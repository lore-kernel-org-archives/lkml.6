Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE42C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3322C2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvls6NGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3322C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754018AbeFSW31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:29:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753622AbeFSW3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:29:23 -0400
Received: from localhost (unknown [146.7.4.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2BD020661;
        Tue, 19 Jun 2018 22:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529447363;
        bh=IWEjH3mLpik6iZt/Cn3+qAeFrcx5VD6bbaCL65P28Vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvls6NGVl1lG/VCoMnG3Tlg1jhlvX/6Y8GrQKF7RnwUJmZpXlLs975vbbwtiAINJX
         yK2OkoE6iIlGKI9ADICOnxZC1JdQSoHQQrm826aVTJHzpgEtj4/seZUpeW3IdzlQhF
         kIT0g8meYZJGOcVgmk+1IInTJhmdK60/k0IANfgQ=
Date:   Tue, 19 Jun 2018 17:29:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     linux-fbdev@vger.kernel.org, timur@codeaurora.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
Message-ID: <20180619222921.GA90490@bhelgaas-glaptop.roam.corp.google.com>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526653072-7153-2-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor subject nit: From the caller's point of view, we must convert a bus
address to a resource *always* (the caller has no knowledge of "whether it
is translated by the host bridge").

On Fri, May 18, 2018 at 10:17:51AM -0400, Sinan Kaya wrote:
> A host bridge is allowed to remap BAR addresses using _TRA attribute in
> _CRS windows.

Also, _TRA/_CRS are ACPI-specific terms and non-ACPI host bridges can
also do the same sort of translation.  Another trivial nit.

> pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
> pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
> 
> When a VGA device is behind such a host bridge and the resource is
> translated efifb driver is trying to do ioremap against bus address
> rather than the resource address and is failing to probe.
> 
> efifb: probing for efifb
> efifb: cannot reserve video memory at 0x1e000000
> efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
> efifb: mode is 800x600x32, linelength=3200, pages=1
> efifb: scrolling: redraw
> efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> 
> Use the host bridge offset information to convert bus address to
> resource address in the fixup.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks a lot for fixing this!

> ---
>  drivers/video/fbdev/efifb.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> index 6daac8d..429cc85 100644
> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -431,6 +431,7 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>  		.end = screen_info.lfb_base + screen_info.lfb_size - 1,
>  		.flags = IORESOURCE_MEM,
>  	};
> +	struct pci_bus_region region;
>  	int i;
>  
>  	if (efifb_pci_dev || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
> @@ -442,6 +443,10 @@ static void efifb_fixup_resources(struct pci_dev *dev)
>  	if (!screen_res.start)
>  		return;
>  
> +	region.start = screen_res.start;
> +	region.end = screen_res.end;
> +	pcibios_bus_to_resource(dev->bus, &screen_res, &region);
> +
>  	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
>  		struct resource *res = &dev->resource[i];
>  
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

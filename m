Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0299C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65922178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZJWm+UE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65922178B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeHHUVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727748AbeHHUVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:21:08 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBAE02178B;
        Wed,  8 Aug 2018 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533751221;
        bh=Wksg3JBMPSQrV6GbShuhwdXUasvykInLpj5HgayMF/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZJWm+UEijUripPhh8rFZzD3NHXCHm8wZ+wn2J+1V8tX1icfhLQXYIUC9CWYoKi8U
         hwQryoB1jywLdJIzaDpYwI4G6Emrkjkw9XX71vjGJbmZ5d9QzRzIsd4WluNkTuIFgQ
         W6R7nqPZXk05J6gahSiIyAFcvOHJTv5Esjz7KmN0=
Date:   Wed, 8 Aug 2018 13:00:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix calculation of bridge window's size
Message-ID: <20180808180019.GE49411@bhelgaas-glaptop.roam.corp.google.com>
References: <20180808054837.19717-1-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808054837.19717-1-acelan.kao@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 01:48:37PM +0800, AceLan Kao wrote:
> There are some 0 resource size pci devices, and it leads to the
> accumulator fails to maintain the correct value.
> It results in a strange issue on my machine that xhci_hcd failed to init.
>    [    2.437278] xhci_hcd 0000:05:00.0: init 0000:05:00.0 fail, -16
>    [    2.437300] xhci_hcd: probe of 0000:05:00.0 failed with error -16

I don't think it's possible for a PCI device to have a BAR of zero
size.  Bits 0-3 of memory BARs are read-only, leading to a minimum BAR
size of 16 bytes; similarly, bits 0-1 of I/O BARs are read-only,
giving a minimum size of 4 ports.

My guess is that if you have a pci_dev with a resource that looks like
it's valid but has zero size, that resource came from OF or device
tree.  If that's the case, I'd say we should fix the OF or DT parsing
code to reject those resources.  If we do that, we shouldn't need the
patch below.

Can you open a bugzilla.kernel.org report and attach the complete
dmesg log leading up to this, as well as the "sudo lspci -vv" output
for this device?  It should have clues about how we got here.

> To fix this, check if the resource size equals to 0, doesn't increase size.
> 
> Fixes: c9c75143a596 ("PCI: Fix calculation of bridge window's size and alignment")
> CC: stable@vger.kernel.org # 4.14+
> 
> Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> ---
>  drivers/pci/setup-bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 79b1824e83b4..ae05dde8c6e3 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1061,7 +1061,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  				r->flags = 0;
>  				continue;
>  			}
> -			size += max(r_size, align);
> +			if (r_size != 0)
> +				size += max(r_size, align);
>  			/* Exclude ranges with size > align from
>  			   calculation of the alignment. */
>  			if (r_size <= align)
> -- 
> 2.17.1
> 

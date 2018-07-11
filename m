Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AA9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C91C20846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCCzl+vY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C91C20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732852AbeGKNP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbeGKNP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:15:58 -0400
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83E3020846;
        Wed, 11 Jul 2018 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531314700;
        bh=pDLuJsqlZXBkmD+/DI1lRwl0mNW/VMAbCv8YTLY0UrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pCCzl+vYpSGLZzTVq1n0+P6Yl8jRg+d+5tQpew2xlAahf8r4Izv/aYavpLaEW0Xlp
         vQH0zEqSQX504668QXIKpDHNsUjdLyg21O4IQXMJcBmmypgZjjXDveTXMwaY1B7Xm+
         8f7bQGRN+NBug8o6xmCU+7JNxMLsUsuADV6hfjms=
Date:   Wed, 11 Jul 2018 08:11:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/5] PCI: iproc: Activate PAXC bridge quirk for more
 devices
Message-ID: <20180711131138.GE188359@bhelgaas-glaptop.roam.corp.google.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
 <1528762867-16823-2-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528762867-16823-2-git-send-email-ray.jui@broadcom.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 05:21:03PM -0700, Ray Jui wrote:
> Activate PAXC bridge quirk for more PAXC based PCIe root complex with
> the following PCIe device ID:
> 0xd750, 0xd802, 0xd804
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>

Because this quirk_paxc_bridge() mechanism is already established,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

BUT, I would push back on quirk_paxc_bridge() if it were new code.

I think it would be much better to implement this in the driver's
config accessors so lspci would show the correct things and the
generic code that deals with pcie_mpss would work unmodified.

> ---
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 2990ad1..47dfea0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2195,6 +2195,9 @@ static void quirk_paxc_bridge(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16cd, quirk_paxc_bridge);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0x16f0, quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd750, quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd802, quirk_paxc_bridge);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_BROADCOM, 0xd804, quirk_paxc_bridge);
>  #endif
>  
>  /* Originally in EDAC sources for i82875P:
> -- 
> 2.1.4
> 

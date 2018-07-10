Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1103CC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 17:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EE3208F7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 17:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPi7a9/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EE3208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933349AbeGJRJH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 13:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933267AbeGJRJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 13:09:04 -0400
Received: from localhost (unknown [207.160.231.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3F14208E8;
        Tue, 10 Jul 2018 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531242544;
        bh=wF6YIkybJ5srKLX2E+ZESowBGJN0YRq2Jn+hvbt/lKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPi7a9/oOTPRqyAeKxxPW2C0xQAO/IZajDnSVojIUu0PI8KDlzukJVkZb1kZO1Ult
         od+Dw2DuQvHin0KvyMQK/Lv26CTINz25R8MaWEqhIrpK1BVq5ZpGn9s5zzmteMvjDD
         cTE5yiwT+oNJB6doS5DsQ2OHJMRelF0e8Ej8dJr8=
Date:   Tue, 10 Jul 2018 12:09:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Mark expected switch fall-throughs
Message-ID: <20180710170902.GC188359@bhelgaas-glaptop.roam.corp.google.com>
References: <20180705145600.GA22099@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705145600.GA22099@embeddedor.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 09:56:00AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Warning level 2 was used: -Wimplicit-fallthrough=2
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to pci/misc for v4.19, thanks!

If you'd like to apply this elsewhere as part of a larger series, feel
free to do that.  Just add my ack and let me know to drop it.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 2 ++
>  drivers/pci/hotplug/shpchp_ctrl.c | 2 ++
>  drivers/pci/pci.c                 | 1 +
>  drivers/pci/quirks.c              | 1 +
>  4 files changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index c684faa..cfc46e8 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -436,6 +436,7 @@ int pciehp_sysfs_enable_slot(struct slot *p_slot)
>  	switch (p_slot->state) {
>  	case BLINKINGON_STATE:
>  		cancel_delayed_work(&p_slot->work);
> +		/* fall through */
>  	case STATIC_STATE:
>  		p_slot->state = POWERON_STATE;
>  		mutex_unlock(&p_slot->lock);
> @@ -473,6 +474,7 @@ int pciehp_sysfs_disable_slot(struct slot *p_slot)
>  	switch (p_slot->state) {
>  	case BLINKINGOFF_STATE:
>  		cancel_delayed_work(&p_slot->work);
> +		/* fall through */
>  	case STATIC_STATE:
>  		p_slot->state = POWEROFF_STATE;
>  		mutex_unlock(&p_slot->lock);
> diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
> index 1047b56..1267dcc 100644
> --- a/drivers/pci/hotplug/shpchp_ctrl.c
> +++ b/drivers/pci/hotplug/shpchp_ctrl.c
> @@ -654,6 +654,7 @@ int shpchp_sysfs_enable_slot(struct slot *p_slot)
>  	switch (p_slot->state) {
>  	case BLINKINGON_STATE:
>  		cancel_delayed_work(&p_slot->work);
> +		/* fall through */
>  	case STATIC_STATE:
>  		p_slot->state = POWERON_STATE;
>  		mutex_unlock(&p_slot->lock);
> @@ -689,6 +690,7 @@ int shpchp_sysfs_disable_slot(struct slot *p_slot)
>  	switch (p_slot->state) {
>  	case BLINKINGOFF_STATE:
>  		cancel_delayed_work(&p_slot->work);
> +		/* fall through */
>  	case STATIC_STATE:
>  		p_slot->state = POWEROFF_STATE;
>  		mutex_unlock(&p_slot->lock);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 97acba7..f5c6ab1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2045,6 +2045,7 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>  		case PCI_D2:
>  			if (pci_no_d1d2(dev))
>  				break;
> +			/* else: fall through */
>  		default:
>  			target_state = state;
>  		}
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f439de8..502275c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2105,6 +2105,7 @@ static void quirk_netmos(struct pci_dev *dev)
>  		if (dev->subsystem_vendor == PCI_VENDOR_ID_IBM &&
>  				dev->subsystem_device == 0x0299)
>  			return;
> +		/* else: fall through */
>  	case PCI_DEVICE_ID_NETMOS_9735:
>  	case PCI_DEVICE_ID_NETMOS_9745:
>  	case PCI_DEVICE_ID_NETMOS_9845:
> -- 
> 2.7.4
> 

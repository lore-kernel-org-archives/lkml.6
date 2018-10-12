Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1047C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABEC2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXk/cvQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABEC2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeJLOHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 10:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbeJLOHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 10:07:20 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B00252098A;
        Fri, 12 Oct 2018 06:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539326183;
        bh=75Fm92VDvQ2i2AjPJp4Rwk/gX8rfJcm8A0TkFOxVrCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXk/cvQZBaTUyuJheeQCs1ELwy4+y2tMqWAIvHVkGJZn0fELMlcKSFFWwFjeCX69Z
         LDNEbPqQ2JkvswKtyNmYFAqvmLXU1H4zQcFs07qSN2Ry9kNkwB5sZ0h/hF5Vs4w0hj
         RS9EiFLNBAXLxvEl78Zmwf1Nr7NkhNCY1rDOZnVk=
Date:   Fri, 12 Oct 2018 08:36:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     haiyangz@microsoft.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org, olaf@aepfle.de,
        sthemmin@microsoft.com, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, vkuznets@redhat.com
Subject: Re: [PATCH net-next] hv_netvsc: fix vf serial matching with pci slot
 info
Message-ID: <20181012063620.GA20393@kroah.com>
References: <20181011201434.30737-1-haiyangz@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011201434.30737-1-haiyangz@linuxonhyperv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 08:14:34PM +0000, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> The VF device's serial number is saved as a string in PCI slot's
> kobj name, not the slot->number. This patch corrects the netvsc
> driver, so the VF device can be successfully paired with synthetic
> NIC.
> 
> Fixes: 00d7ddba1143 ("hv_netvsc: pair VF based on serial number")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 9bcaf204a7d4..8121ce34a39f 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2030,14 +2030,15 @@ static void netvsc_vf_setup(struct work_struct *w)
>  	rtnl_unlock();
>  }
>  
> -/* Find netvsc by VMBus serial number.
> - * The PCI hyperv controller records the serial number as the slot.
> +/* Find netvsc by VF serial number.
> + * The PCI hyperv controller records the serial number as the slot kobj name.
>   */
>  static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
>  {
>  	struct device *parent = vf_netdev->dev.parent;
>  	struct net_device_context *ndev_ctx;
>  	struct pci_dev *pdev;
> +	u32 serial;
>  
>  	if (!parent || !dev_is_pci(parent))
>  		return NULL; /* not a PCI device */
> @@ -2048,16 +2049,22 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
>  		return NULL;
>  	}
>  
> +	if (kstrtou32(pdev->slot->kobj.name, 10, &serial)) {

kobject_name()?

And that feels _very_ fragile to me.  This is now an api that you are
guaranteeing will never change?

Good luck with that!

greg k-h

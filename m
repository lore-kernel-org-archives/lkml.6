Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FD2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190C220664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zXXu1vWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190C220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504791AbeKXBwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:52:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732166AbeKXBwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:52:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6033420664;
        Fri, 23 Nov 2018 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542985686;
        bh=iKNqLfNSA6Ks7kL/mwtuh2yBM781HKA0I7MxyXT/YgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zXXu1vWXioYdMKpVcXlLjl7vX9bB2fiP+24y/jBA3jT+j9opduI8LsJlVT4ysEEVW
         YPLlFoQjadZbU+j3HcRRrg5/8u5cFhfaW6ljkbafjetZ2vHtsLkGjYPJWqxrH9Dxyd
         WJveGENSbfRV+Stf4RTHP64OyZiE5vaUyKLOWiNk=
Date:   Fri, 23 Nov 2018 16:08:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: Don't enable LPM if it's already enabled
Message-ID: <20181123150804.GB17386@kroah.com>
References: <20181031055209.11031-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031055209.11031-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 01:52:09PM +0800, Kai-Heng Feng wrote:
> USB Bluetooth controller QCA ROME (0cf3:e007) sometimes stops working
> after S3:
> [ 165.110742] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [ 168.432065] Bluetooth: hci0: Failed to send body at 4 of 1953 (-110)
> 
> After some experiments, I found that disabling LPM can workaround the
> issue.
> 
> On some platforms, the USB power is cut during S3, so the driver uses
> reset-resume to resume the device. During port resume, LPM gets enabled
> twice, by usb_reset_and_verify_device() and usb_port_resume().
> 
> So let's enable LPM for just once, as this solves the issue for the
> device in question.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  -  Check udev->usb2_hw_lpm_enabled before calling usb_port_resume().
> 
>  drivers/usb/core/hub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index c6077d582d29..02fa574e98ce 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3523,7 +3523,8 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>  		hub_port_logical_disconnect(hub, port1);
>  	} else  {
>  		/* Try to enable USB2 hardware LPM */
> -		if (udev->usb2_hw_lpm_capable == 1)
> +		if (udev->usb2_hw_lpm_capable == 1 &&
> +		    !udev->usb2_hw_lpm_enabled)
>  			usb_set_usb2_hardware_lpm(udev, 1);

It's annoying how every caller has to try to figure this out, why can't
we put this logic in the usb_set_usb2_hardware_lpm() itself?

And usb_set_usb2_hardware_lpm() is a horrid name, as it has a bool
option that you always have to look up.  We should just have
usb_usb2_hardware_lpm_enable() and usb_usb2_hardware_lpm_disable().

Care to make this a patch series to fix all of this up?

thanks,

greg k-h

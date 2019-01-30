Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A65C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61F721473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548836499;
	bh=V5kTva0AhhdC9svKRu+stdKYb1ceZEqFS3eg6CRKLEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=on/CFgaKr4bUt6rMqq0AstBJF565nA0i/f4vCCeXDGFLZN+XruguQJXIcZObv4KBM
	 43M9diEiLjRgFZI5N8jKbmrGdZm5PJIj0SmVoVNk8rNytfwUku0PvrAyRoaXhseWzq
	 bKStsqVBh0sTz/30izisr3OqBgOgAEawRco7nvXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfA3IVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:21:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfA3IVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:21:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C1DD2087F;
        Wed, 30 Jan 2019 08:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548836496;
        bh=V5kTva0AhhdC9svKRu+stdKYb1ceZEqFS3eg6CRKLEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YcZasmwbwBTg8WI9QH2n8tRsZqSE+Z2/yBuKXZ0UQGP6PvyHlD0Re8t3vhRg15MYd
         Lssde145DvSdLEbEoDQ05j7/oE91qmUNbMOXvTJNbKYjMGSxZhN+Py+1YWYzeOf0pW
         oun9NSUY2T2hXFvwjuxSzwjzv7T4ho+55Me1vjr8=
Date:   Wed, 30 Jan 2019 09:21:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: Disable USB2 LPM at shutdown
Message-ID: <20190130082133.GA32660@kroah.com>
References: <20190124061643.11663-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124061643.11663-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 02:16:43PM +0800, Kai-Heng Feng wrote:
> The QCA Rome USB Bluetooth controller has several issues once LPM gets
> enabled:
> - Fails to get enumerated in coldboot. [1]
> - Drains more power (~ 0.2W) when the system is in S5. [2]
> - Disappears after a warmboot. [2]
> 
> The issue happens because the device lingers at LPM L1 in S5, so device
> can't get enumerated even after a reboot.
> 
> Disable LPM at shutdown to solve the issue.
> 
> [1] https://bugs.launchpad.net/bugs/1757218
> [2] https://patchwork.kernel.org/patch/10607097/
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2: Use new LPM helpers.
> 
>  drivers/usb/core/port.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index 1a06a4b5fbb1..bbbb35fa639f 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -285,6 +285,14 @@ static int usb_port_runtime_suspend(struct device *dev)
>  }
>  #endif
>  
> +static void usb_port_shutdown(struct device *dev)
> +{
> +	struct usb_port *port_dev = to_usb_port(dev);
> +
> +	if (port_dev->child)
> +		usb_disable_usb2_hardware_lpm(port_dev->child);
> +}
> +
>  static const struct dev_pm_ops usb_port_pm_ops = {
>  #ifdef CONFIG_PM
>  	.runtime_suspend =	usb_port_runtime_suspend,
> @@ -301,6 +309,7 @@ struct device_type usb_port_device_type = {
>  static struct device_driver usb_port_driver = {
>  	.name = "usb",
>  	.owner = THIS_MODULE,
> +	.shutdown = usb_port_shutdown,
>  };

So you now do this for all ports in the system, no matter what is
plugged in or not.  Are you _SURE_ you want to do that?  It seems like a
big hammer to solve just one single device's problems.

thanks,

greg k-h

Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5249DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1621720664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2SmlHmMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1621720664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504762AbeKXBuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:50:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:49428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732166AbeKXBuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:50:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E6B720664;
        Fri, 23 Nov 2018 15:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542985580;
        bh=zitKCSIgqUUlUQVqyCr7cAvRmkEfUlNMzXgbzOGXjXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2SmlHmMwfFlErlvr7IIYqpUx4GamruCXjdSt6r8+bSZTZJ6n5vA/XhEJ9vOPNwo3Y
         rcLX8BEICW07oeKp8xMjbRxwPDXZC1MHP4AsuAu/db7lad5cxUUjLuOh6CaJsaX0uI
         KadmFhthlRq3/rvb7YkdyYbX1Rv95nV5A/LFkzRM=
Date:   Fri, 23 Nov 2018 16:06:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: Disable USB2 LPM at shutdown
Message-ID: <20181123150618.GA17386@kroah.com>
References: <20181106173401.32001-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106173401.32001-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 01:34:01AM +0800, Kai-Heng Feng wrote:
> The QCA Rome USB Bluetooth controller has several issues once LPM gets
> enabled:
> - Fails to get enumerated in coldboot. [1]
> - Drains more power (~ 0.2W) when the system is in S5. [2]
> - Disappears after a warmboot. [2]
> 
> The issue happens because the device lingers at LPM L1 in S5, so device
> can't get enumerated even after a reboot.
> 
> Disalbe LPM at shutdown can solve the issue.
> 
> [1] https://bugs.launchpad.net/bugs/1757218
> [2] https://patchwork.kernel.org/patch/10607097/
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/usb/core/port.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index 1a06a4b5fbb1..15f6924a4d84 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -285,6 +285,15 @@ static int usb_port_runtime_suspend(struct device *dev)
>  }
>  #endif
>  
> +static void usb_port_shutdown(struct device *dev)
> +{
> +	struct usb_port *port_dev = to_usb_port(dev);
> +
> +	if (port_dev->child)
> +		usb_set_usb2_hardware_lpm(port_dev->child, 0);

Shouldn't you also test if child->usb2_hw_lpm_enabled before calling
this?

Or at the least usb2_hw_lpm_capable?

You did test this on a bunch of USB 1 and USB 3 devices, right?

thanks,

greg k-h

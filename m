Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE51C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59C62173A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59C62173A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbeHNQpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:45:42 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:39646 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1732667AbeHNQpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:45:42 -0400
Received: (qmail 1616 invoked by uid 2102); 14 Aug 2018 09:58:25 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Aug 2018 09:58:25 -0400
Date:   Tue, 14 Aug 2018 09:58:25 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Johan Hovold <johan@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: hide usb_of_get_companion_dev for CONFIG_USB=n
In-Reply-To: <20180813214924.3567840-1-arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1808140957350.1466-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018, Arnd Bergmann wrote:

> The renesas UDC implementation now calls usb_of_get_companion_dev(),
> which is only defined when CONFIG_USB is enabled:
> 
> drivers/usb/gadget/udc/renesas_usb3.o: In function `renesas_usb3_probe':
> renesas_usb3.c:(.text+0xa34): undefined reference to `usb_of_get_companion_dev'
> 
> To avoid the build error, we need two changes:
> 
> - usb_of_get_companion_dev must be stubbed out when CONFIG_USB is
>   disabled, so it the udc driver can be built for a gadget-only
>   mode kernel
> - With CONFIG_USB=m, we must not attempt to have USB_RENESAS_USB3
>   built-in, so we need a soft dependency on USB.
> 
> Fixes: 39facfa01c9f ("usb: gadget: udc: renesas_usb3: Add register of usb role switch")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/gadget/udc/Kconfig | 1 +
>  include/linux/usb/of.h         | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
> index 0a16cbd4e528..663a8bd67a7b 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -193,6 +193,7 @@ config USB_RENESAS_USB3
>  	tristate 'Renesas USB3.0 Peripheral controller'
>  	depends on ARCH_RENESAS || COMPILE_TEST
>  	depends on EXTCON
> +	depends on USB || !USB

Is this some weird standard idiom?  It looks really strange.

Alan Stern


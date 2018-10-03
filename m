Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C65C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C96A2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C96A2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJCUpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:45:38 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48678 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726769AbeJCUpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:45:38 -0400
Received: (qmail 1563 invoked by uid 2102); 3 Oct 2018 09:57:06 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Oct 2018 09:57:06 -0400
Date:   Wed, 3 Oct 2018 09:57:06 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     gregkh@linuxfoundation.org, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: core: Check portchange C_PORT_RESET after resetting
In-Reply-To: <20181003051822.4011-1-kai.heng.feng@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1810030956270.1413-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018, Kai-Heng Feng wrote:

> Based on USB2.0 Spec Section 11.24.2.7.2.5:
> 
>   "This bit is set when the port transitions from the Resetting state (or,
>   if present, the Speed_eval state) to the Enabled state."
> 
> Also Section 11.24.2.13:
> 
>   "Setting the reset feature PORT_RESET causes the hub to signal reset on
>   that port. When the reset signaling is complete, the hub sets the
>   C_PORT_RESET status change and immediately enables the port."
> 
> So let's also check C_PORT_RESET for reset completion.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/usb/core/hub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 7801bb30bdba..d96058372280 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -2721,7 +2721,8 @@ static int hub_port_wait_reset(struct usb_hub *hub, int port1,
>  		 * so also wait for the connection to be re-established.
>  		 */
>  		if (!(portstatus & USB_PORT_STAT_RESET) &&
> -		    (portstatus & USB_PORT_STAT_CONNECTION))
> +		    (portstatus & USB_PORT_STAT_CONNECTION) &&
> +		    (portchange & USB_PORT_STAT_C_RESET))
>  			break;
>  
>  		/* switch to the long delay after two short delay failures */

What is the purpose of this patch?  Does it fix a problem?

Alan Stern


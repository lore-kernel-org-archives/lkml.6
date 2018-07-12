Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFD4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0DF20843
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0DF20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbeGLPJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:09:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50676 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732373AbeGLPJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:09:17 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D365BD4F;
        Thu, 12 Jul 2018 14:59:20 +0000 (UTC)
Date:   Thu, 12 Jul 2018 16:59:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-serial@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jslaby@suse.com,
        arnd@arndb.de, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tty/serial: atmel: manage shutdown in case of RS485
 or ISO7816 mode
Message-ID: <20180712145918.GC22502@kroah.com>
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
 <20180711131638.12622-4-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711131638.12622-4-ludovic.desroches@microchip.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 03:16:38PM +0200, Ludovic Desroches wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> In atmel_shutdown() we call atmel_stop_rx() and atmel_stop_tx() functions.
> Prevent the rx restart that is implemented in RS485 or ISO7816 modes when
> calling atmel_stop_tx() by using the atomic information tasklet_shutdown
> that is already in place for this purpose.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

No signed-off-by from you?

> ---
>  drivers/tty/serial/atmel_serial.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 0118b219f3a8..e4f877e1f3c6 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -617,7 +617,9 @@ static void atmel_stop_tx(struct uart_port *port)
>  	if (((port->rs485.flags & SER_RS485_ENABLED) &&
>  	     !(port->rs485.flags & SER_RS485_RX_DURING_TX)) ||
>  	    port->iso7816.flags & SER_ISO7816_ENABLED)
> -		atmel_start_rx(port);
> +		if (!atomic_read(&atmel_port->tasklet_shutdown))
> +			atmel_start_rx(port);

Is this really ok?  No locking needed?  What happens if that value is
set right after this?

thanks,

greg k-h

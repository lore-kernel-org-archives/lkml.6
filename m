Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584C0C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D67213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D67213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732634AbeGLPIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:08:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732362AbeGLPIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:08:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D751BD4F;
        Thu, 12 Jul 2018 14:58:10 +0000 (UTC)
Date:   Thu, 12 Jul 2018 16:58:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-serial@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jslaby@suse.com,
        arnd@arndb.de, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] tty/serial_core: add ISO7816 infrastructure
Message-ID: <20180712145808.GA22502@kroah.com>
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
 <20180711131638.12622-2-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711131638.12622-2-ludovic.desroches@microchip.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 03:16:36PM +0200, Ludovic Desroches wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Add the ISO7816 ioctl and associated accessors and data structure.
> Drivers can then use this common implementation to handle ISO7816.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> [ludovic.desroches@microchip.com: squash and rebase, removal of gpios, checkpatch fixes]
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>  drivers/tty/serial/serial_core.c  | 49 +++++++++++++++++++++++++++++++++++++++
>  include/linux/serial_core.h       |  3 +++
>  include/uapi/asm-generic/ioctls.h |  2 ++
>  include/uapi/linux/serial.h       | 17 ++++++++++++++
>  4 files changed, 71 insertions(+)

Note, kbuild found build issues with this, please fix up.

Also, here's some comments:

> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 9c14a453f73c..c89ac59f6f8c 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1301,6 +1301,47 @@ static int uart_set_rs485_config(struct uart_port *port,
>  	return 0;
>  }
>  
> +static int uart_get_iso7816_config(struct uart_port *port,
> +				   struct serial_iso7816 __user *iso7816)
> +{
> +	unsigned long flags;
> +	struct serial_iso7816 aux;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	aux = port->iso7816;

Don't you want to check to see if there is a function for iso7816 before
copying it?  Otherwise it's just empty, right?

> +	if (!port->iso7816_config)
> +		return -ENOIOCTLCMD;

Why this error value?

> --- a/include/uapi/asm-generic/ioctls.h
> +++ b/include/uapi/asm-generic/ioctls.h
> @@ -66,6 +66,8 @@
>  #ifndef TIOCSRS485
>  #define TIOCSRS485	0x542F
>  #endif
> +#define TIOCGISO7816	0x5430
> +#define TIOCSISO7816	0x5431

Where did you get these numbers from?

thanks,

greg k-h

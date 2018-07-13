Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9DFECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFFD2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFFD2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbeGMIQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:16:11 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:49770 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbeGMIQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:16:11 -0400
X-IronPort-AV: E=Sophos;i="5.51,347,1526367600"; 
   d="scan'208";a="14112885"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Jul 2018 01:02:41 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.352.0; Fri, 13 Jul 2018
 01:02:39 -0700
Date:   Fri, 13 Jul 2018 10:01:29 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jslaby@suse.com>,
        <arnd@arndb.de>, <richard.genoud@gmail.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] tty/serial_core: add ISO7816 infrastructure
Message-ID: <20180713080129.2ifw7crjksvaxxpq@M43218.corp.atmel.com>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jslaby@suse.com,
        arnd@arndb.de, richard.genoud@gmail.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
 <20180711131638.12622-2-ludovic.desroches@microchip.com>
 <20180712145808.GA22502@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180712145808.GA22502@kroah.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 04:58:08PM +0200, Greg KH wrote:
> On Wed, Jul 11, 2018 at 03:16:36PM +0200, Ludovic Desroches wrote:
> > From: Nicolas Ferre <nicolas.ferre@microchip.com>
> > 
> > Add the ISO7816 ioctl and associated accessors and data structure.
> > Drivers can then use this common implementation to handle ISO7816.
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > [ludovic.desroches@microchip.com: squash and rebase, removal of gpios, checkpatch fixes]
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> > ---
> >  drivers/tty/serial/serial_core.c  | 49 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/serial_core.h       |  3 +++
> >  include/uapi/asm-generic/ioctls.h |  2 ++
> >  include/uapi/linux/serial.h       | 17 ++++++++++++++
> >  4 files changed, 71 insertions(+)
> 
> Note, kbuild found build issues with this, please fix up.
> 
> Also, here's some comments:
> 
> > 
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > index 9c14a453f73c..c89ac59f6f8c 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -1301,6 +1301,47 @@ static int uart_set_rs485_config(struct uart_port *port,
> >  	return 0;
> >  }
> >  
> > +static int uart_get_iso7816_config(struct uart_port *port,
> > +				   struct serial_iso7816 __user *iso7816)
> > +{
> > +	unsigned long flags;
> > +	struct serial_iso7816 aux;
> > +
> > +	spin_lock_irqsave(&port->lock, flags);
> > +	aux = port->iso7816;
> 
> Don't you want to check to see if there is a function for iso7816 before
> copying it?  Otherwise it's just empty, right?

I'll add the check.

> 
> > +	if (!port->iso7816_config)
> > +		return -ENOIOCTLCMD;
> 
> Why this error value?
> 

It was a mimic of RS485.

> > --- a/include/uapi/asm-generic/ioctls.h
> > +++ b/include/uapi/asm-generic/ioctls.h
> > @@ -66,6 +66,8 @@
> >  #ifndef TIOCSRS485
> >  #define TIOCSRS485	0x542F
> >  #endif
> > +#define TIOCGISO7816	0x5430
> > +#define TIOCSISO7816	0x5431
> 
> Where did you get these numbers from?

I will use the macros to create numbers. Any rules about nr choice?

Regards

Ludovic

> 
> thanks,
> 
> greg k-h

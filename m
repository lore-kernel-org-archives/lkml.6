Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF36C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBCB23D47
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 23:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBCB23D47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752905AbeF0Xsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 19:48:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbeF0Xsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 19:48:40 -0400
Received: from localhost (113x41x139x141.ap113.ftth.ucom.ne.jp [113.41.139.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 62164BC6;
        Wed, 27 Jun 2018 23:48:39 +0000 (UTC)
Date:   Thu, 28 Jun 2018 07:48:36 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org,
        gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>,
        shubhraj@xilinx.com, robh@kernel.org, Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 1/6] serial: uartps: Do not initialize field to
 zero again
Message-ID: <20180627234836.GA1691@kroah.com>
References: <cover.1528288895.git.michal.simek@xilinx.com>
 <e8b0169887855a5ef2c1a0456842f650601b451c.1528288895.git.michal.simek@xilinx.com>
 <e7b01bd9-5763-75c0-1384-2536313f5854@monstr.eu>
 <20180627100917.GA20940@kroah.com>
 <05e553c2-202b-0b4b-8b88-60e330c80fa3@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05e553c2-202b-0b4b-8b88-60e330c80fa3@xilinx.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 04:19:46PM +0200, Michal Simek wrote:
> On 27.6.2018 12:09, Greg Kroah-Hartman wrote:
> > On Tue, Jun 19, 2018 at 10:09:05AM +0200, Michal Simek wrote:
> >> On 6.6.2018 14:41, Michal Simek wrote:
> >>> Writing zero and NULLs to already initialized fields is not needed.
> >>> Remove this additional writes.
> >>>
> >>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >>> ---
> >>>
> >>> Changes in v2:
> >>> - new patch - it can be sent separately too
> >>>
> >>>  drivers/tty/serial/xilinx_uartps.c | 3 ---
> >>>  1 file changed, 3 deletions(-)
> >>>
> >>> diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
> >>> index 8a3e34234e98..5f116f3ecd4a 100644
> >>> --- a/drivers/tty/serial/xilinx_uartps.c
> >>> +++ b/drivers/tty/serial/xilinx_uartps.c
> >>> @@ -1510,15 +1510,12 @@ static int cdns_uart_probe(struct platform_device *pdev)
> >>>  
> >>>  	/* At this point, we've got an empty uart_port struct, initialize it */
> >>>  	spin_lock_init(&port->lock);
> >>> -	port->membase	= NULL;
> >>> -	port->irq	= 0;
> >>>  	port->type	= PORT_UNKNOWN;
> >>>  	port->iotype	= UPIO_MEM32;
> >>>  	port->flags	= UPF_BOOT_AUTOCONF;
> >>>  	port->ops	= &cdns_uart_ops;
> >>>  	port->fifosize	= CDNS_UART_FIFO_SIZE;
> >>>  	port->line	= id;
> >>> -	port->dev	= NULL;
> >>>  
> >>>  	/*
> >>>  	 * Register the port.
> >>>
> >>
> >> Alan, Rob, Greg: Any comment about this RFC?
> > 
> > I rarely review RFC patchesets as obviously you don't think it is good
> > enough to be submitted "for real" :)
> 
> There is one missing minor part but I want to review concept first
> because I didn't find any driver which is using this style.
> 
> > If you think this is all good, great, please resend it without the RFC
> > and it will end up in my queue.
> 
> I will definitely do it but please look at the concept itself because I
> would like to use this with at least 3 other drivers.

I don't have the time right now to review "concepts", sorry.

greg k-h

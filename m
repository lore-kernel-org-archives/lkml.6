Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752933AbeEPM6R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:58:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:63320 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752704AbeEPM6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:58:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="54851793"
Message-ID: <171c11a999e2d9580d3783588d20b58e753c89ef.camel@linux.intel.com>
Subject: Re: [PATCH v1 3/3] serial: 8250_port: Disable DMA operations for
 kernel console
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 May 2018 15:58:10 +0300
In-Reply-To: <20180516105553.h7e2buanqfxxya4e@linutronix.de>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
         <20180515183409.78046-4-andriy.shevchenko@linux.intel.com>
         <20180516105553.h7e2buanqfxxya4e@linutronix.de>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-16 at 12:55 +0200, Sebastian Andrzej Siewior wrote:
> On 2018-05-15 21:34:09 [+0300], Andy Shevchenko wrote:

Thanks for review, my answers below.

> > It will be too tricky and error prone to allow DMA operations on
> > kernel
> > console.
> 
> Why is it tricky and error prone? I had it working…

On OMAP only? Had you tested this on let's say Intel Cherrytrail where
DMA controller is a separate PCI device which needs to be handled
separately from UART IP.

> But I don't mind dropping the DMA on the kernel console because I
> doubt
> that we lose something here by disabling it. I would even imagine that
> it gets "simpler" (maybe what you tried to say by "error prone") to
> print something in the NMI case by writing directly to the FIFO
> register
> instead setting up a DMA transfer and so on.

"error prone" mostly refers to patch 2 commit message. Here it seems I
need to put something like above to explain why DMA case tricky _as
well_.

> > Disable any kind of DMA operations in such case.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_port.c
> > b/drivers/tty/serial/8250/8250_port.c
> > index db97222a1bf4..9a4696ea728b 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -2371,7 +2371,10 @@ int serial8250_do_startup(struct uart_port
> > *port)
> >  	 * Request DMA channels for both RX and TX.
> >  	 */
> >  	if (up->dma) {
> > -		retval = serial8250_request_dma(up);
> > +		if (uart_console(port))
> > +			retval = -ENXIO;
> > +		else
> > +			retval = serial8250_request_dma(up);
> >  		if (retval)
> >  			pr_warn_ratelimited("ttyS%d - failed to
> > request DMA\n",
> >  					    serial_index(port));
> 
> I would appreciate if you note that it is disabled on purpose and not
> because something failed.
> Other than those minor things I an board :)

Got it for v2.

> 
> > -- 
> > 2.17.0
> 
> Sebastian

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

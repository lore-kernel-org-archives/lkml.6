Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752489AbeEPKz7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:55:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38507 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbeEPKz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:55:58 -0400
Date: Wed, 16 May 2018 12:55:53 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 3/3] serial: 8250_port: Disable DMA operations for
 kernel console
Message-ID: <20180516105553.h7e2buanqfxxya4e@linutronix.de>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
 <20180515183409.78046-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180515183409.78046-4-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-15 21:34:09 [+0300], Andy Shevchenko wrote:
> It will be too tricky and error prone to allow DMA operations on kernel
> console.

Why is it tricky and error prone? I had it working…
But I don't mind dropping the DMA on the kernel console because I doubt
that we lose something here by disabling it. I would even imagine that
it gets "simpler" (maybe what you tried to say by "error prone") to
print something in the NMI case by writing directly to the FIFO register
instead setting up a DMA transfer and so on.

> Disable any kind of DMA operations in such case.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index db97222a1bf4..9a4696ea728b 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2371,7 +2371,10 @@ int serial8250_do_startup(struct uart_port *port)
>  	 * Request DMA channels for both RX and TX.
>  	 */
>  	if (up->dma) {
> -		retval = serial8250_request_dma(up);
> +		if (uart_console(port))
> +			retval = -ENXIO;
> +		else
> +			retval = serial8250_request_dma(up);
>  		if (retval)
>  			pr_warn_ratelimited("ttyS%d - failed to request DMA\n",
>  					    serial_index(port));

I would appreciate if you note that it is disabled on purpose and not
because something failed.
Other than those minor things I an board :)

> -- 
> 2.17.0

Sebastian

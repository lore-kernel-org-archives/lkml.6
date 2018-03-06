Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeCFDSw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:18:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752756AbeCFDSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:18:51 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B476821486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 5 Mar 2018 22:18:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: "Qixuan.Wu" <qixuan.wu@linux.alibaba.com>,
        linux-kernel-owner <linux-kernel-owner@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>, Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "chenggang.qin" <chenggang.qin@linux.alibaba.com>,
        caijingxian <caijingxian@linux.alibaba.com>,
        "yuanliang.wyl" <yuanliang.wyl@alibaba-inc.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: Would you help to tell why async printk solution was not taken
 to upstream kernel ?
Message-ID: <20180305221848.6b8bd682@gandalf.local.home>
In-Reply-To: <20180306024358.GC6713@jagdpanzerIV>
References: <1eb584e2-a479-46dd-8a25-820da7a34e85.qixuan.wu@linux.alibaba.com>
        <20180304130151.GA483@tigerII.localdomain>
        <af2c3824-c122-4496-a876-9b03af60c429.qixuan.wu@linux.alibaba.com>
        <20180304104324.6bbbaa53@gandalf.local.home>
        <20180305021416.GA6202@jagdpanzerIV>
        <20180305155802.5c0f73fc@gandalf.local.home>
        <20180306015222.GA6713@jagdpanzerIV>
        <20180306024358.GC6713@jagdpanzerIV>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2018 11:43:58 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> One more thing
> 
> On (03/06/18 10:52), Sergey Senozhatsky wrote:
> [..]
> > > If you know the baud rate, logbuf size * console throughput is actually
> > > trivial to calculate.  
> 
> It's trivial when your setup is trivial. In a less trivial case if you
> set watchdog threshold based on "logbuf size * console throughput" then
> things are still too bad.
> 
> So this is what a typical printk over serial console looks like
> 
> printk()
>  console_unlock()
>   for (;;) {
>    local_irq_save()
>     call_console_drivers()
>      foo_console_write()
>       spin_lock_irqsave(&port->lock, flags);
>       uart_console_write(port, s, count, foo_console_putchar);
>       spin_unlock_irqrestore(&port->lock, flags);
>    local_irq_restore()
>   }
> 
> Notice that call_console_drivers->foo_console_write spins on
> port->lock every time it wants to print out a logbuf line.
> Why does it do this?
> 
> In short, because of printf(). Yes, printk() may depend on printf().
> 
> printf()
>  n_tty_write()
>   uart_write()
>    uart_port_lock(state, flags)                  // spin_lock_irqsave(&uport->lock, flags)
>     memcpy(circ->buf + circ->head, buf, c);
>    uart_port_unlock(port, flags)                 // spin_unlock_irqrestore(&port->lock, flags);
> 
> Now, printf() messages stored in uart circ buffer must be printed
> to the console. And this is where console's IRQ handler jumps in.
> 
> A typical IRQ handler does something like this
> 
> static irqreturn_t foo_console_irq_handler(...)
> {
> 	spin_lock(&port->lock);
> 	rx_chars(port, status);
> 	tx_chars(port, status);
> 	spin_unlock(&port->lock);
> }
> 
> Where tx_chars() usually does something like this
> 
> 	while (...) {
> 		write_char(port, xmit->buf[xmit->tail]);
> 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> 		if (uart_circ_empty(xmit))
> 			break;
> 	}
> 
> Some drivers flush all pending chars, some drivers limit the number
> of TX chars to some number, e.g. 512.
> 
> But in any case, printk() -> call_console_drivers() -> foo_console_write()
> must spin on port->lock as long as foo_console_irq_handler() has chars to
> TX / RX.
> 
> Thus, if you have O(logbuf) of kernel messages, and O(circ->buf) of user
> space messages, then printk() will spend O(logbuf) + O(circ->buf) + O(RX).
> 
> So the watchdog threshold value based purely on O(logbuf) (printing to
> _all_ of the consoles) will not always work.
> 

If you have a complex setup happening like above, you most likely have
printks happening on multiple CPUs which means the work load will be
spread out across those CPUs.

-- Steve

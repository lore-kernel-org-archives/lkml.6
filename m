Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCD1C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8521F20672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FxxMJmpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8521F20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbeLMJSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:18:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45302 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbeLMJR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4SuYwpGKGN9YTOF8aelt1/2OLh6iYUzmCHZqX7WFM9o=; b=FxxMJmpJFfs9aGudz1GOwB/Kg
        kFCzz53hRQQX9PZQRxKYWCW9SbEsASnFdfnXOO6DOnq30K26RhuCqFZHhOSxhUXkm8A+M9CbtbE4C
        ZuJEi2qyOYOsne4D5Ut8ovZ4QmoayAKP3bGgL6I4F/GoVF4eFTWJv/S75vl8nxgbMWmdfUeEsT9qZ
        S8BJ0NWjRIhvVBBnjtImA2G7T1xUd56uhWgUf9dh/pNr4pqbpd3FpNx7m2Ct0IQUUPHYfsfnI72fw
        sSaNFBZmmFN0LF4pZzv+TuW961jpqrYxwHCR0MXegp5NQxZcrU46k3xmFKwQJldsQ0oLRPR32GD8W
        2gpxhJfmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXN7g-0002Kw-4H; Thu, 13 Dec 2018 09:17:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6550D207261E5; Thu, 13 Dec 2018 10:17:33 +0100 (CET)
Date:   Thu, 13 Dec 2018 10:17:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Dmitry Safonov <dima@arista.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] tty/serial: do not free trasnmit buffer page under port
 lock
Message-ID: <20181213091733.GD5289@hirez.programming.kicks-ass.net>
References: <20181213045839.9692-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213045839.9692-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 01:58:39PM +0900, Sergey Senozhatsky wrote:
> LKP has hit yet another circular locking dependency between uart
> console drivers and debugobjects [1]:
> 
>      CPU0                                    CPU1
> 
>                                             rhltable_init()
>                                              __init_work()
>                                               debug_object_init
>      uart_shutdown()                          /* db->lock */
>       /* uart_port->lock */                    debug_print_object()
>        free_page()                              printk()
>                                                  call_console_drivers()
>         debug_check_no_obj_freed()                /* uart_port->lock */
>          /* db->lock */
>           debug_print_object()
> 
> So there are two dependency chains:
> 	uart_port->lock -> db->lock
> And
> 	db->lock -> uart_port->lock
> 
> This particular circular locking dependency can be addressed in several
> ways:
> 
> a) One way would be to move debug_print_object() out of db->lock scope
>    and, thus, break the db->lock -> uart_port->lock chain.
> b) Another one would be to free() transmit buffer page out of db->lock
>    in UART code; which is what this patch does.
> 
> It makes sense to apply a) and b) independently: there are too many things
> going on behind free(), none of which depend on uart_port->lock.
> 
> The patch fixes transmit buffer page free() in uart_shutdown() and,
> additionally, in uart_port_startup() (as was suggested by Dmitry Safonov).
> 
> [1] https://lore.kernel.org/lkml/20181211091154.GL23332@shao2-debian/T/#u
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Petr Mladek <pmladek@suse.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  drivers/tty/serial/serial_core.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index c439a5a1e6c0..d4cca5bdaf1c 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -205,10 +205,15 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
>  	if (!state->xmit.buf) {
>  		state->xmit.buf = (unsigned char *) page;
>  		uart_circ_clear(&state->xmit);
> +		uart_port_unlock(uport, flags);
>  	} else {
> +		uart_port_unlock(uport, flags);
> +		/*
> +		 * Do not free() the page under the port lock, see
> +		 * uart_shutdown().
> +		 */
>  		free_page(page);
>  	}
> -	uart_port_unlock(uport, flags);
>  
>  	retval = uport->ops->startup(uport);
>  	if (retval == 0) {
> @@ -268,6 +273,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
>  	struct uart_port *uport = uart_port_check(state);
>  	struct tty_port *port = &state->port;
>  	unsigned long flags = 0;
> +	char *xmit_buf = NULL;
>  
>  	/*
>  	 * Set the TTY IO error marker
> @@ -298,14 +304,18 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
>  	tty_port_set_suspended(port, 0);
>  
>  	/*
> -	 * Free the transmit buffer page.
> +	 * Do not free() the transmit buffer page under the port lock since
> +	 * this can create various circular locking scenarios. For instance,
> +	 * console driver may need to allocate/free a debug object, which
> +	 * can endup in printk() recursion.
>  	 */
>  	uart_port_lock(state, flags);
> -	if (state->xmit.buf) {
> -		free_page((unsigned long)state->xmit.buf);
> -		state->xmit.buf = NULL;
> -	}
> +	xmit_buf = state->xmit.buf;
> +	state->xmit.buf = NULL;
>  	uart_port_unlock(uport, flags);
> +
> +	if (xmit_buf)
> +		free_page((unsigned long)xmit_buf);
>  }
>  
>  /**
> -- 
> 2.20.0
> 

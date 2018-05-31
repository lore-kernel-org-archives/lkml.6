Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755234AbeEaN1M (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:27:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:52579 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755117AbeEaN1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:27:11 -0400
Date: Thu, 31 May 2018 15:27:08 +0200
From: Petr Mladek <pmladek@suse.com>
To: Maninder Singh <maninder1.s@samsung.com>
Cc: sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 2/2] printk: make sure to print log on console.
Message-ID: <20180531132708.2yappktdrz6qljxi@pathway.suse.cz>
References: <CGME20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e@epcas5p2.samsung.com>
 <20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e~zs5h59tMh2250222502epcas5p2S@epcas5p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531102246epcas5p2f1cbc6ff217172e12e2f78bb88eb4a7e~zs5h59tMh2250222502epcas5p2S@epcas5p2.samsung.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-05-31 15:49:11, Maninder Singh wrote:
> This patch make sure printing of log if loglevel at time of storing
> log is greater than current console loglevel.
> 
> @why
> In case of async printk, printk thread can miss logs because it checks
> current log level at time of console_unlock.
> 
> func()
> {
> ....
> ....
> 	console_verbose();  // user wants to have all the logs on console.
> 	pr_alert();
> 	pr_info();
> 	dump_backtrace(); // prints with default loglevel.
> 	pr_info();
> 	pr_emerg();
> 	pr_info();
> 	...
> 	...
> 	...
> 	pr_info();
> 	console_silent(); // stop all logs from printing on console.
> }
> 
> Now if printk thread is scheduled after setting console loglevel
> to silent, then user's requirement will be in waste, because it will not
> print logs on console at time of printk thread scheduling.

A better text would be something like:

Now if console_lock was owned by another process, the messages might
be handled after the consoles were silenced.

> @how
> use one bit of flags field to store whether its console print
> or not(console_print) by checking current console loglevel with 
> message's level at time of log.
> At time of print check this flag for printing message on console.
> 
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  kernel/printk/printk.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ab15903..4e0be66e 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -360,8 +360,16 @@ struct printk_log {
>  	u16 text_len;		/* length of text buffer */
>  	u16 dict_len;		/* length of dictionary buffer */
>  	u8 facility;		/* syslog facility */
> -	u8 flags:5;		/* internal record flags */
> +	u8 flags:4;		/* internal record flags */
>  	u8 level:3;		/* syslog level */
> +	/*
> +	 * whether to print this msg on console or not?
> +	 * due to async printk, printk thread can miss
> +	 * prints at the time of console_flush because of
> +	 * change in print level afterwards.
> +	 */
> +	u8 console_print:1;

We should be careful with changing the structure. It is accessed
by external tools, like "crash".

IMHO, it is perfectly fine to handle this by a flag, e.g.
add LOG_CON_SUPPRESS.

> +
>  }
>  #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>  __packed __aligned(4)
> @@ -623,7 +631,12 @@ static int log_store(int facility, int level,
>  	msg->dict_len = dict_len;
>  	msg->facility = facility;
>  	msg->level = level & 7;
> -	msg->flags = flags & 0x1f;
> +	if (msg->level >= console_loglevel)
> +		msg->console_print = 0;
> +	else
> +		msg->console_print = 1;

We are going to decide about the visibility when the message is
stored. Let's handle it completely and make it easier later.

We could keep suppress_message_printing() as is and do the following
in vprintk_emit():

	if (suppress_message_printing(level)
		lflags |= LOG_CON_SUPPRESS;

> @@ -2354,7 +2367,7 @@ void console_unlock(void)
>  			break;
>  
>  		msg = log_from_idx(console_idx);
> -		if (suppress_message_printing(msg->level)) {
> +		if (suppress_message_printing(msg->console_print)) {

Then it is enough to do

-		if (suppress_message_printing(msg->level)) {
+		if (msg->flags & LOG_CON_SUPRESSED) {

Best Regards,
Petr

  			/*
>  			 * Skip record we have buffered and already printed
>  			 * directly to the console when we received it, and
> -- 
> 1.9.1
> 

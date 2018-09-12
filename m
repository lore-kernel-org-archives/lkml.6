Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7346EC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349A720854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349A720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeILSiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:38:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:36534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbeILSiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:38:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 507FBAED2;
        Wed, 12 Sep 2018 13:33:49 +0000 (UTC)
Date:   Wed, 12 Sep 2018 15:33:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 4.19 regression fix] printk: For early boot messages
 check loglevel when flushing the buffer
Message-ID: <20180912133347.23ulng4njaa3uzsa@pathway.suse.cz>
References: <20180905053609.GA19936@jagdpanzerIV>
 <20180905083326.GC19936@jagdpanzerIV>
 <20180905110207.rxy3upplgkjbk5oi@pathway.suse.cz>
 <20180906072940.GA382@jagdpanzerIV>
 <20180906142825.u2fiqt62jmapr5ud@pathway.suse.cz>
 <20180907042132.GC2394@jagdpanzerIV>
 <20180910145747.emvfzv4mzlk5dfqk@pathway.suse.cz>
 <20180911023039.GA4065@jagdpanzerIV>
 <20180911084722.22fqbewiebzsdofm@pathway.suse.cz>
 <20180912074930.GA470@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912074930.GA470@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-09-12 16:49:30, Sergey Senozhatsky wrote:
> On (09/11/18 10:47), Petr Mladek wrote:
> > > > Most problems should probably be solved when we store console_seq
> > > > before setting exclusive_console. Then we could clear
> > > > exclusive_console when reaching the stored sequence number.
> 
> Hmm, wouldn't the same "it might be problematic with slow consoles"
> argument apply to this solution as well?

It would just fix a clear bug.

> So maybe we can do the following:
> 
> - store console_seq when we register exclusive console
> - in flush_on_panic, if we have exclusive console set
>     - clear exclusive console
>     - rollback console_seq to the value it had before we set exclusive console
 
> ---
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 53c94cbce0af..4ef199572df7 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -424,6 +424,7 @@ static u32 log_next_idx;
>  /* the next printk record to write to the console */
>  static u64 console_seq;
>  static u32 console_idx;
> +static u64 rollback_console_seq;
>  
>  /* the next printk record to read after the last 'clear' command */
>  static u64 clear_seq;
> @@ -2592,6 +2593,10 @@ void console_flush_on_panic(void)
>  	 */
>  	console_trylock();
>  	console_may_schedule = 0;
> +	if (exclusive_console) {
> +		exclusive_console = NULL;
> +		console_seq = rollback_console_seq;

This might be controversial. Yes, it might help in some situations
(slow exclusive console). But it might be counterproductive
when the exclusive console is the one that is readable
after the crash, used for debugging and this change causes
an incomplete log.

I would do this change only when people complains about
the current behavior.

I think that more important is to do:

@@ -2415,6 +2415,9 @@ void console_unlock(void)
                console_seq++;
                raw_spin_unlock(&logbuf_lock);
 
+               if (exclusive_console && console_seq >= rollback_console_seq)
+                       exclusive_console = NULL;
+
                /*
                 * While actively printing out messages, if another printk()
                 * were to occur on another CPU, it may wait for this one to

IMHO, this is a clear win. It fixes a clear mistake.

I would just rename the variable to exclusive_console_seq_stop or so.

Best Regards,
Petr

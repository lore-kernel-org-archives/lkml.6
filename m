Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7286C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8313621773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfBTJBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:01:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:34772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbfBTJBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:01:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0A315B0B6;
        Wed, 20 Feb 2019 09:01:13 +0000 (UTC)
Date:   Wed, 20 Feb 2019 10:01:12 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 10/25] printk: redirect emit/store to new
 ringbuffer
Message-ID: <20190220090112.xbnauwt2w7gwtebo@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-11-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-12 15:29:48, John Ogness wrote:
> vprintk_emit and vprintk_store are the main functions that all printk
> variants eventually go through. Change these to store the message in
> the new printk ring buffer that the printk kthread is reading.

We need to switch the two buffers in a single commit
without disabling important functionality.

By other words, we need to change vprintk_emit(), vprintk_store(),
console_unlock(), syslog(), devkmsg(), and syslog in one patch.

The only exception might continuous lines handling. We might
temporary store them right away. It should not break bisectability.

The patch will be huge but I do not see other reasonable solution
at the moment. In each case, the patch should do only
a "straightforward" switch. Any refactoring or logical
changes should be done in preliminary patches.


> Remove functions no longer in use because of the changes to
> vprintk_emit and vprintk_store.
> 
> In order to handle interrupts and NMIs, a second per-cpu ring buffer
> (sprint_rb) is added. This ring buffer is used for NMI-safe memory
> allocation in order to format the printk messages.
> 
> NOTE: LOG_CONT is ignored for now and handled as individual messages.
>       LOG_CONT functions are masked behind "#if 0" blocks until their
>       functionality can be restored
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 319 ++++++++-----------------------------------------
>  1 file changed, 51 insertions(+), 268 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 5a5a685bb128..b6a6f1002741 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -584,54 +500,36 @@ static int log_store(int facility, int level,
>  		     const char *text, u16 text_len)

>  	memcpy(log_dict(msg), dict, dict_len);
>  	msg->dict_len = dict_len;
>  	msg->facility = facility;
>  	msg->level = level & 7;
>  	msg->flags = flags & 0x1f;

The existing struct printk_log is stored into the data field
of struct prb_entry. It is because printk_ring_buffer is supposed
to be a generic ring buffer.

It makes the code more complicated. Also it needs more space for
the size and seq items from struct prb_entry.

printk() is already very complicated code. We should not make
it unnecessarily worse.

Please, are there any candidates or plans to reuse the new ring
buffer implementation? For example, would it be usable
for ftrace? Steven?

If not, I would prefer to make it printk-specific
and hopefully simplify the code a bit.


> -	if (ts_nsec > 0)
> -		msg->ts_nsec = ts_nsec;
> -	else
> -		msg->ts_nsec = local_clock();
> -	memset(log_dict(msg) + dict_len, 0, pad_len);
> +	msg->ts_nsec = ts_nsec;
>  	msg->len = size;
>  
>  	/* insert message */
> -	log_next_idx += msg->len;
> -	log_next_seq++;
> +	prb_commit(&h);
>  
>  	return msg->text_len;
>  }

[...]

>  int vprintk_store(int facility, int level,
>  		  const char *dict, size_t dictlen,
>  		  const char *fmt, va_list args)
>  {
> -	static char textbuf[LOG_LINE_MAX];
> -	char *text = textbuf;
> -	size_t text_len;
> +	return vprintk_emit(facility, level, dict, dictlen, fmt, args);
> +}
> +
> +/* ring buffer used as memory allocator for temporary sprint buffers */
> +DECLARE_STATIC_PRINTKRB(sprint_rb,
> +			ilog2(PRINTK_RECORD_MAX + sizeof(struct prb_entry) +
> +			      sizeof(long)) + 2, &printk_cpulock);
> +
> +asmlinkage int vprintk_emit(int facility, int level,
> +			    const char *dict, size_t dictlen,
> +			    const char *fmt, va_list args)

[...]

> +	rbuf = prb_reserve(&h, &sprint_rb, PRINTK_SPRINT_MAX);

The second ring buffer for temporary buffers is really interesting
idea.

Well, it brings some questions. For example, how many users might
need a reservation in parallel. Or if the nested use might cause
some problems when we decide to use printk-specific ring buffer
implementation. I still have to think about it.


> -	/* If called from the scheduler, we can not call up(). */
> -	if (!in_sched && pending_output) {
> -		/*
> -		 * Disable preemption to avoid being preempted while holding
> -		 * console_sem which would prevent anyone from printing to
> -		 * console
> -		 */
> -		preempt_disable();
> -		/*
> -		 * Try to acquire and then immediately release the console
> -		 * semaphore.  The release will print out buffers and wake up
> -		 * /dev/kmsg and syslog() users.
> -		 */
> -		if (console_trylock_spinning())
> -			console_unlock();
> -		preempt_enable();
> -	}

I guess that it is clear from the other mails. But to be sure.
This patch should just switch the buffers. The console handling
optimizations/fixes should be done in later patches or even
in a separate patchset.

Best Regards,
Petr

PS: I have just finished a mail that I started writing yesterday
evening. I am going to proceed some other pending mails now. I'll
come back to this thread soon.

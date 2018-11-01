Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28474C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06D020820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06D020820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeKAXQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:16:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:35216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727976AbeKAXQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:16:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23D53AEC8;
        Thu,  1 Nov 2018 14:13:43 +0000 (UTC)
Date:   Thu, 1 Nov 2018 15:13:42 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5] printk: Add line-buffered printk() API.
Message-ID: <20181101141342.t65mqwxdpqs3mu5i@pathway.suse.cz>
References: <1540375870-6235-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540375870-6235-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-10-24 19:11:10, Tetsuo Handa wrote:
> Sometimes we want to print a whole line without being disturbed by
> concurrent printk() from interrupts and/or other threads, for printk()
> which does not end with '\n' can be disturbed.
> 
> Since mixed printk() output makes it hard to interpret, this patch
> introduces API for line-buffered printk() output (so that we can make
> sure that printk() ends with '\n').
> 
> Since functions introduced by this patch are merely wrapping
> printk()/vprintk() calls in order to minimize possibility of using
> "struct cont", it is safe to replace printk()/vprintk() with this API.
> Since we want to remove "struct cont" eventually, we will try to remove
> both "implicit printk() users who are expecting KERN_CONT behavior" and
> "explicit pr_cont()/printk(KERN_CONT) users". Therefore, converting to
> this API is recommended.
> 
> After this patch, we will consider how we can add context identifier to
> each line of printk() output (so that we can group multiple lines into
> one block when parsing). Therefore, if converting to this API does not
> fit for some reason, you might be able to consider converting to multiple
> printk() calls which end with '\n'.

The buffered printk API is for continuous lines. It is more
complicated than a simple printk. You need to get, use, and put
the buffer. It might be acceptable for continuous lines that
should be rare and the related calls typically located in a single
function.

I prefer to solve the related lines on another level, for example,
by storing/showing PID+context_mask for each printed line. This
way it would work transparently even for normal printk().


> Details:
> 
>   A structure named "struct printk_buffer" is introduced for buffering
>   up to LOG_LINE_MAX bytes of printk() output which did not end with '\n'.
> 
>   get_printk_buffer() tries to assign a "struct printk_buffer" from
>   statically preallocated array. get_printk_buffer() returns NULL if
>   all "struct printk_buffer" are in use, but the caller does not need to
>   check for NULL.
> 
>   put_printk_buffer() flushes and releases the "struct printk_buffer".
>   put_printk_buffer() must match corresponding get_printk_buffer() as with
>   rcu_read_unlock() must match corresponding rcu_read_lock().
> 
>   Three functions vprintk_buffered(), printk_buffered() and
>   flush_printk_buffer() are provided for using "struct printk_buffer".
>   These are like vfprintf(), fprintf(), fflush() except that these receive
>   "struct printk_buffer *" for the first argument.
> 
>   vprintk_buffered() and printk_buffered() behave like vprintk() and
>   printk() respectively if "struct printk_buffer *" argument is NULL.

I have troubles the distinguish the meaning of above sentence and
the previous paragraph. It might help to use "fall back" instead
of "behave like".


>   flush_printk_buffer() and put_printk_buffer() become no-op if
>   "struct printk_buffer *" argument is NULL. Therefore, the caller of
>   get_printk_buffer() does not need to check for NULL.
> 

[...]

> --- /dev/null
> +++ b/kernel/printk/printk_buffered.c
> @@ -0,0 +1,279 @@

/* SPDX-License-Identifier: GPL-2.0+ */

> +/*
> + * printk_buffered.c - Line buffered printk() for avoiding KERN_CONT usage.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/types.h> /* DECLARE_BITMAP() */
> +#include <linux/preempt.h> /* in_nmi() */
> +#include <linux/workqueue.h> /* queue_work() */
> +#include <linux/stacktrace.h> /* save_stack_trace() */
> +#include <linux/sched.h> /* cond_resched() */
> +#include <linux/printk.h>
> +
> +/*
> + * Should be sync with definitions in printk.c in order to avoid truncated
> + * printk() output due to limitations.
> + */
> +#define PREFIX_MAX		32
> +#define LOG_LINE_MAX		(1024 - PREFIX_MAX)

This might be shared via kernel/printk/internal.h


> +/* A structure for line-buffered printk() output. */
> +struct printk_buffer {
> +	unsigned short int used; /* Valid bytes in buf[]. */
> +	char buf[LOG_LINE_MAX];
> +} __aligned(1024);
> +
> +/*
> + * Number of statically preallocated buffers.
> + *
> + * We can introduce a kernel config option if someone wants to tune this value.
> + * But since "struct printk_buffer" makes difference only when there are
> + * multiple threads concurrently calling printk() which does not end with '\n',
> + * and this API will fallback to normal printk() when all buffers are in use,
> + * it is possible that nobody needs to tune this value.
> + */
> +#define NUM_LINE_BUFFERS 16
> +
> +static struct printk_buffer printk_buffers[NUM_LINE_BUFFERS];
> +static DECLARE_BITMAP(printk_buffers_in_use, NUM_LINE_BUFFERS);
> +
> +#ifdef CONFIG_DEBUG_PRINTK_BUFFERED
> +#define PRINTK_BUFFERS_MAX_TRACE_ENTRIES 20
> +static struct {
> +	unsigned long stamp;
> +	struct stack_trace trace;
> +	unsigned long entries[PRINTK_BUFFERS_MAX_TRACE_ENTRIES];
> +} printk_buffers_dump[NUM_LINE_BUFFERS];
> +static int buffer_users_report_scheduled;
> +
> +static void report_buffer_users(struct work_struct *work)
> +{
> +	long i;
> +	unsigned int j;
> +
> +	/*
> +	 * This report is racy. But it does not worth introducing a lock
> +	 * dependency.
> +	 */
> +	pr_info("printk: All line buffers are in use.\n");

nit: It need not longer be true. I would use "were in use".

> +	for (i = 0; i < NUM_LINE_BUFFERS; i++) {
> +		if (!test_bit(i, printk_buffers_in_use))
> +			continue;
> +		pr_info("buffer[%lu] was reserved %lu jiffies ago by\n",
> +			i, jiffies - printk_buffers_dump[i].stamp);

nit: It is not a big deal. But I would convert this to a human
     readable time, e.g. by jiffies_to_msecs() or jiffies_to_timeval().


> +		for (j = 0; j < printk_buffers_dump[i].trace.nr_entries; j++)
> +			pr_info("  %pS\n", (void *)
> +				printk_buffers_dump[i].entries[j]);

This duplicates print_stack_trace().

> +		cond_resched();
> +	}
> +}
> +#endif
> +
> +static inline void save_caller_info(const long i)
> +{
> +#ifdef CONFIG_DEBUG_PRINTK_BUFFERED
> +	if (buffer_users_report_scheduled)
> +		return;
> +	printk_buffers_dump[i].stamp = jiffies;
> +	printk_buffers_dump[i].trace.nr_entries = 0;
> +	printk_buffers_dump[i].trace.entries = printk_buffers_dump[i].entries;
> +	printk_buffers_dump[i].trace.max_entries =
> +		PRINTK_BUFFERS_MAX_TRACE_ENTRIES;
> +	printk_buffers_dump[i].trace.skip = 0;
> +	save_stack_trace(&printk_buffers_dump[i].trace);
> +#endif
> +}
> +
> +static void dump_caller_info(void)
> +{
> +#ifdef CONFIG_DEBUG_PRINTK_BUFFERED
> +	static DECLARE_WORK(work, report_buffer_users);
> +
> +	/*
> +	 * Oops, out of "struct printk_buffer" happened. Fallback to normal
> +	 * printk().
> +	 *
> +	 * If you think that it might be due to missing put_printk_buffer()
> +	 * calls, you can enable CONFIG_DEBUG_PRINTK_BUFFERED.
> +	 * Then, who is using the buffers will be reported (from workqueue
> +	 * context because reporting NUM_LINE_BUFFERS entries
> +	 * from atomic context might be too slow). If it does not look like
> +	 * missing put_printk_buffer() calls, you might want to increase
> +	 * NUM_LINE_BUFFERS.
> +	 *
> +	 * But if it turns out that allocating "struct printk_buffer" on stack
> +	 * or in .bss section or from kzalloc() is more suitable than tuning
> +	 * NUM_LINE_BUFFERS, we can update to do so.
> +	 */
> +	if (!in_nmi() && !cmpxchg(&buffer_users_report_scheduled, 0, 1))
> +		queue_work(system_unbound_wq, &work);

Please, add a comment that buffer_users_report_scheduled is never
cleared by intention.


> +#elif defined(CONFIG_STACKTRACE)

The warning should not depend on CONFIG_STACKTRACE. It is
enough that CONFIG_DEBUG_PRINTK_BUFFERED depends on it.

> +	printk_once("Out of printk buffers. Please consider
> CONFIG_DEBUG_PRINTK_BUFFERED=y\n");

pr_warn_once()

> +#endif
> +}
> +
> +/**
> + * get_printk_buffer - Try to get printk_buffer.
> + *
> + * Returns pointer to "struct printk_buffer" on success, NULL otherwise.
> + *
> + * If this function returned "struct printk_buffer", the caller is responsible
> + * for passing it to put_printk_buffer() so that "struct printk_buffer" can be
> + * reused in the future.
> + *
> + * Even if this function returned NULL, the caller does not need to check for
> + * NULL, for passing NULL to printk_buffered() simply acts like normal printk()
> + * and passing NULL to flush_printk_buffer()/put_printk_buffer() is a no-op.
> + */
> +struct printk_buffer *get_printk_buffer(void)
> +{
> +	long i;
> +
> +	for (i = 0; i < NUM_LINE_BUFFERS; i++) {
> +		if (test_and_set_bit_lock(i, printk_buffers_in_use))
> +			continue;
> +		printk_buffers[i].used = 0;

nit: I tend to get confused by the meaning of buffer.used vs.
     printk_buffers_in_use bit. Please, use ".len" instead.
     It is used for this purpose, for example, in struct seq_buf
     or struct cont.


> +		save_caller_info(i);
> +		return &printk_buffers[i];
> +	}
> +	dump_caller_info();
> +	return NULL;
> +}
> +EXPORT_SYMBOL(get_printk_buffer);
> +
> +/**
> + * vprintk_buffered - Try to vprintk() in line buffered mode.
> + *
> + * @ptr:  Pointer to "struct printk_buffer". It can be NULL.
> + * @fmt:  printk() format string.
> + * @args: va_list structure.
> + *
> + * Returns the return value of vprintk().
> + *
> + * Try to store to @ptr first. If it fails, flush @ptr and then try to store to
> + * @ptr again. If it still fails, use unbuffered printing.
> + */
> +int vprintk_buffered(struct printk_buffer *ptr, const char *fmt, va_list args)
> +{
> +	va_list tmp_args;
> +	int fmt_offset;
> +	int r;
> +
> +	if (!ptr)
> +		goto unbuffered;

nit: We could directly return vprintk(fmt, args).


> +	/*
> +	 * Skip KERN_CONT here based on an assumption that KERN_CONT will be
> +	 * given via "fmt" argument when KERN_CONT is given.
> +	 */
> +	fmt_offset = (printk_get_level(fmt) == 'c') ? 2 : 0;
> + retry:
> +	va_copy(tmp_args, args);
> +	r = vsnprintf(ptr->buf + ptr->used, sizeof(ptr->buf) - ptr->used,
> +		      fmt + fmt_offset, tmp_args);
> +	va_end(tmp_args);
> +	if (r + ptr->used < sizeof(ptr->buf)) {
> +		ptr->used += r;
> +		/* Flush already completed lines if any. */
> +		for (r = ptr->used - 1; r >= 0; r--) {
> +			if (ptr->buf[r] != '\n')
> +				continue;

I thought about using strrchr(). But this is more effective
because we know the length of the string. It might deserve
a comment though.


> +			ptr->buf[r++] = '\0';
> +			printk("%s\n", ptr->buf);
> +			ptr->used -= r;
> +			memmove(ptr->buf, ptr->buf + r, ptr->used);

This does not copy the trailing '\0'. I know that you enter it in
flush_printk_buffer() but it looks rather error prone when modifying
or debugging the code in the future.


> +			break;
> +		}
> +		return r;

We need to use another variable in the for-cycle. Otherwise, we would
not return the number of printed characters here.


> +	}
> +	/*
> +	 * Since this "ptr" is dedicated to the caller, there is no possibility
> +	 * of retrying more than once in one vprintk_buffered() call.
> +	 */
> +	if (flush_printk_buffer(ptr))
> +		goto retry;

nit: I would personally invert the logic and move this above. The
following might be even more readable.

	if (ptr->used && ptr->used + r >= sizeof(ptr->buf)) {
		flush_printk_buffer(ptr);
		goto retry;
	}

Then we could continue with flushing complete lines.


> + unbuffered:
> +	return vprintk(fmt, args);
> +}
> +

[...]

> +/**
> + * flush_printk_buffer - Flush incomplete line in printk_buffer.
> + *
> + * @ptr: Pointer to "struct printk_buffer". It can be NULL.
> + *
> + * Returns true if flushed something, false otherwise.
> + *
> + * Flush if @ptr contains partial data. But usually there is no need to call
> + * this function because @ptr is flushed by put_printk_buffer().
> + */
> +bool flush_printk_buffer(struct printk_buffer *ptr)
> +{
> +	if (!ptr || !ptr->used)
> +		return false;
> +	/* vprintk_buffered() keeps 0 <= ptr->used < sizeof(ptr->buf) true. */
> +	ptr->buf[ptr->used] = '\0';

We do not need this when there is always the trailing '\0' in
non-empty buffer. It looks more sane to me.


> +	printk("%s", ptr->buf);
> +	ptr->used = 0;
> +	return true;
> +}
> +EXPORT_SYMBOL(flush_printk_buffer);


We are getting close. Please, split the debugging stuff into separate
patch.

Also it would be great to do add a sample conversion from pr_cont() to
this API in another separate patch.

Thanks for working on it.

Best Regards,
Petr

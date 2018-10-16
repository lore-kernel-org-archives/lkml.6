Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16E8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788AC20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788AC20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeJPV60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:58:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:41764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726778AbeJPV60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:58:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11F3EAF87;
        Tue, 16 Oct 2018 14:07:45 +0000 (UTC)
Date:   Tue, 16 Oct 2018 16:07:44 +0200
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
Subject: Re: [PATCH v4] printk: Add line-buffered printk() API.
Message-ID: <20181016140744.dviqn6yvm5brr2gu@pathway.suse.cz>
References: <1539405580-4569-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539405580-4569-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-10-13 13:39:40, Tetsuo Handa wrote:
> Sometimes we want to print a whole line without being disturbed by
> concurrent printk() from interrupts and/or other threads, for printk()
> which does not end with '\n' can be disturbed.
> 
> Mixed printk() output makes it hard to interpret. Assuming that we will go
> to a direction that we allow prefixing context identifier to each line of
> printk() output (so that we can group multiple lines into one block when
> parsing), this patch introduces API for line-buffered printk() output
> (so that we can make sure that printk() ends with '\n').
> 
> Since functions introduced by this patch are merely wrapping
> printk()/vprintk() calls in order to minimize possibility of using
> "struct cont", it is safe to replace printk()/vprintk() with this API.

> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index cf3eccf..f93d9c8 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -286,6 +286,30 @@ static inline void printk_safe_flush_on_panic(void)
>  }
>  #endif
>  
> +struct printk_buffer;
> +#if defined(CONFIG_PRINTK_LINE_BUFFERED)
> +struct printk_buffer *get_printk_buffer(void);
> +void flush_printk_buffer(struct printk_buffer *ptr);
> +__printf(2, 3)
> +int buffered_printk(struct printk_buffer *ptr, const char *fmt, ...);
> +__printf(2, 0)
> +int buffered_vprintk(struct printk_buffer *ptr, const char *fmt, va_list args);
> +void put_printk_buffer(struct printk_buffer *ptr);
> +#else
> +static inline struct printk_buffer *get_printk_buffer(void)
> +{
> +	return NULL;
> +}
> +static inline void flush_printk_buffer(struct printk_buffer *ptr)
> +{
> +}
> +#define buffered_printk(ptr, fmt, ...) printk(fmt, ##__VA_ARGS__)
> +#define buffered_vprintk(ptr, fmt, args) vprintk(fmt, args)
> +static inline void put_printk_buffer(struct printk_buffer *ptr)
> +{
> +}
> +#endif

Is there any reason to allow to disable this feature?
The current cont buffer is always enabled.

>  extern int kptr_restrict;
>  
>  #ifndef pr_fmt
> @@ -300,19 +324,34 @@ static inline void printk_safe_flush_on_panic(void)
>   */
>  #define pr_emerg(fmt, ...) \
>  	printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
> +#define bpr_emerg(ptr, fmt, ...) \
> +	buffered_printk(ptr, KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
>  #define pr_alert(fmt, ...) \
>  	printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
> +#define bpr_alert(ptr, fmt, ...) \
> +	buffered_printk(ptr, KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
>  #define pr_crit(fmt, ...) \
>  	printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
> +#define bpr_crit(ptr, fmt, ...) \
> +	buffered_printk(ptr, KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
>  #define pr_err(fmt, ...) \
>  	printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
> +#define bpr_err(ptr, fmt, ...) \
> +	buffered_printk(ptr, KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>  #define pr_warning(fmt, ...) \
>  	printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
> +#define bpr_warning(ptr, fmt, ...) \
> +	buffered_printk(ptr, KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
>  #define pr_warn pr_warning
> +#define bpr_warn bpr_warning
>  #define pr_notice(fmt, ...) \
>  	printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
> +#define bpr_notice(ptr, fmt, ...) \
> +	buffered_printk(ptr, KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
>  #define pr_info(fmt, ...) \
>  	printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> +#define bpr_info(ptr, fmt, ...) \
> +	buffered_printk(ptr, KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)

Nitpick: Please, put bpr_* definitions into a separate paragraph.
The above is very hard to read.

>  /*
>   * Like KERN_CONT, pr_cont() should only be used when continuing
>   * a line with no newline ('\n') enclosed. Otherwise it defaults
> @@ -320,6 +359,8 @@ static inline void printk_safe_flush_on_panic(void)
>   */
>  #define pr_cont(fmt, ...) \
>  	printk(KERN_CONT fmt, ##__VA_ARGS__)
> +#define bpr_cont(ptr, fmt, ...) \
> +	buffered_printk(ptr, KERN_CONT fmt, ##__VA_ARGS__)
>
>  /* pr_devel() should produce zero code unless DEBUG is defined */
>  #ifdef DEBUG
> diff --git a/init/Kconfig b/init/Kconfig
> index 1e234e2..1fb01de 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -604,6 +604,37 @@ config PRINTK_SAFE_LOG_BUF_SHIFT
>  		     13 =>   8 KB for each CPU
>  		     12 =>   4 KB for each CPU
>  
> +config PRINTK_LINE_BUFFERED
> +	bool "Allow line buffered printk()"
> +	default y
> +	depends on PRINTK
> +	help
> +	  The line buffered printk() tries to buffer printk() output up to '\n'
> +	  so that incomplete lines won't be mixed when there are multiple
> +	  threads concurrently calling printk() which does not end with '\n'.

I would prefer to always enable it.


> +config PRINTK_NUM_LINE_BUFFERS
> +	int "Number of buffers for line buffered printk()"
> +	range 1 4096
> +	default 16
> +	depends on PRINTK_LINE_BUFFERED
> +	help
> +	  Specify the number of statically preallocated "struct printk_buffer"
> +	  for line buffered printk(). You don't need to specify a large number
> +	  here because "struct printk_buffer" makes difference only when there
> +	  are multiple threads concurrently calling printk() which does not end
> +	  with '\n', and line buffered printk() will fallback to normal
> +	  printk() when out of statically preallocated "struct printk_buffer"
> +	  happened.

I would prefer to start with a hard-coded number. There is a sane
fallback. We need to motivate people to send feedback so that we could
tune it and eventually remove the fallback (current cont buffer code).


> +config PRINTK_REPORT_OUT_OF_LINE_BUFFERS
> +	bool "Report out of buffers for line buffered printk()"
> +	default n
> +	depends on PRINTK_LINE_BUFFERED && STACKTRACE
> +	help
> +	  Select this if you want to know who is using statically preallocated
> +	  "struct printk_buffer" when out of "struct printk_buffer" happened.
> +

I like this approach with the configurable debug functionality. It is
safe and straightforward.

Just please, move it into a separate patch. It would help a lot
with review and discussion.

Nitpick: I suggest to make it a bit shorter, e.g. DEBUG_BUFFERED_PRINTK.


>  #
>  # Architectures with an unreliable sched_clock() should select this:
>  #
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 9bf5404..afc8bed 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1949,6 +1949,245 @@ asmlinkage int printk_emit(int facility, int level,
>  }
>  EXPORT_SYMBOL(printk_emit);
>  
> +#ifdef CONFIG_PRINTK_LINE_BUFFERED
> +/*
> + * A structure for line-buffered printk() output.
> + */
> +static struct printk_buffer {
> +	unsigned short int used; /* Valid bytes in buf[]. */
> +	char buf[LOG_LINE_MAX];
> +} printk_buffers[CONFIG_PRINTK_NUM_LINE_BUFFERS] __aligned(1024);
> +static DECLARE_BITMAP(printk_buffers_in_use, CONFIG_PRINTK_NUM_LINE_BUFFERS);
> +
> +
> +#ifdef CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS
> +static struct {
> +	unsigned long stamp;
> +	struct stack_trace trace;
> +	unsigned long entries[20];
> +} printk_buffers_dump[CONFIG_PRINTK_NUM_LINE_BUFFERS];
> +static int buffer_users_report_scheduled;

[...]
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
> + * NULL, for passing NULL to buffered_printk() simply acts like normal printk()
> + * and passing NULL to flush_printk_buffer()/put_printk_buffer() is a no-op.
> + */
> +struct printk_buffer *get_printk_buffer(void)
> +{

It does not make much sense to use the buffered printk in context
where printk_safe() or printk_nmi() is used. I suggest to define
something like:

static inline bool in_printk_safe_buffered_context(void)
{
	int this_printk_context = this_cpu_read(printk_context);

	if (this_printk_context && PRINTK_NMI_DIRECT_CONTEXT_MASK)
		return false;

	if (this_printk_context &&
	    (PRINTK_SAFE_CONTEXT_MASH || PRINTK_NMI_CONTEXT_MASK))
		return true;

	return true;

and do

	/*
	 * Messages are already concatenated when temporary
	 * stored into the safe per-CPU buffers.
	 */
	if (in_printk_safe_buffered_context())
		return NULL;

> +#ifdef CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS
> +	static DECLARE_WORK(work, report_buffer_users);
> +#endif
> +	long i;
> +
> +	for (i = 0; i < CONFIG_PRINTK_NUM_LINE_BUFFERS; i++) {
> +		if (test_bit(i, printk_buffers_in_use) ||
> +		    test_and_set_bit(i, printk_buffers_in_use))

I would use test_and_set_bit_lock() to make it more likely that
the barriers are right. Otherwise, there is missing the complementary
barrier with clear_bit() in put_printk_buffer().


> +			continue;
> +		printk_buffers[i].used = 0;
> +#ifdef CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS
> +		printk_buffers_dump[i].stamp = jiffies;
> +		printk_buffers_dump[i].trace.nr_entries = 0;
> +		printk_buffers_dump[i].trace.entries =
> +			printk_buffers_dump[i].entries;
> +		printk_buffers_dump[i].trace.max_entries = 20;

#define PRINTK_BUFFERS_MAX_TRACE_ENTRIES 20


> +		printk_buffers_dump[i].trace.skip = 0;
> +		save_stack_trace(&printk_buffers_dump[i].trace);
> +#endif

Please, put this into a helper function to avoid bloating
get_printk_buffer().


> +		return &printk_buffers[i];
> +	}

> +#ifdef CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS
> +	/*
> +	 * Oops, out of "struct printk_buffer" happened. Fallback to normal
> +	 * printk(). You might notice it by partial lines being printed.
> +	 *
> +	 * If you think that it might be due to missing put_printk_buffer()
> +	 * calls, you can enable CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS.
> +	 * Then, who is using the buffers will be reported (from workqueue
> +	 * context because reporting CONFIG_PRINTK_NUM_LINE_BUFFERS entries
> +	 * from atomic context might be too slow). If it does not look like
> +	 * missing put_printk_buffer() calls, you might want to increase
> +	 * CONFIG_PRINTK_NUM_LINE_BUFFERS.
> +	 *
> +	 * But if it turns out that allocating "struct printk_buffer" on stack
> +	 * or in .bss section or from kzalloc() is more suitable than tuning
> +	 * CONFIG_PRINTK_NUM_LINE_BUFFERS, we can update to do so.
> +	 */
> +	if (!in_nmi() && !cmpxchg(&buffer_users_report_scheduled, 0, 1))
> +		queue_work(system_unbound_wq, &work);

We should limit the number of this reports especially when the buffers
leaked and are never released again. I would either limit the total
count of these reports or I would allow scheduling only when
any get_printk_buffer() succeeded in the meantime.

Also we should know when the debugging makes sense. Therefore, we should
write something even when the debugging is off. Something like:

#else
      printk_once("Out of printk buffers. Please, consider enabling with CONFIG_DEBUG_BUFFERED_PRINTK\n");
#endif

> +	return NULL;
> +}
> +EXPORT_SYMBOL(get_printk_buffer);
> +
> +/**
> + * buffered_vprintk - Try to vprintk() in line buffered mode.
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
> +int buffered_vprintk(struct printk_buffer *ptr, const char *fmt, va_list args)
> +{
> +	va_list tmp_args;
> +	unsigned short int i;
> +	int r;
> +
> +	if (!ptr)
> +		goto unbuffered;
> +	for (i = 0; i < 2; i++) {

> +		unsigned int pos = ptr->used;
> +		char *text = ptr->buf + pos;
> +
> +		va_copy(tmp_args, args);
> +		r = vsnprintf(text, sizeof(ptr->buf) - pos, fmt, tmp_args);
> +		va_end(tmp_args);
> +		if (r + pos < sizeof(ptr->buf)) {
> +			/*
> +			 * Eliminate KERN_CONT at this point because we can
> +			 * concatenate incomplete lines inside printk_buffer.
> +			 */
> +			if (r >= 2 && printk_get_level(text) == 'c') {
> +				memmove(text, text + 2, r - 2);
> +				ptr->used += r - 2;

I believe that KERN_CONT is always passed via @fmt parameter. Therefore
we could skip it already in fmt and avoid this memmove. Also note that
printk_get_level() is safe even for empty string. The following
should work:

		if (printk_get_level(fmt) == 'c')
			fmt += 2;

> +			} else {
> +				ptr->used += r;
> +			}
> +			/* Flush already completed lines if any. */
> +			while (1) {
> +				char *cp = memchr(ptr->buf, '\n', ptr->used);
> +
> +				if (!cp)
> +					break;
> +				*cp = '\0';
> +				printk("%s\n", ptr->buf);
> +				i = cp - ptr->buf + 1;
> +				ptr->used -= i;
> +				memmove(ptr->buf, ptr->buf + i, ptr->used);
> +			}
> +			return r;
> +		}
> +		if (i)
> +			break;
> +		flush_printk_buffer(ptr);

It makes sense to repeat the cycle only when something was flushed.
I would would modify flush_printk_buffer() to return the number of
flushed characters.

Also it might be easier to read with goto, I mean to use:

try_again:   instead of for (i = 0; i < 2; i++) {

and then

	if (flush_printk_buffer(ptr))
		goto try_again;



> +	}
> + unbuffered:
> +	return vprintk(fmt, args);
> +}
> +
> +
> +/**
> + * put_printk_buffer - Release printk_buffer.
> + *
> + * @ptr: Pointer to "struct printk_buffer". It can be NULL.
> + *
> + * Returns nothing.
> + *
> + * Flush and release @ptr.
> + */
> +void put_printk_buffer(struct printk_buffer *ptr)
> +{
> +	long i = ptr - printk_buffers;
> +
> +	if (!ptr || i < 0 || i >= CONFIG_PRINTK_NUM_LINE_BUFFERS)
> +		return;

It would deserve a warning when i is out of bounds.


> +	if (ptr->used)
> +		flush_printk_buffer(ptr);
> +	/* Make sure in_use flag is cleared after setting ptr->used = 0. */
> +	wmb();
> +	clear_bit(i, printk_buffers_in_use);

I would replace this with clear_bit_lock(). It would do the barrier
correctly.

In each case, the comment in arch/x86/include/asm/bitops.h above
clear_bit() talks about smp_mb__before_atomic() and/or
smp_mb__after_atomic().

Finally, I would prefer to put the buffered_printk code into a
separate source file, e.g. kernel/printk/buffered_printk.c.

Best Regards,
Petr

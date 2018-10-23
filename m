Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08352C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B9C20651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B9C20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeJWW7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 18:59:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:52390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726970AbeJWW7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 18:59:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42E65AEDB;
        Tue, 23 Oct 2018 14:36:09 +0000 (UTC)
Date:   Tue, 23 Oct 2018 16:36:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
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
Message-ID: <20181023143607.hdkjnqbp43run46q@pathway.suse.cz>
References: <1539405580-4569-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181016140744.dviqn6yvm5brr2gu@pathway.suse.cz>
 <179a676a-0768-9969-6480-8c4d48af3b67@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179a676a-0768-9969-6480-8c4d48af3b67@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-10-17 18:54:52, Tetsuo Handa wrote:
> Petr Mladek wrote:
> > On Sat 2018-10-13 13:39:40, Tetsuo Handa wrote:
> > > +struct printk_buffer;
> > > +#if defined(CONFIG_PRINTK_LINE_BUFFERED)
> > > +struct printk_buffer *get_printk_buffer(void);
> > > +void flush_printk_buffer(struct printk_buffer *ptr);
> > > +__printf(2, 3)
> > > +int buffered_printk(struct printk_buffer *ptr, const char *fmt, ...);
> > > +__printf(2, 0)
> > > +int buffered_vprintk(struct printk_buffer *ptr, const char *fmt, va_list args);
> > > +void put_printk_buffer(struct printk_buffer *ptr);
> > > +#else
> > > +static inline struct printk_buffer *get_printk_buffer(void)
> > > +{
> > > +	return NULL;
> > > +}
> > > +static inline void flush_printk_buffer(struct printk_buffer *ptr)
> > > +{
> > > +}
> > > +#define buffered_printk(ptr, fmt, ...) printk(fmt, ##__VA_ARGS__)
> > > +#define buffered_vprintk(ptr, fmt, args) vprintk(fmt, args)
> > > +static inline void put_printk_buffer(struct printk_buffer *ptr)
> > > +{
> > > +}
> > > +#endif
> > 
> > Is there any reason to allow to disable this feature?
> > The current cont buffer is always enabled.
> 
> We need this dummy version anyway because CONFIG_PRINTK_LINE_BUFFERED
> depends on CONFIG_PRINTK=y.

Good point.

> Even with CONFIG_PRINTK=y, until the cont buffer is removed in future, some
> embedded users might want to save memory footprint for printk_buffers.

printk_safe and printk_nmi have big memory foot print as well and
nobody has complained yet. Let's keep it easy in the beginning.


> > > @@ -604,6 +604,37 @@ config PRINTK_SAFE_LOG_BUF_SHIFT
> > >  		     13 =>   8 KB for each CPU
> > >  		     12 =>   4 KB for each CPU
> > >  
> > > +config PRINTK_LINE_BUFFERED
> > > +	bool "Allow line buffered printk()"
> > > +	default y
> > > +	depends on PRINTK
> > > +	help
> > > +	  The line buffered printk() tries to buffer printk() output up to '\n'
> > > +	  so that incomplete lines won't be mixed when there are multiple
> > > +	  threads concurrently calling printk() which does not end with '\n'.
> > 
> > I would prefer to always enable it.
> 
> But embedded users might have very low traffic where buffering is not useful.

I prefer to keep it simple. Embedded people will speak if it matters.


> > > +config PRINTK_NUM_LINE_BUFFERS
> > > +	int "Number of buffers for line buffered printk()"
> > > +	range 1 4096
> > > +	default 16
> > > +	depends on PRINTK_LINE_BUFFERED
> > > +	help
> > > +	  Specify the number of statically preallocated "struct printk_buffer"
> > > +	  for line buffered printk(). You don't need to specify a large number
> > > +	  here because "struct printk_buffer" makes difference only when there
> > > +	  are multiple threads concurrently calling printk() which does not end
> > > +	  with '\n', and line buffered printk() will fallback to normal
> > > +	  printk() when out of statically preallocated "struct printk_buffer"
> > > +	  happened.
> > 
> > I would prefer to start with a hard-coded number. There is a sane
> > fallback. We need to motivate people to send feedback so that we could
> > tune it and eventually remove the fallback (current cont buffer code).
> 
> I think that we don't need kernel command line parameters for tuning this number.
> But having a kernel config option will help encouraging people to try this API,
> for there might be some users who can't try this API without a lot of printk
> buffers (syzbot-like systems or huge systems which generate huge traffic).

We need to get it working on all systems. I really would like to get
rid of the current cont buffer.


> > > +config PRINTK_REPORT_OUT_OF_LINE_BUFFERS
> > > +	bool "Report out of buffers for line buffered printk()"
> > > +	default n
> > > +	depends on PRINTK_LINE_BUFFERED && STACKTRACE
> > > +	help
> > > +	  Select this if you want to know who is using statically preallocated
> > > +	  "struct printk_buffer" when out of "struct printk_buffer" happened.
> > > +
> > 
> > I like this approach with the configurable debug functionality. It is
> > safe and straightforward.
> 
> I didn't get what "the configurable debug functionality" means. You mean
> enable/disable via debugfs entry? We can later hear from users whether we
> want to allow enable/disable at kernel boot command line and/or debugfs entry.

All new functions are called *printk_buffered() or pbf_*(). It might help
if the configure option would use PRINTK_BUFFERED as well. In addition,
I have troubles to parse it. It might mean also buffer overflow...

Now, this option will be used to debug problems with buffered_printk().
It currently prints some messages when we are out of buffers. But we
might need more. Nobody wants zillions of configure options. One
should be enough.

DEBUG_SOME_FEATURE is a commonly used pattern to enable extra
checks and reports for debugging a feature. I believe that
CONFIG_DEBUG_BUFFERED_PRINTK is more self-explaining.


> > > +/**
> > > + * get_printk_buffer - Try to get printk_buffer.
> > > + *
> > > + * Returns pointer to "struct printk_buffer" on success, NULL otherwise.
> > > + *
> > > + * If this function returned "struct printk_buffer", the caller is responsible
> > > + * for passing it to put_printk_buffer() so that "struct printk_buffer" can be
> > > + * reused in the future.
> > > + *
> > > + * Even if this function returned NULL, the caller does not need to check for
> > > + * NULL, for passing NULL to buffered_printk() simply acts like normal printk()
> > > + * and passing NULL to flush_printk_buffer()/put_printk_buffer() is a no-op.
> > > + */
> > > +struct printk_buffer *get_printk_buffer(void)
> > > +{
> > 
> > It does not make much sense to use the buffered printk in context
> > where printk_safe() or printk_nmi() is used. I suggest to define
> > something like:
> > 
> > static inline bool in_printk_safe_buffered_context(void)
> > {
> > 	int this_printk_context = this_cpu_read(printk_context);
> > 
> > 	if (this_printk_context && PRINTK_NMI_DIRECT_CONTEXT_MASK)
> > 		return false;
> > 
> > 	if (this_printk_context &&
> > 	    (PRINTK_SAFE_CONTEXT_MASH || PRINTK_NMI_CONTEXT_MASK))
> > 		return true;
> > 
> > 	return true;
> > 
> > and do
> > 
> > 	/*
> > 	 * Messages are already concatenated when temporary
> > 	 * stored into the safe per-CPU buffers.
> > 	 */
> > 	if (in_printk_safe_buffered_context())
> > 		return NULL;
> 
> After this API is accepted, I will try thinking how we can inject caller
> information when printk() is called. That's the origin of this thread.
> 
> To do that, we need to make sure that one line is stored (with caller
> information) whenever printk() is called, which means that we can't count on
> implicit line buffering provided for printk_safe() or printk_nmi() context.

Single time stamp is enough for the entire line. And the time
when the line is flushed is enough.

Are there any other information that would need to get stored, please?


> > > +#ifdef CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS
> > > +	static DECLARE_WORK(work, report_buffer_users);
> > > +#endif
> > > +	long i;
> > > +
> > > +	for (i = 0; i < CONFIG_PRINTK_NUM_LINE_BUFFERS; i++) {
> > > +		if (test_bit(i, printk_buffers_in_use) ||
> > > +		    test_and_set_bit(i, printk_buffers_in_use))
> > 
> > I would use test_and_set_bit_lock() to make it more likely that
> > the barriers are right. Otherwise, there is missing the complementary
> > barrier with clear_bit() in put_printk_buffer().
> 
> Really? I think this is accurate enough.
> 
> get_printk_buffer() tolerates race window, as long as get_printk_buffer()
> does not return same buffer to multiple callers. For example, when
> get_printk_buffer() checks for printk_buffers[1] after
> checking printk_buffers[0] is in use, put_printk_buffer() might set
> printk_buffers[0] as free. get_printk_buffer() will return NULL if
> printk_buffers[0] was the only buffer which became available in this
> race window, but it is not a critical problem.

No, it is not enough. We need a barrier that will make sure that
the previous user read (copied) the entire buffer and that we will
read the right value in ptr->used here. In fact, we need a full barrier.

Also all barriers work only in pairs. You could sometimes omit
one if it is already included in some other call. But this is
not the case here.

I am personally very happy for all predefined _lock()/_unlock()
operations. And I do not try to be more clever that Paul E. McKenney.
There is a high chance that I would be wrong ;-)


> > > +#ifdef CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS
> > > +	/*
> > > +	 * Oops, out of "struct printk_buffer" happened. Fallback to normal
> > > +	 * printk(). You might notice it by partial lines being printed.
> > > +	 *
> > > +	 * If you think that it might be due to missing put_printk_buffer()
> > > +	 * calls, you can enable CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS.
> > > +	 * Then, who is using the buffers will be reported (from workqueue
> > > +	 * context because reporting CONFIG_PRINTK_NUM_LINE_BUFFERS entries
> > > +	 * from atomic context might be too slow). If it does not look like
> > > +	 * missing put_printk_buffer() calls, you might want to increase
> > > +	 * CONFIG_PRINTK_NUM_LINE_BUFFERS.
> > > +	 *
> > > +	 * But if it turns out that allocating "struct printk_buffer" on stack
> > > +	 * or in .bss section or from kzalloc() is more suitable than tuning
> > > +	 * CONFIG_PRINTK_NUM_LINE_BUFFERS, we can update to do so.
> > > +	 */
> > > +	if (!in_nmi() && !cmpxchg(&buffer_users_report_scheduled, 0, 1))
> > > +		queue_work(system_unbound_wq, &work);
> > 
> > We should limit the number of this reports especially when the buffers
> > leaked and are never released again. I would either limit the total
> > count of these reports or I would allow scheduling only when
> > any get_printk_buffer() succeeded in the meantime.
> 
> These reports will have at least 60 seconds interval.

The report is too long. There is a high chance that there will be none
or many occurrences. People will surely see the one instance and would
want to get rid of it (report/send a fix). This is what we want.

On the other hand, this feature is not important enough to mess
the log completely.

The only-once approach is trivial and is a good start. We could always
extend it when needed.


> > Also we should know when the debugging makes sense. Therefore, we should
> > write something even when the debugging is off. Something like:
> > 
> > #else
> >       printk_once("Out of printk buffers. Please, consider enabling with CONFIG_DEBUG_BUFFERED_PRINTK\n");
> > #endif
> 
> I think we can know "when CONFIG_DEBUG_BUFFERED_PRINTK=y makes sense"
> when partial lines are printed frequent enough to suspect permanently
> out of buffers.

People will not notice when the current cont buffer is used as
a fallback. We need to know when buffered_printk() fails
to be able to get rid of the fallback.

       printk_once("Out of printk buffers. Please, consider enabling with CONFIG_DEBUG_BUFFERED_PRINTK\n");

The description of CONFIG_DEBUG_BUFFERED_PRINTK might then contains
tips how to deal with this warning. There might be missing
put_printk_buffer() call. More buffers are needed. Or...


> > > +/**
> > > + * buffered_vprintk - Try to vprintk() in line buffered mode.
> > > + *
> > > + * @ptr:  Pointer to "struct printk_buffer". It can be NULL.
> > > + * @fmt:  printk() format string.
> > > + * @args: va_list structure.
> > > + *
> > > + * Returns the return value of vprintk().
> > > + *
> > > + * Try to store to @ptr first. If it fails, flush @ptr and then try to store to
> > > + * @ptr again. If it still fails, use unbuffered printing.
> > > + */
> > > +int buffered_vprintk(struct printk_buffer *ptr, const char *fmt, va_list args)
> > > +{
> > > +	va_list tmp_args;
> > > +	unsigned short int i;
> > > +	int r;
> > > +
> > > +	if (!ptr)
> > > +		goto unbuffered;
> > > +	for (i = 0; i < 2; i++) {
> > > +		unsigned int pos = ptr->used;
> > > +		char *text = ptr->buf + pos;
> > > +
> > > +		va_copy(tmp_args, args);
> > > +		r = vsnprintf(text, sizeof(ptr->buf) - pos, fmt, tmp_args);
> > > +		va_end(tmp_args);
> > > +		if (r + pos < sizeof(ptr->buf)) {
> > > +			/*
> > > +			 * Eliminate KERN_CONT at this point because we can
> > > +			 * concatenate incomplete lines inside printk_buffer.
> > > +			 */
> > > +			if (r >= 2 && printk_get_level(text) == 'c') {
> > > +				memmove(text, text + 2, r - 2);
> > > +				ptr->used += r - 2;
> > 
> > I believe that KERN_CONT is always passed via @fmt parameter. Therefore
> > we could skip it already in fmt and avoid this memmove. Also note that
> > printk_get_level() is safe even for empty string. The following
> > should work:
> > 
> > 		if (printk_get_level(fmt) == 'c')
> > 			fmt += 2;
> > 
> 
> Don't we need to care about vprintk(fmt, args) fallback path? That is,
>
>    const int fmt_offset = (printk_get_level(fmt) == 'c') ? 2 : 0;
>    r = vsnprintf(text, sizeof(ptr->buf) - pos, fmt + fmt_offset, tmp_args);
> 
> for now?
> 
> But hmm, unconditionally triminng KERN_CONT is OK as long as ptr != NULL because
> "we have to use vprintk(fmt, args) fallback path when ptr != NULL" implies that
> "the output is too long to store into global buffer (if not in safe/nmi context)
> or per-CPU buffers (if in safe/nmi context) from vprintk(), and thus KERN_CONT
> won't work as expected after all" ?

Good point, we need to use the original pointer in the fallback.
Anyway, we still could trim KERN_CONT for the internal vsnprintf()
and get rid of the memmove().


> > > +			} else {
> > > +				ptr->used += r;
> > > +			}
> > > +			/* Flush already completed lines if any. */
> > > +			while (1) {
> > > +				char *cp = memchr(ptr->buf, '\n', ptr->used);
> > > +
> > > +				if (!cp)
> > > +					break;
> > > +				*cp = '\0';
> > > +				printk("%s\n", ptr->buf);
> > > +				i = cp - ptr->buf + 1;
> > > +				ptr->used -= i;
> > > +				memmove(ptr->buf, ptr->buf + i, ptr->used);

One more idea. We do not need to printk more lines separately. Even
the normal printk() does not store the lines separately.

I would just flush the entire buffer when we find '\n' and get rid even
of this 2nd memmove(). Reasonable code will not use '\n' in the middle
of a continuous line. Unreasonable printk() will get what it deserves.


> > > +			}
> > > +			return r;
> > > +		}
> > > +		if (i)
> > > +			break;
> > > +		flush_printk_buffer(ptr);
> > 
> > It makes sense to repeat the cycle only when something was flushed.
> > I would would modify flush_printk_buffer() to return the number of
> > flushed characters.
> 
> OK.
> 
> 		if (i || flush_printk_buffer(ptr) == 0)
> 			break;
> 
> will work.
> 
> > 
> > Also it might be easier to read with goto, I mean to use:
> > 
> > try_again:   instead of for (i = 0; i < 2; i++) {
> > 
> > and then
> > 
> > 	if (flush_printk_buffer(ptr))
> > 		goto try_again;
> 
> Doesn't it disable possible optimization by the compiler (e.g. unroll
> the for() loop if the compiler thinks it worth doing)? Since this "ptr"
> is dedicated to the caller, there is no possibility of executing
> "goto try_again" twice in one buffered_vprintk() call.

This is a slow path. It does not need to be super optimal. The code
readability is more important here. And the cycle hides the logic
unnecessarily.


> > > +	}
> > > + unbuffered:
> > > +	return vprintk(fmt, args);
> > > +}
> > > +
> > > +
> > > +/**
> > > + * put_printk_buffer - Release printk_buffer.
> > > + *
> > > + * @ptr: Pointer to "struct printk_buffer". It can be NULL.
> > > + *
> > > + * Returns nothing.
> > > + *
> > > + * Flush and release @ptr.
> > > + */
> > > +void put_printk_buffer(struct printk_buffer *ptr)
> > > +{
> > > +	long i = ptr - printk_buffers;
> > > +
> > > +	if (!ptr || i < 0 || i >= CONFIG_PRINTK_NUM_LINE_BUFFERS)
> > > +		return;
> > 
> > It would deserve a warning when i is out of bounds.
> 
> The reason I changed to split printk_buffers_in_use out of printk_buffer
> is that some architectures do not support cmpxchg() on "bool", and thus
> we need to assign "int" for in_use flag. If that is not a problem (even
> if we allow use of dynamically allocated or on-stack buffers in future),
> I can bring in_use flag back to printk_buffer. Which choice do you prefer?


I do not have a strong opinion. We could use u8 instead of the
bool to get over the cmpxchg() limitation. But the bitmap looks
good as well. It even makes sense because it is related to both
printk_buffers and printk_buffers_dump arrays.

Anyway, please add a warning when the array is out of bounds.
I would help us to catch eventual bugs. We could always remove
it when we add support for on-stack buffers. Or it is possible that
we would want to distinguish them another way.

Best Regards,
Petr

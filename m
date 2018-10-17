Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FC8ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40392151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40392151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeJQRty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:49:54 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:48318 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQRty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:49:54 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9H9suNK044873;
        Wed, 17 Oct 2018 18:54:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Wed, 17 Oct 2018 18:54:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9H9sp71044747
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 17 Oct 2018 18:54:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v4] printk: Add line-buffered printk() API.
To:     Petr Mladek <pmladek@suse.com>
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
References: <1539405580-4569-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181016140744.dviqn6yvm5brr2gu@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <179a676a-0768-9969-6480-8c4d48af3b67@i-love.sakura.ne.jp>
Date:   Wed, 17 Oct 2018 18:54:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016140744.dviqn6yvm5brr2gu@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek wrote:
> On Sat 2018-10-13 13:39:40, Tetsuo Handa wrote:
> > +struct printk_buffer;
> > +#if defined(CONFIG_PRINTK_LINE_BUFFERED)
> > +struct printk_buffer *get_printk_buffer(void);
> > +void flush_printk_buffer(struct printk_buffer *ptr);
> > +__printf(2, 3)
> > +int buffered_printk(struct printk_buffer *ptr, const char *fmt, ...);
> > +__printf(2, 0)
> > +int buffered_vprintk(struct printk_buffer *ptr, const char *fmt, va_list args);
> > +void put_printk_buffer(struct printk_buffer *ptr);
> > +#else
> > +static inline struct printk_buffer *get_printk_buffer(void)
> > +{
> > +	return NULL;
> > +}
> > +static inline void flush_printk_buffer(struct printk_buffer *ptr)
> > +{
> > +}
> > +#define buffered_printk(ptr, fmt, ...) printk(fmt, ##__VA_ARGS__)
> > +#define buffered_vprintk(ptr, fmt, args) vprintk(fmt, args)
> > +static inline void put_printk_buffer(struct printk_buffer *ptr)
> > +{
> > +}
> > +#endif
> 
> Is there any reason to allow to disable this feature?
> The current cont buffer is always enabled.

We need this dummy version anyway because CONFIG_PRINTK_LINE_BUFFERED
depends on CONFIG_PRINTK=y.

Even with CONFIG_PRINTK=y, until the cont buffer is removed in future, some
embedded users might want to save memory footprint for printk_buffers.

> > @@ -604,6 +604,37 @@ config PRINTK_SAFE_LOG_BUF_SHIFT
> >  		     13 =>   8 KB for each CPU
> >  		     12 =>   4 KB for each CPU
> >  
> > +config PRINTK_LINE_BUFFERED
> > +	bool "Allow line buffered printk()"
> > +	default y
> > +	depends on PRINTK
> > +	help
> > +	  The line buffered printk() tries to buffer printk() output up to '\n'
> > +	  so that incomplete lines won't be mixed when there are multiple
> > +	  threads concurrently calling printk() which does not end with '\n'.
> 
> I would prefer to always enable it.

But embedded users might have very low traffic where buffering is not useful.



> > +config PRINTK_NUM_LINE_BUFFERS
> > +	int "Number of buffers for line buffered printk()"
> > +	range 1 4096
> > +	default 16
> > +	depends on PRINTK_LINE_BUFFERED
> > +	help
> > +	  Specify the number of statically preallocated "struct printk_buffer"
> > +	  for line buffered printk(). You don't need to specify a large number
> > +	  here because "struct printk_buffer" makes difference only when there
> > +	  are multiple threads concurrently calling printk() which does not end
> > +	  with '\n', and line buffered printk() will fallback to normal
> > +	  printk() when out of statically preallocated "struct printk_buffer"
> > +	  happened.
> 
> I would prefer to start with a hard-coded number. There is a sane
> fallback. We need to motivate people to send feedback so that we could
> tune it and eventually remove the fallback (current cont buffer code).

I think that we don't need kernel command line parameters for tuning this number.
But having a kernel config option will help encouraging people to try this API,
for there might be some users who can't try this API without a lot of printk
buffers (syzbot-like systems or huge systems which generate huge traffic).



> > +config PRINTK_REPORT_OUT_OF_LINE_BUFFERS
> > +	bool "Report out of buffers for line buffered printk()"
> > +	default n
> > +	depends on PRINTK_LINE_BUFFERED && STACKTRACE
> > +	help
> > +	  Select this if you want to know who is using statically preallocated
> > +	  "struct printk_buffer" when out of "struct printk_buffer" happened.
> > +
> 
> I like this approach with the configurable debug functionality. It is
> safe and straightforward.

I didn't get what "the configurable debug functionality" means. You mean
enable/disable via debugfs entry? We can later hear from users whether we
want to allow enable/disable at kernel boot command line and/or debugfs entry.



> > +/**
> > + * get_printk_buffer - Try to get printk_buffer.
> > + *
> > + * Returns pointer to "struct printk_buffer" on success, NULL otherwise.
> > + *
> > + * If this function returned "struct printk_buffer", the caller is responsible
> > + * for passing it to put_printk_buffer() so that "struct printk_buffer" can be
> > + * reused in the future.
> > + *
> > + * Even if this function returned NULL, the caller does not need to check for
> > + * NULL, for passing NULL to buffered_printk() simply acts like normal printk()
> > + * and passing NULL to flush_printk_buffer()/put_printk_buffer() is a no-op.
> > + */
> > +struct printk_buffer *get_printk_buffer(void)
> > +{
> 
> It does not make much sense to use the buffered printk in context
> where printk_safe() or printk_nmi() is used. I suggest to define
> something like:
> 
> static inline bool in_printk_safe_buffered_context(void)
> {
> 	int this_printk_context = this_cpu_read(printk_context);
> 
> 	if (this_printk_context && PRINTK_NMI_DIRECT_CONTEXT_MASK)
> 		return false;
> 
> 	if (this_printk_context &&
> 	    (PRINTK_SAFE_CONTEXT_MASH || PRINTK_NMI_CONTEXT_MASK))
> 		return true;
> 
> 	return true;
> 
> and do
> 
> 	/*
> 	 * Messages are already concatenated when temporary
> 	 * stored into the safe per-CPU buffers.
> 	 */
> 	if (in_printk_safe_buffered_context())
> 		return NULL;

After this API is accepted, I will try thinking how we can inject caller
information when printk() is called. That's the origin of this thread.

To do that, we need to make sure that one line is stored (with caller
information) whenever printk() is called, which means that we can't count on
implicit line buffering provided for printk_safe() or printk_nmi() context.

Therefore, this buffering makes sense even if the caller is known to be
already printk_safe() or printk_nmi() context.



> > +#ifdef CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS
> > +	static DECLARE_WORK(work, report_buffer_users);
> > +#endif
> > +	long i;
> > +
> > +	for (i = 0; i < CONFIG_PRINTK_NUM_LINE_BUFFERS; i++) {
> > +		if (test_bit(i, printk_buffers_in_use) ||
> > +		    test_and_set_bit(i, printk_buffers_in_use))
> 
> I would use test_and_set_bit_lock() to make it more likely that
> the barriers are right. Otherwise, there is missing the complementary
> barrier with clear_bit() in put_printk_buffer().

Really? I think this is accurate enough.

get_printk_buffer() tolerates race window, as long as get_printk_buffer()
does not return same buffer to multiple callers. For example, when
get_printk_buffer() checks for printk_buffers[1] after
checking printk_buffers[0] is in use, put_printk_buffer() might set
printk_buffers[0] as free. get_printk_buffer() will return NULL if
printk_buffers[0] was the only buffer which became available in this
race window, but it is not a critical problem.

Likewise, put_printk_buffer() tolerates race window, as long as writing
to printk_buffer[i] completes before printk_buffer[i] becomes visible to
get_printk_buffer().

And since test_and_set_bit() and clear_bit() are atomic, I think that
there is no possibility that

  (1) get_printk_buffer() from CPU0 finds that
      test_bit(0, printk_buffers_in_use) is false.

  (2) get_printk_buffer() from CPU1 finds that
      test_bit(0, printk_buffers_in_use) is false.

  (3) get_printk_buffer() from CPU0 finds that
      test_and_set_bit(0, printk_buffers_in_use) is false.

  (4) get_printk_buffer() from CPU1 finds that
      test_and_set_bit(0, printk_buffers_in_use) is true.

  (5) put_printk_buffer() from CPU0 calls
      clear_bit(0, printk_buffers_in_use).

  (6) get_printk_buffer() from CPU1 leaves
      test_bit(0, printk_buffers_in_use) true due to (4),
      which results in leaking printk_buffers[0].

happens.



> > +#ifdef CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS
> > +	/*
> > +	 * Oops, out of "struct printk_buffer" happened. Fallback to normal
> > +	 * printk(). You might notice it by partial lines being printed.
> > +	 *
> > +	 * If you think that it might be due to missing put_printk_buffer()
> > +	 * calls, you can enable CONFIG_PRINTK_REPORT_OUT_OF_LINE_BUFFERS.
> > +	 * Then, who is using the buffers will be reported (from workqueue
> > +	 * context because reporting CONFIG_PRINTK_NUM_LINE_BUFFERS entries
> > +	 * from atomic context might be too slow). If it does not look like
> > +	 * missing put_printk_buffer() calls, you might want to increase
> > +	 * CONFIG_PRINTK_NUM_LINE_BUFFERS.
> > +	 *
> > +	 * But if it turns out that allocating "struct printk_buffer" on stack
> > +	 * or in .bss section or from kzalloc() is more suitable than tuning
> > +	 * CONFIG_PRINTK_NUM_LINE_BUFFERS, we can update to do so.
> > +	 */
> > +	if (!in_nmi() && !cmpxchg(&buffer_users_report_scheduled, 0, 1))
> > +		queue_work(system_unbound_wq, &work);
> 
> We should limit the number of this reports especially when the buffers
> leaked and are never released again. I would either limit the total
> count of these reports or I would allow scheduling only when
> any get_printk_buffer() succeeded in the meantime.

These reports will have at least 60 seconds interval.

> 
> Also we should know when the debugging makes sense. Therefore, we should
> write something even when the debugging is off. Something like:
> 
> #else
>       printk_once("Out of printk buffers. Please, consider enabling with CONFIG_DEBUG_BUFFERED_PRINTK\n");
> #endif

I think we can know "when CONFIG_DEBUG_BUFFERED_PRINTK=y makes sense"
when partial lines are printed frequent enough to suspect permanently
out of buffers.



> > +/**
> > + * buffered_vprintk - Try to vprintk() in line buffered mode.
> > + *
> > + * @ptr:  Pointer to "struct printk_buffer". It can be NULL.
> > + * @fmt:  printk() format string.
> > + * @args: va_list structure.
> > + *
> > + * Returns the return value of vprintk().
> > + *
> > + * Try to store to @ptr first. If it fails, flush @ptr and then try to store to
> > + * @ptr again. If it still fails, use unbuffered printing.
> > + */
> > +int buffered_vprintk(struct printk_buffer *ptr, const char *fmt, va_list args)
> > +{
> > +	va_list tmp_args;
> > +	unsigned short int i;
> > +	int r;
> > +
> > +	if (!ptr)
> > +		goto unbuffered;
> > +	for (i = 0; i < 2; i++) {
> > +		unsigned int pos = ptr->used;
> > +		char *text = ptr->buf + pos;
> > +
> > +		va_copy(tmp_args, args);
> > +		r = vsnprintf(text, sizeof(ptr->buf) - pos, fmt, tmp_args);
> > +		va_end(tmp_args);
> > +		if (r + pos < sizeof(ptr->buf)) {
> > +			/*
> > +			 * Eliminate KERN_CONT at this point because we can
> > +			 * concatenate incomplete lines inside printk_buffer.
> > +			 */
> > +			if (r >= 2 && printk_get_level(text) == 'c') {
> > +				memmove(text, text + 2, r - 2);
> > +				ptr->used += r - 2;
> 
> I believe that KERN_CONT is always passed via @fmt parameter. Therefore
> we could skip it already in fmt and avoid this memmove. Also note that
> printk_get_level() is safe even for empty string. The following
> should work:
> 
> 		if (printk_get_level(fmt) == 'c')
> 			fmt += 2;
> 

Don't we need to care about vprintk(fmt, args) fallback path? That is,

   const int fmt_offset = (printk_get_level(fmt) == 'c') ? 2 : 0;
   r = vsnprintf(text, sizeof(ptr->buf) - pos, fmt + fmt_offset, tmp_args);

for now?

But hmm, unconditionally triminng KERN_CONT is OK as long as ptr != NULL because
"we have to use vprintk(fmt, args) fallback path when ptr != NULL" implies that
"the output is too long to store into global buffer (if not in safe/nmi context)
or per-CPU buffers (if in safe/nmi context) from vprintk(), and thus KERN_CONT
won't work as expected after all" ?

> > +			} else {
> > +				ptr->used += r;
> > +			}
> > +			/* Flush already completed lines if any. */
> > +			while (1) {
> > +				char *cp = memchr(ptr->buf, '\n', ptr->used);
> > +
> > +				if (!cp)
> > +					break;
> > +				*cp = '\0';
> > +				printk("%s\n", ptr->buf);
> > +				i = cp - ptr->buf + 1;
> > +				ptr->used -= i;
> > +				memmove(ptr->buf, ptr->buf + i, ptr->used);
> > +			}
> > +			return r;
> > +		}
> > +		if (i)
> > +			break;
> > +		flush_printk_buffer(ptr);
> 
> It makes sense to repeat the cycle only when something was flushed.
> I would would modify flush_printk_buffer() to return the number of
> flushed characters.

OK.

		if (i || flush_printk_buffer(ptr) == 0)
			break;

will work.

> 
> Also it might be easier to read with goto, I mean to use:
> 
> try_again:   instead of for (i = 0; i < 2; i++) {
> 
> and then
> 
> 	if (flush_printk_buffer(ptr))
> 		goto try_again;

Doesn't it disable possible optimization by the compiler (e.g. unroll
the for() loop if the compiler thinks it worth doing)? Since this "ptr"
is dedicated to the caller, there is no possibility of executing
"goto try_again" twice in one buffered_vprintk() call.



> > +	}
> > + unbuffered:
> > +	return vprintk(fmt, args);
> > +}
> > +
> > +
> > +/**
> > + * put_printk_buffer - Release printk_buffer.
> > + *
> > + * @ptr: Pointer to "struct printk_buffer". It can be NULL.
> > + *
> > + * Returns nothing.
> > + *
> > + * Flush and release @ptr.
> > + */
> > +void put_printk_buffer(struct printk_buffer *ptr)
> > +{
> > +	long i = ptr - printk_buffers;
> > +
> > +	if (!ptr || i < 0 || i >= CONFIG_PRINTK_NUM_LINE_BUFFERS)
> > +		return;
> 
> It would deserve a warning when i is out of bounds.

The reason I changed to split printk_buffers_in_use out of printk_buffer
is that some architectures do not support cmpxchg() on "bool", and thus
we need to assign "int" for in_use flag. If that is not a problem (even
if we allow use of dynamically allocated or on-stack buffers in future),
I can bring in_use flag back to printk_buffer. Which choice do you prefer?


Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85725C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D762147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfBSNyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:54:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:57994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726180AbfBSNyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:54:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA94EAD8E;
        Tue, 19 Feb 2019 13:54:45 +0000 (UTC)
Date:   Tue, 19 Feb 2019 14:54:42 +0100
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
Subject: Re: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Message-ID: <20190219135442.og3ui76tgzc7t25b@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212143003.48446-9-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-02-12 15:29:46, John Ogness wrote:
> The printk ring buffer provides an NMI-safe interface for writing
> messages to a ring buffer. Using such a buffer for alleviates printk
> callers from the current burdens of disabled preemption while calling
> the console drivers (and possibly printing out many messages that
> another task put into the log buffer).
> 
> Create a ring buffer to be used for storing messages to be
> printed to the consoles.
> 
> Create a dedicated printk kthread to block on the ring buffer
> and call the console drivers for the read messages.

It was already mentioned in the reply to the cover letter.
An offloading console handling to a kthread is very problematic:

  + It reduces the chance that the messages will ever reach
    the console when the system becomes unstable or is dying.
    Note that panic() is the better alternative. The system
    could die without calling panic().

  + There are situations when the kthread will not be usable
    by definition, for example, early boot, suspend, kexec,
    shutdown.

  + It is hard to do a single thread efficient enough. It could
    not have too high priority to avoid staling normal processes.
    It won't be scheduled in time when processed with a higher
    priority produce too many messages.


That said, I think that some offloading would be useful and
even necessary, especially on the real time systems. But we
need to be more conservative, for example:

  + offload only when it takes too long
  + do not offload in emergency situations
  + keep the console owner logic

The above ideas come from the old discussions about introducing
printk kthread. This patchset brings one more idea to push
emergency messages directly to "lockless" consoles.

I could imagine that the default setting will be more
conservative while real time kernel would do a more
aggressive offloading.

Anyway, I would split this entire patchset into two.
The first one would replace the existing main buffer
and per-cpu safe buffers with the lockless one.
The other patchset would try to reduce delays caused
by console handling by introducing lockless consoles,
offloading, ...


> NOTE: The printk_delay is relocated to _after_ the message is
>       printed, where it makes more sense.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index d3d170374ceb..08e079b95652 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -44,6 +44,8 @@
>  #include <linux/irq_work.h>
>  #include <linux/ctype.h>
>  #include <linux/uio.h>
> +#include <linux/kthread.h>
> +#include <linux/printk_ringbuffer.h>
>  #include <linux/sched/clock.h>
>  #include <linux/sched/debug.h>
>  #include <linux/sched/task_stack.h>
> @@ -397,7 +399,12 @@ DEFINE_RAW_SPINLOCK(logbuf_lock);
>  		printk_safe_exit_irqrestore(flags);	\
>  	} while (0)
>  
> +DECLARE_STATIC_PRINTKRB_CPULOCK(printk_cpulock);
> +
>  #ifdef CONFIG_PRINTK
> +/* record buffer */
> +DECLARE_STATIC_PRINTKRB(printk_rb, CONFIG_LOG_BUF_SHIFT, &printk_cpulock);
> +
>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
>  /* the next printk record to read by syslog(READ) or /proc/kmsg */
>  static u64 syslog_seq;
> @@ -744,6 +751,10 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
>  	return p - buf;
>  }
>  
> +#define PRINTK_SPRINT_MAX (LOG_LINE_MAX + PREFIX_MAX)
> +#define PRINTK_RECORD_MAX (sizeof(struct printk_log) + \
> +				CONSOLE_EXT_LOG_MAX + PRINTK_SPRINT_MAX)
> +
>  /* /dev/kmsg - userspace message inject/listen interface */
>  struct devkmsg_user {
>  	u64 seq;
> @@ -1566,6 +1577,34 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
>  	return do_syslog(type, buf, len, SYSLOG_FROM_READER);
>  }
>  
> +static void format_text(struct printk_log *msg, u64 seq,
> +			char *ext_text, size_t *ext_len,
> +			char *text, size_t *len, bool time)
> +{
> +	if (suppress_message_printing(msg->level)) {
> +		/*
> +		 * Skip record that has level above the console
> +		 * loglevel and update each console's local seq.
> +		 */
> +		*len = 0;
> +		*ext_len = 0;
> +		return;
> +	}
> +
> +	*len = msg_print_text(msg, console_msg_format & MSG_FORMAT_SYSLOG,
> +			      time, text, PRINTK_SPRINT_MAX);
> +	if (nr_ext_console_drivers) {
> +		*ext_len = msg_print_ext_header(ext_text, CONSOLE_EXT_LOG_MAX,
> +						msg, seq);
> +		*ext_len += msg_print_ext_body(ext_text + *ext_len,
> +					       CONSOLE_EXT_LOG_MAX - *ext_len,
> +					       log_dict(msg), msg->dict_len,
> +					       log_text(msg), msg->text_len);
> +	} else {
> +		*ext_len = 0;
> +	}
> +}

Please, refactor the existing code instead of cut&pasting. It will
help to check eventual regressions. Also it will help to understand
the evolution when digging in the git history. [*]

> +
>  /*
>   * Special console_lock variants that help to reduce the risk of soft-lockups.
>   * They allow to pass console_lock to another printk() call using a busy wait.
> @@ -2899,6 +2938,72 @@ void wake_up_klogd(void)
>  	preempt_enable();
>  }
>  
> +static int printk_kthread_func(void *data)
> +{
> +	struct prb_iterator iter;
> +	struct printk_log *msg;
> +	size_t ext_len;
> +	char *ext_text;
> +	u64 master_seq;
> +	size_t len;
> +	char *text;
> +	char *buf;
> +	int ret;
> +
> +	ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
> +	text = kmalloc(PRINTK_SPRINT_MAX, GFP_KERNEL);
> +	buf = kmalloc(PRINTK_RECORD_MAX, GFP_KERNEL);
> +	if (!ext_text || !text || !buf)
> +		return -1;

We need to have some fallback solution when the kthread can't
get started properly.


> +
> +	prb_iter_init(&iter, &printk_rb, NULL);
> +
> +	/* the printk kthread never exits */
> +	for (;;) {
> +		ret = prb_iter_wait_next(&iter, buf,
> +					 PRINTK_RECORD_MAX, &master_seq);
> +		if (ret == -ERESTARTSYS) {
> +			continue;
> +		} else if (ret < 0) {
> +			/* iterator invalid, start over */
> +			prb_iter_init(&iter, &printk_rb, NULL);
> +			continue;
> +		}
> +
> +		msg = (struct printk_log *)buf;
> +		format_text(msg, master_seq, ext_text, &ext_len, text,
> +			    &len, printk_time);
> +
> +		console_lock();
> +		if (len > 0 || ext_len > 0) {
> +			call_console_drivers(ext_text, ext_len, text, len);
> +			boot_delay_msec(msg->level);
> +			printk_delay();
> +		}
> +		console_unlock();

This calls console_unlock() that still calls console drivers at this
stage. Note the each patch should keep the kernel buildable and
avoid regressions. Otherwise, it would break bisection. [*]

> +	}
> +
> +	kfree(ext_text);
> +	kfree(text);
> +	kfree(buf);

This will never get called. Well, I think that the kthread
will look different when it is used only as a callback.
We will need some buffers also when the direct console
is handled by the printk() caller directly.


> +	return 0;
> +}
> +

[*] I am not sure whether I should comment this "details" at this
    stage [RFC]. I guess that you worked on this patchset many
    weeks or even months. You tried various approaches,
    refactored the code several times. It is hard to keep
    such a big patchset clean. It might even be wasting of time.


Best Regards,
Petr

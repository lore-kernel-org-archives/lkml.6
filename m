Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeDDRNQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752448AbeDDRNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:13:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9982520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 4 Apr 2018 13:13:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2] tracing, printk: Force no hashing when
 trace_printk() is used
Message-ID: <20180404131310.459e3ef2@gandalf.local.home>
In-Reply-To: <20180404023455.GA493@jagdpanzerIV>
References: <20180403173126.4f79af9e@gandalf.local.home>
        <CAGXu5jLbNtn9CqqCeG3UHmWfC9=qPmhjSLw9vu0Zcyt04XaQ+A@mail.gmail.com>
        <20180403180313.3cc8bb27@gandalf.local.home>
        <20180404023455.GA493@jagdpanzerIV>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018 11:34:55 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

> On (04/03/18 18:03), Steven Rostedt wrote:
> >   
> > > he'd want you to change all the trace_printk()s to %px with
> > > justifications, though.  
> > 
> > What trace_printk()s do you want to change? They are throw away
> > functions. trace_printk() is not something that stays in the kernel.
> > It's added during debugging and then removed before submitting what you
> > are working on upstream.  
> 
> Seems that your patch also can fix up bpf_trace_printk() - it doesn't
> even support %px, only hashed %p, which it passes to __trace_printk().
> 

Crap, that should not work, but it does. I need to update the code to
prevent that from happening. I don't want any user space code to be
able to enable this.

Something like this will even prevent modules from disabling the printk
hash...

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a1d01666dd2..c4af083742b0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2834,6 +2834,14 @@ static int alloc_percpu_trace_buffer(void)
 
 static int buffers_allocated;
 
+/* Will become read only after boot */
+static const bool disable_printk_hash;
+
+static void set_printk_hash(bool val)
+{
+	*(bool *)&disable_printk_hash = val;
+}
+
 void trace_printk_init_buffers(void)
 {
 	if (buffers_allocated)
@@ -2864,9 +2872,11 @@ void trace_printk_init_buffers(void)
 
 	buffers_allocated = 1;
 
-	/* This is a debug kernel, allow pointers to be shown */
-	static_branch_enable(&trace_debug);
-	kptr_restrict = 0;
+	if (disable_printk_hash) {
+		/* This is a debug kernel, allow pointers to be shown */
+		static_branch_enable(&trace_debug);
+		kptr_restrict = 0;
+	}
 
 	/*
 	 * trace_printk_init_buffers() can be called by modules.
@@ -8456,10 +8466,13 @@ __init static int tracer_alloc_buffers(void)
 	if (!alloc_cpumask_var(&global_trace.tracing_cpumask, GFP_KERNEL))
 		goto out_free_buffer_mask;
 
+	/* Only trace_printk() in the core kernel can disable hashing */
+	set_printk_hash(true);
 	/* Only allocate trace_printk buffers if a trace_printk exists */
 	if (__stop___trace_bprintk_fmt != __start___trace_bprintk_fmt)
 		/* Must be called before global_trace.buffer is allocated */
 		trace_printk_init_buffers();
+	set_printk_hash(false);
 
 	/* To save memory, keep the ring buffer size to its minimum */
 	if (ring_buffer_expanded)



-- Steve

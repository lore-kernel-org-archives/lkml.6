Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753391AbeDCVGR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 17:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752495AbeDCVGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 17:06:16 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B08220852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 3 Apr 2018 17:06:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC][PATCH] tracing, printk: Force no hashing when
 trace_printk() is used
Message-ID: <20180403170612.7b11fc41@gandalf.local.home>
In-Reply-To: <CAGXu5j+g6nbDz+gjAxZTSf1004J=naAf7b9dPTE0q8+7UtXCLw@mail.gmail.com>
References: <20180403154102.150b1be0@gandalf.local.home>
        <CAGXu5j+g6nbDz+gjAxZTSf1004J=naAf7b9dPTE0q8+7UtXCLw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2018 13:07:58 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Tue, Apr 3, 2018 at 12:41 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > Both trace_debug is set and kptr_restrict is set to zero in the same
> > code that produces the above banner. This will allow trace_printk() to
> > not be affected by security code, as trace_printk() should never be run
> > on a machine that needs security of this kind.  
> 
> While I think it'd be nice to have a boot-time knob for this (a debate
> that was unsuccessful in earlier threads), I remain skeptical of
> having a _runtime_ knob for this, as then it becomes a target (and
> yes, there are plenty of targets, but why add another).
> 
> If this was __ro_after_init, maybe that'd be nicer. CONFIG_TRACING=y

Well, then of course this would need a check to keep modules from
setting it. But I think I know of a nice alternative.


> is used everywhere, so this is really just the whole knob debate over
> again. Instead, I've been following Linus's distillation of %p usage
> in the kernel:
> 
> http://lkml.kernel.org/r/CA+55aFwQEd_d40g4mUCSsVRZzrFPUJt74vc6PPpb675hYNXcKw@mail.gmail.com

Remember, this isn't a printk() that hangs around for production. I was
debugging code that modified pointers, and I wanted to make sure that
the pointer arithmetic was correct (it wasn't), and randomizing the
output made my prints useless.

If you are concerned about attack surface, I could make it a bit more
difficult to tweak by malicious software. What about the patch below?
It would be much more difficult to modify this knob from an attack
vector.

-- Steve

diff --git a/include/linux/printk.h b/include/linux/printk.h
index e9b603ee9953..b624493b3991 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -278,6 +278,7 @@ static inline void printk_safe_flush_on_panic(void)
 #endif
 
 extern int kptr_restrict;
+extern struct static_key trace_debug;
 
 extern asmlinkage void dump_stack(void) __cold;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0f47e653ffd8..6c151d00848b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2864,6 +2864,10 @@ void trace_printk_init_buffers(void)
 
 	buffers_allocated = 1;
 
+	/* This is a debug kernel, allow pointers to be shown */
+	static_key_enable(&trace_debug);
+	kptr_restrict = 0;
+
 	/*
 	 * trace_printk_init_buffers() can be called by modules.
 	 * If that happens, then we need to start cmdline recording
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 89f8a4a4b770..c3d8eafecb39 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1345,6 +1345,7 @@ char *uuid_string(char *buf, char *end, const u8 *addr,
 }
 
 int kptr_restrict __read_mostly;
+struct static_key trace_debug = STATIC_KEY_INIT_FALSE;
 
 static noinline_for_stack
 char *restricted_pointer(char *buf, char *end, const void *ptr,
@@ -1962,6 +1963,10 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return pointer_string(buf, end, ptr, spec);
 	}
 
+	/* When the kernel is in debugging mode, show all pointers */
+	if (static_key_false(&trace_debug))
+		return restricted_pointer(buf, end, ptr, spec);
+
 	/* default is to _not_ leak addresses, hash before printing */
 	return ptr_to_id(buf, end, ptr, spec);
 }

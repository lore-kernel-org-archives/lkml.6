Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeDDVFW convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 17:05:22 -0400
Received: from smtprelay0188.hostedemail.com ([216.40.44.188]:35882 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751749AbeDDVFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 17:05:21 -0400
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,rostedt@goodmis.org,:::::,RULES_HIT:41:152:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1513:1515:1516:1518:1521:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2896:3138:3139:3140:3141:3142:3353:3865:3867:3868:3870:3871:3872:3873:4321:4605:5007:6671:7652:7875:7903:9040:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12438:12555:12895:12986:13007:13255:14181:14721:21080:21451:21611:21627:30012:30026:30051:30054:30069:30090,0,RBL:error,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: cart55_393fc02d6b353
X-Filterd-Recvd-Size: 3542
Date: Wed, 04 Apr 2018 16:56:23 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20180404205102.20816-1-chris@chris-wilson.co.uk>
References: <20180330150132.16903-1-chris@chris-wilson.co.uk> <20180404205102.20816-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3] trace: Default to using trace_global_clock if sched_clock is unstable
To: Chris Wilson <chris@chris-wilson.co.uk>, linux-kernel@vger.kernel.org
CC: intel-gfx@lists.freedesktop.org
From: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <7D320425-063C-4C54-BAD2-8843ADCD8D6A@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you add a patch on top. I already added your patch to my tree.

See branch ftrace/core
git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

-- Steve


On April 4, 2018 4:51:02 PM EDT, Chris Wilson <chris@chris-wilson.co.uk> wrote:
>Across suspend, we may see a very large drift in timestamps if the
>sched
>clock is unstable, prompting the global trace's ringbuffer code to warn
>and suggest switching to the global clock. Preempt this request by
>detecting when the sched clock is unstable (determined during
>late_initcall) and automatically switching the default clock over to
>trace_global_clock.
>
>This should prevent requiring user interaction to resolve warnings such
>as:
>
>Delta way too big! 18446743856563626466 ts=18446744054496180323 write
>stamp = 197932553857
>    If you just came from a suspend/resume,
>    please switch to the trace global clock:
>    echo global > /sys/kernel/debug/tracing/trace_clock
>
>Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
>Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
>---
>v2: Tell the user what's happening and what they can do to correct it.
>v3: Restore the correct logic to switch only if the default trace clock
>(no override) is found to be *not* stable.
>---
> kernel/trace/trace.c | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
>
>diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>index 13baf85b27d8..a1810b053f65 100644
>--- a/kernel/trace/trace.c
>+++ b/kernel/trace/trace.c
>@@ -41,6 +41,7 @@
> #include <linux/nmi.h>
> #include <linux/fs.h>
> #include <linux/trace.h>
>+#include <linux/sched/clock.h>
> #include <linux/sched/rt.h>
> 
> #include "trace.h"
>@@ -8505,3 +8506,21 @@ __init static int clear_boot_tracer(void)
> 
> fs_initcall(tracer_init_tracefs);
> late_initcall_sync(clear_boot_tracer);
>+
>+#ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
>+__init static int tracing_set_default_clock(void)
>+{
>+	/* sched_clock_stable() is determined in late_initcall */
>+	if (!trace_boot_clock && !sched_clock_stable()) {
>+		printk(KERN_WARNING
>+		       "Unstable clock detected, switching default tracing clock to
>\"global\"\n"
>+		       "If you want to keep using the local clock, then add:\n"
>+		       "  \"trace_clock=local\"\n"
>+		       "on the kernel command line\n");
>+		tracing_set_clock(&global_trace, "global");
>+	}
>+
>+	return 0;
>+}
>+late_initcall_sync(tracing_set_default_clock);
>+#endif

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.

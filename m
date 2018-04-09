Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeDILNw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:13:52 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:25931 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeDILNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:13:50 -0400
To: dvyukov@google.com
Cc: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, msb@chromium.org, tglx@linutronix.de,
        vegard.nossum@oracle.com
Subject: Re: [PATCH v2] locking/hung_task: Show all hung tasks before panic
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <201804072131.AEF86988.OFOQLJMVFFtOSH@I-love.SAKURA.ne.jp>
        <20180407153937.GR4082@hirez.programming.kicks-ass.net>
        <CACT4Y+Z6_P9mj2TEE3mtCez1je7dbviftM0rPcgsmQ-yFYYmBg@mail.gmail.com>
        <201804080124.GHG87587.SVFOOQFLOHMJtF@I-love.SAKURA.ne.jp>
        <CACT4Y+ZA_zYGxxj9oN8m5ApSbKSSS-mf2DXpHT3Ab3MdiEKKgQ@mail.gmail.com>
In-Reply-To: <CACT4Y+ZA_zYGxxj9oN8m5ApSbKSSS-mf2DXpHT3Ab3MdiEKKgQ@mail.gmail.com>
Message-Id: <201804092013.IIF48452.FMOLFHVStOFJQO@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Mon, 9 Apr 2018 20:13:47 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Vyukov wrote:
> On Sat, Apr 7, 2018 at 6:24 PM, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > Dmitry Vyukov wrote:
> >> On Sat, Apr 7, 2018 at 5:39 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> >> > On Sat, Apr 07, 2018 at 09:31:19PM +0900, Tetsuo Handa wrote:
> >> >> are for replacing debug_show_all_locks() in check_hung_task() for cases like
> >> >> https://syzkaller.appspot.com/bug?id=26aa22915f5e3b7ca2cfca76a939f12c25d624db
> >> >> because we are interested in only threads holding locks.
> >> >>
> >> >> SysRq-t is too much but SysRq-w is useless for killable/interruptible threads...
> >> >
> >> > Or use a script to process the sysrq-t output? I mean, we can add all
> >> > sorts, but where does it end?
> >
> > Maybe allow khungtaskd to call call_usermode_helper() to run arbitrary operations
> > instead of just calling panic()?
> 
> This would probably work for syzbot too.

Yes, it should work in many cases. Something like below...

----------
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -18,6 +18,7 @@
 #include <linux/utsname.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
+#include <linux/kmod.h>
 
 #include <trace/events/sched.h>
 
@@ -44,6 +45,7 @@
 
 static int __read_mostly did_panic;
 static bool hung_task_show_lock;
+static bool hung_task_call_panic;
 
 static struct task_struct *watchdog_task;
 
@@ -127,10 +129,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	touch_nmi_watchdog();
 
 	if (sysctl_hung_task_panic) {
-		if (hung_task_show_lock)
-			debug_show_all_locks();
-		trigger_all_cpu_backtrace();
-		panic("hung_task: blocked tasks");
+		hung_task_show_lock = true;
+		hung_task_call_panic = true;
 	}
 }
 
@@ -193,6 +193,23 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 	rcu_read_unlock();
 	if (hung_task_show_lock)
 		debug_show_all_locks();
+	if (hung_task_call_panic) {
+		char *argv[2];
+		char *envp[3];
+
+		trigger_all_cpu_backtrace();
+
+		argv[0] = (char *) "/sbin/khungtaskd_panic";
+		argv[1] = NULL;
+		envp[0] = "HOME=/";
+		envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+		envp[2] = NULL;
+		pr_emerg("Calling %s with 60 seconds timeout.\n",
+			 argv[0]);
+		call_usermodehelper(argv[0], argv, envp, UMH_NO_WAIT);
+		schedule_timeout_interruptible(60 * HZ);
+		panic("hung_task: blocked tasks");
+	}
 }
 
 static long hung_timeout_jiffies(unsigned long last_checked,
----------

What is unfortunate is that above won't work for "panic due to stall" cases.
If available, kdump is preferable...

> 
> >> Good question.
> >> We are talking about few dozen more stacks, right?
> >>
> >> Not all kernel bugs are well reproducible, so it's not always possible
> >> to go back and hit sysrq-t. And this come up in the context of syzbot,
> >> which is an automated system. It reported a bunch of hangs and most of
> >> them are real bugs, but not all of them are easily actionable.
> >> Can it be a config or a command line argument, which will make syzbot
> >> capture more useful context for each such hang?
> >>
> >
> > It will be nice if syzbot testing is done with kdump configured, and the
> > result of automated scripting on vmcore (such as "foreach bt -s -l") is
> > available.
> 
> kdump's popped up several times already
> (https://github.com/google/syzkaller/issues/491). But this will
> require some non-trivial amount of work to pipe it through the whole
> system (starting from investigation/testing, second kernel to storing
> them and exposing).
> 

We can use different kernels for testing and kdump, can't we? Then,
I think it is not difficult to load kernel for kdump from local disk.
And kdump (kexec-tools) already supports dumping via ssh. Then, is there
still non-trivial amount of work? Just a remote server for temporarily
holding kernel for testing and run scripted analyzing commands ?

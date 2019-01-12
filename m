Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6247C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3202177B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 02:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547259994;
	bh=aXBhIe8CTbdSb328zSKd7/uJOwq0P+xumiV61OdipRI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rzq7nNorRn8NCXSCxVI5BVhudrhHGlotHDqNGt9/84qr3tDe716ai+ediUejClj+N
	 JBuNzfFmVvuBvsFFFzS0gAWECmP3kldUPuq6ADa0n4ab3uD1Z56x6RR/FIqL87Wtbw
	 P55LAuINI4SbWxI7jfiVYfZpnS6YS65fxnFiits4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfALC0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 21:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:47552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfALC0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 21:26:04 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7414420872;
        Sat, 12 Jan 2019 02:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547259963;
        bh=aXBhIe8CTbdSb328zSKd7/uJOwq0P+xumiV61OdipRI=;
        h=From:To:Cc:Subject:Date:From;
        b=KtbQvA2CEO1JNN2NPyOj34P5s6S8dPQ8zT6VBqGCJ0ULgth0jDOnio/OgZSfPqEVB
         GTU2+6fjRJ6Qd8HUVEE4CFdI4TUzWVkR0x3P2QUTk6VMLpMIxKOhq1A8qpRADU9bVD
         kETCCjM8eh4MhDN3I4QA6PsIc1Y/Xjhd5AAhN8wc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 0/9] kprobes: Fix and improve blacklist symbols
Date:   Sat, 12 Jan 2019 11:25:40 +0900
Message-Id: <154725993986.18060.2759150647140353514.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the v2 series of kprobes blacklist bugfix and improvements mainly
on x86 (since I started testing on qemu-x86).

>From v1, I just removed stable-ml from Cc (but tagged [1/9]) and added
Steve's Ack.

This has been started from discussion about KPROBE_ENENTS_ON_NOTRACE
configuration. I tried to find notrace functions which can cause kernel
crash with kprobes using following script.

====
#!/bin/sh

i=0;
cat notrace_functions | while read f ; do
  if echo p:event$i $f >> /sys/kernel/debug/tracing/kprobe_events; then
     echo "Probing on $f"
     echo 1 > /sys/kernel/debug/tracing/events/kprobes/event$i/enable 
  fi
  i=$((i+1))
done
====

And I found several functions which must be blacklisted.
 - optprobe template code, which is just a template code and
   never be executed. Moreover, since it can be copied and
   reused, if we probe it, it modifies the template code and
   can cause a crash. ([1/9][2/9])
 - functions which is called before kprobe_int3_handler()
   handles kprobes. This can cause a breakpoint recursion. ([3/9])
 - IRQ entry text, which should not be probed since register/pagetable
   status has not been stable at that point. ([4/9])
 - Suffixed symbols, like .constprop, .part etc. Those suffixed
   symbols never be blacklisted even if the non-suffixed version
   has been blacklisted. ([5/9])
 - hardirq tracer also works before int3 handling. ([6/9])
 - preempt_check debug function also is involved in int3 handling.
   ([7/9])
 - RCU debug routine is also called before kprobe_int3_handler().
   ([8/9])
 - Some lockdep functions are also involved in int3 handling.
   ([9/9])

Of course there still may be some functions which can be called
by configuration change, I'll continue to test it.

Thank you,

---

Masami Hiramatsu (9):
      x86/kprobes: Prohibit probing on optprobe template code
      x86/kprobes: Move trampoline code into RODATA
      x86/kprobes: Prohibit probing on functions before kprobe_int3_handler()
      x86/kprobes: Prohibit probing on IRQ handlers directly
      kprobes: Search non-suffixed symbol in blacklist
      kprobes: Prohibit probing on hardirq tracers
      kprobes: Prohibit probing on preempt_check debug functions
      kprobes: Prohibit probing on RCU debug routine
      kprobes: Prohibit probing on lockdep functions


 arch/x86/kernel/alternative.c   |    3 ++-
 arch/x86/kernel/ftrace.c        |    3 ++-
 arch/x86/kernel/kprobes/core.c  |    7 +++++++
 arch/x86/kernel/kprobes/opt.c   |    4 ++--
 arch/x86/kernel/traps.c         |    1 +
 kernel/kprobes.c                |   21 ++++++++++++++++++++-
 kernel/locking/lockdep.c        |    7 ++++++-
 kernel/rcu/tree.c               |    2 ++
 kernel/rcu/update.c             |    2 ++
 kernel/trace/trace_irqsoff.c    |    9 +++++++--
 kernel/trace/trace_preemptirq.c |    5 +++++
 lib/smp_processor_id.c          |    7 +++++--
 12 files changed, 61 insertions(+), 10 deletions(-)

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E218C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B2A21738
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547088868;
	bh=u6XLsqhkf6vnPqTUPogavdsdaaILzvIZ7JYPZPiqXBA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ns6tzyK11A+DgPbpAbS20rRs6hT7nzbewY6gcS24Tti6E7wiu+CAsgwdrBIn9Vdoq
	 9mdwN/bUaV9ZlH34yEyhdXeJt+nw3TtmI4BX4ryEnPliIPQBY65FicFMuj8BlYERj0
	 iwFlzYviEFtZDjUEGl5KC70Sz3Vh0lr5c4gNhK1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfAJCy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:54:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbfAJCy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:54:26 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A2DD20665;
        Thu, 10 Jan 2019 02:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547088865;
        bh=u6XLsqhkf6vnPqTUPogavdsdaaILzvIZ7JYPZPiqXBA=;
        h=From:To:Cc:Subject:Date:From;
        b=Qza4MITgmZkUx1HCUeuIh8bBcM65fUAk2thdottgVHKl0pX6Yg5wY3/5AQAoeTjqW
         xRqWXOaX+FAcN/UkvUQLwqiVIZEHsRCYCIUJpWngm+y9poZMZpnhTjHhDjvU6fSQuh
         k6LqthsBBFtAnZPHCNt6OG1KHkZTS4GAJNuCH8Zg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: [PATCH 0/9] kprobes: Fix and improve blacklist symbols
Date:   Thu, 10 Jan 2019 11:54:01 +0900
Message-Id: <154708884117.6325.4454464467156828009.stgit@devbox>
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

Here is a series of kprobes blacklist bugfix and improvements mainly
on x86 (since I started testing on qemu-x86).

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

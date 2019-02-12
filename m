Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AADC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8E6217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549987876;
	bh=Hse9D6TRu4tRlMtiyVJ25CZGZL9zcOq2bE44q7kAaRs=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SdaXKMusf4xX5DejUM4JrVmdBUqPeLsio24sr29S19Tj5sDdyMR//bGdxOCPovdzi
	 JKXjU3jaVw+2nAyupzRBR/HY8KhHTA8GrGpjeTg2atLXwEvFycYn1PptSwTbBGxaBd
	 mgDan4Wo+h6H4+x7W6kvEJggCxzigBn6UScWPGuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfBLQLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:11:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730461AbfBLQLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:11:14 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B349217D9;
        Tue, 12 Feb 2019 16:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549987873;
        bh=Hse9D6TRu4tRlMtiyVJ25CZGZL9zcOq2bE44q7kAaRs=;
        h=From:To:Cc:Subject:Date:From;
        b=X3CQVhTCxfhpW4+JZ1Z3wg/aLug0vA8z8wUfAeizaTLBbJ9OXgTU9no4IG/nskf13
         2rAmb6nd9CYVSOuheXZlWXsxCoHkXO4WKFO1z77Z5chC20dEKn00Xbn8r47VXPy64U
         dNYlOE7ZjRxC6UdLqbeVsJNe1ubXJvybkXjJvseQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -tip v3 00/10] kprobes: Fix and improve blacklist symbols
Date:   Wed, 13 Feb 2019 01:10:50 +0900
Message-Id: <154998785011.31052.1475728497912659748.stgit@devbox>
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

Here is the v3 series of kprobes blacklist bugfix and improvements mainly
on x86 (since I started testing on qemu-x86).

This version is just rebased on top of -tip master branch and
add bsearch nokprobe patch by Andrea (Thanks!)

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
   can cause a crash. ([1/10][2/10])
 - functions which is called before kprobe_int3_handler()
   handles kprobes. This can cause a breakpoint recursion. ([3/10])
 - IRQ entry text, which should not be probed since register/pagetable
   status has not been stable at that point. ([4/10])
 - Suffixed symbols, like .constprop, .part etc. Those suffixed
   symbols never be blacklisted even if the non-suffixed version
   has been blacklisted. ([5/10])
 - hardirq tracer also works before int3 handling. ([6/10])
 - preempt_check debug function also is involved in int3 handling.
   ([7/10])
 - RCU debug routine is also called before kprobe_int3_handler().
   ([8/10])
 - Some lockdep functions are also involved in int3 handling.
   ([9/10])
 - bsearch() is involved in int3 handling because of ftrace
   is using it. ([10/10])

Of course there still may be some functions which can be called
by configuration change, I'll continue to test it.

Thank you,

---

Andrea Righi (1):
      kprobes: Prohibit probing on bsearch()

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
 lib/bsearch.c                   |    2 ++
 lib/smp_processor_id.c          |    7 +++++--
 13 files changed, 63 insertions(+), 10 deletions(-)

-- 
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

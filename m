Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23848C10F0B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72C4206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550940589;
	bh=yaD7xeyHJZfucXq8VOqJajNWMvdZJQvVXFLobCC1MVQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xfCnIDC99bTs7Q7y72Qz5yKw4qoXWlfEZP2jWB+rlzsN7k9Aht2V0qMW5FiwbXU7A
	 goLpqudus6mJuWEjo389zLKzt2HuAOijr/vRejHnS+zvRYI6lgom69X+x0hx+andvS
	 rIShJ4GGJRon+JRnewGUfODUKQRMm+/8X0J91c8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfBWQtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 11:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfBWQtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 11:49:47 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E9D6206A3;
        Sat, 23 Feb 2019 16:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550940586;
        bh=yaD7xeyHJZfucXq8VOqJajNWMvdZJQvVXFLobCC1MVQ=;
        h=From:To:Cc:Subject:Date:From;
        b=gV32V3X2jsMfrVr+MuZT/TbJQJHBVeICRfFWS1rcFkEBlv/vrBmqn8VndUMkJGniZ
         Wwm2jCvgpnIPudiLdX/mgWSLZuEMbJ2WiMu+IQ+7WcNKekNoZNhb5JPyW8RhyNZY0Y
         MWWXMsR89KNizdlqHdeK8SRGdx32Zz8NX/tqjnRI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: [PATCH -tip v3 0/3] kprobes: Fix kretprobe issues
Date:   Sun, 24 Feb 2019 01:49:22 +0900
Message-Id: <155094056180.6137.4208463927265038015.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Here is v3 series of fixing kretprobe incorrect stacking order patches.

I found that this series did not merged yet, so I just ported it
on the tip tree.

In this version, I just added Steve's Ack and sort tags.
Please push it as an urgent fix.

(1) kprobe incorrct stacking order problem

On recent talk with Andrea, I started more precise investigation on
the kernel panic with kretprobes on notrace functions, which Francis
had been reported last year ( https://lkml.org/lkml/2017/7/14/466 ).

See the investigation details in 
https://lkml.kernel.org/r/154686789378.15479.2886543882215785247.stgit@devbox

When we put a kretprobe on ftrace_ops_assist_func() and put another
kretprobe on probed-function, below happens

<caller>
 -><probed-function>
   ->fentry
    ->ftrace_ops_assist_func()
     ->int3
      ->kprobe_int3_handler()
      ...->pre_handler_kretprobe()
           push the return address (*fentry*) of ftrace_ops_assist_func() to
           top of the kretprobe list and replace it with kretprobe_trampoline.
      <-kprobe_int3_handler()
     <-(int3)
     ->kprobe_ftrace_handler()
      ...->pre_handler_kretprobe()
           push the return address (caller) of probed-function to top of the
           kretprobe list and replace it with kretprobe_trampoline.
     <-(kprobe_ftrace_handler())
    <-(ftrace_ops_assist_func())
    [kretprobe_trampoline]
     ->tampoline_handler()
       pop the return address (caller) from top of the kretprobe list
     <-(trampoline_handler())
    <caller>
    [run caller with incorrect stack information]
   <-(<caller>)
  !!KERNEL PANIC!!

Therefore, this kernel panic happens only when we put 2 k*ret*probes on
ftrace_ops_assist_func() and other functions. If we put kprobes, it
doesn't cause any issue, since it doesn't change the return address.

To fix (or just avoid) this issue, we can introduce a frame pointer
verification to skip wrong order entries. And I also would like to
blacklist those functions because those are part of ftrace-based 
kprobe handling routine.

(2) kretprobe trampoline recursion problem

This was found by Andrea in the previous thread
https://lkml.kernel.org/r/20190107183444.GA5966@xps-13

----
 echo "r:event_1 __fdget" >> kprobe_events
 echo "r:event_2 _raw_spin_lock_irqsave" >> kprobe_events
 echo 1 > events/kprobes/enable
 [DEADLOCK]
----

Because kretprobe trampoline_handler uses spinlock for protecting
hash table, if we probe the spinlock itself, it causes deadlock.
Thank you Andrea and Steve for discovering this root cause!!

This bug has been introduced with the asm-coded trampoline
code, since previously it used another kprobe for hooking
the function return placeholder (which only has a nop) and
trampoline handler was called from that kprobe.

To fix this bug, I introduced a dummy kprobe and set it in
current_kprobe as we did in old days.

Thank you,

---

Masami Hiramatsu (3):
      x86/kprobes: Verify stack frame on kretprobe
      kprobes: Mark ftrace mcount handler functions nokprobe
      x86/kprobes: Fix to avoid kretprobe recursion


 arch/x86/kernel/kprobes/core.c |   48 ++++++++++++++++++++++++++++++++++++++--
 include/linux/kprobes.h        |    1 +
 kernel/trace/ftrace.c          |    6 ++++-
 3 files changed, 52 insertions(+), 3 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

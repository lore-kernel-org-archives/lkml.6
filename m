Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8556BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D38D2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfB0NdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:33:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730169AbfB0NdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:33:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7DD430BD2B6;
        Wed, 27 Feb 2019 13:33:12 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id A049561369;
        Wed, 27 Feb 2019 13:33:10 +0000 (UTC)
Date:   Wed, 27 Feb 2019 14:33:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Srinivasa D S <srinivasa@in.ibm.com>,
        Hien Nguyen <hien@us.ibm.com>, David Valin <dvalin@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, stable@vger.kernel.org
Subject: Re: [RFC] kprobes: Fix locking in recycle_rp_inst
Message-ID: <20190227133309.GL18893@krava>
References: <20190226161036.10680-1-jolsa@kernel.org>
 <20190227173846.397e2a66da37e0385d3fc383@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227173846.397e2a66da37e0385d3fc383@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 27 Feb 2019 13:33:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 05:38:46PM +0900, Masami Hiramatsu wrote:

SNIP

> > When we switch it to raw_spin_lock_irqsave the return probe
> > on _raw_spin_lock starts working.
> 
> Yes, there can be a race between probes and probe on irq handler.
> 
> kretprobe_hash_lock()/kretprobe_hash_unlock() are safe because
> those disables irqs. Only recycle_rp_inst() has this problem.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> And this is one of the oldest bug in kprobe.
> 
> commit ef53d9c5e4da ("kprobes: improve kretprobe scalability with hashed locking")
> 
> introduced the spin_lock(&rp->lock) in recycle_rp_inst() but forgot to disable irqs.
> And 
> 
> commit c9becf58d935 ("[PATCH] kretprobe: kretprobe-booster")

ok, so I'll add:

Fixes: c9becf58d935 ("[PATCH] kretprobe: kretprobe-booster")

> 
> introduced assembly-based trampoline which didn't disable irq.
> 
> Could you add Cc:stable to this patch too?

sure, attaching patch with updated changelog

thanks,
jirka


---
We can call recycle_rp_inst from both task and irq contexts,
so we should irqsave/irqrestore locking functions.

I wasn't able to hit this particular lockup, but I found it
while checking on why return probe on _raw_spin_lock locks
the system, reported by David by using bpftrace on simple
script, like:

  kprobe:_raw_spin_lock
  {
      @time[tid] = nsecs;
      @symb[tid] = arg0;
  }

  kretprobe:_raw_spin_lock
      / @time[tid] /
  {
      delete(@time[tid]);
      delete(@symb[tid]);
  }

or by perf tool:

  # perf probe -a _raw_spin_lock:%return
  # perf record -e probe:_raw_spin_lock__return -a

The thing is that the _raw_spin_lock call in recycle_rp_inst,
is the only one that return probe code paths call and it will
trigger another kprobe instance while already processing one
and lock up on kretprobe_table_lock lock:

  #12 [ffff99c337403d28] queued_spin_lock_slowpath at ffffffff9712693b
  #13 [ffff99c337403d28] _raw_spin_lock_irqsave at ffffffff9794c100
  #14 [ffff99c337403d38] pre_handler_kretprobe at ffffffff9719435c
  #15 [ffff99c337403d68] kprobe_ftrace_handler at ffffffff97059f12
  #16 [ffff99c337403d98] ftrace_ops_assist_func at ffffffff971a0421
  #17 [ffff99c337403dd8] handle_edge_irq at ffffffff97139f55
  #18 [ffff99c337403df0] handle_edge_irq at ffffffff97139f55
  #19 [ffff99c337403e58] _raw_spin_lock at ffffffff9794c111
  #20 [ffff99c337403e88] _raw_spin_lock at ffffffff9794c115
  #21 [ffff99c337403ea8] trampoline_handler at ffffffff97058a8f
  #22 [ffff99c337403f00] kretprobe_trampoline at ffffffff970586d5
  #23 [ffff99c337403fb0] handle_irq at ffffffff97027b1f
  #24 [ffff99c337403fc0] do_IRQ at ffffffff97a01bc9
  --- <IRQ stack> ---
  #25 [ffffa5c3c1f9fb38] ret_from_intr at ffffffff97a0098f
      [exception RIP: smp_call_function_many+460]
      RIP: ffffffff9716685c  RSP: ffffa5c3c1f9fbe0  RFLAGS: 00000202
      RAX: 0000000000000005  RBX: ffff99c337421c80  RCX: ffff99c337566260
      RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffff99c337421c88
      RBP: ffff99c337421c88   R8: 0000000000000001   R9: ffffffff98352940
      R10: ffff99c33703c910  R11: ffffffff9794c110  R12: ffffffff97055680
      R13: 0000000000000000  R14: 0000000000000001  R15: 0000000000000040
      ORIG_RAX: ffffffffffffffde  CS: 0010  SS: 0018
  #26 [ffffa5c3c1f9fc20] on_each_cpu at ffffffff97166918
  #27 [ffffa5c3c1f9fc40] ftrace_replace_code at ffffffff97055a34
  #28 [ffffa5c3c1f9fc88] ftrace_modify_all_code at ffffffff971a3552
  #29 [ffffa5c3c1f9fca8] arch_ftrace_update_code at ffffffff97055a6c
  #30 [ffffa5c3c1f9fcb0] ftrace_run_update_code at ffffffff971a3683
  #31 [ffffa5c3c1f9fcc0] ftrace_startup at ffffffff971a6638
  #32 [ffffa5c3c1f9fce8] register_ftrace_function at ffffffff971a66a0

When we switch it to raw_spin_lock_irqsave the return probe
on _raw_spin_lock starts working.

Fixes: c9becf58d935 ("[PATCH] kretprobe: kretprobe-booster")
Cc: stable@vger.kernel.org
Reported-by: David Valin <dvalin@redhat.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/kprobes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index c83e54727131..c82056b354cc 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1154,9 +1154,11 @@ void recycle_rp_inst(struct kretprobe_instance *ri,
 	hlist_del(&ri->hlist);
 	INIT_HLIST_NODE(&ri->hlist);
 	if (likely(rp)) {
-		raw_spin_lock(&rp->lock);
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&rp->lock, flags);
 		hlist_add_head(&ri->hlist, &rp->free_instances);
-		raw_spin_unlock(&rp->lock);
+		raw_spin_unlock_irqrestore(&rp->lock, flags);
 	} else
 		/* Unregistering */
 		hlist_add_head(&ri->hlist, head);
-- 
2.17.2


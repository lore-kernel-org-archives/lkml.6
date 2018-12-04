Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4F0C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CE7214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKMeJk5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CE7214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeLDK6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbeLDK6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:58:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2953A214DA;
        Tue,  4 Dec 2018 10:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921114;
        bh=THxNsdnuD01nV1jyaiy6sPQjeSd1IOdeIQ3xKrNFvro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKMeJk5z4k+h2mGaeVE2MHWWjqoxanIubLA1966DEAOkJeq0AM288AsWOTS1e97vI
         vUGebcP0D2I94FHWx/gLpip4ANn9P9B1OkyfZXZR4KcxzKV2sOiBIFQS9wM9OAVxoF
         +LTpJfLs0UaSU8btUYPsiF4vLo+ALVKbyxuMDdSk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.19 087/139] perf/x86/intel: Disallow precise_ip on BTS events
Date:   Tue,  4 Dec 2018 11:49:28 +0100
Message-Id: <20181204103653.894505656@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 472de49fdc53365c880ab81ae2b5cfdd83db0b06 upstream.

Vince reported a crash in the BTS flush code when touching the callchain
data, which was supposed to be initialized as an 'early' callchain,
but intel_pmu_drain_bts_buffer() does not do that:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
  ...
  Call Trace:
   <IRQ>
   intel_pmu_drain_bts_buffer+0x151/0x220
   ? intel_get_event_constraints+0x219/0x360
   ? perf_assign_events+0xe2/0x2a0
   ? select_idle_sibling+0x22/0x3a0
   ? __update_load_avg_se+0x1ec/0x270
   ? enqueue_task_fair+0x377/0xdd0
   ? cpumask_next_and+0x19/0x20
   ? load_balance+0x134/0x950
   ? check_preempt_curr+0x7a/0x90
   ? ttwu_do_wakeup+0x19/0x140
   x86_pmu_stop+0x3b/0x90
   x86_pmu_del+0x57/0x160
   event_sched_out.isra.106+0x81/0x170
   group_sched_out.part.108+0x51/0xc0
   __perf_event_disable+0x7f/0x160
   event_function+0x8c/0xd0
   remote_function+0x3c/0x50
   flush_smp_call_function_queue+0x35/0xe0
   smp_call_function_single_interrupt+0x3a/0xd0
   call_function_single_interrupt+0xf/0x20
   </IRQ>

It was triggered by fuzzer but can be easily reproduced by:

  # perf record -e cpu/branch-instructions/pu -g -c 1

Peter suggested not to allow branch tracing for precise events:

 > Now arguably, this is really stupid behaviour. Who in his right mind
 > wants callchain output on BTS entries. And even if they do, BTS +
 > precise_ip is nonsensical.
 >
 > So in my mind disallowing precise_ip on BTS would be the simplest fix.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: <stable@vger.kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 6cbc304f2f36 ("perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)")
Link: http://lkml.kernel.org/r/20181121101612.16272-3-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2990,6 +2990,10 @@ static int intel_pmu_bts_config(struct p
 		if (!attr->exclude_kernel)
 			return -EOPNOTSUPP;
 
+		/* BTS is not allowed for precise events. */
+		if (attr->precise_ip)
+			return -EOPNOTSUPP;
+
 		/* disallow bts if conflicting events are present */
 		if (x86_add_exclusive(x86_lbr_exclusive_lbr))
 			return -EBUSY;



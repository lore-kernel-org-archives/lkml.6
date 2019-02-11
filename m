Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91664C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AB3222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897905;
	bh=7rpeOJkq0lavqs0KdUdRIV2w7Y1mapqvKRGhtq43OHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H0Bo2cbdEuojJscICNkkaZPmuSgT5VHGbJuAYtP33bTtyAwxYnZkte8Mb/rEEKY0/
	 Ohf3+Gnx4341oYMixrHZbX072rtOqfhPU2Q5D/pOItT20E7rjKpmtR9vx6da3GQ3OX
	 yr3x+acYHErmZ+wSz1PbLb7lY555Y4VwEc4ETxzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404020AbfBKPK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:10:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403880AbfBKPKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:10:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2774E222A7;
        Mon, 11 Feb 2019 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897852;
        bh=7rpeOJkq0lavqs0KdUdRIV2w7Y1mapqvKRGhtq43OHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbxP/BOfBSRtUuYZu1r/xAgLGXbaFEzVjEXgo9gnwBgGCjn5gurSLXJB/cHBvliuZ
         hrjQJqAZ4qfhaN6XozUbj8bbchhdjU9nnU++VKeCby2DOBg5EG1iSo5mJREUSZHtYF
         AeL+hS7E2F8aqo06zmsVPa4QvnufJsMfF2zq3bXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Lin Ming <ming.m.lin@intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@elte.hu>, He Zhe <zhe.he@windriver.com>
Subject: [PATCH 4.9 137/137] perf: Add support for supplementary event registers
Date:   Mon, 11 Feb 2019 15:20:18 +0100
Message-Id: <20190211141824.827389473@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

commit a7e3ed1e470116c9d12c2f778431a481a6be8ab6 upstream.

Change logs against Andi's original version:

- Extends perf_event_attr:config to config{,1,2} (Peter Zijlstra)
- Fixed a major event scheduling issue. There cannot be a ref++ on an
  event that has already done ref++ once and without calling
  put_constraint() in between. (Stephane Eranian)
- Use thread_cpumask for percore allocation. (Lin Ming)
- Use MSR names in the extra reg lists. (Lin Ming)
- Remove redundant "c = NULL" in intel_percore_constraints
- Fix comment of perf_event_attr::config1

Intel Nehalem/Westmere have a special OFFCORE_RESPONSE event
that can be used to monitor any offcore accesses from a core.
This is a very useful event for various tunings, and it's
also needed to implement the generic LLC-* events correctly.

Unfortunately this event requires programming a mask in a separate
register. And worse this separate register is per core, not per
CPU thread.

This patch:

- Teaches perf_events that OFFCORE_RESPONSE needs extra parameters.
  The extra parameters are passed by user space in the
  perf_event_attr::config1 field.

- Adds support to the Intel perf_event core to schedule per
  core resources. This adds fairly generic infrastructure that
  can be also used for other per core resources.
  The basic code has is patterned after the similar AMD northbridge
  constraints code.

Thanks to Stephane Eranian who pointed out some problems
in the original version and suggested improvements.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
LKML-Reference: <1299119690-13991-2-git-send-email-ming.m.lin@intel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
[ He Zhe: Fixes conflict caused by missing disable_counter_freeze which is
 introduced since v4.20 af3bdb991a5cb. ]
Signed-off-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/core.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3235,6 +3235,11 @@ static void free_excl_cntrs(int cpu)
 
 static void intel_pmu_cpu_dying(int cpu)
 {
+	fini_debug_store_on_cpu(cpu);
+}
+
+static void intel_pmu_cpu_dead(int cpu)
+{
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	struct intel_shared_regs *pc;
 
@@ -3246,8 +3251,6 @@ static void intel_pmu_cpu_dying(int cpu)
 	}
 
 	free_excl_cntrs(cpu);
-
-	fini_debug_store_on_cpu(cpu);
 }
 
 static void intel_pmu_sched_task(struct perf_event_context *ctx,
@@ -3324,6 +3327,7 @@ static __initconst const struct x86_pmu
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+	.cpu_dead		= intel_pmu_cpu_dead,
 };
 
 static __initconst const struct x86_pmu intel_pmu = {
@@ -3359,6 +3363,8 @@ static __initconst const struct x86_pmu
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
+	.cpu_dead		= intel_pmu_cpu_dead,
+
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
 };



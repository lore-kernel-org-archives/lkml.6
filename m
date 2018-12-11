Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050CBC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3BF20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3BF20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbeLKPbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:31:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55185 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeLKPbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:31:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBFVO7h4042009
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 07:31:24 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBFVOwi4042005;
        Tue, 11 Dec 2018 07:31:24 -0800
Date:   Tue, 11 Dec 2018 07:31:24 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-765d0af19f5f388a34bf4533378f8398b72ded46@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, hpa@zytor.com, efault@gmx.de
Reply-To: mingo@kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org,
          hpa@zytor.com, efault@gmx.de, torvalds@linux-foundation.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <1535548752-4434-4-git-send-email-vincent.guittot@linaro.org>
References: <1535548752-4434-4-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Remove the ::smt_gain field from
 'struct sched_domain'
Git-Commit-ID: 765d0af19f5f388a34bf4533378f8398b72ded46
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  765d0af19f5f388a34bf4533378f8398b72ded46
Gitweb:     https://git.kernel.org/tip/765d0af19f5f388a34bf4533378f8398b72ded46
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Wed, 29 Aug 2018 15:19:11 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 11 Dec 2018 15:16:57 +0100

sched/topology: Remove the ::smt_gain field from 'struct sched_domain'

::smt_gain is used to compute the capacity of CPUs of a SMT core with the
constraint 1 < ::smt_gain < 2 in order to be able to compute number of CPUs
per core. The field has_free_capacity of struct numa_stat, which was the
last user of this computation of number of CPUs per core, has been removed
by:

  2d4056fafa19 ("sched/numa: Remove numa_has_capacity()")

We can now remove this constraint on core capacity and use the defautl value
SCHED_CAPACITY_SCALE for SMT CPUs. With this remove, SCHED_CAPACITY_SCALE
becomes the maximum compute capacity of CPUs on every systems. This should
help to simplify some code and remove fields like rd->max_cpu_capacity

Furthermore, arch_scale_cpu_capacity() is used with a NULL sd in several other
places in the code when it wants the capacity of a CPUs to scale
some metrics like in pelt, deadline or schedutil. In case on SMT, the value
returned is not the capacity of SMT CPUs but default SCHED_CAPACITY_SCALE.

So remove it.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1535548752-4434-4-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/topology.h | 1 -
 kernel/sched/sched.h           | 3 ---
 kernel/sched/topology.c        | 2 --
 3 files changed, 6 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 6b9976180c1e..7fa0bc17cd8c 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -89,7 +89,6 @@ struct sched_domain {
 	unsigned int newidle_idx;
 	unsigned int wake_idx;
 	unsigned int forkexec_idx;
-	unsigned int smt_gain;
 
 	int nohz_idle;			/* NOHZ IDLE status */
 	int flags;			/* See SD_* */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9bde60a11805..ceb896404869 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1864,9 +1864,6 @@ unsigned long arch_scale_freq_capacity(int cpu)
 static __always_inline
 unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 {
-	if (sd && (sd->flags & SD_SHARE_CPUCAPACITY) && (sd->span_weight > 1))
-		return sd->smt_gain / sd->span_weight;
-
 	return SCHED_CAPACITY_SCALE;
 }
 #endif
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8d7f15ba5916..7364e0b427b7 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1133,7 +1133,6 @@ sd_init(struct sched_domain_topology_level *tl,
 
 		.last_balance		= jiffies,
 		.balance_interval	= sd_weight,
-		.smt_gain		= 0,
 		.max_newidle_lb_cost	= 0,
 		.next_decay_max_lb_cost	= jiffies,
 		.child			= child,
@@ -1164,7 +1163,6 @@ sd_init(struct sched_domain_topology_level *tl,
 
 	if (sd->flags & SD_SHARE_CPUCAPACITY) {
 		sd->imbalance_pct = 110;
-		sd->smt_gain = 1178; /* ~15% */
 
 	} else if (sd->flags & SD_SHARE_PKG_RESOURCES) {
 		sd->imbalance_pct = 117;

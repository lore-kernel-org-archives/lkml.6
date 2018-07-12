Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569DCC780D3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1486F21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="fuoAJg+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1486F21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbeGLRiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:38:14 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:45020 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732378AbeGLRiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cmpxchg.org
        ; s=x; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EOH4yuXU61UFUoCxssnGS0E9pmyAjCBzpOCJhmVNCYY=; b=fuoAJg+ANQDWbpN68BmdzpDcro
        EFO7eTln+95KuyO3oawXhDEnMCsE65lDhQIFTlHTiS4GnbXJyEi+FKi0fIqqBikXI5kPVLekION2m
        YZQlgEjJgGr+Fk0GqfvNDmtjJ58Lr1WVJZ64VvntC0ZczlhMvDhCNUvP/LSxcUcH4N9w=;
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 07/10] sched: introduce this_rq_lock_irq()
Date:   Thu, 12 Jul 2018 13:29:39 -0400
Message-Id: <20180712172942.10094-8-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712172942.10094-1-hannes@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_sched_yield() disables IRQs, looks up this_rq() and locks it. The
next patch is adding another site with the same pattern, so provide a
convenience function for it.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/core.c  |  4 +---
 kernel/sched/sched.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 211890edf37e..9586a8141f16 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4960,9 +4960,7 @@ static void do_sched_yield(void)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	local_irq_disable();
-	rq = this_rq();
-	rq_lock(rq, &rf);
+	rq = this_rq_lock_irq(&rf);
 
 	schedstat_inc(rq->yld_count);
 	current->sched_class->yield_task(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b8f038497240..bc798c7cb4d4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1119,6 +1119,18 @@ rq_unlock(struct rq *rq, struct rq_flags *rf)
 	raw_spin_unlock(&rq->lock);
 }
 
+static inline struct rq *
+this_rq_lock_irq(struct rq_flags *rf)
+	__acquires(rq->lock)
+{
+	struct rq *rq;
+
+	local_irq_disable();
+	rq = this_rq();
+	rq_lock(rq, rf);
+	return rq;
+}
+
 #ifdef CONFIG_NUMA
 enum numa_topology_type {
 	NUMA_DIRECT,
-- 
2.18.0


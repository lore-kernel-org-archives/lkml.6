Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121EAC4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E4721783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697277;
	bh=fdnf0tDm+NUnGdGJKyoJsLJgE329LZfTLAqXrT33+A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WsOUHCFJ0EfI86Y9+QJ+1i4PpN8mgQ90B5m3ASaB9UZPAE/7VQi8ABu4k1xRZwwhO
	 Rj86TXkI0HnQwZiAuBX29XAOwWcEKAis2gCWleUz6yv7PfSfYq75XnFLT+nIzgsI8D
	 m+/cN4xSB35i69CuXrglsMmocnWHSGJv2dE+Xc4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfA1Pvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:51:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfA1Pv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:51:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E4292147A;
        Mon, 28 Jan 2019 15:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690686;
        bh=fdnf0tDm+NUnGdGJKyoJsLJgE329LZfTLAqXrT33+A4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AV9QGp57O9LtROCvRwkXnzcB/1spcQ2cm4N/nLNkeDO2CmB1N0Qfa2gnzOmcwMRp2
         hfFpSaoihCrjL2C7aIiAagJJ6+yJeE8Rsn84XQoexKTqALuwTxWpoo1f4ytlpOeTs8
         g58zs04OKLKLoyK9h62hZzO/Fno30HfqdleeYMBI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Quentin Perret <quentin.perret@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, adharmap@codeaurora.org,
        chris.redpath@arm.com, currojerez@riseup.net,
        dietmar.eggemann@arm.com, edubezval@gmail.com,
        gregkh@linuxfoundation.org, javi.merino@kernel.org,
        joel@joelfernandes.org, juri.lelli@redhat.com,
        patrick.bellasi@arm.com, pkondeti@codeaurora.org,
        rjw@rjwysocki.net, skannan@codeaurora.org, smuckle@google.com,
        srinivas.pandruvada@linux.intel.com, thara.gopinath@linaro.org,
        tkjos@google.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 163/304] sched/topology: Add lowest CPU asymmetry sched_domain level pointer
Date:   Mon, 28 Jan 2019 10:41:20 -0500
Message-Id: <20190128154341.47195-163-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Perret <quentin.perret@arm.com>

[ Upstream commit 011b27bb5d3139e8b5fe9ceff1fc7f6dc3145071 ]

Add another member to the family of per-cpu sched_domain shortcut
pointers. This one, sd_asym_cpucapacity, points to the lowest level
at which the SD_ASYM_CPUCAPACITY flag is set. While at it, rename the
sd_asym shortcut to sd_asym_packing to avoid confusions.

Generally speaking, the largest opportunity to save energy via
scheduling comes from a smarter exploitation of heterogeneous platforms
(i.e. big.LITTLE). Consequently, the sd_asym_cpucapacity shortcut will
be used at first as the lowest domain where Energy-Aware Scheduling
(EAS) should be applied. For example, it is possible to apply EAS within
a socket on a multi-socket system, as long as each socket has an
asymmetric topology. Energy-aware cross-sockets wake-up balancing will
only happen when the system is over-utilized, or this_cpu and prev_cpu
are in different sockets.

Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: adharmap@codeaurora.org
Cc: chris.redpath@arm.com
Cc: currojerez@riseup.net
Cc: dietmar.eggemann@arm.com
Cc: edubezval@gmail.com
Cc: gregkh@linuxfoundation.org
Cc: javi.merino@kernel.org
Cc: joel@joelfernandes.org
Cc: juri.lelli@redhat.com
Cc: patrick.bellasi@arm.com
Cc: pkondeti@codeaurora.org
Cc: rjw@rjwysocki.net
Cc: skannan@codeaurora.org
Cc: smuckle@google.com
Cc: srinivas.pandruvada@linux.intel.com
Cc: thara.gopinath@linaro.org
Cc: tkjos@google.com
Cc: valentin.schneider@arm.com
Cc: vincent.guittot@linaro.org
Cc: viresh.kumar@linaro.org
Link: https://lkml.kernel.org/r/20181203095628.11858-7-quentin.perret@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c     | 2 +-
 kernel/sched/sched.h    | 3 ++-
 kernel/sched/topology.c | 8 ++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e8f191ba3fe5..9ef0b878229d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9256,7 +9256,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		}
 	}
 
-	sd = rcu_dereference(per_cpu(sd_asym, cpu));
+	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
 	if (sd) {
 		for_each_cpu(i, sched_domain_span(sd)) {
 			if (i == cpu ||
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4e524ab589c9..6f68dcb791f6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1285,7 +1285,8 @@ DECLARE_PER_CPU(int, sd_llc_size);
 DECLARE_PER_CPU(int, sd_llc_id);
 DECLARE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DECLARE_PER_CPU(struct sched_domain *, sd_numa);
-DECLARE_PER_CPU(struct sched_domain *, sd_asym);
+DECLARE_PER_CPU(struct sched_domain *, sd_asym_packing);
+DECLARE_PER_CPU(struct sched_domain *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
 
 struct sched_group_capacity {
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8d7f15ba5916..ced83d060ec8 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -397,7 +397,8 @@ DEFINE_PER_CPU(int, sd_llc_size);
 DEFINE_PER_CPU(int, sd_llc_id);
 DEFINE_PER_CPU(struct sched_domain_shared *, sd_llc_shared);
 DEFINE_PER_CPU(struct sched_domain *, sd_numa);
-DEFINE_PER_CPU(struct sched_domain *, sd_asym);
+DEFINE_PER_CPU(struct sched_domain *, sd_asym_packing);
+DEFINE_PER_CPU(struct sched_domain *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
 static void update_top_cache_domain(int cpu)
@@ -423,7 +424,10 @@ static void update_top_cache_domain(int cpu)
 	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
 
 	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
-	rcu_assign_pointer(per_cpu(sd_asym, cpu), sd);
+	rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
+
+	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
+	rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
 }
 
 /*
-- 
2.19.1


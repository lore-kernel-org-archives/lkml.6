Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D41C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EFA20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EFA20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeIJPB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:01:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47689 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbeIJPB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:01:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AA7n8v1807048
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:07:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AA7m8H1807045;
        Mon, 10 Sep 2018 03:07:48 -0700
Date:   Mon, 10 Sep 2018 03:07:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-287cdaac5700c5b8970d739f73d742d863d3e2ca@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, srikar@linux.vnet.ibm.com,
        tglx@linutronix.de, torvalds@linux-foundation.org, hpa@zytor.com,
        peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, srikar@linux.vnet.ibm.com,
          vincent.guittot@linaro.org
In-Reply-To: <20180904093626.GA23936@linaro.org>
References: <20180904093626.GA23936@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Fix scale_rt_capacity() for SMT
Git-Commit-ID: 287cdaac5700c5b8970d739f73d742d863d3e2ca
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

Commit-ID:  287cdaac5700c5b8970d739f73d742d863d3e2ca
Gitweb:     https://git.kernel.org/tip/287cdaac5700c5b8970d739f73d742d863d3e2ca
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Tue, 4 Sep 2018 11:36:26 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 10:13:47 +0200

sched/fair: Fix scale_rt_capacity() for SMT

Since commit:

  523e979d3164 ("sched/core: Use PELT for scale_rt_capacity()")

scale_rt_capacity() returns the remaining capacity and not a scale factor
to apply on cpu_capacity_orig. arch_scale_cpu() is directly called by
scale_rt_capacity() so we must take the sched_domain argument.

Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 523e979d3164 ("sched/core: Use PELT for scale_rt_capacity()")
Link: http://lkml.kernel.org/r/20180904093626.GA23936@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c6b7d6daab20..f12d004be6a1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7488,10 +7488,10 @@ static inline int get_sd_load_idx(struct sched_domain *sd,
 	return load_idx;
 }
 
-static unsigned long scale_rt_capacity(int cpu)
+static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
+	unsigned long max = arch_scale_cpu_capacity(sd, cpu);
 	unsigned long used, free;
 	unsigned long irq;
 
@@ -7513,7 +7513,7 @@ static unsigned long scale_rt_capacity(int cpu)
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
-	unsigned long capacity = scale_rt_capacity(cpu);
+	unsigned long capacity = scale_rt_capacity(sd, cpu);
 	struct sched_group *sdg = sd->groups;
 
 	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(sd, cpu);

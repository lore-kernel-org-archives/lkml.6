Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE78C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93684214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fy7kIM+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93684214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeJIXmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:42:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38613 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeJIXmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:42:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9-v6so2300800qtf.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nAJdbw7cVJufaDU26DYt0Cn84YRW0q9zfDmKbAnQg00=;
        b=fy7kIM+fgL9ZvKDy66WMaAC9Wc/4RpI9FTvgC8ZckGaXt71Bledbyz1ZX6lTq176Jo
         64y8pUfFC/fEu3WI5sDQ7mG+PAvywzM3cJRcQftrsyEZXTB+ULmYlbLWH2In+T80BvJ/
         xKiREcpFn14bvqEGKsDe08LQZsYTbcaunNqEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nAJdbw7cVJufaDU26DYt0Cn84YRW0q9zfDmKbAnQg00=;
        b=lobQ/E8jKPHnah8RqOz+z7M1PxJqcVVrkGtL9ceIM327XVy4bax1vOMe28Cm+xFdGi
         DL7EfLNq5bx13KlrgRnvldYlZsfax6Kq8LyNZ9QTZDUwWUn/OOtxHEehDEm0S8QLPZcX
         GbXJbCob09eu9guszKaGuFIPxHF2C64w8BGcOJlKRm/tj8wufs1QuLAQku/+COnMR7lN
         w6sVmH5JowLPb6JmUrP8B8UdS9ituhr++cwatkue3NuQCejAOKWJiuJJj4PK7yiJNPZz
         0vjJY1LzZyM8Wjtxd4mwNbygqWZC83ZLXeA6HXyt+nnSKk5rIQDM6VwuK2+rJdDlvf69
         +UMg==
X-Gm-Message-State: ABuFfojZv9qjrqWG1Y3WIPKIKMFkn8ryRi/dI32lQGGZ8p5D8te9gGpy
        zIjc/jkfCPxwu/d7Wu5okAZgchy3rH6MDg==
X-Google-Smtp-Source: ACcGV63vB8RJmeHFYyOdoUcjI/azglwvjR9wv/BZCHPmnirFJv6IX+zqA3JdY71OWmTFydvdq1dXeg==
X-Received: by 2002:a05:6214:1091:: with SMTP id o17mr19318832qvr.97.1539102306927;
        Tue, 09 Oct 2018 09:25:06 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id o7-v6sm10441169qkc.67.2018.10.09.09.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 09:25:06 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org
Subject: [RFC PATCH 1/7] sched/pelt.c: Add option to make load and util calculations frequency invariant
Date:   Tue,  9 Oct 2018 12:24:56 -0400
Message-Id: <1539102302-9057-2-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an additional parametr in accumulate_sum to allow optional
frequency adjustment of load and utilization. When considering
rt/dl load/util, it is correct to scale it to the current cpu
frequency. On the other hand, thermal pressure(max capped frequency)
is frequency invariant.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 kernel/sched/pelt.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 35475c0..05b8798 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -107,7 +107,8 @@ static u32 __accumulate_pelt_segments(u64 periods, u32 d1, u32 d3)
  */
 static __always_inline u32
 accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
-	       unsigned long load, unsigned long runnable, int running)
+	       unsigned long load, unsigned long runnable, int running,
+		int freq_adjusted)
 {
 	unsigned long scale_freq, scale_cpu;
 	u32 contrib = (u32)delta; /* p == 0 -> delta < 1024 */
@@ -137,7 +138,8 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
 	}
 	sa->period_contrib = delta;
 
-	contrib = cap_scale(contrib, scale_freq);
+	if (freq_adjusted)
+		contrib = cap_scale(contrib, scale_freq);
 	if (load)
 		sa->load_sum += load * contrib;
 	if (runnable)
@@ -178,7 +180,8 @@ accumulate_sum(u64 delta, int cpu, struct sched_avg *sa,
  */
 static __always_inline int
 ___update_load_sum(u64 now, int cpu, struct sched_avg *sa,
-		  unsigned long load, unsigned long runnable, int running)
+		  unsigned long load, unsigned long runnable, int running,
+			int freq_adjusted)
 {
 	u64 delta;
 
@@ -221,7 +224,8 @@ ___update_load_sum(u64 now, int cpu, struct sched_avg *sa,
 	 * Step 1: accumulate *_sum since last_update_time. If we haven't
 	 * crossed period boundaries, finish.
 	 */
-	if (!accumulate_sum(delta, cpu, sa, load, runnable, running))
+	if (!accumulate_sum(delta, cpu, sa, load, runnable, running,
+						freq_adjusted))
 		return 0;
 
 	return 1;
@@ -272,7 +276,7 @@ int __update_load_avg_blocked_se(u64 now, int cpu, struct sched_entity *se)
 	if (entity_is_task(se))
 		se->runnable_weight = se->load.weight;
 
-	if (___update_load_sum(now, cpu, &se->avg, 0, 0, 0)) {
+	if (___update_load_sum(now, cpu, &se->avg, 0, 0, 0, 1)) {
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
 		return 1;
 	}
@@ -286,7 +290,7 @@ int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_e
 		se->runnable_weight = se->load.weight;
 
 	if (___update_load_sum(now, cpu, &se->avg, !!se->on_rq, !!se->on_rq,
-				cfs_rq->curr == se)) {
+				cfs_rq->curr == se, 1)) {
 
 		___update_load_avg(&se->avg, se_weight(se), se_runnable(se));
 		cfs_se_util_change(&se->avg);
@@ -301,7 +305,7 @@ int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq)
 	if (___update_load_sum(now, cpu, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
 				scale_load_down(cfs_rq->runnable_weight),
-				cfs_rq->curr != NULL)) {
+				cfs_rq->curr != NULL, 1)) {
 
 		___update_load_avg(&cfs_rq->avg, 1, 1);
 		return 1;
@@ -326,7 +330,7 @@ int update_rt_rq_load_avg(u64 now, struct rq *rq, int running)
 	if (___update_load_sum(now, rq->cpu, &rq->avg_rt,
 				running,
 				running,
-				running)) {
+				running, 1)) {
 
 		___update_load_avg(&rq->avg_rt, 1, 1);
 		return 1;
@@ -349,7 +353,7 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	if (___update_load_sum(now, rq->cpu, &rq->avg_dl,
 				running,
 				running,
-				running)) {
+				running, 1)) {
 
 		___update_load_avg(&rq->avg_dl, 1, 1);
 		return 1;
@@ -385,11 +389,11 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 	ret = ___update_load_sum(rq->clock - running, rq->cpu, &rq->avg_irq,
 				0,
 				0,
-				0);
+				0, 1);
 	ret += ___update_load_sum(rq->clock, rq->cpu, &rq->avg_irq,
 				1,
 				1,
-				1);
+				1, 1);
 
 	if (ret)
 		___update_load_avg(&rq->avg_irq, 1, 1);
-- 
2.1.4


Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EC1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871D822419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOVhNjg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871D822419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbeKOAqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:46:33 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37767 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbeKOAqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:46:32 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so7468293pge.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 06:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lI6Brk4FLVHP1n6C43ZrBQ76dtP9t2lQe8qWznPRBDE=;
        b=TOVhNjg+x8DdTzwPVFrSgoleRvs5LHBmc01/jDavaqn9DmYJ9v/i4FcSEQuSit8yYU
         KJ5AOO85mGdjjJKrFNcBXBQF2kXKg2lWuyZCDMgXYzauQYFjTl8rwmBuaDG1lip6JmIb
         yFiiDNSVW2T9Km3eu7BYWsBTS49njWGALwiG8S4O0poi2ZBidW05dTJtyRQhdm2mKXNA
         gryi0+GHtEJ1nDsJu1cV9pLGhTYe8AgVu5rmYKDFKyWFc1lS06yxQv8K1t4aXuMmmz+N
         qGn12xOUyGB6Hb9Ma4M6hRse47kVyJDJglhn5d/T1UJdEUQbg8e0QELPyIJ6TmM/RrL5
         mtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lI6Brk4FLVHP1n6C43ZrBQ76dtP9t2lQe8qWznPRBDE=;
        b=knzhkP9SbOGAJgzVJGms9apOzZW8bSejawM23LJuKSnnyRKxgG4Svx/cKrQ/EnTkPa
         FL04CteASbzpNDQ4ASNkcSA67vvktapHpFH76LsI5xLfL3pme+z3FGbHDXLXFlPqfM2y
         iB2YD4K5XWb+6e8YaEer4FevzFLmhwx4uJxhzpmcCthjplRtYKo3P+oR0ZLlmIQM9sRa
         o+naE7CrrVo9NuoA/RzjQPdibhcUp8aqtALpHSuF42SG9aeBGa/s78ThCOGimANBjQGh
         HBRv8nB5OZX09Xh5r4MvVKxgzXJq46556wMzK2c5vFtmGj5+QllfaZw7L8iH0LFqPtRd
         SXmQ==
X-Gm-Message-State: AGRZ1gJCdmexHknfXYL+WoLr+kI1tXp+W/GlJ2d/k6T44XIAuyIVIDmj
        A6E9JUCfJeNcQmUSbblXeNA=
X-Google-Smtp-Source: AJdET5c8p0w1oIKn1gVZO4UgbmuAj7+2RCbMBCHkkIbniY9OKYIC3dP1s8/oO878l2m5NpQCLd4lDA==
X-Received: by 2002:a65:514c:: with SMTP id g12mr1967249pgq.169.1542206581580;
        Wed, 14 Nov 2018 06:43:01 -0800 (PST)
Received: from ubuntu.localdomain ([104.238.150.158])
        by smtp.gmail.com with ESMTPSA id t13sm36815678pgr.42.2018.11.14.06.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 06:43:01 -0800 (PST)
From:   Muchun Song <smuchun@gmail.com>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Clean up update_blocked_averages()
Date:   Wed, 14 Nov 2018 22:42:43 +0800
Message-Id: <20181114144243.100142-1-smuchun@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, with CONFIG_NO_HZ_COMMON is disabled, we don't need to call
cfs_rq_has_blocked() and others_have_blocked(). And the local variable
'done' is unnecessary as well.

So we put the functions in the #ifdef block so that compiler can help us
optimize the code(e.g. the local variable 'done' and the function call).

After do that, we introduce a function named update_rq_blocked_load() to
remove #ifdef from update_blocked_averages(), which can make the code
clean.

Second, there are some the same function call in update_blocked_averages()
regardless of whether CONFIG_FAIR_GROUP_SCHED is enabled or not. That is
rt, dl and irq's load_avg update. So let the update_others_load_avg() do
it.

Signed-off-by: Muchun Song <smuchun@gmail.com>
---
 kernel/sched/fair.c | 59 +++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e30dea59d215..89b3b4a18eee 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7367,6 +7367,7 @@ static void attach_tasks(struct lb_env *env)
 	rq_unlock(env->dst_rq, &rf);
 }
 
+#ifdef CONFIG_NO_HZ_COMMON
 static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
 {
 	if (cfs_rq->avg.load_avg)
@@ -7394,6 +7395,37 @@ static inline bool others_have_blocked(struct rq *rq)
 	return false;
 }
 
+static inline void update_rq_blocked_load(struct rq *rq, bool clear)
+{
+	rq->last_blocked_load_update_tick = jiffies;
+	if (clear)
+		rq->has_blocked_load = 0;
+}
+#else /* !CONFIG_NO_HZ_COMMON */
+static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
+{
+	return false;
+}
+
+static inline bool others_have_blocked(struct rq *rq)
+{
+	return false;
+}
+
+static inline void update_rq_blocked_load(struct rq *rq, bool clear)
+{
+}
+#endif /* CONFIG_NO_HZ_COMMON */
+
+static void update_others_load_avg(struct rq *rq)
+{
+	const struct sched_class *curr = rq->curr->sched_class;
+
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr == &rt_sched_class);
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr == &dl_sched_class);
+	update_irq_load_avg(rq, 0);
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
@@ -7417,7 +7449,6 @@ static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq, *pos;
-	const struct sched_class *curr_class;
 	struct rq_flags rf;
 	bool done = true;
 
@@ -7455,19 +7486,12 @@ static void update_blocked_averages(int cpu)
 			done = false;
 	}
 
-	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
+	update_others_load_avg(rq);
 	/* Don't need periodic decay once load/util_avg are null */
-	if (others_have_blocked(rq))
+	if (done && others_have_blocked(rq))
 		done = false;
 
-#ifdef CONFIG_NO_HZ_COMMON
-	rq->last_blocked_load_update_tick = jiffies;
-	if (done)
-		rq->has_blocked_load = 0;
-#endif
+	update_rq_blocked_load(rq, done);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
@@ -7522,22 +7546,15 @@ static inline void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq = &rq->cfs;
-	const struct sched_class *curr_class;
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
 
-	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
-#ifdef CONFIG_NO_HZ_COMMON
-	rq->last_blocked_load_update_tick = jiffies;
-	if (!cfs_rq_has_blocked(cfs_rq) && !others_have_blocked(rq))
-		rq->has_blocked_load = 0;
-#endif
+	update_others_load_avg(rq);
+	update_rq_blocked_load(rq, !cfs_rq_has_blocked(cfs_rq) &&
+				   !others_have_blocked(rq));
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-- 
2.17.1


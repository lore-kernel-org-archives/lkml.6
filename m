Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9528BC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFA72089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xjbel8BM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFA72089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbeJBOIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:08:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36981 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeJBOIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:08:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so926864wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 00:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wf4RyXux5B5jeDxtYeqhctDhaaK9OERZSccFy0gfof0=;
        b=Xjbel8BM8yKMlqC/42AYs0S3sd5yMDO5sSmyMzEeONlYHqTDQtk/jkEn89AcXcRI3O
         4X6rkLSaW2AYio6FEnDeFqNLmywzNadVBP59R+drzsmv5opi9Qmkn3BE/ycXoQAfVre3
         9Zhr+Im2eyVM4gkDbxxrudxmtLmocIDPygpq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wf4RyXux5B5jeDxtYeqhctDhaaK9OERZSccFy0gfof0=;
        b=BQ6Z/cM7U20Tdst00HIuVXaH6baK2g9Plg5biDYhu1Vgqtb/wlR0XZy+9aLVCMXRvy
         jjYvDf49wcUQbZNCWck0IFk/4tPKCOveTcmGH+CgIynHQUI10KHSOLTxZmCoFVew07c+
         NHljZCfO/BUpuBRHdAdEeg/OlL3SPZUnNLERCy6T5FoeWu4/B1++KK+8F/u44QOD1X5Y
         61xFQi2HKaiD8OCBlJa6jLo7/PmfgO2ct4d54iOvKNxcT7fTlndgeDmeXXFvAquEBOcR
         fegLBHxbWKVNMwT/IWpxc78HD+nc25Jgyofsra76nACZOjdykyuqlejcTvwl5M2QSIqU
         nqWQ==
X-Gm-Message-State: ABuFfohhl0Kd6ug14gp7NsRbT8s6zFH2q43byp0z+rnUWC/QhILLZevz
        h2R1Kz7YNI6HjQYStaA4VvTJqA==
X-Google-Smtp-Source: ACcGV61dtwT/oLNPvCARW0KYCwgHCkXpwgGFTkLOfin7o5ZxDqgFnjQWd29gN2bxx8gnHlocyxwxWQ==
X-Received: by 2002:adf:9244:: with SMTP id 62-v6mr9302961wrj.130.1538465218673;
        Tue, 02 Oct 2018 00:26:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:99b3:4272:8254:6430])
        by smtp.gmail.com with ESMTPSA id t24-v6sm3550552wra.5.2018.10.02.00.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Oct 2018 00:26:57 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RESEND PATCH 3/3] sched/fair: fix unnecessary increase of balance interval
Date:   Tue,  2 Oct 2018 09:26:39 +0200
Message-Id: <1538465199-20176-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538465199-20176-1-git-send-email-vincent.guittot@linaro.org>
References: <1538465199-20176-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of active balance, we increase the balance interval to cover
pinned tasks cases not covered by all_pinned logic. Neverthless, the active
migration triggered by asym packing should be treated as the normal
unbalanced case and reset the interval to default value otherwise active
migration for asym_packing can be easily delayed for hundreds of ms
because of this all_pinned detection mecanism.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 00f2171..4b6a226 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8456,22 +8456,32 @@ static struct rq *find_busiest_queue(struct lb_env *env,
  */
 #define MAX_PINNED_INTERVAL	512
 
-static int need_active_balance(struct lb_env *env)
+static inline bool
+asym_active_balance(enum cpu_idle_type idle, unsigned int flags, int dst, int src)
 {
-	struct sched_domain *sd = env->sd;
-
-	if (env->idle != CPU_NOT_IDLE) {
+	if (idle != CPU_NOT_IDLE) {
 
 		/*
 		 * ASYM_PACKING needs to force migrate tasks from busy but
 		 * lower priority CPUs in order to pack all tasks in the
 		 * highest priority CPUs.
 		 */
-		if ((sd->flags & SD_ASYM_PACKING) &&
-		    sched_asym_prefer(env->dst_cpu, env->src_cpu))
-			return 1;
+		if ((flags & SD_ASYM_PACKING) &&
+		    sched_asym_prefer(dst, src))
+			return true;
 	}
 
+	return false;
+}
+
+static int need_active_balance(struct lb_env *env)
+{
+	struct sched_domain *sd = env->sd;
+
+
+	if (asym_active_balance(env->idle, sd->flags, env->dst_cpu, env->src_cpu))
+		return 1;
+
 	/*
 	 * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
 	 * It's worth migrating the task if the src_cpu's capacity is reduced
@@ -8749,7 +8759,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	} else
 		sd->nr_balance_failed = 0;
 
-	if (likely(!active_balance)) {
+	if (likely(!active_balance) ||
+	    asym_active_balance(env.idle, sd->flags, env.dst_cpu, env.src_cpu)) {
 		/* We were unbalanced, so reset the balancing interval */
 		sd->balance_interval = sd->min_interval;
 	} else {
-- 
2.7.4


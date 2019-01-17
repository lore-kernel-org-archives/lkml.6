Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E497C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7015620851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbfAQIsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:48:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43386 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfAQIr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:47:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so9971716wrs.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 00:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=goaAe7vGQCi5mRt58Lo1uF5caU1iA3IvOl0cay4wrr0=;
        b=bhDWnnSqUqPjQFeSzA9hrAld+VXHYlUyyQWOqFF73m73Nif5m9iOpyHwm52wsfG0Ty
         F5BPUanRxvMsua04sopExJgRlqIzQJvuEtHn5sL4XCtoEjL1OdlLkKvxdNTWGrq22NVJ
         IH8tLxLoAntBzQUV2w+u1zHm7GZHNEkIvZsGYsJbni7Yvxd7BgTFYkqKCSSRjbRwv4FP
         YvtXVC7BEq9yvX6qSjPdbqxa44AJPKdExvrhz2r8JcrpUWnY4wht7a4YihyjaZzwnTQy
         1LTEGyvjAd9aKlxFuZdiHT7DP/NqC3F3YF89uq0Nm897EOwwV/cNdxhT/o1+q0iWwEJY
         Vjlw==
X-Gm-Message-State: AJcUukeaRPH6rNiNMSRBRLfh66SWs7rCiTYJ8Xv+gWl8SvtMCEOxYRMT
        Hqv39UjDxFYyt7Sul/krD/Zm6g==
X-Google-Smtp-Source: ALg8bN51bQ80TIhj8sO66yfQ2Cy+vNeBOj6lc7ai+obgdrWKtlp2OL1yZwFLatyVMRG/lc5QKppRDg==
X-Received: by 2002:adf:c846:: with SMTP id e6mr10517656wrh.243.1547714877001;
        Thu, 17 Jan 2019 00:47:57 -0800 (PST)
Received: from localhost.localdomain.home ([151.15.254.62])
        by smtp.gmail.com with ESMTPSA id 199sm41984992wmh.21.2019.01.17.00.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 00:47:56 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: [PATCH v6 2/5] sched/core: Streamlining calls to task_rq_unlock()
Date:   Thu, 17 Jan 2019 09:47:36 +0100
Message-Id: <20190117084739.17078-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190117084739.17078-1-juri.lelli@redhat.com>
References: <20190117084739.17078-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Calls to task_rq_unlock() are done several times in function
__sched_setscheduler().  This is fine when only the rq lock needs to be
handled but not so much when other locks come into play.

This patch streamlines the release of the rq lock so that only one
location need to be modified when dealing with more than one lock.

No change of functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 091e089063be..f5263383170e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4228,8 +4228,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	 * Changing the policy of the stop threads its a very bad idea:
 	 */
 	if (p == rq->stop) {
-		task_rq_unlock(rq, p, &rf);
-		return -EINVAL;
+		retval = -EINVAL;
+		goto unlock;
 	}
 
 	/*
@@ -4245,8 +4245,8 @@ static int __sched_setscheduler(struct task_struct *p,
 			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
-		task_rq_unlock(rq, p, &rf);
-		return 0;
+		retval = 0;
+		goto unlock;
 	}
 change:
 
@@ -4259,8 +4259,8 @@ static int __sched_setscheduler(struct task_struct *p,
 		if (rt_bandwidth_enabled() && rt_policy(policy) &&
 				task_group(p)->rt_bandwidth.rt_runtime == 0 &&
 				!task_group_is_autogroup(task_group(p))) {
-			task_rq_unlock(rq, p, &rf);
-			return -EPERM;
+			retval = -EPERM;
+			goto unlock;
 		}
 #endif
 #ifdef CONFIG_SMP
@@ -4275,8 +4275,8 @@ static int __sched_setscheduler(struct task_struct *p,
 			 */
 			if (!cpumask_subset(span, &p->cpus_allowed) ||
 			    rq->rd->dl_bw.bw == 0) {
-				task_rq_unlock(rq, p, &rf);
-				return -EPERM;
+				retval = -EPERM;
+				goto unlock;
 			}
 		}
 #endif
@@ -4295,8 +4295,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	 * is available.
 	 */
 	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
-		task_rq_unlock(rq, p, &rf);
-		return -EBUSY;
+		retval = -EBUSY;
+		goto unlock;
 	}
 
 	p->sched_reset_on_fork = reset_on_fork;
@@ -4352,6 +4352,10 @@ static int __sched_setscheduler(struct task_struct *p,
 	preempt_enable();
 
 	return 0;
+
+unlock:
+	task_rq_unlock(rq, p, &rf);
+	return retval;
 }
 
 static int _sched_setscheduler(struct task_struct *p, int policy,
-- 
2.17.2


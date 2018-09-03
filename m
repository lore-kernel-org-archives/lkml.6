Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E48C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A37020862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A37020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeICSsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:48:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37013 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeICSss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:48:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so883217wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 07:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ixlA8GSsgMTTrpJTxCCYl0cq2Ht5+u6xLI53pQCU/GY=;
        b=co1JYEoAiG/wg/aXp/plaM5rg8dNaUqM+0O8tR3iPBDnOLYLctTrF376rt4LT7bKcg
         MWt7RaiSS8iCjPRLSdvUGtoVYPM8b98ymyKvMckYJrVDHEUw4ZuC4FOmiL7v2IL5KFgG
         E22fM8iH00QtUJzIdD7b5iNnsI+/tH3R36RzMGYvhp+VwhsOs8SSNGElWmsC/Hh9SJhV
         0RhSoyTupDcgt4oc9clNkD2BMnZ3zGw/t6oN8mym9T3AQ59G6lCColDuueMQWlhcGVx5
         q7FtohYZAOd+1gWoDLyX3xm+wakzN0XrWl+TZobHT7pSKU8ad86FTEG+Ui7I9x75k4JP
         kESQ==
X-Gm-Message-State: APzg51CaIUfjFfoAkNooNhav9Pd1qXw1yxIYn02+oiGY9c9CkQLH21HV
        /LIi9C1kKCsJCOICSiH8MzKHyg==
X-Google-Smtp-Source: ANB0VdZnVSnyznWXJTF2MEO2jl4gZijAnNyo23xu+U5YU6v+dWN8aJ+lAcWVIfHjo7Ba6RmJwRMvfg==
X-Received: by 2002:adf:8b98:: with SMTP id o24-v6mr18996859wra.110.1535984901630;
        Mon, 03 Sep 2018 07:28:21 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.227.30])
        by smtp.gmail.com with ESMTPSA id b74-v6sm14175880wma.8.2018.09.03.07.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 07:28:21 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: [PATCH v5 2/5] sched/core: Streamlining calls to task_rq_unlock()
Date:   Mon,  3 Sep 2018 16:27:58 +0200
Message-Id: <20180903142801.20046-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903142801.20046-1-juri.lelli@redhat.com>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
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
---
 kernel/sched/core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index deafa9fe602b..22f5622cba69 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4232,8 +4232,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	 * Changing the policy of the stop threads its a very bad idea:
 	 */
 	if (p == rq->stop) {
-		task_rq_unlock(rq, p, &rf);
-		return -EINVAL;
+		retval = -EINVAL;
+		goto unlock;
 	}
 
 	/*
@@ -4249,8 +4249,8 @@ static int __sched_setscheduler(struct task_struct *p,
 			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
-		task_rq_unlock(rq, p, &rf);
-		return 0;
+		retval = 0;
+		goto unlock;
 	}
 change:
 
@@ -4263,8 +4263,8 @@ static int __sched_setscheduler(struct task_struct *p,
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
@@ -4279,8 +4279,8 @@ static int __sched_setscheduler(struct task_struct *p,
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
@@ -4299,8 +4299,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	 * is available.
 	 */
 	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
-		task_rq_unlock(rq, p, &rf);
-		return -EBUSY;
+		retval = -EBUSY;
+		goto unlock;
 	}
 
 	p->sched_reset_on_fork = reset_on_fork;
@@ -4356,6 +4356,10 @@ static int __sched_setscheduler(struct task_struct *p,
 	preempt_enable();
 
 	return 0;
+
+unlock:
+	task_rq_unlock(rq, p, &rf);
+	return retval;
 }
 
 static int _sched_setscheduler(struct task_struct *p, int policy,
-- 
2.17.1


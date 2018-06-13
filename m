Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 99838C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58993208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58993208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964803AbeFMMSN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:18:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34977 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935286AbeFMMRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:17:31 -0400
Received: by mail-wr0-f194.google.com with SMTP id l10-v6so2540916wrn.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 05:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KX4uxSPk+Ym6JtztjwcqO+gEDs3avL9GQ5ej6jLr24U=;
        b=dFo4+6f6XAP/XxpD9CW2yx1UMljC/TsZvEnVcX8JVAoS0GEW670DcMVboxZkDZmsHP
         CDotTvsC63gApeDrTp/XK8WPWML/AHTPlIiJFAQIYoIIs9I6wXfpLMsTS93pg+qAxrBh
         zWPTcxgDJUfB8RwjKeu9mm3pimLJ69ou2DvzWWs8GnnskpTAaRMuU9k6bvijIYzz6Rv7
         RXwOBWSN6rhFOyI/vgKpRL47ZusaHE22bOfAgfKq4qU2GXgNN0UYmB+e2V0lKxuq9lVx
         iUWi1aJn1nErYy5mlgJjmP8ap0iMoXnVFtDaq0icM4j7BBKQvbhT4EiDJDC0w5ujrszc
         MA8g==
X-Gm-Message-State: APt69E3+7z6Om6hedRIhMilPFh9Hj2tBAbBR2wvQSLu8uBDR7eR+LwL7
        zefYCzH66BefYkiDsXioMN3/gA==
X-Google-Smtp-Source: ADUXVKJeIZnLh/s5f0Bm/EtrYJPtKAlL863+rFzoUwdNlZt3/Z8DddfZWcN6KQuwtNGhNsbZKSGxtw==
X-Received: by 2002:a5d:41c6:: with SMTP id e6-v6mr4044599wrq.25.1528892249983;
        Wed, 13 Jun 2018 05:17:29 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id 137-v6sm4943673wmv.28.2018.06.13.05.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 05:17:29 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: [PATCH v4 3/5] sched/core: Streamlining calls to task_rq_unlock()
Date:   Wed, 13 Jun 2018 14:17:09 +0200
Message-Id: <20180613121711.5018-4-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180613121711.5018-1-juri.lelli@redhat.com>
References: <20180613121711.5018-1-juri.lelli@redhat.com>
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
---
 kernel/sched/core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d1555185c054..ca788f74259d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4237,8 +4237,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	 * Changing the policy of the stop threads its a very bad idea:
 	 */
 	if (p == rq->stop) {
-		task_rq_unlock(rq, p, &rf);
-		return -EINVAL;
+		retval = -EINVAL;
+		goto unlock;
 	}
 
 	/*
@@ -4254,8 +4254,8 @@ static int __sched_setscheduler(struct task_struct *p,
 			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
-		task_rq_unlock(rq, p, &rf);
-		return 0;
+		retval = 0;
+		goto unlock;
 	}
 change:
 
@@ -4268,8 +4268,8 @@ static int __sched_setscheduler(struct task_struct *p,
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
@@ -4284,8 +4284,8 @@ static int __sched_setscheduler(struct task_struct *p,
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
@@ -4304,8 +4304,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	 * is available.
 	 */
 	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, attr)) {
-		task_rq_unlock(rq, p, &rf);
-		return -EBUSY;
+		retval = -EBUSY;
+		goto unlock;
 	}
 
 	p->sched_reset_on_fork = reset_on_fork;
@@ -4361,6 +4361,10 @@ static int __sched_setscheduler(struct task_struct *p,
 	preempt_enable();
 
 	return 0;
+
+unlock:
+	task_rq_unlock(rq, p, &rf);
+	return retval;
 }
 
 static int _sched_setscheduler(struct task_struct *p, int policy,
-- 
2.14.3


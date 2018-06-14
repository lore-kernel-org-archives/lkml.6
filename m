Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 782C0C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F59208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4eXILZb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F59208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754886AbeFNKdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:33:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51609 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754724AbeFNKdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:33:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id r15-v6so9680320wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 03:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BNV/ih/tOFiOY23P07soJ7dY8Nrc7hPd77TJUNr/gkY=;
        b=U4eXILZbNhk9GM6A74uUo5UEIyDvqx90Cns4uKdgJVk4KkO5cKSCSqrRGh3BNa5Wp8
         DQYYqQ4jWpfuOxRCIVME/FYXpqeUrEKzqyq8Vz7A+XTzgwg4XqwdAtq1CL5vIAV/NjcG
         o9uh4VKG6r6hkFmqCAzVQWZ7ck2uP7h30n2rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BNV/ih/tOFiOY23P07soJ7dY8Nrc7hPd77TJUNr/gkY=;
        b=Pgr8J13lihZfdc2Un9VpVkdQgoKBPmtRRtGWqPCjP2FwNkGLDeR6E4ONvHkGFQCuVL
         ZiUOmhcfy/6PlVzF0lyck9+UsdfNEvVJ30UYCToIf25tqt640alGqrHpydi/jWERPcSO
         mHQg323uQL7HVEnlgiMXKjbs8V/KlhTb6XgjlS3B8aLrE+IO4z2nJVH7lHqdSJoPlXy3
         Klgy3VPs4q0gl6T9b0+lZmdkul0lzHbH3/fZw9ZOFZ/hz1X8NpTiSEz+/S6ncffAO9pB
         vekKstYoezf8GJHA4o1R4h5v8tJLlN3/YFBrR8TAowFj12iuD0ekSwxmFLEcTzm88ys5
         sCVw==
X-Gm-Message-State: APt69E0CV0tNdHTvUp5u+GOQhKdHiPIiYZdXJ1n8knJaW+COW4dzoUpM
        QgunbkTGTPysqjohgd1SN/yG0A==
X-Google-Smtp-Source: ADUXVKK7YiyQH+2VmFDHCHqTNKb2Gu2mh+FEsjuB5LqpwhF2x8p7vCSJxQ9pJ+507t0j/X/XnQRUmA==
X-Received: by 2002:a1c:f308:: with SMTP id q8-v6mr1353901wmq.6.1528972392110;
        Thu, 14 Jun 2018 03:33:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c494:f0e:88b7:c1b])
        by smtp.gmail.com with ESMTPSA id u15-v6sm7389975wma.37.2018.06.14.03.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 03:33:11 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, patrick.bellasi@arm.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/util_est: fix util_est_dequeue() for throttled cfs rq
Date:   Thu, 14 Jun 2018 12:33:00 +0200
Message-Id: <1528972380-16268-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a cfs_rq is throttled, parent cfs_rq->nr_running is decreased and
everything happens at cfs_rq level. Currently util_est stays unchanged
in such case and it keeps accounting the utilization of throttled tasks.
This can somewhat make sense as we don't dequeue tasks but only throttled
cfs_rq.
If a task of another group is enqueued/dequeued and root cfs_rq becomes
idle during the dequeue, util_est will be cleared whereas it was
accounting util_est of throttled tasks before. So the behavior of util_est
is not always the same regarding throttled tasks and depends of side
activity. Furthermore, util_est will not be updated when the cfs_rq is
unthrottled as everything happens at cfs rq level. Main results is that
util_est will stay null whereas we now have running tasks. We have to wait
for the next dequeue/enqueue of the previously throttled tasks to get an
up to date util_est.

Remove the assumption that cfs_rq's estimated utilization of a CPU is 0
if there is no running task so the util_est of a task remains until the
latter is dequeued even if its cfs_rq has been throttled.

Fixes: 7f65ea42eb00 ("sched/fair: Add util_est on top of PELT")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e497c05..d3121fc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3982,18 +3982,10 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 	if (!sched_feat(UTIL_EST))
 		return;
 
-	/*
-	 * Update root cfs_rq's estimated utilization
-	 *
-	 * If *p is the last task then the root cfs_rq's estimated utilization
-	 * of a CPU is 0 by definition.
-	 */
-	ue.enqueued = 0;
-	if (cfs_rq->nr_running) {
-		ue.enqueued  = cfs_rq->avg.util_est.enqueued;
-		ue.enqueued -= min_t(unsigned int, ue.enqueued,
-				     (_task_util_est(p) | UTIL_AVG_UNCHANGED));
-	}
+	/* Update root cfs_rq's estimated utilization */
+	ue.enqueued  = cfs_rq->avg.util_est.enqueued;
+	ue.enqueued -= min_t(unsigned int, ue.enqueued,
+			     (_task_util_est(p) | UTIL_AVG_UNCHANGED));
 	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
 
 	/*
-- 
2.7.4


Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBCDC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6875121872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCdlDgXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfBGKqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:46:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34829 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBGKqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:46:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so4597089pfi.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 02:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b2MAKObbwgm8lJA0u2i67iep8woAREaJgQav9usjeCw=;
        b=VCdlDgXPZVK2DY38U2rVU5hpR0QczAQdo1nb8NTcvLX0RVv3WskMBzr6HTw3oTAzsD
         K946YhyE6G9QT4QCvLWhffOatMbZSkhbIYjGvNXjjvAz9XCSicrPX+2xI42KPE3uJ7X8
         Kw0UZBntq93e56NTgna1QtOEr/J0ZWAfwTCpmF6VYn8/llrc4mcU0VRdV0ZZl6k9UGmL
         lD4fO0Nn16IKcFWsLDVBDcN24JY6+08jChQVJmSWAL4dZd3jquRsdytgBUM7RZg4RPMI
         DKTDC0eGnil+yKfINZCL3ekvz0qbwmm9xeGwORGUZmI7UriMj/1zfaWiQV65aMK021E8
         +laQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b2MAKObbwgm8lJA0u2i67iep8woAREaJgQav9usjeCw=;
        b=dcwf6ltloozhN/gFjLbu2+L5mVDX8BuPPGaVb6bLGM7BE9cNx2evnt5x6peTlv5nSH
         zmVGW4Auic9RQZn0q5wm5w+woxUn07aZ6WcjAef1yXaXoAycinzDHNnFCR9vpfm9IySc
         +t0AGaJ03Axju1O3Q+MqX/wLdzpjc9YTHLVC9X34F+vAHcbhMrIZM0Wh6tB3a2UBo352
         lZtK8oMJRqx/puS4DDAhCYSx3NKm4/MVCVdjupc1tt7eP65Dv/WBV1mtEsLiRNmsg3em
         aZ5MiH7EKHoiAyiN8YSIAnrXA2/6oY9f+Eh1szwQL/rHCYuvvxOAh67VkTUayw1Bab7B
         Dtfw==
X-Gm-Message-State: AHQUAubsdwOFVMFQVgwzlYfSCfHd/sS2lSCSH8EDbc12H63F1vIcApIh
        qK1hxDAiPYa4Y+TgF1mrpVPXyA==
X-Google-Smtp-Source: AHgI3IbXWsAhjn/cIdHJ/BrAPnfEYpDagAvI+yCApfzOxuFTVeJhgKwVcT+VmqHC6zFRo76ANNasDw==
X-Received: by 2002:a63:534c:: with SMTP id t12mr14114184pgl.205.1549536374129;
        Thu, 07 Feb 2019 02:46:14 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id m67sm12209839pfm.73.2019.02.07.02.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:46:13 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched/fair: Don't pass sd to select_idle_smt()
Date:   Thu,  7 Feb 2019 16:16:05 +0530
Message-Id: <f91c5e118183e79d4a982e9ac4ce5e47948f6c1b.1549536337.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameter sd isn't getting used in select_idle_smt(), drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 38d4669aa2ef..8d5c82342a36 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6102,7 +6102,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 /*
  * Scan the local SMT mask for idle CPUs.
  */
-static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_smt(struct task_struct *p, int target)
 {
 	int cpu;
 
@@ -6126,7 +6126,7 @@ static inline int select_idle_core(struct task_struct *p, struct sched_domain *s
 	return -1;
 }
 
-static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+static inline int select_idle_smt(struct task_struct *p, int target)
 {
 	return -1;
 }
@@ -6231,7 +6231,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-	i = select_idle_smt(p, sd, target);
+	i = select_idle_smt(p, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-- 
2.20.1.321.g9e740568ce00


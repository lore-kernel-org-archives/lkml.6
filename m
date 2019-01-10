Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D15C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14C4213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OdfmzDI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfAJWIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:08:21 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36940 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbfAJWIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:08:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id c25so5400326pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gvi1iRKLPW3qMsLI6kumJKUVDFg5NUDF94Fa5S4jUjU=;
        b=OdfmzDI9CcL+2VXf5ocSTDNyRd9IHxsxjkC2PxQORGPsj0X7psQuS3Umk7pGcF+y1N
         2erlFLdCgBeLM6sKPD7UtLOkmNwDY3Q8+bYqlRpPzxYaWaUO9Ku8vgf0RYaWAZcgeQDp
         +OycaSHT78G3F5f1FH0QvE8CIaRHZ77mkmp4zAhGBT3h+OnHhOI95bD1lAbzndzCJcN8
         kAYejfjaXIKLAAr8fN6d+3sQPM/sqCNbQm4TKt/fmoxpEaDlXqQnfBs/W76fh5Si1HRb
         2Ywu2dMPM2Aw/LeKx3cXLOODPCznDtA+9g6oDheS4QVxUuvqwreMha9jFWiYakAAlmvd
         BQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gvi1iRKLPW3qMsLI6kumJKUVDFg5NUDF94Fa5S4jUjU=;
        b=LHkEBAC921QsSuThQc40DMTPKEw/d7tXRDjT782WBhjRdCxjOWFtm7K16dNcTHe4x/
         WuQOfb+gHmRNeRWnmLUW0Jkp5ki3Xxqs1mQhGemBCyHt0H8ZHtMrJyZhPcoIRHnFMljw
         A37wTjPG7+YpvaCBLuOxVJrT/BZ7kUmkWDOAqlASz6DjD3MWQvDO+jCGzeADTOrNnQ/L
         XtvqTsttEtHTgLoHjhyGEAaZQ4rasshq5CfIKnm43B0wztVjPusucFrsveg+QArG8qa5
         TYJmagUBJSzxHv4c3ic3CTHDEbLzJvF/MT5M3kQaOtbHCmO6a1NJY3UH0l3qTP8E1kne
         3dMg==
X-Gm-Message-State: AJcUukcnQtas6rihyx7gRZWvaOM89SMoA3H5GKyVm12csA9LW3lDUMrj
        naVBwLsoyH2nCXYsi6T+I+xLNA==
X-Google-Smtp-Source: ALg8bN6gohws80ogM6bKIwE/KhY+FsflDzhULCDncx+SgcmmVujJEzOQajCDWV/20rlAO9DnbJk3/Q==
X-Received: by 2002:a62:3943:: with SMTP id g64mr12126011pfa.114.1547158094933;
        Thu, 10 Jan 2019 14:08:14 -0800 (PST)
Received: from surenb0.mtv.corp.google.com ([2620:0:1000:1612:3320:4357:47df:276b])
        by smtp.googlemail.com with ESMTPSA id p7sm152958019pfj.72.2019.01.10.14.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 14:08:14 -0800 (PST)
From:   Suren Baghdasaryan <surenb@google.com>
To:     gregkh@linuxfoundation.org
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 4/5] psi: rename psi fields in preparation for psi trigger addition
Date:   Thu, 10 Jan 2019 14:07:17 -0800
Message-Id: <20190110220718.261134-5-surenb@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190110220718.261134-1-surenb@google.com>
References: <20190110220718.261134-1-surenb@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming psi_group structure member fields used for calculating psi
totals and averages for clear distinction between them and trigger-related
fields that will be added next.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/psi_types.h | 15 ++++++++-------
 kernel/sched/psi.c        | 26 ++++++++++++++------------
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 762c6bb16f3c..47757668bdcb 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -69,20 +69,21 @@ struct psi_group_cpu {
 };
 
 struct psi_group {
-	/* Protects data updated during an aggregation */
-	struct mutex stat_lock;
+	/* Protects data used by the aggregator */
+	struct mutex update_lock;
 
 	/* Per-cpu task state & time tracking */
 	struct psi_group_cpu __percpu *pcpu;
 
-	/* Periodic aggregation state */
-	u64 total_prev[NR_PSI_STATES - 1];
-	u64 last_update;
-	u64 next_update;
 	struct delayed_work clock_work;
 
-	/* Total stall times and sampled pressure averages */
+	/* Total stall times observed */
 	u64 total[NR_PSI_STATES - 1];
+
+	/* Running pressure averages */
+	u64 avg_total[NR_PSI_STATES - 1];
+	u64 avg_last_update;
+	u64 avg_next_update;
 	unsigned long avg[NR_PSI_STATES - 1][3];
 };
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 2262d920295f..c366503ba135 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -172,9 +172,9 @@ static void group_init(struct psi_group *group)
 
 	for_each_possible_cpu(cpu)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
-	group->next_update = sched_clock() + psi_period;
+	group->avg_next_update = sched_clock() + psi_period;
 	INIT_DELAYED_WORK(&group->clock_work, psi_update_work);
-	mutex_init(&group->stat_lock);
+	mutex_init(&group->update_lock);
 }
 
 void __init psi_init(void)
@@ -277,7 +277,7 @@ static bool update_stats(struct psi_group *group)
 	int cpu;
 	int s;
 
-	mutex_lock(&group->stat_lock);
+	mutex_lock(&group->update_lock);
 
 	/*
 	 * Collect the per-cpu time buckets and average them into a
@@ -318,7 +318,7 @@ static bool update_stats(struct psi_group *group)
 
 	/* avgX= */
 	now = sched_clock();
-	expires = group->next_update;
+	expires = group->avg_next_update;
 	if (now < expires)
 		goto out;
 	if (now - expires > psi_period)
@@ -331,14 +331,14 @@ static bool update_stats(struct psi_group *group)
 	 * But the deltas we sample out of the per-cpu buckets above
 	 * are based on the actual time elapsing between clock ticks.
 	 */
-	group->next_update = expires + ((1 + missed_periods) * psi_period);
-	period = now - (group->last_update + (missed_periods * psi_period));
-	group->last_update = now;
+	group->avg_next_update = expires + ((1 + missed_periods) * psi_period);
+	period = now - (group->avg_last_update + (missed_periods * psi_period));
+	group->avg_last_update = now;
 
 	for (s = 0; s < NR_PSI_STATES - 1; s++) {
 		u32 sample;
 
-		sample = group->total[s] - group->total_prev[s];
+		sample = group->total[s] - group->avg_total[s];
 		/*
 		 * Due to the lockless sampling of the time buckets,
 		 * recorded time deltas can slip into the next period,
@@ -358,11 +358,11 @@ static bool update_stats(struct psi_group *group)
 		 */
 		if (sample > period)
 			sample = period;
-		group->total_prev[s] += sample;
+		group->avg_total[s] += sample;
 		calc_avgs(group->avg[s], missed_periods, sample, period);
 	}
 out:
-	mutex_unlock(&group->stat_lock);
+	mutex_unlock(&group->update_lock);
 	return nonidle_total;
 }
 
@@ -390,8 +390,10 @@ static void psi_update_work(struct work_struct *work)
 		u64 now;
 
 		now = sched_clock();
-		if (group->next_update > now)
-			delay = nsecs_to_jiffies(group->next_update - now) + 1;
+		if (group->avg_next_update > now) {
+			delay = nsecs_to_jiffies(
+				group->avg_next_update - now) + 1;
+		}
 		schedule_delayed_work(dwork, delay);
 	}
 }
-- 
2.20.1.97.g81188d93c3-goog


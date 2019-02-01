Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CAAC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848CA20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYqqeHxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfBAGQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 01:16:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41377 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfBAGQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 01:16:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so2656121plm.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 22:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OWAwfc5wYY5PtG8pBPOfVRPrY8t3iMD9QATzlWF/GMo=;
        b=bYqqeHxuhWXUZATJfWLOrNfmFCQW9gujoTXIX3aKUkbBC8WV6YN4mlX4cZhFQdpzCf
         g/i7uoJlUX/RLzMm8/vxCsf0aX8RzFAHLjIeQ2GP0Q76iXL8vgmgbFPwALiCHMTBWcw8
         TIPdjkwdI8oG6Gg67BMLF7X+2Qkv6AY/gHjQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OWAwfc5wYY5PtG8pBPOfVRPrY8t3iMD9QATzlWF/GMo=;
        b=hmSuI0SDQmp5I90LaiqSx1qAtFuQybkqgcI5kMCfwFVKMQkGqwBAhCgTULceDam7R3
         /iB18ybCDJMINi/5Rik2KjTC94hcokyuJYQj4QqCxM4KSSOdZ793oluJer5wWQepdpRj
         ZQZfLjyzyi0JMzy3FVq1jK+viCN3hdsOWtqdZUlFifbpqR5HZdZaiYnjzn0/I7yr8Z2i
         wDW2udSs6GZKg7J0ZDYT0Grkdr+ImIT0uwsOXyNsDaoFo1hkR7E+auWWbmymJc7blFI0
         nzg6ECm6OGn0/6eOrbYDDPSnOf8ywKFjkm4MdHeBPEp65/KmXk2MkBpHi+w80zaoqRiX
         edBw==
X-Gm-Message-State: AJcUukfj7Khg7nyUQhwFMGtMAtotyKGsrYb/R5NcCSDlXBDdaqfZL76Q
        04SDliVUUKnJhhYCFHILPDR5CQ==
X-Google-Smtp-Source: ALg8bN5tliiYj16YVnP7/Bof7v4XupPN8vWp6CW/mRpZ6U/Fly30woq1yIFK9vRbGiEWgpqY8sx7Eg==
X-Received: by 2002:a17:902:7791:: with SMTP id o17mr37608663pll.60.1549001759710;
        Thu, 31 Jan 2019 22:15:59 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id o4sm10080341pgs.12.2019.01.31.22.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 22:15:58 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpufreq: stats: Fix concurrency issues while resetting stats
Date:   Fri,  1 Feb 2019 11:45:45 +0530
Message-Id: <927dcc1de6acad3dd2cfae4e300e6fee4f665101.1549001732.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
In-Reply-To: <d5d8c15aca712342350d2f451002f55e15e9e93b.1549001732.git.viresh.kumar@linaro.org>
References: <d5d8c15aca712342350d2f451002f55e15e9e93b.1549001732.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible for cpufreq_stats_clear_table() and
cpufreq_stats_record_transition() to get called concurrently and they
will try to update same variables simultaneously and may lead to
corruption of data.

Prevent that with the help of existing spinlock.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 941e63e3e652..e2db5581489a 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -31,20 +31,20 @@ static void cpufreq_stats_update(struct cpufreq_stats *stats)
 {
 	unsigned long long cur_time = get_jiffies_64();
 
-	spin_lock(&cpufreq_stats_lock);
 	stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
 	stats->last_time = cur_time;
-	spin_unlock(&cpufreq_stats_lock);
 }
 
 static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
 {
 	unsigned int count = stats->max_state;
 
+	spin_lock(&cpufreq_stats_lock);
 	memset(stats->time_in_state, 0, count * sizeof(u64));
 	memset(stats->trans_table, 0, count * count * sizeof(int));
 	stats->last_time = get_jiffies_64();
 	stats->total_trans = 0;
+	spin_unlock(&cpufreq_stats_lock);
 }
 
 static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
@@ -62,7 +62,10 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 	if (policy->fast_switch_enabled)
 		return 0;
 
+	spin_lock(&cpufreq_stats_lock);
 	cpufreq_stats_update(stats);
+	spin_unlock(&cpufreq_stats_lock);
+
 	for (i = 0; i < stats->state_num; i++) {
 		len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
 			(unsigned long long)
@@ -239,9 +242,11 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
 	if (old_index == -1 || new_index == -1 || old_index == new_index)
 		return;
 
+	spin_lock(&cpufreq_stats_lock);
 	cpufreq_stats_update(stats);
 
 	stats->last_index = new_index;
 	stats->trans_table[old_index * stats->max_state + new_index]++;
 	stats->total_trans++;
+	spin_unlock(&cpufreq_stats_lock);
 }
-- 
2.20.1.321.g9e740568ce00


Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134ADC282D8
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE3920989
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbfAaBvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:51:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43855 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfAaBvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 20:51:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so704613plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 17:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lselr77VbRukcmW0lwT2WV7foY0fOvPgFp9daJmbpgQ=;
        b=ZAjSBQIlTpPfykTlVbP4NqKUUhgkcKAeYEA2BfPM4B9Gs4ryMmozyBLmcoXJIV2VJn
         73duYfUa14IPkYIlcI85caNoGj/zxvgDMBW11g9F7Qe+jeuwotjX12cNdf4e9L7oL995
         MqYEAInsP/7SPC9uIhTezMpVg6sdACGngu0+v8IfzvCaBsh2Lm1bYhNl3Q3EcedvJH04
         OZ5Sedq/QFhdMcBCK6Wfzd265nidSmLuSfBOTNeazBM+1T49q+PNhaw5B40j+YsNYh61
         /qV9VfYiqUnW9WV6O1Hv7DLnsVY8EXwKFIS+XUEG0axre+v30j7xXr3Uafj5W8uKpqXv
         qKgg==
X-Gm-Message-State: AJcUukfZH0NHespQ+8k+nyose3VwO9Tc95fL24ImPiSdDyrrPhxHNZgh
        5Qk5joelRD/AmNbljJangzy4Sw==
X-Google-Smtp-Source: ALg8bN4SAUBlBM/IU9+S3t9Fl7Ith0t7QZ3Azed+PiKxNAaSM0TljGf48TaudtIff5EymeK2epV15w==
X-Received: by 2002:a17:902:8607:: with SMTP id f7mr31983502plo.123.1548899507315;
        Wed, 30 Jan 2019 17:51:47 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d3sm2775244pgl.64.2019.01.30.17.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 17:51:46 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] cpufreq: Record stats when fast switching is enabled
Date:   Wed, 30 Jan 2019 17:51:39 -0800
Message-Id: <20190131015139.126890-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fast switching is enabled currently no cpufreq stats are
recorded and the corresponding sysfs attributes appear empty (see
also commit 1aefc75b2449 ("cpufreq: stats: Make the stats code
non-modular")).

Record the stats after a successful fast switch and re-enable access
through sysfs when fast switching is enabled. Since
cpufreq_stats_update() can now be called in interrupt context (during
a fast switch) disable local IRQs while holding the stats spinlock.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
The change is so simple that I wonder if I'm missing some important
reason why the stats can't/shouldn't be updated during/after a fast
switch ...

I would expect that holding the stats spinlock briefly in
cpufreq_stats_update() shouldn't be a problem. In theory it would
also be an option to have a per stats lock, though it seems overkill
from my (possibly ignorant) point of view.
---
 drivers/cpufreq/cpufreq.c       |  8 +++++++-
 drivers/cpufreq/cpufreq_stats.c | 11 +++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e35a886e00bcf..63aadb0bbddfe 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1857,9 +1857,15 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq)
 {
+	unsigned int freq;
+
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
 
-	return cpufreq_driver->fast_switch(policy, target_freq);
+	freq = cpufreq_driver->fast_switch(policy, target_freq);
+	if (freq)
+		cpufreq_stats_record_transition(policy, freq);
+
+	return freq;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
 
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 1572129844a5b..21b919bfaeccf 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -30,11 +30,12 @@ struct cpufreq_stats {
 static void cpufreq_stats_update(struct cpufreq_stats *stats)
 {
 	unsigned long long cur_time = get_jiffies_64();
+	unsigned long flags;
 
-	spin_lock(&cpufreq_stats_lock);
+	spin_lock_irqsave(&cpufreq_stats_lock, flags);
 	stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
 	stats->last_time = cur_time;
-	spin_unlock(&cpufreq_stats_lock);
+	spin_unlock_irqrestore(&cpufreq_stats_lock, flags);
 }
 
 static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
@@ -58,9 +59,6 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 	ssize_t len = 0;
 	int i;
 
-	if (policy->fast_switch_enabled)
-		return 0;
-
 	cpufreq_stats_update(stats);
 	for (i = 0; i < stats->state_num; i++) {
 		len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
@@ -84,9 +82,6 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 	ssize_t len = 0;
 	int i, j;
 
-	if (policy->fast_switch_enabled)
-		return 0;
-
 	len += snprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
 	len += snprintf(buf + len, PAGE_SIZE - len, "         : ");
 	for (i = 0; i < stats->state_num; i++) {
-- 
2.20.1.495.gaa96b0ce6b-goog


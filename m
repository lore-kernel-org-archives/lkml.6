Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GE8aBaOiGFtWVAAAmS7hNA
	; Thu, 07 Jun 2018 03:12:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F13A7608BA; Thu,  7 Jun 2018 03:12:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5D102605BD;
	Thu,  7 Jun 2018 03:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D102605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932319AbeFGDMb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 23:12:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:43515 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752800AbeFGDM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 23:12:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2018 20:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,485,1520924400";
   d="scan'208";a="230565994"
Received: from sandybridge-desktop.sh.intel.com ([10.239.160.116])
  by orsmga005.jf.intel.com with ESMTP; 06 Jun 2018 20:12:27 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Artem S Tashkinov <t.artem@mailcity.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH][RFC] sched: cpufreq: Fix long idle judgement logic in load calculation
Date: Thu,  7 Jun 2018 11:17:34 +0800
Message-Id: <1528341454-16991-1-git-send-email-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to current code implementation, detecting the long
idle period is done by checking if the interval between two
adjacent utilization update handers is long enough. Although
this mechanism can detect if the idle period is long enough
(no utilization hooks invoked during idle period), it might
not contain a corner case: if the task has occupied the cpu
for too long which causes no context switch during that
period, then no utilization handler will be launched until this
high prio task is switched out. As a result, the idle_periods
field might be calculated incorrectly because it regards the
100% load as 0% and makes the conservative governor who uses
this field confusing.

Change the judgement to compare the idle_time with sampling_rate
directly.

Reported-by: Artem S. Tashkinov <t.artem@mailcity.com>
Cc: Artem S Tashkinov <t.artem@mailcity.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/cpufreq/cpufreq_governor.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 871bf9c..9792c80 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -165,7 +165,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			 * calls, so the previous load value can be used then.
 			 */
 			load = j_cdbs->prev_load;
-		} else if (unlikely(time_elapsed > 2 * sampling_rate &&
+		} else if (((int)idle_time > 0) && unlikely(idle_time > 2 * sampling_rate &&
 				    j_cdbs->prev_load)) {
 			/*
 			 * If the CPU had gone completely idle and a task has
@@ -185,10 +185,8 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			 * clear prev_load to guarantee that the load will be
 			 * computed again next time.
 			 *
-			 * Detecting this situation is easy: the governor's
-			 * utilization update handler would not have run during
-			 * CPU-idle periods.  Hence, an unusually large
-			 * 'time_elapsed' (as compared to the sampling rate)
+			 * Detecting this situation is easy: an unusually large
+			 * 'idle_time' (as compared to the sampling rate)
 			 * indicates this scenario.
 			 */
 			load = j_cdbs->prev_load;
@@ -217,8 +215,8 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			j_cdbs->prev_load = load;
 		}
 
-		if (time_elapsed > 2 * sampling_rate) {
-			unsigned int periods = time_elapsed / sampling_rate;
+		if (((int)idle_time > 0) && (idle_time > 2 * sampling_rate)) {
+			unsigned int periods = idle_time / sampling_rate;
 
 			if (periods < idle_periods)
 				idle_periods = periods;
-- 
2.7.4

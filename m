Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1E4C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471D22075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471D22075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeJHWXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:23:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:10653 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbeJHWXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:23:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 08:11:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,357,1534834800"; 
   d="scan'208";a="93292011"
Received: from mucrsa0015.imu.intel.com ([10.62.163.98])
  by fmsmga002.fm.intel.com with ESMTP; 08 Oct 2018 08:11:08 -0700
From:   Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: conservative: Fix requested_freq handling
Date:   Mon,  8 Oct 2018 17:09:00 +0200
Message-Id: <20181008150901.19667-1-waldemar.rymarkiewicz@gmail.com>
X-Mailer: git-send-email 2.10.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>

The governor updates dbs_info->requested_freq only after increasing or
decreasing frequency. There is, however, an use case when this is not
sufficient.

Imagine, external module constraining cpufreq policy in a way that policy->max
= policy->min = max_available_freq (eg. 1Ghz). CPUfreq will set freq to
max_freq and conservative gov will not try downscale/upscale due to the
limits. It will just exit instead

    if (requested_freq > policy->max || requested_freq < policy->min)
            //max=min=1Ghz -> requested_freq=cur=1Ghz
            requested_freq = policy->cur;
    [...]
    if (requested_freq == policy->max)
             goto out;

In a result, dbs_info->requested_freq is not updated with newly calculated
requested_freq=1Ghz. Next, execution of update routine will use again
previously stored requested_freq (in my case it was min_available_freq)

    [...]
    unsigned int requested_freq = dbs_info->requested_freq;
    [....]

Now, when external module returns to previous policy limits that is
policy->min = min_available_freq and policy->max = max_available_freq,
conservative governor is not able to decrease frequency because stored
requested_freq is still or rather already set to min_available_freq so
the check (for decreasing)

    [...]
    if (load < cs_tuners->down_threshold) {
    [....]
           if (requested_freq == policy->min)
                   goto out;
    [...]

returns from routine before it does any freq change. To fix that just update
dbs_info->requested_freq every time we go out from the update routine.

Signed-off-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index f20f20a..7f90f6e 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -113,7 +113,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 			requested_freq = policy->max;
 
 		__cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_H);
-		dbs_info->requested_freq = requested_freq;
 		goto out;
 	}
 
@@ -136,10 +135,10 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 			requested_freq = policy->min;
 
 		__cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_L);
-		dbs_info->requested_freq = requested_freq;
 	}
 
  out:
+	dbs_info->requested_freq = requested_freq;
 	return dbs_data->sampling_rate;
 }
 
-- 
2.10.1


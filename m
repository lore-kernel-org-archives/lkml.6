Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeFEVnl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:43:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:37414 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752358AbeFEVmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:42:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,479,1520924400";
   d="scan'208";a="47023742"
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net
Cc: peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        viresh.kumar@linaro.org, ggherdovich@suse.cz,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/4] cpufreq: intel_pstate: New sysfs entry to control HWP boost
Date: Tue,  5 Jun 2018 14:42:41 -0700
Message-Id: <20180605214242.62156-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new attribute is added to intel_pstate sysfs to enable/disable
HWP dynamic performance boost.

Reported-by: Mel Gorman <mgorman@techsingularity.net>
Tested-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 5b2b6b6d1ff4..70bf63bb4e0e 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1033,6 +1033,30 @@ static ssize_t store_min_perf_pct(struct kobject *a, struct attribute *b,
 	return count;
 }
 
+static ssize_t show_hwp_dynamic_boost(struct kobject *kobj,
+				struct attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", hwp_boost);
+}
+
+static ssize_t store_hwp_dynamic_boost(struct kobject *a, struct attribute *b,
+				       const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &input);
+	if (ret)
+		return ret;
+
+	mutex_lock(&intel_pstate_driver_lock);
+	hwp_boost = !!input;
+	intel_pstate_update_policies();
+	mutex_unlock(&intel_pstate_driver_lock);
+
+	return count;
+}
+
 show_one(max_perf_pct, max_perf_pct);
 show_one(min_perf_pct, min_perf_pct);
 
@@ -1042,6 +1066,7 @@ define_one_global_rw(max_perf_pct);
 define_one_global_rw(min_perf_pct);
 define_one_global_ro(turbo_pct);
 define_one_global_ro(num_pstates);
+define_one_global_rw(hwp_dynamic_boost);
 
 static struct attribute *intel_pstate_attributes[] = {
 	&status.attr,
@@ -1082,6 +1107,11 @@ static void __init intel_pstate_sysfs_expose_params(void)
 	rc = sysfs_create_file(intel_pstate_kobject, &min_perf_pct.attr);
 	WARN_ON(rc);
 
+	if (hwp_active) {
+		rc = sysfs_create_file(intel_pstate_kobject,
+				       &hwp_dynamic_boost.attr);
+		WARN_ON(rc);
+	}
 }
 /************************** sysfs end ************************/
 
-- 
2.13.6

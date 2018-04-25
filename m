Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751181AbeDYGPJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 02:15:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751027AbeDYGPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 02:15:06 -0400
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        svaidy@linux.vnet.ibm.com,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Remove global pstate ramp-down timer in POWER9
Date: Wed, 25 Apr 2018 11:44:55 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18042506-0012-0000-0000-000005CE7044
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042506-0013-0000-0000-0000194AE71F
Message-Id: <1524636895-27185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804250055
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

POWER9 doesnot support global pstate requests for the chip. So remove
the timer logic which slowly ramps down the global pstate in P9
platforms.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 0591874..71f8682 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -750,8 +750,13 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 
 	cur_msec = jiffies_to_msecs(get_jiffies_64());
 
-	spin_lock(&gpstates->gpstate_lock);
 	freq_data.pstate_id = idx_to_pstate(new_index);
+	if (!gpstates) {
+		freq_data.gpstate_id = freq_data.pstate_id;
+		goto no_gpstate;
+	}
+
+	spin_lock(&gpstates->gpstate_lock);
 
 	if (!gpstates->last_sampled_time) {
 		gpstate_idx = new_index;
@@ -801,6 +806,7 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
 
 	spin_unlock(&gpstates->gpstate_lock);
 
+no_gpstate:
 	/*
 	 * Use smp_call_function to send IPI and execute the
 	 * mtspr on target CPU.  We could do that without IPI
@@ -835,6 +841,13 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		kernfs_put(kn);
 	}
 
+	policy->freq_table = powernv_freqs;
+	policy->fast_switch_possible = true;
+
+	if (pvr_version_is(PVR_POWER9))
+		return 0;
+
+	/* Initialise Gpstate ramp-down timer only on POWER8 */
 	gpstates =  kzalloc(sizeof(*gpstates), GFP_KERNEL);
 	if (!gpstates)
 		return -ENOMEM;
@@ -849,15 +862,14 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
 				msecs_to_jiffies(GPSTATE_TIMER_INTERVAL);
 	spin_lock_init(&gpstates->gpstate_lock);
 
-	policy->freq_table = powernv_freqs;
-	policy->fast_switch_possible = true;
 	return 0;
 }
 
 static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	/* timer is deleted in cpufreq_cpu_stop() */
-	kfree(policy->driver_data);
+	if (policy->driver_data)
+		kfree(policy->driver_data);
 
 	return 0;
 }
@@ -990,7 +1002,8 @@ static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 	freq_data.pstate_id = idx_to_pstate(powernv_pstate_info.min);
 	freq_data.gpstate_id = idx_to_pstate(powernv_pstate_info.min);
 	smp_call_function_single(policy->cpu, set_pstate, &freq_data, 1);
-	del_timer_sync(&gpstates->timer);
+	if (gpstates)
+		del_timer_sync(&gpstates->timer);
 }
 
 static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
-- 
1.8.3.1

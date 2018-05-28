Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754769AbeE1Re6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 13:34:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49626 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754680AbeE1Rex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 13:34:53 -0400
From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH] cpuidle/powernv : Add Description for cpuidle state
Date: Mon, 28 May 2018 23:04:42 +0530
X-Mailer: git-send-email 2.14.1
X-TM-AS-GCONF: 00
x-cbid: 18052817-0020-0000-0000-000004220EDD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052817-0021-0000-0000-000042B76149
Message-Id: <20180528173442.100642-1-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805280211
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Names of cpuidle states were being used for description of states
in POWER as no descriptions were added in device tree. This patch
reads description for idle states which have been added in device
tree.
The description for idle states in case of POWER can be printed
using "cpupower monitor -l" or "cpupower idle-info".

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---

The skiboot patch which adds description for idle states in device tree
can be found here: https://patchwork.ozlabs.org/patch/921637/

 drivers/cpuidle/cpuidle-powernv.c | 17 +++++++++++++----
 include/linux/cpuidle.h           |  2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 1a8234e706bc..d3915a965128 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -133,7 +133,7 @@ static int stop_loop(struct cpuidle_device *dev,
 static struct cpuidle_state powernv_states[CPUIDLE_STATE_MAX] = {
 	{ /* Snooze */
 		.name = "snooze",
-		.desc = "snooze",
+		.desc = "idle polling state",
 		.exit_latency = 0,
 		.target_residency = 0,
 		.enter = snooze_loop },
@@ -206,6 +206,7 @@ static int powernv_cpuidle_driver_init(void)
 }
 
 static inline void add_powernv_state(int index, const char *name,
+				     const char *desc,
 				     unsigned int flags,
 				     int (*idle_fn)(struct cpuidle_device *,
 						    struct cpuidle_driver *,
@@ -215,7 +216,7 @@ static inline void add_powernv_state(int index, const char *name,
 				     u64 psscr_val, u64 psscr_mask)
 {
 	strlcpy(powernv_states[index].name, name, CPUIDLE_NAME_LEN);
-	strlcpy(powernv_states[index].desc, name, CPUIDLE_NAME_LEN);
+	strlcpy(powernv_states[index].desc, desc, CPUIDLE_DESC_LEN);
 	powernv_states[index].flags = flags;
 	powernv_states[index].target_residency = target_residency;
 	powernv_states[index].exit_latency = exit_latency;
@@ -250,6 +251,7 @@ static int powernv_add_idle_states(void)
 	u64 psscr_val[CPUIDLE_STATE_MAX];
 	u64 psscr_mask[CPUIDLE_STATE_MAX];
 	const char *names[CPUIDLE_STATE_MAX];
+	const char *descs[CPUIDLE_STATE_MAX];
 	u32 has_stop_states = 0;
 	int i, rc;
 	u32 supported_flags = pnv_get_supported_cpuidle_states();
@@ -311,6 +313,11 @@ static int powernv_add_idle_states(void)
 		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
 		goto out;
 	}
+	if (of_property_read_string_array(power_mgt,
+		"ibm,cpu-idle-state-descs", descs, dt_idle_states) < 0) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-descs in DT\n");
+		goto out;
+	}
 
 	/*
 	 * If the idle states use stop instruction, probe for psscr values
@@ -414,10 +421,11 @@ static int powernv_add_idle_states(void)
 				target_residency = 100;
 			/* Add NAP state */
 			add_powernv_state(nr_idle_states, "Nap",
+					  "stop processor execution",
 					  CPUIDLE_FLAG_NONE, nap_loop,
 					  target_residency, exit_latency, 0, 0);
 		} else if (has_stop_states && !stops_timebase) {
-			add_powernv_state(nr_idle_states, names[i],
+			add_powernv_state(nr_idle_states, names[i], descs[i],
 					  CPUIDLE_FLAG_NONE, stop_loop,
 					  target_residency, exit_latency,
 					  psscr_val[i], psscr_mask[i]);
@@ -434,11 +442,12 @@ static int powernv_add_idle_states(void)
 				target_residency = 300000;
 			/* Add FASTSLEEP state */
 			add_powernv_state(nr_idle_states, "FastSleep",
+					  "Core and L2 clock gating",
 					  CPUIDLE_FLAG_TIMER_STOP,
 					  fastsleep_loop,
 					  target_residency, exit_latency, 0, 0);
 		} else if (has_stop_states && stops_timebase) {
-			add_powernv_state(nr_idle_states, names[i],
+			add_powernv_state(nr_idle_states, names[i], descs[i],
 					  CPUIDLE_FLAG_TIMER_STOP, stop_loop,
 					  target_residency, exit_latency,
 					  psscr_val[i], psscr_mask[i]);
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 1eefabf1621f..5094755cb132 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -17,7 +17,7 @@
 
 #define CPUIDLE_STATE_MAX	10
 #define CPUIDLE_NAME_LEN	16
-#define CPUIDLE_DESC_LEN	32
+#define CPUIDLE_DESC_LEN	60
 
 struct module;
 
-- 
2.14.1

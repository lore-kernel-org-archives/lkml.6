Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754871AbeEaMPe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:15:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754197AbeEaMPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:15:30 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stewart Smith <stewart@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH] cpuidle:powernv: Make the snooze timeout dynamic.
Date: Thu, 31 May 2018 17:45:09 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18053112-0024-0000-0000-000003634149
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009102; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01040290; UDB=6.00532506; IPR=6.00819420;
 MB=3.00021393; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-31 12:15:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053112-0025-0000-0000-000048313B6A
Message-Id: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=823 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805310139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

The commit 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of
snooze to deeper idle state") introduced a timeout for the snooze idle
state so that it could be eventually be promoted to a deeper idle
state. The snooze timeout value is static and set to the target
residency of the next idle state, which would train the cpuidle
governor to pick the next idle state eventually.

The unfortunate side-effect of this is that if the next idle state(s)
is disabled, the CPU will forever remain in snooze, despite the fact
that the system is completely idle, and other deeper idle states are
available.

This patch fixes the issue by dynamically setting the snooze timeout
to the target residency of the next enabled state on the device.

Before Patch
==================
POWER8 : Only nap disabled.
 $cpupower monitor sleep 30
sleep took 30.01297 seconds and exited with status 0
              |Idle_Stats
PKG |CORE|CPU | snoo | Nap  | Fast
   0|   8|   0| 96.41|  0.00|  0.00
   0|   8|   1| 96.43|  0.00|  0.00
   0|   8|   2| 96.47|  0.00|  0.00
   0|   8|   3| 96.35|  0.00|  0.00
   0|   8|   4| 96.37|  0.00|  0.00
   0|   8|   5| 96.37|  0.00|  0.00
   0|   8|   6| 96.47|  0.00|  0.00
   0|   8|   7| 96.47|  0.00|  0.00

POWER9: Shallow states (stop0lite, stop1lite, stop2lite, stop0, stop1,
stop2) disabled:
$cpupower monitor sleep 30
sleep took 30.05033 seconds and exited with status 0
              |Idle_Stats
PKG |CORE|CPU | snoo | stop | stop | stop | stop | stop | stop | stop | stop
   0|  16|   0| 89.79|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
   0|  16|   1| 90.12|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
   0|  16|   2| 90.21|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00
   0|  16|   3| 90.29|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00

After Patch
======================
POWER8 : Only nap disabled.
$ cpupower monitor sleep 30
sleep took 30.01200 seconds and exited with status 0
              |Idle_Stats
PKG |CORE|CPU | snoo | Nap  | Fast
   0|   8|   0| 16.58|  0.00| 77.21
   0|   8|   1| 18.42|  0.00| 75.38
   0|   8|   2|  4.70|  0.00| 94.09
   0|   8|   3| 17.06|  0.00| 81.73
   0|   8|   4|  3.06|  0.00| 95.73
   0|   8|   5|  7.00|  0.00| 96.80
   0|   8|   6|  1.00|  0.00| 98.79
   0|   8|   7|  5.62|  0.00| 94.17

POWER9: Shallow states (stop0lite, stop1lite, stop2lite, stop0, stop1,
stop2) disabled:

$cpupower monitor sleep 30
sleep took 30.02110 seconds and exited with status 0
              |Idle_Stats
PKG |CORE|CPU | snoo | stop | stop | stop | stop | stop | stop | stop | stop
   0|   0|   0|  0.69|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  9.39| 89.70
   0|   0|   1|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.05| 93.21
   0|   0|   2|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00| 89.93
   0|   0|   3|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|  0.00| 93.26

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 1a8234e..d29e4f0 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -43,9 +43,31 @@ struct stop_psscr_table {
 
 static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX] __read_mostly;
 
-static u64 snooze_timeout __read_mostly;
+static u64 default_snooze_timeout __read_mostly;
 static bool snooze_timeout_en __read_mostly;
 
+static u64 get_snooze_timeout(struct cpuidle_device *dev,
+			      struct cpuidle_driver *drv,
+			      int index)
+{
+	int i;
+
+	if (unlikely(!snooze_timeout_en))
+		return default_snooze_timeout;
+
+	for (i = index + 1; i < drv->state_count; i++) {
+		struct cpuidle_state *s = &drv->states[i];
+		struct cpuidle_state_usage *su = &dev->states_usage[i];
+
+		if (s->disabled || su->disable)
+			continue;
+
+		return s->target_residency * tb_ticks_per_usec;
+	}
+
+	return default_snooze_timeout;
+}
+
 static int snooze_loop(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
@@ -56,7 +78,7 @@ static int snooze_loop(struct cpuidle_device *dev,
 
 	local_irq_enable();
 
-	snooze_exit_time = get_tb() + snooze_timeout;
+	snooze_exit_time = get_tb() + get_snooze_timeout(dev, drv, index);
 	ppc64_runlatch_off();
 	HMT_very_low();
 	while (!need_resched()) {
@@ -465,11 +487,9 @@ static int powernv_idle_probe(void)
 		cpuidle_state_table = powernv_states;
 		/* Device tree can indicate more idle states */
 		max_idle_state = powernv_add_idle_states();
-		if (max_idle_state > 1) {
+		default_snooze_timeout = TICK_USEC * tb_ticks_per_usec;
+		if (max_idle_state > 1)
 			snooze_timeout_en = true;
-			snooze_timeout = powernv_states[1].target_residency *
-					 tb_ticks_per_usec;
-		}
  	} else
  		return -ENODEV;
 
-- 
1.9.4

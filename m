Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754915AbeDPNXc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 09:23:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752736AbeDPNXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 09:23:31 -0400
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH v2] perf list: Add s390 support for detailed/verbose pmu event description
Date: Mon, 16 Apr 2018 15:23:14 +0200
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18041613-0012-0000-0000-000005CB679B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041613-0013-0000-0000-00001947ABFD
Message-Id: <20180416132314.33249-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804160127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

Perf list with flags -d and -v print a description (-d) or
a very verbose explanation (-v) of CPU specific counter events.
These descriptions are provided with the json files in
directory pmu-events/arch/s390/*.json.

Display of these descriptions on s390 requires the
corresponding json files.

On s390 this does not work because function is_pmu_core()
does not detect the s390 directory name where the
CPU specific events are listed. On x86 it is
  /sys/bus/event_source/devices/cpu
whereas on s390 it is
  /sys/bus/event_source/devices/cpum_cf
  /sys/bus/event_source/devices/cpum_sf

Fix this by adding s390 directory name testing to
function is_pmu_core(). This is the same approach as taken for
arm platform.

Output before:
[root@s35lp76 perf]# ./perf list -d pmu
List of pre-defined events (to be used in -e):

  cpum_cf/AES_BLOCKED_CYCLES/      [Kernel PMU event]
  cpum_cf/AES_BLOCKED_FUNCTIONS/   [Kernel PMU event]
  cpum_cf/AES_CYCLES/              [Kernel PMU event]
  cpum_cf/AES_FUNCTIONS/           [Kernel PMU event]
  ....
  cpum_cf/TX_NC_TEND/              [Kernel PMU event]
  cpum_cf/VX_BCD_EXECUTION_SLOTS/  [Kernel PMU event]
  cpum_sf/SF_CYCLES_BASIC/         [Kernel PMU event]

Output after:
[root@s35lp76 perf]# ./perf list -d pmu
List of pre-defined events (to be used in -e):

  cpum_cf/AES_BLOCKED_CYCLES/      [Kernel PMU event]
  cpum_cf/AES_BLOCKED_FUNCTIONS/   [Kernel PMU event]
  cpum_cf/AES_CYCLES/              [Kernel PMU event]
  cpum_cf/AES_FUNCTIONS/           [Kernel PMU event]
  ....
  cpum_cf/TX_NC_TEND/              [Kernel PMU event]
  cpum_cf/VX_BCD_EXECUTION_SLOTS/  [Kernel PMU event]
  cpum_sf/SF_CYCLES_BASIC/         [Kernel PMU event]

3906:
  bcd_dfp_execution_slots
       [BCD DFP Execution Slots]
  decimal_instructions
       [Decimal Instructions]
  dtlb2_gpage_writes
       [DTLB2 GPAGE Writes]
  dtlb2_hpage_writes
       [DTLB2 HPAGE Writes]
  dtlb2_misses
       [DTLB2 Misses]
  dtlb2_writes
       [DTLB2 Writes]
  itlb2_misses
       [ITLB2 Misses]
  itlb2_writes
       [ITLB2 Writes]
  l1c_tlb2_misses
       [L1C TLB2 Misses]
  .....

cfvn 3:
  cpu_cycles
       [CPU Cycles]
  instructions
       [Instructions]
  l1d_dir_writes
       [L1D Directory Writes]
  l1d_penalty_cycles
       [L1D Penalty Cycles]
  l1i_dir_writes
       [L1I Directory Writes]
  l1i_penalty_cycles
       [L1I Penalty Cycles]
  problem_state_cpu_cycles
       [Problem State CPU Cycles]
  problem_state_instructions
       [Problem State Instructions]
  ....

csvn generic:
  aes_blocked_cycles
       [AES Blocked Cycles]
  aes_blocked_functions
       [AES Blocked Functions]
  aes_cycles
       [AES Cycles]
  aes_functions
       [AES Functions]
  dea_blocked_cycles
       [DEA Blocked Cycles]
  dea_blocked_functions
       [DEA Blocked Functions]
  ....

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/util/pmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 1111d5bf15ca..8675ddf558c6 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -562,6 +562,12 @@ static int is_pmu_core(const char *name)
 	if (stat(path, &st) == 0)
 		return 1;
 
+	/* Look for cpu sysfs (specific to s390) */
+	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s",
+		  sysfs, name);
+	if (stat(path, &st) == 0 && !strncmp(name, "cpum_", 5))
+		return 1;
+
 	return 0;
 }
 
-- 
2.14.3

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeDUHsl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:48:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49253 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbeDUHsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:48:40 -0400
Date: Sat, 21 Apr 2018 00:48:28 -0700
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-038586c34301578e538f6c5aa79ca82bce1b9152@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        heiko.carstens@de.ibm.com, hpa@zytor.com, brueckner@linux.vnet.ibm.com,
        tmricht@linux.vnet.ibm.com, mingo@kernel.org, tglx@linutronix.de,
        acme@redhat.com, schwidefsky@de.ibm.com
Reply-To: acme@redhat.com, schwidefsky@de.ibm.com, mingo@kernel.org,
        tmricht@linux.vnet.ibm.com, brueckner@linux.vnet.ibm.com,
        tglx@linutronix.de, hpa@zytor.com, heiko.carstens@de.ibm.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com
In-Reply-To: <20180416132314.33249-1-tmricht@linux.ibm.com>
References: <20180416132314.33249-1-tmricht@linux.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf list: Add s390 support for detailed/verbose
 PMU event description
Git-Commit-ID: 038586c34301578e538f6c5aa79ca82bce1b9152
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  038586c34301578e538f6c5aa79ca82bce1b9152
Gitweb:     https://git.kernel.org/tip/038586c34301578e538f6c5aa79ca82bce1b9152
Author:     Thomas Richter <tmricht@linux.vnet.ibm.com>
AuthorDate: Mon, 16 Apr 2018 15:23:14 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 17 Apr 2018 09:47:39 -0300

perf list: Add s390 support for detailed/verbose PMU event description

'perf list' with flags -d and -v print a description (-d) or a very
verbose explanation (-v) of CPU specific counter events.  These
descriptions are provided with the json files in directory
pmu-events/arch/s390/*.json.

Display of these descriptions on s390 requires the corresponding json
files.

On s390 this does not work because function is_pmu_core() does not
detect the s390 directory name where the CPU specific events are listed.
On x86 it is:

  /sys/bus/event_source/devices/cpu

whereas on s390 it is:

  /sys/bus/event_source/devices/cpum_cf
  /sys/bus/event_source/devices/cpum_sf

Fix this by adding s390 directory name testing to function
is_pmu_core(). This is the same approach as taken for the ARM platform.

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
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180416132314.33249-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 064bdcb7bd78..61a5e5027338 100644
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
 

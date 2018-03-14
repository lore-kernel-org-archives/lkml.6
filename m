Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeCNMkm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:40:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750902AbeCNMkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:40:41 -0400
From: Thomas Richter <tmricht@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 2/2 v2] perf stat: Add support for flag T on s390
Date: Wed, 14 Mar 2018 13:40:04 +0100
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180314124004.98937-1-tmricht@linux.vnet.ibm.com>
References: <20180314124004.98937-1-tmricht@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031412-0040-0000-0000-000004405C08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031412-0041-0000-0000-000020E35FC8
Message-Id: <20180314124004.98937-2-tmricht@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140145
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for command 'perf stat -T' on s390.
It adds s390 specfic counter table for transactions.
The architecture is queried and the event string for
transaction counters is constructed
depending on the s390 type and model CPU measurement
facility counter list.

Output Before:
[root@s35lp76 perf]# perf stat -T -- sleep 1
Cannot set up transaction events
[root@s35lp76 perf]#

Output after:
[root@s35lp76 perf]# ./perf stat -T -- sleep 1

 Performance counter stats for 'sleep 1':

   0.939985      task-clock (msec)         #    0.001 CPUs utilized
  2,557,145      instructions              #    0.53  insn per cycle
  4,785,929      cycles                    #    5.091 GHz
          0      cpum_cf/TX_C_TABORT_NO_SPECIAL/ #    0.000 K/sec
          0      cpum_cf/TX_C_TABORT_SPECIAL/ #    0.000 K/sec
          0      cpum_cf/TX_C_TEND/        #    0.000 K/sec
          0      cpum_cf/TX_NC_TABORT/     #    0.000 K/sec
          0      cpum_cf/TX_NC_TEND/       #    0.000 K/sec

  1.001934710 seconds time elapsed

[root@s35lp76 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 tools/perf/builtin-stat.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8d7b97c708e4..943ed3648049 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2162,10 +2162,40 @@ static struct pmu_tx_events x86_tx_events[] = {/* x86 transaction counters */
 	}
 };
 
+static struct pmu_tx_events s390_tx_events[] = {/* s390 transaction counters */
+	{
+		.pmu = "cpum_cf",
+		.name = "TX_C_TABORT_NO_SPECIAL",
+	},
+	{
+		.pmu = "cpum_cf",
+		.name = "TX_C_TABORT_SPECIAL",
+	},
+	{
+		.pmu = "cpum_cf",
+		.name = "TX_C_TEND",
+	},
+	{
+		.pmu = "cpum_cf",
+		.name = "TX_NC_TABORT",
+	},
+	{
+		.pmu = "cpum_cf",
+		.name = "TX_NC_TEND",
+	},
+	{
+		.pmu = 0
+	}
+};
+
 struct arch_pmu_tx_events {
 	const char *archname;		/* Architecture name */
 	struct pmu_tx_events *tx;	/* Architecture specific counters */
 } arch_pmu_tx_events[] = {
+	{
+		.archname = "s390",
+		.tx = s390_tx_events
+	},
 	{
 		.archname = "x86",
 		.tx = x86_tx_events
-- 
2.14.3

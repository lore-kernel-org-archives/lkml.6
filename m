Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752426AbeDLNdL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 09:33:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751711AbeDLNdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 09:33:10 -0400
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf record: Change warning for missing sysfs entry to debug
Date: Thu, 12 Apr 2018 15:32:46 +0200
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18041213-0040-0000-0000-0000044CC47E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041213-0041-0000-0000-000020F0F88F
Message-Id: <20180412133246.92801-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804120135
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using perf on 4.16.0 kernel on s390 shows warning
   failed: can't open node sysfs data
each time I run command perf record ... for example:

[root@s35lp76 perf]# ./perf record -e rB0000 -- sleep 1
[ perf record: Woken up 1 times to write data ]
failed: can't open node sysfs data
[ perf record: Captured and wrote 0.001 MB perf.data (4 samples) ]
[root@s35lp76 perf]#

It turns out commit e2091cedd51bf ("perf tools: Add MEM_TOPOLOGY
feature to perf data file") tries to open directory named
/sys/devices/system/node/ which does not exist on s390.

This is the call stack:
 __cmd_record
 +---> perf_session__write_header
       +---> perf_header__adds_write
             +---> do_write_feat
	           +---> write_mem_topology
		         +---> build_mem_topology
			       prints warning
The issue starts in do_write_feat() which unconditionally
loops over all features and now includes HEADER_MEM_TOPOLOGY and calls
write_mem_topology().
Function record__init_features() at the beginning of __cmd_record()
sets all features and then turns off some of them.

Fix this by changing the warning to a level 2 debug output statement.
So it is only shown when debug level 2 or higher is set.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/header.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 121df1683c36..a8bff2178fbc 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1320,7 +1320,8 @@ static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
 
 	dir = opendir(path);
 	if (!dir) {
-		pr_warning("failed: can't open node sysfs data\n");
+		pr_debug2("%s: could't read %s, does this arch have topology information?\n",
+			  __func__, path);
 		return -1;
 	}
 
-- 
2.14.3

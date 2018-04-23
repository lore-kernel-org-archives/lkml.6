Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755418AbeDWO3z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:29:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755342AbeDWO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:29:53 -0400
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf record: Fix s390 random record__auxtrace_init return value
Date: Mon, 23 Apr 2018 16:29:40 +0200
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18042314-0040-0000-0000-000004320254
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042314-0041-0000-0000-000026362922
Message-Id: <20180423142940.21143-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230145
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Command perf record calls
cmd_report
+---> record__auxtrace_init
      +---> auxtrace_record__init()

On s390 function auxtrace_record__init() returns random return
value due to missing initialization.
This sometime causes perf record to exit immediately without
error message and creating a perf.data file.

Fix this by setting error return code to zero before return
from platform specific function which does not set the
error code in call cases.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/arch/s390/util/auxtrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index 6cb48e4cffd9..3afe8256eff2 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -87,6 +87,7 @@ struct auxtrace_record *auxtrace_record__init(struct perf_evlist *evlist,
 	struct perf_evsel *pos;
 	int diagnose = 0;
 
+	*err = 0;
 	if (evlist->nr_entries == 0)
 		return NULL;
 
-- 
2.14.3

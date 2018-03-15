Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeCOIZo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:25:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750777AbeCOIZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:25:42 -0400
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Cc: wangnan0@huawei.com, mingo@redhat.com, srikar@linux.vnet.ibm.com,
        oleg@redhat.com, mhiramat@kernel.org, namhyung@kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2 2/2] trace_uprobe: Simplify probes_seq_show()
Date: Thu, 15 Mar 2018 13:57:56 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180315082756.9050-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180315082756.9050-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031508-0012-0000-0000-000005BEECA6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031508-0013-0000-0000-0000193AF551
Message-Id: <20180315082756.9050-2-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803150097
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify probes_seq_show() function. No change in output
before and after patch.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 kernel/trace/trace_uprobe.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 0298bd15be83..544fa10a471b 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -602,24 +602,9 @@ static int probes_seq_show(struct seq_file *m, void *v)
 	char c = is_ret_probe(tu) ? 'r' : 'p';
 	int i;
 
-	seq_printf(m, "%c:%s/%s", c, tu->tp.call.class->system,
-			trace_event_name(&tu->tp.call));
-	seq_printf(m, " %s:", tu->filename);
-
-	/* Don't print "0x  (null)" when offset is 0 */
-	if (tu->offset) {
-		seq_printf(m, "0x%0*lx", (int)(sizeof(void *) * 2), tu->offset);
-	} else {
-		switch (sizeof(void *)) {
-		case 4:
-			seq_printf(m, "0x00000000");
-			break;
-		case 8:
-		default:
-			seq_printf(m, "0x0000000000000000");
-			break;
-		}
-	}
+	seq_printf(m, "%c:%s/%s %s:0x%0*lx", c, tu->tp.call.class->system,
+			trace_event_name(&tu->tp.call), tu->filename,
+			(int)(sizeof(void *) * 2), tu->offset);
 
 	for (i = 0; i < tu->tp.nr_args; i++)
 		seq_printf(m, " %s=%s", tu->tp.args[i].name, tu->tp.args[i].comm);
-- 
2.13.6

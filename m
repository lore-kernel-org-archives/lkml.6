Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeBFJdc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:33:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752199AbeBFJdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:33:23 -0500
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: rostedt@goodmis.org
Cc: mingo@redhat.com, srikar@linux.vnet.ibm.com, oleg@redhat.com,
        wangnan0@huawei.com, masami.hiramatsu.pt@hitachi.com,
        keescook@chromium.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 2/2] trace_uprobe: Simplify probes_seq_show()
Date: Tue,  6 Feb 2018 15:04:30 +0530
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206093430.7550-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180206093430.7550-1-ravi.bangoria@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020609-0040-0000-0000-0000040CD32C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020609-0041-0000-0000-000026108066
Message-Id: <20180206093430.7550-2-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-06_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802060118
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify probes_seq_show() function. We are using %lx to display
the offset and we don't prepend unnecessary 0s in the offset.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 kernel/trace/trace_uprobe.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c2c965398893..c12a3957e1ee 100644
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
-		seq_printf(m, "0x%lx", tu->offset);
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
+	seq_printf(m, "%c:%s/%s %s:0x%lx", c, tu->tp.call.class->system,
+			trace_event_name(&tu->tp.call), tu->filename,
+			tu->offset);
 
 	for (i = 0; i < tu->tp.nr_args; i++)
 		seq_printf(m, " %s=%s", tu->tp.args[i].name, tu->tp.args[i].comm);
-- 
2.13.6

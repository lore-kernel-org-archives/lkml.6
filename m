Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbeCOIZl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:25:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750777AbeCOIZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:25:39 -0400
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Cc: wangnan0@huawei.com, mingo@redhat.com, srikar@linux.vnet.ibm.com,
        oleg@redhat.com, mhiramat@kernel.org, namhyung@kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] trace_uprobe: Use %lx to display offset
Date: Thu, 15 Mar 2018 13:57:55 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18031508-0040-0000-0000-00000420ED6F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031508-0041-0000-0000-00002623F545
Message-Id: <20180315082756.9050-1-ravi.bangoria@linux.vnet.ibm.com>
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

tu->offset is unsigned long, not a pointer, thus %lx should
be used to print it, not the %px.

Fixes: 0e4d819d0893 ("trace_uprobe: Display correct offset in uprobe_events")
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
v2 changelog:
 - Keep prefixed 0s as is.

 kernel/trace/trace_uprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 2014f4351ae0..0298bd15be83 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -608,7 +608,7 @@ static int probes_seq_show(struct seq_file *m, void *v)
 
 	/* Don't print "0x  (null)" when offset is 0 */
 	if (tu->offset) {
-		seq_printf(m, "0x%px", (void *)tu->offset);
+		seq_printf(m, "0x%0*lx", (int)(sizeof(void *) * 2), tu->offset);
 	} else {
 		switch (sizeof(void *)) {
 		case 4:
-- 
2.13.6

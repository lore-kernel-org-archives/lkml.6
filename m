Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeBFJd1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 04:33:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752183AbeBFJdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 04:33:21 -0500
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: rostedt@goodmis.org
Cc: mingo@redhat.com, srikar@linux.vnet.ibm.com, oleg@redhat.com,
        wangnan0@huawei.com, masami.hiramatsu.pt@hitachi.com,
        keescook@chromium.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 1/2] trace_uprobe: Use %lx to display offset
Date: Tue,  6 Feb 2018 15:04:29 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18020609-0016-0000-0000-0000051FD947
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020609-0017-0000-0000-0000285C8AD4
Message-Id: <20180206093430.7550-1-ravi.bangoria@linux.vnet.ibm.com>
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

Kees suggested that, 'offset' is unsigned long, not a pointer,
thus %lx should be used to print it, not the %px. Also, I don't
see any reason to prepend offset with 0s. Replace %px with %lx.

Before patch:
  # echo "p:probe_a/main /tmp/a.out:0x594" > uprobe_events
  # cat uprobe_events
    p:probe_a/main /tmp/a.out:0x0000000000000594

After patch:
  # echo "p:probe_a/main /tmp/a.out:0x594" > uprobe_events
  # cat uprobe_events
    p:probe_a/main /tmp/a.out:0x594

Fixes: 0e4d819d0893 ("trace_uprobe: Display correct offset in uprobe_events")
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 kernel/trace/trace_uprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 268029ae1be6..c2c965398893 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -608,7 +608,7 @@ static int probes_seq_show(struct seq_file *m, void *v)
 
 	/* Don't print "0x  (null)" when offset is 0 */
 	if (tu->offset) {
-		seq_printf(m, "0x%px", (void *)tu->offset);
+		seq_printf(m, "0x%lx", tu->offset);
 	} else {
 		switch (sizeof(void *)) {
 		case 4:
-- 
2.13.6

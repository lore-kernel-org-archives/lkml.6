Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755329AbeDTPIj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:08:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755295AbeDTPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:08:37 -0400
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: rostedt@goodmis.org
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        kamalesh@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [RFC] trace_events: Fix kernel crash while using empty filter with perf
Date: Fri, 20 Apr 2018 20:37:58 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18042015-0008-0000-0000-000004ED83B4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042015-0009-0000-0000-00001E819C46
Message-Id: <20180420150758.19787-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804200152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel is crashing when user tries to record 'ftrace:function' event
with empty filter:

  # perf record -e ftrace:function --filter="" ls

  # dmesg
  BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
  Oops: 0000 [#1] SMP PTI
  ...
  RIP: 0010:ftrace_profile_set_filter+0x14b/0x2d0
  RSP: 0018:ffffa4a7c0da7d20 EFLAGS: 00010246
  RAX: ffffa4a7c0da7d64 RBX: 0000000000000000 RCX: 0000000000000006
  RDX: 0000000000000000 RSI: 0000000000000092 RDI: ffff8c48ffc968f0
  ...
  Call Trace:
   _perf_ioctl+0x54a/0x6b0
   ? rcu_all_qs+0x5/0x30
  ...

After patch:
  # perf record -e ftrace:function --filter="" ls
  failed to set filter "" on event ftrace:function with 22 (Invalid argument)

Also, if user tries to echo "" > filter, it used to throw an error.
This behavior got changed by commit 80765597bc58 ("tracing: Rewrite
filter logic to be simpler and faster"). This patch restores the
behavior as a side effect:

Before patch:
  # echo "" > filter
  #

After patch:
  # echo "" > filter
  bash: echo: write error: Invalid argument
  #

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/trace/trace_events_filter.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 9b4716bb8bb0..1f951b3df60c 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1499,14 +1499,14 @@ static int process_preds(struct trace_event_call *call,
 		return ret;
 	}
 
-	if (!nr_preds) {
-		prog = NULL;
-	} else {
-		prog = predicate_parse(filter_string, nr_parens, nr_preds,
+	if (!nr_preds)
+		return -EINVAL;
+
+	prog = predicate_parse(filter_string, nr_parens, nr_preds,
 			       parse_pred, call, pe);
-		if (IS_ERR(prog))
-			return PTR_ERR(prog);
-	}
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
 	rcu_assign_pointer(filter->prog, prog);
 	return 0;
 }
-- 
2.14.3

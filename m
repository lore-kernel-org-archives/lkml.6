Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeBZWCf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:02:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751742AbeBZWCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:02:23 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 11/12] torture: Grace periods do not piggyback off of themselves
Date: Mon, 26 Feb 2018 14:02:40 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226220225.GA32136@linux.vnet.ibm.com>
References: <20180226220225.GA32136@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022622-0040-0000-0000-000003FD5C85
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995533; UDB=6.00506035; IPR=6.00774861;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 22:02:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022622-0041-0000-0000-000007FE6695
Message-Id: <1519682561-510-11-git-send-email-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260276
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcuperf trace-event processing counted every "done" trace event
as a piggyback, which is incorrect because the task that started the
grace period didn't piggyback at all.  This commit fixes this problem
by recording the task that started a given grace period and ignoring
that task's "done" record for that grace period.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh
index dffb553a7bcc..8948f7926b21 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh
@@ -44,6 +44,7 @@ $8 == "start" {
 	starttask = $1;
 	starttime = $3;
 	startseq = $7;
+	seqtask[startseq] = starttask;
 }
 
 $8 == "end" {
@@ -62,7 +63,7 @@ $8 == "end" {
 	}
 }
 
-$8 == "done" {
+$8 == "done" && seqtask[$7] != $1 {
 	piggybackcnt[$1]++;
 }
 
-- 
2.5.2

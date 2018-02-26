Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBZWCc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:02:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751890AbeBZWCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:02:22 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 09/12] torture: Default jitter off when running rcuperf
Date: Mon, 26 Feb 2018 14:02:38 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226220225.GA32136@linux.vnet.ibm.com>
References: <20180226220225.GA32136@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022622-0008-0000-0000-000002DB9DD5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995533; UDB=6.00506035; IPR=6.00774861;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 22:02:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022622-0009-0000-0000-00003864E993
Message-Id: <1519682561-510-9-git-send-email-paulmck@linux.vnet.ibm.com>
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

The purpose of jitter is to expose concurrency bugs due to invalid
assumptions about forward progress.  There is usually little point
in jitter when measuring performance.  This commit therefore defaults
jitter off when running rcuperf.  You can override this by specifying
the kvm.sh "--jitter" argument -after- the "--torture rcuperf"
argument.  No idea why you would want this, but if you do, that is
how you do it.

One example of a conccurrency bug that this jitter might expose is one
in which the developer assumed that a given short region of code would be
guaranteed to execute within some short time limit.  Such assumptions are
invalid in virtualized environments because the hupervisor can preempt
the guest OS at any point, even when the guest OS thinks that it has
disabled interrupts.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index f3c3d33150a0..56610dbbdf73 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -179,6 +179,12 @@ do
 		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuperf\)$' '^--'
 		TORTURE_SUITE=$2
 		shift
+		if test "$TORTURE_SUITE" = rcuperf
+		then
+			# If you really want jitter for rcuperf, specify
+			# it after specifying rcuperf.  (But why?)
+			jitter=0
+		fi
 		;;
 	*)
 		echo Unknown argument $1
-- 
2.5.2

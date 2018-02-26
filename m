Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeBZWEc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:04:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751891AbeBZWCW (ORCPT
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
Subject: [PATCH tip/core/rcu 08/12] torture: Specify qemu memory size with --memory argument
Date: Mon, 26 Feb 2018 14:02:37 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226220225.GA32136@linux.vnet.ibm.com>
References: <20180226220225.GA32136@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022622-0048-0000-0000-0000023FB48A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995533; UDB=6.00506035; IPR=6.00774861;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 22:02:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022622-0049-0000-0000-000044433AC5
Message-Id: <1519682561-510-8-git-send-email-paulmck@linux.vnet.ibm.com>
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

The 512 megabyte memory size has served quite well, but more memory
is required when using large trace buffers on large systems.  This
commit therefore adds a --memory argument to the kvm.sh script, which
allows the memory size to be specified on the command line, for example,
"--memory 768", --memory 800M", or "--memory 2G".

Reported-by: Sebastian Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 4 ++--
 tools/testing/selftests/rcutorture/bin/kvm.sh            | 8 ++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 1b78a12740e5..5f8fbb0d7c17 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -177,8 +177,8 @@ then
 	exit 0
 fi
 echo "NOTE: $QEMU either did not run or was interactive" > $resdir/console.log
-echo $QEMU $qemu_args -m 512 -kernel $KERNEL -append \"$qemu_append $boot_args\" > $resdir/qemu-cmd
-( $QEMU $qemu_args -m 512 -kernel $KERNEL -append "$qemu_append $boot_args"& echo $! > $resdir/qemu_pid; wait `cat  $resdir/qemu_pid`; echo $? > $resdir/qemu-retval ) &
+echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" > $resdir/qemu-cmd
+( $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append "$qemu_append $boot_args"& echo $! > $resdir/qemu_pid; wait `cat  $resdir/qemu_pid`; echo $? > $resdir/qemu-retval ) &
 commandcompleted=0
 sleep 10 # Give qemu's pid a chance to reach the file
 if test -s "$resdir/qemu_pid"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 1fa05132774d..f3c3d33150a0 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -42,6 +42,7 @@ TORTURE_BOOT_IMAGE=""
 TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG=""
 TORTURE_KMAKE_ARG=""
+TORTURE_QEMU_MEM=512
 TORTURE_SHUTDOWN_GRACE=180
 TORTURE_SUITE=rcu
 resdir=""
@@ -68,6 +69,7 @@ usage () {
 	echo "       --kconfig Kconfig-options"
 	echo "       --kmake-arg kernel-make-arguments"
 	echo "       --mac nn:nn:nn:nn:nn:nn"
+	echo "       --memory megabytes | nnnG"
 	echo "       --no-initrd"
 	echo "       --qemu-args qemu-arguments"
 	echo "       --qemu-cmd qemu-system-..."
@@ -145,6 +147,11 @@ do
 		TORTURE_QEMU_MAC=$2
 		shift
 		;;
+	--memory)
+		checkarg --memory "(memory size)" $# "$2" '^[0-9]\+[MG]\?$' error
+		TORTURE_QEMU_MEM=$2
+		shift
+		;;
 	--no-initrd)
 		TORTURE_INITRD=""; export TORTURE_INITRD
 		;;
@@ -286,6 +293,7 @@ TORTURE_KMAKE_ARG="$TORTURE_KMAKE_ARG"; export TORTURE_KMAKE_ARG
 TORTURE_QEMU_CMD="$TORTURE_QEMU_CMD"; export TORTURE_QEMU_CMD
 TORTURE_QEMU_INTERACTIVE="$TORTURE_QEMU_INTERACTIVE"; export TORTURE_QEMU_INTERACTIVE
 TORTURE_QEMU_MAC="$TORTURE_QEMU_MAC"; export TORTURE_QEMU_MAC
+TORTURE_QEMU_MEM="$TORTURE_QEMU_MEM"; export TORTURE_QEMU_MEM
 TORTURE_SHUTDOWN_GRACE="$TORTURE_SHUTDOWN_GRACE"; export TORTURE_SHUTDOWN_GRACE
 TORTURE_SUITE="$TORTURE_SUITE"; export TORTURE_SUITE
 if ! test -e $resdir
-- 
2.5.2

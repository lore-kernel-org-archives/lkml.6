Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeBZWCY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 17:02:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751758AbeBZWCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 17:02:21 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        Lihao Liang <lianglihao@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 07/12] rcutorture: Add basic ARM64 support to run scripts
Date: Mon, 26 Feb 2018 14:02:36 -0800
X-Mailer: git-send-email 2.5.2
In-Reply-To: <20180226220225.GA32136@linux.vnet.ibm.com>
References: <20180226220225.GA32136@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022622-0008-0000-0000-000002DB9DD6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995533; UDB=6.00506035; IPR=6.00774861;
 MB=3.00019751; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-26 22:02:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022622-0009-0000-0000-00003864E992
Message-Id: <1519682561-510-7-git-send-email-paulmck@linux.vnet.ibm.com>
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

From: Lihao Liang <lianglihao@huawei.com>

This commit adds support of the qemu command qemu-system-aarch64
to rcutorture.

Signed-off-by: Lihao Liang <lianglihao@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 07a13779eece..65f6655026f0 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -136,6 +136,9 @@ identify_boot_image () {
 		qemu-system-x86_64|qemu-system-i386)
 			echo arch/x86/boot/bzImage
 			;;
+		qemu-system-aarch64)
+			echo arch/arm64/boot/Image
+			;;
 		*)
 			echo vmlinux
 			;;
@@ -158,6 +161,9 @@ identify_qemu () {
 	elif echo $u | grep -q "Intel 80386"
 	then
 		echo qemu-system-i386
+	elif echo $u | grep -q aarch64
+	then
+		echo qemu-system-aarch64
 	elif uname -a | grep -q ppc64
 	then
 		echo qemu-system-ppc64
@@ -176,16 +182,20 @@ identify_qemu () {
 # Output arguments for the qemu "-append" string based on CPU type
 # and the TORTURE_QEMU_INTERACTIVE environment variable.
 identify_qemu_append () {
+	local console=ttyS0
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
 		echo noapic selinux=0 initcall_debug debug
 		;;
+	qemu-system-aarch64)
+		console=ttyAMA0
+		;;
 	esac
 	if test -n "$TORTURE_QEMU_INTERACTIVE"
 	then
 		echo root=/dev/sda
 	else
-		echo console=ttyS0
+		echo console=$console
 	fi
 }
 
@@ -197,6 +207,9 @@ identify_qemu_args () {
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
 		;;
+	qemu-system-aarch64)
+		echo -machine virt,gic-version=host -cpu host
+		;;
 	qemu-system-ppc64)
 		echo -enable-kvm -M pseries -nodefaults
 		echo -device spapr-vscsi
@@ -254,7 +267,7 @@ specify_qemu_cpus () {
 		echo $2
 	else
 		case "$1" in
-		qemu-system-x86_64|qemu-system-i386)
+		qemu-system-x86_64|qemu-system-i386|qemu-system-aarch64)
 			echo $2 -smp $3
 			;;
 		qemu-system-ppc64)
-- 
2.5.2

Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A58C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027A226244
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027A226244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755780AbeFYW4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:56:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755090AbeFYWz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:55:58 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PMmqgJ044589
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:55:58 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96prt0y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:55:58 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 18:55:57 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 18:55:52 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PMtprX14942504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 22:55:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A26A5B206B;
        Mon, 25 Jun 2018 18:55:46 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8240BB2064;
        Mon, 25 Jun 2018 18:55:46 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 18:55:46 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D318316CA093; Mon, 25 Jun 2018 15:57:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 1/5] torture: Use a single build directory for torture scenarios
Date:   Mon, 25 Jun 2018 15:57:51 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625225735.GA11793@linux.vnet.ibm.com>
References: <20180625225735.GA11793@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062522-2213-0000-0000-000002BFD89E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052304; UDB=6.00539450; IPR=6.00830229;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 22:55:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062522-2214-0000-0000-00005A9B6F32
Message-Id: <20180625225755.12839-1-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=889 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The torture scripting currently builds each kernel from a set of parallel
runs in its own build directory.  This can waste quite a bit of space when
running large numbers of concurrent scenarios, and pointlessly given that
the builds are run sequentially (albeit with a largish -j number passed to
"make").  This commit therefore places all build-command output in the
results directory, then does all builds in a single "b1" build directory.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../selftests/rcutorture/bin/configinit.sh    | 26 +++++++++----------
 .../selftests/rcutorture/bin/kvm-build.sh     | 11 ++++----
 .../rcutorture/bin/kvm-test-1-run.sh          |  5 ++--
 tools/testing/selftests/rcutorture/bin/kvm.sh |  2 +-
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/configinit.sh b/tools/testing/selftests/rcutorture/bin/configinit.sh
index c15f270e121d..65541c21a544 100755
--- a/tools/testing/selftests/rcutorture/bin/configinit.sh
+++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
@@ -1,6 +1,6 @@
 #!/bin/bash
 #
-# Usage: configinit.sh config-spec-file [ build output dir ]
+# Usage: configinit.sh config-spec-file build-output-dir results-dir
 #
 # Create a .config file from the spec file.  Run from the kernel source tree.
 # Exits with 0 if all went well, with 1 if all went well but the config
@@ -40,20 +40,18 @@ mkdir $T
 
 c=$1
 buildloc=$2
+resdir=$3
 builddir=
-if test -n $buildloc
+if echo $buildloc | grep -q '^O='
 then
-	if echo $buildloc | grep -q '^O='
+	builddir=`echo $buildloc | sed -e 's/^O=//'`
+	if test ! -d $builddir
 	then
-		builddir=`echo $buildloc | sed -e 's/^O=//'`
-		if test ! -d $builddir
-		then
-			mkdir $builddir
-		fi
-	else
-		echo Bad build directory: \"$buildloc\"
-		exit 2
+		mkdir $builddir
 	fi
+else
+	echo Bad build directory: \"$buildloc\"
+	exit 2
 fi
 
 sed -e 's/^\(CONFIG[0-9A-Z_]*\)=.*$/grep -v "^# \1" |/' < $c > $T/u.sh
@@ -61,12 +59,12 @@ sed -e 's/^\(CONFIG[0-9A-Z_]*=\).*$/grep -v \1 |/' < $c >> $T/u.sh
 grep '^grep' < $T/u.sh > $T/upd.sh
 echo "cat - $c" >> $T/upd.sh
 make mrproper
-make $buildloc distclean > $builddir/Make.distclean 2>&1
-make $buildloc $TORTURE_DEFCONFIG > $builddir/Make.defconfig.out 2>&1
+make $buildloc distclean > $resdir/Make.distclean 2>&1
+make $buildloc $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
 mv $builddir/.config $builddir/.config.sav
 sh $T/upd.sh < $builddir/.config.sav > $builddir/.config
 cp $builddir/.config $builddir/.config.new
-yes '' | make $buildloc oldconfig > $builddir/Make.oldconfig.out 2> $builddir/Make.oldconfig.err
+yes '' | make $buildloc oldconfig > $resdir/Make.oldconfig.out 2> $resdir/Make.oldconfig.err
 
 # verify new config matches specification.
 configcheck.sh $builddir/.config $c
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index 34d126734cde..9115fcdb5617 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -2,7 +2,7 @@
 #
 # Build a kvm-ready Linux kernel from the tree in the current directory.
 #
-# Usage: kvm-build.sh config-template build-dir
+# Usage: kvm-build.sh config-template build-dir resdir
 #
 # This program is free software; you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
@@ -29,6 +29,7 @@ then
 	exit 1
 fi
 builddir=${2}
+resdir=${3}
 
 T=${TMPDIR-/tmp}/test-linux.sh.$$
 trap 'rm -rf $T' 0
@@ -41,19 +42,19 @@ CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_CONSOLE=y
 ___EOF___
 
-configinit.sh $T/config O=$builddir
+configinit.sh $T/config O=$builddir $resdir
 retval=$?
 if test $retval -gt 1
 then
 	exit 2
 fi
 ncpus=`cpus2use.sh`
-make O=$builddir -j$ncpus $TORTURE_KMAKE_ARG > $builddir/Make.out 2>&1
+make O=$builddir -j$ncpus $TORTURE_KMAKE_ARG > $resdir/Make.out 2>&1
 retval=$?
-if test $retval -ne 0 || grep "rcu[^/]*": < $builddir/Make.out | egrep -q "Stop|Error|error:|warning:" || egrep -q "Stop|Error|error:" < $builddir/Make.out
+if test $retval -ne 0 || grep "rcu[^/]*": < $resdir/Make.out | egrep -q "Stop|Error|error:|warning:" || egrep -q "Stop|Error|error:" < $resdir/Make.out
 then
 	echo Kernel build error
-	egrep "Stop|Error|error:|warning:" < $builddir/Make.out
+	egrep "Stop|Error|error:|warning:" < $resdir/Make.out
 	echo Run aborted.
 	exit 3
 fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index c5b0f94341d9..f7247ee00514 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -98,14 +98,15 @@ then
 	ln -s $base_resdir/.config $resdir  # for kvm-recheck.sh
 	# Arch-independent indicator
 	touch $resdir/builtkernel
-elif kvm-build.sh $T/Kc2 $builddir
+elif kvm-build.sh $T/Kc2 $builddir $resdir
 then
 	# Had to build a kernel for this test.
 	QEMU="`identify_qemu $builddir/vmlinux`"
 	BOOT_IMAGE="`identify_boot_image $QEMU`"
-	cp $builddir/Make*.out $resdir
 	cp $builddir/vmlinux $resdir
 	cp $builddir/.config $resdir
+	cp $builddir/Module.symvers $resdir > /dev/null || :
+	cp $builddir/System.map $resdir > /dev/null || :
 	if test -n "$BOOT_IMAGE"
 	then
 		cp $builddir/$BOOT_IMAGE $resdir
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 56610dbbdf73..5a7a62d76a50 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -347,7 +347,7 @@ function dump(first, pastlast, batchnum)
 	print "needqemurun="
 	jn=1
 	for (j = first; j < pastlast; j++) {
-		builddir=KVM "/b" jn
+		builddir=KVM "/b1"
 		cpusr[jn] = cpus[j];
 		if (cfrep[cf[j]] == "") {
 			cfr[jn] = cf[j];
-- 
2.17.1


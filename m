Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27465C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24FA2077B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24FA2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbeKLFwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:52:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729712AbeKLFvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:51:19 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJwvvs038142
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:01:50 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npde82eqp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:01:50 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 20:01:48 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 20:01:44 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABK1hoK43122900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 20:01:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5EEEB2064;
        Sun, 11 Nov 2018 20:01:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E12DB2066;
        Sun, 11 Nov 2018 20:01:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 20:01:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D12EF16C5D59; Sun, 11 Nov 2018 12:01:44 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 2/8] rcutorture: Add initrd support for systems lacking dracut
Date:   Sun, 11 Nov 2018 12:01:37 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111200127.GA9511@linux.ibm.com>
References: <20181111200127.GA9511@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111120-0072-0000-0000-000003C6F49E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116024; UDB=6.00577118; IPR=6.00896125;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 20:01:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111120-0073-0000-0000-00004A134EA0
Message-Id: <20181111200143.10177-2-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

The support for creating initrd directories using dracut is a great
improvement over having to always hand-create them, it is a bit annoying
to have to install some otherwise irrelevant package just to be able to
run rcutorture.  This commit therefore adds support for creating initrd
directories on systems innocent of dracut.  You do need gcc, but then
again you need that to build the kernel (or to build llvm) in any case.

The idea is to create an initrd directory containing nothing but a
statically linked binary having a for-loop over a long-term sleep().
The result is a Linux kernel with almost no userspace: even the
time-honored /dev, /lib, /tmp, and /usr directories are gone.  In fact,
the only directory present is "/", but only because I don't know how to
get rid of it, at least short of not having an initrd in the first place.
Although statically linked binaries are much maligned, and rightly so,
their disadvantages seem to be irrelevant for this particular use case.
From https://www.akkadia.org/drepper/no_static_linking.html:

1.	Fixes are difficult to apply to hordes of widely scattered
	statically linked binaries.  But in this case, there is only one
	binary, but there would otherwise be no fewer than four libraries.

2.	Security measures like local address randomization cannot be used.
	Prudence prevents me from asserting that it is impossible to
	base a remote attack on a networking-free rcutorture instance.
	Nevertheless, bonus points to the first person who comes up with
	such an attack!

3.	More efficient use of physical memory.  Not in this case, given
	that libc is 1.8MB and the statically linked binary "only" 800K.

4.	Features such as locales, name service switch (NSS),
	internationalized domain names (IDN) tool, and so on require
	dynamic linking.  Bonus points to the first person coming up
	with a valid rcutorture use case requiring these features in
	its initrd.

5.	Accidental violations of (L)GPL.  Actually, this change actually
	helps -avoid- such violations by reducing the temptation to
	pass around tarballs of rcutorture-ready initrd directories.
	After all, the rcutorture scripts automatically create an initrd
	directory for you, so why bother with the tarballs?

6.	Tools and hacks like ltrace, LD_PRELOAD, LD_PROFILE, and LD_AUDIT
	don't work.  Again, bonus points to the first person coming up
	with a valid rcutorture use case requiring these features in
	its initrd.

Nevertheless, the script will use dracut if available, and will create the
statically linked binary only when dracut are missing.  Those preferring
the smaller initrd directory resulting from the statically linked binary
(like me) are free to hand-edit mkinitrd.sh to remove the code using
dracut.  ;-)

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../selftests/rcutorture/bin/mkinitrd.sh      | 40 ++++++--
 .../selftests/rcutorture/doc/initrd.txt       | 99 +++----------------
 2 files changed, 45 insertions(+), 94 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
index ae773760f396..87a87ffeaa85 100755
--- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
+++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
@@ -46,15 +46,41 @@ done
 __EOF___
 
 # Try using dracut to create initrd
-command -v dracut >/dev/null 2>&1 || { echo >&2 "Dracut not installed"; exit 1; }
-echo Creating $D/initrd using dracut.
+if command -v dracut >/dev/null 2>&1
+then
+	echo Creating $D/initrd using dracut.
+	# Filesystem creation
+	dracut --force --no-hostonly --no-hostonly-cmdline --module "base" $T/initramfs.img
+	cd $D
+	mkdir initrd
+	cd initrd
+	zcat $T/initramfs.img | cpio -id
+	cp $T/init init
+	chmod +x init
+	echo Done creating $D/initrd using dracut
+	exit 0
+fi
 
-# Filesystem creation
-dracut --force --no-hostonly --no-hostonly-cmdline --module "base" $T/initramfs.img
+# No dracut, so create a C-language initrd/init program and statically
+# link it.  This results in a very small initrd, but might be a bit less
+# future-proof than dracut.
+echo "Could not find dracut, attempting C initrd"
 cd $D
 mkdir initrd
 cd initrd
-zcat $T/initramfs.img | cpio -id
-cp $T/init init
-echo Done creating $D/initrd using dracut
+cat > init.c << '___EOF___'
+#include <unistd.h>
+
+int main(int argc, int argv[])
+{
+	for (;;)
+		sleep(1000*1000*1000); /* One gigasecond is ~30 years. */
+	return 0;
+}
+___EOF___
+gcc -static -Os -o init init.c
+strip init
+rm init.c
+echo "Done creating a statically linked C-language initrd"
+
 exit 0
diff --git a/tools/testing/selftests/rcutorture/doc/initrd.txt b/tools/testing/selftests/rcutorture/doc/initrd.txt
index 833f826d6ec2..933b4fd12327 100644
--- a/tools/testing/selftests/rcutorture/doc/initrd.txt
+++ b/tools/testing/selftests/rcutorture/doc/initrd.txt
@@ -1,9 +1,12 @@
-This document describes one way to create the initrd directory hierarchy
-in order to allow an initrd to be built into your kernel.  The trick
-here is to steal the initrd file used on your Linux laptop, Ubuntu in
-this case.  There are probably much better ways of doing this.
+The rcutorture scripting tools automatically create the needed initrd
+directory using dracut.  Failing that, this tool will create an initrd
+containing a single statically linked binary named "init" that loops
+over a very long sleep() call.  In both cases, this creation is done
+by tools/testing/selftests/rcutorture/bin/mkinitrd.sh.
 
-That said, here are the commands:
+However, if you are attempting to run rcutorture on a system that does
+not have dracut installed, and if you don't like the notion of static
+linking, you might wish to press an existing initrd into service:
 
 ------------------------------------------------------------------------
 cd tools/testing/selftests/rcutorture
@@ -11,22 +14,7 @@ zcat /initrd.img > /tmp/initrd.img.zcat
 mkdir initrd
 cd initrd
 cpio -id < /tmp/initrd.img.zcat
-------------------------------------------------------------------------
-
-Another way to create an initramfs image is using "dracut"[1], which is
-available on many distros, however the initramfs dracut generates is a cpio
-archive with another cpio archive in it, so an extra step is needed to create
-the initrd directory hierarchy.
-
-Here are the commands to create a initrd directory for rcutorture using
-dracut:
-
-------------------------------------------------------------------------
-dracut --no-hostonly --no-hostonly-cmdline --module "base bash shutdown" /tmp/initramfs.img
-cd tools/testing/selftests/rcutorture
-mkdir initrd
-cd initrd
-/usr/lib/dracut/skipcpio /tmp/initramfs.img | zcat | cpio -id < /tmp/initramfs.img
+# Manually verify that initrd contains needed binaries and libraries.
 ------------------------------------------------------------------------
 
 Interestingly enough, if you are running rcutorture, you don't really
@@ -39,75 +27,12 @@ with 0755 mode.
 ------------------------------------------------------------------------
 #!/bin/sh
 
-[ -d /dev ] || mkdir -m 0755 /dev
-[ -d /root ] || mkdir -m 0700 /root
-[ -d /sys ] || mkdir /sys
-[ -d /proc ] || mkdir /proc
-[ -d /tmp ] || mkdir /tmp
-mkdir -p /var/lock
-mount -t sysfs -o nodev,noexec,nosuid sysfs /sys
-mount -t proc -o nodev,noexec,nosuid proc /proc
-# Some things don't work properly without /etc/mtab.
-ln -sf /proc/mounts /etc/mtab
-
-# Note that this only becomes /dev on the real filesystem if udev's scripts
-# are used; which they will be, but it's worth pointing out
-if ! mount -t devtmpfs -o mode=0755 udev /dev; then
-	echo "W: devtmpfs not available, falling back to tmpfs for /dev"
-	mount -t tmpfs -o mode=0755 udev /dev
-	[ -e /dev/console ] || mknod --mode=600 /dev/console c 5 1
-	[ -e /dev/kmsg ] || mknod --mode=644 /dev/kmsg c 1 11
-	[ -e /dev/null ] || mknod --mode=666 /dev/null c 1 3
-fi
-
-mkdir /dev/pts
-mount -t devpts -o noexec,nosuid,gid=5,mode=0620 devpts /dev/pts || true
-mount -t tmpfs -o "nosuid,size=20%,mode=0755" tmpfs /run
-mkdir /run/initramfs
-# compatibility symlink for the pre-oneiric locations
-ln -s /run/initramfs /dev/.initramfs
-
-# Export relevant variables
-export ROOT=
-export ROOTDELAY=
-export ROOTFLAGS=
-export ROOTFSTYPE=
-export IP=
-export BOOT=
-export BOOTIF=
-export UBIMTD=
-export break=
-export init=/sbin/init
-export quiet=n
-export readonly=y
-export rootmnt=/root
-export debug=
-export panic=
-export blacklist=
-export resume=
-export resume_offset=
-export recovery=
-
-for i in /sys/devices/system/cpu/cpu*/online
-do
-	case $i in
-	'/sys/devices/system/cpu/cpu0/online')
-		;;
-	'/sys/devices/system/cpu/cpu*/online')
-		;;
-	*)
-		echo 1 > $i
-		;;
-	esac
-done
-
 while :
 do
 	sleep 10
 done
 ------------------------------------------------------------------------
 
-References:
-[1]: https://dracut.wiki.kernel.org/index.php/Main_Page
-[2]: http://blog.elastocloud.org/2015/06/rapid-linux-kernel-devtest-with-qemu.html
-[3]: https://www.centos.org/forums/viewtopic.php?t=51621
+This approach also allows most of the binaries and libraries in the
+initrd filesystem to be dispensed with, which can save significant
+space in rcutorture's "res" directory.
-- 
2.17.1


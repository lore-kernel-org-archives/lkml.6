Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7572C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B462157F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B462157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbeHNUy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:54:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728743AbeHNUy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:54:26 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7EI472b013709
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:06:01 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kv3cshq6p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 14:06:01 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <davidj@linux.ibm.com>;
        Tue, 14 Aug 2018 12:06:00 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Aug 2018 12:05:57 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7EI5uV622413696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Aug 2018 11:05:57 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCBC2C6059;
        Tue, 14 Aug 2018 12:05:56 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62DFAC6057;
        Tue, 14 Aug 2018 12:05:56 -0600 (MDT)
Received: from dev.watson.ibm.com (unknown [9.31.111.83])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 Aug 2018 12:05:56 -0600 (MDT)
From:   David Jacobson <davidj@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     David Jacobson <david@davidej.com>, Petr Vorel <pvorel@suze.cz>,
        David Jacobson <davidj@linux.ibm.com>
Subject: [PATCH 3/7] evmtest: test kernel module loading
Date:   Tue, 14 Aug 2018 14:05:47 -0400
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180814180551.28311-1-davidj@linux.ibm.com>
References: <20180814180551.28311-1-davidj@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18081418-0016-0000-0000-0000091A52A3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009544; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073490; UDB=6.00553126; IPR=6.00853448;
 MB=3.00022715; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-14 18:05:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081418-0017-0000-0000-00003FFF57F6
Message-Id: <20180814180551.28311-3-davidj@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808140185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel supports two methods of loading kernel modules -
init_module and finit_module syscalls. This test verifies loading kernel
modules with both syscalls, first without an IMA policy, and
subsequently with an IMA policy (that restricts module loading to signed
modules).

This test requires the kernel to be configured with the
"CONFIG_MODULE_SIG" option, but not with "CONFIG_MODULE_SIG_FORCE".  For
this reason, the test requires that  "module.sig_enforce=1" is supplied
as a boot option to the kernel.

Signed-off-by: David Jacobson <davidj@linux.ibm.com>

Changelog:
---
 evmtest/Makefile.am                         |  11 +-
 evmtest/files/policies/kernel_module_policy |   2 +
 evmtest/functions/r_kmod_sig.sh             | 225 ++++++++++++++++++++
 evmtest/src/Makefile                        |   5 +
 evmtest/src/basic_mod.c                     |  36 ++++
 evmtest/src/kern_mod_loader.c               | 131 ++++++++++++
 6 files changed, 407 insertions(+), 3 deletions(-)
 create mode 100644 evmtest/files/policies/kernel_module_policy
 create mode 100755 evmtest/functions/r_kmod_sig.sh
 create mode 100644 evmtest/src/Makefile
 create mode 100644 evmtest/src/basic_mod.c
 create mode 100644 evmtest/src/kern_mod_loader.c

diff --git a/evmtest/Makefile.am b/evmtest/Makefile.am
index b537e78..6be0596 100644
--- a/evmtest/Makefile.am
+++ b/evmtest/Makefile.am
@@ -3,7 +3,7 @@ datarootdir=@datarootdir@
 exec_prefix=@exec_prefix@
 bindir=@bindir@
 
-all: evmtest.1
+all: src evmtest.1
 
 evmtest.1:
 	asciidoc -d manpage -b docbook -o evmtest.1.xsl README
@@ -11,7 +11,10 @@ evmtest.1:
 	xsltproc --nonet -o $@ $(MANPAGE_DOCBOOK_XSL) evmtest.1.xsl
 	asciidoc -o evmtest.html README
 	rm -f evmtest.1.xsl
-install:
+src:
+	cd src && make
+
+install: src
 	install -m 755 evmtest $(bindir)
 	install -d $(datarootdir)/evmtest/files/
 	install -d $(datarootdir)/evmtest/files/policies
@@ -19,7 +22,9 @@ install:
 	install -D $$(find ./files/ -not -type d -not -path "./files/policies/*")  $(datarootdir)/evmtest/files/
 	install -D ./functions/* $(datarootdir)/evmtest/functions/
 	install -D ./files/policies/* $(datarootdir)/evmtest/files/policies/
+	cp ./src/basic_mod.ko $(datarootdir)/evmtest/files/
+	cp ./src/kern_mod_loader $(datarootdir)/evmtest/files
 	cp evmtest.1 $(datarootdir)/man/man1
 	mandb -q
 
-.PHONY: install evmtest.1
+.PHONY: src install evmtest.1
diff --git a/evmtest/files/policies/kernel_module_policy b/evmtest/files/policies/kernel_module_policy
new file mode 100644
index 0000000..8096e18
--- /dev/null
+++ b/evmtest/files/policies/kernel_module_policy
@@ -0,0 +1,2 @@
+measure func=MODULE_CHECK
+appraise func=MODULE_CHECK appraise_type=imasig
diff --git a/evmtest/functions/r_kmod_sig.sh b/evmtest/functions/r_kmod_sig.sh
new file mode 100755
index 0000000..43ab9df
--- /dev/null
+++ b/evmtest/functions/r_kmod_sig.sh
@@ -0,0 +1,225 @@
+#!/bin/bash
+# Author: David Jacobson <davidj@linux.ibm.com>
+TEST="r_kmod_sig"
+BUILD_DIR=""
+ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/.."
+source $ROOT/files/common.sh
+
+VERBOSE=0
+# This test validates that IMA prevents the loading of unsigned
+# kernel modules
+# There is no way to tell how the Kernel was compiled, so the boot command:
+# module.sig_enable=1 is required for this test. This is equivalent to
+# compiling with CONFIG_MODULE_SIG_FORCE
+
+SIG_ENFORCE_CMD="module.sig_enforce=1"
+POLICY_LOAD=$ROOT/files/load_policy.sh
+
+usage(){
+	echo ""
+	echo "kmod_sig [-b kernel_build_directory] -k <ima_key> [-v]"
+	echo "	This test verifies that IMA prevents the loading of an"
+	echo "	unsigned kernel module with a policy appraising MODULE_CHECK"
+	echo ""
+	echo "	This test must be run as root"
+	echo ""
+	echo "	-b,--kernel_build_directory	The path to a kernel build dir"
+	echo "	-k,--key			IMA key"
+	echo "	-v,--verbose			Verbose logging"
+	echo "	-h,--help			Display this help message"
+}
+
+TEMP=`getopt -o 'b:k:hv' -l 'kernel_build_directory:,key:,help,verbose'\
+	-n 'r_kmod_sig' -- "$@"`
+eval set -- "$TEMP"
+
+while true ; do
+	case "$1" in
+	-h|--help) usage; exit 0 ;;
+	-b|--kernel_build_directory) BUILD_DIR=$2; shift 2;;
+	-k|--key) IMA_KEY=$2; shift 2;;
+	-v|--verbose)	VERBOSE=1; shift;;
+	--) shift; break;;
+	*) echo "[*] Unrecognized option $1"; exit 1 ;;
+	esac
+done
+
+if [[ -z $IMA_KEY ]]; then
+	echo "[!] Please provide an IMA key."
+	usage
+	exit 1
+fi
+
+if [[ -z $BUILD_DIR ]]; then
+	v_out "No build directory provided, searching..."
+	BUILD_DIR="/lib/modules/`uname -r`/build"
+	if [[ ! -e $BUILD_DIR ]]; then
+		echo "[!] Could not find build tree. Please specify with -b"
+		exit 1
+	else
+		v_out "Found - using: `readlink -f $BUILD_DIR`"
+	fi
+fi
+
+EVMTEST_require_root
+
+begin
+
+if [[ ! -d "$BUILD_DIR" ]]; then
+	fail "Could not find kernel build path"
+fi
+
+if [[ ! -e "$IMA_KEY" ]]; then
+	fail "Could not find IMA key"
+fi
+
+v_out "Unloading test module if loaded..."
+rmmod basic_mod &>> /dev/null
+
+mod_load=$ROOT/files/kern_mod_loader
+
+if [[ ! $EVMTEST_BOOT_OPTS = *$SIG_ENFORCE_CMD* ]]; then
+	v_out "Test requires running with kernel command: $SIG_ENFORCE_CMD"
+	fail "Booted with options: $EVMTEST_BOOT_OPTS"
+else
+	v_out "Booted with correct configuration..."
+fi
+
+# This test may have been run before - remove the security attribute so we can
+# test again
+v_out "Removing security attribute if it exists..."
+setfattr -x security.ima $ROOT/files/basic_mod.ko &>> /dev/null
+
+v_out "Removing appended signature if present..."
+strip --strip-debug $ROOT/files/basic_mod.ko
+
+v_out "Signing policy before loading..."
+evmctl ima_sign -f $ROOT/files/policies/kernel_module_policy -k $IMA_KEY
+
+if [[ $? != 0 ]]; then
+	fail "failed to sign policy - check key"
+fi
+
+v_out "Setting policy to prevent loading unsigned kernel modules..."
+$POLICY_LOAD kernel_module_policy &>> /dev/null
+
+if [[ $? != 0 ]]; then
+	fail "Could not write policy - is the supplied key correct?"
+fi
+
+# First attempt to find hash algo
+hash_alg=`grep CONFIG_MODULE_SIG_HASH $BUILD_DIR/.config|awk -F "=" \
+	'{print $2}'| tr -d "\""`
+# Need to read the config a little more to determine how to sign module...
+if [[ -z $hash_alg ]]; then
+	v_out "Could not determine hash algorithm used on module signing"
+	v_out "Checking for other Kconfig variables..."
+	hash_opts=`grep CONFIG_MODULE_SIG $BUILD_DIR/.config`
+
+	# All possible hashes from:
+	# https://www.kernel.org/doc/html/v4.17/admin-guide/module-signing.html
+	case $hash_opts in
+	*"CONFIG_MODULE_SIG_SHA1=y"*)
+		hash_alg="sha1"
+		;;
+	*"CONFIG_MODULE_SIG_SHA224"*)
+		hash_alg="sha224"
+		;;
+	*"CONFIG_MODULE_SIG_SHA256"*)
+		hash_alg="sha256"
+		;;
+	*"CONFIG_MODULE_SIG_SHA384"*)
+		hash_alg="sha384"
+		;;
+	*"CONFIG_MODULE_SIG_SHA512"*)
+		hash_alg="sha512"
+		;;
+	*)
+		fail "Could not determine hash"
+		;;
+	esac
+fi
+
+v_out "Using: $hash_alg"
+
+v_out "Looking for signing key..."
+if [[ ! -e $BUILD_DIR/certs/signing_key.pem ]]; then
+	v_out "signing_key.pem not in certs/ finding location via Kconfig";
+	key_location=`grep MODULE_SIG_KEY $BUILD_DIR/.config`
+	if [[ -z $key_location ]]; then
+		fail "Could not determine key location"
+	fi
+	# Parse from .config
+	key_location=${key_location/CONFIG_MODULE_SIG_KEY=/}
+	# Drop quotes
+	key_location=${key_location//\"}
+	# Drop .pem
+	key_location=${key_location/.pem}
+	sig_key=$key_location
+
+else
+	sig_key=$BUILD_DIR/certs/signing_key
+fi
+
+v_out "Found key: $sig_key"
+
+v_out "Signing module [appended signature]..."
+
+$BUILD_DIR/scripts/sign-file $hash_alg $sig_key.pem \
+	$sig_key.x509 $ROOT/files/basic_mod.ko
+
+if [[ $? != 0 ]]; then
+	fail "Signing failed - please ensure sign-file is in scripts/"
+fi
+
+v_out "Attempting to load signed module with init_mod [should pass] ..."
+$mod_load $ROOT/files/basic_mod.ko init_module &>> /dev/null
+if [[ $? != 0 ]]; then
+	fail "Failed to load using init_module - check key used to sign module"
+fi
+v_out "Module loaded..."
+
+v_out "Unloading module..."
+rmmod basic_mod &>> /dev/null
+
+v_out "Attempting to load signed module with finit_mod [should fail]..."
+$mod_load $ROOT/files/basic_mod.ko finit_module &>> /dev/null
+# Several of these are piped to /dev/null - the text output doesn't matter here
+# the return code is kept
+if [[ $? == 0 ]]; then
+	fail
+fi
+v_out "Module loading blocked..."
+
+v_out "Signing file [extended file attribute]..."
+evmctl ima_sign -k $IMA_KEY -f $ROOT/files/basic_mod.ko
+
+if [[ $? != 0 ]]; then
+	fail "Error signing module - check keys"
+fi
+
+v_out "Attempting to load module with finit_mod [should pass]..."
+$mod_load $ROOT/files/basic_mod.ko finit_module &>> /dev/null
+
+v_out "Removing signature(s)..."
+
+setfattr -x security.ima $ROOT/files/basic_mod.ko &>> /dev/null
+strip --strip-debug $ROOT/files/basic_mod.ko
+
+v_out "Signing with unknown key..."
+evmctl ima_sign -f $ROOT/files/basic_mod.ko &>> /dev/null
+$mod_load $ROOT/files/basic_mod.ko finit_module &>> /dev/null
+if [[ $? == 0 ]]; then
+	fail "Allowed module to load with wrong signature"
+fi
+
+v_out "Prevented loading with finit_module"
+
+$mod_load $ROOT/files/basic_mod.ko init_module &>> /dev/null
+
+if [[ $? == 0 ]]; then
+	fail "Allowed module to load with wrong signature"
+fi
+v_out "Prevented loading with init_module"
+
+passed
diff --git a/evmtest/src/Makefile b/evmtest/src/Makefile
new file mode 100644
index 0000000..4c3f33d
--- /dev/null
+++ b/evmtest/src/Makefile
@@ -0,0 +1,5 @@
+obj-m += basic_mod.o
+
+all:
+	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
+	$(CC) kern_mod_loader.c -o kern_mod_loader
diff --git a/evmtest/src/basic_mod.c b/evmtest/src/basic_mod.c
new file mode 100644
index 0000000..7c49c74
--- /dev/null
+++ b/evmtest/src/basic_mod.c
@@ -0,0 +1,36 @@
+/*
+ * Basic kernel module
+ *
+ * Copyright (C) 2018 IBM
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+/*
+ * evmtest_load_type is a flag passed when loading the module, it indicates
+ * which syscall is being used. It should be either init_module or finit_module
+ * When loaded, evmtest_load_type is outputted to the kernel's message buffer
+ */
+static char *evmtest_load_type;
+
+module_param(evmtest_load_type, charp, 000);
+MODULE_PARM_DESC(evmtest_load_type, "Which syscall is loading this module.");
+
+static int __init basic_module_init(void)
+{
+	printk(KERN_INFO "EVMTEST: LOADED MODULE (%s)\n", evmtest_load_type);
+	return 0;
+}
+
+static void __exit basic_module_cleanup(void)
+{
+	printk(KERN_INFO "EVMTEST: UNLOADED MODULE (%s)\n", evmtest_load_type);
+}
+
+module_init(basic_module_init);
+module_exit(basic_module_cleanup);
+
+MODULE_AUTHOR("David Jacobson");
+MODULE_DESCRIPTION("Kernel module for testing IMA signatures");
+MODULE_LICENSE("GPL");
diff --git a/evmtest/src/kern_mod_loader.c b/evmtest/src/kern_mod_loader.c
new file mode 100644
index 0000000..fdb9ab1
--- /dev/null
+++ b/evmtest/src/kern_mod_loader.c
@@ -0,0 +1,131 @@
+/*
+* This program is free software: you can redistribute it and/or modify
+* it under the terms of the GNU General Public License as published by
+* the Free Software Foundation, either version 3 of the License, or
+* (at your option) any later version.
+
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+
+* You should have received a copy of the GNU General Public License
+* along with this program.  If not, see <https://www.gnu.org/licenses/>.
+*/
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+/*
+ * finit_module - load a kernel module using the finit_module syscall
+ * @fd: File Descriptor of the kernel module to be loaded
+ */
+int finit_module(int fd)
+{
+	return syscall(__NR_finit_module, fd,
+			"evmtest_load_type=finit_module", 0);
+}
+
+/*
+ * init_module - load a kernel module using the init_module syscall
+ * @fd: File Descriptor of the kernel module to be loaded
+ *
+ * Adapted explanation from: https://github.com/cirosantilli/
+ * linux-kernel-module-cheat/blob/
+ * 91583552ba2c2d547c8577ac888ab9f851642b25/kernel_module/user/
+ * myinsmod.c
+ */
+int init_module(int fd)
+{
+
+	struct stat st;
+
+	int mod = fstat(fd, &st);
+
+	if (mod != 0) {
+		printf("[!] Failed to load module\n");
+		return -1;
+	}
+
+	size_t im_size = st.st_size;
+	void *im = malloc(im_size);
+
+	if (im == NULL) {
+		printf("[!] Failed to load module - MALLOC NULL\n");
+		return -1;
+	}
+	read(fd, im, im_size);
+	close(fd);
+
+	int loaded = syscall(__NR_init_module, im, im_size,
+			     "evmtest_load_type=init_module");
+	free(im);
+
+	return loaded;
+}
+
+/*
+ * display_help - print out a help message to the user
+ */
+void display_help(void)
+{
+	printf("kern_mod_loader: Usage\n");
+	printf("kern_mod_loader <path> <finit_module|init_module>\n");
+}
+
+int main(int argc, char **argv)
+{
+
+	int ret;
+	int uid = getuid();
+
+	if (argc != 3) {
+		printf("[*] Please supply a path and load type\n");
+		printf("kern_mod_loader <path> <init_module|finit_module>\n");
+		return -1;
+	}
+
+	/* Root is required to try and load kernel modules */
+	if (uid != 0) {
+		printf("[!] kern_mod_loader must be run as root\n");
+		return -1;
+	}
+
+	int fd = open(argv[1], O_RDONLY);
+	if (fd == -1) {
+		printf("[!] Could not open file for read.\n");
+		return -1;
+	}
+
+	if (strncmp(argv[2], "finit_module", 12) == 0) {
+		printf("[*] Using finit_module syscall...\n");
+		ret = finit_module(fd);
+
+	} else if (strncmp(argv[2], "init_module", 11) == 0) {
+		printf("[*] Using init_module syscall...\n");
+		ret = init_module(fd);
+	} else {
+		printf("[!] Please use a valid syscall...\n");
+		return -1;
+	}
+
+	switch (ret) {
+	case 0:
+		printf("[*] Module loaded successfully.\n");
+		return ret;
+	case -1:
+		printf("[!] Could not load module\n");
+		printf("[!] This may be intended behavior\n");
+		return ret;
+	default:
+		printf("[!] Unknown error\n.");
+		return ret;
+	}
+}
-- 
2.17.1


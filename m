Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DBFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B4A218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfBZX2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:28:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729465AbfBZX2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:28:01 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QNO15r117367
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 18:28:00 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qwcj3fw0g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 18:28:00 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Feb 2019 23:27:51 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 23:27:48 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1QNRmYP51445766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 23:27:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAB1EA404D;
        Tue, 26 Feb 2019 23:27:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B2B5A4051;
        Tue, 26 Feb 2019 23:27:47 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.106.105])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Feb 2019 23:27:46 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v2 4/5] selftests/ima: kexec_file_load syscall test
Date:   Tue, 26 Feb 2019 18:26:59 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19022623-0016-0000-0000-0000025B496D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022623-0017-0000-0000-000032B5AE3D
Message-Id: <1551223620-11586-5-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-26_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel can be configured to verify PE signed kernel images, IMA
kernel image signatures, both types of signatures, or none.  This test
verifies only properly signed kernel images are loaded into memory,
based on the kernel configuration and runtime policies.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/ima/Makefile               |   2 +-
 tools/testing/selftests/ima/common_lib.sh          |  97 ++++++++++
 .../testing/selftests/ima/test_kexec_file_load.sh  | 195 +++++++++++++++++++++
 tools/testing/selftests/ima/test_kexec_load.sh     |   1 -
 4 files changed, 293 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/ima/test_kexec_file_load.sh

diff --git a/tools/testing/selftests/ima/Makefile b/tools/testing/selftests/ima/Makefile
index 46b9e04d2737..049c83c9426c 100644
--- a/tools/testing/selftests/ima/Makefile
+++ b/tools/testing/selftests/ima/Makefile
@@ -4,7 +4,7 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
-TEST_PROGS := test_kexec_load.sh
+TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
 TEST_FILES := common_lib.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/ima/common_lib.sh b/tools/testing/selftests/ima/common_lib.sh
index c6d04006281d..24091f29bd09 100755
--- a/tools/testing/selftests/ima/common_lib.sh
+++ b/tools/testing/selftests/ima/common_lib.sh
@@ -4,6 +4,9 @@
 # Kselftest framework defines: ksft_pass=0, ksft_fail=1, ksft_skip=4
 
 VERBOSE="${VERBOSE:-1}"
+IKCONFIG="/tmp/config-`uname -r`"
+KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
+SECURITYFS=$(grep "securityfs" /proc/mounts | awk '{print $2}')
 
 log_info()
 {
@@ -55,3 +58,97 @@ get_secureboot_mode()
 
 	return $ret
 }
+
+# Look for config option in Kconfig file.
+# Return 1 for found and 0 for not found.
+kconfig_enabled()
+{
+	local config="$1"
+	local msg="$2"
+
+        grep -E -q $config $IKCONFIG
+        if [ $? -eq 0 ]; then
+                log_info "$msg"
+                return 1
+        fi
+        return 0
+}
+
+# Attempt to get the kernel config first via proc, and then by
+# extracting it from the kernel image or the configs.ko using
+# scripts/extract-ikconfig.
+# Return 1 for found and 0 for not found.
+get_kconfig()
+{
+	local proc_config="/proc/config.gz"
+	local module_dir="/lib/modules/`uname -r`"
+	local configs_module="$module_dir/kernel/kernel/configs.ko"
+
+	if [ ! -f $proc_config ]; then
+		modprobe configs > /dev/null 2>&1
+	fi
+	if [ -f $proc_config ]; then
+		cat $proc_config | gunzip > $IKCONFIG 2>/dev/null
+		if [ $? -eq 0 ]; then
+			return 1
+		fi
+	fi
+
+	local extract_ikconfig="$module_dir/source/scripts/extract-ikconfig"
+	if [ ! -f $extract_ikconfig ]; then
+		log_skip "extract-ikconfig not found"
+	fi
+
+	$extract_ikconfig $KERNEL_IMAGE > $IKCONFIG 2>/dev/null
+	if [ $? -eq 1 ]; then
+		if [ ! -f $configs_module ]; then
+			log_skip "CONFIG_IKCONFIG not enabled"
+		fi
+		$extract_ikconfig $configs_module > $IKCONFIG
+		if [ $? -eq 1 ]; then
+			log_skip "CONFIG_IKCONFIG not enabled"
+		fi
+	fi
+	return 1
+}
+
+# Make sure that securityfs is mounted
+mount_securityfs()
+{
+	if [ -z $SECURITYFS ]; then
+		SECURITYFS=/sys/kernel/security
+		mount -t securityfs security $SECURITYFS
+	fi
+
+	if [ ! -d "$SECURITYFS" ]; then
+		log_fail "$SECURITYFS :securityfs is not mounted"
+	fi
+}
+
+# The policy rule format is an "action" followed by key-value pairs.  This
+# function supports up to two key-value pairs, in any order.
+# For example: action func=<keyword> [appraise_type=<type>]
+# Return 1 for found and 0 for not found.
+check_ima_policy()
+{
+	local action=$1
+	local keypair1="$2"
+	local keypair2="$3"
+
+	mount_securityfs
+
+	local ima_policy=$SECURITYFS/ima/policy
+	if [ ! -e $ima_policy ]; then
+		log_fail "$ima_policy not found"
+	fi
+
+	if [ -n $keypair2 ]; then
+		grep -e "^$action.*$keypair1" "$ima_policy" | \
+			grep -q -e "$keypair2"
+	else
+		grep -q -e "^$action.*$keypair1" "$ima_policy"
+	fi
+
+	[ $? -eq 0 ] && ret=1 || ret=0
+        return $ret
+}
diff --git a/tools/testing/selftests/ima/test_kexec_file_load.sh b/tools/testing/selftests/ima/test_kexec_file_load.sh
new file mode 100755
index 000000000000..e08c7e6cf28c
--- /dev/null
+++ b/tools/testing/selftests/ima/test_kexec_file_load.sh
@@ -0,0 +1,195 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Loading a kernel image via the kexec_file_load syscall can verify either
+# the IMA signature stored in the security.ima xattr or the PE signature,
+# both signatures depending on the IMA policy, or none.
+#
+# To determine whether the kernel image is signed, this test depends
+# on pesign and getfattr.  This test also requires the kernel to be
+# built with CONFIG_IKCONFIG enabled and either CONFIG_IKCONFIG_PROC
+# enabled or access to the extract-ikconfig script.
+
+TEST="KEXEC_FILE_LOAD"
+. ./common_lib.sh
+
+trap "{ rm -f $IKCONFIG ; }" EXIT
+
+# Some of the IMA builtin policies may require the kexec kernel image to
+# be signed, but these policy rules may be replaced with a custom
+# policy.  Only CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS persists after
+# loading a custom policy.  Check if it is enabled, before reading the
+# IMA runtime sysfs policy file.
+# Return 1 for IMA signature required and 0 for not required.
+is_ima_sig_required()
+{
+	local ret=0
+
+	kconfig_enabled "CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS=y" \
+		"IMA kernel image signature required"
+	if [ $? -eq 1 ]; then
+		log_info "IMA signature required"
+		return 1
+	fi
+
+	# The architecture specific or a custom policy may require the
+	# kexec kernel image be signed.  Policy rules are walked
+	# sequentially.  As a result, a policy rule may be defined, but
+	# might not necessarily be used.  This test assumes if a policy
+	# rule is specified, that is the intent.
+	if [ $ima_read_policy -eq 1 ]; then
+		check_ima_policy "appraise" "func=KEXEC_KERNEL_CHECK" \
+			"appraise_type=imasig"
+		ret=$?
+		[ $ret -eq 1 ] && log_info "IMA signature required";
+	fi
+	return $ret
+}
+
+# The kexec_file_load_test() is complicated enough, require pesign.
+# Return 1 for PE signature found and 0 for not found.
+check_for_pesig()
+{
+	which pesign > /dev/null 2>&1
+	if [ $?	-eq 1 ]; then
+		log_skip "pesign not found"
+	fi
+
+	pesign -i $KERNEL_IMAGE --show-signature | grep -q "No signatures"
+	local ret=$?
+	if [ $ret -eq 1 ]; then
+		log_info "kexec kernel image PE signed"
+	else
+		log_info "kexec kernel image not PE signed"
+	fi
+	return $ret
+}
+
+# The kexec_file_load_test() is complicated enough, require getfattr.
+# Return 1 for IMA signature found and 0 for not found.
+check_for_imasig()
+{
+	local ret=0
+
+	which getfattr > /dev/null 2>&1
+	if [ $?	-eq 1 ]; then
+		log_skip "getfattr not found"
+	fi
+
+	line=$(getfattr -n security.ima -e hex --absolute-names $KERNEL_IMAGE 2>&1)
+	echo $line | grep -q "security.ima=0x03"
+	if [ $? -eq 0 ]; then
+		ret=1
+		log_info "kexec kernel image IMA signed"
+	else
+		log_info "kexec kernel image not IMA signed"
+	fi
+	return $ret
+}
+
+kexec_file_load_test()
+{
+	local succeed_msg="kexec_file_load succeeded"
+	local failed_msg="kexec_file_load failed"
+	local key_msg="try enabling the CONFIG_INTEGRITY_PLATFORM_KEYRING"
+
+	line=$(kexec --load --kexec-file-syscall $KERNEL_IMAGE 2>&1)
+
+	if [ $? -eq 0 ]; then
+		kexec --unload --kexec-file-syscall
+
+		# In secureboot mode with an architecture  specific
+		# policy, make sure either an IMA or PE signature exists.
+		if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ] && \
+			[ $ima_signed -eq 0 ] && [ $pe_signed -eq 0 ]; then
+			log_fail "$succeed_msg (missing sig)"
+		fi
+
+		if [ $pe_sig_required -eq 1 ] && [ $pe_signed -eq 0 ]; then
+			log_fail "$succeed_msg (missing PE sig)"
+		fi
+
+		if [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ]; then
+			log_fail "$succeed_msg (missing IMA sig)"
+		fi
+
+		if [ $pe_sig_required -eq 0 ] && [ $ima_sig_required -eq 0 ] \
+		    && [ $ima_read_policy -eq 0 ] && [ $ima_signed -eq 0 ]; then
+			log_fail "$succeed_msg (possibly missing IMA sig)"
+		fi
+
+		log_pass "$succeed_msg"
+	fi
+
+	# Check the reason for the kexec_file_load failure
+	echo $line | grep -q "Required key not available"
+	if [ $? -eq 0 ]; then
+		if [ $platform_keyring -eq 0 ]; then
+			log_pass "$failed_msg (-ENOKEY), $key_msg"
+		else
+			log_pass "$failed_msg (-ENOKEY)"
+		fi
+	fi
+
+	if [ $pe_sig_required -eq 1 ] && [ $pe_signed -eq 0 ]; then
+		log_pass "$failed_msg (missing PE sig)"
+	fi
+
+	if [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ]; then
+		log_pass "$failed_msg (missing IMA sig)"
+	fi
+
+	if [ $pe_sig_required -eq 0 ] && [ $ima_sig_required -eq 0 ] \
+	    && [ $ima_read_policy -eq 0 ] && [ $ima_signed -eq 0 ]; then
+		log_pass "$failed_msg (possibly missing IMA sig)"
+	fi
+
+	log_pass "$failed_msg"
+	return 0
+}
+
+# kexec requires root privileges
+if [ $(id -ru) -ne 0 ]; then
+	log_skip "requires root privileges"
+fi
+
+# get the kernel config
+get_kconfig
+
+# Determine which kernel config options are enabled
+kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y" \
+	"architecture specific policy enabled"
+arch_policy=$?
+
+kconfig_enabled "CONFIG_INTEGRITY_PLATFORM_KEYRING=y" \
+	"platform keyring enabled"
+platform_keyring=$?
+
+kconfig_enabled "CONFIG_IMA_READ_POLICY=y" "reading IMA policy permitted"
+ima_read_policy=$?
+
+kconfig_enabled "CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y" \
+	"PE signed kernel image required"
+pe_sig_required=$?
+
+is_ima_sig_required
+ima_sig_required=$?
+
+get_secureboot_mode
+secureboot=$?
+
+if [ $secureboot -eq 0 ] && [ $arch_policy -eq 0 ] && \
+   [ $pe_sig_required -eq 0 ] && [ $ima_sig_required -eq 0 ] && \
+   [ $ima_read_policy -eq 1 ]; then
+	log_skip "No signature verification required"
+fi
+
+# Are there pe and ima signatures
+check_for_pesig
+pe_signed=$?
+
+check_for_imasig
+ima_signed=$?
+
+# Test loading the kernel image via kexec_file_load syscall
+kexec_file_load_test
diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
index 8b99017538ba..1c00fd6c4dcd 100755
--- a/tools/testing/selftests/ima/test_kexec_load.sh
+++ b/tools/testing/selftests/ima/test_kexec_load.sh
@@ -16,7 +16,6 @@ get_secureboot_mode
 secureboot=$?
 
 # kexec_load should fail in secure boot mode
-KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
 kexec --load $KERNEL_IMAGE 2>&1 > /dev/null
 if [ $? -eq 0 ]; then
 	kexec --unload
-- 
2.7.5


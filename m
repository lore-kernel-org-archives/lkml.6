Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B61DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5AA218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfAaS4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:56:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728295AbfAaS40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:56:26 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VIs922064369
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 13:56:25 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qc4xmwn3p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 13:56:25 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 31 Jan 2019 18:56:23 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 31 Jan 2019 18:56:20 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0VIuJXp54329458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Jan 2019 18:56:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89F9E4C050;
        Thu, 31 Jan 2019 18:56:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D7944C052;
        Thu, 31 Jan 2019 18:56:18 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.107.203])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 31 Jan 2019 18:56:18 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        David Howells <dhowells@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 3/3] selftests/ima: kexec_file_load syscall test
Date:   Thu, 31 Jan 2019 13:55:36 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19013118-0012-0000-0000-000002EF9C02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013118-0013-0000-0000-00002126E894
Message-Id: <1548960936-7800-4-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310141
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
 .../testing/selftests/ima/test_kexec_file_load.sh  | 250 +++++++++++++++++++++
 2 files changed, 251 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/ima/test_kexec_file_load.sh

diff --git a/tools/testing/selftests/ima/Makefile b/tools/testing/selftests/ima/Makefile
index 0b3adf5444b6..945fd203744c 100644
--- a/tools/testing/selftests/ima/Makefile
+++ b/tools/testing/selftests/ima/Makefile
@@ -4,7 +4,7 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
-TEST_PROGS := test_kexec_load.sh
+TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/ima/test_kexec_file_load.sh b/tools/testing/selftests/ima/test_kexec_file_load.sh
new file mode 100755
index 000000000000..70819662ed6f
--- /dev/null
+++ b/tools/testing/selftests/ima/test_kexec_file_load.sh
@@ -0,0 +1,250 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
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
+VERBOSE=1
+EXTRACT_IKCONFIG=$(ls /lib/modules/`uname -r`/source/scripts/extract-ikconfig)
+IKCONFIG=/tmp/config-`uname -r`
+PROC_CONFIG="/proc/config.gz"
+KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
+PESIGN=/usr/bin/pesign
+GETFATTR=/usr/bin/getfattr
+
+TEST="$0"
+. ./common_lib.sh
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+kconfig_enabled()
+{
+	RC=0
+	egrep -q $1 $IKCONFIG
+	if [ $? -eq 0 ]; then
+		RC=1
+	fi
+	return $RC
+}
+
+# policy rule format: action func=<keyword> [appraise_type=<type>]
+check_ima_policy()
+{
+	IMA_POLICY=/sys/kernel/security/ima/policy
+
+	RC=0
+	if [ $# -eq 3 ]; then
+		grep -e $2 $IMA_POLICY | grep -e "^$1.*$3" 2>&1 >/dev/null
+	else
+		grep -e $2 $IMA_POLICY | grep -e "^$1" 2>&1 >/dev/null
+	fi
+	if [ $? -eq 0 ]; then
+		RC=1
+	fi
+	return $RC
+}
+
+check_kconfig_options()
+{
+	# Attempt to get the kernel config first via proc, and then by
+	# extracting it from the kernel image using scripts/extract-ikconfig.
+	if [ ! -f $PROC_CONFIG ]; then
+		modprobe configs 2>/dev/null
+	fi
+	if [ -f $PROC_CONFIG ]; then
+		cat $PROC_CONFIG > $IKCONFIG
+	fi
+
+	if [ ! -f $IKCONFIG ]; then
+		if [ ! -f $EXTRACT_IKCONFIG ]; then
+			echo "$TEST: requires access to extract-ikconfig" >&2
+			exit $ksft_skip
+		fi
+
+		$EXTRACT_IKCONFIG $KERNEL_IMAGE > $IKCONFIG
+		kconfig_enabled "CONFIG_IKCONFIG=y"
+		if [ $? -eq 0 ]; then
+			echo "$TEST: requires the kernel to be built with CONFIG_IKCONFIG" >&2
+			exit $ksft_skip
+		fi
+	fi
+
+	kconfig_enabled "CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y"
+	pe_sig_required=$?
+	if [ $VERBOSE -ne 0 ] && [ $pe_sig_required -eq 1 ]; then
+		echo "$TEST: [INFO] PE signed kernel image required"
+	fi
+
+	kconfig_enabled "CONFIG_IMA_APPRAISE_REQUIRE_KEXEC_SIGS=y"
+	ima_sig_required=$?
+	if [ $VERBOSE -ne 0 ] && [ $ima_sig_required -eq 1 ]; then
+		echo "$TEST: [INFO] IMA kernel image signature required"
+	fi
+
+	kconfig_enabled "CONFIG_IMA_ARCH_POLICY=y"
+	arch_policy=$?
+	if [ $VERBOSE -ne 0 ] && [ $arch_policy -eq 1 ]; then
+		echo "$TEST: [INFO] architecture specific policy enabled"
+	fi
+
+	kconfig_enabled "CONFIG_INTEGRITY_PLATFORM_KEYRING=y"
+	platform_keyring=$?
+	if [ $VERBOSE -ne 0 ] && [ $platform_keyring -eq 1 ]; then
+		echo "$TEST: [INFO] platform kerying enabled"
+	fi
+
+	kconfig_enabled "CONFIG_IMA_READ_POLICY=y"
+	ima_read_policy=$?
+	if [ $VERBOSE -ne 0 ] && [ $ima_read_policy -eq 1 ]; then
+		echo "$TEST: [INFO] userspace can read IMA policy"
+	fi
+	rm $IKCONFIG
+}
+
+check_for_apps()
+{
+	if [ ! -f $PESIGN ]; then
+		PESIGN=$(which pesign 2>/dev/null)
+		if [ $?	-eq 1 ]; then
+			echo "$TEST: requires pesign" >&2
+			exit $ksft_skip
+		else
+			echo "$TEST: [INFO] found $PESIGN"
+		fi
+	fi
+
+	if [ ! -f $GETFATTR ]; then
+		GETFATTR=$(which getfattr 2>/dev/null)
+		if [ $?	-eq 1 ]; then
+			echo "$TEST: requires getfattr" >&2
+			exit $ksft_skip
+		else
+			echo "$TEST: [INFO] found $GETFATTR"
+		fi
+	fi
+}
+
+check_runtime()
+{
+	get_secureboot_mode
+	secureboot=$?
+	if [ $VERBOSE -ne 0 ] && [ $secureboot -eq 1 ]; then
+		echo "$TEST: [INFO] secure boot mode enabled"
+	fi
+	# The builtin "secure_boot" or custom policies might require an
+	# IMA signature.  Check the runtime appraise policy rules
+	# (eg. <securityfs>/ima/policy).  Policy rules are walked
+	# sequentially.  As a result, a policy rule may be defined,
+	# but might not necessarily be used.  This test assumes if a
+	# policy rule is specified, that is the intent.
+	if [ $ima_sig_required -eq 0 ] && [ $ima_read_policy -eq 1 ]; then
+		check_ima_policy "appraise" "func=KEXEC_KERNEL_CHECK" \
+			"appraise_type=imasig"
+		ima_sig_required=$?
+		if [ $VERBOSE -ne 0 ] && [ $ima_sig_required -eq 1 ]; then
+			echo "$TEST: [INFO] IMA signature required"
+		fi
+	fi
+}
+
+check_for_sigs()
+{
+	pe_signed=0
+	$PESIGN -i $KERNEL_IMAGE --show-signature | grep -q "No signatures"
+	pe_signed=$?
+	if [ $VERBOSE -ne 0 ]; then
+		if [ $pe_signed -eq 1 ]; then
+			echo "$TEST: [INFO] kexec kernel image PE signed"
+		else
+			echo "$TEST: [INFO] kexec kernel image not PE signed"
+		fi
+	fi
+
+	ima_signed=0
+	line=$($GETFATTR -n security.ima -e hex --absolute-names $KERNEL_IMAGE 2>&1)
+	echo $line | grep -q "security.ima=0x03"
+	if [ $? -eq 0 ]; then
+		ima_signed=1
+		if [ $VERBOSE -ne 0 ] ; then
+			echo "$TEST: [INFO] kexec kernel image IMA signed"
+		fi
+	elif [ $VERBOSE -ne 0 ]; then
+		echo "$TEST: [INFO] kexec kernel image not IMA signed"
+	fi
+}
+
+kexec_file_load_test()
+{
+	succeed_msg="$TEST: kexec_file_load succeeded "
+	failed_msg="$TEST: kexec_file_load failed "
+	platformkey_msg="try enabling the CONFIG_INTEGRITY_PLATFORM_KEYRING"
+	rc=0
+
+	line=$(kexec --load --kexec-file-syscall $KERNEL_IMAGE 2>&1)
+
+	# kexec_file_load succeeded. In secureboot mode with an architecture
+	# specific policy, make sure either an IMA or PE signature exists.
+	if [ $? -eq 0 ]; then
+		kexec --unload --kexec-file-syscall
+		if [ $arch_policy -eq 1 ] && [ $ima_signed -eq 0 ] && \
+		   [ $pe_signed -eq 0 ]; then
+			echo $succeed_msg "(missing sigs) [FAIL]"
+			rc=1
+		elif [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ]; then
+			echo $succeed_msg "(missing imasig) [FAIL]"
+			rc=1
+		elif [ $pe_sig_required -eq 1 ] && [ $pe_signed -eq 0 ]; then
+			echo $succeed_msg "(missing PE sig) [FAIL]"
+			rc=1
+		elif [ $ima_read_policy -eq 0 ] && [ $ima_sig_required -eq 0 ] \
+		      && [ $ima_signed -eq 0]; then
+			echo $succeed_msg "[UNKNOWN]"
+		else
+			echo $succeed_msg "[PASS]"
+		fi
+		return $rc
+	fi
+
+	# Check the reason for the kexec_file_load failure
+	echo $line | grep -q "Required key not available"
+	if [ $? -eq 0 ]; then
+		rc=1
+		if [ $platform_keyring -eq 0 ]; then
+			echo $failed_msg "(-ENOKEY)," $platformkey_msg
+		else
+			echo $failed_msg "(-ENOKEY)"
+		fi
+	elif [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ]; then
+		echo $TEST: $failed_msg "[PASS]"
+	elif [ $pe_sig_required -eq 1 ] && [ $pe_signed -eq 0 ]; then
+		echo $TEST: $failed_msg "[PASS]"
+	elif [ $ima_read_policy -eq 0 ] && [ $ima_sig_required -eq 0 ] && \
+	     [ $ima_signed -eq 0]; then
+		echo $failed_msg "[UNKNOWN]"
+	else
+		echo $TEST: $failed_msg "[FAIL]"
+		rc=1
+	fi
+	return $rc
+}
+
+# kexec requires root privileges
+if [ $(id -ru) != 0 ]; then
+	echo "$TEST: Requires root privileges" >&2
+	exit $ksft_skip
+fi
+
+check_kconfig_options
+check_for_apps
+check_runtime
+check_for_sigs
+kexec_file_load_test
+rc=$?
+exit $rc
-- 
2.7.5


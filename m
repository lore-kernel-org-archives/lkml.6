Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91C1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3035218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfBZX2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:28:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729364AbfBZX15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:27:57 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1QNNxvM032091
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 18:27:55 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qwe8hjfhy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 18:27:55 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 26 Feb 2019 23:27:53 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Feb 2019 23:27:50 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1QNRn1722937626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 23:27:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB553A4055;
        Tue, 26 Feb 2019 23:27:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C775A4051;
        Tue, 26 Feb 2019 23:27:49 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.106.105])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Feb 2019 23:27:49 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v2 5/5] selftests/ima: loading kernel modules
Date:   Tue, 26 Feb 2019 18:27:00 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
References: <1551223620-11586-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19022623-0016-0000-0000-0000025B496E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022623-0017-0000-0000-000032B5AE3E
Message-Id: <1551223620-11586-6-git-send-email-zohar@linux.ibm.com>
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

While the appended kernel module signature can be verified, when loading
a kernel module via either the init_module or the finit_module syscall,
verifying the IMA signature requires access to the file descriptor,
which is only available via the finit_module syscall.  As "modprobe"
does not provide a flag allowing the syscall - init_module or
finit_module - to be specified, this patch does not load a kernel
module.

This test simply verifies that on secure boot enabled systems with
"CONFIG_IMA_ARCH_POLICY" configured, that at least an appended kernel
module signature or an IMA signature is required based on the Kconfig
and the runtime IMA policy.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/ima/Makefile              |  2 +-
 tools/testing/selftests/ima/test_kernel_module.sh | 96 +++++++++++++++++++++++
 2 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/ima/test_kernel_module.sh

diff --git a/tools/testing/selftests/ima/Makefile b/tools/testing/selftests/ima/Makefile
index 049c83c9426c..ef5201ff0bea 100644
--- a/tools/testing/selftests/ima/Makefile
+++ b/tools/testing/selftests/ima/Makefile
@@ -4,7 +4,7 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
-TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
+TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh test_kernel_module.sh
 TEST_FILES := common_lib.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/ima/test_kernel_module.sh b/tools/testing/selftests/ima/test_kernel_module.sh
new file mode 100755
index 000000000000..4009e1b60b03
--- /dev/null
+++ b/tools/testing/selftests/ima/test_kernel_module.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# On secure boot enabled systems with "CONFIG_IMA_ARCH_POLICY" configured,
+# this test verifies that at least an appended kernel module signature or
+# an IMA signature is required.  It does not attempt to load a kernel module.
+
+TEST="KERNEL_MODULE"
+. ./common_lib.sh
+
+trap "{ rm -f $IKCONFIG ; }" EXIT
+
+# Some of the IMA builtin policies may require the kernel modules to
+# be signed, but these policy rules may be replaced with a custom
+# policy.  Only CONFIG_IMA_APPRAISE_REQUIRE_MODULE_SIGS persists after
+# loading a custom policy.  Check if it is enabled, before reading the
+# IMA runtime sysfs policy file.
+# Return 1 for IMA signature required and 0 for not required.
+is_ima_sig_required()
+{
+	local ret=0
+
+	kconfig_enabled "CONFIG_IMA_APPRAISE_REQUIRE_MODULE_SIGS=y" \
+		"IMA kernel module signature required"
+	if [ $? -eq 1 ]; then
+		log_info "IMA kernel module signature required"
+		return 1
+	fi
+
+	# The architecture specific or a custom policy may require the
+	# kernel module to be signed.  Policy rules are walked sequentially.
+	# As a result, a policy rule may be defined, but might not necessarily
+	# be used.  This test assumes if a policy rule is specified, that is
+	# the intent.
+	if [ $ima_read_policy -eq 1 ]; then
+		check_ima_policy "appraise" "func=MODULE_CHECK" \
+			"appraise_type=imasig"
+		ret=$?
+		[ $ret -eq 1 ] && log_info "IMA signature required";
+	fi
+	return $ret
+}
+
+# loading kernel modules requires root privileges
+if [ $(id -ru) -ne 0 ]; then
+	log_skip "requires root privileges"
+fi
+
+# Are appended signatures required?
+if [ -e /sys/module/module/parameters/sig_enforce ]; then
+	sig_enforce=$(cat /sys/module/module/parameters/sig_enforce)
+	if [ $sig_enforce = "Y" ]; then
+		log_pass "appended kernel module signature required"
+	fi
+fi
+
+get_secureboot_mode
+if [ $? -eq 0 ]; then
+	log_skip "secure boot not enabled"
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
+kconfig_enabled "CONFIG_MODULE_SIG=y" \
+	"appended kernel modules signature enabled"
+appended_sig_enabled=$?
+
+kconfig_enabled "CONFIG_IMA_READ_POLICY=y" "reading IMA policy permitted"
+ima_read_policy=$?
+
+is_ima_sig_required
+ima_sig_required=$?
+
+if [ $arch_policy -eq 0 ]; then
+	log_skip "architecture specific policy not enabled"
+fi
+
+if [ $appended_sig_enabled -eq 1 ]; then
+	log_fail "appended kernel module signature enabled, but not required"
+fi
+
+if [ $ima_sig_required -eq 1 ]; then
+	log_pass "IMA kernel module signature required"
+fi
+
+if [ $ima_read_policy -eq 1 ]; then
+	log_fail "IMA kernel module signature not required"
+else
+	log_skip "reading IMA policy not permitted"
+fi
-- 
2.7.5


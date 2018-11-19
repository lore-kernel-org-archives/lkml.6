Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481C2C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137D520831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137D520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbeKTGVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:21:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730663AbeKTGVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:21:44 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAJJrp4B052405
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 14:56:33 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nv1ewnnum-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 14:56:33 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 19 Nov 2018 19:56:30 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 19 Nov 2018 19:56:28 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAJJuQZv61604090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 19:56:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 441F3A405C;
        Mon, 19 Nov 2018 19:56:26 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C1CFA4060;
        Mon, 19 Nov 2018 19:56:25 +0000 (GMT)
Received: from dhcp-9-31-102-82.watson.ibm.com (unknown [9.31.102.82])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Nov 2018 19:56:24 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        jforbes@redhat.com, seth.forshee@canonical.com,
        kexec@lists.infradead.org, Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH 2/3] selftests/ima: kexec_load syscall test
Date:   Mon, 19 Nov 2018 14:56:10 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
References: <1542657371-7019-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111919-0020-0000-0000-000002EA70BB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111919-0021-0000-0000-000021399F02
Message-Id: <1542657371-7019-3-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=6 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811190178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel CONFIG_KEXEC_VERIFY_SIG option is limited to verifying a
kernel image's signature, when loaded via the kexec_file_load syscall.
There is no method for verifying a kernel image's signature loaded
via the kexec_load syscall.

This test verifies loading the kernel image via the kexec_load syscall
fails when the kernel CONFIG_KEXEC_VERIFY_SIG option is enabled on
systems with secureboot enabled[1].

[1] Detecting secureboot enabled is architecture specific.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/Makefile               |  1 +
 tools/testing/selftests/ima/Makefile           | 11 ++++++
 tools/testing/selftests/ima/config             |  4 ++
 tools/testing/selftests/ima/test_kexec_load.sh | 54 ++++++++++++++++++++++++++
 4 files changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/ima/Makefile
 create mode 100644 tools/testing/selftests/ima/config
 create mode 100755 tools/testing/selftests/ima/test_kexec_load.sh

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f1fe492c8e17..552c447af03d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -13,6 +13,7 @@ TARGETS += firmware
 TARGETS += ftrace
 TARGETS += futex
 TARGETS += gpio
+TARGETS += ima
 TARGETS += intel_pstate
 TARGETS += ipc
 TARGETS += kcmp
diff --git a/tools/testing/selftests/ima/Makefile b/tools/testing/selftests/ima/Makefile
new file mode 100644
index 000000000000..0b3adf5444b6
--- /dev/null
+++ b/tools/testing/selftests/ima/Makefile
@@ -0,0 +1,11 @@
+# Makefile for kexec_load
+
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+
+ifeq ($(ARCH),x86)
+TEST_PROGS := test_kexec_load.sh
+
+include ../lib.mk
+
+endif
diff --git a/tools/testing/selftests/ima/config b/tools/testing/selftests/ima/config
new file mode 100644
index 000000000000..6bc86d4d9bb4
--- /dev/null
+++ b/tools/testing/selftests/ima/config
@@ -0,0 +1,4 @@
+CONFIG_IMA_APPRAISE
+CONFIG_IMA_ARCH_POLICY
+CONFIG_SECURITYFS
+CONFIG_KEXEC_VERIFY_SIG
diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
new file mode 100755
index 000000000000..3aafc6f6a400
--- /dev/null
+++ b/tools/testing/selftests/ima/test_kexec_load.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Loading a kernel image via the kexec_load syscall should fail
+# when the kerne is CONFIG_KEXEC_VERIFY_SIG enabled and the system
+# is booted in secureboot mode.
+
+TEST="$0"
+EFIVARFS="/sys/firmware/efi/efivars"
+rc=0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+# kexec requires root privileges
+if [ $UID != 0 ]; then
+	echo "$TEST: must be run as root" >&2
+	exit $ksft_skip
+fi
+
+# Make sure that efivars is mounted in the normal location
+if ! grep -q "^\S\+ $EFIVARFS efivarfs" /proc/mounts; then
+	echo "$TEST: efivars is not mounted on $EFIVARFS" >&2
+	exit $ksft_skip
+fi
+
+# Get secureboot mode
+file="$EFIVARFS/SecureBoot-*"
+if [ ! -e $file ]; then
+	echo "$TEST: unknown secureboot mode" >&2
+	exit $ksft_skip
+fi
+secureboot=`hexdump $file | awk '{print substr($4,length($4),1)}'`
+
+# kexec_load should fail in secure boot mode
+KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
+kexec -l $KERNEL_IMAGE &>> /dev/null
+if [ $? == 0 ]; then
+	kexec -u
+	if [ "$secureboot" == "1" ]; then
+		echo "$TEST: kexec_load succeeded [FAIL]"
+		rc=1
+	else
+		echo "$TEST: kexec_load succeeded [PASS]"
+	fi
+else
+	if [ "$secureboot" == "1" ]; then
+		echo "$TEST: kexec_load failed [PASS]"
+	else
+		echo "$TEST: kexec_load failed [FAIL]"
+		rc=1
+	fi
+fi
+
+exit $rc
-- 
2.7.5


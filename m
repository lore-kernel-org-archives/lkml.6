Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CECBC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4320E240E7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4320E240E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754413AbeGEQmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:42:03 -0400
Received: from foss.arm.com ([217.140.101.70]:53652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754368AbeGEQmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:42:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B0F080D;
        Thu,  5 Jul 2018 09:42:00 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D29283F5BA;
        Thu,  5 Jul 2018 09:41:56 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, will.deacon@arm.com
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, aryabinin@virtuozzo.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, hpa@zytor.com, linuxdrivers@attotech.com,
        mark.rutland@arm.com, mingo@kernel.org, mingo@redhat.com,
        parri.andrea@gmail.com, peter@hurleysoftware.com,
        tglx@linutronix.de
Subject: [PATCHv3 11/12] atomics: check generated headers are up-to-date
Date:   Thu,  5 Jul 2018 17:40:52 +0100
Message-Id: <20180705164053.10073-12-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180705164053.10073-1-mark.rutland@arm.com>
References: <20180705164053.10073-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the generated atomic headers are in place, it would be good
to ensure that:

a) the headers are up-to-date when scripting changes.

b) developers don't directly modify the generated headers.

To ensure both of these properties, let's add a Kbuild step to check
that the generated headers are up-to-date.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 Kbuild                          | 18 ++++++++++++++++--
 scripts/atomic/check-atomics.sh | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100755 scripts/atomic/check-atomics.sh

diff --git a/Kbuild b/Kbuild
index 005304205482..47c9fe175bd9 100644
--- a/Kbuild
+++ b/Kbuild
@@ -6,7 +6,8 @@
 # 2) Generate timeconst.h
 # 3) Generate asm-offsets.h (may need bounds.h and timeconst.h)
 # 4) Check for missing system calls
-# 5) Generate constants.py (may need bounds.h)
+# 5) check atomics headers are up-to-date
+# 6) Generate constants.py (may need bounds.h)
 
 #####
 # 1) Generate bounds.h
@@ -72,7 +73,20 @@ missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
 	$(call cmd,syscalls)
 
 #####
-# 5) Generate constants for Python GDB integration
+# 5) Check atomic headers are up-to-date
+#
+
+always += old-atomics
+targets += old-atomics
+
+quiet_cmd_atomics = CALL    $<
+      cmd_atomics = $(CONFIG_SHELL) scripts/atomic/check-atomics.sh
+
+old-atomics: scripts/atomic/check-atomics.sh FORCE
+	$(call cmd,atomics)
+
+#####
+# 6) Generate constants for Python GDB integration
 #
 
 extra-$(CONFIG_GDB_SCRIPTS) += build_constants_py
diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
new file mode 100755
index 000000000000..c30101cddf2d
--- /dev/null
+++ b/scripts/atomic/check-atomics.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Check if atomic headers are up-to-date
+
+ATOMICDIR=$(dirname $0)
+ATOMICTBL=${ATOMICDIR}/atomics.tbl
+LINUXDIR=${ATOMICDIR}/../..
+
+cat <<EOF |
+gen-atomic-instrumented.sh      asm-generic/atomic-instrumented.h
+gen-atomic-long.sh              asm-generic/atomic-long.h
+gen-atomic-fallback.sh          linux/atomic-fallback.h
+EOF
+while read script header; do
+	if ! (${ATOMICDIR}/${script} ${ATOMICTBL} | diff - ${LINUXDIR}/include/${header} > /dev/null); then
+		printf "warning: include/${header} is out-of-date.\n"
+	fi
+done
-- 
2.11.0


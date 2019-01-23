Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A86C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA88521841
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfAWLKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:10:17 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7521 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727075AbfAWLKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:10:12 -0500
X-IronPort-AV: E=Sophos;i="5.56,510,1539619200"; 
   d="scan'208";a="52651122"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Jan 2019 19:10:08 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 0D5FD4BAD9D9;
        Wed, 23 Jan 2019 19:10:05 +0800 (CST)
Received: from localhost.local (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 23 Jan 2019 19:10:11 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>, <kasong@redhat.com>
Subject: [PATCH v16 2/7] x86/boot: Introduce get_acpi_rsdp() to parse RSDP in cmdline from KEXEC
Date:   Wed, 23 Jan 2019 19:08:45 +0800
Message-ID: <20190123110850.12433-3-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123110850.12433-1-fanc.fnst@cn.fujitsu.com>
References: <20190123110850.12433-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 0D5FD4BAD9D9.AEB98
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASLR may randomly choose some positions which are located in movable
memory regions. This will make the movable memory chosen by KASLR
can't be removed.

Memory information in SRAT is necessary to fix the conflict between
KASLR and memory-hotremove.

ACPI SRAT (System/Static Resource Affinity Table) shows the details
about memory ranges, including ranges of memory provided by hot-added
memory devices. SRAT is introduced by Root System Description
Pointer(RSDP). So RSDP should be found firstly.

When booting form KEXEC/EFI/BIOS, the methods to find RSDP
are different. When booting from KEXEC, 'acpi_rsdp=' may have been
added to cmdline, so parse cmdline to find RSDP.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/acpi.c | 32 ++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/misc.h |  3 +++
 2 files changed, 35 insertions(+)
 create mode 100644 arch/x86/boot/compressed/acpi.c

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
new file mode 100644
index 000000000000..bacfc4ea35ac
--- /dev/null
+++ b/arch/x86/boot/compressed/acpi.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BOOT_CTYPE_H
+#include "misc.h"
+#include "error.h"
+#include "../string.h"
+
+#ifdef CONFIG_ACPI
+
+/*
+ * Max length of 64-bit hex address string is 19, prefix "0x" + 16 hex
+ * digits, and '\0' for termination.
+ */
+#define MAX_ADDR_LEN 19
+
+static acpi_physical_address get_acpi_rsdp(void)
+{
+	acpi_physical_address addr = 0;
+
+#ifdef CONFIG_KEXEC
+	char val[MAX_ADDR_LEN] = { };
+	int ret;
+
+	ret = cmdline_find_option("acpi_rsdp", val, MAX_ADDR_LEN);
+	if (ret < 0)
+		return 0;
+
+	if (kstrtoull(val, 16, &addr))
+		return 0;
+#endif
+	return addr;
+}
+#endif /* CONFIG_ACPI */
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index a1d5918765f3..764ad50c0119 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -25,6 +25,9 @@
 #include <asm/bootparam.h>
 #include <asm/bootparam_utils.h>
 
+#define BOOT_CTYPE_H
+#include <linux/acpi.h>
+
 #define BOOT_BOOT_H
 #include "../ctype.h"
 
-- 
2.20.1




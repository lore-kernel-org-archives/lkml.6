Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BDEC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A23C2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A23C2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbeLNJay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:30:54 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6629 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728866AbeLNJau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:30:50 -0500
X-IronPort-AV: E=Sophos;i="5.56,352,1539619200"; 
   d="scan'208";a="49767742"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2018 17:30:49 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 392FE4B734D8;
        Fri, 14 Dec 2018 17:30:46 +0800 (CST)
Received: from localhost.local (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Dec 2018 17:30:45 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <msys.mizuma@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v14 1/5] x86/boot: Introduce get_acpi_rsdp() to parse RSDP in cmdline from KEXEC
Date:   Fri, 14 Dec 2018 17:30:09 +0800
Message-ID: <20181214093013.13370-2-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 392FE4B734D8.A8A8E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory information in SRAT is necessary to fix the conflict between
KASLR and memory-hotremove.

ACPI SRAT (System/Static Resource Affinity Table) shows the details
about memory ranges, including ranges of memory provided by hot-added
memory devices. SRAT is introduced by Root System Description
Pointer(RSDP), so RSDP should be found firstly.

When booting form KEXEC/EFI/BIOS, the methods to find RSDP
are different. When booting from KEXEC, 'acpi_rsdp' may have been
added to cmdline, so parse cmdline to find RSDP.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/acpi.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 arch/x86/boot/compressed/acpi.c

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
new file mode 100644
index 000000000000..44f19546c169
--- /dev/null
+++ b/arch/x86/boot/compressed/acpi.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+#define BOOT_CTYPE_H
+#include "misc.h"
+#include "error.h"
+
+#include <linux/efi.h>
+#include <linux/numa.h>
+#include <linux/acpi.h>
+#include <asm/efi.h>
+
+/* Max length of 64-bit hex address string is 18, prefix "0x" + 16 hex digits */
+#define MAX_ADDRESS_LENGTH 18
+
+static acpi_physical_address get_acpi_rsdp(void)
+{
+#ifdef CONFIG_KEXEC
+	char val[MAX_ADDRESS_LENGTH+1];
+	unsigned long long res;
+	int len;
+
+	len = cmdline_find_option("acpi_rsdp", val, MAX_ADDRESS_LENGTH+1);
+	if (len > 0) {
+		char *e;
+
+		val[len] = '\0';
+		return (acpi_physical_address)simple_strtoull(val, &e, 16);
+	}
+#endif
+	return 0;
+}
-- 
2.19.2




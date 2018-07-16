Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5771EECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058A720BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058A720BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbeGPJX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:23:56 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:55883 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727192AbeGPJXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:23:55 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42280505"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Jul 2018 16:57:29 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 419B64B625E7;
        Mon, 16 Jul 2018 16:57:27 +0800 (CST)
Received: from localhost (10.167.225.56) by G08CNEXCHPEKD02.g08.fujitsu.local
 (10.167.33.89) with Microsoft SMTP Server id 14.3.399.0; Mon, 16 Jul 2018
 16:57:29 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>
CC:     <indou.takao@jp.fujitsu.com>, <lcapitulino@redhat.com>,
        <caoj.fnst@cn.fujitsu.com>, <douly.fnst@cn.fujitsu.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [RFC PATCH v2 1/4] x86/boot: Add acpitb.h to help parse acpi tables
Date:   Mon, 16 Jul 2018 16:55:35 +0800
Message-ID: <20180716085538.31939-2-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716085538.31939-1-fanc.fnst@cn.fujitsu.com>
References: <20180716085538.31939-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: 419B64B625E7.AA9DF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to parse ACPI tables, reuse the head file linux/acpi.h,
so that the files in 'compressed' directory can read ACPI table
by including this head file.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
---
 arch/x86/boot/compressed/acpitb.h | 49 +++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 arch/x86/boot/compressed/acpitb.h

diff --git a/arch/x86/boot/compressed/acpitb.h b/arch/x86/boot/compressed/acpitb.h
new file mode 100644
index 000000000000..b51dedb7c46f
--- /dev/null
+++ b/arch/x86/boot/compressed/acpitb.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/acpi.h>
+
+#define ACPI_MAX_TABLES                128
+
+struct acpi_table_header *get_acpi_srat_table(void);
+
+#ifdef ACPI_BIG_ENDIAN
+
+#define ACPI_MOVE_64_TO_64(d, s) \
+{((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[7]; \
+((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[6]; \
+((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[5]; \
+((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[4]; \
+((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3]; \
+((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[2]; \
+((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1]; \
+((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0]; }
+
+#define ACPI_MOVE_16_TO_32(d, s) \
+{(*(u32 *)(void *)(d)) = 0; \
+((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1]; \
+((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0]; }
+
+#else
+#ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
+
+#define ACPI_MOVE_64_TO_64(d, s) \
+{*(u64 *)(void *)(d) = *(u64 *)(void *)(s); }
+
+#define ACPI_MOVE_16_TO_32(d, s) \
+{*(u32 *)(void *)(d) = *(u16 *)(void *)(s); }
+
+#else
+#define ACPI_MOVE_64_TO_64(d, s) \
+{((u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0]; \
+((u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1]; \
+((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2]; \
+((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3]; \
+((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[4]; \
+((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[5]; \
+((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[6]; \
+((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[7]; }
+
+#define ACPI_MOVE_16_TO_32(d, s) \
+{(*(u32 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s); }
+
+#endif
+#endif
-- 
2.17.1




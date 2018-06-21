Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62F7C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF8020837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF8020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754620AbeFUBsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:48:40 -0400
Received: from exmail.andestech.com ([59.124.169.137]:12085 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754551AbeFUBsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:48:37 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id w5L1gZ7D038580
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 09:42:35 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w5L1gCGE038505;
        Thu, 21 Jun 2018 09:42:12 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 21 Jun 2018
 09:42:32 +0800
From:   Zong Li <zong@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Zong Li <zong@andestech.com>, <greentime@adnestech.com>
Subject: [PATCH 5/5] RISC-V: Use fixed width integer types for 32-bit compatible
Date:   Thu, 21 Jun 2018 09:41:46 +0800
Message-ID: <37a6523947397cd72320676030b96926e373d05a.1529506497.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1529506497.git.zong@andestech.com>
References: <cover.1529506497.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w5L1gCGE038505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use fixed width integer types for print format on 32/64 bit
to fix warning about format compatible.

Like inttypes.h, but more simpler for RISC-V usage.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/include/asm/format.h | 20 ++++++++++++++++++++
 arch/riscv/kernel/module.c      | 13 +++++++------
 2 files changed, 27 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/include/asm/format.h

diff --git a/arch/riscv/include/asm/format.h b/arch/riscv/include/asm/format.h
new file mode 100644
index 000000000000..9b68ca7fac46
--- /dev/null
+++ b/arch/riscv/include/asm/format.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2018 Andes Technology Corporation */
+
+#ifndef _ASM_RISCV_FORMAT_H
+#define _ASM_RISCV_FORMAT_H
+
+#if __riscv_xlen == 64
+#define __PRI_PREFIX	"ll"
+#else
+#define __PRI_PREFIX
+#endif
+
+#define PRIdX	__PRI_PREFIX "d"
+#define PRIiX	__PRI_PREFIX "i"
+#define PRIuX	__PRI_PREFIX "u"
+#define PRIoX	__PRI_PREFIX "o"
+#define PRIxX	__PRI_PREFIX "x"
+#define PRIXX	__PRI_PREFIX "X"
+
+#endif /* _ASM_RISCV_FORMAT_H */
diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index c88d2ee918a5..039f755ff3e3 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -18,11 +18,12 @@
 #include <linux/moduleloader.h>
 #include <linux/vmalloc.h>
 #include <asm/pgtable.h>
+#include <asm/format.h>
 
 static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_Addr v)
 {
 	if (v != (u32)v) {
-		pr_err("%s: value %016llx out of range for 32-bit field\n",
+		pr_err("%s: value %016" PRIxX "out of range for 32-bit field\n",
 		       me->name, v);
 		return -EINVAL;
 	}
@@ -103,7 +104,7 @@ static int apply_r_riscv_pcrel_hi20_rela(struct module *me, u32 *location,
 
 	if (offset != (s32)offset) {
 		pr_err(
-		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
+		  "%s: target %016" PRIxX "can not be addressed by the 32-bit offset from PC = %p\n",
 		  me->name, v, location);
 		return -EINVAL;
 	}
@@ -145,7 +146,7 @@ static int apply_r_riscv_hi20_rela(struct module *me, u32 *location,
 
 	if (IS_ENABLED(CMODEL_MEDLOW)) {
 		pr_err(
-		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
+		  "%s: target %016" PRIxX "can not be addressed by the 32-bit offset from PC = %p\n",
 		  me->name, v, location);
 		return -EINVAL;
 	}
@@ -189,7 +190,7 @@ static int apply_r_riscv_got_hi20_rela(struct module *me, u32 *location,
 		offset = (void *)offset - (void *)location;
 	} else {
 		pr_err(
-		  "%s: can not generate the GOT entry for symbol = %016llx from PC = %p\n",
+		  "%s: can not generate the GOT entry for symbol = %016" PRIxX "from PC = %p\n",
 		  me->name, v, location);
 		return -EINVAL;
 	}
@@ -213,7 +214,7 @@ static int apply_r_riscv_call_plt_rela(struct module *me, u32 *location,
 			offset = (void *)offset - (void *)location;
 		} else {
 			pr_err(
-			  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
+			  "%s: target %016" PRIxX "can not be addressed by the 32-bit offset from PC = %p\n",
 			  me->name, v, location);
 			return -EINVAL;
 		}
@@ -235,7 +236,7 @@ static int apply_r_riscv_call_rela(struct module *me, u32 *location,
 
 	if (offset != fill_v) {
 		pr_err(
-		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
+		  "%s: target %016" PRIxX "can not be addressed by the 32-bit offset from PC = %p\n",
 		  me->name, v, location);
 		return -EINVAL;
 	}
-- 
2.16.1


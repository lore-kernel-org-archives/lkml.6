Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C874DC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B3320837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B3320837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754580AbeFUBsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:48:35 -0400
Received: from exmail.andestech.com ([59.124.169.137]:51918 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754330AbeFUBsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:48:32 -0400
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id w5L1gJiC038535
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 09:42:19 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w5L1g2HZ038446;
        Thu, 21 Jun 2018 09:42:02 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 21 Jun 2018
 09:42:22 +0800
From:   Zong Li <zong@andestech.com>
To:     <palmer@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Zong Li <zong@andestech.com>, <greentime@adnestech.com>
Subject: [PATCH 3/5] RISC-V: Add definiion of extract symbol's index and type for 32-bit
Date:   Thu, 21 Jun 2018 09:41:44 +0800
Message-ID: <3081ab2d2c70e3b1826a9930c90eac33dacce7d2.1529506497.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1529506497.git.zong@andestech.com>
References: <cover.1529506497.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w5L1g2HZ038446
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic marco to get the index and type of symbol.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/include/uapi/asm/elf.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
index 5cae4c30cd8e..1e0dfc36aab9 100644
--- a/arch/riscv/include/uapi/asm/elf.h
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -21,8 +21,13 @@ typedef struct user_regs_struct elf_gregset_t;
 
 typedef union __riscv_fp_state elf_fpregset_t;
 
-#define ELF_RISCV_R_SYM(r_info) ((r_info) >> 32)
-#define ELF_RISCV_R_TYPE(r_info) ((r_info) & 0xffffffff)
+#if __riscv_xlen == 64
+#define ELF_RISCV_R_SYM(r_info)		ELF64_R_SYM(r_info)
+#define ELF_RISCV_R_TYPE(r_info)	ELF64_R_TYPE(r_info)
+#else
+#define ELF_RISCV_R_SYM(r_info)		ELF32_R_SYM(r_info)
+#define ELF_RISCV_R_TYPE(r_info)	ELF32_R_TYPE(r_info)
+#endif
 
 /*
  * RISC-V relocation types
-- 
2.16.1


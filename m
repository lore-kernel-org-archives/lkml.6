Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeCMIvj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:51:39 -0400
Received: from exmail.andestech.com ([59.124.169.137]:25662 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932279AbeCMIs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:48:26 -0400
From: Zong Li <zong@andestech.com>
To: <palmer@sifive.com>, <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zong@andestech.com>, <zongbox@gmail.com>
CC: <greentime@andestech.com>
Subject: [PATCH 04/11] RISC-V: Support CALL relocation type in kernel module
Date: Tue, 13 Mar 2018 16:35:09 +0800
Message-ID: <a0947eb75726861ea1c37c1f64ebe888b590b5cf.1520928420.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1520928420.git.zong@andestech.com>
References: <cover.1520928420.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w2D8XFFS025056
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/module.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 242d3a14c210..7e85e5840b4d 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -141,6 +141,27 @@ static int apply_r_riscv_call_plt_rela(struct module *me, u32 *location,
 	return 0;
 }
 
+static int apply_r_riscv_call_rela(struct module *me, u32 *location,
+				   Elf_Addr v)
+{
+	s64 offset = (void *)v - (void *)location;
+	s32 fill_v = offset;
+	u32 hi20, lo12;
+
+	if (offset != fill_v) {
+		pr_err(
+		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
+		  me->name, v, location);
+		return -EINVAL;
+	}
+
+	hi20 = (offset + 0x800) & 0xfffff000;
+	lo12 = (offset - hi20) & 0xfff;
+	*location = (*location & 0xfff) | hi20;
+	*(location + 1) = (*(location + 1) & 0xfffff) | (lo12 << 20);
+	return 0;
+}
+
 static int apply_r_riscv_relax_rela(struct module *me, u32 *location,
 				    Elf_Addr v)
 {
@@ -157,6 +178,7 @@ static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 	[R_RISCV_PCREL_LO12_S]		= apply_r_riscv_pcrel_lo12_s_rela,
 	[R_RISCV_GOT_HI20]		= apply_r_riscv_got_hi20_rela,
 	[R_RISCV_CALL_PLT]		= apply_r_riscv_call_plt_rela,
+	[R_RISCV_CALL]			= apply_r_riscv_call_rela,
 	[R_RISCV_RELAX]			= apply_r_riscv_relax_rela,
 };
 
-- 
2.16.1

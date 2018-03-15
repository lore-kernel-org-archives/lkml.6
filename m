Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeCOIvp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:51:45 -0400
Received: from exmail.andestech.com ([59.124.169.137]:8001 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeCOIvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:51:43 -0400
From: Zong Li <zong@andestech.com>
To: <palmer@sifive.com>, <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zong@andestech.com>, <zongbox@gmail.com>
CC: <greentime@andestech.com>
Subject: [PATCH v2 05/11] RISC-V: Support HI20/LO12_I/LO12_S relocation type in kernel module
Date: Thu, 15 Mar 2018 16:50:45 +0800
Message-ID: <b2a2fcef9a56d6febda05260880d63aabda58403.1521103172.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1521103167.git.zong@andestech.com>
References: <cover.1521103167.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w2F8lp8f080949
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI20 and LO12_I/LO12_S relocate the absolute address, the range of
offset must in 32-bit.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/module.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 3f2730840c25..f1bd6b1a4520 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -92,6 +92,45 @@ static int apply_r_riscv_pcrel_lo12_s_rela(struct module *me, u32 *location,
 	return 0;
 }
 
+static int apply_r_riscv_hi20_rela(struct module *me, u32 *location,
+				   Elf_Addr v)
+{
+	s32 hi20;
+
+	if (IS_ENABLED(CMODEL_MEDLOW)) {
+		pr_err(
+		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
+		  me->name, v, location);
+		return -EINVAL;
+	}
+
+	hi20 = ((s32)v + 0x800) & 0xfffff000;
+	*location = (*location & 0xfff) | hi20;
+	return 0;
+}
+
+static int apply_r_riscv_lo12_i_rela(struct module *me, u32 *location,
+				     Elf_Addr v)
+{
+	/* Skip medlow checking because of filtering by HI20 already */
+	s32 hi20 = ((s32)v + 0x800) & 0xfffff000;
+	s32 lo12 = ((s32)v - hi20);
+	*location = (*location & 0xfffff) | ((lo12 & 0xfff) << 20);
+	return 0;
+}
+
+static int apply_r_riscv_lo12_s_rela(struct module *me, u32 *location,
+				     Elf_Addr v)
+{
+	/* Skip medlow checking because of filtering by HI20 already */
+	s32 hi20 = ((s32)v + 0x800) & 0xfffff000;
+	s32 lo12 = ((s32)v - hi20);
+	u32 imm11_5 = (lo12 & 0xfe0) << (31 - 11);
+	u32 imm4_0 = (lo12 & 0x1f) << (11 - 4);
+	*location = (*location & 0x1fff07f) | imm11_5 | imm4_0;
+	return 0;
+}
+
 static int apply_r_riscv_got_hi20_rela(struct module *me, u32 *location,
 				       Elf_Addr v)
 {
@@ -176,6 +215,9 @@ static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 	[R_RISCV_PCREL_HI20]		= apply_r_riscv_pcrel_hi20_rela,
 	[R_RISCV_PCREL_LO12_I]		= apply_r_riscv_pcrel_lo12_i_rela,
 	[R_RISCV_PCREL_LO12_S]		= apply_r_riscv_pcrel_lo12_s_rela,
+	[R_RISCV_HI20]			= apply_r_riscv_hi20_rela,
+	[R_RISCV_LO12_I]		= apply_r_riscv_lo12_i_rela,
+	[R_RISCV_LO12_S]		= apply_r_riscv_lo12_s_rela,
 	[R_RISCV_GOT_HI20]		= apply_r_riscv_got_hi20_rela,
 	[R_RISCV_CALL_PLT]		= apply_r_riscv_call_plt_rela,
 	[R_RISCV_CALL]			= apply_r_riscv_call_rela,
-- 
2.16.1

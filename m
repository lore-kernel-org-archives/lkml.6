Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbeCOIwJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:52:09 -0400
Received: from exmail.andestech.com ([59.124.169.137]:7659 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeCOIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:52:04 -0400
From: Zong Li <zong@andestech.com>
To: <palmer@sifive.com>, <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zong@andestech.com>, <zongbox@gmail.com>
CC: <greentime@andestech.com>
Subject: [PATCH v2 06/11] RISC-V: Support RVC_BRANCH/JUMP relocation type in kernel modulewq
Date: Thu, 15 Mar 2018 16:50:46 +0800
Message-ID: <b3261ff2c00ddf787651adcc87f097a8a97a5839.1521103173.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1521103167.git.zong@andestech.com>
References: <cover.1521103167.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w2F8luE5080966
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/module.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index f1bd6b1a4520..7ab6a9b72384 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -49,6 +49,39 @@ static int apply_r_riscv_jal_rela(struct module *me, u32 *location,
 	return 0;
 }
 
+static int apply_r_riscv_rcv_branch_rela(struct module *me, u32 *location,
+					 Elf_Addr v)
+{
+	s64 offset = (void *)v - (void *)location;
+	u16 imm8 = (offset & 0x100) << (12 - 8);
+	u16 imm7_6 = (offset & 0xc0) >> (6 - 5);
+	u16 imm5 = (offset & 0x20) >> (5 - 2);
+	u16 imm4_3 = (offset & 0x18) << (12 - 5);
+	u16 imm2_1 = (offset & 0x6) << (12 - 10);
+
+	*(u16 *)location = (*(u16 *)location & 0xe383) |
+		    imm8 | imm7_6 | imm5 | imm4_3 | imm2_1;
+	return 0;
+}
+
+static int apply_r_riscv_rvc_jump_rela(struct module *me, u32 *location,
+				       Elf_Addr v)
+{
+	s64 offset = (void *)v - (void *)location;
+	u16 imm11 = (offset & 0x800) << (12 - 11);
+	u16 imm10 = (offset & 0x400) >> (10 - 8);
+	u16 imm9_8 = (offset & 0x300) << (12 - 11);
+	u16 imm7 = (offset & 0x80) >> (7 - 6);
+	u16 imm6 = (offset & 0x40) << (12 - 11);
+	u16 imm5 = (offset & 0x20) >> (5 - 2);
+	u16 imm4 = (offset & 0x10) << (12 - 5);
+	u16 imm3_1 = (offset & 0xe) << (12 - 10);
+
+	*(u16 *)location = (*(u16 *)location & 0xe003) |
+		    imm11 | imm10 | imm9_8 | imm7 | imm6 | imm5 | imm4 | imm3_1;
+	return 0;
+}
+
 static int apply_r_riscv_pcrel_hi20_rela(struct module *me, u32 *location,
 					 Elf_Addr v)
 {
@@ -212,6 +245,8 @@ static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 	[R_RISCV_64]			= apply_r_riscv_64_rela,
 	[R_RISCV_BRANCH]		= apply_r_riscv_branch_rela,
 	[R_RISCV_JAL]			= apply_r_riscv_jal_rela,
+	[R_RISCV_RVC_BRANCH]		= apply_r_riscv_rcv_branch_rela,
+	[R_RISCV_RVC_JUMP]		= apply_r_riscv_rvc_jump_rela,
 	[R_RISCV_PCREL_HI20]		= apply_r_riscv_pcrel_hi20_rela,
 	[R_RISCV_PCREL_LO12_I]		= apply_r_riscv_pcrel_lo12_i_rela,
 	[R_RISCV_PCREL_LO12_S]		= apply_r_riscv_pcrel_lo12_s_rela,
-- 
2.16.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeCMIte (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:49:34 -0400
Received: from exmail.andestech.com ([59.124.169.137]:46571 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752473AbeCMIsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:48:35 -0400
From: Zong Li <zong@andestech.com>
To: <palmer@sifive.com>, <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zong@andestech.com>, <zongbox@gmail.com>
CC: <greentime@andestech.com>
Subject: [PATCH 07/11] RISC-V: Support ALIGN relocation type in kernel module
Date: Tue, 13 Mar 2018 16:35:12 +0800
Message-ID: <64e85dd0127ae1566864e23cbfdacd45d0f31f87.1520928420.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1520928420.git.zong@andestech.com>
References: <cover.1520928420.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w2D8XUuj025116
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just ignore align type. The nop instructions cannot be removed in
kernel module. Kernel modules is not doing relax.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/module.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index e23c051dfc62..351bf2a518ee 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -240,6 +240,12 @@ static int apply_r_riscv_relax_rela(struct module *me, u32 *location,
 	return 0;
 }
 
+static int apply_r_riscv_align_rela(struct module *me, u32 *location,
+				    Elf_Addr v)
+{
+	return 0;
+}
+
 static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 				Elf_Addr v) = {
 	[R_RISCV_64]			= apply_r_riscv_64_rela,
@@ -257,6 +263,7 @@ static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 	[R_RISCV_CALL_PLT]		= apply_r_riscv_call_plt_rela,
 	[R_RISCV_CALL]			= apply_r_riscv_call_rela,
 	[R_RISCV_RELAX]			= apply_r_riscv_relax_rela,
+	[R_RISCV_ALIGN]			= apply_r_riscv_align_rela,
 };
 
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
-- 
2.16.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeCOIwI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:52:08 -0400
Received: from exmail.andestech.com ([59.124.169.137]:13184 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbeCOIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:52:04 -0400
From: Zong Li <zong@andestech.com>
To: <palmer@sifive.com>, <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zong@andestech.com>, <zongbox@gmail.com>
CC: <greentime@andestech.com>
Subject: [PATCH v2 07/11] RISC-V: Support ALIGN relocation type in kernel module
Date: Thu, 15 Mar 2018 16:50:47 +0800
Message-ID: <65bad5a6944562c80a019fe18d0761623e66c57f.1521103173.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1521103167.git.zong@andestech.com>
References: <cover.1521103167.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w2F8m2sb081018
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just fail on align type. Kernel modules loader didn't do relax
like linker, it is difficult to remove or migrate the code,
but the remnant nop instructions harm the performaace of module.
We expect the building module with the no-relax option.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/module.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 7ab6a9b72384..957933e669b1 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -240,6 +240,15 @@ static int apply_r_riscv_relax_rela(struct module *me, u32 *location,
 	return 0;
 }
 
+static int apply_r_riscv_align_rela(struct module *me, u32 *location,
+				    Elf_Addr v)
+{
+	pr_err(
+	  "%s: The unexpected relocation type 'R_RISCV_ALIGN' from PC = %p\n",
+	  me->name, location);
+	return -EINVAL;
+}
+
 static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 				Elf_Addr v) = {
 	[R_RISCV_64]			= apply_r_riscv_64_rela,
@@ -257,6 +266,7 @@ static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 	[R_RISCV_CALL_PLT]		= apply_r_riscv_call_plt_rela,
 	[R_RISCV_CALL]			= apply_r_riscv_call_rela,
 	[R_RISCV_RELAX]			= apply_r_riscv_relax_rela,
+	[R_RISCV_ALIGN]			= apply_r_riscv_align_rela,
 };
 
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
-- 
2.16.1

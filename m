Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeCOIvr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:51:47 -0400
Received: from exmail.andestech.com ([59.124.169.137]:34888 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbeCOIvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:51:43 -0400
From: Zong Li <zong@andestech.com>
To: <palmer@sifive.com>, <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zong@andestech.com>, <zongbox@gmail.com>
CC: <greentime@andestech.com>
Subject: [PATCH v2 03/11] RISC-V: Support GOT_HI20/CALL_PLT relocation type in kernel module
Date: Thu, 15 Mar 2018 16:50:43 +0800
Message-ID: <aa6a55b974ee5a93f38d128edcadac83e3255ca4.1521103171.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1521103167.git.zong@andestech.com>
References: <cover.1521103167.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w2F8lfLa080920
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For CALL_PLT, emit the plt entry only when offset is more than 32-bit.

For PCREL_LO12, it uses the location of corresponding HI20 to
get the address of external symbol. It should check the HI20 type
is the PCREL_HI20 or GOT_HI20, because sometime the location will
have two or more relocation types.
For example:
0:   00000797                auipc   a5,0x0
                     0: R_RISCV_ALIGN        *ABS*
                     0: R_RISCV_GOT_HI20     SYMBOL
4:   0007b783                ld      a5,0(a5) # 0 <SYMBOL>
                     4: R_RISCV_PCREL_LO12_I .L0
                     4: R_RISCV_RELAX        *ABS*

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/module.c | 62 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index e0f05034fc21..be717bd7cea7 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -92,6 +92,28 @@ static int apply_r_riscv_pcrel_lo12_s_rela(struct module *me, u32 *location,
 	return 0;
 }
 
+static int apply_r_riscv_got_hi20_rela(struct module *me, u32 *location,
+				       Elf_Addr v)
+{
+	s64 offset = (void *)v - (void *)location;
+	s32 hi20;
+
+	/* Always emit the got entry */
+	if (IS_ENABLED(CONFIG_MODULE_SECTIONS)) {
+		offset = module_emit_got_entry(me, v);
+		offset = (void *)offset - (void *)location;
+	} else {
+		pr_err(
+		  "%s: can not generate the GOT entry for symbol = %016llx from PC = %p\n",
+		  me->name, v, location);
+		return -EINVAL;
+	}
+
+	hi20 = (offset + 0x800) & 0xfffff000;
+	*location = (*location & 0xfff) | hi20;
+	return 0;
+}
+
 static int apply_r_riscv_call_plt_rela(struct module *me, u32 *location,
 				       Elf_Addr v)
 {
@@ -100,10 +122,16 @@ static int apply_r_riscv_call_plt_rela(struct module *me, u32 *location,
 	u32 hi20, lo12;
 
 	if (offset != fill_v) {
-		pr_err(
-		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
-		  me->name, v, location);
-		return -EINVAL;
+		/* Only emit the plt entry if offset over 32-bit range */
+		if (IS_ENABLED(CONFIG_MODULE_SECTIONS)) {
+			offset = module_emit_plt_entry(me, v);
+			offset = (void *)offset - (void *)location;
+		} else {
+			pr_err(
+			  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
+			  me->name, v, location);
+			return -EINVAL;
+		}
 	}
 
 	hi20 = (offset + 0x800) & 0xfffff000;
@@ -127,6 +155,7 @@ static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
 	[R_RISCV_PCREL_HI20]		= apply_r_riscv_pcrel_hi20_rela,
 	[R_RISCV_PCREL_LO12_I]		= apply_r_riscv_pcrel_lo12_i_rela,
 	[R_RISCV_PCREL_LO12_S]		= apply_r_riscv_pcrel_lo12_s_rela,
+	[R_RISCV_GOT_HI20]		= apply_r_riscv_got_hi20_rela,
 	[R_RISCV_CALL_PLT]		= apply_r_riscv_call_plt_rela,
 	[R_RISCV_RELAX]			= apply_r_riscv_relax_rela,
 };
@@ -184,25 +213,38 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 				u64 hi20_loc =
 					sechdrs[sechdrs[relsec].sh_info].sh_addr
 					+ rel[j].r_offset;
-				/* Find the corresponding HI20 PC-relative relocation entry */
-				if (hi20_loc == sym->st_value) {
+				u32 hi20_type = ELF_RISCV_R_TYPE(rel[j].r_info);
+
+				/* Find the corresponding HI20 relocation entry */
+				if (hi20_loc == sym->st_value
+				    && (hi20_type == R_RISCV_PCREL_HI20
+					|| hi20_type == R_RISCV_GOT_HI20)) {
+					s32 hi20, lo12;
 					Elf_Sym *hi20_sym =
 						(Elf_Sym *)sechdrs[symindex].sh_addr
 						+ ELF_RISCV_R_SYM(rel[j].r_info);
 					u64 hi20_sym_val =
 						hi20_sym->st_value
 						+ rel[j].r_addend;
+
 					/* Calculate lo12 */
-					s64 offset = hi20_sym_val - hi20_loc;
-					s32 hi20 = (offset + 0x800) & 0xfffff000;
-					s32 lo12 = offset - hi20;
+					u64 offset = hi20_sym_val - hi20_loc;
+					if (IS_ENABLED(CONFIG_MODULE_SECTIONS)
+					    && hi20_type == R_RISCV_GOT_HI20) {
+						offset = module_emit_got_entry(
+							 me, hi20_sym_val);
+						offset = offset - hi20_loc;
+					}
+					hi20 = (offset + 0x800) & 0xfffff000;
+					lo12 = offset - hi20;
 					v = lo12;
+
 					break;
 				}
 			}
 			if (j == sechdrs[relsec].sh_size / sizeof(*rel)) {
 				pr_err(
-				  "%s: Can not find HI20 PC-relative relocation information\n",
+				  "%s: Can not find HI20 relocation information\n",
 				  me->name);
 				return -EINVAL;
 			}
-- 
2.16.1

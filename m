Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF734C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC5D22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC5D22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbeKMV0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:26:00 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:34556 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732037AbeKMVZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:25:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id B71ED18485;
        Tue, 13 Nov 2018 12:28:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id CLUekswJ9N-s; Tue, 13 Nov 2018 12:28:13 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 8D7AB18482;
        Tue, 13 Nov 2018 12:28:13 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 791631A064;
        Tue, 13 Nov 2018 12:28:13 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63D461A062;
        Tue, 13 Nov 2018 12:28:13 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Tue, 13 Nov 2018 12:28:13 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id 56FCB2F48;
        Tue, 13 Nov 2018 12:28:13 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 5278180AA6; Tue, 13 Nov 2018 12:28:13 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     linux@armlinux.org.uk, jeyu@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH v3] ARM: module: Fix function kallsyms on Thumb-2
Date:   Tue, 13 Nov 2018 12:27:45 +0100
Message-Id: <20181113112745.15945-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.11.0
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thumb-2 functions have the lowest bit set in the symbol value in the
symtab.  When kallsyms are generated for the vmlinux, the kallsyms are
generated from the output of nm, and nm clears the lowest bit.

 $ arm-linux-gnueabihf-readelf -a vmlinux | grep show_interrupts
  95947: 8015dc89   686 FUNC    GLOBAL DEFAULT    2 show_interrupts
 $ arm-linux-gnueabihf-nm vmlinux | grep show_interrupts
 8015dc88 T show_interrupts
 $ cat /proc/kallsyms | grep show_interrupts
 8015dc88 T show_interrupts

However, for modules, the kallsyms uses the values in the symbol table
without modification, so for functions in modules, the lowest bit is set
in kallsyms.

 $ arm-linux-gnueabihf-readelf -a drivers/net/tun.ko | grep tun_get_socket
    268: 000000e1    44 FUNC    GLOBAL DEFAULT    2 tun_get_socket
 $ arm-linux-gnueabihf-nm drivers/net/tun.ko | grep tun_get_socket
 000000e0 T tun_get_socket
 $ cat /proc/kallsyms | grep tun_get_socket
 7fcd30e1 t tun_get_socket  [tun]

Because of this, the offset of the crashing instruction shown in oopses
is incorrect when the crash is in a module.  For example, given a
tun_get_socket which starts like this,

 000000e0 <tun_get_socket>:
       e0:       b500            push    {lr}
       e2:       f7ff fffe       bl      0 <__gnu_mcount_nc>
       e6:       4b08            ldr     r3, [pc, #32]
       e8:       6942            ldr     r2, [r0, #20]
       ea:       429a            cmp     r2, r3
       ec:       d002            beq.n   f4 <tun_get_socket+0x14>

a crash when tun_get_socket is called with NULL results in:

 PC is at tun_get_socket+0x7/0x2c [tun]
 pc : [<7fcdb0e8>]

which can result in the incorrect line being reported by gdb if this
symbol+offset is used there.  If the crash is on the first instruction
of a function, the "PC is at" line would also report the symbol name of
the preceding function.

To solve this, introduce a weak module_kallsyms_symbol_value() function
which arches can override to fix up these symbol values, and implement
this for Thumb-2.  We need to move elf_type() to st_other so that the
original value of st_info is preserved.

After the fix:

 $ cat /proc/kallsyms | grep tun_get_socket
 7fcd30e0 t tun_get_socket  [tun]

 PC is at tun_get_socket+0x8/0x2c [tun]
 pc : [<7fcdb0e8>]

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
v3: Do not overwrite st_value
v2: Fix build warning with !MODULES

 arch/arm/kernel/module.c     | 10 ++++++++++
 include/linux/moduleloader.h |  2 ++
 kernel/module.c              | 34 +++++++++++++++++++++-------------
 3 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 3ff571c2c71c..89ab84a83600 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -336,6 +336,16 @@ static const Elf_Shdr *find_mod_section(const Elf32_Ehdr *hdr,
 extern void fixup_pv_table(const void *, unsigned long);
 extern void fixup_smp(const void *, unsigned long);
 
+#ifdef CONFIG_THUMB2_KERNEL
+unsigned long module_kallsyms_symbol_value(Elf_Sym *sym)
+{
+	if (ELF_ST_TYPE(sym->st_info) == STT_FUNC)
+		return sym->st_value & ~1;
+
+	return sym->st_value;
+}
+#endif
+
 int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 		    struct module *mod)
 {
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 31013c2effd3..6395409b01a4 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -86,6 +86,8 @@ void module_arch_cleanup(struct module *mod);
 /* Any cleanup before freeing mod->module_init */
 void module_arch_freeing_init(struct module *mod);
 
+unsigned long module_kallsyms_symbol_value(Elf_Sym *sym);
+
 #ifdef CONFIG_KASAN
 #include <linux/kasan.h>
 #define MODULE_ALIGN (PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)
diff --git a/kernel/module.c b/kernel/module.c
index 49a405891587..5a588cfbb8f8 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2682,7 +2682,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 
 	/* Set types up while we still have access to sections. */
 	for (i = 0; i < mod->kallsyms->num_symtab; i++)
-		mod->kallsyms->symtab[i].st_info
+		mod->kallsyms->symtab[i].st_other
 			= elf_type(&mod->kallsyms->symtab[i], info);
 
 	/* Now populate the cut down core kallsyms for after init. */
@@ -3916,6 +3916,11 @@ static const char *symname(struct mod_kallsyms *kallsyms, unsigned int symnum)
 	return kallsyms->strtab + kallsyms->symtab[symnum].st_name;
 }
 
+unsigned long __weak module_kallsyms_symbol_value(Elf_Sym *sym)
+{
+	return sym->st_value;
+}
+
 static const char *get_ksymbol(struct module *mod,
 			       unsigned long addr,
 			       unsigned long *size,
@@ -3934,6 +3939,9 @@ static const char *get_ksymbol(struct module *mod,
 	/* Scan for closest preceding symbol, and next symbol. (ELF
 	   starts real symbols at 1). */
 	for (i = 1; i < kallsyms->num_symtab; i++) {
+		unsigned long thisval = module_kallsyms_symbol_value(&kallsyms->symtab[i]);
+		unsigned long bestval = module_kallsyms_symbol_value(&kallsyms->symtab[best]);
+
 		if (kallsyms->symtab[i].st_shndx == SHN_UNDEF)
 			continue;
 
@@ -3943,21 +3951,21 @@ static const char *get_ksymbol(struct module *mod,
 		    || is_arm_mapping_symbol(symname(kallsyms, i)))
 			continue;
 
-		if (kallsyms->symtab[i].st_value <= addr
-		    && kallsyms->symtab[i].st_value > kallsyms->symtab[best].st_value)
+		if (thisval <= addr
+		    && thisval > bestval)
 			best = i;
-		if (kallsyms->symtab[i].st_value > addr
-		    && kallsyms->symtab[i].st_value < nextval)
-			nextval = kallsyms->symtab[i].st_value;
+		if (thisval > addr
+		    && thisval < nextval)
+			nextval = thisval;
 	}
 
 	if (!best)
 		return NULL;
 
 	if (size)
-		*size = nextval - kallsyms->symtab[best].st_value;
+		*size = nextval - module_kallsyms_symbol_value(&kallsyms->symtab[best]);
 	if (offset)
-		*offset = addr - kallsyms->symtab[best].st_value;
+		*offset = addr - module_kallsyms_symbol_value(&kallsyms->symtab[best]);
 	return symname(kallsyms, best);
 }
 
@@ -4060,8 +4068,8 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 			continue;
 		kallsyms = rcu_dereference_sched(mod->kallsyms);
 		if (symnum < kallsyms->num_symtab) {
-			*value = kallsyms->symtab[symnum].st_value;
-			*type = kallsyms->symtab[symnum].st_info;
+			*value = module_kallsyms_symbol_value(&kallsyms->symtab[symnum]);
+			*type = kallsyms->symtab[symnum].st_other;
 			strlcpy(name, symname(kallsyms, symnum), KSYM_NAME_LEN);
 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
 			*exported = is_exported(name, *value, mod);
@@ -4082,7 +4090,7 @@ static unsigned long mod_find_symname(struct module *mod, const char *name)
 	for (i = 0; i < kallsyms->num_symtab; i++)
 		if (strcmp(name, symname(kallsyms, i)) == 0 &&
 		    kallsyms->symtab[i].st_shndx != SHN_UNDEF)
-			return kallsyms->symtab[i].st_value;
+			return module_kallsyms_symbol_value(&kallsyms->symtab[i]);
 	return 0;
 }
 
@@ -4131,8 +4139,8 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 			if (kallsyms->symtab[i].st_shndx == SHN_UNDEF)
 				continue;
 
-			ret = fn(data, symname(kallsyms, i),
-				 mod, kallsyms->symtab[i].st_value);
+			ret = fn(data, symname(kallsyms, i), mod,
+				 module_kallsyms_symbol_value(&kallsyms->symtab[i]));
 			if (ret != 0)
 				return ret;
 		}
-- 
2.11.0


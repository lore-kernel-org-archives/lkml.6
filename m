Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1409C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68A72082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68A72082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbeLDOPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:15:12 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:55839 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbeLDOPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:15:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 6B896184CD;
        Tue,  4 Dec 2018 15:15:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id luuwGJ4KEYHA; Tue,  4 Dec 2018 15:14:57 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 49B1F18508;
        Tue,  4 Dec 2018 15:14:57 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A5541E06A;
        Tue,  4 Dec 2018 15:14:57 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04F091E070;
        Tue,  4 Dec 2018 15:14:57 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Tue,  4 Dec 2018 15:14:56 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id ED13C10BE;
        Tue,  4 Dec 2018 15:14:56 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id EB47E800D4; Tue,  4 Dec 2018 15:14:56 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     linux@armlinux.org.uk, jeyu@kernel.org
Cc:     dave.martin@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH v5 2/2] ARM: module: Fix function kallsyms on Thumb-2
Date:   Tue,  4 Dec 2018 15:14:15 +0100
Message-Id: <20181204141415.969-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181204141415.969-1-vincent.whitchurch@axis.com>
References: <20181204141415.969-1-vincent.whitchurch@axis.com>
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
    333: 00002d4d    36 FUNC    GLOBAL DEFAULT    1 tun_get_socket
 $ arm-linux-gnueabihf-nm drivers/net/tun.ko | grep tun_get_socket
 00002d4c T tun_get_socket
 $ cat /proc/kallsyms | grep tun_get_socket
 7f802d4d t tun_get_socket      [tun]

Because of this, the symbol+offset of the crashing instruction shown in
oopses is incorrect when the crash is in a module.  For example, given a
tun_get_socket which starts like this,

 00002d4c <tun_get_socket>:
     2d4c:       6943            ldr     r3, [r0, #20]
     2d4e:       4a07            ldr     r2, [pc, #28]
     2d50:       4293            cmp     r3, r2

a crash when tun_get_socket is called with NULL results in:

 PC is at tun_xdp+0xa3/0xa4 [tun]
 pc : [<7f802d4c>]

As can be seen, the "PC is at" line reports the wrong symbol name, and
the symbol+offset will point to the wrong source line if it is passed to
gdb.

To solve this, add a way for archs to fixup the reading of these module
kallsyms values, and use that to clear the lowest bit for function
symbols on Thumb-2.

After the fix:

 # cat /proc/kallsyms | grep tun_get_socket
 7f802d4c t tun_get_socket       [tun]

 PC is at tun_get_socket+0x0/0x24 [tun]
 pc : [<7f802d4c>]

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
v5: Use/move local variables to reduce calls and keep lines short.  Use const arg.
v4: Split out st_value overwrite change.  Add HAVE* macro to avoid function call.
v3: Do not overwrite st_value
v2: Fix build warning with !MODULES

 arch/arm/include/asm/module.h | 11 +++++++++++
 include/linux/module.h        |  7 +++++++
 kernel/module.c               | 45 +++++++++++++++++++++++++++----------------
 3 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 9e81b7c498d8..c7bcf0347801 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -61,4 +61,15 @@ u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);
 	MODULE_ARCH_VERMAGIC_ARMTHUMB \
 	MODULE_ARCH_VERMAGIC_P2V
 
+#ifdef CONFIG_THUMB2_KERNEL
+#define HAVE_ARCH_MODULE_KALLSYMS_SYMBOL_VALUE
+static inline unsigned long module_kallsyms_symbol_value(const Elf_Sym *sym)
+{
+	if (ELF_ST_TYPE(sym->st_info) == STT_FUNC)
+		return sym->st_value & ~1;
+
+	return sym->st_value;
+}
+#endif
+
 #endif /* _ASM_ARM_MODULE_H */
diff --git a/include/linux/module.h b/include/linux/module.h
index fce6b4335e36..12146257eb5d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -486,6 +486,13 @@ struct module {
 #define MODULE_ARCH_INIT {}
 #endif
 
+#ifndef HAVE_ARCH_MODULE_KALLSYMS_SYMBOL_VALUE
+static inline unsigned long module_kallsyms_symbol_value(const Elf_Sym *sym)
+{
+	return sym->st_value;
+}
+#endif
+
 extern struct mutex module_mutex;
 
 /* FIXME: It'd be nice to isolate modules during init, too, so they
diff --git a/kernel/module.c b/kernel/module.c
index 3d86a38b580c..9364017fdc21 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3922,7 +3922,7 @@ static const char *get_ksymbol(struct module *mod,
 			       unsigned long *offset)
 {
 	unsigned int i, best = 0;
-	unsigned long nextval;
+	unsigned long nextval, bestval;
 	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
 
 	/* At worse, next value is at end of module */
@@ -3931,10 +3931,15 @@ static const char *get_ksymbol(struct module *mod,
 	else
 		nextval = (unsigned long)mod->core_layout.base+mod->core_layout.text_size;
 
+	bestval = module_kallsyms_symbol_value(&kallsyms->symtab[best]);
+
 	/* Scan for closest preceding symbol, and next symbol. (ELF
 	   starts real symbols at 1). */
 	for (i = 1; i < kallsyms->num_symtab; i++) {
-		if (kallsyms->symtab[i].st_shndx == SHN_UNDEF)
+		const Elf_Sym *sym = &kallsyms->symtab[i];
+		unsigned long thisval = module_kallsyms_symbol_value(sym);
+
+		if (sym->st_shndx == SHN_UNDEF)
 			continue;
 
 		/* We ignore unnamed symbols: they're uninformative
@@ -3943,21 +3948,21 @@ static const char *get_ksymbol(struct module *mod,
 		    || is_arm_mapping_symbol(symname(kallsyms, i)))
 			continue;
 
-		if (kallsyms->symtab[i].st_value <= addr
-		    && kallsyms->symtab[i].st_value > kallsyms->symtab[best].st_value)
+		if (thisval <= addr && thisval > bestval) {
 			best = i;
-		if (kallsyms->symtab[i].st_value > addr
-		    && kallsyms->symtab[i].st_value < nextval)
-			nextval = kallsyms->symtab[i].st_value;
+			bestval = thisval;
+		}
+		if (thisval > addr && thisval < nextval)
+			nextval = thisval;
 	}
 
 	if (!best)
 		return NULL;
 
 	if (size)
-		*size = nextval - kallsyms->symtab[best].st_value;
+		*size = nextval - bestval;
 	if (offset)
-		*offset = addr - kallsyms->symtab[best].st_value;
+		*offset = addr - bestval;
 	return symname(kallsyms, best);
 }
 
@@ -4060,8 +4065,10 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 			continue;
 		kallsyms = rcu_dereference_sched(mod->kallsyms);
 		if (symnum < kallsyms->num_symtab) {
-			*value = kallsyms->symtab[symnum].st_value;
-			*type = kallsyms->symtab[symnum].st_size;
+			const Elf_Sym *sym = &kallsyms->symtab[symnum];
+
+			*value = module_kallsyms_symbol_value(sym);
+			*type = sym->st_size;
 			strlcpy(name, symname(kallsyms, symnum), KSYM_NAME_LEN);
 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
 			*exported = is_exported(name, *value, mod);
@@ -4079,10 +4086,13 @@ static unsigned long mod_find_symname(struct module *mod, const char *name)
 	unsigned int i;
 	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
 
-	for (i = 0; i < kallsyms->num_symtab; i++)
+	for (i = 0; i < kallsyms->num_symtab; i++) {
+		const Elf_Sym *sym = &kallsyms->symtab[i];
+
 		if (strcmp(name, symname(kallsyms, i)) == 0 &&
-		    kallsyms->symtab[i].st_shndx != SHN_UNDEF)
-			return kallsyms->symtab[i].st_value;
+		    sym->st_shndx != SHN_UNDEF)
+			return module_kallsyms_symbol_value(sym);
+	}
 	return 0;
 }
 
@@ -4127,12 +4137,13 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
 		for (i = 0; i < kallsyms->num_symtab; i++) {
+			const Elf_Sym *sym = &kallsyms->symtab[i];
 
-			if (kallsyms->symtab[i].st_shndx == SHN_UNDEF)
+			if (sym->st_shndx == SHN_UNDEF)
 				continue;
 
-			ret = fn(data, symname(kallsyms, i),
-				 mod, kallsyms->symtab[i].st_value);
+			ret = fn(data, symname(kallsyms, i), mod,
+				 module_kallsyms_symbol_value(sym));
 			if (ret != 0)
 				return ret;
 		}
-- 
2.11.0


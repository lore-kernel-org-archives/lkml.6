Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C157C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C4020831
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C4020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbeKBAcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:32:45 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:48448 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbeKBAco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:32:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 812E318345;
        Thu,  1 Nov 2018 16:29:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 6jMeQ-yHQnrT; Thu,  1 Nov 2018 16:29:14 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 3EABB1835D;
        Thu,  1 Nov 2018 16:29:14 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E0081E07D;
        Thu,  1 Nov 2018 16:29:14 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11D3B1E07C;
        Thu,  1 Nov 2018 16:29:14 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Thu,  1 Nov 2018 16:29:14 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 051BB2526;
        Thu,  1 Nov 2018 16:29:14 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 001C080AD5; Thu,  1 Nov 2018 16:29:13 +0100 (CET)
Date:   Thu, 1 Nov 2018 16:29:13 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v2] ARM: module: Fix function kallsyms on Thumb-2
Message-ID: <20181101152913.r2isskngiahi6o2u@axis.com>
References: <20181031084253.9650-1-vincent.whitchurch@axis.com>
 <20181031155341.GA27878@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031155341.GA27878@linux-8ccs>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 04:53:41PM +0100, Jessica Yu wrote:
> Could this be done in modpost? I'm guessing the answer is no as some
> relocations may rely on that bit being set in st_value, right?
> Therefore we can only clear the bit _after_ relocations to the module
> are applied at runtime, correct?

Yes, that's correct, it needs to be done after the relocations.

> I'm not against having an arch-specific kallsyms fixup function, my
> only concern would be if this would interfere with the delayed
> relocations livepatching does, if there are plans in the future to
> have livepatching on arm (IIRC there was an attempt at a port in
> 2016). If there exists some Thumb-2 relocation types that rely on that
> lowest bit in st_value being set in order to be applied, and we clear
> it permanently from the symtab, then livepatching wouldn't be able to
> apply those types of relocations anymore. If this is a legitimate
> concern, then perhaps an alternative solution would be to have an
> arch-specific kallsyms symbol-value-fixup function for accesses to
> sym.st_value, without modifying the module symtab.

I'm not familiar with livepatching, but yes, if it needs to do
relocations later I guess we should preserve the original value.

I gave the alternative solution a go and it seems to work.
add_kallsyms() currently overwrites st_info so I had to move the
elf_type to the unused st_other field instead to preserve st_info:

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 3ff571c2c71c..f443d0ccd1a0 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -336,6 +336,16 @@ static const Elf_Shdr *find_mod_section(const Elf32_Ehdr *hdr,
 extern void fixup_pv_table(const void *, unsigned long);
 extern void fixup_smp(const void *, unsigned long);
 
+#ifdef CONFIG_THUMB2_KERNEL
+unsigned long symbol_value(Elf_Sym *sym)
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
index 31013c2effd3..6bf6118db37f 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -86,6 +86,8 @@ void module_arch_cleanup(struct module *mod);
 /* Any cleanup before freeing mod->module_init */
 void module_arch_freeing_init(struct module *mod);
 
+unsigned long symbol_value(Elf_Sym *sym);
+
 #ifdef CONFIG_KASAN
 #include <linux/kasan.h>
 #define MODULE_ALIGN (PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)
diff --git a/kernel/module.c b/kernel/module.c
index 49a405891587..871bf4450e9d 100644
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
 
+unsigned long __weak symbol_value(Elf_Sym *sym)
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
+		unsigned long thisval = symbol_value(&kallsyms->symtab[i]);
+		unsigned long bestval = symbol_value(&kallsyms->symtab[best]);
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
+		*size = nextval - symbol_value(&kallsyms->symtab[best]);
 	if (offset)
-		*offset = addr - kallsyms->symtab[best].st_value;
+		*offset = addr - symbol_value(&kallsyms->symtab[best]);
 	return symname(kallsyms, best);
 }
 
@@ -4060,8 +4068,8 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 			continue;
 		kallsyms = rcu_dereference_sched(mod->kallsyms);
 		if (symnum < kallsyms->num_symtab) {
-			*value = kallsyms->symtab[symnum].st_value;
-			*type = kallsyms->symtab[symnum].st_info;
+			*value = symbol_value(&kallsyms->symtab[symnum]);
+			*type = kallsyms->symtab[symnum].st_other;
 			strlcpy(name, symname(kallsyms, symnum), KSYM_NAME_LEN);
 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
 			*exported = is_exported(name, *value, mod);
@@ -4082,7 +4090,7 @@ static unsigned long mod_find_symname(struct module *mod, const char *name)
 	for (i = 0; i < kallsyms->num_symtab; i++)
 		if (strcmp(name, symname(kallsyms, i)) == 0 &&
 		    kallsyms->symtab[i].st_shndx != SHN_UNDEF)
-			return kallsyms->symtab[i].st_value;
+			return symbol_value(&kallsyms->symtab[i]);
 	return 0;
 }
 
@@ -4132,7 +4140,7 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 				continue;
 
 			ret = fn(data, symname(kallsyms, i),
-				 mod, kallsyms->symtab[i].st_value);
+				 mod, symbol_value(&kallsyms->symtab[i]));
 			if (ret != 0)
 				return ret;
 		}

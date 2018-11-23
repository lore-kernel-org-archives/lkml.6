Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63B0C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6552B20659
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 16:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNrEYwmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6552B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440665AbeKXD0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 22:26:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730360AbeKXD0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 22:26:19 -0500
Received: from linux-8ccs.suse.de (nat.nue.novell.com [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6470C20659;
        Fri, 23 Nov 2018 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542991281;
        bh=J3vO6H0YiiJdMxR+5Qw1fEniZkiFowp6lz9dyjQTKwc=;
        h=From:To:Cc:Subject:Date:From;
        b=QNrEYwmmMo79v9e3heQKRpCPH+z+dxWSxKwKgx0TZEZU6Fg1d9rzXf+x2sruNWT4f
         YX7UmJ3kYVDeZoXZSXeH9pqRojBg23uP0zVIeco9eOgovimjRpVw1VhVGPRtfJ6FME
         SRmecwLf0Hvf95SI63UfjeU+J9Ecxur/Z2cJhfuI=
From:   Jessica Yu <jeyu@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v2] module: make it clearer when we're handling kallsyms symbols vs exported symbols
Date:   Fri, 23 Nov 2018 17:41:04 +0100
Message-Id: <20181123164104.6054-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module loader internally works with both exported symbols
represented as struct kernel_symbol, as well as Elf symbols from a
module's symbol table. It's hard to distinguish sometimes which type of
symbol we're handling given that some helper function names are not
consistent or helpful. Take get_ksymbol() for instance - are we
looking for an exported symbol or a kallsyms symbol here? Or symname()
and kernel_symbol_name() - which function handles an exported symbol and
which one an Elf symbol?

Clean up and unify the function naming scheme a bit to make it clear
which kind of symbol we're handling. This change only affects static
functions internal to the module loader.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---

v2: renamed kallsyms_find_* funcs to find_kallsyms_* to follow the
    already existing <verb>_<noun> naming convention in module.c

 kernel/module.c | 78 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 49a405891587..1b5edf78694c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -495,9 +495,9 @@ struct find_symbol_arg {
 	const struct kernel_symbol *sym;
 };
 
-static bool check_symbol(const struct symsearch *syms,
-				 struct module *owner,
-				 unsigned int symnum, void *data)
+static bool check_exported_symbol(const struct symsearch *syms,
+				  struct module *owner,
+				  unsigned int symnum, void *data)
 {
 	struct find_symbol_arg *fsa = data;
 
@@ -555,9 +555,9 @@ static int cmp_name(const void *va, const void *vb)
 	return strcmp(a, kernel_symbol_name(b));
 }
 
-static bool find_symbol_in_section(const struct symsearch *syms,
-				   struct module *owner,
-				   void *data)
+static bool find_exported_symbol_in_section(const struct symsearch *syms,
+					    struct module *owner,
+					    void *data)
 {
 	struct find_symbol_arg *fsa = data;
 	struct kernel_symbol *sym;
@@ -565,13 +565,14 @@ static bool find_symbol_in_section(const struct symsearch *syms,
 	sym = bsearch(fsa->name, syms->start, syms->stop - syms->start,
 			sizeof(struct kernel_symbol), cmp_name);
 
-	if (sym != NULL && check_symbol(syms, owner, sym - syms->start, data))
+	if (sym != NULL && check_exported_symbol(syms, owner,
+						 sym - syms->start, data))
 		return true;
 
 	return false;
 }
 
-/* Find a symbol and return it, along with, (optional) crc and
+/* Find an exported symbol and return it, along with, (optional) crc and
  * (optional) module which owns it.  Needs preempt disabled or module_mutex. */
 const struct kernel_symbol *find_symbol(const char *name,
 					struct module **owner,
@@ -585,7 +586,7 @@ const struct kernel_symbol *find_symbol(const char *name,
 	fsa.gplok = gplok;
 	fsa.warn = warn;
 
-	if (each_symbol_section(find_symbol_in_section, &fsa)) {
+	if (each_symbol_section(find_exported_symbol_in_section, &fsa)) {
 		if (owner)
 			*owner = fsa.owner;
 		if (crc)
@@ -2198,7 +2199,7 @@ EXPORT_SYMBOL_GPL(__symbol_get);
  *
  * You must hold the module_mutex.
  */
-static int verify_export_symbols(struct module *mod)
+static int verify_exported_symbols(struct module *mod)
 {
 	unsigned int i;
 	struct module *owner;
@@ -2519,10 +2520,10 @@ static void free_modinfo(struct module *mod)
 
 #ifdef CONFIG_KALLSYMS
 
-/* lookup symbol in given range of kernel_symbols */
-static const struct kernel_symbol *lookup_symbol(const char *name,
-	const struct kernel_symbol *start,
-	const struct kernel_symbol *stop)
+/* Lookup exported symbol in given range of kernel_symbols */
+static const struct kernel_symbol *lookup_exported_symbol(const char *name,
+							  const struct kernel_symbol *start,
+							  const struct kernel_symbol *stop)
 {
 	return bsearch(name, start, stop - start,
 			sizeof(struct kernel_symbol), cmp_name);
@@ -2533,9 +2534,10 @@ static int is_exported(const char *name, unsigned long value,
 {
 	const struct kernel_symbol *ks;
 	if (!mod)
-		ks = lookup_symbol(name, __start___ksymtab, __stop___ksymtab);
+		ks = lookup_exported_symbol(name, __start___ksymtab, __stop___ksymtab);
 	else
-		ks = lookup_symbol(name, mod->syms, mod->syms + mod->num_syms);
+		ks = lookup_exported_symbol(name, mod->syms, mod->syms + mod->num_syms);
+
 	return ks != NULL && kernel_symbol_value(ks) == value;
 }
 
@@ -3592,7 +3594,7 @@ static int complete_formation(struct module *mod, struct load_info *info)
 	mutex_lock(&module_mutex);
 
 	/* Find duplicate symbols (must be called under lock). */
-	err = verify_export_symbols(mod);
+	err = verify_exported_symbols(mod);
 	if (err < 0)
 		goto out;
 
@@ -3911,15 +3913,19 @@ static inline int is_arm_mapping_symbol(const char *str)
 	       && (str[2] == '\0' || str[2] == '.');
 }
 
-static const char *symname(struct mod_kallsyms *kallsyms, unsigned int symnum)
+static const char *kallsyms_symbol_name(struct mod_kallsyms *kallsyms, unsigned int symnum)
 {
 	return kallsyms->strtab + kallsyms->symtab[symnum].st_name;
 }
 
-static const char *get_ksymbol(struct module *mod,
-			       unsigned long addr,
-			       unsigned long *size,
-			       unsigned long *offset)
+/*
+ * Given a module and address, find the corresponding symbol and return its name
+ * while providing its size and offset if needed.
+ */
+static const char *find_kallsyms_symbol(struct module *mod,
+					unsigned long addr,
+					unsigned long *size,
+					unsigned long *offset)
 {
 	unsigned int i, best = 0;
 	unsigned long nextval;
@@ -3939,8 +3945,8 @@ static const char *get_ksymbol(struct module *mod,
 
 		/* We ignore unnamed symbols: they're uninformative
 		 * and inserted at a whim. */
-		if (*symname(kallsyms, i) == '\0'
-		    || is_arm_mapping_symbol(symname(kallsyms, i)))
+		if (*kallsyms_symbol_name(kallsyms, i) == '\0'
+		    || is_arm_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
 			continue;
 
 		if (kallsyms->symtab[i].st_value <= addr
@@ -3958,7 +3964,8 @@ static const char *get_ksymbol(struct module *mod,
 		*size = nextval - kallsyms->symtab[best].st_value;
 	if (offset)
 		*offset = addr - kallsyms->symtab[best].st_value;
-	return symname(kallsyms, best);
+
+	return kallsyms_symbol_name(kallsyms, best);
 }
 
 void * __weak dereference_module_function_descriptor(struct module *mod,
@@ -3983,7 +3990,8 @@ const char *module_address_lookup(unsigned long addr,
 	if (mod) {
 		if (modname)
 			*modname = mod->name;
-		ret = get_ksymbol(mod, addr, size, offset);
+
+		ret = find_kallsyms_symbol(mod, addr, size, offset);
 	}
 	/* Make a copy in here where it's safe */
 	if (ret) {
@@ -4006,9 +4014,10 @@ int lookup_module_symbol_name(unsigned long addr, char *symname)
 		if (within_module(addr, mod)) {
 			const char *sym;
 
-			sym = get_ksymbol(mod, addr, NULL, NULL);
+			sym = find_kallsyms_symbol(mod, addr, NULL, NULL);
 			if (!sym)
 				goto out;
+
 			strlcpy(symname, sym, KSYM_NAME_LEN);
 			preempt_enable();
 			return 0;
@@ -4031,7 +4040,7 @@ int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size,
 		if (within_module(addr, mod)) {
 			const char *sym;
 
-			sym = get_ksymbol(mod, addr, size, offset);
+			sym = find_kallsyms_symbol(mod, addr, size, offset);
 			if (!sym)
 				goto out;
 			if (modname)
@@ -4062,7 +4071,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		if (symnum < kallsyms->num_symtab) {
 			*value = kallsyms->symtab[symnum].st_value;
 			*type = kallsyms->symtab[symnum].st_info;
-			strlcpy(name, symname(kallsyms, symnum), KSYM_NAME_LEN);
+			strlcpy(name, kallsyms_symbol_name(kallsyms, symnum), KSYM_NAME_LEN);
 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
 			*exported = is_exported(name, *value, mod);
 			preempt_enable();
@@ -4074,13 +4083,14 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 	return -ERANGE;
 }
 
-static unsigned long mod_find_symname(struct module *mod, const char *name)
+/* Given a module and name of symbol, find and return the symbol's value */
+static unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
 {
 	unsigned int i;
 	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
 
 	for (i = 0; i < kallsyms->num_symtab; i++)
-		if (strcmp(name, symname(kallsyms, i)) == 0 &&
+		if (strcmp(name, kallsyms_symbol_name(kallsyms, i)) == 0 &&
 		    kallsyms->symtab[i].st_shndx != SHN_UNDEF)
 			return kallsyms->symtab[i].st_value;
 	return 0;
@@ -4097,12 +4107,12 @@ unsigned long module_kallsyms_lookup_name(const char *name)
 	preempt_disable();
 	if ((colon = strnchr(name, MODULE_NAME_LEN, ':')) != NULL) {
 		if ((mod = find_module_all(name, colon - name, false)) != NULL)
-			ret = mod_find_symname(mod, colon+1);
+			ret = find_kallsyms_symbol_value(mod, colon+1);
 	} else {
 		list_for_each_entry_rcu(mod, &modules, list) {
 			if (mod->state == MODULE_STATE_UNFORMED)
 				continue;
-			if ((ret = mod_find_symname(mod, name)) != 0)
+			if ((ret = find_kallsyms_symbol_value(mod, name)) != 0)
 				break;
 		}
 	}
@@ -4131,7 +4141,7 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 			if (kallsyms->symtab[i].st_shndx == SHN_UNDEF)
 				continue;
 
-			ret = fn(data, symname(kallsyms, i),
+			ret = fn(data, kallsyms_symbol_name(kallsyms, i),
 				 mod, kallsyms->symtab[i].st_value);
 			if (ret != 0)
 				return ret;
-- 
2.16.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968824AbeE3JJg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:09:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965096AbeE3JJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:09:09 -0400
From: Jessica Yu <jeyu@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH 1/3] module: make it clear when we're handling the module copy in info->hdr
Date: Wed, 30 May 2018 11:08:28 +0200
Message-Id: <20180530090830.20737-2-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180530090830.20737-1-jeyu@kernel.org>
References: <20180530090830.20737-1-jeyu@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In load_module(), it's not always clear whether we're handling the
temporary module copy in info->hdr (which is freed at the end of
load_module()) or if we're handling the module already allocated and
copied to it's final place. Adding an info->mod field and using it
whenever we're handling the temporary copy makes that explicitly clear.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
 kernel/module.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 9c1709a05037..e8eba00bfed7 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -312,6 +312,8 @@ EXPORT_SYMBOL(unregister_module_notifier);
 
 struct load_info {
 	const char *name;
+	/* pointer to module in temporary copy, freed at end of load_module() */
+	struct module *mod;
 	Elf_Ehdr *hdr;
 	unsigned long len;
 	Elf_Shdr *sechdrs;
@@ -2979,14 +2981,13 @@ static int rewrite_section_headers(struct load_info *info, int flags)
  * search for module section index etc), and do some basic section
  * verification.
  *
- * Return the temporary module pointer (we'll replace it with the final
- * one when we move the module sections around).
+ * Set info->mod to the temporary copy of the module in info->hdr. The final one
+ * will be allocated in move_module().
  */
-static struct module *setup_load_info(struct load_info *info, int flags)
+static int setup_load_info(struct load_info *info, int flags)
 {
 	unsigned int i;
 	int err;
-	struct module *mod;
 
 	/* Set up the convenience variables */
 	info->sechdrs = (void *)info->hdr + info->hdr->e_shoff;
@@ -2995,7 +2996,7 @@ static struct module *setup_load_info(struct load_info *info, int flags)
 
 	err = rewrite_section_headers(info, flags);
 	if (err)
-		return ERR_PTR(err);
+		return err;
 
 	/* Find internal symbols and strings. */
 	for (i = 1; i < info->hdr->e_shnum; i++) {
@@ -3012,30 +3013,30 @@ static struct module *setup_load_info(struct load_info *info, int flags)
 	if (!info->index.mod) {
 		pr_warn("%s: No module found in object\n",
 			info->name ?: "(missing .modinfo name field)");
-		return ERR_PTR(-ENOEXEC);
+		return -ENOEXEC;
 	}
 	/* This is temporary: point mod into copy of data. */
-	mod = (void *)info->sechdrs[info->index.mod].sh_addr;
+	info->mod = (void *)info->sechdrs[info->index.mod].sh_addr;
 
 	/*
 	 * If we didn't load the .modinfo 'name' field, fall back to
 	 * on-disk struct mod 'name' field.
 	 */
 	if (!info->name)
-		info->name = mod->name;
+		info->name = info->mod->name;
 
 	if (info->index.sym == 0) {
 		pr_warn("%s: module has no symbols (stripped?)\n", info->name);
-		return ERR_PTR(-ENOEXEC);
+		return -ENOEXEC;
 	}
 
 	info->index.pcpu = find_pcpusec(info);
 
 	/* Check module struct version now, before we try to use module. */
-	if (!check_modstruct_version(info, mod))
-		return ERR_PTR(-ENOEXEC);
+	if (!check_modstruct_version(info, info->mod))
+		return -ENOEXEC;
 
-	return mod;
+	return 0;
 }
 
 static int check_modinfo(struct module *mod, struct load_info *info, int flags)
@@ -3330,25 +3331,24 @@ core_param(module_blacklist, module_blacklist, charp, 0400);
 
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
-	/* Module within temporary copy. */
 	struct module *mod;
 	unsigned int ndx;
 	int err;
 
-	mod = setup_load_info(info, flags);
-	if (IS_ERR(mod))
-		return mod;
+	err = setup_load_info(info, flags);
+	if (err)
+		return ERR_PTR(err);
 
 	if (blacklisted(info->name))
 		return ERR_PTR(-EPERM);
 
-	err = check_modinfo(mod, info, flags);
+	err = check_modinfo(info->mod, info, flags);
 	if (err)
 		return ERR_PTR(err);
 
 	/* Allow arches to frob section contents and sizes.  */
 	err = module_frob_arch_sections(info->hdr, info->sechdrs,
-					info->secstrings, mod);
+					info->secstrings, info->mod);
 	if (err < 0)
 		return ERR_PTR(err);
 
@@ -3367,11 +3367,11 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	/* Determine total sizes, and put offsets in sh_entsize.  For now
 	   this is done generically; there doesn't appear to be any
 	   special cases for the architectures. */
-	layout_sections(mod, info);
-	layout_symtab(mod, info);
+	layout_sections(info->mod, info);
+	layout_symtab(info->mod, info);
 
 	/* Allocate and move to the final place */
-	err = move_module(mod, info);
+	err = move_module(info->mod, info);
 	if (err)
 		return ERR_PTR(err);
 
-- 
2.16.3

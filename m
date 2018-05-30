Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968775AbeE3JJR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:09:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964904AbeE3JJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:09:12 -0400
From: Jessica Yu <jeyu@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH 2/3] module: setup load info before module_sig_check()
Date: Wed, 30 May 2018 11:08:29 +0200
Message-Id: <20180530090830.20737-3-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180530090830.20737-1-jeyu@kernel.org>
References: <20180530090830.20737-1-jeyu@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to be able to log the module name in early error messages, such as
when module signature verification fails.  Previously, the module name is
set in layout_and_allocate(), meaning that any error messages that happen
before (such as those in module_sig_check()) won't be logged with a module
name, which isn't terribly helpful.

In order to do this, reshuffle the order in load_module() and set up
load info earlier so that we can log the module name along with these
error messages. This requires splitting rewrite_section_headers() out of
setup_load_info().

While we're at it, clean up and split up the operations done in
layout_and_allocate(), setup_load_info(), and rewrite_section_headers()
more cleanly so these functions only perform what their names suggest.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
 kernel/module.c | 77 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index e8eba00bfed7..ae824a6f1a03 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2491,7 +2491,11 @@ static char *get_modinfo(struct load_info *info, const char *tag)
 	Elf_Shdr *infosec = &info->sechdrs[info->index.info];
 	unsigned long size = infosec->sh_size;
 
-	for (p = (char *)infosec->sh_addr; p; p = next_string(p, &size)) {
+	/*
+	 * get_modinfo() calls made before rewrite_section_headers()
+	 * must use sh_offset, as sh_addr isn't set!
+	 */
+	for (p = (char *)info->hdr + infosec->sh_offset; p; p = next_string(p, &size)) {
 		if (strncmp(p, tag, taglen) == 0 && p[taglen] == '=')
 			return p + taglen + 1;
 	}
@@ -2960,17 +2964,7 @@ static int rewrite_section_headers(struct load_info *info, int flags)
 	}
 
 	/* Track but don't keep modinfo and version sections. */
-	if (flags & MODULE_INIT_IGNORE_MODVERSIONS)
-		info->index.vers = 0; /* Pretend no __versions section! */
-	else
-		info->index.vers = find_sec(info, "__versions");
 	info->sechdrs[info->index.vers].sh_flags &= ~(unsigned long)SHF_ALLOC;
-
-	info->index.info = find_sec(info, ".modinfo");
-	if (!info->index.info)
-		info->name = "(missing .modinfo section)";
-	else
-		info->name = get_modinfo(info, "name");
 	info->sechdrs[info->index.info].sh_flags &= ~(unsigned long)SHF_ALLOC;
 
 	return 0;
@@ -2987,16 +2981,18 @@ static int rewrite_section_headers(struct load_info *info, int flags)
 static int setup_load_info(struct load_info *info, int flags)
 {
 	unsigned int i;
-	int err;
 
 	/* Set up the convenience variables */
 	info->sechdrs = (void *)info->hdr + info->hdr->e_shoff;
 	info->secstrings = (void *)info->hdr
 		+ info->sechdrs[info->hdr->e_shstrndx].sh_offset;
 
-	err = rewrite_section_headers(info, flags);
-	if (err)
-		return err;
+	/* Try to find a name early so we can log errors with a module name */
+	info->index.info = find_sec(info, ".modinfo");
+	if (!info->index.info)
+		info->name = "(missing .modinfo section)";
+	else
+		info->name = get_modinfo(info, "name");
 
 	/* Find internal symbols and strings. */
 	for (i = 1; i < info->hdr->e_shnum; i++) {
@@ -3009,6 +3005,11 @@ static int setup_load_info(struct load_info *info, int flags)
 		}
 	}
 
+	if (info->index.sym == 0) {
+		pr_warn("%s: module has no symbols (stripped?)\n", info->name);
+		return -ENOEXEC;
+	}
+
 	info->index.mod = find_sec(info, ".gnu.linkonce.this_module");
 	if (!info->index.mod) {
 		pr_warn("%s: No module found in object\n",
@@ -3016,26 +3017,22 @@ static int setup_load_info(struct load_info *info, int flags)
 		return -ENOEXEC;
 	}
 	/* This is temporary: point mod into copy of data. */
-	info->mod = (void *)info->sechdrs[info->index.mod].sh_addr;
+	info->mod = (void *)info->hdr + info->sechdrs[info->index.mod].sh_offset;
 
 	/*
-	 * If we didn't load the .modinfo 'name' field, fall back to
+	 * If we didn't load the .modinfo 'name' field earlier, fall back to
 	 * on-disk struct mod 'name' field.
 	 */
 	if (!info->name)
 		info->name = info->mod->name;
 
-	if (info->index.sym == 0) {
-		pr_warn("%s: module has no symbols (stripped?)\n", info->name);
-		return -ENOEXEC;
-	}
+	if (flags & MODULE_INIT_IGNORE_MODVERSIONS)
+		info->index.vers = 0; /* Pretend no __versions section! */
+	else
+		info->index.vers = find_sec(info, "__versions");
 
 	info->index.pcpu = find_pcpusec(info);
 
-	/* Check module struct version now, before we try to use module. */
-	if (!check_modstruct_version(info, info->mod))
-		return -ENOEXEC;
-
 	return 0;
 }
 
@@ -3335,13 +3332,6 @@ static struct module *layout_and_allocate(struct load_info *info, int flags)
 	unsigned int ndx;
 	int err;
 
-	err = setup_load_info(info, flags);
-	if (err)
-		return ERR_PTR(err);
-
-	if (blacklisted(info->name))
-		return ERR_PTR(-EPERM);
-
 	err = check_modinfo(info->mod, info, flags);
 	if (err)
 		return ERR_PTR(err);
@@ -3684,17 +3674,36 @@ static int load_module(struct load_info *info, const char __user *uargs,
 		       int flags, bool can_do_ima_check)
 {
 	struct module *mod;
-	long err;
+	long err = 0;
 	char *after_dashes;
 
+	err = elf_header_check(info);
+	if (err)
+		goto free_copy;
+
+	err = setup_load_info(info, flags);
+	if (err)
+		goto free_copy;
+
+	if (blacklisted(info->name)) {
+		err = -EPERM;
+		goto free_copy;
+	}
+
 	err = module_sig_check(info, flags, can_do_ima_check);
 	if (err)
 		goto free_copy;
 
-	err = elf_header_check(info);
+	err = rewrite_section_headers(info, flags);
 	if (err)
 		goto free_copy;
 
+	/* Check module struct version now, before we try to use module. */
+	if (!check_modstruct_version(info, info->mod)) {
+		err = -ENOEXEC;
+		goto free_copy;
+	}
+
 	/* Figure out module layout, and allocate all the memory. */
 	mod = layout_and_allocate(info, flags);
 	if (IS_ERR(mod)) {
-- 
2.16.3

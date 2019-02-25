Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8F1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25632087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fLqbVs3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfBYUAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:00:08 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44906 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfBYUAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 15:00:07 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1PJvN6I046999;
        Mon, 25 Feb 2019 20:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2018-07-02;
 bh=SJjadGJSNzZF+UrL2IHlg0sQrJtHyFGp7uDt6saytdk=;
 b=fLqbVs3MhS1FIkDgr9oeUjQlsjLwq943+DbocLhQbpZ+V5Y3G24JT4PMj/1lAD2Ybb/G
 FijRkM6PBHbZuLMOJimEWoDkx9HQGVgNN4FPbmOpSMnr44r+xkLv5olEdBrHPogYtRx4
 7j4hebUAcq2Qg0j2rSTEx1Qen7ImzT3Z4elKLezWLIpoz9L41VvWQ854LzEM9hEP6GsV
 pfyL7Y7WLNXbB/sezuXkdIbLbQNxmMkadIRhzcoCuLB4ilKvGkPgAa7rIe0E/k49n5jC
 rQpZqz/mTsAYlIC0tTVO5hoNtB95/+GRFRDDg960bEVpSL1/s93tls8w+Uta/v8wNgnW ZA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2qtxtrg8hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Feb 2019 20:00:04 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1PK03Cv024602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Feb 2019 20:00:03 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1PK02dU025139;
        Mon, 25 Feb 2019 20:00:03 GMT
Received: from localhost.us.oracle.com (/10.211.15.82)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Feb 2019 12:00:02 -0800
From:   eugene.loh@oracle.com
To:     jeyu@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kallsyms: store type information in its own array
Date:   Mon, 25 Feb 2019 11:59:58 -0800
Message-Id: <1551124798-12712-1-git-send-email-eugene.loh@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9178 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902250144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugene Loh <eugene.loh@oracle.com>

When a module is loaded, its symbols' Elf_Sym information is stored
in a symtab.  Further, type information is also captured.  Since
Elf_Sym has no type field, historically the st_info field has been
hijacked for storing type:  st_info was overwritten.

commit 5439c985c5a83a8419f762115afdf560ab72a452 ("module: Overwrite
st_size instead of st_info") changes that practice, as its one-liner
indicates.  Unfortunately, this change overwrites symbol size,
information that a tool like DTrace expects to find.

Allocate a typetab array to store type information so that no Elf_Sym
field needs to be overwritten.

Fixes: 5439c985c5a8 ("module: Overwrite st_size instead of st_info")
Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
Reviewed-by: Nick Alcock <nick.alcock@oracle.com>
---
 include/linux/module.h   |  1 +
 kernel/module-internal.h |  2 +-
 kernel/module.c          | 21 ++++++++++++++-------
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index f5bc4c0..9c1bc21 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -315,6 +315,7 @@ struct mod_kallsyms {
 	Elf_Sym *symtab;
 	unsigned int num_symtab;
 	char *strtab;
+	char *typetab;
 };
 
 #ifdef CONFIG_LIVEPATCH
diff --git a/kernel/module-internal.h b/kernel/module-internal.h
index 79c9be2..67828af 100644
--- a/kernel/module-internal.h
+++ b/kernel/module-internal.h
@@ -20,7 +20,7 @@ struct load_info {
 	unsigned long len;
 	Elf_Shdr *sechdrs;
 	char *secstrings, *strtab;
-	unsigned long symoffs, stroffs;
+	unsigned long symoffs, stroffs, init_typeoff, core_typeoff;
 	struct _ddebug *debug;
 	unsigned int num_debug;
 	bool sig_ok;
diff --git a/kernel/module.c b/kernel/module.c
index 2ad1b52..c7c1bcd 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2647,6 +2647,8 @@ static void layout_symtab(struct module *mod, struct load_info *info)
 	info->symoffs = ALIGN(mod->core_layout.size, symsect->sh_addralign ?: 1);
 	info->stroffs = mod->core_layout.size = info->symoffs + ndst * sizeof(Elf_Sym);
 	mod->core_layout.size += strtab_size;
+	info->core_typeoff = mod->core_layout.size;
+	mod->core_layout.size += ndst * sizeof(char);
 	mod->core_layout.size = debug_align(mod->core_layout.size);
 
 	/* Put string table section at end of init part of module. */
@@ -2660,6 +2662,8 @@ static void layout_symtab(struct module *mod, struct load_info *info)
 				      __alignof__(struct mod_kallsyms));
 	info->mod_kallsyms_init_off = mod->init_layout.size;
 	mod->init_layout.size += sizeof(struct mod_kallsyms);
+	info->init_typeoff = mod->init_layout.size;
+	mod->init_layout.size += nsrc * sizeof(char);
 	mod->init_layout.size = debug_align(mod->init_layout.size);
 }
 
@@ -2683,20 +2687,23 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 	mod->kallsyms->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
 	/* Make sure we get permanent strtab: don't use info->strtab. */
 	mod->kallsyms->strtab = (void *)info->sechdrs[info->index.str].sh_addr;
+	mod->kallsyms->typetab = mod->init_layout.base + info->init_typeoff;
 
-	/* Set types up while we still have access to sections. */
-	for (i = 0; i < mod->kallsyms->num_symtab; i++)
-		mod->kallsyms->symtab[i].st_size
-			= elf_type(&mod->kallsyms->symtab[i], info);
-
-	/* Now populate the cut down core kallsyms for after init. */
+	/*
+	 * Now populate the cut down core kallsyms for after init
+	 * and set types up while we still have access to sections.
+	 */
 	mod->core_kallsyms.symtab = dst = mod->core_layout.base + info->symoffs;
 	mod->core_kallsyms.strtab = s = mod->core_layout.base + info->stroffs;
+	mod->core_kallsyms.typetab = mod->core_layout.base + info->core_typeoff;
 	src = mod->kallsyms->symtab;
 	for (ndst = i = 0; i < mod->kallsyms->num_symtab; i++) {
+		mod->kallsyms->typetab[i] = elf_type(src + i, info);
 		if (i == 0 || is_livepatch_module(mod) ||
 		    is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
 				   info->index.pcpu)) {
+			mod->core_kallsyms.typetab[ndst] =
+			    mod->kallsyms->typetab[i];
 			dst[ndst] = src[i];
 			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
 			s += strlcpy(s, &mod->kallsyms->strtab[src[i].st_name],
@@ -4084,7 +4091,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 			const Elf_Sym *sym = &kallsyms->symtab[symnum];
 
 			*value = kallsyms_symbol_value(sym);
-			*type = sym->st_size;
+			*type = kallsyms->typetab[symnum];
 			strlcpy(name, kallsyms_symbol_name(kallsyms, symnum), KSYM_NAME_LEN);
 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
 			*exported = is_exported(name, *value, mod);
-- 
1.8.3.1


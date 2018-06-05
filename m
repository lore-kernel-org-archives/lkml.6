Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeFEInl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:43:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbeFEInj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:43:39 -0400
From: Jessica Yu <jeyu@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, live-patching@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH] module: exclude SHN_UNDEF symbols from kallsyms api
Date: Tue,  5 Jun 2018 10:42:23 +0200
Message-Id: <20180605084223.20556-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Livepatch modules are special in that we preserve their entire symbol
tables in order to be able to apply relocations after module load. The
unwanted side effect of this is that undefined (SHN_UNDEF) symbols of
livepatch modules are accessible via the kallsyms api and this can
confuse symbol resolution in livepatch (klp_find_object_symbol()) and
cause subtle bugs in livepatch.

Have the module kallsyms api skip over SHN_UNDEF symbols. These symbols
are usually not available for normal modules anyway as we cut down their
symbol tables to just the core (non-undefined) symbols, so this should
really just affect livepatch modules. Note that this patch doesn't
affect the display of undefined symbols in /proc/kallsyms.

Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
 kernel/module.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index c9bea7f2b43e..dfa61490b37d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4070,7 +4070,7 @@ static unsigned long mod_find_symname(struct module *mod, const char *name)
 
 	for (i = 0; i < kallsyms->num_symtab; i++)
 		if (strcmp(name, symname(kallsyms, i)) == 0 &&
-		    kallsyms->symtab[i].st_info != 'U')
+		    kallsyms->symtab[i].st_shndx != SHN_UNDEF)
 			return kallsyms->symtab[i].st_value;
 	return 0;
 }
@@ -4116,6 +4116,10 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 		if (mod->state == MODULE_STATE_UNFORMED)
 			continue;
 		for (i = 0; i < kallsyms->num_symtab; i++) {
+
+			if (kallsyms->symtab[i].st_shndx == SHN_UNDEF)
+				continue;
+
 			ret = fn(data, symname(kallsyms, i),
 				 mod, kallsyms->symtab[i].st_value);
 			if (ret != 0)
-- 
2.16.3

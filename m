Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED0FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E9321019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 07:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbeLaHUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 02:20:38 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:25217 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbeLaHUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 02:20:38 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Sun, 30 Dec 2018 23:20:33 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id B0C1140AE5;
        Sun, 30 Dec 2018 23:20:35 -0800 (PST)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>
CC:     "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Nadav Amit <namit@vmware.com>
Subject: [RFC v2 4/6] x86: interface for accessing indirect branch locations
Date:   Sun, 30 Dec 2018 23:21:10 -0800
Message-ID: <20181231072112.21051-5-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181231072112.21051-1-namit@vmware.com>
References: <20181231072112.21051-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a C interface to access the locations of indirect branches. To be
used for dynamic patching.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/sections.h | 2 ++
 include/linux/module.h          | 9 +++++++++
 kernel/module.c                 | 8 ++++++++
 3 files changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 8ea1cfdbeabc..acba39349f46 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -4,6 +4,7 @@
 
 #include <asm-generic/sections.h>
 #include <asm/extable.h>
+#include <asm/nospec-branch.h>
 
 extern char __brk_base[], __brk_limit[];
 extern struct exception_table_entry __stop___ex_table[];
@@ -11,6 +12,7 @@ extern char __end_rodata_aligned[];
 
 #if defined(CONFIG_X86_64)
 extern char __end_rodata_hpage_align[];
+extern const struct optpoline_entry __optpolines[], __optpolines_end[];
 #endif
 
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/include/linux/module.h b/include/linux/module.h
index fce6b4335e36..2590719dd8f2 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -40,6 +40,8 @@ struct modversion_info {
 
 struct module;
 struct exception_table_entry;
+struct optpoline_entry;
+struct optpoline;
 
 struct module_kobject {
 	struct kobject kobj;
@@ -387,6 +389,13 @@ struct module {
 	unsigned int num_exentries;
 	struct exception_table_entry *extable;
 
+#ifdef CONFIG_OPTPOLINE
+	/* Dynamic indirect branch promotion */
+	struct optpoline_entry *optpoline_entries;
+	struct optpoline *optpolines;
+	unsigned int num_optpolines;
+#endif
+
 	/* Startup function. */
 	int (*init)(void);
 
diff --git a/kernel/module.c b/kernel/module.c
index 99b46c32d579..5e9edca9bbdc 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -64,6 +64,7 @@
 #include <linux/bsearch.h>
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
+#include <asm/nospec-branch.h>
 #include <uapi/linux/module.h>
 #include "module-internal.h"
 
@@ -256,6 +257,7 @@ static void mod_update_bounds(struct module *mod)
 #ifdef CONFIG_KGDB_KDB
 struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
 #endif /* CONFIG_KGDB_KDB */
+struct list_head *cachepoline_modules = &modules;
 
 static void module_assert_mutex(void)
 {
@@ -3125,6 +3127,12 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->extable = section_objs(info, "__ex_table",
 				    sizeof(*mod->extable), &mod->num_exentries);
 
+#ifdef CONFIG_OPTPOLINE
+	mod->optpoline_entries = section_objs(info, "__optpolines",
+					      sizeof(*mod->optpoline_entries),
+					      &mod->num_optpolines);
+#endif
+
 	if (section_addr(info, "__obsparm"))
 		pr_warn("%s: Ignoring obsolete parameters\n", mod->name);
 
-- 
2.17.1


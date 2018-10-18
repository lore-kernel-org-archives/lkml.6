Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D0DECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3382145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3382145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeJRIyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:54:46 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:46860 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727019AbeJRIye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:54:34 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 17 Oct 2018 17:55:41 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 4BAD540918;
        Wed, 17 Oct 2018 17:56:09 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin " <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Nadav Amit <namit@vmware.com>
Subject: [RFC PATCH 3/5] x86: interface for accessing indirect branch locations
Date:   Wed, 17 Oct 2018 17:54:18 -0700
Message-ID: <20181018005420.82993-4-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018005420.82993-1-namit@vmware.com>
References: <20181018005420.82993-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a C interface to access the locations of indirect branches. To be
used for dynamic patching.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/nospec-branch.h | 1 -
 arch/x86/include/asm/sections.h      | 2 ++
 include/linux/module.h               | 5 +++++
 kernel/module.c                      | 8 ++++++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index bd2d3a41e88c..a4496c141143 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -406,7 +406,6 @@ struct relpoline_entry {
 	u8 reg;
 } __packed;
 
-
 /* The Intel SPEC CTRL MSR base value cache */
 extern u64 x86_spec_ctrl_base;
 
diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 8ea1cfdbeabc..e8dd9c40ecd5 100644
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
+extern const struct relpoline_entry __relpolines[], __relpolines_end[];
 #endif
 
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/include/linux/module.h b/include/linux/module.h
index f807f15bebbe..29ff390f8339 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -39,6 +39,7 @@ struct modversion_info {
 
 struct module;
 struct exception_table_entry;
+struct relpoline_entry;
 
 struct module_kobject {
 	struct kobject kobj;
@@ -387,6 +388,10 @@ struct module {
 	unsigned int num_exentries;
 	struct exception_table_entry *extable;
 
+	/* Cachepolines */
+	unsigned int num_relpolines;
+	struct relpoline_entry *relpolines;
+
 	/* Startup function. */
 	int (*init)(void);
 
diff --git a/kernel/module.c b/kernel/module.c
index 49a405891587..e34fc28875bd 100644
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
 
+#ifdef CONFIG_X86_64
+	mod->relpolines = section_objs(info, "__relpolines",
+					 sizeof(*mod->relpolines),
+					 &mod->num_relpolines);
+#endif
+
 	if (section_addr(info, "__obsparm"))
 		pr_warn("%s: Ignoring obsolete parameters\n", mod->name);
 
-- 
2.17.1


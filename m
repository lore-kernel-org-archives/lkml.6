Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEDFC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1F120851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1F120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeLEIwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:52:34 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:33316 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727337AbeLEIwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:52:13 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 5 Dec 2018 00:52:03 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 3EDB341392;
        Wed,  5 Dec 2018 00:52:05 -0800 (PST)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, <linux_dti@icloud.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v7 13/14] module: Do not set nx for module memory before freeing
Date:   Tue, 4 Dec 2018 17:34:07 -0800
Message-ID: <20181205013408.47725-14-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205013408.47725-1-namit@vmware.com>
References: <20181205013408.47725-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When module memory is about to be freed, there is no apparent reason to
make it (and its data) executable, but that's exactly what is done
today. This is not efficient and not secure.

There are various theories why it was done, but none of them seem as
something that really require it today. nios2 uses kmalloc for module
memory, but anyhow it does not change the PTEs of the module memory.  In
x86, changing vmalloc'd memory mappings also modifies the direct mapping
alias, but the NX-bit is not modified in such way.

So let's remove it. Andy suggested that the changes of the PTEs can be
avoided (excluding the direct-mapping alias), which is true. However,
in x86 it requires some cleanup of the contiguous page allocator, which
is outside of the scope of this patch-set.

Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 kernel/module.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 7cb207249437..57c5b23746e7 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2027,20 +2027,29 @@ void set_all_modules_text_ro(void)
 	mutex_unlock(&module_mutex);
 }
 
-static void disable_ro_nx(const struct module_layout *layout)
+static void module_restore_mappings(const struct module_layout *layout)
 {
-	if (rodata_enabled) {
-		frob_text(layout, set_memory_rw);
-		frob_rodata(layout, set_memory_rw);
-		frob_ro_after_init(layout, set_memory_rw);
-	}
-	frob_rodata(layout, set_memory_x);
-	frob_ro_after_init(layout, set_memory_x);
-	frob_writable_data(layout, set_memory_x);
+	/*
+	 * First, make the mappings of the code non-executable to prevent
+	 * transient W+X mappings from being set when the text is set as RW.
+	 */
+	frob_text(layout, set_memory_nx);
+
+	if (!rodata_enabled)
+		return;
+
+	/*
+	 * Second, set the memory as writable. Although the module memory is
+	 * about to be freed, these calls are required (at least on x86) to
+	 * restore the direct map to its "correct" state.
+	 */
+	frob_text(layout, set_memory_rw);
+	frob_rodata(layout, set_memory_rw);
+	frob_ro_after_init(layout, set_memory_rw);
 }
 
 #else
-static void disable_ro_nx(const struct module_layout *layout) { }
+static void module_restore_mappings(const struct module_layout *layout) { }
 static void module_enable_nx(const struct module *mod) { }
 static void module_disable_nx(const struct module *mod) { }
 #endif
@@ -2173,7 +2182,7 @@ static void free_module(struct module *mod)
 	mutex_unlock(&module_mutex);
 
 	/* This may be empty, but that's OK */
-	disable_ro_nx(&mod->init_layout);
+	module_restore_mappings(&mod->init_layout);
 	module_arch_freeing_init(mod);
 	module_memfree(mod->init_layout.base);
 	kfree(mod->args);
@@ -2183,7 +2192,7 @@ static void free_module(struct module *mod)
 	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
 
 	/* Finally, free the core (containing the module structure) */
-	disable_ro_nx(&mod->core_layout);
+	module_restore_mappings(&mod->core_layout);
 	module_memfree(mod->core_layout.base);
 }
 
@@ -3507,7 +3516,7 @@ static noinline int do_init_module(struct module *mod)
 #endif
 	module_enable_ro(mod, true);
 	mod_tree_remove_init(mod);
-	disable_ro_nx(&mod->init_layout);
+	module_restore_mappings(&mod->init_layout);
 	module_arch_freeing_init(mod);
 	mod->init_layout.base = NULL;
 	mod->init_layout.size = 0;
-- 
2.17.1


Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94510C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 23:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CF121871
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 23:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeLaXm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 18:42:28 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:12631 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727563AbeLaXm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 18:42:27 -0500
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 31 Dec 2018 15:42:22 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 23CE3B18BD;
        Mon, 31 Dec 2018 18:42:26 -0500 (EST)
From:   Nadav Amit <namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] x86/retpoline: change RETPOLINE into CONFIG_RETPOLINE
Date:   Mon, 31 Dec 2018 15:42:53 -0800
Message-ID: <20181231234253.2724-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent enhancement intentionally fails the kernel build if the
compiler does not support retpolines and CONFIG_RETPOLINE is set.

However, the patch that introduced it did not change RETPOLINE macro
references into CONFIG_RETPOLINE ones. As a result, indirect branches
that are used by init functions are not kept (i.e., they use
retpolines), and modules that do not use retpolines are marked as
retpoline-safe.

Fix it be changing RETPOLINE into CONFIG_RETPOLINE.

Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: stable@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/cpu/bugs.c   | 2 +-
 include/linux/compiler-gcc.h | 2 +-
 include/linux/module.h       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8654b8b0c848..1de0f4170178 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -215,7 +215,7 @@ static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
 static enum spectre_v2_user_mitigation spectre_v2_user __ro_after_init =
 	SPECTRE_V2_USER_NONE;
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 static bool spectre_v2_bad_module;
 
 bool retpoline_module_ok(bool has_retpoline)
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 2010493e1040..977ddf2774f9 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -68,7 +68,7 @@
  */
 #define uninitialized_var(x) x = x
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 #define __noretpoline __attribute__((__indirect_branch__("keep")))
 #endif
 
diff --git a/include/linux/module.h b/include/linux/module.h
index fce6b4335e36..0c575f51fe57 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -817,7 +817,7 @@ static inline void module_bug_finalize(const Elf_Ehdr *hdr,
 static inline void module_bug_cleanup(struct module *mod) {}
 #endif	/* CONFIG_GENERIC_BUG */
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 extern bool retpoline_module_ok(bool has_retpoline);
 #else
 static inline bool retpoline_module_ok(bool has_retpoline)
-- 
2.17.1


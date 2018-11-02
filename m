Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D88BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4842081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4842081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeKCIky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 04:40:54 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:8611 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbeKCIky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 04:40:54 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 2 Nov 2018 16:31:32 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 94A57B14CC;
        Fri,  2 Nov 2018 19:31:42 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during early_init
Date:   Fri, 2 Nov 2018 16:29:41 -0700
Message-ID: <20181102232946.98461-3-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181102232946.98461-1-namit@vmware.com>
References: <20181102232946.98461-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no apparent reason not to use text_poke_early() while we are
during early-init and we do not patch code that might be on the stack
(i.e., we'll return to the middle of the patched code).  This appears to
be the case of jump-labels, so do so.

This is required for the next patches that would set a temporary mm for
patching, which is initialized after some static-keys are
enabled/disabled.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/jump_label.c | 8 +++++++-
 include/linux/kernel.h       | 1 +
 init/main.c                  | 4 ++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index aac0c1f7e354..367c1d0c20a3 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -52,7 +52,13 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 	jmp.offset = jump_entry_target(entry) -
 		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 
-	if (early_boot_irqs_disabled)
+	/*
+	 * As long as we are in early boot, we can use text_poke_early(), which
+	 * is more efficient: the memory was still not marked as read-only (it
+	 * is only marked after poking_init()). This also prevents us from using
+	 * text_poke() before poking_init() is called.
+	 */
+	if (!early_boot_done)
 		poker = text_poke_early;
 
 	if (type == JUMP_LABEL_JMP) {
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d6aac75b51ba..3e86ff3c64c4 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -564,6 +564,7 @@ extern unsigned long get_taint(void);
 extern int root_mountflags;
 
 extern bool early_boot_irqs_disabled;
+extern u8 early_boot_done;
 
 /*
  * Values used for system_state. Ordering of the states must not be changed
diff --git a/init/main.c b/init/main.c
index a664246450d1..b0fa26637496 100644
--- a/init/main.c
+++ b/init/main.c
@@ -117,6 +117,8 @@ extern void radix_tree_init(void);
  */
 bool early_boot_irqs_disabled __read_mostly;
 
+u8 early_boot_done __read_mostly;
+
 enum system_states system_state __read_mostly;
 EXPORT_SYMBOL(system_state);
 
@@ -735,6 +737,8 @@ asmlinkage __visible void __init start_kernel(void)
 		efi_free_boot_services();
 	}
 
+	early_boot_done = true;
+
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
 }
-- 
2.17.1


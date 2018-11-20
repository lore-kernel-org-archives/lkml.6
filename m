Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4076AC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3872145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3872145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeKUO0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:26:14 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:13925 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728021AbeKUO0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:26:13 -0500
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Tue, 20 Nov 2018 19:52:52 -0800
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id A3EFFB1879;
        Tue, 20 Nov 2018 22:53:30 -0500 (EST)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, <linux_dti@icloud.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v6 09/10] x86/jump-label: remove support for custom poker
Date:   Tue, 20 Nov 2018 12:35:44 -0800
Message-ID: <20181120203545.34928-10-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120203545.34928-1-namit@vmware.com>
References: <20181120203545.34928-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only two types of poking: early and breakpoint based. The use
of a function pointer to perform poking complicates the code and is
probably inefficient due to the use of indirect branches.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/jump_label.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index ed5fe274a7d8..994c13e2867d 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -39,7 +39,6 @@ static void bug_at(unsigned char *ip, int line)
 
 static void __ref __jump_label_transform(struct jump_entry *entry,
 					 enum jump_label_type type,
-					 void *(*poker)(void *, const void *, size_t),
 					 int init)
 {
 	union jump_code_union jmp;
@@ -52,14 +51,6 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 	jmp.offset = jump_entry_target(entry) -
 		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 
-	/*
-	 * As long as we're UP and not yet marked RO, we can use
-	 * text_poke_early; SYSTEM_BOOTING guarantees both, as we switch to
-	 * SYSTEM_SCHEDULING before going either.
-	 */
-	if (system_state == SYSTEM_BOOTING)
-		poker = text_poke_early;
-
 	if (type == JUMP_LABEL_JMP) {
 		if (init) {
 			expect = default_nop; line = __LINE__;
@@ -82,16 +73,17 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 		bug_at((void *)jump_entry_code(entry), line);
 
 	/*
-	 * Make text_poke_bp() a default fallback poker.
+	 * As long as we're UP and not yet marked RO, we can use
+	 * text_poke_early; SYSTEM_BOOTING guarantees both, as we switch to
+	 * SYSTEM_SCHEDULING before going either.
 	 *
 	 * At the time the change is being done, just ignore whether we
 	 * are doing nop -> jump or jump -> nop transition, and assume
 	 * always nop being the 'currently valid' instruction
-	 *
 	 */
-	if (poker) {
-		(*poker)((void *)jump_entry_code(entry), code,
-			 JUMP_LABEL_NOP_SIZE);
+	if (init || system_state == SYSTEM_BOOTING) {
+		text_poke_early((void *)jump_entry_code(entry), code,
+				JUMP_LABEL_NOP_SIZE);
 		return;
 	}
 
@@ -103,7 +95,7 @@ void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
 	mutex_lock(&text_mutex);
-	__jump_label_transform(entry, type, NULL, 0);
+	__jump_label_transform(entry, type, 0);
 	mutex_unlock(&text_mutex);
 }
 
@@ -133,7 +125,7 @@ __init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
 			jlstate = JL_STATE_NO_UPDATE;
 	}
 	if (jlstate == JL_STATE_UPDATE)
-		__jump_label_transform(entry, type, text_poke_early, 1);
+		__jump_label_transform(entry, type, 1);
 }
 
 #endif
-- 
2.17.1


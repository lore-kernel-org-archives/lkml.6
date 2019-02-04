Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D96C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D4B2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfBDUAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:00:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbfBDUAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:00:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 94C8DC0740F1;
        Mon,  4 Feb 2019 20:00:44 +0000 (UTC)
Received: from t460s.bristot.redhat.com (ovpn-117-55.phx2.redhat.com [10.3.117.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A46D9F7DE;
        Mon,  4 Feb 2019 20:00:18 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     bristot@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: [PATCH V4 4/9] x86/jump_label: Add __jump_label_set_jump_code() helper
Date:   Mon,  4 Feb 2019 20:58:57 +0100
Message-Id: <179663eb6c18019d5fda46a9725abaf306a1a714.1549308412.git.bristot@redhat.com>
In-Reply-To: <cover.1549308412.git.bristot@redhat.com>
References: <cover.1549308412.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 04 Feb 2019 20:00:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the definition of the code to be written from
__jump_label_transform() to a specialized function.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Chris von Recklinghausen <crecklin@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Scott Wood <swood@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/jump_label.c | 38 +++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e443c43478eb..2ef687db5a87 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -73,30 +73,36 @@ static inline void __jump_label_trans_check_disable(struct jump_entry *entry,
 		bug_at((void *)jump_entry_code(entry), line);
 }
 
+static void __jump_label_set_jump_code(struct jump_entry *entry,
+				       enum jump_label_type type,
+				       union jump_code_union *code,
+				       int init)
+{
+	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
+
+	code->jump = 0xe9;
+	code->offset = jump_entry_target(entry) -
+		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
+
+	if (type == JUMP_LABEL_JMP) {
+		__jump_label_trans_check_enable(entry, type, ideal_nop, init);
+	} else {
+		__jump_label_trans_check_disable(entry, type, code, init);
+		memcpy(code, ideal_nop, JUMP_LABEL_NOP_SIZE);
+	}
+}
 
 static void __ref __jump_label_transform(struct jump_entry *entry,
 					 enum jump_label_type type,
 					 void *(*poker)(void *, const void *, size_t),
 					 int init)
 {
-	union jump_code_union jmp;
-	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
-	const void *code;
-
-	jmp.jump = 0xe9;
-	jmp.offset = jump_entry_target(entry) -
-		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
+	union jump_code_union code;
 
 	if (early_boot_irqs_disabled)
 		poker = text_poke_early;
 
-	if (type == JUMP_LABEL_JMP) {
-		__jump_label_trans_check_enable(entry, type, ideal_nop, init);
-		code = &jmp.code;
-	} else {
-		__jump_label_trans_check_disable(entry, type, &jmp, init);
-		code = ideal_nop;
-	}
+	__jump_label_set_jump_code(entry, type, &code, init);
 
 	/*
 	 * Make text_poke_bp() a default fallback poker.
@@ -107,12 +113,12 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
 	 *
 	 */
 	if (poker) {
-		(*poker)((void *)jump_entry_code(entry), code,
+		(*poker)((void *)jump_entry_code(entry), &code,
 			 JUMP_LABEL_NOP_SIZE);
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), code, JUMP_LABEL_NOP_SIZE,
+	text_poke_bp((void *)jump_entry_code(entry), &code, JUMP_LABEL_NOP_SIZE,
 		     (void *)jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 }
 
-- 
2.17.1


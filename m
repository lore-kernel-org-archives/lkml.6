Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AE6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798072176F
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389581AbeLUK2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:28:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389541AbeLUK17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:27:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 382F97970D;
        Fri, 21 Dec 2018 10:27:59 +0000 (UTC)
Received: from f28server.default (ovpn-116-118.phx2.redhat.com [10.3.116.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E2BB5D739;
        Fri, 21 Dec 2018 10:27:55 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [PATCH V3 4/9] x86/jump_label: Add __jump_label_set_jump_code() helper
Date:   Fri, 21 Dec 2018 11:27:29 +0100
Message-Id: <eb97675f0d139aa6f78874db3abc81fcdba7a80f.1545228276.git.bristot@redhat.com>
In-Reply-To: <cover.1545228276.git.bristot@redhat.com>
References: <cover.1545228276.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 21 Dec 2018 10:27:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the definition of the code to be written from
__jump_label_transform() to a specialized function. No change in the
method, code relocation only.

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
index 7894080bd02f..a039ac4ca5bf 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -75,30 +75,36 @@ static inline void __jump_label_trans_check_disable(struct jump_entry *entry,
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
@@ -109,12 +115,12 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
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


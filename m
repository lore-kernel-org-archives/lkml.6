Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3464CC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81532084D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81532084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeJHUFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:05:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeJHUFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:05:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2709D3084258;
        Mon,  8 Oct 2018 12:53:43 +0000 (UTC)
Received: from f28server.default (ovpn-116-135.phx2.redhat.com [10.3.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE3EE61D3F;
        Mon,  8 Oct 2018 12:53:33 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [RFC PATCH 3/6] x86/jump_label: Move checking code away from __jump_label_transform()
Date:   Mon,  8 Oct 2018 14:53:02 +0200
Message-Id: <ae6a5a3f4d59567e17a96d505daed0bacb42ecae.1539001620.git.bristot@redhat.com>
In-Reply-To: <cover.1539001620.git.bristot@redhat.com>
References: <cover.1539001620.git.bristot@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 08 Oct 2018 12:53:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates two new functions, __jump_label_enabling_check()
and __jump_label_disabling_check(), to make the respective check before
updating a jump_entry.

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Zhou Chengming <zhouchengming1@huawei.com>
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
 arch/x86/kernel/jump_label.c | 88 ++++++++++++++++++++++--------------
 1 file changed, 53 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index eeea935e9bb5..a11d836d9aaa 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -37,57 +37,75 @@ static void bug_at(unsigned char *ip, int line)
 	BUG();
 }
 
+static inline void __jump_label_enabling_check(struct jump_entry *entry,
+					 enum jump_label_type type,
+					 int init)
+{
+	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
+	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
+
+	if (init) {
+		/*
+		 * Jump label is enabled for the first time.
+		 * So we expect a default_nop...
+		 */
+		if (unlikely(memcmp((void *)entry->code, default_nop, 5)
+			     != 0))
+			bug_at((void *)entry->code, __LINE__);
+	} else {
+		/*
+		 * ...otherwise expect an ideal_nop. Otherwise
+		 * something went horribly wrong.
+		 */
+		if (unlikely(memcmp((void *)entry->code, ideal_nop, 5)
+			     != 0))
+			bug_at((void *)entry->code, __LINE__);
+	}
+}
+
+static inline void __jump_label_disabling_check(struct jump_entry *entry,
+					 enum jump_label_type type,
+					 int init)
+{
+	union jump_code_union code;
+	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
+
+	/*
+	 * We are disabling this jump label. If it is not what
+	 * we think it is, then something must have gone wrong.
+	 * If this is the first initialization call, then we
+	 * are converting the default nop to the ideal nop.
+	 */
+	if (init) {
+		if (unlikely(memcmp((void *)entry->code, default_nop, 5) != 0))
+			bug_at((void *)entry->code, __LINE__);
+	} else {
+		code.jump = 0xe9;
+		code.offset = entry->target -
+			(entry->code + JUMP_LABEL_NOP_SIZE);
+		if (unlikely(memcmp((void *)entry->code, &code, 5) != 0))
+			bug_at((void *)entry->code, __LINE__);
+	}
+}
+
 static void __ref __jump_label_transform(struct jump_entry *entry,
 					 enum jump_label_type type,
 					 void *(*poker)(void *, const void *, size_t),
 					 int init)
 {
 	union jump_code_union code;
-	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
-	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
 
 	if (early_boot_irqs_disabled)
 		poker = text_poke_early;
 
 	if (type == JUMP_LABEL_JMP) {
-		if (init) {
-			/*
-			 * Jump label is enabled for the first time.
-			 * So we expect a default_nop...
-			 */
-			if (unlikely(memcmp((void *)entry->code, default_nop, 5)
-				     != 0))
-				bug_at((void *)entry->code, __LINE__);
-		} else {
-			/*
-			 * ...otherwise expect an ideal_nop. Otherwise
-			 * something went horribly wrong.
-			 */
-			if (unlikely(memcmp((void *)entry->code, ideal_nop, 5)
-				     != 0))
-				bug_at((void *)entry->code, __LINE__);
-		}
+		__jump_label_enabling_check(entry, type, init);
 
 		code.jump = 0xe9;
 		code.offset = entry->target -
 				(entry->code + JUMP_LABEL_NOP_SIZE);
 	} else {
-		/*
-		 * We are disabling this jump label. If it is not what
-		 * we think it is, then something must have gone wrong.
-		 * If this is the first initialization call, then we
-		 * are converting the default nop to the ideal nop.
-		 */
-		if (init) {
-			if (unlikely(memcmp((void *)entry->code, default_nop, 5) != 0))
-				bug_at((void *)entry->code, __LINE__);
-		} else {
-			code.jump = 0xe9;
-			code.offset = entry->target -
-				(entry->code + JUMP_LABEL_NOP_SIZE);
-			if (unlikely(memcmp((void *)entry->code, &code, 5) != 0))
-				bug_at((void *)entry->code, __LINE__);
-		}
+		__jump_label_disabling_check(entry, type, init);
 		memcpy(&code, ideal_nops[NOP_ATOMIC5], JUMP_LABEL_NOP_SIZE);
 	}
 
-- 
2.17.1


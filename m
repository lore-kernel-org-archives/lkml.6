Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7E2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064872186D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GymrCStW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064872186D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932148AbeGBSOK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:14:10 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44074 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753384AbeGBSME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:12:04 -0400
Received: by mail-wr0-f194.google.com with SMTP id p12-v6so16417898wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w4lxjj61CeIJtbmnFVjG2GWM9frrLYdO8XaMvDkK3nI=;
        b=GymrCStWjyo2SvoZDUrwyeQXJkBuT4se9Fg+tlEcaSo8Aym536nvFRSHOd7XtAmMya
         1cL8Wd/1/asNFKwEGUHVvxVPJM+2IlGnMiza3uAWHP5OVn+C/2H3QjewoJJxBO7xHlhd
         OpHAV/O6SWI/9zM3HEWvMLl+wwzB48KZ/wPpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w4lxjj61CeIJtbmnFVjG2GWM9frrLYdO8XaMvDkK3nI=;
        b=VJwSMMdzxJnEMMEYtkTPBIvXFqIgefpV3UKSGs2UPziUPE0l38sw+ynk4shM8bnmP6
         XppepRi7mocWGhN3BD+7HsOD0oOl8csYRwpYvcksdXjcT9WVwg9O8e//MeagY3C2LW6g
         ClAM0oORmUx0pLV7ig+sOlfoxXM3uLb4W6CY60RhvFnX1koff4uhmBdDGxPyYSfV57Gm
         OP1gWv4XdgGqeHb80nx3htLmUaRGN63HzoYG7T3n5aDBLLto0oZo77Qr8kjRrCAs3eve
         zlEUb7l+od0+799vBVslKNzNxQhhJ6la5/A7lMGzo+2wlnisoD3I0ODGHx8JYDdrajcx
         HExQ==
X-Gm-Message-State: APt69E0hCe+Uy6dHdJcNQg+I/WIL3aPc08lhJYrBwU3nqRCC/eWOTkQe
        zv7PNhbHEw7yPbnhVudwyOqVHQ==
X-Google-Smtp-Source: AAOMgpc4dZrSrdg3KWZAALIfxmtO8U+AjGhk5fNvj0iSbn/hiLmJQgn1cO5C2seb/rPtBR/9d8g/DA==
X-Received: by 2002:adf:8e49:: with SMTP id n67-v6mr19861946wrb.131.1530555123423;
        Mon, 02 Jul 2018 11:12:03 -0700 (PDT)
Received: from localhost.localdomain (151.21.90.92.rev.sfr.net. [92.90.21.151])
        by smtp.gmail.com with ESMTPSA id 189-v6sm10582822wmd.17.2018.07.02.11.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:12:02 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 5/8] x86: jump_label: switch to jump_entry accessors
Date:   Mon,  2 Jul 2018 20:11:42 +0200
Message-Id: <20180702181145.4799-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of switching x86 to use place-relative references for
the code, target and key members of struct jump_entry, replace direct
references to the struct members with invocations of the new accessors.
This will allow us to make the switch by modifying the accessors only.

This incorporates a cleanup of __jump_label_transform() proposed by
Peter.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/kernel/jump_label.c | 62 ++++++++------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e56c95be2808..023768222a94 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -42,52 +42,37 @@ static void __jump_label_transform(struct jump_entry *entry,
 				   void *(*poker)(void *, const void *, size_t),
 				   int init)
 {
-	union jump_code_union code;
+	union jump_code_union jmp;
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
+	const void *expect, *code;
+	int line;
+
+	jmp.jump = 0xe9;
+	jmp.offset = jump_entry_target(entry) -
+		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 
 	if (type == JUMP_LABEL_JMP) {
 		if (init) {
-			/*
-			 * Jump label is enabled for the first time.
-			 * So we expect a default_nop...
-			 */
-			if (unlikely(memcmp((void *)entry->code, default_nop, 5)
-				     != 0))
-				bug_at((void *)entry->code, __LINE__);
+			expect = default_nop; line = __LINE__;
 		} else {
-			/*
-			 * ...otherwise expect an ideal_nop. Otherwise
-			 * something went horribly wrong.
-			 */
-			if (unlikely(memcmp((void *)entry->code, ideal_nop, 5)
-				     != 0))
-				bug_at((void *)entry->code, __LINE__);
+			expect = ideal_nop; line = __LINE__;
 		}
 
-		code.jump = 0xe9;
-		code.offset = entry->target -
-				(entry->code + JUMP_LABEL_NOP_SIZE);
+		code = &jmp.code;
 	} else {
-		/*
-		 * We are disabling this jump label. If it is not what
-		 * we think it is, then something must have gone wrong.
-		 * If this is the first initialization call, then we
-		 * are converting the default nop to the ideal nop.
-		 */
 		if (init) {
-			if (unlikely(memcmp((void *)entry->code, default_nop, 5) != 0))
-				bug_at((void *)entry->code, __LINE__);
+			expect = default_nop; line = __LINE__;
 		} else {
-			code.jump = 0xe9;
-			code.offset = entry->target -
-				(entry->code + JUMP_LABEL_NOP_SIZE);
-			if (unlikely(memcmp((void *)entry->code, &code, 5) != 0))
-				bug_at((void *)entry->code, __LINE__);
+			expect = &jmp.code; line = __LINE__;
 		}
-		memcpy(&code, ideal_nops[NOP_ATOMIC5], JUMP_LABEL_NOP_SIZE);
+
+		code = ideal_nop;
 	}
 
+	if (memcmp((void *)jump_entry_code(entry), expect, JUMP_LABEL_NOP_SIZE))
+		bug_at((void *)jump_entry_code(entry), line);
+
 	/*
 	 * Make text_poke_bp() a default fallback poker.
 	 *
@@ -96,11 +81,14 @@ static void __jump_label_transform(struct jump_entry *entry,
 	 * always nop being the 'currently valid' instruction
 	 *
 	 */
-	if (poker)
-		(*poker)((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE);
-	else
-		text_poke_bp((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE,
-			     (void *)entry->code + JUMP_LABEL_NOP_SIZE);
+	if (poker) {
+		(*poker)((void *)jump_entry_code(entry), code,
+			 JUMP_LABEL_NOP_SIZE);
+		return;
+	}
+
+	text_poke_bp((void *)jump_entry_code(entry), code, JUMP_LABEL_NOP_SIZE,
+		     (void *)jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 }
 
 void arch_jump_label_transform(struct jump_entry *entry,
-- 
2.17.1


Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5C4ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39B420880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NsN3AGnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39B420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbeISM27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:28:59 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34502 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731001AbeISM26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:28:58 -0400
Received: by mail-it0-f65.google.com with SMTP id x79-v6so16348118ita.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 23:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NQAhy2Ey7Mb6Ox0BCHyj7wjUntgBhLLd89LZtlZjBHU=;
        b=NsN3AGnv7VsZoqzNrVLUZ4ZX6yXb4cVP5GslK5jPZ0Y4tbBxC1B7e1XNykxHAR/3nT
         Xwjbvtf7nZ33/GqY6GYPE+PxBEbnXSd7i1+38SmgzfPHMcuuuVMJTKvhYZemWDB1m4QH
         Ja5JsrtYPbYr70dgGUwnDQM80n6TlQiQHp9AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NQAhy2Ey7Mb6Ox0BCHyj7wjUntgBhLLd89LZtlZjBHU=;
        b=W/cmJwP9OVsmkPg4cepxH6Q3gdvRZ/3h2nhAOPVRcWRwr1yYfjzbOtOtyqmF5FSrZz
         sYBYyDX5ABZwekI7HdXEZzGK0YryohKqGyMDtgeT+J3mUmE0hAkNLeU7lG4PmPBKEugQ
         kKo+wFvE6qiM3uC3ELirYU5afT9oegiYCQelIeJ3D5ljLN9S8Y7WW6Ygdl5Cfy2EN3Ly
         V38AIqT9QIv+9EH54jv+DNOigOV4JrfIggu5EXfx3wVvAvf31qtm/uw+Rx7H3nT2ljBm
         sq5PjfgjHT+EUKJ/znN7xcWIG2zNRFm9lnyPBW2wTiQpO9gWxlsJM2hSM90YrgEhviey
         w1WQ==
X-Gm-Message-State: APzg51B2lJ8gw8xS2njBXwIpGXP6HagWoq4SX5hL5dxiW6MjraS0w0AS
        cUrpNC8vyLczP0jvBcsEq6uh4vdSX5JxJA==
X-Google-Smtp-Source: ANB0VdYEogMo8sPSravQfn7FYvX8lZmccL3rlR5nUpxZNJFm1pFyOodUDp8b37oLtQTDBbhwYH8leA==
X-Received: by 2002:a24:1ad2:: with SMTP id 201-v6mr20493825iti.18.1537339948813;
        Tue, 18 Sep 2018 23:52:28 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id x68-v6sm7939477ita.2.2018.09.18.23.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 23:52:28 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Subject: [PATCH v3 5/9] x86: jump_label: switch to jump_entry accessors
Date:   Tue, 18 Sep 2018 23:51:40 -0700
Message-Id: <20180919065144.25010-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
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
index eeea935e9bb5..aac0c1f7e354 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -42,55 +42,40 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
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
 
 	if (early_boot_irqs_disabled)
 		poker = text_poke_early;
 
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
@@ -99,11 +84,14 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
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


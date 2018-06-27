Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BD2C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5B025CF1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFOKClWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5B025CF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935110AbeF0QGU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:06:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54208 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934909AbeF0QGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:06:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id b188-v6so321937wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=esdLUiP7Nq3pkGb9sS91qfLIwlUoKTrbJ1pPFJuzVN8=;
        b=CFOKClWpw5aVyAdTvFohT5qLEXHmaYuvG7el2Mj0dHB2mwVKTW2MFGWsyrkUpBMILS
         ChNE9yCoBxh78nTLsP/Bm0nc0tkOTSwx0MzIoHQUFzm4XeBhhuUnXwWjroQ8AF6w5i08
         SAaSJr5sUWwDHqD9Aiox6yQObmW1VDz2iY1gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=esdLUiP7Nq3pkGb9sS91qfLIwlUoKTrbJ1pPFJuzVN8=;
        b=bUsstkuIKUimNZQcn5pAyenJIi9vHyRio1sPDAYK8nQyHFaChX1USPIzcrOeOfwse0
         YB895HVEbXwDBNkjI1FzvjZan+7h13KtAVOx1nJMbBrNe7uBgwzI81czpLlENYSQvOYc
         RgJP8q2BJaEOmy+cxUwP9yIXTvXOSVgIf2GeXQOJe0QRry+3CKVvscUXVLSQbstfRYG1
         adCvl9euZcU4CzSUCF2r6BF2ENQ4i13L3f1OmZYLBtg7dF2g8JAPqcf049Kla9sAd+qk
         FjTLyD8jghAhfkNxTv94hyafPPT2VW+WWZBok8oB2zi+FUJSdpcy9istgJY0r56LZQ/7
         3Qew==
X-Gm-Message-State: APt69E1MMol4rwZhe1IeAF72bnhyfxZq1grO/TafMiSP+0hKdY1Ze7WJ
        4DvA3glObRpqyTwuxBo9Z3kWI4UlAss=
X-Google-Smtp-Source: AAOMgpekeKrNwZtqo154F2URB/zvV/iRrauul4luSTtzlRRjtIhO1LDLskV2tIyEAvt8/PbSUVkeVw==
X-Received: by 2002:a1c:568a:: with SMTP id k132-v6mr2709334wmb.89.1530115573151;
        Wed, 27 Jun 2018 09:06:13 -0700 (PDT)
Received: from rev02.home ([2a01:cb1d:112:6f00:4d04:66e:dea8:5b23])
        by smtp.gmail.com with ESMTPSA id s2-v6sm7055000wrn.75.2018.06.27.09.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 09:06:12 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/5] x86: jump_label: switch to jump_entry accessors
Date:   Wed, 27 Jun 2018 18:06:03 +0200
Message-Id: <20180627160604.8154-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of switching x86 to use place-relative references for
the code, target and key members of struct jump_entry, replace direct
references to the struct members with invocations of the new accessors.
This will allow us to make the switch by modifying the accessors only.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/kernel/jump_label.c | 43 ++++++++++++--------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e56c95be2808..d64296092ef5 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -52,22 +52,24 @@ static void __jump_label_transform(struct jump_entry *entry,
 			 * Jump label is enabled for the first time.
 			 * So we expect a default_nop...
 			 */
-			if (unlikely(memcmp((void *)entry->code, default_nop, 5)
-				     != 0))
-				bug_at((void *)entry->code, __LINE__);
+			if (unlikely(memcmp((void *)jump_entry_code(entry),
+					    default_nop, 5) != 0))
+				bug_at((void *)jump_entry_code(entry),
+				       __LINE__);
 		} else {
 			/*
 			 * ...otherwise expect an ideal_nop. Otherwise
 			 * something went horribly wrong.
 			 */
-			if (unlikely(memcmp((void *)entry->code, ideal_nop, 5)
-				     != 0))
-				bug_at((void *)entry->code, __LINE__);
+			if (unlikely(memcmp((void *)jump_entry_code(entry),
+					    ideal_nop, 5) != 0))
+				bug_at((void *)jump_entry_code(entry),
+				       __LINE__);
 		}
 
 		code.jump = 0xe9;
-		code.offset = entry->target -
-				(entry->code + JUMP_LABEL_NOP_SIZE);
+		code.offset = jump_entry_target(entry) -
+			      (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
 	} else {
 		/*
 		 * We are disabling this jump label. If it is not what
@@ -76,14 +78,18 @@ static void __jump_label_transform(struct jump_entry *entry,
 		 * are converting the default nop to the ideal nop.
 		 */
 		if (init) {
-			if (unlikely(memcmp((void *)entry->code, default_nop, 5) != 0))
-				bug_at((void *)entry->code, __LINE__);
+			if (unlikely(memcmp((void *)jump_entry_code(entry),
+					    default_nop, 5) != 0))
+				bug_at((void *)jump_entry_code(entry),
+				       __LINE__);
 		} else {
 			code.jump = 0xe9;
-			code.offset = entry->target -
-				(entry->code + JUMP_LABEL_NOP_SIZE);
-			if (unlikely(memcmp((void *)entry->code, &code, 5) != 0))
-				bug_at((void *)entry->code, __LINE__);
+			code.offset = jump_entry_target(entry) -
+				(jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
+			if (unlikely(memcmp((void *)jump_entry_code(entry),
+				     &code, 5) != 0))
+				bug_at((void *)jump_entry_code(entry),
+				       __LINE__);
 		}
 		memcpy(&code, ideal_nops[NOP_ATOMIC5], JUMP_LABEL_NOP_SIZE);
 	}
@@ -97,10 +103,13 @@ static void __jump_label_transform(struct jump_entry *entry,
 	 *
 	 */
 	if (poker)
-		(*poker)((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE);
+		(*poker)((void *)jump_entry_code(entry), &code,
+			 JUMP_LABEL_NOP_SIZE);
 	else
-		text_poke_bp((void *)entry->code, &code, JUMP_LABEL_NOP_SIZE,
-			     (void *)entry->code + JUMP_LABEL_NOP_SIZE);
+		text_poke_bp((void *)jump_entry_code(entry), &code,
+			     JUMP_LABEL_NOP_SIZE,
+			     (void *)jump_entry_code(entry) +
+			     JUMP_LABEL_NOP_SIZE);
 }
 
 void arch_jump_label_transform(struct jump_entry *entry,
-- 
2.11.0


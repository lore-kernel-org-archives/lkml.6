Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180D7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34D420859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389397AbfAPL72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:59:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39235 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732396AbfAPL72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:59:28 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0GBxDad252994
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 16 Jan 2019 03:59:13 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0GBxDYT252991;
        Wed, 16 Jan 2019 03:59:13 -0800
Date:   Wed, 16 Jan 2019 03:59:13 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-71a93c26930471e976dd184ef91931b2a5393afc@git.kernel.org>
Cc:     x86@kernel.org, luto@amacapital.net, peterz@infradead.org,
        bp@suse.de, hpa@zytor.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, tglx@linutronix.de, thomas.lendacky@amd.com,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com, hpa@zytor.com,
          bp@suse.de, peterz@infradead.org, luto@amacapital.net,
          x86@kernel.org
In-Reply-To: <20181211222326.14581-4-bp@alien8.de>
References: <20181211222326.14581-4-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/alternatives] x86/alternatives: Add an ALTERNATIVE_3()
 macro
Git-Commit-ID: 71a93c26930471e976dd184ef91931b2a5393afc
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  71a93c26930471e976dd184ef91931b2a5393afc
Gitweb:     https://git.kernel.org/tip/71a93c26930471e976dd184ef91931b2a5393afc
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Mon, 10 Dec 2018 16:17:23 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 16 Jan 2019 12:42:50 +0100

x86/alternatives: Add an ALTERNATIVE_3() macro

Similar to ALTERNATIVE_2(), ALTERNATIVE_3() selects between 3 possible
variants. Will be used for adding RDTSCP to the rdtsc_ordered()
alternatives.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: X86 ML <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181211222326.14581-4-bp@alien8.de
---
 arch/x86/include/asm/alternative.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 373e2baca6ce..4c74073a19cc 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -122,6 +122,16 @@ static inline int alternatives_text_reserved(void *start, void *end)
 		"(" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")), 0x90\n"	\
 	alt_end_marker ":\n"
 
+#define OLDINSTR_3(oldinsn, n1, n2, n3)								\
+	"# ALT: oldinstr3\n"									\
+	"661:\n\t" oldinsn "\n662:\n"								\
+	"# ALT: padding3\n"									\
+	".skip -((" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
+		" - (" alt_slen ")) > 0) * "							\
+		"(" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
+		" - (" alt_slen ")), 0x90\n"							\
+	alt_end_marker ":\n"
+
 #define ALTINSTR_ENTRY(feature, num)					      \
 	" .long 661b - .\n"				/* label           */ \
 	" .long " b_replacement(num)"f - .\n"		/* new instruction */ \
@@ -155,6 +165,19 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_REPLACEMENT(newinstr2, feature2, 2)			\
 	".popsection\n"
 
+#define ALTERNATIVE_3(oldinsn, newinsn1, feat1, newinsn2, feat2, newinsn3, feat3) \
+	OLDINSTR_3(oldinsn, 1, 2, 3)						\
+	".pushsection .altinstructions,\"a\"\n"					\
+	ALTINSTR_ENTRY(feat1, 1)						\
+	ALTINSTR_ENTRY(feat2, 2)						\
+	ALTINSTR_ENTRY(feat3, 3)						\
+	".popsection\n"								\
+	".pushsection .altinstr_replacement, \"ax\"\n"				\
+	ALTINSTR_REPLACEMENT(newinsn1, feat1, 1)				\
+	ALTINSTR_REPLACEMENT(newinsn2, feat2, 2)				\
+	ALTINSTR_REPLACEMENT(newinsn3, feat3, 3)				\
+	".popsection\n"
+
 /*
  * Alternative instructions for different CPU types or capabilities.
  *

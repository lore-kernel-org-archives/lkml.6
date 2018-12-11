Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20283C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6CE2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="H4kconNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6CE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbeLKWXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:23:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46202 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbeLKWXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:23:31 -0500
Received: from zn.tnic (p200300EC2BCD2B0010F6E1EC68D6BA6C.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:10f6:e1ec:68d6:ba6c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 45AFD1EC0BFC;
        Tue, 11 Dec 2018 23:23:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544567010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PbCAF2XcCAjQWK1b11rF+GVjG1oyepoSMGI1yKiTULM=;
        b=H4kconNmMwqaWh5v6kq1qFO5UhvBZX0Pr+YzCwF6Q8jNd7YO0iJWPLCfmC9GeH3SWf+yWS
        7OWmUG8rc5zQwFGROIttfH5lMxkDP4mgbGONDFYApSTS7RXZ0B992hdKOZD3BGfiP6Q8oc
        f+NNkdYG+nEfVMALV81mZS8tBwBw8oU=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH 1/4] x86/alternatives: Add macro comments
Date:   Tue, 11 Dec 2018 23:23:23 +0100
Message-Id: <20181211222326.14581-2-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181211222326.14581-1-bp@alien8.de>
References: <20181211222326.14581-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... so that when one stares at the .s output, one can find her way
around the resulting asm magic.

For example, ALTERNATIVE looks like this now:

          # ALT: oldnstr
  661:
          ...
  662:
          # ALT: padding
  .skip ...
  663:
  .pushsection .altinstructions,"a"

  ...

  .popsection
  .pushsection .altinstr_replacement, "ax"
          # ALT: replacement 1
  6641:
  	...
  6651:
          .popsection

Merge __OLDINSTR() into OLDINSTR(), while at it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/alternative.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index d7faa16622d8..8d38b296a18a 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -87,13 +87,12 @@ static inline int alternatives_text_reserved(void *start, void *end)
 #define alt_total_slen		alt_end_marker"b-661b"
 #define alt_rlen(num)		e_replacement(num)"f-"b_replacement(num)"f"
 
-#define __OLDINSTR(oldinstr, num)					\
+#define OLDINSTR(oldinstr, num)						\
+	"# ALT: oldnstr\n"						\
 	"661:\n\t" oldinstr "\n662:\n"					\
+	"# ALT: padding\n"						\
 	".skip -(((" alt_rlen(num) ")-(" alt_slen ")) > 0) * "		\
-		"((" alt_rlen(num) ")-(" alt_slen ")),0x90\n"
-
-#define OLDINSTR(oldinstr, num)						\
-	__OLDINSTR(oldinstr, num)					\
+		"((" alt_rlen(num) ")-(" alt_slen ")),0x90\n"		\
 	alt_end_marker ":\n"
 
 /*
@@ -109,7 +108,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * additionally longer than the first replacement alternative.
  */
 #define OLDINSTR_2(oldinstr, num1, num2) \
+	"# ALT: oldinstr2\n"									\
 	"661:\n\t" oldinstr "\n662:\n"								\
+	"# ALT: padding2\n"									\
 	".skip -((" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")) > 0) * "	\
 		"(" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")), 0x90\n"	\
 	alt_end_marker ":\n"
@@ -122,8 +123,9 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	" .byte " alt_rlen(num) "\n"			/* replacement len */ \
 	" .byte " alt_pad_len "\n"			/* pad len */
 
-#define ALTINSTR_REPLACEMENT(newinstr, feature, num)	/* replacement */     \
-	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n\t"
+#define ALTINSTR_REPLACEMENT(newinstr, feature, num)	/* replacement */	\
+	"# ALT: replacement " #num "\n"						\
+	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n"
 
 /* alternative assembly primitive: */
 #define ALTERNATIVE(oldinstr, newinstr, feature)			\
-- 
2.19.1


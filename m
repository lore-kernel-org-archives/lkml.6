Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2C9C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9C12084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WZ2lcHep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9C12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeLKWXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:23:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46246 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbeLKWXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:23:33 -0500
Received: from zn.tnic (p200300EC2BCD2B0010F6E1EC68D6BA6C.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:10f6:e1ec:68d6:ba6c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 08EF21EC0C0D;
        Tue, 11 Dec 2018 23:23:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544567012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/mxEqfgkMMmGXETHhDRIDKT6kwIaVl8L4VY0yY4ghDM=;
        b=WZ2lcHepbhGEWdyW2m8JHf+gJ/R2h2YWHEgignzPNJWqchJs88iNwZC95VLdDJGYyiQqUn
        WSz40pUZhBDT4e82mt+fnaMW2DmpQW2SJzAU2OCFL6VlYb9ilQBCvQCUTfq7lul22F92ZB
        WYE4HquQFffpzUdHx4UbT5GyxlbLu+M=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH 3/4] x86/alternatives: Add an ALTERNATIVE_3() macro
Date:   Tue, 11 Dec 2018 23:23:25 +0100
Message-Id: <20181211222326.14581-4-bp@alien8.de>
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

Similar to ALTERNATIVE_2(), ALTERNATIVE_3() selects between 3 possible
variants. Will be used for adding RDTSCP to the rdtsc_ordered()
alternatives.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/alternative.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 8d38b296a18a..f24d111f366b 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -115,6 +115,16 @@ static inline int alternatives_text_reserved(void *start, void *end)
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
@@ -148,6 +158,19 @@ static inline int alternatives_text_reserved(void *start, void *end)
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
-- 
2.19.1


Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C81C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D03721524
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Cz644Ua1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D03721524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbeITDpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:45:46 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43241 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733235AbeITDpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:45:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id z27-v6so6148413edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HfAsVEQefeGww9i9tpc6vNdlydvyaI4WH6N+VrkhAI0=;
        b=Cz644Ua18OnCyh0OmOHrltrTwSyr50atmmxthXFUlNSkUMnACWPcoyyL8fq1e/zIpP
         CHGtqkfBbUXA3WkLKw3OM+tbrCwGxmi2AhMUoPmMhkcTDcHLsoJVQcD1WXEjPetfwT7L
         0ZcwEFaXXRyA51Un6VcO/ufBG5Qv/klrWU+Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HfAsVEQefeGww9i9tpc6vNdlydvyaI4WH6N+VrkhAI0=;
        b=AKA5MUVd8Z9zpVasZx+N1RrO0H0DzQRbX9DfzJXkGaWn73W2WpwySIlsDJyRRl/rYj
         xMKAkDiMwC4zz6r9+qiUhV3DDMLDbbgIBGzYpD9WJBcdOLt1uaUwrp2WkRiTegNitpen
         KYmDseBv7RgeicBySGAbTs6FJwPTPnKhTZuD2vUmagz8tcmo5F0Psu5OZF1Qd0l1r9gF
         SrNyXS34dIgrrmVom1/g7ObLbvhyrH6RNEvfjrx3zLRShr3k4dAZ3LJh/MbCok6j8Kiu
         njKoiTLFaAFQF7NZx5ttQOJkKGYL1GqAEalJYL6E48OiDxMKNX4an/o5nrfQFgHOTG6I
         TT5g==
X-Gm-Message-State: APzg51AEcbmi+6bsICXI0+2PrTfuWPdgjH0U63kHJeeuV3rMo+T7Ybrv
        dPstGD0NaHCXQOuJ+xEMMXTwiw==
X-Google-Smtp-Source: ANB0VdbjtqL7wdzyrRQFv0GW6sLABl62x+3VDx3KyIWJshJYRsNA5iwFnNsYtm5Qh3hMRhewNjIp7Q==
X-Received: by 2002:a50:cd58:: with SMTP id d24-v6mr62278074edj.1.1537394737024;
        Wed, 19 Sep 2018 15:05:37 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-115-161.cgn.ip.fibianet.dk. [5.186.115.161])
        by smtp.gmail.com with ESMTPSA id a9-v6sm2798edi.26.2018.09.19.15.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 15:05:36 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, x86@kernel.org
Subject: [PATCH 21/22] x86: jump_label: introduce ASM_STATIC_KEY_INIT_{TRUE,FALSE}
Date:   Thu, 20 Sep 2018 00:04:43 +0200
Message-Id: <20180919220444.23190-22-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be useful when defining the contents of (a struct containing)
a static key in inline assembly.

Cc: x86@kernel.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/include/asm/jump_label.h | 18 ++++++++++++++++++
 include/linux/jump_label.h        |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 8c0de4282659..2736f7ff6806 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -110,4 +110,22 @@ struct jump_entry {
 
 #endif	/* __ASSEMBLY__ */
 
+#ifdef CONFIG_X86_64
+#define ASM_STATIC_KEY_INIT_TRUE					\
+	 "\t.long 1                              \t# .enabled\n"	\
+	 "\t.long 0                              \t# <padding>\n"	\
+	 "\t.quad "__stringify(__JUMP_TYPE_TRUE)"\t# .type\n"
+#define ASM_STATIC_KEY_INIT_FALSE					\
+	 "\t.long 0                               \t# .enabled\n"	\
+	 "\t.long 0                               \t# <padding>\n"	\
+	 "\t.quad "__stringify(__JUMP_TYPE_FALSE)"\t# .type\n"
+#else
+#define ASM_STATIC_KEY_INIT_TRUE					\
+	 "\t.long 1                              \t# .enabled\n"	\
+	 "\t.long "__stringify(__JUMP_TYPE_TRUE)"\t# .type\n"
+#define ASM_STATIC_KEY_INIT_FALSE					\
+	 "\t.long 0                               \t# .enabled\n"	\
+	 "\t.long "__stringify(__JUMP_TYPE_FALSE)"\t# .type\n"
+#endif
+
 #endif
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 1a0b6f17a5d6..6e98193ae708 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -132,6 +132,8 @@ struct module;
 
 #ifdef HAVE_JUMP_LABEL
 
+#define __JUMP_TYPE_FALSE	0
+#define __JUMP_TYPE_TRUE	1
 #define JUMP_TYPE_FALSE		0UL
 #define JUMP_TYPE_TRUE		1UL
 #define JUMP_TYPE_LINKED	2UL
-- 
2.16.4


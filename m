Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC12AC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9AC214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="cStqMdDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9AC214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJIShN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:37:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42172 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeJIShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:37:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id b7-v6so1311364edd.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SK6y8mbEDUn37gsfEq2QEfc4KllYlfae2KjxIwGnhy0=;
        b=cStqMdDypl71roOta5TwnHB+sEF6cxua632QN2sO09wJsV0DO5aCkpcpKaHNijj6Kz
         BcvKdBHUnRz+vO2HwkNh5NKJgBbREWrPqCbHzJzzBvILqoem/eTXJ6/BEBtlZcJBtdWF
         Vyt/uVWAo91o9oeEMIQxyLeI96Lf45x/N87Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SK6y8mbEDUn37gsfEq2QEfc4KllYlfae2KjxIwGnhy0=;
        b=bVwvWLjHv32znA0mEhYhtndfaoQtczp+WBVxcAL8GbpLd11Rlw0ftxiE+GeuprmSNT
         i0nF27vQBFFVcH72Xp1nBztEsBZbZ82QY1s1gSk7NnJ44nF/tr+oc6Z8MS1jCOyf/I3B
         tPgF9FArp0tF0NiYM985AONyxtr5CL1AxL6kYV+EfObFdLoHZG1rKVHO8WFfrKniNMZb
         DvqLYuGwtqxh4+rehHGzVY64Yd24sN0u8saBa4q0jz4pL5ZLqL756xRY+d6ZmlmVDrXA
         9wjdQSLDoj98tt5C+lRhCTSv2qLbcmVhnjy5ucM/BLfN7/oZCF7tsMksS8aCxoob86mL
         xbJQ==
X-Gm-Message-State: ABuFfojPYU5EVwVXdKa9+IfbhGmgnXiLMx2avwgjoGhJbhj67NjYMBzY
        /GCDKKsXeRUlUtJW9JSyrf4b1g==
X-Google-Smtp-Source: ACcGV61wB9FB0iWSf47yR7MkuT281Su1eidZml9Z6G9f3qcn1/2A/nGrbl8TKFx3rZIUqz0UQHRY5w==
X-Received: by 2002:a17:906:2a88:: with SMTP id l8-v6mr27720938eje.236.1539084041780;
        Tue, 09 Oct 2018 04:20:41 -0700 (PDT)
Received: from prevas-ravi.vestasvisitor.net ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id n23-v6sm3595821eja.41.2018.10.09.04.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 04:20:41 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 21/23] x86: jump_label: introduce ASM_STATIC_KEY_INIT_{TRUE,FALSE}
Date:   Tue,  9 Oct 2018 13:20:11 +0200
Message-Id: <20181009112013.14238-22-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.4.g721af0fda3
In-Reply-To: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20181009112013.14238-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be useful when defining the contents of (a struct containing)
a static key in inline assembly.

Cc: x86@kernel.org
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Jason Baron <jbaron@akamai.com>
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
2.19.1.3.g1d92a00e68


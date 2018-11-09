Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DCEC43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD2D20855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 23:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Cto9fnx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD2D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbeKJIyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:54:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39756 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbeKJIyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:54:12 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so2970168ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 15:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M37KRO1zueMQG666kNlfagGEjdBQCa9CS7UqUCM4Yss=;
        b=Cto9fnx7YjGwUFT7VZWHRLdWqtB+iVrJPJrose7rA9qz0674yOJLzKbA1a1ETFuuzL
         VKQn5PttPpU/KwPL9flcWTu8nwtdAqYdJO5bh/WlZk/B9iEM7fnrGEP7Mm977cEibWOZ
         UbOSQL19k33wRJuYMReY6BrfKHj9K8KdB/lEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M37KRO1zueMQG666kNlfagGEjdBQCa9CS7UqUCM4Yss=;
        b=BbLbn6q1Z/ZmW82pRtZNK+NoopVuOGBdAxLwshOtELv/HMJ/1uA4SdaJh0zIvy3Uhg
         UoXehvqfkaYtbTBUj0y3azj5Z1sxtiJbbVdPRlVOdoHPeVDqwVNf4X2QEZaRVDW095n2
         Z1Dlf+eJprEnX0gWOc30qAzWKYvpTCBpM/acapHZlar86iII1aD1Sop1/KoAg76oJZwA
         0kii/fDdYgfBH+Tz8vCwj2hyeN2H7nxlggEmd8Q0bGYo9jJ+JgFtU3a8YzRaoNylvmwG
         EurqSmFq/NVMFvaxVVamLKMVUzDyh5BEw0Ec90LIeIMPOf+/chL6lkNSsqZw4w2XCffK
         k3IA==
X-Gm-Message-State: AGRZ1gImjZZyTpZAAhwTmWPVkAKhPz7SEhaU1EoW2tlBuirdCiX79gIP
        3fmU1/4fi1OmdWeTgHcukuzF3+OTK43fzg==
X-Google-Smtp-Source: AJdET5eCj/EhkMBQqB0VxMN2aqiNnpNa+XzM/d0YrM3CYNnKuweyddj2Gi+/mXv1si+eudFdS6NMMQ==
X-Received: by 2002:a2e:5816:: with SMTP id m22-v6mr6418163ljb.177.1541805086939;
        Fri, 09 Nov 2018 15:11:26 -0800 (PST)
Received: from prevas-ravi.prevas.se (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id x16sm1584012lff.26.2018.11.09.15.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 15:11:26 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v3 22/23] x86: jump_label: introduce asm macros STATIC_KEY_INIT{,_TRUE,_FALSE}
Date:   Sat, 10 Nov 2018 00:10:20 +0100
Message-Id: <20181109231021.11658-23-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
In-Reply-To: <20181109231021.11658-1-linux@rasmusvillemoes.dk>
References: <20181009112013.14238-1-linux@rasmusvillemoes.dk>
 <20181109231021.11658-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These will be useful when defining the contents of (a struct containing)
a static key in assembly.

Cc: x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/x86/include/asm/jump_label.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index a5fb34fe56a4..f8b5c77ec96d 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -12,6 +12,7 @@
 
 #include <asm/asm.h>
 #include <asm/nops.h>
+#include <asm-generic/jump_label.h>
 
 #ifndef __ASSEMBLY__
 
@@ -64,6 +65,22 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	.popsection
 .endm
 
+.macro STATIC_KEY_INIT enabled:req type:req
+	.long \enabled    # .enabled
+#ifdef CONFIG_X86_64
+	.long 0           # <padding>
+#endif
+	_ASM_PTR \type    # .type
+.endm
+
+.macro STATIC_KEY_INIT_TRUE
+	STATIC_KEY_INIT 1 JUMP_TYPE_TRUE
+.endm
+
+.macro STATIC_KEY_INIT_FALSE
+	STATIC_KEY_INIT 0 JUMP_TYPE_FALSE
+.endm
+
 #endif	/* __ASSEMBLY__ */
 
 #endif
-- 
2.19.1.6.gbde171bbf5


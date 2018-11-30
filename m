Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7854CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3733E2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TLoQF32h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3733E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeK3WpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:45:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50232 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeK3WpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:45:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id 125so5476656wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 03:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2DrRwlNhWmcexXHUFa6mLLJUB8elF/12TyOVEW08kM4=;
        b=TLoQF32hR6MENnF9NLW/wA6P7TTyThwtxte6UePfPsozjdaakL9CRsG0sdAY/uI9US
         zO1jbujBRtunInp3UY+EvWSj9kmBVPJFRWsVJZO/vqn4Y9SpAwCnE1ikFPE9I4wUkQ0L
         OaQlFDHJDwUEFetDyLz5oiVl2RDwuVrbZCu4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2DrRwlNhWmcexXHUFa6mLLJUB8elF/12TyOVEW08kM4=;
        b=UZ41mM7ZZJN/znBVyGml0YU7B0FsXDi4OV5igQFhlzwbkMI9r/3M6bUorDuxFqC/6J
         /AMprQLvhxyX3lO2DDKASh4/HN7I6d0k136R2JazQlBzMII1kb8Ql491mLPO1VrHj3I5
         XXH2n3dzjlZjd9JZcuxnEncI4qloX8Wgrqy8Sawpoi8zLaF0BBZTsLk0mVj5sasm54yx
         NdkdYqA+ITzrx9oFg9qycrBngyJ92eImzjcyfC6EsbM2iwTnMFWvkelE33I6dxAYZpIA
         5ixXIrPmzKqfZFaoffGJdGZwh6xSiKaznXHw/VejKOPt1E7ksgraTL1mgli0aby0jl0t
         oZFA==
X-Gm-Message-State: AA+aEWaC/QZzD30Om9JzskEpw9c9pz8e7kWRhTyB7Q80kVzBPkscfAEv
        5Q2vNwP/q9tYhmVaLz3Fcyvz5g==
X-Google-Smtp-Source: AFSGD/Wi9e4MH+kxqmhOlfAFXYN23J45T2khTsFC6ni0zW7dj0Og914SjwE6KZAHcxQgjooZakkDEg==
X-Received: by 2002:a1c:aa92:: with SMTP id t140mr5144570wme.36.1543577763727;
        Fri, 30 Nov 2018 03:36:03 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:f070:d240:312e:9f99])
        by smtp.gmail.com with ESMTPSA id a12sm4390887wro.18.2018.11.30.03.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 03:36:02 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        catalin.marinas@arm.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] arm64: drop linker script hack to hide __efistub_ symbols
Date:   Fri, 30 Nov 2018 12:35:58 +0100
Message-Id: <20181130113558.15198-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1212f7a16af4 ("scripts/kallsyms: filter arm64's __efistub_
symbols") updated the kallsyms code to filter out symbols with
the __efistub_ prefix explicitly, so we no longer require the
hack in our linker script to emit them as absolute symbols.

Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/image.h | 46 +++++++++++++++------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index a820ed07fb80..8da289dc843a 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -75,16 +75,6 @@
 
 __efistub_stext_offset = stext - _text;
 
-/*
- * Prevent the symbol aliases below from being emitted into the kallsyms
- * table, by forcing them to be absolute symbols (which are conveniently
- * ignored by scripts/kallsyms) rather than section relative symbols.
- * The distinction is only relevant for partial linking, and only for symbols
- * that are defined within a section declaration (which is not the case for
- * the definitions below) so the resulting values will be identical.
- */
-#define KALLSYMS_HIDE(sym)	ABSOLUTE(sym)
-
 /*
  * The EFI stub has its own symbol namespace prefixed by __efistub_, to
  * isolate it from the kernel proper. The following symbols are legally
@@ -94,28 +84,28 @@ __efistub_stext_offset = stext - _text;
  * linked at. The routines below are all implemented in assembler in a
  * position independent manner
  */
-__efistub_memcmp		= KALLSYMS_HIDE(__pi_memcmp);
-__efistub_memchr		= KALLSYMS_HIDE(__pi_memchr);
-__efistub_memcpy		= KALLSYMS_HIDE(__pi_memcpy);
-__efistub_memmove		= KALLSYMS_HIDE(__pi_memmove);
-__efistub_memset		= KALLSYMS_HIDE(__pi_memset);
-__efistub_strlen		= KALLSYMS_HIDE(__pi_strlen);
-__efistub_strnlen		= KALLSYMS_HIDE(__pi_strnlen);
-__efistub_strcmp		= KALLSYMS_HIDE(__pi_strcmp);
-__efistub_strncmp		= KALLSYMS_HIDE(__pi_strncmp);
-__efistub_strrchr		= KALLSYMS_HIDE(__pi_strrchr);
-__efistub___flush_dcache_area	= KALLSYMS_HIDE(__pi___flush_dcache_area);
+__efistub_memcmp		= __pi_memcmp;
+__efistub_memchr		= __pi_memchr;
+__efistub_memcpy		= __pi_memcpy;
+__efistub_memmove		= __pi_memmove;
+__efistub_memset		= __pi_memset;
+__efistub_strlen		= __pi_strlen;
+__efistub_strnlen		= __pi_strnlen;
+__efistub_strcmp		= __pi_strcmp;
+__efistub_strncmp		= __pi_strncmp;
+__efistub_strrchr		= __pi_strrchr;
+__efistub___flush_dcache_area	= __pi___flush_dcache_area;
 
 #ifdef CONFIG_KASAN
-__efistub___memcpy		= KALLSYMS_HIDE(__pi_memcpy);
-__efistub___memmove		= KALLSYMS_HIDE(__pi_memmove);
-__efistub___memset		= KALLSYMS_HIDE(__pi_memset);
+__efistub___memcpy		= __pi_memcpy;
+__efistub___memmove		= __pi_memmove;
+__efistub___memset		= __pi_memset;
 #endif
 
-__efistub__text			= KALLSYMS_HIDE(_text);
-__efistub__end			= KALLSYMS_HIDE(_end);
-__efistub__edata		= KALLSYMS_HIDE(_edata);
-__efistub_screen_info		= KALLSYMS_HIDE(screen_info);
+__efistub__text			= _text;
+__efistub__end			= _end;
+__efistub__edata		= _edata;
+__efistub_screen_info		= screen_info;
 
 #endif
 
-- 
2.19.1


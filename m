Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18D5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C2E20854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="HJlQr41d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C2E20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeIJK5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 06:57:30 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:48296 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJK5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 06:57:30 -0400
Received: from trochilidae.hsd1.wa.comcast.net (unknown [IPv6:2601:602:8700:fb00:81ae:bc59:4e6c:42ca])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 118775C00D5;
        Mon, 10 Sep 2018 08:05:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1536559507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:references; bh=vgpt+KqQZLMiSkIxd+n6bYFPukVKIl0ExLwl3OCRYTA=;
        b=HJlQr41dJMNCDP4r0yyPCChE6k4FJkznQMka8zbDXcZLUm+qZVHwJZXrIsBLVbY6t5Sfbo
        TEaLh0wYDWoKCGycC16MgaqiadnRtxR5fatC+s0sin/zaAOkX36hPxEnlg3G4uHgAEAvvl
        iHyT6yrPvewQJiEjuUNV/RQVq77hZWY=
From:   Stefan Agner <stefan@agner.ch>
To:     torvalds@linux-foundation.org, ndesaulniers@google.com
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        tglx@linutronix.de, mingo@kernel.org, aryabinin@virtuozzo.com,
        will.deacon@arm.com, linux@rasmusvillemoes.dk, dwmw@amazon.co.uk,
        paullawrence@google.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH] include/linux/compiler-clang.h: define __naked
Date:   Sun,  9 Sep 2018 23:04:55 -0700
Message-Id: <20180910060455.20409-1-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM32 arch code uses the __naked attribute. This has previously been
defined in include/linux/compiler-gcc.h, which is no longer included
for Clang. Define __naked for Clang. Conservatively add all attributes
previously used (and supported by Clang).

This fixes compile errors when building ARM32 using Clang:
  arch/arm/mach-exynos/mcpm-exynos.c:193:13: error: variable has incomplete type 'void'
  static void __naked exynos_pm_power_up_setup(unsigned int affinity_level)
              ^

Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 include/linux/compiler-clang.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index b1ce500fe8b3..a593e3ac0720 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -23,6 +23,12 @@
 
 #define __no_sanitize_address __attribute__((no_sanitize("address")))
 
+/*
+ * ARM32 is currently the only user of __naked supported by Clang. Follow
+ * gcc: Do not trace naked functions and make sure they don't get inlined.
+ */
+#define __naked __attribute__((naked)) noinline notrace
+
 /*
  * Not all versions of clang implement the the type-generic versions
  * of the builtin overflow checkers. Fortunately, clang implements
-- 
2.18.0


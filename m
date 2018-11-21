Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7204CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FEC206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="spSqPFU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FEC206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbeKVFuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732351AbeKVFqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:46:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 452FC214D9;
        Wed, 21 Nov 2018 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827430;
        bh=nPDLVY1T9PKl7LayrFyTe3iJypB2hvPysZmhLJu4kkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=spSqPFU+0s0Hz6PrLGke/8EFxxRZ7Dk9WmEW7uWW6SDk/ShrfRVHwTatuLjWct2WC
         Gww5XNIgtAeF75s7ICieEROC0hBnhg4s2rjg+nWT1/3gns1Syj4CC6uvsPBOPdNh0o
         PZx12isAEvSAtMuuy6bK3XJ/ZvTiOQOLxnKK5vdI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Davidson <md@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Bernhard.Rosenkranzer@linaro.org,
        Greg Hackmann <ghackmann@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 27/59] x86/boot: #undef memcpy() et al in string.c
Date:   Wed, 21 Nov 2018 20:06:42 +0100
Message-Id: <20181121183509.323347749@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Davidson <md@google.com>

commit 18d5e6c34a8eda438d5ad8b3b15f42dab01bf05d upstream.

undef memcpy() and friends in boot/string.c so that the functions
defined here will have the correct names, otherwise we end up
up trying to redefine __builtin_memcpy() etc.

Surprisingly, GCC allows this (and, helpfully, discards the
__builtin_ prefix from the function name when compiling it),
but clang does not.

Adding these #undef's appears to preserve what I assume was
the original intent of the code.

Signed-off-by: Michael Davidson <md@google.com>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: H. Peter Anvin <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bernhard.Rosenkranzer@linaro.org
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20170724235155.79255-1-mka@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/boot/string.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -16,6 +16,15 @@
 #include "ctype.h"
 #include "string.h"
 
+/*
+ * Undef these macros so that the functions that we provide
+ * here will have the correct names regardless of how string.h
+ * may have chosen to #define them.
+ */
+#undef memcpy
+#undef memset
+#undef memcmp
+
 int memcmp(const void *s1, const void *s2, size_t len)
 {
 	bool diff;



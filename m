Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2334C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CA12146F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgCRal6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CA12146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeKZVsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:48:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbeKZVsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:48:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5F9820817;
        Mon, 26 Nov 2018 10:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229694;
        bh=TQe/gUsa1wS3vGYhqPCqcKA0JrpgvSD7X0+iqh/J1V4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgCRal6BNR8u5DnfuvgbLJfb9vFiak9LqAofOZZ0OFUtSjI0+UW60TekZ44yb+bk7
         x4U77m3aE0qpzp0Y0iUOY1EisyktBAEOIal6/evJb14hIgGOKZC4UZgBBHr7uJ0shY
         o4+aP7j45N0E/LiJN/qxQ7Gee1ztQQ0CdsyDytO4=
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
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 35/70] x86/boot: #undef memcpy() et al in string.c
Date:   Mon, 26 Nov 2018 11:50:50 +0100
Message-Id: <20181126105050.147832290@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
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
 	u8 diff;



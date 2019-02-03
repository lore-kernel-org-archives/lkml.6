Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3683C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5E12177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 19:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RHobQ4AH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfBCTYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 14:24:10 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41573 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfBCTYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 14:24:10 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so8713264lfj.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 11:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3hDt5xTqcJPcfr0Kp5jZD0bpXVuYxvfDk3mD4GAvP5c=;
        b=RHobQ4AHk+jh6VtUCtdz2jdfZ1HIge7zT/iX1uosWx7ocXUbndWtnGP5MTgDQZ2kOK
         Req5LG53uc/TJfcWBFKXcjmY6y/D6EhLUdzoYVGAFs7a5v7RFz1n345jgJ4e6TJbfiAz
         AuQnsbiUckjOItQyN9VoJQ9S67fbvnBjPUX64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3hDt5xTqcJPcfr0Kp5jZD0bpXVuYxvfDk3mD4GAvP5c=;
        b=OlxY4ZCKzfoBo30bCxaeKsfXVsnjw/yQ9eA+HBX1jXt30l/pAHPLEkEQ4en/7CaeXT
         c1BZtGNhil0klZaw92LUP1kFizp5NNtQIXpcFSYwlO42q3EmQjGKHTifgAVENR9PZrt5
         nUkBtNsaL38vtL4AJpHNJOYuL3FgYkELxwEKObb8TCY82tpSrAR4QxLexGhlbBctSnvi
         e3IoZihoaZCcKrnW2z/wutx3860eCm1Tle9KrGsM974S4P54BFWc2b4VX58IhoC0+ykC
         TJCkSNHx8Gjvwm06wbm0UBB6xPvtdC4FcJ1ypKxoY7iIGEziR3T6+3993kQwJcBIIVbQ
         yfaQ==
X-Gm-Message-State: AHQUAuZUzXTshFrK2rmcfpE9qMQzdOqwHKgVQV9EXDjISVTF+EYvWnjI
        hHjC8PCxSA/wF6lJUV7NSXWs+w==
X-Google-Smtp-Source: AHgI3Ib4klAD7yMmWlvF+ZC2s+ewadyShX1feCJ8QYuB37OBnl0JDpuHJ09RA5Ur8tuLdKNowtfuLA==
X-Received: by 2002:ac2:4219:: with SMTP id y25mr1889575lfh.130.1549221848401;
        Sun, 03 Feb 2019 11:24:08 -0800 (PST)
Received: from prevas-ravi.prevas.se (77.241.141.140.bredband.3.dk. [77.241.141.140])
        by smtp.gmail.com with ESMTPSA id b81-v6sm2406628ljb.7.2019.02.03.11.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 11:24:07 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] build_bug.h: add wrapper for _Static_assert
Date:   Sun,  3 Feb 2019 20:24:00 +0100
Message-Id: <20190203192401.29170-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUILD_BUG_ON() is a little annoying, since it cannot be used outside
function scope. So one cannot put assertions about the sizeof() a
struct next to the struct definition, but has to hide that in some
more or less arbitrary function.

Since gcc 4.6 (which is now also the required minimum), there is
support for the C11 _Static_assert in all C modes, including gnu89. So
add a simple wrapper for that.

_Static_assert() requires a message argument, which is usually quite
redundant (and I believe that bug got fixed at least in newer C++
standards), but we can easily work around that with a little macro
magic, making it optional.

For example, adding

  static_assert(sizeof(struct printf_spec) == 8);

in vsprintf.c and modifying that struct to violate it, one gets

./include/linux/build_bug.h:78:41: error: static assertion failed: "sizeof(struct printf_spec) == 8"
 #define __static_assert(expr, msg, ...) _Static_assert(expr, "" msg "")

godbolt.org suggests that _Static_assert() has been support by clang
since at least 3.0.0.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/build_bug.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index faeec7433aab..4bf9ba847b44 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -58,4 +58,23 @@
  */
 #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
 
+/**
+ * static_assert - check integer constant expression at build time
+ *
+ * static_assert() is a wrapper for the C11 _Static_assert, with a
+ * little macro magic to make the message optional (defaulting to the
+ * stringification of the tested expression).
+ *
+ * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
+ * scope, but requires the expression to be an integer constant
+ * expression (i.e., it is not enough that __builtin_constant_p() is
+ * true for expr).
+ *
+ * Also note that BUILD_BUG_ON() fails the build if the condition is
+ * true, while static_assert() fails the build if the expression is
+ * false.
+ */
+#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
+#define __static_assert(expr, msg, ...) _Static_assert(expr, "" msg "")
+
 #endif	/* _LINUX_BUILD_BUG_H */
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeBVAVY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 19:21:24 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33058 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeBVAVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 19:21:22 -0500
X-Google-Smtp-Source: AH8x226hbbuRmzc20tiMiYbGaW55BS56HemQFCGHdUZi6mlk64TTk6EAqErK+EDy3XOqPX0ndB0k9g==
Date: Wed, 21 Feb 2018 16:21:19 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Patrick McLean <chutzpah@gentoo.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig.h: Include compiler types to avoid missed struct
 attributes
Message-ID: <20180222002119.GA47700@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header files for some structures could get included in such a way
that struct attributes (specifically __randomize_layout from path.h) would
be parsed as variable names instead of attributes. This could lead to
some instances of a structure being unrandomized, causing nasty GPFs, etc.

This patch makes sure the compiler_types.h header is included in
kconfig.h so that we've always got types and struct attributes defined,
since kconfig.h is included from the compiler command line.

Reported-by: Patrick McLean <chutzpah@gentoo.org>
Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Fixes: 3859a271a003 ("randstruct: Mark various structs for randomization")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
I'm sending this anyway, in case Maciej or Patrick want to give it a test...
---
 include/linux/kconfig.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
index fec5076eda91..c5fd4ee776ba 100644
--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -64,4 +64,7 @@
  */
 #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
 
+/* Make sure we always have all types and struct attributes defined. */
+#include <linux/compiler_types.h>
+
 #endif /* __LINUX_KCONFIG_H */
-- 
2.7.4


-- 
Kees Cook
Pixel Security

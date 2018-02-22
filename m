Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeBVA26 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 19:28:58 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40477 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeBVA24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 19:28:56 -0500
X-Google-Smtp-Source: AH8x225tS8DxIBUOyvUMvKgvaMo+rarFupC60gY+IlWAswGA+WbcvoRY9p/lnetc+aTez/cT04afUA==
Date: Wed, 21 Feb 2018 16:28:54 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Patrick McLean <chutzpah@gentoo.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kconfig.h: Include compiler types to avoid missed struct
 attributes
Message-ID: <20180222002854.GA29269@beast>
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
Root-caused-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Fixes: 3859a271a003 ("randstruct: Mark various structs for randomization")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Updated Maciej's tag.
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCYWcw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:32:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37587 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbeCYWcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:32:48 -0400
X-Google-Smtp-Source: AG47ELvEAY/gOIWnBj7vDFotrj4VNE00E5Od4J95cs17M7+JHEz1tbechCGxImjXwKg3GUWKGxlmKA==
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: fix build with future Make
Date: Mon, 26 Mar 2018 00:32:39 +0200
Message-Id: <20180325223239.14778-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried building using a freshly built Make (4.2.1-69-g8a731d1), but the
objtool build broke with

orc_dump.c: In function ‘orc_dump’:
orc_dump.c:106:2: error: ‘elf_getshnum’ is deprecated [-Werror=deprecated-declarations]
  if (elf_getshdrnum(elf, &nr_sections)) {

Turns out that with that new Make, the backslash was not removed, so cpp
didn't see a #include directive, grep found nothing, and
-DLIBELF_USE_DEPRECATED was wrongly put in CFLAGS.

Now, that new Make behaviour is documented in their NEWS file:

  * WARNING: Backward-incompatibility!
    Number signs (#) appearing inside a macro reference or function invocation
    no longer introduce comments and should not be escaped with backslashes:
    thus a call such as:
      foo := $(shell echo '#')
    is legal.  Previously the number sign needed to be escaped, for example:
      foo := $(shell echo '\#')
    Now this latter will resolve to "\#".  If you want to write makefiles
    portable to both versions, assign the number sign to a variable:
      C := \#
      foo := $(shell echo '$C')
    This was claimed to be fixed in 3.81, but wasn't, for some reason.
    To detect this change search for 'nocomment' in the .FEATURES variable.

There are likely other places in the tree that will need fixing, so
cc-ing Kbuild, but with this at least a x86-64 defconfig builds.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 tools/objtool/Makefile         | 2 +-
 tools/scripts/Makefile.include | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index e6acc281dd37..8ae824dbfca3 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -35,7 +35,7 @@ CFLAGS   += -Wall -Werror $(WARNINGS) -fomit-frame-pointer -O2 -g $(INCLUDES)
 LDFLAGS  += -lelf $(LIBSUBCMD)
 
 # Allow old libelf to be used:
-elfshdr := $(shell echo '\#include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
+elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
 CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
 
 AWK = awk
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index dd614463d4d6..495066bafbe3 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -120,3 +120,5 @@ ifneq ($(silent),1)
 	QUIET_UNINST   = @printf '  UNINST   %s\n' $1;
   endif
 endif
+
+pound := \#
-- 
2.15.1

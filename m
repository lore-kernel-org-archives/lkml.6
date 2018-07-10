Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEDBC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE7A208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE7A208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbeGJSeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:34:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48066 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389277AbeGJSea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:34:30 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 43FD5E6B;
        Tue, 10 Jul 2018 18:34:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.14 39/53] Kbuild: fix # escaping in .cmd files for future Make
Date:   Tue, 10 Jul 2018 20:25:15 +0200
Message-Id: <20180710182501.037898694@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

commit 9564a8cf422d7b58f6e857e3546d346fa970191e upstream.

I tried building using a freshly built Make (4.2.1-69-g8a731d1), but
already the objtool build broke with

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

This also fixes up the two make-cmd instances to replace # with $(pound)
rather than with \#. There might very well be other places that need
similar fixup in preparation for whatever future Make release contains
the above change, but at least this builds an x86_64 defconfig with the
new make.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=197847
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 scripts/Kbuild.include         |    5 +++--
 tools/build/Build.include      |    5 +++--
 tools/objtool/Makefile         |    2 +-
 tools/scripts/Makefile.include |    2 ++
 4 files changed, 9 insertions(+), 5 deletions(-)

--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -8,6 +8,7 @@ squote  := '
 empty   :=
 space   := $(empty) $(empty)
 space_escape := _-_SPACE_-_
+pound := \#
 
 ###
 # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
@@ -251,11 +252,11 @@ endif
 
 # Replace >$< with >$$< to preserve $ when reloading the .cmd file
 # (needed for make)
-# Replace >#< with >\#< to avoid starting a comment in the .cmd file
+# Replace >#< with >$(pound)< to avoid starting a comment in the .cmd file
 # (needed for make)
 # Replace >'< with >'\''< to be able to enclose the whole string in '...'
 # (needed for the shell)
-make-cmd = $(call escsq,$(subst \#,\\\#,$(subst $$,$$$$,$(cmd_$(1)))))
+make-cmd = $(call escsq,$(subst $(pound),$$(pound),$(subst $$,$$$$,$(cmd_$(1)))))
 
 # Find any prerequisites that is newer than target or that does not exist.
 # PHONY targets skipped in both cases.
--- a/tools/build/Build.include
+++ b/tools/build/Build.include
@@ -12,6 +12,7 @@
 # Convenient variables
 comma   := ,
 squote  := '
+pound   := \#
 
 ###
 # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
@@ -43,11 +44,11 @@ echo-cmd = $(if $($(quiet)cmd_$(1)),\
 ###
 # Replace >$< with >$$< to preserve $ when reloading the .cmd file
 # (needed for make)
-# Replace >#< with >\#< to avoid starting a comment in the .cmd file
+# Replace >#< with >$(pound)< to avoid starting a comment in the .cmd file
 # (needed for make)
 # Replace >'< with >'\''< to be able to enclose the whole string in '...'
 # (needed for the shell)
-make-cmd = $(call escsq,$(subst \#,\\\#,$(subst $$,$$$$,$(cmd_$(1)))))
+make-cmd = $(call escsq,$(subst $(pound),$$(pound),$(subst $$,$$$$,$(cmd_$(1)))))
 
 ###
 # Find any prerequisites that is newer than target or that does not exist.
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -35,7 +35,7 @@ CFLAGS   += -Wall -Werror $(WARNINGS) -f
 LDFLAGS  += -lelf $(LIBSUBCMD)
 
 # Allow old libelf to be used:
-elfshdr := $(shell echo '\#include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
+elfshdr := $(shell echo '$(pound)include <libelf.h>' | $(CC) $(CFLAGS) -x c -E - | grep elf_getshdr)
 CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
 
 AWK = awk
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -101,3 +101,5 @@ ifneq ($(silent),1)
 	QUIET_INSTALL  = @printf '  INSTALL  %s\n' $1;
   endif
 endif
+
+pound := \#



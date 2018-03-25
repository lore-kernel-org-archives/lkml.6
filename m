Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeCYXJl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 19:09:41 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35375 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbeCYXJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 19:09:36 -0400
X-Google-Smtp-Source: AG47ELskLFl2Z+sGf4JcZx/ag0pTydo9mf4Nlc2ENOKLo360480/vNQ3qAXiUtcIvY5jIacvwpzkZw==
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: Michal Marek <michal.lkml@markovi.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/1] Kbuild: fix # escaping in .cmd files for future Make
Date: Mon, 26 Mar 2018 01:09:16 +0200
Message-Id: <20180325230918.23161-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180325223239.14778-1-linux@rasmusvillemoes.dk>
References: <20180325223239.14778-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest official Make release is 4.2.1 from mid-2016, but the current
git release has this relevant note in the NEWS file:

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

Prepare for whatever future Make release contains that change by fixing
up the .cmd file escaping - without this, make always thinks the command
string has changed and hence rebuilds everything.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
So the previous patch made everything build, but building again
revealed that this central place very much also needed fixing.

 scripts/Kbuild.include | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 065324a8046f..7a926e4688f4 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -10,6 +10,7 @@ space   := $(empty) $(empty)
 space_escape := _-_SPACE_-_
 right_paren := )
 left_paren := (
+pound := \#
 
 ###
 # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
@@ -328,7 +329,7 @@ endif
 # (needed for make)
 # Replace >'< with >'\''< to be able to enclose the whole string in '...'
 # (needed for the shell)
-make-cmd = $(call escsq,$(subst \#,\\\#,$(subst $$,$$$$,$(cmd_$(1)))))
+make-cmd = $(call escsq,$(subst $(pound),\\$(pound),$(subst $$,$$$$,$(cmd_$(1)))))
 
 # Find any prerequisites that is newer than target or that does not exist.
 # PHONY targets skipped in both cases.
-- 
2.15.1

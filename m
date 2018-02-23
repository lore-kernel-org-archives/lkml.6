Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeBWE6t (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 23:58:49 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:26797 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751296AbeBWE6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 23:58:47 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w1N4uwWB024939
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Mark Charlebois <charlebm@gmail.com>,
        Michael Forney <forney@google.com>, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 2/2] kbuild: simplify ld-option implementation
Date: Fri, 23 Feb 2018 13:56:53 +0900
Message-Id: <1519361813-8553-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519361813-8553-1-git-send-email-yamada.masahiro@socionext.com>
References: <1519361813-8553-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, linker options are tested by the coordination of $(CC) and
$(LD) because LD needs some object to link.

As commit 86a9df597cdd ("kbuild: fix linker feature test macros when
cross compiling with Clang") addressed, we need to make sure $(CC)
and $(LD) agree the underlying architecture of the passed object.

This could be a bit complex when we combine tools from different groups.
For example, we can use clang for $(CC), but we still need to rely on
GCC toolchain for $(LD).

So, I was searching a way for standalone testing of linker options.
A trick I found is to use '-v'.  This prints the version string, but
also tests if the given option is recognized.

If a given option is supported,

  $ aarch64-linux-gnu-ld -v --fix-cortex-a53-843419
  GNU ld (Linaro_Binutils-2017.11) 2.28.2.20170706
  $ echo $?
  0

If unsupported,

  $ aarch64-linux-gnu-ld -v --fix-cortex-a53-843419
  GNU ld (crosstool-NG linaro-1.13.1-4.7-2013.04-20130415 - Linaro GCC 2013.04) 2.23.1
  aarch64-linux-gnu-ld: unrecognized option '--fix-cortex-a53-843419'
  aarch64-linux-gnu-ld: use the --help option for usage information
  $ echo $?
  1

Gold works likewise.

  $ aarch64-linux-gnu-ld.gold -v --fix-cortex-a53-843419
  GNU gold (Linaro_Binutils-2017.11 2.28.2.20170706) 1.14
  masahiro@pug:~/ref/linux$ echo $?
  0
  $ aarch64-linux-gnu-ld.gold -v --fix-cortex-a53-999999
  GNU gold (Linaro_Binutils-2017.11 2.28.2.20170706) 1.14
  aarch64-linux-gnu-ld.gold: --fix-cortex-a53-999999: unknown option
  aarch64-linux-gnu-ld.gold: use the --help option for usage information
  $ echo $?
  1

LLD too.

  $ ld.lld -v --gc-sections
  LLD 7.0.0 (http://llvm.org/git/lld.git 4a0e4190e74cea19f8a8dc625ccaebdf8b5d1585) (compatible with GNU linkers)
  $ echo $?
  0
  $ ld.lld -v --fix-cortex-a53-843419
  LLD 7.0.0 (http://llvm.org/git/lld.git 4a0e4190e74cea19f8a8dc625ccaebdf8b5d1585) (compatible with GNU linkers)
  $ echo $?
  0
  $ ld.lld -v --fix-cortex-a53-999999
  ld.lld: error: unknown argument: --fix-cortex-a53-999999
  LLD 7.0.0 (http://llvm.org/git/lld.git 4a0e4190e74cea19f8a8dc625ccaebdf8b5d1585) (compatible with GNU linkers)
  $ echo $?
  1

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Kbuild.include | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 34cbd81..f9c2f07 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -237,9 +237,7 @@ cc-ldoption = $(call try-run-cached,\
 
 # ld-option
 # Usage: LDFLAGS += $(call ld-option, -X)
-ld-option = $(call try-run-cached,\
-	$(CC) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -x c /dev/null -c -o "$$TMPO"; \
-	$(LD) $(LDFLAGS) $(1) "$$TMPO" -o "$$TMP",$(1),$(2))
+ld-option = $(call try-run-cached, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2))
 
 # ar-option
 # Usage: KBUILD_ARFLAGS := $(call ar-option,D)
-- 
2.7.4

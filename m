Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753978AbeDMFOq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 01:14:46 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:54463 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeDMFIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 01:08:15 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w3D56lfs029209
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/30] kconfig: move compiler capability tests to Kconfig
Date: Fri, 13 Apr 2018 14:06:09 +0900
Message-Id: <1523595999-27433-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[Introduction]

The motivation of this work is to move the compiler option tests to
Kconfig from Makefile.  A number of kernel features require the
compiler support.  Enabling such features blindly in Kconfig ends up
with a lot of nasty build-time testing in Makefiles.  If a chosen
feature turns out unsupported by the compiler, what the build system
can do is either to disable it (silently!) or to forcibly break the
build, despite Kconfig has let the user to enable it.

[Major Changes in V3]

This version looks more like Make.

  - Use = operator instead of 'macro' keyword
    to define a user-defined function.

  - 'Recursively expanded variable' is implemented as a side-effect.
     A variable is a function with zero argument.

  - Support simply expanded variable which is defined by := operator

  - Support += operator.
    Probably, this feature will be useful to accumulate compiler flags.
    At least, Clang needs some prerequisite flags such as triplet
    to test other compiler flags.

  - Support $(info ...) and $(warning ...) built-in functions,
    which were useful while I was debugging this.

  - Add documentation

  - Add unit tests

  - Collect helpers to scripts/Kconfig.include

[TODO items]

I have not been able to finish this.  Maybe aiming for v4.18-rc1.

  - The text expansion should be able to defer argument expansion.
    This is necessary if we want to implement $(if ...) built-in function.

  - Error out recursive expansion of itself.
    For example,
        X = $(X)
    refers itself.
    If referenced, the expansion continues eternally.  This must be terminated.

  - More compatible behavior?
    Kconfig works mostly like Make, but there are naive cases
    where the behavior is different.

[Old Versions]

V2:  https://lkml.org/lkml/2018/2/16/610
V1:  https://lkml.org/lkml/2018/2/16/610
RFC: https://lkml.org/lkml/2018/2/8/429



Masahiro Yamada (30):
  gcc-plugins: fix build condition of SANCOV plugin
  kbuild: remove kbuild cache
  kbuild: remove CONFIG_CROSS_COMPILE support
  kconfig: reference environment variables directly and remove 'option
    env='
  kconfig: remove string expansion in file_lookup()
  kconfig: remove string expansion for mainmenu after yyparse()
  kconfig: remove sym_expand_string_value()
  kconfig: add built-in function support
  kconfig: add 'shell' built-in function
  kconfig: replace $(UNAME_RELEASE) with function call
  kconfig: begin PARAM state only when seeing a command keyword
  kconfig: support variable and user-defined function
  kconfig: support simply expanded variable
  kconfig: support append assignment operator
  kconfig: expand lefthand side of assignment statement
  kconfig: add 'info' and 'warning' built-in functions
  Documentation: kconfig: document a new Kconfig macro language
  kconfig: test: test text expansion
  kconfig: show compiler version text in the top comment
  kconfig: add basic helper macros to scripts/Kconfig.include
  stack-protector: test compiler capability in Kconfig and drop AUTO
    mode
  kconfig: add CC_IS_GCC and GCC_VERSION
  kconfig: add CC_IS_CLANG and CLANG_VERSION
  gcov: remove CONFIG_GCOV_FORMAT_AUTODETECT
  kcov: test compiler capability in Kconfig and correct dependency
  gcc-plugins: move GCC version check for PowerPC to Kconfig
  gcc-plugins: test plugin support in Kconfig and clean up Makefile
  gcc-plugins: allow to enable GCC_PLUGINS for COMPILE_TEST
  arm64: move GCC version check for ARCH_SUPPORTS_INT128 to Kconfig
  kbuild: test dead code/data elimination support in Kconfig

 Documentation/kbuild/kconfig-language.txt          |   8 -
 Documentation/kbuild/kconfig-macro-language.txt    | 179 +++++++
 Kconfig                                            |  10 +-
 MAINTAINERS                                        |   3 +-
 Makefile                                           | 113 +---
 arch/Kconfig                                       |  53 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/Makefile                                |   2 -
 arch/powerpc/Kconfig                               |   2 +-
 arch/sh/Kconfig                                    |   4 +-
 arch/sparc/Kconfig                                 |   4 +-
 arch/um/Kconfig.common                             |   4 -
 arch/x86/Kconfig                                   |  15 +-
 arch/x86/um/Kconfig                                |   6 +-
 init/Kconfig                                       |  40 +-
 kernel/gcov/Kconfig                                |  17 +-
 kernel/gcov/Makefile                               |   2 -
 lib/Kconfig.debug                                  |  11 +-
 scripts/Kbuild.include                             | 101 +---
 scripts/Kconfig.include                            |  20 +
 scripts/Makefile.gcc-plugins                       |  91 +---
 scripts/Makefile.kcov                              |  10 +-
 scripts/clang-version.sh                           |  18 +-
 scripts/gcc-plugins/Makefile                       |   1 +
 scripts/gcc-x86_32-has-stack-protector.sh          |   7 +-
 scripts/gcc-x86_64-has-stack-protector.sh          |   5 -
 scripts/kconfig/confdata.c                         |  31 +-
 scripts/kconfig/kconf_id.c                         |   1 -
 scripts/kconfig/lkc.h                              |   4 -
 scripts/kconfig/lkc_proto.h                        |  15 +-
 scripts/kconfig/menu.c                             |   3 -
 scripts/kconfig/preprocess.c                       | 594 +++++++++++++++++++++
 scripts/kconfig/symbol.c                           | 109 ----
 .../kconfig/tests/preprocess/builtin_func/Kconfig  |  19 +
 .../tests/preprocess/builtin_func/__init__.py      |   8 +
 .../tests/preprocess/builtin_func/expected_stderr  |   4 +
 .../tests/preprocess/builtin_func/expected_stdout  |   1 +
 scripts/kconfig/tests/preprocess/escape/Kconfig    |  49 ++
 .../kconfig/tests/preprocess/escape/__init__.py    |   9 +
 .../tests/preprocess/escape/expected_stderr        |  10 +
 scripts/kconfig/tests/preprocess/user_func/Kconfig |  19 +
 .../kconfig/tests/preprocess/user_func/__init__.py |   7 +
 .../tests/preprocess/user_func/expected_stderr     |   5 +
 scripts/kconfig/tests/preprocess/variable/Kconfig  |  39 ++
 .../kconfig/tests/preprocess/variable/__init__.py  |   7 +
 .../tests/preprocess/variable/expected_stderr      |   7 +
 scripts/kconfig/util.c                             |  22 +-
 scripts/kconfig/zconf.l                            |  95 +++-
 scripts/kconfig/zconf.y                            |  48 +-
 49 files changed, 1259 insertions(+), 574 deletions(-)
 create mode 100644 Documentation/kbuild/kconfig-macro-language.txt
 create mode 100644 scripts/Kconfig.include
 create mode 100644 scripts/kconfig/preprocess.c
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/expected_stderr
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
 create mode 100644 scripts/kconfig/tests/preprocess/escape/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/escape/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/escape/expected_stderr
 create mode 100644 scripts/kconfig/tests/preprocess/user_func/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/user_func/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/user_func/expected_stderr
 create mode 100644 scripts/kconfig/tests/preprocess/variable/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/variable/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/variable/expected_stderr

-- 
2.7.4

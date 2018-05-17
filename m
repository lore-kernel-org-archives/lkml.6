Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeEQGS5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 02:18:57 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:24174 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbeEQGSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 02:18:51 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w4H6HbTw002841
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 00/31] kconfig: move compiler capability tests to Kconfig
Date: Thu, 17 May 2018 15:16:39 +0900
Message-Id: <1526537830-22606-1-git-send-email-yamada.masahiro@socionext.com>
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
build, despite Kconfig has let the user to enable it.  By moving the
compiler capability tests to Kconfig, Kconfig entries will be visible
only when they are available.

[Major Changes in V4]

 - In V4, I slightly change the syntax of a function call.
   I chose grammatical consistency and simplicity.
   Anyway, Kconfig is deviating from Make behavior already.

   In v3, a function call looked like this:

      $(func-name arg1,arg2,arg3)

   In v4, a function is invoked like follows:

      $(func-name,arg1,arg2,arg3)

   The difference is that the function name and the first argument
   are separated by a comma.

 - V3 supported single-letter variable like $X.
   V4 dropped it because we do not need multiple ways to do the
   same thing.
   You must always enclose a variable name like $(X).

 - Support lazy argument expansion.  This is necessary for implementing
   'if', 'and', 'or' functions as in Make.

 - Add more built-in functions:
   'if', 'error', 'filename', 'lineno'

 - Error out if a recursive variable references itself eventually.
   For example,  X = $(X)
   ends up with a circular expansion.  It must be terminated
   since the expansion would continue eternally.

 - Update Documentation and unit-tests, accordingly.

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

[Old Versions]

V3:  https://lkml.org/lkml/2018/4/13/37
V2:  https://lkml.org/lkml/2018/2/16/610
V1:  https://lkml.org/lkml/2018/2/16/610
RFC: https://lkml.org/lkml/2018/2/8/429



Masahiro Yamada (31):
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
  kconfig: support user-defined function and recursively expanded
    variable
  kconfig: support simply expanded variable
  kconfig: support append assignment operator
  kconfig: expand lefthand side of assignment statement
  kconfig: add 'info', 'warning', and 'error' built-in functions
  kconfig: add 'if' built-in function
  kconfig: add 'filename' and 'lineno' built-in variables
  kconfig: error out if a recursive variable references itself
  Documentation: kconfig: document a new Kconfig macro language
  kconfig: test: add Kconfig macro language tests
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

 Documentation/kbuild/kconfig-language.txt          |   8 -
 Documentation/kbuild/kconfig-macro-language.txt    | 252 ++++++++
 Kconfig                                            |  10 +-
 MAINTAINERS                                        |   3 +-
 Makefile                                           | 105 +---
 arch/Kconfig                                       |  49 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/Makefile                                |   6 -
 arch/powerpc/Kconfig                               |   2 +-
 arch/sh/Kconfig                                    |   4 +-
 arch/sparc/Kconfig                                 |   4 +-
 arch/um/Kconfig.common                             |   4 -
 arch/x86/Kconfig                                   |  15 +-
 arch/x86/um/Kconfig                                |  10 +-
 init/Kconfig                                       |  40 +-
 kernel/gcov/Kconfig                                |  17 +-
 kernel/gcov/Makefile                               |   2 -
 lib/Kconfig.debug                                  |  11 +-
 scripts/Kbuild.include                             | 101 +---
 scripts/Kconfig.include                            |  27 +
 scripts/Makefile.gcc-plugins                       |  91 +--
 scripts/Makefile.kcov                              |  10 +-
 scripts/clang-version.sh                           |  18 +-
 scripts/gcc-plugins/Makefile                       |   1 +
 scripts/gcc-x86_32-has-stack-protector.sh          |   7 +-
 scripts/gcc-x86_64-has-stack-protector.sh          |   5 -
 scripts/kconfig/confdata.c                         |  33 +-
 scripts/kconfig/kconf_id.c                         |   1 -
 scripts/kconfig/lkc.h                              |   4 -
 scripts/kconfig/lkc_proto.h                        |  15 +-
 scripts/kconfig/menu.c                             |   3 -
 scripts/kconfig/preprocess.c                       | 651 +++++++++++++++++++++
 scripts/kconfig/symbol.c                           | 109 ----
 .../kconfig/tests/preprocess/builtin_func/Kconfig  |  29 +
 .../tests/preprocess/builtin_func/__init__.py      |   8 +
 .../tests/preprocess/builtin_func/expected_stderr  |   7 +
 .../tests/preprocess/builtin_func/expected_stdout  |   1 +
 .../tests/preprocess/circular_expansion/Kconfig    |   3 +
 .../preprocess/circular_expansion/__init__.py      |  10 +
 .../preprocess/circular_expansion/expected_stderr  |   1 +
 scripts/kconfig/tests/preprocess/escape/Kconfig    |  21 +
 .../kconfig/tests/preprocess/escape/__init__.py    |   7 +
 .../tests/preprocess/escape/expected_stderr        |   5 +
 scripts/kconfig/tests/preprocess/variable/Kconfig  |  48 ++
 .../kconfig/tests/preprocess/variable/__init__.py  |   7 +
 .../tests/preprocess/variable/expected_stderr      |   9 +
 scripts/kconfig/util.c                             |  22 +-
 scripts/kconfig/zconf.l                            |  95 ++-
 scripts/kconfig/zconf.y                            |  46 +-
 49 files changed, 1366 insertions(+), 572 deletions(-)
 create mode 100644 Documentation/kbuild/kconfig-macro-language.txt
 create mode 100644 scripts/Kconfig.include
 create mode 100644 scripts/kconfig/preprocess.c
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/expected_stderr
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
 create mode 100644 scripts/kconfig/tests/preprocess/circular_expansion/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/circular_expansion/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/circular_expansion/expected_stderr
 create mode 100644 scripts/kconfig/tests/preprocess/escape/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/escape/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/escape/expected_stderr
 create mode 100644 scripts/kconfig/tests/preprocess/variable/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/variable/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/variable/expected_stderr

-- 
2.7.4

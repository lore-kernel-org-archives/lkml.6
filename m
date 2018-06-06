Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AOcCC6qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9CCCF606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933702AbeFFRT1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:19:27 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:33426 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932977AbeFFRTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:19:23 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w56HIxif018069
X-Nifty-SrcIP: [209.85.217.170]
X-Google-Smtp-Source: ADUXVKL3mwr+TP+5fILF4vAutAJy9pkSve4fvgM7uPjisagtekt/hlkWlx/MjFiayDOgI8Wf+NqC8G+gcIGgIbrJT2Y=
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 7 Jun 2018 02:18:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNASMpvFgue9gZ=6Epq_Skt2pvTVOoT9w=SzA_uGR87KP-w@mail.gmail.com>
Message-ID: <CAK7LNASMpvFgue9gZ=6Epq_Skt2pvTVOoT9w=SzA_uGR87KP-w@mail.gmail.com>
Subject: [GIT PULL 2/2] Kconfig updates for v4.18
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull Kconfig updates for v4.18

(The follow-up cleanup works are not included in this PR.
I will send them later on because I need to wait for
some prerequisite patches from the PowerPC subsystem.)


You will see a conflict in the top-level Makefile.
It should be resolved as follows:
(The correct fix is also available in linux-next)

------------------------------------------
diff --cc Makefile
index 0d5cdaa,defb383..bbc979a
--- a/Makefile
+++ b/Makefile
@@@ -807,7 -806,8 +806,7 @@@ KBUILD_CFLAGS_KERNEL       += $(call cc-optio
  endif

  # arch Makefile may override CC so keep this after arch Makefile is included
- NOSTDINC_FLAGS += -nostdinc -isystem $(call shell-cached,$(CC)
-print-file-name=include)
+ NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 -CHECKFLAGS     += $(NOSTDINC_FLAGS)

  # warn about C99 declaration after statement
  KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
-------------------------------------------




The following changes since commit b04e217704b7f879c6b91222b066983a44a7a09f:

  Linux 4.17-rc7 (2018-05-27 13:01:47 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kconfig-v4.18

for you to fetch changes up to 2ae89c7a82ea9d81a19b4fc2df23bef4b112f24e:

  kconfig: Avoid format overflow warning from GCC 8.1 (2018-06-05
22:07:21 +0900)

----------------------------------------------------------------
Kconfig updates for v4.18

Kconfig now supports new functionality to perform textual substitution.
It has been a while since Linus suggested to move compiler option tests
from makefiles to Kconfig. Finally, here it is. The implementation has
been generalized into a Make-like macro language. Some built-in functions
such as 'shell' are provided. Variables and user-defined functions are
also supported so that 'cc-option', 'ld-option', etc. are implemented as
macros.

Summary:

- refactor package checks for building {m,n,q,g}conf

- remove unused/unmaintained localization support

- remove Kbuild cache

- drop CONFIG_CROSS_COMPILE support

- replace 'option env=' with direct variable expansion

- add built-in functions such as 'shell'

- support variables and user-defined functions

- add helper macros as as 'cc-option'

- add unit tests and a document of the new macro language

- add 'testconfig' to help

- fix warnings from GCC 8.1

----------------------------------------------------------------
Masahiro Yamada (26):
      kbuild: do not display CHK for filechk
      kconfig: refactor Qt package checks for building qconf
      kconfig: refactor GTK+ package checks for building gconf
      kconfig: refactor ncurses package checks for building mconf and nconf
      kbuild: remove kbuild cache
      kbuild: remove CONFIG_CROSS_COMPILE support
      kconfig: reference environment variables directly and remove 'option env='
      kconfig: remove string expansion in file_lookup()
      kconfig: remove string expansion for mainmenu after yyparse()
      kconfig: remove sym_expand_string_value()
      kconfig: make default prompt of mainmenu less specific
      kconfig: add built-in function support
      kconfig: add 'shell' built-in function
      kconfig: replace $(UNAME_RELEASE) with function call
      kconfig: begin PARAM state only when seeing a command keyword
      kconfig: support user-defined function and recursively expanded variable
      kconfig: support simply expanded variable
      kconfig: support append assignment operator
      kconfig: expand lefthand side of assignment statement
      kconfig: add 'info', 'warning-if', and 'error-if' built-in functions
      kconfig: add 'filename' and 'lineno' built-in variables
      kconfig: error out if a recursive variable references itself
      Documentation: kconfig: document a new Kconfig macro language
      kconfig: test: add Kconfig macro language tests
      kconfig: show compiler version text in the top comment
      kconfig: add basic helper macros to scripts/Kconfig.include

Nathan Chancellor (1):
      kconfig: Avoid format overflow warning from GCC 8.1

Petr Vorel (2):
      kconfig: Add testconfig into make help output
      kbuild: Move last word of nconfig help to the previous line

Sam Ravnborg (1):
      kconfig: drop localization support

 Documentation/kbuild/kconfig-language.txt             |   8 -
 Documentation/kbuild/kconfig-macro-language.txt       | 242 +++++++++
 Kconfig                                               |  10 +-
 MAINTAINERS                                           |   3 +-
 Makefile                                              |  10 +-
 arch/sh/Kconfig                                       |   4 +-
 arch/sparc/Kconfig                                    |   4 +-
 arch/um/Kconfig.common                                |   4 -
 arch/x86/Kconfig                                      |   4 +-
 arch/x86/um/Kconfig                                   |  10 +-
 init/Kconfig                                          |  25 +-
 scripts/Kbuild.include                                | 102 +---
 scripts/Kconfig.include                               |  27 +
 scripts/kconfig/.gitignore                            |   4 -
 scripts/kconfig/Makefile                              | 194 ++------
 scripts/kconfig/POTFILES.in                           |  12 -
 scripts/kconfig/check.sh                              |  14 -
 scripts/kconfig/conf.c                                |  51 +-
 scripts/kconfig/confdata.c                            |  39 +-
 scripts/kconfig/gconf-cfg.sh                          |  23 +
 scripts/kconfig/gconf.c                               |  46 +-
 scripts/kconfig/kconf_id.c                            |   1 -
 scripts/kconfig/kxgettext.c                           | 235 ---------
 scripts/kconfig/lkc.h                                 |  19 +-
 scripts/kconfig/lkc_proto.h                           |  15 +-
 scripts/kconfig/lxdialog/check-lxdialog.sh            |  93 ----
 scripts/kconfig/lxdialog/checklist.c                  |   4 +-
 scripts/kconfig/lxdialog/dialog.h                     |   8 +-
 scripts/kconfig/lxdialog/inputbox.c                   |   4 +-
 scripts/kconfig/lxdialog/menubox.c                    |  10 +-
 scripts/kconfig/lxdialog/textbox.c                    |   2 +-
 scripts/kconfig/lxdialog/yesno.c                      |   4 +-
 scripts/kconfig/mconf-cfg.sh                          |  44 ++
 scripts/kconfig/mconf.c                               | 141 +++---
 scripts/kconfig/menu.c                                |  23 +-
 scripts/kconfig/nconf-cfg.sh                          |  44 ++
 scripts/kconfig/nconf.c                               | 148 +++---
 scripts/kconfig/nconf.h                               |   1 -
 scripts/kconfig/preprocess.c                          | 572
++++++++++++++++++++++
 scripts/kconfig/qconf-cfg.sh                          |  25 +
 scripts/kconfig/qconf.cc                              | 104 ++--
 scripts/kconfig/symbol.c                              | 109 -----
 .../tests/no_write_if_dep_unmet/expected_config       |   2 +-
 scripts/kconfig/tests/preprocess/builtin_func/Kconfig |  27 +
 .../kconfig/tests/preprocess/builtin_func/__init__.py |   9 +
 .../tests/preprocess/builtin_func/expected_stderr     |   5 +
 .../tests/preprocess/builtin_func/expected_stdout     |   1 +
 .../tests/preprocess/circular_expansion/Kconfig       |   5 +
 .../tests/preprocess/circular_expansion/__init__.py   |  11 +
 .../preprocess/circular_expansion/expected_stderr     |   1 +
 scripts/kconfig/tests/preprocess/escape/Kconfig       |  44 ++
 scripts/kconfig/tests/preprocess/escape/__init__.py   |   8 +
 .../kconfig/tests/preprocess/escape/expected_stderr   |  10 +
 scripts/kconfig/tests/preprocess/variable/Kconfig     |  53 ++
 scripts/kconfig/tests/preprocess/variable/__init__.py |   8 +
 .../kconfig/tests/preprocess/variable/expected_stderr |   9 +
 scripts/kconfig/util.c                                |  33 +-
 scripts/kconfig/zconf.l                               |  95 +++-
 scripts/kconfig/zconf.y                               |  46 +-
 59 files changed, 1666 insertions(+), 1143 deletions(-)
 create mode 100644 Documentation/kbuild/kconfig-macro-language.txt
 create mode 100644 scripts/Kconfig.include
 delete mode 100644 scripts/kconfig/POTFILES.in
 delete mode 100755 scripts/kconfig/check.sh
 create mode 100755 scripts/kconfig/gconf-cfg.sh
 delete mode 100644 scripts/kconfig/kxgettext.c
 delete mode 100755 scripts/kconfig/lxdialog/check-lxdialog.sh
 create mode 100755 scripts/kconfig/mconf-cfg.sh
 create mode 100644 scripts/kconfig/nconf-cfg.sh
 create mode 100644 scripts/kconfig/preprocess.c
 create mode 100755 scripts/kconfig/qconf-cfg.sh
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/builtin_func/__init__.py
 create mode 100644
scripts/kconfig/tests/preprocess/builtin_func/expected_stderr
 create mode 100644
scripts/kconfig/tests/preprocess/builtin_func/expected_stdout
 create mode 100644 scripts/kconfig/tests/preprocess/circular_expansion/Kconfig
 create mode 100644
scripts/kconfig/tests/preprocess/circular_expansion/__init__.py
 create mode 100644
scripts/kconfig/tests/preprocess/circular_expansion/expected_stderr
 create mode 100644 scripts/kconfig/tests/preprocess/escape/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/escape/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/escape/expected_stderr
 create mode 100644 scripts/kconfig/tests/preprocess/variable/Kconfig
 create mode 100644 scripts/kconfig/tests/preprocess/variable/__init__.py
 create mode 100644 scripts/kconfig/tests/preprocess/variable/expected_stderr


-- 
Best Regards
Masahiro Yamada

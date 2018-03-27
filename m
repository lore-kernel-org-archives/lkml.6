Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx49EG0eJhX9J1m5O8hft54GPxjp4eA3JjIj7K6Z9NFtVTjCG9YvL4WbgXgxap2JOvaduhLtY
ARC-Seal: i=1; a=rsa-sha256; t=1522128624; cv=none;
        d=google.com; s=arc-20160816;
        b=irH+mpN2pS3eDylmL7hUK9kycUiNqm0aajQcyhbjOLpYAstoNy7Bss1gEGLSuq9oLa
         phsNhCpV3p9FKRy394fyKTapNlIdUNca6Ca3AhcDyOqWywc1FASAwFOFJ/aWqbFEasWl
         jPafSFkaYitLYc/UkV3RFhZBuwgWWjtgXOkPE7SJnRYVHYt36rstcp14mxCa4sdwR2OR
         O8M6XdszZBXV19Jb5KilcW/mk9B5O4UnjAgUbHLYD6hwXzw19uyghCi7xETDCxKqzaM/
         pzxxft+2++h1r3BSYhAJ4v3IUxVsnD1VCIGDMfq5MhqPJ4dSOu9HnYt/3vR2H1mevO2h
         4r2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=2joAA3xkYAnslO7dgaCdSypAn5Wb3IebPjDBipuflxs=;
        b=Iu6PtD14THkoJcVT0lEM9idIwhE26CpOpjcvHfIUkbQYbrFFGxrpmNSGJUxy2rG8qq
         kA0ERssk3uhxRhPD5E6Mt4yvNf/hlb4WyP6STPbM9IVPqI9KuRR/a7Wx/ultnEz71V+k
         iLsrLGDKxwdNWa5qpzvzLPeYNKBo0kJ6HzUWd3Y6jLYP6V3iSFwSSjYCEBpdCpah0T8M
         heIZ1raKjukUb4JQIwHz8FUYdKbSzGsPJXLUlDLm2w1AAWUNdMLZyJkrDriFaei7cHth
         6gYUVVUyN417x1zjok/nP14r8hSX69swAWGdhoXeLUo39fgHnq/OmQfk88/38XdrVPwX
         mwjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Bk2tGtZc;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=Bk2tGtZc;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaLj011947
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Magnusson <ulfalizer@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Pitre <nico@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Emese Revfy <re.emese@gmail.com>, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 00/21] kconfig: move compiler capability tests to Kconfig
Date: Tue, 27 Mar 2018 14:29:14 +0900
Message-Id: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067544503943402?=
X-GMAIL-MSGID: =?utf-8?q?1596067544503943402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Here is v2 to start to move compiler capability tests to Kconfig.

V1:
https://lkml.org/lkml/2018/2/16/610

I brushed up the implementation even more.

Major changes for v2:
[1] Environments and functions are expanded in the lexer (zconf.l)
    The parser (zconf.y) receives expanded tokens.  This simplifies
    the implementation.

[2] Implement only one built-in function 'shell'.  This returns
    stdout from the command.  We need something to return 'y' or 'n'.
    This is now implemented as a macro 'success'.

[3] Macros (user-defined function) are defined by 'macro' keyword
    instead of string type symbol.

    ex1) macro success $(shell ($(1) && echo y) || echo n)
    ex2) macro cc-option $(success $CC -Werror $(1) -c -x c /dev/null -o /dev/null)

My plan for v3
--------------

The MW is approaching, but I'd like to make it more lovely if
I have some time.

While I was writing these patches, I noticed a kind of similarity
between Makefile and Kconfig.

Makefile can define variables and functions to do text processing
during the parse phase.  After parsing, it builds up dependency
graph, and moves on to the execution phase.  Then, it generates
objects as needed by checking time-stamps.

[Makefile]

  OBJ := foo.o
  SRC := foo.c
  CC := gcc

  $(OBJ): $(SRC)
            $(CC) -c -o $(OBJ) $(SRC)

[Makefile after text processing]

  foo.o: foo.c
          gcc -c -o foo.o foo.c

Now, we are adding tools for text processing to Kconfig.  Functions
are statically expanded by the lexer.  After all source files are
parsed, Kconfig moves on to the evaluation phase.  Then, users can
tweak symbol values from menus.

So, we should be able to describe Kconfig like follows:

[Kconfig]

   MY_SYMBOL := CC_STACKPROTECTOR
   MY_PROMPT := "Stackprotector"
   success = $(shell ($(1) && echo y) || echo n)
   cc-option = $(success $CC -Werror $(1) -c -x c /dev/null -o /dev/null)

   config $(MY_SYMBOL)
           bool $(MY_PROMPT)
           depends on $(cc-option -fstack-protector)

[Kconfig after text processing]

   config CC_STACKPROTECTOR
           bool "Stackptector"
           depends on y

So, I think it is better to use '=' assignment for defining functions.
I will remove the 'macro' keyword.
Also, support variables.  A variable is a function with no argument.
So, it will be easy to implement it as a sub-set of function feature.
It is better to support two flavors of assignments, '=' and ':=' as well.

Masahiro Yamada (21):
  kbuild: remove kbuild cache
  kbuild: remove CONFIG_CROSS_COMPILE support
  kconfig: move and rename sym_expand_string_value()
  kconfig: reference environments directly and remove 'option env='
    syntax
  kconfig: remove string expansion in file_lookup()
  kconfig: remove string expansion for mainmenu after yyparse()
  kconfig: add function support and implement 'shell' function
  kconfig: replace $UNAME_RELEASE with function call
  kconfig: add 'macro' keyword to support user-defined function
  kconfig: add 'success' and 'cc-option' macros
  stack-protector: test compiler capability in Kconfig and drop AUTO
    mode
  kconfig: show compiler version text in the top comment
  kconfig: add CC_IS_GCC and GCC_VERSION
  kconfig: add CC_IS_CLANG and CLANG_VERSION
  gcov: remove CONFIG_GCOV_FORMAT_AUTODETECT
  kcov: imply GCC_PLUGINS and GCC_PLUGIN_SANCOV instead of select'ing
    them
  gcc-plugins: always build plugins with C++
  gcc-plugins: move GCC version check for PowerPC to Kconfig
  gcc-plugins: test GCC plugin support in Kconfig
  gcc-plugins: enable GCC_PLUGINS for COMPILE_TEST
  arm64: move GCC version check for ARCH_SUPPORTS_INT128 to Kconfig

 Documentation/kbuild/kconfig-language.txt |   8 --
 Kconfig                                   |   4 +-
 Makefile                                  | 103 ++------------
 arch/Kconfig                              |  37 ++---
 arch/arm64/Kconfig                        |   1 +
 arch/arm64/Makefile                       |   2 -
 arch/powerpc/Kconfig                      |   2 +-
 arch/sh/Kconfig                           |   4 +-
 arch/sparc/Kconfig                        |   4 +-
 arch/tile/Kconfig                         |   2 +-
 arch/um/Kconfig.common                    |   4 -
 arch/x86/Kconfig                          |  12 +-
 arch/x86/um/Kconfig                       |   4 +-
 init/Kconfig                              |  44 +++---
 kernel/gcov/Kconfig                       |  17 +--
 kernel/gcov/Makefile                      |   2 -
 lib/Kconfig.debug                         |   7 +-
 scripts/Kbuild.include                    | 101 ++------------
 scripts/Makefile.gcc-plugins              |  95 ++++---------
 scripts/clang-version.sh                  |  24 ++--
 scripts/gcc-plugin.sh                     |  37 +----
 scripts/gcc-plugins/Makefile              |  15 +-
 scripts/gcc-x86_32-has-stack-protector.sh |   7 +-
 scripts/gcc-x86_64-has-stack-protector.sh |   5 -
 scripts/kconfig/confdata.c                |  31 +---
 scripts/kconfig/env.c                     |  95 +++++++++++++
 scripts/kconfig/function.c                | 225 ++++++++++++++++++++++++++++++
 scripts/kconfig/kconf_id.c                |   1 -
 scripts/kconfig/lkc.h                     |   9 +-
 scripts/kconfig/lkc_proto.h               |   7 +-
 scripts/kconfig/menu.c                    |   3 -
 scripts/kconfig/symbol.c                  | 109 ---------------
 scripts/kconfig/util.c                    |  96 ++++++++++---
 scripts/kconfig/zconf.l                   |  51 ++++++-
 scripts/kconfig/zconf.y                   |  35 ++---
 35 files changed, 608 insertions(+), 595 deletions(-)
 create mode 100644 scripts/kconfig/env.c
 create mode 100644 scripts/kconfig/function.c

-- 
2.7.4

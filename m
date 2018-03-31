Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeCaCVK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 22:21:10 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:23350 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeCaCVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 22:21:07 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w2V2L3b7013469
X-Nifty-SrcIP: [209.85.217.174]
X-Google-Smtp-Source: AIpwx4/xdPGYaKEfoZJ732kUUSMe7ODLT5wSqcBjFd0Oyd9NcljpE8BN+wFA8vQgQRVMv5bfhq/IJTdpB719SCXCe00=
MIME-Version: 1.0
In-Reply-To: <20180330222145.GC20025@outlook.office365.com>
References: <1521810279-6282-3-git-send-email-yamada.masahiro@socionext.com>
 <20180330174022.GA8890@outlook.office365.com> <20180330222145.GC20025@outlook.office365.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 31 Mar 2018 11:20:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNARab5mN0F4OrW03v=EsmaRiutLxqR6J1vkybVW=gMvzqw@mail.gmail.com>
Message-ID: <CAK7LNARab5mN0F4OrW03v=EsmaRiutLxqR6J1vkybVW=gMvzqw@mail.gmail.com>
Subject: Re: [03/10] genksyms: generate lexer and parser during build instead
 of shipping
To: Andrei Vagin <avagin@virtuozzo.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-31 7:21 GMT+09:00 Andrei Vagin <avagin@virtuozzo.com>:
> On Fri, Mar 30, 2018 at 10:40:22AM -0700, Andrei Vagin wrote:
>> On Fri, Mar 23, 2018 at 10:04:32PM +0900, Masahiro Yamada wrote:
>> > Now that the kernel build supports flex and bison, remove the _shipped
>> > files and generate them during the build instead.
>> >
>> > There are no more shipped lexer and parser, so I ripped off the rules
>> > in scripts/Malefile.lib that were used for REGENERATE_PARSERS.
>> >
>> > The genksyms parser has ambiguous grammar, which would emit warnings:
>> >
>> >  scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
>> >  scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
>> >
>> > They are normally suppressed, but displayed when W=1 is given.
>> >
>> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > ---
>> >
>> >  scripts/Makefile.lib                 |   24 +-
>> >  scripts/genksyms/Makefile            |   23 +
>> >  scripts/genksyms/lex.lex.c_shipped   | 2291 --------------------------------
>> >  scripts/genksyms/parse.tab.c_shipped | 2394 ----------------------------------
>> >  scripts/genksyms/parse.tab.h_shipped |  119 --
>> >  5 files changed, 26 insertions(+), 4825 deletions(-)
>> >  delete mode 100644 scripts/genksyms/lex.lex.c_shipped
>> >  delete mode 100644 scripts/genksyms/parse.tab.c_shipped
>> >  delete mode 100644 scripts/genksyms/parse.tab.h_shipped
>> >
>> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> > index 2fde810..b7d2c97 100644
>> > --- a/scripts/Makefile.lib
>> > +++ b/scripts/Makefile.lib
>> > @@ -183,14 +183,8 @@ endef
>> >  quiet_cmd_flex = LEX     $@
>> >        cmd_flex = $(LEX) -o$@ -L $<
>> >
>> > -ifdef REGENERATE_PARSERS
>> > -.PRECIOUS: $(src)/%.lex.c_shipped
>> > -$(src)/%.lex.c_shipped: $(src)/%.l
>> > -   $(call cmd,flex)
>> > -endif
>> > -
>> >  .PRECIOUS: $(obj)/%.lex.c
>> > -$(filter %.lex.c,$(targets)): $(obj)/%.lex.c: $(src)/%.l FORCE
>> > +$(obj)/%.lex.c: $(src)/%.l FORCE
>> >     $(call if_changed,flex)
>> >
>> >  # YACC
>> > @@ -198,27 +192,15 @@ $(filter %.lex.c,$(targets)): $(obj)/%.lex.c: $(src)/%.l FORCE
>> >  quiet_cmd_bison = YACC    $@
>> >        cmd_bison = $(YACC) -o$@ -t -l $<
>> >
>> > -ifdef REGENERATE_PARSERS
>> > -.PRECIOUS: $(src)/%.tab.c_shipped
>> > -$(src)/%.tab.c_shipped: $(src)/%.y
>> > -   $(call cmd,bison)
>> > -endif
>> > -
>> >  .PRECIOUS: $(obj)/%.tab.c
>> > -$(filter %.tab.c,$(targets)): $(obj)/%.tab.c: $(src)/%.y FORCE
>> > +$(obj)/%.tab.c: $(src)/%.y FORCE
>> >     $(call if_changed,bison)
>> >
>> >  quiet_cmd_bison_h = YACC    $@
>> >        cmd_bison_h = bison -o/dev/null --defines=$@ -t -l $<
>> >
>> > -ifdef REGENERATE_PARSERS
>> > -.PRECIOUS: $(src)/%.tab.h_shipped
>> > -$(src)/%.tab.h_shipped: $(src)/%.y
>> > -   $(call cmd,bison_h)
>> > -endif
>> > -
>> >  .PRECIOUS: $(obj)/%.tab.h
>> > -$(filter %.tab.h,$(targets)): $(obj)/%.tab.h: $(src)/%.y FORCE
>> > +$(obj)/%.tab.h: $(src)/%.y FORCE
>> >     $(call if_changed,bison_h)
>> >
>> >  # Shipped files
>> > diff --git a/scripts/genksyms/Makefile b/scripts/genksyms/Makefile
>> > index 0ccac51..f4749e8 100644
>> > --- a/scripts/genksyms/Makefile
>> > +++ b/scripts/genksyms/Makefile
>> > @@ -5,9 +5,32 @@ always             := $(hostprogs-y)
>> >
>> >  genksyms-objs      := genksyms.o parse.tab.o lex.lex.o
>> >
>> > +# FIXME: fix the ambiguous grammar in parse.y and delete this hack
>> > +#
>> > +# Suppress shift/reduce, reduce/reduce conflicts warnings
>> > +# unless W=1 is specified.
>> > +ifeq ($(findstring 1,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
>> > +SUPPRESS_BISON_WARNING := 2>/dev/null
>>
>> We have a robot which runs CRIU tests on linux-next.
>> Yesterday it failed with this error:
>>
>>   HOSTCC  scripts/genksyms/genksyms.o
>> make[2]: *** [scripts/genksyms/parse.tab.c] Error 127
>>
>> cripts/genksyms/Makefile:20: recipe for target 'scripts/genksyms/parse.tab.c' failed
>> scripts/Makefile.build:559: recipe for target 'scripts/genksyms' failed
>> Makefile:1073: recipe for target 'scripts' failed
>> make[1]: *** [scripts/genksyms] Error 2
>> make: *** [scripts] Error 2
>> make: *** Waiting for unfinished jobs....
>>
>> https://travis-ci.org/avagin/linux/jobs/360056903
>>
>> From this output, it is very hard to understand what was going wrong.
>
>
> The reason was that bison and fles were not installed, but I think the
> error message should be more clear.
>
>>
>> Thanks,
>> Andrei
>>

Thanks for the report.


OK, I will apply the fix-up attached below.

If bison is not installed, it will fail with clear message.

  HOSTCC  scripts/genksyms/genksyms.o
/bin/sh: 1: bison: not found
make[2]: *** [scripts/genksyms/Makefile:18:
scripts/genksyms/parse.tab.c] Error 127
make[1]: *** [scripts/Makefile.build:559: scripts/genksyms] Error 2
make: *** [Makefile:1073: scripts] Error 2


BTW, without flex and bison, how did you build Kconfig?

Since commit 29c833061c1d8c2d1d23a62e7061561eadd76cdb,
Kconfig requires flex and bison, and this commit is
in Linus' tree for a couple of month.

Without flex and bison, you cannot do even "make *config"
Nobody has ever complaint about this.




diff --git a/scripts/genksyms/Makefile b/scripts/genksyms/Makefile
index aeefd47..7cb3d70 100644
--- a/scripts/genksyms/Makefile
+++ b/scripts/genksyms/Makefile
@@ -10,20 +10,20 @@ genksyms-objs       := genksyms.o parse.tab.o lex.lex.o
 # Suppress shift/reduce, reduce/reduce conflicts warnings
 # unless W=1 is specified.
 ifeq ($(findstring 1,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
-SUPPRESS_BISON_WARNING := 2>/dev/null
-endif

 quiet_cmd_bison_no_warn = $(quet_cmd_bison)
-      cmd_bison_no_warn = $(cmd_bison) $(SUPPRESS_BISON_WARNING)
+      cmd_bison_no_warn = $(YACC) --version >/dev/null; $(cmd_bison)
2>/dev/null

 $(obj)/parse.tab.c: $(src)/parse.y FORCE
        $(call if_changed,bison_no_warn)

 quiet_cmd_bison_h_no_warn = $(quet_cmd_bison_h)
-      cmd_bison_h_no_warn = $(cmd_bison_h) $(SUPPRESS_BISON_WARNING)
+      cmd_bison_h_no_warn = $(YACC) --version >/dev/null;
$(cmd_bison_h) 2>/dev/null

 $(obj)/parse.tab.h: $(src)/parse.y FORCE
        $(call if_changed,bison_h_no_warn)
+
+endif
 # FIXME END

 # -I needed for generated C source (shipped source)


-- 
Best Regards
Masahiro Yamada

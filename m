Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx49uEgeRFKQLP+EXpMR2majO2v+ZA06P/F4HPlh8ceSEPPTTUoXsyUM8eSCYULgfILB3Bs1c
ARC-Seal: i=1; a=rsa-sha256; t=1522338076; cv=none;
        d=google.com; s=arc-20160816;
        b=qmU9lGSJYC0Rqfoni65X8EiP12Ui1bZTAFj9erUE0b6MELr1Stp39eZrZku2LB2hof
         xGxLcBI4G+Vz5BAIWrs8mTMZLvm/bi9BxYLPCe3O4KddacPNhkiaxOzH2ml6UFZJzafT
         mC0OsXjxQPGfxJyZbAqfuDQ+wZGcRFh98Hem2lyYOhtFuSrzNPONuqmu6OQ+PeshX4fK
         +tc99oN3GlwlH1RXsZoLUTz9xem2YLS3o24oiv5482JR9hqdlrBnLu5C9lWSDtrrfq3h
         JFjev3+SYEqGsGJpvzjUIrTw7ueDHmbp7Io8tNwwP2FYIBDzCpFc8ddSwwlOlklgDFyq
         rbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=sHEgxRJnbdWjM7XLzV0WFDDMn1Cv4T0bXNiR5hHMPew=;
        b=GbH2QpbAVw89Z/WWrzrrp65V5ZFNmgh2yet0HEOJRn21FZ7seuYDiR3j0Ri/R5nfgh
         SLC5bljhzrEWganXwASb09wl4+TfV1bp/8+TW9Vy9sKITAPOa5oWyYgx6MEii9xaihoS
         chbwVwBuLh1b7GvJUARJQYkGCFfwu6D9F/jprQWbuJP/K6iq7UWozFPq/fIrnU8QdPtt
         E8TCbGoa2cQ0kgWTefwuRXHo5YJwbkMwDhTBDqWAwsOmcmwNt+TfRzPEDXbT6++1uWOD
         7yeEp9vfYDHPf2leG99cxzvd2PPr35AMYptM1EDsvWuQ8NEMv/1LzzDJvUBv94Dh/s8v
         nD6w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=QTYDZ334;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=QTYDZ334;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2TFerLv018522
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joe Perches <joe@perches.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Rini <trini@konsulko.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: use -fmacro-prefix-map to make __FILE__ a relative path
Date: Fri, 30 Mar 2018 00:40:47 +0900
Message-Id: <1522338047-7128-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596286899451539888?=
X-GMAIL-MSGID: =?utf-8?q?1596287170667063071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The __FILE__ macro is used everywhere in the kernel to locate the file
path printing the log message.  The biggest users of this macro are
WARN_ON() and friends.  If the kernel is built out of tree, this could
be a long absolute path, like this:

  WARNING: CPU: 1 PID: 1 at /path/to/build/directory/arch/arm64/kernel/foo.c:...

This is because Kbuild runs in the objtree instead of the srctree.

Commit 9da0763bdd82 ("kbuild: Use relative path when building in a
subdir of the source tree") mitigated the pain to some extent;
$(srctree) becomes ".." if the objtree is a child of the srctree.

For other cases of out-of-tree build, __FILE__ is still the absolute
path.  It also means the kernel image depends on where it was built.

A brand-new option from GCC solves this problem.

-fmacro-prefix-map=<old>=<new>
  When preprocessing files residing in directory <old>, expand the
  __FILE__ and __BASE_FILE__ macros as if the files resided in
  directory <new> instead.  This can be used to change an absolute
  path to a relative path by using . for <new> which can result in
  more reproducible builds that are location independent.  This
  option also affects __builtin_FILE() during compilation.

If your compiler supports this option, __FILE__ is the relative path
from the root of srctree regardless of O= option.

Please note __FILE__ is always an absolute path for external modules.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I tested this on GCC 8.
(not released yet, but you can get the source code from the trunk.)


Changes in v2:
  - Comment-in the ifeq

 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 7ba478a..5acee54 100644
--- a/Makefile
+++ b/Makefile
@@ -813,6 +813,11 @@ KBUILD_CFLAGS	+= $(call cc-option,-ffunction-sections,)
 KBUILD_CFLAGS	+= $(call cc-option,-fdata-sections,)
 endif
 
+# Change __FILE__ to a relative path from the srctree
+ifneq ($(KBUILD_SRC),)
+KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
+endif
+
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(call shell-cached,$(CC) -print-file-name=include)
 CHECKFLAGS     += $(NOSTDINC_FLAGS)
-- 
2.7.4

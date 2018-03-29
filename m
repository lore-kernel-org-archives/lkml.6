Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx4+fUfiVBnXMKCREN94bEukm/fqRT80Xq7Y4zJtXXaLa/LwaaDtw7Zl9QiuFOuT0yWF+bpmD
ARC-Seal: i=1; a=rsa-sha256; t=1522337817; cv=none;
        d=google.com; s=arc-20160816;
        b=Vt7jyeyJmNbgVOEWPZsRPyAVa4BILLeqBlOynAFxWQ5eBx1O88j/4M+f3xV+Ca0gC8
         n+4IgCvd3VPpiQ40PQ9iQzaRS2OxYOU1673qWAnyTcdiokJ7mBIn9ADJBp2IOfgV+51H
         1YvywEKLO+sZAPDZ1/tw+mmRzcOR39MTg7Vjjsdqel6VxFRcwwY+pF/6IHfUjA3gacdc
         Ct2xIrD0kX0ua7gWW1i1R6Q6H97xkWrJ+7dKGcXEB5Tum8NtWknR9FnQQ15dFd3/TfYK
         o9eKjf2YjcgKT2RI93jQWat3ijm0JAloXxP9rcv5kQchU1BGuiNFkaUzwSpN7ZCqJ/4T
         zb7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=ASsa6c/3FTooetj52xY3Ni62T7HMSHEXBvPm6pDXRdk=;
        b=b/npQDk3fye6ohzTewnXxVDTPff3asDXBpkDMCR3GMM2F+PwCsOsbDWYLPBQ9jqIYC
         gzdmLsDX9yu2HmBgwUxto5ea5jG1GOlxT2C5J8+klvS0kPTw5YDjLap4HMP+MSMGiitL
         0i1rJJb4O69rGcH07H60qyLnKtAhmJa4GgHnLME1WZbR52G2jXjIHxdoLPY9Xt21NUxG
         UxiQArky5NvxN74r+530RH+F8sZrdWIl+EY0mOE+NaCOWZaB8hTbkhy7WehgmHWgxDyQ
         N+yVeImGNl2trN5qcLDYMj4t3mq5uaHbzDbp+NrLMYrX7JfPNg/GndpsoQHi2Vdv6+3i
         uPlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=wwsobpKo;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=wwsobpKo;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w2TFac1c000897
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
Subject: [PATCH] kbuild: use -fmacro-prefix-map to make __FILE__ a relative path
Date: Fri, 30 Mar 2018 00:36:06 +0900
Message-Id: <1522337766-6476-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596286899451539888?=
X-GMAIL-MSGID: =?utf-8?q?1596286899451539888?=
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


 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 7ba478a..d2d44f9 100644
--- a/Makefile
+++ b/Makefile
@@ -813,6 +813,11 @@ KBUILD_CFLAGS	+= $(call cc-option,-ffunction-sections,)
 KBUILD_CFLAGS	+= $(call cc-option,-fdata-sections,)
 endif
 
+#ifneq ($(KBUILD_SRC),)
+# Change __FILE__ to a relative path from the srctree
+KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
+#endif
+
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(call shell-cached,$(CC) -print-file-name=include)
 CHECKFLAGS     += $(NOSTDINC_FLAGS)
-- 
2.7.4

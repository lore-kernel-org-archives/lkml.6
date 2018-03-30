Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx48T7kN6bEAF/dMQnQrHS1MFns9y6ale1p/ge3o+VsgDu42wDrsMc/w2Eh2vBEl78TKxTaHm
ARC-Seal: i=1; a=rsa-sha256; t=1522383372; cv=none;
        d=google.com; s=arc-20160816;
        b=u+CvY3/jkHOBfZQGyv660F1ZwoAjfU7DLdOYIqBP4/oo6jOvtAfa3DHjeomAkVsZXK
         R82TEWnzQIch1TbxXHVqo9s6Sy4uCvizVO7iHK2buRHf8oqJcOq1N5iV//IeF1P97xSi
         TE9yWCpcbwa57jXdEA6ubBL7/CeIlSRQf5eC4ZsFuVC/qjAinspe8RfzYzxhOwopfVjN
         QY0c/zGZX6yxRZQl56q1FnLTEAbLyGSpKbRQhCZSRPGvlodSL0cQ7ipm5P3AMXkYlYwg
         eLy8toE8Y2QQbCNl0drlVYmHeC6vs2pGVo6yDwsKuKm6bstpo6jbfPJk+mkI4qYhdUv7
         0K4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-filter
         :arc-authentication-results;
        bh=O3LwoY7L+nMa/z0pl8tqBGnf4ydtnDcQUBBNN+QbOBg=;
        b=IuQpaFMcUQbdIQnW2L+MJO/zZ+TUH9To1cBurfMxklATxYw3WrGZVQzFJ6IsitEpn0
         Ep0Wm8hWplOM57Owgi+A8siE3G1DRYvoNG6ZT5aEkojW9/A3r4nPws+/7hOS1wv8TkQA
         PsAeVFTSTcfCIQZF5XR2/fgQGA91ZWiwlTmde6Ok3v2RaOwGVYlHpxc3elHXHYKrJu2X
         n2gUw8zNY9zj78zges389NTNmMVF8Ns4H4mun1xh/n5KBZx6fyEPNCrUDUA+O5xSz/8W
         YcGLgRNiAI2jeMq7S8iC8mI1aQAzXTKS+e5RAuhTgeaQ7/JE+wVoeujUU6UokP3mCTOz
         aWVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=wKkwTII4;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.77 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=wKkwTII4;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.77 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w2U4FiLC008081
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Rini <trini@konsulko.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] kbuild: use -fmacro-prefix-map to make __FILE__ a relative path
Date: Fri, 30 Mar 2018 13:15:26 +0900
Message-Id: <1522383326-3880-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596334666549330178?=
X-GMAIL-MSGID: =?utf-8?q?1596334666549330178?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The __FILE__ macro is used everywhere in the kernel to locate the file
printing the log message, such as WARN_ON(), etc.  If the kernel is
built out of tree, this can be a long absolute path, like this:

  WARNING: CPU: 1 PID: 1 at /path/to/build/directory/arch/arm64/kernel/foo.c:...

This is because Kbuild runs in the objtree instead of the srctree,
then __FILE__ is expanded to a file path prefixed with $(srctree)/.

Commit 9da0763bdd82 ("kbuild: Use relative path when building in a
subdir of the source tree") improved this to some extent; $(srctree)
becomes ".." if the objtree is a child of the srctree.

For other cases of out-of-tree build, __FILE__ is still the absolute
path.  It also means the kernel image depends on where it was built.

A brand-new option from GCC, -fmacro-prefix-map, solves this problem.
If your compiler supports it, __FILE__ is the relative path from the
srctree regardless of O= option.  This provides more readable log and
more reproducible builds.

Please note __FILE__ is always an absolute path for external modules.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I tested this on GCC 8.
(not released yet, but you can get the source code from the trunk.)


Changes in v3:
 - It is harmless to always set this option.
   Remove ifneq ifneq ($(KBUILD_SRC),)

Changes in v2:
 - Comment-in the ifeq

 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 7ba478a..83d25c9 100644
--- a/Makefile
+++ b/Makefile
@@ -856,6 +856,9 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
 # Require designated initializers for all marked structures
 KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
 
+# change __FILE__ to the relative path from the srctree
+KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
+
 # use the deterministic mode of AR if available
 KBUILD_ARFLAGS := $(call ar-option,D)
 
-- 
2.7.4

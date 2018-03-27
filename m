Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AIpwx49xeUq9BF5iPnshK/M6JeIyrVKJ4krDfighGD/quDf6BangF4suQlmGPhvWgy6sFT8TiHtM
ARC-Seal: i=1; a=rsa-sha256; t=1522128618; cv=none;
        d=google.com; s=arc-20160816;
        b=mQoGCin0QMIwTbAjwWruUAbD4+1kk6KT/MaTLJZ1vQ71FxS0e7U30sCiCRPTVUnIsD
         JzHCEsFLV9OA/cDnoVzJhdeMVjOLwrCiy66zL0V2z3wVc38DXFkrMd7K33I8+dLZCLND
         pvvPETaiGRz5UxcO1h4d6Wdl4fEqgzl1PrJTJs+aocrqV0rVjTXvg2n8EW7MlTMphJHh
         cXhFm800QXfeUamfDciZbFRKtxRk+DgcWUUYXEb9F3fFqBjN1kvNLSmV1pmytbY35LgP
         LeH1HEkFuGIwdMR5/5WbiEwfRZYQzFcg2dnoMp6jKDnOBnUT3b88nOB6HpSzmNO47G8j
         iYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=6WjQL00enGkVi5o0NmgKQEyQtdjD15+bMKSxvKuX21Q=;
        b=BiDrlXWLkxCR/n6pJj0gZ69kzM/pE3SH06XduAHlLR4ZDT8FX+TNTvx7/zQTkqOkXi
         G92aZSK6m9YxbY6tWLuWIHhne7qRwRDFkx7I/Af7Dazv9H7aJLTDIlQ+F/MIuDdW9zA8
         RamYOo4loW0Qn8HDhPrZEDVzvi/9qI1AsdneVoe3RJ8Kv0jZjBoPw39ToEmMqu/+gBbI
         ffvbwpMl3CfKQMLOhAWF2GSDJjb50Gmd6d5OOxd23ickJMJi3S4Bv6ZVtIdQvDh55BQh
         214JW5bI0AG/+uUNgMFN8DtsHZ3f6vs1EStqCrUZB1nhsIphg96j0udLcw5Jn3++5GS0
         +Jqw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=hWZA5rAg;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=hWZA5rAg;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.76 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w2R5TaLt011947
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/21] kconfig: add 'success' and 'cc-option' macros
Date: Tue, 27 Mar 2018 14:29:24 +0900
Message-Id: <1522128575-5326-11-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
References: <1522128575-5326-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596067537959344954?=
X-GMAIL-MSGID: =?utf-8?q?1596067537959344954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'cc-option' will be the most frequently used macro.  It evaluates to 'y'
if the given argument is supported by the compiler, or 'n' otherwise.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Implement 'success' as a macro

 init/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 0d6fe20..c456030 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -8,6 +8,12 @@ config DEFCONFIG_LIST
 	default ARCH_DEFCONFIG
 	default "arch/$ARCH/defconfig"
 
+# expanded to y if the command exits with 0, n otherwise
+macro success $(shell ($(1) && echo y) || echo n)
+
+# expanded to y if the given compiler flag is supported, n otherwise
+macro cc-option $(success $CC -Werror $(1) -c -x c /dev/null -o /dev/null)
+
 config CONSTRUCTORS
 	bool
 	depends on !UML
-- 
2.7.4

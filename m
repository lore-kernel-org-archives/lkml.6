Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x2274R/unOXOGCezBFaMKaT0P19CXXd/xCNXB8yEtxldjJHJl31rH0tsGvfTZMTZoBtw/IgSa
ARC-Seal: i=1; a=rsa-sha256; t=1517877367; cv=none;
        d=google.com; s=arc-20160816;
        b=jDhWF8jVFNvbkxAGYNeriMdwSuCgi/Bg1jE/tC7YcWVdYc+iMbPAA23QzIVbpD327s
         JORtDc/LbbGtmJq5SNT0lOgXishFHBLSpG5/4slPyAgOewMyu2YBoNd6GkcYmpkzpPX2
         9SoHcpHiMJ+W8A/gcsxcOV7LJjPdhP2+/6Hsd5FvlfowmE8r0zmtVXnC16KMcyLWUNEF
         zIxs1CNw5P08PmyjXGZsf3khxP8uCQ51vOITMddmKtj6FdtTqXdRkz8z9AHosge299ZD
         YPef7pcQ/vbt8rKIWGrkPXJWLwD9Yw7azKWk9g/O03Sd/10NZSGIP2L2KaCl3RmI7EHz
         FBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=GMlbL4n4TZmnicc5N3ATpO1/g+JjbJbNcZa/SH7AxAo=;
        b=IQSw6miPX2Lw7B8pNxneTghklkgTDVX7YGpKlhCaTBVVGjxi46hkABcsXIU33ccsTI
         rC4iNB4jgKV9x2d3BRiqD+PHamvzrBPMuis1CnSphXOkhveRZtGGQQVXFUt67n7wIbPz
         Tm3Qu7Kv7m2OdkZbQK6eACvGX9FiJVRZcF5blkYi3LNQJtbpIwmEvpWXSvAJSc+fwp+6
         elBn4qP2XD276PTBuWAVmd/H/874GiPlcDqB6xV0GBVlcfwV/fN0XaeaxBGIBa/Ht+OE
         ElTyxI/LC++04RP5X0AyYgSj/wVOtjZUKxYxmpDxYDgQjkJ0Ad6SZ6SSEtbyWwhyYPvO
         DneQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=QSclydS1;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=QSclydS1;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w160ZHAh011351
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 02/14] kconfig: do not write choice values when their dependency becomes n
Date: Tue,  6 Feb 2018 09:34:42 +0900
Message-Id: <1517877294-4826-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778627076775?=
X-GMAIL-MSGID: =?utf-8?q?1591609778627076775?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"# CONFIG_... is not set" for choice values are wrongly written into
the .config file if they are once visible, then become invisible later.

  Test case
  ---------

---------------------------(Kconfig)----------------------------
config A
	bool "A"

choice
	prompt "Choice ?"
	depends on A

config CHOICE_B
	bool "Choice B"

config CHOICE_C
	bool "Choice C"

endchoice
----------------------------------------------------------------

---------------------------(.config)----------------------------
CONFIG_A=y
----------------------------------------------------------------

With the Kconfig and .config above,

  $ make config
  scripts/kconfig/conf  --oldaskconfig Kconfig
  *
  * Linux Kernel Configuration
  *
  A (A) [Y/n] n
  #
  # configuration written to .config
  #
  $ cat .config
  #
  # Automatically generated file; DO NOT EDIT.
  # Linux Kernel Configuration
  #
  # CONFIG_A is not set
  # CONFIG_CHOICE_B is not set
  # CONFIG_CHOICE_C is not set

Here,

  # CONFIG_CHOICE_B is not set
  # CONFIG_CHOICE_C is not set

should not be written into the .config file because their dependency
"depends on A" is unmet.

Currently, there is no code that clears SYMBOL_WRITE of choice values.

Clear SYMBOL_WRITE for all symbols in sym_calc_value(), then set it
again after calculating visibility.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/kconfig/symbol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index c9123ed..5d6f6b1 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -371,8 +371,7 @@ void sym_calc_value(struct symbol *sym)
 		sym->curr.tri = no;
 		return;
 	}
-	if (!sym_is_choice_value(sym))
-		sym->flags &= ~SYMBOL_WRITE;
+	sym->flags &= ~SYMBOL_WRITE;
 
 	sym_calc_visibility(sym);
 
@@ -385,6 +384,7 @@ void sym_calc_value(struct symbol *sym)
 		if (sym_is_choice_value(sym) && sym->visible == yes) {
 			prop = sym_get_choice_prop(sym);
 			newval.tri = (prop_get_symbol(prop)->curr.val == sym) ? yes : no;
+			sym->flags |= SYMBOL_WRITE;
 		} else {
 			if (sym->visible != no) {
 				/* if the symbol is visible use the user value
-- 
2.7.4

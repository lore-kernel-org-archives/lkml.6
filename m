Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x225pZNKL7oazda5MNMkyN/qZZKO5Jopzt857aK8OFQh7rVBCvAteKAgUBlfXzuaeksgPnm9n
ARC-Seal: i=1; a=rsa-sha256; t=1518806386; cv=none;
        d=google.com; s=arc-20160816;
        b=Vth8pqy8DpHQuBV0gTwRQxDmw8T/Ku4hwKw2ivAvcn81zmfFjlYU+KtKhvZR9QEaCV
         R5jFORo0amShvdQB9Ch88r/KSn3WilCwuHP5q2yE3Gw8wbHIb7+HmZyTKeaQLWBS0jKS
         CD256AaqL/f9r0LfoOTL41wp3VZN+OveiPWoqFxU9RdptpEi1aDFFuRGauqGz8BbtSyP
         oe0cwV0F6pVGDR7KySRhWWvrhFHUVnsepuvm5990iBOjGEPwMwX68FBsd+yeNFjAo4V/
         yHVDNsb1oSFroB/N1eAZURwKAb0K/VtV7td/ua47rYpNv1slZBg67flpJI35+oRg4SqU
         qcvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=5v0/HrzAJlD9iSgCxrOCACm9vCZI9W7j1VzmKYbwL2Y=;
        b=s4fl0fE7vVrZoqW7Tg/UI1DEnrYO5ou/LDltyfXpv+h4hlNITk4pSkpmbVh+/pQjiu
         TEfXfQ9eUrvN0q3i3zIs4fPtPY0ZDYgzSRqRgu+3D8Q9pV3O3Xj83N5vvyqYe2RB2DBS
         ftfv8fvt34ZwuK/vBvpP205q2GIbxI+DlgGpC4MOec1eNZc2z0pKCTxC2c7rxvc1rNRc
         SeBk1T+e7FyiRLOWXt/ESr1mhDWbHEYdN4VBcYinluX+m7Y1HkNI2/cgYLZiVNnsJElo
         WNWAxao+sQYu0q6/mzIzH39fY3PD6zHEwTcLTYEBvJ7UjNP/phN8D9Q5jE4QjrnSVIjC
         KgNw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=jgNgpdo1;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=jgNgpdo1;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBT7013418
X-Nifty-SrcIP: [125.199.20.195]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/23] kconfig: set SYMBOL_AUTO to the symbol marked with defconfig_list
Date: Sat, 17 Feb 2018 03:38:32 +0900
Message-Id: <1518806331-7101-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583925561685060?=
X-GMAIL-MSGID: =?utf-8?q?1592583925561685060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The 'defconfig_list' is a weird attribute.  If the '.config' is
missing, conf_read_simple() iterates over all visible defaults,
then it uses the first one for which fopen() succeeds.

config DEFCONFIG_LIST
	string
	depends on !UML
	option defconfig_list
	default "/lib/modules/$UNAME_RELEASE/.config"
	default "/etc/kernel-config"
	default "/boot/config-$UNAME_RELEASE"
	default "$ARCH_DEFCONFIG"
	default "arch/$ARCH/defconfig"

However, like other symbols, the first visible default is always
written out to the .config file.  This might be different from what
has been actually used.

For example, on my machine, the third one "/boot/config-$UNAME_RELEASE"
is opened, like follows:

  $ rm .config
  $ make oldconfig 2>/dev/null
  scripts/kconfig/conf  --oldconfig Kconfig
  #
  # using defaults found in /boot/config-4.4.0-112-generic
  #
  *
  * Restart config...
  *
  *
  * IRQ subsystem
  *
  Expose irq internals in debugfs (GENERIC_IRQ_DEBUGFS) [N/y/?] (NEW)

However, the resulted .config file contains the first one since it is
visible:

  $ grep CONFIG_DEFCONFIG_LIST .config
  CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

In order to stop confusing people, prevent this CONFIG option from
being written to the .config file.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I'd like to fix the root case of this weirdness later.
(and other 'option' attributes as well)

But, this series is focusing a more important work in a bigger picture.

For now, I decided to just hide CONFIG_DEFCONFIG_LIST
from the .config file.


 scripts/kconfig/menu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 9922285..36cd3e1 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -212,6 +212,7 @@ void menu_add_option(int token, char *arg)
 			sym_defconfig_list = current_entry->sym;
 		else if (sym_defconfig_list != current_entry->sym)
 			zconf_error("trying to redefine defconfig symbol");
+		sym_defconfig_list->flags |= SYMBOL_AUTO;
 		break;
 	case T_OPT_ENV:
 		prop_add_env(arg);
-- 
2.7.4

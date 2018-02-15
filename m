Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226NCthtf9yDUpOtfhJKOwbW2RwY8NNBf97AP5rYYOK8yqTKc3WrNxKCR3jxb1yCQjLJDV/c
ARC-Seal: i=1; a=rsa-sha256; t=1518708591; cv=none;
        d=google.com; s=arc-20160816;
        b=KbvMLaJSq9Mo9tr2734BfH1MsV7YJqIihj/KB5odPRZGsmsi7qQBD499Yw/qxkYpKD
         rUpczUuPePyjCElAu506INbzxDg6bCnT2TI1hliy5Au2L0rQNJ0z4JeuuslUITGckvYs
         b09GLaQ4f2ryThvIh8vJWNgEQMcYTngWV20OErzeeYG2Pnp2w+YFamAXmGhxMfQ+qsw5
         QLwAh7CzSBvqA6p8RFlv3r9wKSkAYNUSqvs44jyrZh8a61UmbANYHTRu4HlN5sJXFkYC
         Hu23bGQqtYXN6bPH5yqhRLIM8EgG/s09Qz4TyWxGybtmTFzoD+NbmglAnaOwVTE00n/3
         Z+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YRcbWduuinOGebg6MCgtKJPhgDHVXklWFcODhQjf0vE=;
        b=IY6ir0l4ZblzW44uS4CSXqCxAnhjK9SxGUWHCbbhr4dZXMVSgP/PQ8tQgDMaIBXhBk
         lt5vscZtk4w09QUySFhBSHwU+LB3yvBvmKe7dojMSYngUfuCQRWhhOH3b/2ANz83Uvpx
         IZGAZORf7gIWYw2d8Zju57osIPoEFn7umaxJFeRNGo18a91IgZdVkyR2R0+25Arub0iF
         Nci+swxzlEoJhqyJBzMBMgpJpkt6/Q2Bl3es0jFh+CwwT/EJC5iKkG8eVMWgooQoPsk9
         d90KFqkothhlSog1vypxEcTh/icNd5rtvJX28I9iXNhq+oPFApg4jgCe4zmRiwnI0P+K
         T42A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matt Redfearn <matt.redfearn@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	James Hogan <james.hogan@mips.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4.14 001/195] watchdog: indydog: Add dependency on SGI_HAS_INDYDOG
Date: Thu, 15 Feb 2018 16:14:52 +0100
Message-Id: <20180215151705.818993168@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481380463922372?=
X-GMAIL-MSGID: =?utf-8?q?1592481380463922372?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@mips.com>

commit 24f8d233074badd4c18e4dafd2fb97d65838afed upstream.

Commit da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
enabled building the Indy watchdog driver when COMPILE_TEST is enabled.
However, the driver makes reference to symbols that are only defined for
certain platforms are selected in the config. These platforms select
SGI_HAS_INDYDOG. Without this, link time errors result, for example
when building a MIPS allyesconfig.

drivers/watchdog/indydog.o: In function `indydog_write':
indydog.c:(.text+0x18): undefined reference to `sgimc'
indydog.c:(.text+0x1c): undefined reference to `sgimc'
drivers/watchdog/indydog.o: In function `indydog_start':
indydog.c:(.text+0x54): undefined reference to `sgimc'
indydog.c:(.text+0x58): undefined reference to `sgimc'
drivers/watchdog/indydog.o: In function `indydog_stop':
indydog.c:(.text+0xa4): undefined reference to `sgimc'
drivers/watchdog/indydog.o:indydog.c:(.text+0xa8): more undefined
references to `sgimc' follow
make: *** [Makefile:1005: vmlinux] Error 1

Fix this by ensuring that CONFIG_INDIDOG can only be selected when the
necessary dependent platform symbols are built in.

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Suggested-by: James Hogan <james.hogan@mips.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1451,7 +1451,7 @@ config RC32434_WDT
 
 config INDYDOG
 	tristate "Indy/I2 Hardware Watchdog"
-	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST)
+	depends on SGI_HAS_INDYDOG
 	help
 	  Hardware driver for the Indy's/I2's watchdog. This is a
 	  watchdog timer that will reboot the machine after a 60 second

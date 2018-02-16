Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x227PzhqstoKe4CD/uifu6Olqs8khmofvxJ/lLFPUUL7flthgudeVbxQVKkPvKW+VP106DDOB
ARC-Seal: i=1; a=rsa-sha256; t=1518806395; cv=none;
        d=google.com; s=arc-20160816;
        b=J8/X5PYDqadZY+DexbVjMsVNEzTVHi8G4by/AirN2aYvq4/g6Kn//g2qYIMJuauSpX
         L680wWwFyQWRqqOwwEG137FQfRPG2s4anGJfwS0ArSGsZ2nCKj25B1K2LJxPQfp3jZIU
         aOiDYQP3N99RHdV951QH7QNkdArJskexfAG4NwJbAsT7PsNeekh1vZs9c+MlT0HTklNu
         zpYKXWjwTBZkAxqCDpHkeE1PF/qQIM96AAki8yAjqD5HCHKgwl+vDrsoUdcTJc2LvS1N
         QFcPFqjgfJZ6/g9JkmpgjzqKkCstFFdajRdoajv/ePettDbkspFxLI0sp/e3A61YhgzY
         Hx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=uohe4JbWTsHxXCz7M2tIVXCUW+oWNRx1k6t+Og+uw9s=;
        b=F4dwpHHXc49NgENbonbenLwOm7DwKSCa2k6caV+g2HSX8pZilg9I7tvYGGUB/RFwie
         I7ZSJ7UPu13FsdIgoI0aq0ZMMk8K2/g8pYKcA33nJHbIEXHeydSDX8MuP59TTb0S9OTL
         rGx59/kOQdRdVbVEVHCLvcw77dKSjoQvo7A6GFyPtkjTiF3oP3tCCvWeHAnDChkmo5s3
         G+KgJmNsU/JmQZUADi8WbVhIaT5kFgmMDbnAJ2+5yvX9+DB14B0KMYleYAWG8TbQv7uV
         0uQ+ZwE7IB7DvS/3VKzyVWAsPmgzI1VWC4Qmdvo3KhhYwGtRMrX4Tat2mgoFKCdFqtSC
         hybw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=xEiTufgI;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=xEiTufgI;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.74 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w1GIdBTF013418
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
Subject: [PATCH 12/23] kconfig: replace $UNAME_RELEASE with function call
Date: Sat, 17 Feb 2018 03:38:40 +0900
Message-Id: <1518806331-7101-13-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935111958656?=
X-GMAIL-MSGID: =?utf-8?q?1592583935111958656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With 'shell-stdout' supported, we can make it self-contained in
Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile     | 3 +--
 init/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index e9fc7c9..6491404 100644
--- a/Makefile
+++ b/Makefile
@@ -275,8 +275,7 @@ include scripts/Kbuild.include
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
 KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
 KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
-UNAME_RELEASE := $(shell uname --release)
-export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION UNAME_RELEASE
+export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
 
 # SUBARCH tells the usermode build what the underlying arch is.  That is set
 # first, and if a usermode build is happening, the "ARCH=um" on the command
diff --git a/init/Kconfig b/init/Kconfig
index f026a62..837a584 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2,9 +2,9 @@ config DEFCONFIG_LIST
 	string
 	depends on !UML
 	option defconfig_list
-	default "/lib/modules/$UNAME_RELEASE/.config"
+	default "/lib/modules/$(shell-stdout uname --release)/.config"
 	default "/etc/kernel-config"
-	default "/boot/config-$UNAME_RELEASE"
+	default "/boot/config-$(shell-stdout uname --release)"
 	default ARCH_DEFCONFIG
 	default "arch/$ARCH/defconfig"
 
-- 
2.7.4

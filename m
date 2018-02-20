Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x225jOHNVSZ8rA16znPCesenEPbOzpSk9EcNyHOn/2fy4tV5LsGhpqhZ9gc4zk/4aAriAXRcq
ARC-Seal: i=1; a=rsa-sha256; t=1519163054; cv=none;
        d=google.com; s=arc-20160816;
        b=FDqHEk1Pzwkyg64T3v/jICPNa9s+lEzfKzwfHzG03wyLGKqY74axYgvOZPxn0OHFLG
         6RyvrgLclC7h/cA0BNsgpmgsjAcnlekD40qr/B2JH7sfYb+ZaiMQD/TrMEcRuRySZCzM
         6fZmcKYGf+waV3P8FiJ1gBxn1von08Y5E6TesABE5JB9Ev++ZZjufDXuKjJbdF0/XNU1
         8jx1I8KRqqXa6qrmmFT5xs984yqwiFq7ntRJ3EpircqhuYINr8IrfhRq8apxPgqtvpcA
         6++uHBfPL8nYGDMpKbbqLrHbrk8Rp7b6yl1C/8kyilwhWzI9YcOlfOMzOn38OcjginaR
         flYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=udjQ55Skt5crfUmhNKfcOPf39vtLzFbkJb4bouhv7PA=;
        b=pQXCp1lO2+15GW5KcsK4npzDyQwLyBJSbzL9psZirHyx+xPMhbMV1X+wiMHe07a8jx
         wowmXSTiMPHFhBSvAPnYJ3UAWmAcrL7xQyxo2OeyXXnTD9Bdx0fvX+AuQZJcgdhw/WBD
         jqGTjwonnB4AdvrO63UCcZgLYMRxooir6XdUkI2/5FPFbBTU3TWoDApusq6GfFVtLSwX
         dSwyzMw1KignWdl0z11d4VF12D9gF4R8T//KG+QxZco0B2MSCcPWiFfstxmA2kCd3nWW
         k0q+n9KDk+/0UtKhm2/OO0qWDcPVPUunIXfrsTRASltVi9eltbscqcLqGAF1o28AiYhL
         nncw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="176774938"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-rtc@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Joe Perches <joe@perches.com>,
	Mark Salyzyn <salyzyn@android.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 20/21] mk68/mac: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:43:59 +0200
Message-Id: <20180220214400.66749-21-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957919041334939?=
X-GMAIL-MSGID: =?utf-8?q?1592957919041334939?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/m68k/Kconfig.machine | 1 +
 arch/m68k/mac/misc.c      | 8 ++------
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index 64a641467736..620a55da648e 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -26,6 +26,7 @@ config MAC
 	bool "Macintosh support"
 	depends on MMU
 	select MMU_MOTOROLA if MMU
+	select PRINTK_PEXT_TIMEDATE
 	help
 	  This option enables support for the Apple Macintosh series of
 	  computers (yes, there is experimental support now, at least for part
diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 4956edaac926..0002bb0ebbfc 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -673,13 +673,9 @@ int mac_hwclk(int op, struct rtc_time *t)
 		unmktime(now, 0,
 			 &t->tm_year, &t->tm_mon, &t->tm_mday,
 			 &t->tm_hour, &t->tm_min, &t->tm_sec);
-		pr_debug("%s: read %04d-%02d-%-2d %02d:%02d:%02d\n",
-		         __func__, t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
-		         t->tm_hour, t->tm_min, t->tm_sec);
+		pr_debug("%s: read %ptR\n", __func__, t);
 	} else { /* write */
-		pr_debug("%s: tried to write %04d-%02d-%-2d %02d:%02d:%02d\n",
-		         __func__, t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
-		         t->tm_hour, t->tm_min, t->tm_sec);
+		pr_debug("%s: tried to write %ptR\n", __func__, t);
 
 		now = mktime(t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
 			     t->tm_hour, t->tm_min, t->tm_sec);
-- 
2.15.1

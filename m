Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AH8x226FyGRWe20qkwE4BiyRwGdt8dKv+tYt2rGnNNLzj13tnc8aa7CIK54xP0qM3yJAPmb2CPTX
ARC-Seal: i=1; a=rsa-sha256; t=1519163052; cv=none;
        d=google.com; s=arc-20160816;
        b=JKkQPQZ+nqePCDQaLzGvNIhZSDJoe++T6HX+M+52H5/DS0DHPAaEPyRMwP2oCyuZDu
         zhdYwMPmhyqrk4Wx9q/1/5Bhrh93ModCbJVn63hu2KJRZsztgvfffiCuTY4Oh6/nnIkw
         wyv3qOrEsjXxCbjhpRHQIGADJTzk1oTqzSf60YZbBPTXW7sNRF17OWvVnfr/2BC16oD0
         kpc1HJVMEKNaMh0vZ4BAkQF366bfsYmPoecW3ma8yT1gbOKIWzQEEI72AsNX5xYRkHtm
         xLWSRQ7fcb4ImVpYOoiKxFBxisl6xmkxLqghxJR2fKHXEnibOS/DbVqGZlTiA9GLOyMh
         GTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=FTo9srVq/8gdb2gQq1MmnpcFDwIlenGN6uIXKuQqiFs=;
        b=W2lEnQdmDt8Z9Qq6cpZ/k2jPVAJg1P16a7QPYMHUQ6ps0xydDB4RbTFfwCsJqIRC+f
         /3UTF8MjbZdtudFnvI259BzDhIEc8Q6kfFVe4w4736zYztiaBNzN8n7jZlrVtwCQZIgH
         C5H1EZCorBKhlc4a47qC7QOz0EAZXetQrjfG6RhpFOw9SMJ/wj6sWyFoWksLfHL3VeeC
         jtvs6pl17HR+p2rH5YRdXlokgu88nACV436TU4BH26NRxTzQBH/Md/s7DMErgnIPG5bN
         fd6/CJ2lHCt0j3Qf3kfZ98gHj5CQUEtC4DQhcVrezP1hY5VqtTGZDQmgPay19H7PGdv8
         jQAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,541,1511856000";
   d="scan'208";a="31520288"
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
	linux-pm@vger.kernel.org
Subject: [PATCH v2 21/21] PM: Switch to use %ptR
Date: Tue, 20 Feb 2018 23:44:00 +0200
Message-Id: <20180220214400.66749-22-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
References: <20180220214400.66749-1-andriy.shevchenko@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592957916506892727?=
X-GMAIL-MSGID: =?utf-8?q?1592957916506892727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: linux-pm@vger.kernel.org
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/power/trace.c | 4 +---
 kernel/power/Kconfig       | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/trace.c b/drivers/base/power/trace.c
index 1cda505d6a85..b11f47a1e819 100644
--- a/drivers/base/power/trace.c
+++ b/drivers/base/power/trace.c
@@ -118,9 +118,7 @@ static unsigned int read_magic_time(void)
 	unsigned int val;
 
 	mc146818_get_time(&time);
-	pr_info("RTC time: %2d:%02d:%02d, date: %02d/%02d/%02d\n",
-		time.tm_hour, time.tm_min, time.tm_sec,
-		time.tm_mon + 1, time.tm_mday, time.tm_year % 100);
+	pr_info("RTC time: %ptRt, date: %ptRd\n", &time, &time);
 	val = time.tm_year;				/* 100 years */
 	if (val > 100)
 		val -= 100;
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index e880ca22c5a5..f73cecd3b75f 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -220,6 +220,7 @@ config PM_TRACE_RTC
 	depends on PM_SLEEP_DEBUG
 	depends on X86
 	select PM_TRACE
+	select PRINTK_PEXT_TIMEDATE
 	---help---
 	This enables some cheesy code to save the last PM event point in the
 	RTC across reboots, so that you can debug a machine that just hangs
-- 
2.15.1

Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526288233; cv=none;
        d=google.com; s=arc-20160816;
        b=Bc9OV15Zht3WZMUzEpVXiDedMPn3stfxLqgkVdlQDlIhP8MjbDyTI2gq/8rNjLylKG
         AhhzFBuCliR0tL5L0JtOm1UniZfz7mbXYLXEEculXQAfoCuN7kfElJkCk8M4vEIwK3IT
         +A6gys8aZMtQbteGhzOU5iBY6GVpggWeytzpm7OD/y+vwmP3WayiDx/fYFb3i2QJrgVw
         GKs58fUGZbOas6EMJEDIbEqkvCmnoLiw8g7dNep3jMs9L9mCJ6dxU7NF1iLAGQ0oO9u+
         8nloa9/H+Nf8bsqUeNlmJKsSjx6a2VMLrJCdFp5s644phekNbfPv4VR8t+G3QqKTygrl
         wdSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=NPxlDCjOk7gpJ7ywY/IgHfUOCSQRmo1KxQ6z9d2/zdU=;
        b=sEH3CITiSh3HS5nU4M49/aZcXPFJOWrh2nfcxBHIF4ftwpwW9euvmWj6Bu17xrerzg
         SCxytMw8TtP+m4XCfUYenjSFzko3ix/HHql8hnjN9l59pm8ErWm8y+/C+VXo8tJZAMsJ
         t0/xde834lhki1IHPTLeoL/Y/cl5KbjshMs/52fUAaQVUXnRLt4bje0Lyjd9KfOqq3ZW
         OjynqaO6kkJmdIgJHENeWOZWV9Gpm+CLMz6FAqXGe6U9oCa0Y11zNLukna6+LDwAYNuV
         XEz0S5oXPTlpGm3C2/meLQE4DCzi8fy25iVJv2wgxS3nr/YIprUNXrNP8gFFwstFqBzt
         rMpw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=UgkJ7DPr;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=UgkJ7DPr;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpVkW/3+zxblhObhwqITAxggXU+3pn3SN4lD/8SKbxsncUQkxkzBY3Df9n3WyUWJnvuXOuXdw==
From: Baolin Wang <baolin.wang@linaro.org>
To: tglx@linutronix.de,
	john.stultz@linaro.org,
	daniel.lezcano@linaro.org,
	arnd@arndb.de,
	tony@atomide.com,
	aaro.koskinen@iki.fi,
	linux@armlinux.org.uk,
	mark.rutland@arm.com,
	marc.zyngier@arm.com
Cc: baolin.wang@linaro.org,
	broonie@kernel.org,
	paulmck@linux.vnet.ibm.com,
	mlichvar@redhat.com,
	rdunlap@infradead.org,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pombredanne@nexb.com,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	heiko@sntech.de,
	linus.walleij@linaro.org,
	viresh.kumar@linaro.org,
	mingo@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	douly.fnst@cn.fujitsu.com,
	len.brown@intel.com,
	rajvi.jingar@intel.com,
	alexandre.belloni@bootlin.com,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [RFC PATCH 07/10] clocksource: timer-ti-32k: Register the persistent clock
Date: Mon, 14 May 2018 16:55:33 +0800
Message-Id: <353359ad77f87c01e9cc5a5fce382dbf6e9318e6.1526285602.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429210432259974?=
X-GMAIL-MSGID: =?utf-8?q?1600429210432259974?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since the 32K counter is always available, then we can register the
persistent clock to compensate the suspend time for the OS time.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/Kconfig        |    1 +
 drivers/clocksource/timer-ti-32k.c |    4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 884719c..ed19757 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -262,6 +262,7 @@ config CLKSRC_TI_32K
 	bool "Texas Instruments 32.768 Hz Clocksource" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK
 	select TIMER_OF if OF
+	select PERSISTENT_CLOCK
 	help
 	  This option enables support for Texas Instruments 32.768 Hz clocksource
 	  available on many OMAP-like platforms.
diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index 880a861..353ff9d 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -41,6 +41,7 @@
 #include <linux/clocksource.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/persistent_clock.h>
 
 /*
  * 32KHz clocksource ... always available, on pretty most chips except
@@ -120,6 +121,9 @@ static int __init ti_32k_timer_init(struct device_node *np)
 	}
 
 	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
+	persistent_clock_init_and_register(omap_32k_read_sched_clock,
+					   CLOCKSOURCE_MASK(32), 32768, 0);
+
 	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
 
 	return 0;
-- 
1.7.9.5

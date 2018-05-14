Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526288243; cv=none;
        d=google.com; s=arc-20160816;
        b=0okxR9VqmXlWy6tgClD8dMi2skN2Mnhz5wY0UELmavpNeFMHS6TC9n/foGhlNgdPq4
         xDsiYzDMNdLwoeSWjF7yKyotwv1V2agCY4duvz6zi1uMdfNh6NgxD/cIfqJkncrm7XJE
         UX358Gxvgnb7P9TcaPK67uAs+hPFIF3Lx7DulX+E/72AYxCYDvs3K1/PAJ3TdFhAqCcM
         Ks8uKUI5kyhVrXHjBHzwQoD6N0vdS8acVH79lYjzoDBIg3CHtQGZyjAv+7V9Bb8dXDXW
         R0SdUVAUPbr7z97tO6r29o3zkB62lumaTBOKzWAnNCkFr0K2UuQuz3SoS17yTG4O4A7M
         mMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=8amEPfYJHI7TtKp1hNI+LYrHxqnx9lRqWmjNtNhRjpI=;
        b=DycBcRX/IgJkyovXqdc5Pu5RyW1IKbXt68oh+3Zsot3a4CYd90d7tXrvrO6T8g1rUm
         CFEtrK252lftSSEQ0QMjeDXdo9e9ijGhR79MYHC1O6kc3NpF6NT8mCjis1NVMVXN0ujP
         jxCLYckt8jw22DsesBhN/oJX5kgRRsulpkMMhjdmd+rtpsKf1sbHG9aCD9E+y02CGMUA
         SnqMq0ZZlEz+gKNyD/4WLgTsKkt8bqXEL8AmPekFhY3NKE7PWGMATyA0J7BEbRrVsyx1
         +YYYjl0nV0GlJINlKYYs/P9EKKoVurJFmFWJ8XGjZrRlKfIx0cNYmCDLTSUSNJKK29xR
         7Peg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=W92MFS1W;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=W92MFS1W;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZq8tgE0wF3czYET6/Zih5Qllbfdt/FTuCbyjc8WSph6/5brUQNNgJaKPVJWOt0TTNRSQrDUeA==
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
Subject: [RFC PATCH 08/10] clocksource: time-pistachio: Register the persistent clock
Date: Mon, 14 May 2018 16:55:34 +0800
Message-Id: <e923209285df7043bd52c136ba85507891b4b059.1526285602.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429220531048736?=
X-GMAIL-MSGID: =?utf-8?q?1600429220531048736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since the timer on pistachio platform is always available, we can
register it as one persistent clock to compensate the suspend time
for the OS time.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/Kconfig          |    1 +
 drivers/clocksource/time-pistachio.c |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index ed19757..b45be75 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -255,6 +255,7 @@ config CLKSRC_PISTACHIO
 	bool "Clocksource for Pistachio SoC" if COMPILE_TEST
 	depends on HAS_IOMEM
 	select TIMER_OF
+	select PERSISTENT_CLOCK
 	help
 	  Enables the clocksource for the Pistachio SoC.
 
diff --git a/drivers/clocksource/time-pistachio.c b/drivers/clocksource/time-pistachio.c
index a2dd85d..5c3eb71 100644
--- a/drivers/clocksource/time-pistachio.c
+++ b/drivers/clocksource/time-pistachio.c
@@ -20,6 +20,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/persistent_clock.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/sched_clock.h>
@@ -212,6 +213,8 @@ static int __init pistachio_clksrc_of_init(struct device_node *node)
 
 	raw_spin_lock_init(&pcs_gpt.lock);
 	sched_clock_register(pistachio_read_sched_clock, 32, rate);
+	persistent_clock_init_and_register(pistachio_read_sched_clock,
+					   CLOCKSOURCE_MASK(32), rate, 0);
 	return clocksource_register_hz(&pcs_gpt.cs, rate);
 }
 TIMER_OF_DECLARE(pistachio_gptimer, "img,pistachio-gptimer",
-- 
1.7.9.5

Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C9EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A11220665
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 17:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A11220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbeK2E4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:56:49 -0500
Received: from shell.v3.sk ([90.176.6.54]:39489 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbeK2E4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 23:56:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3C77399C7E;
        Wed, 28 Nov 2018 18:54:18 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zI2nU5Q9Rce1; Wed, 28 Nov 2018 18:53:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 78FE7999FD;
        Wed, 28 Nov 2018 18:53:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id smAYdk7ILxdn; Wed, 28 Nov 2018 18:53:38 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B2A0399994;
        Wed, 28 Nov 2018 18:53:32 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Pavel Machek <pavel@ucw.cz>, James Cameron <quozl@laptop.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v4 16/20] ARM: mmp/mmp2: dt: enable the clock
Date:   Wed, 28 Nov 2018 18:53:20 +0100
Message-Id: <20181128175324.163202-17-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181128175324.163202-1-lkundrak@v3.sk>
References: <20181128175324.163202-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device-tree booted MMP2 needs to enable the timer clock, otherwise
it would stop ticking when the boot finishes.

It can also use the clock rate from the clk, the non-DT boards need to
keep using the hardcoded rates.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v2:
- Wording improvement, whitespace fix and an ack from Pavel

Changes since v1:
- Made the clock optional, to keep compatibility with DTs without it

 arch/arm/mach-mmp/common.h |  2 +-
 arch/arm/mach-mmp/mmp2.c   |  2 +-
 arch/arm/mach-mmp/pxa168.c |  2 +-
 arch/arm/mach-mmp/time.c   | 32 ++++++++++++++++++++------------
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index 7e284d9c429f..5ac2851ef5d3 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -2,7 +2,7 @@
 #include <linux/reboot.h>
 #define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
=20
-extern void timer_init(int irq);
+extern void timer_init(int irq, unsigned long rate);
=20
 extern void __init mmp_map_io(void);
 extern void mmp_restart(enum reboot_mode, const char *);
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index b670fafedeac..8717de7d0757 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -134,7 +134,7 @@ void __init mmp2_timer_init(void)
 	clk_rst =3D APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(1);
 	__raw_writel(clk_rst, APBC_TIMERS);
=20
-	timer_init(IRQ_MMP2_TIMER1);
+	timer_init(IRQ_MMP2_TIMER1, 6500000);
 }
=20
 /* on-chip devices */
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 0f5f16fb8c66..77a358165a56 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -79,7 +79,7 @@ void __init pxa168_timer_init(void)
 	/* 3.25MHz, bus/functional clock enabled, release reset */
 	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
=20
-	timer_init(IRQ_PXA168_TIMER1);
+	timer_init(IRQ_PXA168_TIMER1, 6500000);
 }
=20
 void pxa168_clear_keypad_wakeup(void)
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 0f49ac579a17..007b94a92923 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
+#include <linux/clk.h>
=20
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -38,12 +39,6 @@
 #include "cputype.h"
 #include "clock.h"
=20
-#ifdef CONFIG_CPU_MMP2
-#define MMP_CLOCK_FREQ		6500000
-#else
-#define MMP_CLOCK_FREQ		3250000
-#endif
-
 #define TIMERS_VIRT_BASE	TIMERS1_VIRT_BASE
=20
 #define MAX_DELTA		(0xfffffffe)
@@ -189,19 +184,18 @@ static struct irqaction timer_irq =3D {
 	.dev_id		=3D &ckevt,
 };
=20
-void __init timer_init(int irq)
+void __init timer_init(int irq, unsigned long rate)
 {
 	timer_config();
=20
-	sched_clock_register(mmp_read_sched_clock, 32, MMP_CLOCK_FREQ);
+	sched_clock_register(mmp_read_sched_clock, 32, rate);
=20
 	ckevt.cpumask =3D cpumask_of(0);
=20
 	setup_irq(irq, &timer_irq);
=20
-	clocksource_register_hz(&cksrc, MMP_CLOCK_FREQ);
-	clockevents_config_and_register(&ckevt, MMP_CLOCK_FREQ,
-					MIN_DELTA, MAX_DELTA);
+	clocksource_register_hz(&cksrc, rate);
+	clockevents_config_and_register(&ckevt, rate, MIN_DELTA, MAX_DELTA);
 }
=20
 #ifdef CONFIG_OF
@@ -213,7 +207,9 @@ static const struct of_device_id mmp_timer_dt_ids[] =3D=
 {
 void __init mmp_dt_init_timer(void)
 {
 	struct device_node *np;
+	struct clk *clk;
 	int irq, ret;
+	unsigned long rate;
=20
 	np =3D of_find_matching_node(NULL, mmp_timer_dt_ids);
 	if (!np) {
@@ -221,6 +217,18 @@ void __init mmp_dt_init_timer(void)
 		goto out;
 	}
=20
+	clk =3D of_clk_get(np, 0);
+	if (!IS_ERR(clk)) {
+		ret =3D clk_prepare_enable(clk);
+		if (ret)
+			goto out;
+		rate =3D clk_get_rate(clk) / 2;
+	} else if (cpu_is_pj4()) {
+		rate =3D 6500000;
+	} else {
+		rate =3D 3250000;
+	}
+
 	irq =3D irq_of_parse_and_map(np, 0);
 	if (!irq) {
 		ret =3D -EINVAL;
@@ -231,7 +239,7 @@ void __init mmp_dt_init_timer(void)
 		ret =3D -ENOMEM;
 		goto out;
 	}
-	timer_init(irq);
+	timer_init(irq, rate);
 	return;
 out:
 	pr_err("Failed to get timer from device tree with error:%d\n", ret);
--=20
2.19.1


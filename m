Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC189C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A118C21871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WG2ppXXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeLRV3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35232 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbeLRV3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so4282119wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=twrxu4jjsRoXSJA8/HDhXrIZ0SjRWAquqPN4hbirMCs=;
        b=WG2ppXXO+b/Rg8PdQ40dvWMm34OqvgMSq7y0wDoUwfwgB6vfGUSJfPyyH6UtxXDM66
         GHMFEyzO5yCvc2wiMOKs325z62lJp8k3YXWxIGQc6qKe56Aa0i0F6OqiQzYEXYnHfOTM
         bsOJ0gPQ2jRUAjzyL+BDagXJkoVbdgFhU7QhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=twrxu4jjsRoXSJA8/HDhXrIZ0SjRWAquqPN4hbirMCs=;
        b=XLPI51c+poAPRiba/DY63hiZDQK0mkXOly6zxtVfSDw9m6sIx9PMvH0fDeYI0kSXDv
         LHX9gxu/KF/DU1JFfE53K0/nlouWOzg94OxGFrxnJ0uHmmSJ6FUI9F50ZunovJAYPAJK
         XGSO4aiIq2uBpCaU16IfZkdJ9mUM5QFUZLEC8CJp8mbl+jlmC6w58Vtr268pBW2dySzc
         8RiaDfx5zH4Q6J4reN93OUbjSKhk6CG6zixy+j5//b4tmnJ3Jd9YS+aLQEryjQEOcjZG
         K0hsh2L/h5LWD0J+bUplK3CSUaNVu7RFjLjiImJPpGEnWpcjO+fTB7QgBwsft3gZ8gyg
         nRrA==
X-Gm-Message-State: AA+aEWaNi2BZ0ymQAUE8BhfHTw453wDLBGga+wbPy15ZydDO44Vn+tK3
        h2p5DSjZlIymIteLt93EWh5srh7ZCKs=
X-Google-Smtp-Source: AFSGD/UIgyQ8lCSpRMK7EzuTqjrDiY/E+FwB43N0BHgcfW3Wa/pEpT+8Y1IVB1jtwkfFzaon+bHWxQ==
X-Received: by 2002:a1c:7eca:: with SMTP id z193mr4981559wmc.140.1545168567899;
        Tue, 18 Dec 2018 13:29:27 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:27 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>, stable@vger.kernel.org,
        linux-snps-arc@lists.infradead.org (open list:SYNOPSYS ARC ARCHITECTURE)
Subject: [PATCH 12/25] clocksource/drivers/arc_timer: Utilize generic sched_clock
Date:   Tue, 18 Dec 2018 22:28:30 +0100
Message-Id: <20181218212844.30445-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Brodkin <alexey.brodkin@synopsys.com>

It turned out we used to use default implementation of sched_clock()
from kernel/sched/clock.c which was as precise as 1/HZ, i.e.
by default we had 10 msec granularity of time measurement.

Now given ARC built-in timers are clocked with the same frequency as
CPU cores we may get much higher precision of time tracking.

Thus we switch to generic sched_clock which really reads ARC hardware
counters.

This is especially helpful for measuring short events.
That's what we used to have:
------------------------------>8------------------------
$ perf stat /bin/sh -c /root/lmbench-master/bin/arc/hello > /dev/null

 Performance counter stats for '/bin/sh -c /root/lmbench-master/bin/arc/hello':

         10.000000      task-clock (msec)         #    2.832 CPUs utilized
                 1      context-switches          #    0.100 K/sec
                 1      cpu-migrations            #    0.100 K/sec
                63      page-faults               #    0.006 M/sec
           3049480      cycles                    #    0.305 GHz
           1091259      instructions              #    0.36  insn per cycle
            256828      branches                  #   25.683 M/sec
             27026      branch-misses             #   10.52% of all branches

       0.003530687 seconds time elapsed

       0.000000000 seconds user
       0.010000000 seconds sys
------------------------------>8------------------------

And now we'll see:
------------------------------>8------------------------
$ perf stat /bin/sh -c /root/lmbench-master/bin/arc/hello > /dev/null

 Performance counter stats for '/bin/sh -c /root/lmbench-master/bin/arc/hello':

          3.004322      task-clock (msec)         #    0.865 CPUs utilized
                 1      context-switches          #    0.333 K/sec
                 1      cpu-migrations            #    0.333 K/sec
                63      page-faults               #    0.021 M/sec
           2986734      cycles                    #    0.994 GHz
           1087466      instructions              #    0.36  insn per cycle
            255209      branches                  #   84.947 M/sec
             26002      branch-misses             #   10.19% of all branches

       0.003474829 seconds time elapsed

       0.003519000 seconds user
       0.000000000 seconds sys
------------------------------>8------------------------

Note how much more meaningful is the second output - time spent for
execution pretty much matches number of cycles spent (we're runnign
@ 1GHz here).

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Acked-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arc/Kconfig                |  1 +
 drivers/clocksource/Kconfig     |  1 +
 drivers/clocksource/arc_timer.c | 22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index c9e2a1323536..74b5a654f664 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -26,6 +26,7 @@ config ARC
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
 	select GENERIC_PENDING_IRQ if SMP
+	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 8761a1c21b6c..c57b156f49a2 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -277,6 +277,7 @@ config CLKSRC_MPS2
 
 config ARC_TIMERS
 	bool "Support for 32-bit TIMERn counters in ARC Cores" if COMPILE_TEST
+	depends on GENERIC_SCHED_CLOCK
 	select TIMER_OF
 	help
 	  These are legacy 32-bit TIMER0 and TIMER1 counters found on all ARC cores
diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
index 20da9b1d7f7d..b28970ca4a7a 100644
--- a/drivers/clocksource/arc_timer.c
+++ b/drivers/clocksource/arc_timer.c
@@ -23,6 +23,7 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/sched_clock.h>
 
 #include <soc/arc/timers.h>
 #include <soc/arc/mcip.h>
@@ -88,6 +89,11 @@ static u64 arc_read_gfrc(struct clocksource *cs)
 	return (((u64)h) << 32) | l;
 }
 
+static notrace u64 arc_gfrc_clock_read(void)
+{
+	return arc_read_gfrc(NULL);
+}
+
 static struct clocksource arc_counter_gfrc = {
 	.name   = "ARConnect GFRC",
 	.rating = 400,
@@ -111,6 +117,8 @@ static int __init arc_cs_setup_gfrc(struct device_node *node)
 	if (ret)
 		return ret;
 
+	sched_clock_register(arc_gfrc_clock_read, 64, arc_timer_freq);
+
 	return clocksource_register_hz(&arc_counter_gfrc, arc_timer_freq);
 }
 TIMER_OF_DECLARE(arc_gfrc, "snps,archs-timer-gfrc", arc_cs_setup_gfrc);
@@ -139,6 +147,11 @@ static u64 arc_read_rtc(struct clocksource *cs)
 	return (((u64)h) << 32) | l;
 }
 
+static notrace u64 arc_rtc_clock_read(void)
+{
+	return arc_read_rtc(NULL);
+}
+
 static struct clocksource arc_counter_rtc = {
 	.name   = "ARCv2 RTC",
 	.rating = 350,
@@ -170,6 +183,8 @@ static int __init arc_cs_setup_rtc(struct device_node *node)
 
 	write_aux_reg(AUX_RTC_CTRL, 1);
 
+	sched_clock_register(arc_rtc_clock_read, 64, arc_timer_freq);
+
 	return clocksource_register_hz(&arc_counter_rtc, arc_timer_freq);
 }
 TIMER_OF_DECLARE(arc_rtc, "snps,archs-timer-rtc", arc_cs_setup_rtc);
@@ -185,6 +200,11 @@ static u64 arc_read_timer1(struct clocksource *cs)
 	return (u64) read_aux_reg(ARC_REG_TIMER1_CNT);
 }
 
+static notrace u64 arc_timer1_clock_read(void)
+{
+	return arc_read_timer1(NULL);
+}
+
 static struct clocksource arc_counter_timer1 = {
 	.name   = "ARC Timer1",
 	.rating = 300,
@@ -209,6 +229,8 @@ static int __init arc_cs_setup_timer1(struct device_node *node)
 	write_aux_reg(ARC_REG_TIMER1_CNT, 0);
 	write_aux_reg(ARC_REG_TIMER1_CTRL, TIMER_CTRL_NH);
 
+	sched_clock_register(arc_timer1_clock_read, 32, arc_timer_freq);
+
 	return clocksource_register_hz(&arc_counter_timer1, arc_timer_freq);
 }
 
-- 
2.17.1


Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27DDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8198020823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 11:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L2pAfsSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8198020823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbeKSVwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:52:45 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:37552 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbeKSVwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:52:44 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7CAA610C1572;
        Mon, 19 Nov 2018 03:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542626964; bh=ae0XlBK1VHd6MNJjzpSZIdKKTGdhQ7Se20K47fSA5+w=;
        h=From:To:Cc:Subject:Date:From;
        b=L2pAfsSpSBqex4BGf3OkHsK+S/F1lno0/HmLt5aj6pPLmMTmHzmuEhj8LAhunZOgw
         eRnw6F6XRIHz9+9hnYTzxPu3bQQrI7Tks2/cHNI3hyBHDPCnpBDM+Qh9E3BnHGfkrg
         DxwVodMHhnqU0VJiXn+fK/Sa2TTzszYLssGr0VaON3pOBzCsb2Ez2qyk/kUJF6toNC
         iMFJQ/lDnr2qT15mwuUv7Mvx6XF0p9yRxOT5bTkWAHyZSNFJteSEehgb2V5cskblza
         MDSyaMw/UxTQY7U8c1BaMspUqhhgPKgUe8vLoJcLqF/5AFq8NodLUmzCi1TrueFL/K
         IUw0mwLwEIwkA==
Received: from abrodkin-7480l.internal.synopsys.com (unknown [10.121.8.88])
        by mailhost.synopsys.com (Postfix) with ESMTP id BF0AF3AC1;
        Mon, 19 Nov 2018 03:29:22 -0800 (PST)
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3] clocksource/drivers/arc_timer: Utilize generic sched_clock
Date:   Mon, 19 Nov 2018 14:29:17 +0300
Message-Id: <20181119112917.4214-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

Changes v2 -> v3:
 * Rebased on top of v4.20-rc3
 * Moved GENERIC_SCHED_CLOCK to alphabetically-sorted location in
   arch/arc/Kconfig

Changes v1 -> v2:
 * Timer read callbacks marked as "notrace"
 * ARC Timer1 explicitly described as 32-bit one on
   sched_clock_register() invocation

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
index 55c77e44bb2d..d9c8a779dd7d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -290,6 +290,7 @@ config CLKSRC_MPS2
 
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
2.19.1


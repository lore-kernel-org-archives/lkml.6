Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF560C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B893C20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864752;
	bh=HtL+gJK/kzmErIZ2BHEglfHs1XxqBDlkVqTk2dA2nXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UWonDDh1hhdgV/NCxYdY9k4oxZzDp6FLVVanP0UOhgie8I3+QbgTsltUIUt+/eTN9
	 9iUqJd5jKbY4NOSYg2S4Lt3uw/YOS/6Kq+85YP9j7PdksxRnvr6GDGsK8fx0Rjdi4Y
	 GCPQ3iKKpEHyUG6wL8DUVi2d+PnScKX6yyde1gI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfAGMhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbfAGMhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:37:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 265772173C;
        Mon,  7 Jan 2019 12:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864653;
        bh=HtL+gJK/kzmErIZ2BHEglfHs1XxqBDlkVqTk2dA2nXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ub8MTslnohVX+6JIGa9SFf2fWWE5Cv/DwdkjbX4WgI9kauC+iP2mDJw3Fmdfte3JG
         p/7Kwr7OY65Pj8yRTAisyoyEid0uYxQn7JkFpSmcnV6b1ktAw8xRSnUc60eYGfSOXM
         xm+VpOyt1YkKmyGIQwnHPJ8CjQJL6G5BhsBet6eI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.20 063/145] clocksource/drivers/arc_timer: Utilize generic sched_clock
Date:   Mon,  7 Jan 2019 13:31:40 +0100
Message-Id: <20190107104445.551185789@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Brodkin <alexey.brodkin@synopsys.com>

commit bf287607c80f24387fedb431a346dc67f25be12c upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/Kconfig                |    1 +
 drivers/clocksource/Kconfig     |    1 +
 drivers/clocksource/arc_timer.c |   22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+)

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
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -290,6 +290,7 @@ config CLKSRC_MPS2
 
 config ARC_TIMERS
 	bool "Support for 32-bit TIMERn counters in ARC Cores" if COMPILE_TEST
+	depends on GENERIC_SCHED_CLOCK
 	select TIMER_OF
 	help
 	  These are legacy 32-bit TIMER0 and TIMER1 counters found on all ARC cores
--- a/drivers/clocksource/arc_timer.c
+++ b/drivers/clocksource/arc_timer.c
@@ -23,6 +23,7 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/sched_clock.h>
 
 #include <soc/arc/timers.h>
 #include <soc/arc/mcip.h>
@@ -88,6 +89,11 @@ static u64 arc_read_gfrc(struct clocksou
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
@@ -111,6 +117,8 @@ static int __init arc_cs_setup_gfrc(stru
 	if (ret)
 		return ret;
 
+	sched_clock_register(arc_gfrc_clock_read, 64, arc_timer_freq);
+
 	return clocksource_register_hz(&arc_counter_gfrc, arc_timer_freq);
 }
 TIMER_OF_DECLARE(arc_gfrc, "snps,archs-timer-gfrc", arc_cs_setup_gfrc);
@@ -139,6 +147,11 @@ static u64 arc_read_rtc(struct clocksour
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
@@ -170,6 +183,8 @@ static int __init arc_cs_setup_rtc(struc
 
 	write_aux_reg(AUX_RTC_CTRL, 1);
 
+	sched_clock_register(arc_rtc_clock_read, 64, arc_timer_freq);
+
 	return clocksource_register_hz(&arc_counter_rtc, arc_timer_freq);
 }
 TIMER_OF_DECLARE(arc_rtc, "snps,archs-timer-rtc", arc_cs_setup_rtc);
@@ -185,6 +200,11 @@ static u64 arc_read_timer1(struct clocks
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
@@ -209,6 +229,8 @@ static int __init arc_cs_setup_timer1(st
 	write_aux_reg(ARC_REG_TIMER1_CNT, 0);
 	write_aux_reg(ARC_REG_TIMER1_CTRL, TIMER_CTRL_NH);
 
+	sched_clock_register(arc_timer1_clock_read, 32, arc_timer_freq);
+
 	return clocksource_register_hz(&arc_counter_timer1, arc_timer_freq);
 }
 



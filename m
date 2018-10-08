Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5738EC676D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1419020841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="syefbeFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1419020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJHUCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:02:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45205 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJHUCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:02:23 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181008125048euoutp01805b39279356fb59c71f2ce4922185f6~box5vXuK71950819508euoutp01g;
        Mon,  8 Oct 2018 12:50:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181008125048euoutp01805b39279356fb59c71f2ce4922185f6~box5vXuK71950819508euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539003048;
        bh=+hlh6tcQhN7aktr3PJyjEvqOPWD+APolECBd/LiiVuk=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=syefbeFE6shxjMvHMs4yRtVe3XwrpOGmll2KMMybPzwoBpNzTOcW8QvVFcC6kBUGb
         KvE/BULhkIaF5iBPlwpzWWT6GQA58dMmenvz6RVSAfqMqv64V8yZw7WjZd5JC0Wpa+
         Jq/7WiaFYqzthopZD6rqbmOKi0ISvrOzQloZ0ktA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008125048eucas1p2ba6913438382cbc9dca1e7e368bcd0bc~box5RIL3T1695716957eucas1p2q;
        Mon,  8 Oct 2018 12:50:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1E.D2.04441.7A25BBB5; Mon,  8
        Oct 2018 13:50:47 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008125047eucas1p23e520d778ad5f18aba57b21641d4cb4c~box4c4pET1877418774eucas1p2n;
        Mon,  8 Oct 2018 12:50:47 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-b8-5bbb52a7ea54
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 43.39.04128.7A25BBB5; Mon,  8
        Oct 2018 13:50:47 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGA006EA6BYW230@eusync1.samsung.com>;
        Mon, 08 Oct 2018 13:50:47 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH 2/7] clocksource: exynos_mct: Add arch_timer cooperation
 mode for ARM64
Date:   Mon, 08 Oct 2018 14:50:04 +0200
Message-id: <20181008125009.3721-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181008125009.3721-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7djP87rLg3ZHG/zttLTYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4MjZt+MBYsEiqYt3Xo0wNjOtFuxg5OSQETCS+TPrO1MXIxSEksIJRYsqFhcwQzmdGiVnb
        j7PDVM0/uIUJxBYSWMYoMeNZCkRRA5NE148FYEVsAoYSXW+72EBsEYFsic7HDxhBbGaBRcwS
        B44Jg9jCApESD6evYwGxWQRUJe7vuAdm8wrYSEz9eJ8JYpm8xOoNB5hBbE4BW4knXatYQJZJ
        COxhk3g2czErRJGLxJeXZ6CuE5Z4dXwLlC0jcXlyN1RDM6NE+4xZ7BBOD6PE1jk72CCqrCUO
        H7/ICnEen8SkbdOB1nEAxXklOtqEIEwPiU27zSG+nMAocXzLTfYJjJILGBlWMYqnlhbnpqcW
        G+allusVJ+YWl+al6yXn525iBEbz6X/HP+1g/Hop6RCjAAejEg/vyoBd0UKsiWXFlbmHGCU4
        mJVEeEW3A4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzLpu3MVpIID2xJDU7NbUgtQgmy8TBKdXA
        WObywblocuTT+OKXlz1vGSwsmnKMc15fp8YE/QupVpsvdbjwJK6RvC/AZ+dYPPdMyYwF21/9
        7BKWyp24K5Ftqsj8HRvTnyTb5fJ+OL1s4RFft4BJ8ys/OS9d8eHTH2+lA34zn0zZ8tpaSlF7
        Y7D78YQOxzm7W1YEBAaqHs5Y4tzX/cDeRfDNciWW4oxEQy3mouJEAKshHbPiAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVy+t/xy7rLg3ZHG2yZJm6xccZ6Vov3y3oY
        La5/ec5qMe+zrMWk+xNYLM6f38BusenxNVaLy7vmsFnMOL+PyWLtkbvsFn/v/GOz2LxpKrPF
        y48nWBx4PdbMW8PosWlVJ5vHnWt72DzenTvH7rF5Sb1H35ZVjB6fN8kFsEdx2aSk5mSWpRbp
        2yVwZWza8IGxYJFUxbqvR5kaGNeLdjFyckgImEjMP7iFCcQWEljCKHHxEWcXIxeQ3cQkcXXd
        bkaQBJuAoUTX2y42EFtEIFti/t5udhCbWWAJs8TN+w4gtrBApMTHHetYQGwWAVWJ+zvugdm8
        AjYSUz/eZ4JYJi+xesMBZhCbU8BW4knXKhaIxTYSvdMvsk5g5FnAyLCKUSS1tDg3PbfYSK84
        Mbe4NC9dLzk/dxMjMAy3Hfu5ZQdj17vgQ4wCHIxKPLwrAnZFC7EmlhVX5h5ilOBgVhLhFd0O
        FOJNSaysSi3Kjy8qzUktPsQozcGiJM573qAySkggPbEkNTs1tSC1CCbLxMEp1cCYvorbfXP8
        cW/Ljd3fO9lm3vFPMPqhLHnVbFpybUjRbx2ZyZ47r25kPfE8j/9qFcf+iwbBytN2O+3wZeU/
        lrpg78oHJlOXP5wok3bwrduJlY8j9x6MjJ35cY9ygvTnVu/YChcLd/F+4w+Suw/bzex88ldi
        apDwLknfzTsE4sLKVrsKrv36c8N0JZbijERDLeai4kQAaEuZzj8CAAA=
X-CMS-MailID: 20181008125047eucas1p23e520d778ad5f18aba57b21641d4cb4c
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181008125047eucas1p23e520d778ad5f18aba57b21641d4cb4c
References: <20181008125009.3721-1-m.szyprowski@samsung.com>
        <CGME20181008125047eucas1p23e520d778ad5f18aba57b21641d4cb4c@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get ARM Architected Timers working on Samsung Exynos SoCs, one has to
first configure and enable Exynos Multi-Core Timer, because they both
share some common hardware blocks. This patch adds a mode of cooperation
with arch_timer driver, so kernel can use CP15 based timer interface via
arch_timer driver, which is mandatory on ARM64. In such mode driver only
configures MCT registers and starts the timer but don't register any
clocksource or events in the system. Those are left to be handled by
arch_timer driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 43b335ff4a96..05b201ed8ef5 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -57,6 +57,7 @@
 #define TICK_BASE_CNT	1
 
 enum {
+	MCT_INT_NONE = 0,
 	MCT_INT_SPI,
 	MCT_INT_PPI
 };
@@ -238,6 +239,9 @@ static int __init exynos4_clocksource_init(void)
 {
 	exynos4_mct_frc_start();
 
+	if (!mct_int_type)
+		return 0;
+
 #if defined(CONFIG_ARM)
 	exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;
 	exynos4_delay_timer.freq = clk_rate;
@@ -343,6 +347,9 @@ static struct irqaction mct_comp_event_irq = {
 
 static int exynos4_clockevent_init(void)
 {
+	if (!mct_int_type)
+		return 0;
+
 	mct_comp_device.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&mct_comp_device, clk_rate,
 					0xf, 0xffffffff);
@@ -476,12 +483,12 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 
 		irq_force_affinity(evt->irq, cpumask_of(cpu));
 		enable_irq(evt->irq);
-	} else {
+	} else if (mct_int_type == MCT_INT_PPI) {
 		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
 	}
-	clockevents_config_and_register(evt, clk_rate / (TICK_BASE_CNT + 1),
-					0xf, 0x7fffffff);
-
+	if (mct_int_type)
+		clockevents_config_and_register(evt,
+			       clk_rate / (TICK_BASE_CNT + 1), 0xf, 0x7fffffff);
 	return 0;
 }
 
@@ -496,7 +503,7 @@ static int exynos4_mct_dying_cpu(unsigned int cpu)
 		if (evt->irq != -1)
 			disable_irq_nosync(evt->irq);
 		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
-	} else {
+	} else if (mct_int_type == MCT_INT_PPI) {
 		disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
 	}
 	return 0;
@@ -529,7 +536,7 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 					 &percpu_mct_tick);
 		WARN(err, "MCT: can't request IRQ %d (%d)\n",
 		     mct_irqs[MCT_L0_IRQ], err);
-	} else {
+	} else if (mct_int_type == MCT_INT_SPI) {
 		for_each_possible_cpu(cpu) {
 			int mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
 			struct mct_clock_event_device *pcpu_mevt =
@@ -573,6 +580,15 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 
 	mct_int_type = int_type;
 
+	if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
+		struct device_node *np = of_find_compatible_node(NULL, NULL,
+							     "arm,armv8-timer");
+		if (np) {
+			mct_int_type = MCT_INT_NONE;
+			of_node_put(np);
+		}
+	}
+
 	/* This driver uses only one global timer interrupt */
 	mct_irqs[MCT_G0_IRQ] = irq_of_parse_and_map(np, MCT_G0_IRQ);
 
-- 
2.17.1


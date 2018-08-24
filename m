Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D99C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919502150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l9fdsf27";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ECoC1JTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919502150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeHXXnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:43:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52852 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeHXXnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:43:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 85921605A2; Fri, 24 Aug 2018 20:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535141246;
        bh=DX0+wc6YyGu52tlssKp8gCZCcHH+5hHUdAKlPVLlPr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l9fdsf27nX7+zKjIxOiqW7j9IyW0F8y+jz1sdwqJcf08OAM00NBH30DhnbMMgPkpS
         gE9EEUdzzqdpNfTPw3OdWE1eJRB6aXXSzAEoTO4GGJBSTCh08cXNftcrGTpXjB4g1b
         wn8+KhTzKq89gPLTzFSjqXPK1EsxlxXQJwBQHV6Y=
Received: from rplsssn-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rplsssn@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8819F60559;
        Fri, 24 Aug 2018 20:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535141242;
        bh=DX0+wc6YyGu52tlssKp8gCZCcHH+5hHUdAKlPVLlPr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ECoC1JTNDYIkuCmAVVwXeENIaeBa5l8U47I1E5I0Kh3AkZu5IsGDTO6J1I02dQ4Lh
         6ZWqBnWKcSXOGyTPKzKVVJ15+vToqyIGo//12ZZ6KSnE0RfqxsnKOexujNDdWWiGSD
         VjzUYSKPycyV/s8XM2KPnSNsv0057bVY45BqQaYg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8819F60559
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rplsssn@codeaurora.org
From:   "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        rafael@kernel.org, drake@endlessm.com, sboyd@kernel.org,
        evgreen@chromium.org, dianders@chromium.org, mka@chromium.org,
        ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 4/6] drivers: qcom: system_pm: program next wakeup to PDC timer
Date:   Sat, 25 Aug 2018 01:36:26 +0530
Message-Id: <1535141188-29731-5-git-send-email-rplsssn@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
References: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to sleep and wake request votes that need to be sent to
remote processor as part of low power mode entry, the next wake-up timer
value needs to be programmed to PDC (Power Domain Controller) which has
its own timer and is in an always on power domain. A specific control
register is provided in RSC address space for this purpose. PDC wakes-up
the RSC and sets up the resources back in active state before the
processor is woken up by a timer interrupt.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 drivers/soc/qcom/system_pm.c | 61 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/soc/qcom/system_pm.c b/drivers/soc/qcom/system_pm.c
index 8810b84..1451bf8 100644
--- a/drivers/soc/qcom/system_pm.c
+++ b/drivers/soc/qcom/system_pm.c
@@ -5,15 +5,67 @@
 
 #include <linux/cpu_pm.h>
 #include <linux/kernel.h>
+#include <linux/ktime.h>
 #include <linux/platform_device.h>
+#include <linux/tick.h>
 
 #include <soc/qcom/rpmh.h>
 
+#define ARCH_TIMER_HZ (19200000)
+#define PDC_TIME_VALID_SHIFT	31
+#define PDC_TIME_UPPER_MASK	0xFFFFFF
 static struct cpumask cpu_pm_state_mask;
 static raw_spinlock_t cpu_pm_state_lock;
 
 static struct device *sys_pm_dev;
 
+static uint64_t us_to_ticks(uint64_t time_us)
+{
+	uint64_t sec, nsec, time_cycles;
+
+	sec = time_us;
+	do_div(sec, USEC_PER_SEC);
+	nsec = time_us - sec * USEC_PER_SEC;
+
+	if (nsec > 0) {
+		nsec = nsec * NSEC_PER_USEC;
+		do_div(nsec, NSEC_PER_SEC);
+	}
+
+	sec += nsec;
+
+	time_cycles = (u64)sec * ARCH_TIMER_HZ;
+
+	return time_cycles;
+}
+
+static int setup_pdc_wakeup_timer(bool suspend)
+{
+	int cpu;
+	struct tcs_cmd cmd[2] = { { 0 } };
+	ktime_t next_wakeup, cpu_wakeup;
+	uint64_t wakeup_cycles = ~0U;
+
+	if (!suspend) {
+		/*
+		 * Find the next wakeup for any of the online CPUs
+		 */
+		next_wakeup = ktime_set(KTIME_SEC_MAX, 0);
+		for_each_online_cpu(cpu) {
+			cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
+			if (ktime_before(cpu_wakeup, next_wakeup))
+				next_wakeup = cpu_wakeup;
+		}
+		wakeup_cycles = us_to_ticks(ktime_to_us(next_wakeup));
+	}
+
+	cmd[0].data =  (wakeup_cycles >> 32) & PDC_TIME_UPPER_MASK;
+	cmd[0].data |= 1 << PDC_TIME_VALID_SHIFT;
+	cmd[1].data = (wakeup_cycles & 0xFFFFFFFF);
+
+	return rpmh_write_pdc_data(sys_pm_dev, cmd, ARRAY_SIZE(cmd));
+}
+
 static int sys_pm_notifier(struct notifier_block *b,
 			       unsigned long cmd, void *v)
 {
@@ -25,6 +77,14 @@ static int sys_pm_notifier(struct notifier_block *b,
 			if (rpmh_ctrlr_idle(sys_pm_dev)) {
 				/* Flush the sleep/wake sets */
 				rpmh_flush(sys_pm_dev);
+				/*
+				 * The next wakeup value is converted to ticks
+				 * and copied to the Power Domain Controller
+				 * that has its own timer, which is in an
+				 * always-on power domain. The programming is
+				 * done through a separate register on the RSC
+				 */
+				setup_pdc_wakeup_timer(false);
 			} else {
 				pr_err("%s:rpmh controller is busy\n",
 						__func__);
@@ -72,6 +132,7 @@ static int sys_pm_suspend(struct device *dev)
 	if (rpmh_ctrlr_idle(dev)) {
 		/* Flush the sleep/wake sets in RSC controller */
 		rpmh_flush(dev);
+		setup_pdc_wakeup_timer(true);
 	} else {
 		pr_err("%s:rpmh controller is busy\n", __func__);
 		return -EBUSY;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.


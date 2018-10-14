Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E82C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD5720645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD5720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbeJNX1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:27:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37167 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728141AbeJNX1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:27:08 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM9-0004cj-FY; Sun, 14 Oct 2018 16:31:01 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLQ-0000GP-Dc; Sun, 14 Oct 2018 16:30:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        "Shawn Guo" <shawn.guo@linaro.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.577113963@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 092/366] rtc: snvs: Fix usage of snvs_rtc_enable
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bryan O'Donoghue <pure.logic@nexus-software.ie>

commit 1485991c024603b2fb4ae77beb7a0d741128a48e upstream.

commit 179a502f8c46 ("rtc: snvs: add Freescale rtc-snvs driver") introduces
the SNVS RTC driver with a function snvs_rtc_enable().

snvs_rtc_enable() can return an error on the enable path however this
driver does not currently trap that failure on the probe() path and
consequently if enabling the RTC fails we encounter a later error spinning
forever in rtc_write_sync_lp().

[   36.093481] [<c010d630>] (__irq_svc) from [<c0c2e9ec>] (_raw_spin_unlock_irqrestore+0x34/0x44)
[   36.102122] [<c0c2e9ec>] (_raw_spin_unlock_irqrestore) from [<c072e32c>] (regmap_read+0x4c/0x5c)
[   36.110938] [<c072e32c>] (regmap_read) from [<c085d0f4>] (rtc_write_sync_lp+0x6c/0x98)
[   36.118881] [<c085d0f4>] (rtc_write_sync_lp) from [<c085d160>] (snvs_rtc_alarm_irq_enable+0x40/0x4c)
[   36.128041] [<c085d160>] (snvs_rtc_alarm_irq_enable) from [<c08567b4>] (rtc_timer_do_work+0xd8/0x1a8)
[   36.137291] [<c08567b4>] (rtc_timer_do_work) from [<c01441b8>] (process_one_work+0x28c/0x76c)
[   36.145840] [<c01441b8>] (process_one_work) from [<c01446cc>] (worker_thread+0x34/0x58c)
[   36.153961] [<c01446cc>] (worker_thread) from [<c014aee4>] (kthread+0x138/0x150)
[   36.161388] [<c014aee4>] (kthread) from [<c0107e14>] (ret_from_fork+0x14/0x20)
[   36.168635] rcu_sched kthread starved for 2602 jiffies! g496 c495 f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
[   36.178564] rcu_sched       R  running task        0     8      2 0x00000000
[   36.185664] [<c0c288b0>] (__schedule) from [<c0c29134>] (schedule+0x3c/0xa0)
[   36.192739] [<c0c29134>] (schedule) from [<c0c2db80>] (schedule_timeout+0x78/0x4e0)
[   36.200422] [<c0c2db80>] (schedule_timeout) from [<c01a7ab0>] (rcu_gp_kthread+0x648/0x1864)
[   36.208800] [<c01a7ab0>] (rcu_gp_kthread) from [<c014aee4>] (kthread+0x138/0x150)
[   36.216309] [<c014aee4>] (kthread) from [<c0107e14>] (ret_from_fork+0x14/0x20)

This patch fixes by parsing the result of rtc_write_sync_lp() and
propagating both in the probe and elsewhere. If the RTC doesn't start we
don't proceed loading the driver and don't get into this loop mess later
on.

Fixes: 179a502f8c46 ("rtc: snvs: add Freescale rtc-snvs driver")
Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[bwh: Backported to 3.16:
 - No cleanup is needed on error in snvs_rtc_probe(); just return
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/rtc/rtc-snvs.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -130,20 +130,23 @@ static int snvs_rtc_set_time(struct devi
 {
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
 	unsigned long time;
+	int ret;
 
 	rtc_tm_to_time(tm, &time);
 
 	/* Disable RTC first */
-	snvs_rtc_enable(data, false);
+	ret = snvs_rtc_enable(data, false);
+	if (ret)
+		return ret;
 
 	/* Write 32-bit time to 47-bit timer, leaving 15 LSBs blank */
 	writel(time << CNTR_TO_SECS_SH, data->ioaddr + SNVS_LPSRTCLR);
 	writel(time >> (32 - CNTR_TO_SECS_SH), data->ioaddr + SNVS_LPSRTCMR);
 
 	/* Enable RTC again */
-	snvs_rtc_enable(data, true);
+	ret = snvs_rtc_enable(data, true);
 
-	return 0;
+	return ret;
 }
 
 static int snvs_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
@@ -271,7 +274,11 @@ static int snvs_rtc_probe(struct platfor
 	writel(0xffffffff, data->ioaddr + SNVS_LPSR);
 
 	/* Enable RTC */
-	snvs_rtc_enable(data, true);
+	ret = snvs_rtc_enable(data, true);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable rtc %d\n", ret);
+		return ret;
+	}
 
 	device_init_wakeup(&pdev->dev, true);
 


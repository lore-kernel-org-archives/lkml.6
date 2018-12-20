Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A288C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F079921852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297934;
	bh=DCHn/hLENp9HwLwmoKqAPcaa5+jepGbzZxkl0LxmARU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Z9s2BmzmzKTRqG92Rxj14SGB4cmEOSikIzlR1//6KjePHmzRJkVzO7Hqq3UrXbaP
	 Nk4AxmSokdiaiIlcVIWW0S15piR5cGjJn5vJsSdTTxBFE5E+x5KZBMAkOvcEs4xkzB
	 YE7fKKOE/qrXejgxiLORFXZYPSWn0YulJt8ezVLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbeLTJZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:25:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbeLTJZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:25:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 398FC217D9;
        Thu, 20 Dec 2018 09:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297925;
        bh=DCHn/hLENp9HwLwmoKqAPcaa5+jepGbzZxkl0LxmARU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2Lqa9A8GYE6HWXZjogIDLWnmSHoTBQqDPfYc1aAMacPyf632XGfv2Pc+zJXubMS2
         TyAuW35Qn9yfFwDPjqWO5J+lw1UkAkOu/338uLwcHLVpBXqDkbhc8Dms9xaZstEHgQ
         7ti0P9WXuw3xTrIwNunZxNFa+DmihcMjqSHl0Gzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Bryan ODonoghue <pure.logic@nexus-software.ie>,
        Trent Piepho <tpiepho@impinj.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 61/61] rtc: snvs: Add timeouts to avoid kernel lockups
Date:   Thu, 20 Dec 2018 10:19:01 +0100
Message-Id: <20181220085846.205752305@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit cd7f3a249dbed2858e6c2f30e5be7f1f7a709ee2 ]

In order to read correctly from asynchronously updated RTC registers,
it's necessary to read repeatedly until their values do not change from
read to read.  It's also necessary to wait for three RTC clock ticks for
certain operations.  There are no timeouts in this code and these
operations could possibly loop forever.

To avoid kernel hangs, put in timeouts.

The iMX7d can be configured to stop the SRTC on a tamper event, which
will lockup the kernel inside this driver as described above.

These hangs can happen when running under qemu, which doesn't emulate
the SNVS RTC, though currently the driver will refuse to load on qemu
due to a timeout in the driver probe method.

It could also happen if the SRTC block where somehow placed into reset
or the slow speed clock that drives the SRTC counter (but not the CPU)
were to stop.

The symptoms on a two core iMX7d are a work queue hang on
rtc_timer_do_work(), which eventually blocks a systemd fsnotify
operation that triggers a work queue flush, causing systemd to hang and
thus causing all services that should be started by systemd, like a
console getty, to fail to start or stop.

Also optimize the wait code to wait less.  It only needs to wait for the
clock to advance three ticks, not to see it change three times.

Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-snvs.c | 105 +++++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 35 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index 9af591d5223c..71eee39520f0 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -47,49 +47,83 @@ struct snvs_rtc_data {
 	struct clk *clk;
 };
 
+/* Read 64 bit timer register, which could be in inconsistent state */
+static u64 rtc_read_lpsrt(struct snvs_rtc_data *data)
+{
+	u32 msb, lsb;
+
+	regmap_read(data->regmap, data->offset + SNVS_LPSRTCMR, &msb);
+	regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &lsb);
+	return (u64)msb << 32 | lsb;
+}
+
+/* Read the secure real time counter, taking care to deal with the cases of the
+ * counter updating while being read.
+ */
 static u32 rtc_read_lp_counter(struct snvs_rtc_data *data)
 {
 	u64 read1, read2;
-	u32 val;
+	unsigned int timeout = 100;
 
+	/* As expected, the registers might update between the read of the LSB
+	 * reg and the MSB reg.  It's also possible that one register might be
+	 * in partially modified state as well.
+	 */
+	read1 = rtc_read_lpsrt(data);
 	do {
-		regmap_read(data->regmap, data->offset + SNVS_LPSRTCMR, &val);
-		read1 = val;
-		read1 <<= 32;
-		regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &val);
-		read1 |= val;
-
-		regmap_read(data->regmap, data->offset + SNVS_LPSRTCMR, &val);
-		read2 = val;
-		read2 <<= 32;
-		regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &val);
-		read2 |= val;
-	} while (read1 != read2);
+		read2 = read1;
+		read1 = rtc_read_lpsrt(data);
+	} while (read1 != read2 && --timeout);
+	if (!timeout)
+		dev_err(&data->rtc->dev, "Timeout trying to get valid LPSRT Counter read\n");
 
 	/* Convert 47-bit counter to 32-bit raw second count */
 	return (u32) (read1 >> CNTR_TO_SECS_SH);
 }
 
-static void rtc_write_sync_lp(struct snvs_rtc_data *data)
+/* Just read the lsb from the counter, dealing with inconsistent state */
+static int rtc_read_lp_counter_lsb(struct snvs_rtc_data *data, u32 *lsb)
 {
-	u32 count1, count2, count3;
-	int i;
-
-	/* Wait for 3 CKIL cycles */
-	for (i = 0; i < 3; i++) {
-		do {
-			regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count1);
-			regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count2);
-		} while (count1 != count2);
-
-		/* Now wait until counter value changes */
-		do {
-			do {
-				regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count2);
-				regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count3);
-			} while (count2 != count3);
-		} while (count3 == count1);
+	u32 count1, count2;
+	unsigned int timeout = 100;
+
+	regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count1);
+	do {
+		count2 = count1;
+		regmap_read(data->regmap, data->offset + SNVS_LPSRTCLR, &count1);
+	} while (count1 != count2 && --timeout);
+	if (!timeout) {
+		dev_err(&data->rtc->dev, "Timeout trying to get valid LPSRT Counter read\n");
+		return -ETIMEDOUT;
 	}
+
+	*lsb = count1;
+	return 0;
+}
+
+static int rtc_write_sync_lp(struct snvs_rtc_data *data)
+{
+	u32 count1, count2;
+	u32 elapsed;
+	unsigned int timeout = 1000;
+	int ret;
+
+	ret = rtc_read_lp_counter_lsb(data, &count1);
+	if (ret)
+		return ret;
+
+	/* Wait for 3 CKIL cycles, about 61.0-91.5 µs */
+	do {
+		ret = rtc_read_lp_counter_lsb(data, &count2);
+		if (ret)
+			return ret;
+		elapsed = count2 - count1; /* wrap around _is_ handled! */
+	} while (elapsed < 3 && --timeout);
+	if (!timeout) {
+		dev_err(&data->rtc->dev, "Timeout waiting for LPSRT Counter to change\n");
+		return -ETIMEDOUT;
+	}
+	return 0;
 }
 
 static int snvs_rtc_enable(struct snvs_rtc_data *data, bool enable)
@@ -173,9 +207,7 @@ static int snvs_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
 			   (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN),
 			   enable ? (SNVS_LPCR_LPTA_EN | SNVS_LPCR_LPWUI_EN) : 0);
 
-	rtc_write_sync_lp(data);
-
-	return 0;
+	return rtc_write_sync_lp(data);
 }
 
 static int snvs_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
@@ -183,11 +215,14 @@ static int snvs_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
 	struct rtc_time *alrm_tm = &alrm->time;
 	unsigned long time;
+	int ret;
 
 	rtc_tm_to_time(alrm_tm, &time);
 
 	regmap_update_bits(data->regmap, data->offset + SNVS_LPCR, SNVS_LPCR_LPTA_EN, 0);
-	rtc_write_sync_lp(data);
+	ret = rtc_write_sync_lp(data);
+	if (ret)
+		return ret;
 	regmap_write(data->regmap, data->offset + SNVS_LPTAR, time);
 
 	/* Clear alarm interrupt status bit */
-- 
2.19.1




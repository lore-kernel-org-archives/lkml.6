Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4127C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7160420661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107417;
	bh=WVlHBSkRBwGzMP4F62pelg2aASpr8wORPiqr9J7qIYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BEy6x92e2q+PQzz1MZcFTckBHeZbV7QCoNY7yOOveKTuLrzysyKV95+A9BgWX8zEa
	 ZJ8Ls1XhLYPyJOaHuNZfCYMUjGgJkgAQLxz8LesdzlvLBxdBop4RicdQ2Z7lXKtLsS
	 tOxMZsAIEBBH8TqX8caowHpp/dt8FqxUuCge9b30=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7160420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbeLFOng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:43:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730165AbeLFOnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:43:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1CF020892;
        Thu,  6 Dec 2018 14:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107411;
        bh=WVlHBSkRBwGzMP4F62pelg2aASpr8wORPiqr9J7qIYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OPZkfgObF/nlWulwh1BJwKrc6yBsAgeXrcBFYwdIpEnGQWdK8xYvG8J00Te4/w9IY
         io+4gaXFE44blJfstunHoRPp5JPXS4XhNdG4kZBTf2abVW95PQ8EZYje/aE7p9MbUZ
         Izcd0phmvpaXsajBlfdMG/S7oXF4q08d3nzDNZqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rafael David Tinoco <rafael.tinoco@linaro.org>
Subject: [PATCH 4.14 50/55] thermal/drivers/hisi: Encapsulate register writes into helpers
Date:   Thu,  6 Dec 2018 15:39:24 +0100
Message-Id: <20181206143004.444534386@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
References: <20181206143001.749982936@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Lezcano <daniel.lezcano@linaro.org>

commit 1e11b014271ceccb5ea04ae58f4829ac8209a86d upstream.

Hopefully, the function name can help to clarify the semantic of the operations
when writing in the register.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/hisi_thermal.c |   92 +++++++++++++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 22 deletions(-)

--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -26,6 +26,7 @@
 
 #include "thermal_core.h"
 
+#define TEMP0_LAG			(0x0)
 #define TEMP0_TH			(0x4)
 #define TEMP0_RST_TH			(0x8)
 #define TEMP0_CFG			(0xC)
@@ -96,6 +97,56 @@ static inline long hisi_thermal_round_te
 		hisi_thermal_temp_to_step(temp));
 }
 
+static inline void hisi_thermal_set_lag(void __iomem *addr, int value)
+{
+	writel(value, addr + TEMP0_LAG);
+}
+
+static inline void hisi_thermal_alarm_clear(void __iomem *addr, int value)
+{
+	writel(value, addr + TEMP0_INT_CLR);
+}
+
+static inline void hisi_thermal_alarm_enable(void __iomem *addr, int value)
+{
+	writel(value, addr + TEMP0_INT_EN);
+}
+
+static inline void hisi_thermal_alarm_set(void __iomem *addr, int temp)
+{
+	writel(hisi_thermal_temp_to_step(temp) | 0x0FFFFFF00, addr + TEMP0_TH);
+}
+
+static inline void hisi_thermal_reset_set(void __iomem *addr, int temp)
+{
+	writel(hisi_thermal_temp_to_step(temp), addr + TEMP0_RST_TH);
+}
+
+static inline void hisi_thermal_reset_enable(void __iomem *addr, int value)
+{
+	writel(value, addr + TEMP0_RST_MSK);
+}
+
+static inline void hisi_thermal_enable(void __iomem *addr, int value)
+{
+	writel(value, addr + TEMP0_EN);
+}
+
+static inline void hisi_thermal_sensor_select(void __iomem *addr, int sensor)
+{
+	writel((sensor << 12), addr + TEMP0_CFG);
+}
+
+static inline int hisi_thermal_get_temperature(void __iomem *addr)
+{
+	return hisi_thermal_step_to_temp(readl(addr + TEMP0_VALUE));
+}
+
+static inline void hisi_thermal_hdak_set(void __iomem *addr, int value)
+{
+	writel(value, addr + TEMP0_CFG);
+}
+
 static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,
 					 struct hisi_thermal_sensor *sensor)
 {
@@ -104,22 +155,21 @@ static long hisi_thermal_get_sensor_temp
 	mutex_lock(&data->thermal_lock);
 
 	/* disable interrupt */
-	writel(0x0, data->regs + TEMP0_INT_EN);
-	writel(0x1, data->regs + TEMP0_INT_CLR);
+	hisi_thermal_alarm_enable(data->regs, 0);
+	hisi_thermal_alarm_clear(data->regs, 1);
 
 	/* disable module firstly */
-	writel(0x0, data->regs + TEMP0_EN);
+	hisi_thermal_enable(data->regs, 0);
 
 	/* select sensor id */
-	writel((sensor->id << 12), data->regs + TEMP0_CFG);
+	hisi_thermal_sensor_select(data->regs, sensor->id);
 
 	/* enable module */
-	writel(0x1, data->regs + TEMP0_EN);
+	hisi_thermal_enable(data->regs, 1);
 
 	usleep_range(3000, 5000);
 
-	val = readl(data->regs + TEMP0_VALUE);
-	val = hisi_thermal_step_to_temp(val);
+	val = hisi_thermal_get_temperature(data->regs);
 
 	mutex_unlock(&data->thermal_lock);
 
@@ -136,28 +186,26 @@ static void hisi_thermal_enable_bind_irq
 	sensor = &data->sensors;
 
 	/* setting the hdak time */
-	writel(0x0, data->regs + TEMP0_CFG);
+	hisi_thermal_hdak_set(data->regs, 0);
 
 	/* disable module firstly */
-	writel(0x0, data->regs + TEMP0_RST_MSK);
-	writel(0x0, data->regs + TEMP0_EN);
+	hisi_thermal_reset_enable(data->regs, 0);
+	hisi_thermal_enable(data->regs, 0);
 
 	/* select sensor id */
-	writel((sensor->id << 12), data->regs + TEMP0_CFG);
+	hisi_thermal_sensor_select(data->regs, sensor->id);
 
 	/* enable for interrupt */
-	writel(hisi_thermal_temp_to_step(sensor->thres_temp) | 0x0FFFFFF00,
-	       data->regs + TEMP0_TH);
+	hisi_thermal_alarm_set(data->regs, sensor->thres_temp);
 
-	writel(hisi_thermal_temp_to_step(HISI_TEMP_RESET),
-	       data->regs + TEMP0_RST_TH);
+	hisi_thermal_reset_set(data->regs, HISI_TEMP_RESET);
 
 	/* enable module */
-	writel(0x1, data->regs + TEMP0_RST_MSK);
-	writel(0x1, data->regs + TEMP0_EN);
+	hisi_thermal_reset_enable(data->regs, 1);
+	hisi_thermal_enable(data->regs, 1);
 
-	writel(0x0, data->regs + TEMP0_INT_CLR);
-	writel(0x1, data->regs + TEMP0_INT_EN);
+	hisi_thermal_alarm_clear(data->regs, 0);
+	hisi_thermal_alarm_enable(data->regs, 1);
 
 	usleep_range(3000, 5000);
 
@@ -169,9 +217,9 @@ static void hisi_thermal_disable_sensor(
 	mutex_lock(&data->thermal_lock);
 
 	/* disable sensor module */
-	writel(0x0, data->regs + TEMP0_INT_EN);
-	writel(0x0, data->regs + TEMP0_RST_MSK);
-	writel(0x0, data->regs + TEMP0_EN);
+	hisi_thermal_enable(data->regs, 0);
+	hisi_thermal_alarm_enable(data->regs, 0);
+	hisi_thermal_reset_enable(data->regs, 0);
 
 	mutex_unlock(&data->thermal_lock);
 }



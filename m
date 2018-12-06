Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EB7C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CA920850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544108164;
	bh=H8E8kPf+0aCRXPSMQf11eXm4z/1bKBcwaK/RXuGsuAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kfdqzgo5L7IKTAe2PE+9UdjiZX1JJq3cD2v0d/7p/TOelX8G9ZL6WPuBZ7YfgBWCD
	 joZGQ3qXD5oF2UoHTRX9nDrxf8OFVgAoGo4nsqBNHr0tNuL1b7QRSFclAP5fLfO6SY
	 6K8HrPlcBQG2gk5pb0tiON3P7pVqMaL/N+cOjQHQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CA920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbeLFOnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:43:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbeLFOne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:43:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4970B20892;
        Thu,  6 Dec 2018 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107413;
        bh=H8E8kPf+0aCRXPSMQf11eXm4z/1bKBcwaK/RXuGsuAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n43YkN55Hn844ZFZsThv7oLpFkc4JA1QWJM2MFQH/Goq6rnskPZxfobFoQALjbESG
         vStX7Ww9Qr9zt1BeUUaHl1PB3U5uv2yOl6VC/sDFqVW7QKQej+MqE0SRH5q+FCw7sE
         OWRpTx6tKtngm/+kLlsJf4wvhoyaaiczy2vObqjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rafael David Tinoco <rafael.tinoco@linaro.org>
Subject: [PATCH 4.14 51/55] thermal/drivers/hisi: Fix configuration register setting
Date:   Thu,  6 Dec 2018 15:39:25 +0100
Message-Id: <20181206143004.500265888@linuxfoundation.org>
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

commit b424315a287c70eeb5f920f84c92492bd2f5658e upstream.

The TEMP0_CFG configuration register contains different field to set up the
temperature controller. However in the code, nothing prevents a setup to
overwrite the previous one: eg. writing the hdak value overwrites the sensor
selection, the sensor selection overwrites the hdak value.

In order to prevent such thing, use a regmap-like mechanism by reading the
value before, set the corresponding bits and write the result.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/hisi_thermal.c |   34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -30,6 +30,8 @@
 #define TEMP0_TH			(0x4)
 #define TEMP0_RST_TH			(0x8)
 #define TEMP0_CFG			(0xC)
+#define TEMP0_CFG_SS_MSK		(0xF000)
+#define TEMP0_CFG_HDAK_MSK		(0x30)
 #define TEMP0_EN			(0x10)
 #define TEMP0_INT_EN			(0x14)
 #define TEMP0_INT_CLR			(0x18)
@@ -132,19 +134,41 @@ static inline void hisi_thermal_enable(v
 	writel(value, addr + TEMP0_EN);
 }
 
-static inline void hisi_thermal_sensor_select(void __iomem *addr, int sensor)
+static inline int hisi_thermal_get_temperature(void __iomem *addr)
 {
-	writel((sensor << 12), addr + TEMP0_CFG);
+	return hisi_thermal_step_to_temp(readl(addr + TEMP0_VALUE));
 }
 
-static inline int hisi_thermal_get_temperature(void __iomem *addr)
+/*
+ * Temperature configuration register - Sensor selection
+ *
+ * Bits [19:12]
+ *
+ * 0x0: local sensor (default)
+ * 0x1: remote sensor 1 (ACPU cluster 1)
+ * 0x2: remote sensor 2 (ACPU cluster 0)
+ * 0x3: remote sensor 3 (G3D)
+ */
+static inline void hisi_thermal_sensor_select(void __iomem *addr, int sensor)
 {
-	return hisi_thermal_step_to_temp(readl(addr + TEMP0_VALUE));
+	writel((readl(addr + TEMP0_CFG) & ~TEMP0_CFG_SS_MSK) |
+	       (sensor << 12), addr + TEMP0_CFG);
 }
 
+/*
+ * Temperature configuration register - Hdak conversion polling interval
+ *
+ * Bits [5:4]
+ *
+ * 0x0 :   0.768 ms
+ * 0x1 :   6.144 ms
+ * 0x2 :  49.152 ms
+ * 0x3 : 393.216 ms
+ */
 static inline void hisi_thermal_hdak_set(void __iomem *addr, int value)
 {
-	writel(value, addr + TEMP0_CFG);
+	writel((readl(addr + TEMP0_CFG) & ~TEMP0_CFG_HDAK_MSK) |
+	       (value << 4), addr + TEMP0_CFG);
 }
 
 static long hisi_thermal_get_sensor_temp(struct hisi_thermal_data *data,



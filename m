Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6872AC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115AB20651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 02:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd1QktYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115AB20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeJXLKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:10:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46540 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeJXLKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:10:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id r64-v6so1641056pfb.13;
        Tue, 23 Oct 2018 19:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Z70I5UUHxwSFhYj51uL4iC1Yky3MsOgzPMgaF7+w4g=;
        b=gd1QktYI4tSMO7b4/Sa4QEmyvgmgmT7CGGcrEMLkX9QmgTXauLQvTafZCQKibRDKkT
         vPG2NQJPlSXSVGrbiDaYuh+Y2Q61V4++VbE0DKnGjy+Cqu5QvELXfIzXM12P53D4IXeQ
         wJdSeAe4bUD1ATrC9LX2JTHRd/UuntCD3xOzwcAtLFtlKtAubEf86D1HgkDw+v4Em51A
         HQqeuxExXHDvcocM5CTsRODmz6quI+XhEfV5bzuKmTf6sjQmroIfsMmkcwEhSN8k6XKJ
         YqJOwZll8NlzTSgDR+IWvi4EQkdAmPU1w5IMl7wHbPl107luLczM4BgpdY0GWLYlJYgY
         aUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Z70I5UUHxwSFhYj51uL4iC1Yky3MsOgzPMgaF7+w4g=;
        b=qbTpU0GG5RHPyPoKAATC6NtyAOTKqind7Hhrb4nuAUsWzzS/jocrwo8O7JHKu5fTa7
         DUbwBjtUzzvkhKjLmRiwvSb0pqKjk7+07fHa/Xaz2PYN5Eb471v4r32ZPS2cIn7rCqSa
         sOFXY4mVS6hi/Qh3VgMCiggTCcF0UWMBqlB3sfL4h0WC5ChW8OfLMAEQ1x4yWI4BPy/h
         7++/wt32k/RkjO42a7cK2lpuvLM8rvn5LpkeF/hj+YTTwkXnP7OLYo1cJGeIhLdcJRln
         MTHfY/bE2IV3EL/WhKKtXy8GcMfCvZhG3JeCj0BbzaEWq426mC0wYc0OE/UGcTZ6cUzC
         yZ1Q==
X-Gm-Message-State: AGRZ1gI+AmYK6F867f+423prosRAJ7rX47WEtFERczXLsdjKQmxKG295
        M/fXO9I5cAafMDurKs+hmr0=
X-Google-Smtp-Source: AJdET5f61svgfK4xDBFQfvnqk3YpIA5JLWOv6rPcJQxRtQWfV+ZdwIRSmFBw6ylkJMZXI5wj5s0LxA==
X-Received: by 2002:a63:aa48:: with SMTP id x8-v6mr764163pgo.87.1540348592184;
        Tue, 23 Oct 2018 19:36:32 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n17-v6sm3606625pfj.84.2018.10.23.19.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 19:36:31 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] hwmon: (ina3221) Make sure data is ready before reading
Date:   Tue, 23 Oct 2018 19:36:22 -0700
Message-Id: <20181024023623.4231-5-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181024023623.4231-1-nicoleotsuka@gmail.com>
References: <20181024023623.4231-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The data might need some time to get ready after channel enabling,
although the data register is always readable. The CVRF bit is to
indicate that data conversion is finished, so polling the CVRF bit
before data reading could ensure the result being valid.

An alternative way could be to wait for expected time between the
channel enabling and the data reading. And this could avoid extra
I2C communications. However, INA3221 seemly takes longer time than
what's stated in the datasheet. Test results show that sometimes
it couldn't finish data conversion in time.

So this patch plays safe by adding a CVRF polling to make sure the
data register is updated with the new data.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 * Moved CVRF polling to data read routine
 * Added calculation of wait time based on conversion time setting

 drivers/hwmon/ina3221.c | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 10e8347a3c80..9bbac826e50b 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -44,6 +44,13 @@
 #define INA3221_CONFIG_MODE_SHUNT	BIT(0)
 #define INA3221_CONFIG_MODE_BUS		BIT(1)
 #define INA3221_CONFIG_MODE_CONTINUOUS	BIT(2)
+#define INA3221_CONFIG_VSH_CT_SHIFT	3
+#define INA3221_CONFIG_VSH_CT_MASK	GENMASK(5, 3)
+#define INA3221_CONFIG_VSH_CT(x)	(((x) & GENMASK(5, 3)) >> 3)
+#define INA3221_CONFIG_VBUS_CT_SHIFT	6
+#define INA3221_CONFIG_VBUS_CT_MASK	GENMASK(8, 6)
+#define INA3221_CONFIG_VBUS_CT(x)	(((x) & GENMASK(8, 6)) >> 6)
+#define INA3221_CONFIG_CHs_EN_MASK	GENMASK(14, 12)
 #define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
 
 #define INA3221_RSHUNT_DEFAULT		10000
@@ -52,6 +59,9 @@ enum ina3221_fields {
 	/* Configuration */
 	F_RST,
 
+	/* Status Flags */
+	F_CVRF,
+
 	/* Alert Flags */
 	F_WF3, F_WF2, F_WF1,
 	F_CF3, F_CF2, F_CF1,
@@ -63,6 +73,7 @@ enum ina3221_fields {
 static const struct reg_field ina3221_reg_fields[] = {
 	[F_RST] = REG_FIELD(INA3221_CONFIG, 15, 15),
 
+	[F_CVRF] = REG_FIELD(INA3221_MASK_ENABLE, 0, 0),
 	[F_WF3] = REG_FIELD(INA3221_MASK_ENABLE, 3, 3),
 	[F_WF2] = REG_FIELD(INA3221_MASK_ENABLE, 4, 4),
 	[F_WF1] = REG_FIELD(INA3221_MASK_ENABLE, 5, 5),
@@ -111,6 +122,28 @@ static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
 	return ina->reg_config & INA3221_CONFIG_CHx_EN(channel);
 }
 
+/* Lookup table for Bus and Shunt conversion times in usec */
+static const u16 ina3221_conv_time[] = {
+	140, 204, 332, 588, 1100, 2116, 4156, 8244,
+};
+
+static inline int ina3221_wait_for_data(struct ina3221_data *ina)
+{
+	u32 channels = hweight16(ina->reg_config & INA3221_CONFIG_CHs_EN_MASK);
+	u32 vbus_ct_idx = INA3221_CONFIG_VBUS_CT(ina->reg_config);
+	u32 vsh_ct_idx = INA3221_CONFIG_VSH_CT(ina->reg_config);
+	u32 vbus_ct = ina3221_conv_time[vbus_ct_idx];
+	u32 vsh_ct = ina3221_conv_time[vsh_ct_idx];
+	u32 wait, cvrf;
+
+	/* Calculate total conversion time */
+	wait = channels * (vbus_ct + vsh_ct);
+
+	/* Polling the CVRF bit to make sure read data is ready */
+	return regmap_field_read_poll_timeout(ina->fields[F_CVRF],
+					      cvrf, cvrf, wait, 100000);
+}
+
 static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
 			      int *val)
 {
@@ -150,6 +183,12 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
 		if (!ina3221_is_enabled(ina, channel))
 			return -ENODATA;
 
+		ret = ina3221_wait_for_data(ina);
+		if (ret) {
+			dev_err(dev, "Timed out at waiting for CVRF bit\n");
+			return ret;
+		}
+
 		ret = ina3221_read_value(ina, reg, &regval);
 		if (ret)
 			return ret;
@@ -189,6 +228,13 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 	case hwmon_curr_input:
 		if (!ina3221_is_enabled(ina, channel))
 			return -ENODATA;
+
+		ret = ina3221_wait_for_data(ina);
+		if (ret) {
+			dev_err(dev, "Timed out at waiting for CVRF bit\n");
+			return ret;
+		}
+
 		/* fall through */
 	case hwmon_curr_crit:
 	case hwmon_curr_max:
-- 
2.17.1


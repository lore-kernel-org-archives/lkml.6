Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EF7ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA262064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sErbTQ7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA262064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeJYEDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:03:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39842 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeJYEDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:03:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id e67-v6so2693379plb.6;
        Wed, 24 Oct 2018 12:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6N/GlUC27cnYsO8+zk0TomAYmkISb/0zWfW0oqqa/6k=;
        b=sErbTQ7otRVfVKLq5aPLqwxhH55uaCnoAeVAY049QaAS3P50WXx8Hs2Rog83cIBpFZ
         382wk2YBvOnvUZCjz0EiXFmr5gORYVihL3DzoIlLcw0x7ht0DANk5rU094nEL55GUcwU
         NQfEg3+GAVvygjzOYq3FpFKAx686Ff083Z1++7nRHn6jXBbR0toAiGiv6/Wyv3dDD9s5
         1zl+s0CtsQJiFVu3f0cKIGm40HEo7KAXuwMmu7nXCx3hIhomJLmsiRFimiUCkGzOBzby
         XRhFcle8in07luWoCjamKch3s9CEAXlgg3uu8SbGLXIylg0gdEmPH9glHDjCLH+bRmwC
         YMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6N/GlUC27cnYsO8+zk0TomAYmkISb/0zWfW0oqqa/6k=;
        b=VrZwQCDFoUtsoOvxmR+Adq3essr4pEXehS6Xjt3axTNWN6KJIDFMnW8fZLeLKVDNCf
         Dec5L7LlUFKZl6hdG9LNCKqtSbBBNbqrYMGAuHbdzuhEdXtWbPT1wtNtc4Zzidg215DM
         rCCaiPJXEgnJdnbCB0utEV+8j088ECQ5/ygrDp3SZe5fysxr2KJ4p2JDMtrchtvuGhXR
         Bsi8g5RpW/F6qRB/d3GYXIDP9YcpOm6GKtmuXCCHKdBCIxS3IsC+thnU8Or688l2WJmI
         LH5qL+q2j4goMXmMT8gNvT/sLgykPxP37+B19NJt9BhMG8bc2Q85bSaXcFYdhijB3c80
         QP3A==
X-Gm-Message-State: AGRZ1gIIYTsORXkGaJhQJ12QFPjd24Kxe3HpJiMvaxNL1Sgxsm8TNJoy
        qTcQVqtYaeIOLB2TW+4HND8=
X-Google-Smtp-Source: AJdET5fxe1HMaJfd73kESiZr6J48PRLcVx8vyat77+zxJpZVSNpgwT/Ebnz2lzZirwNrauLeT+KF9Q==
X-Received: by 2002:a17:902:4103:: with SMTP id e3-v6mr3660408pld.236.1540409658897;
        Wed, 24 Oct 2018 12:34:18 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id r81-v6sm19921633pfa.110.2018.10.24.12.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 12:34:18 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] hwmon: (ina3221) Make sure data is ready before reading
Date:   Wed, 24 Oct 2018 12:34:01 -0700
Message-Id: <20181024193402.16698-5-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181024193402.16698-1-nicoleotsuka@gmail.com>
References: <20181024193402.16698-1-nicoleotsuka@gmail.com>
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
Changelog
v2->v3:
 * Dropped timeout dev_err messages as it's indicated in the errno
v1->v2:
 * Moved CVRF polling to data read routine
 * Added calculation of wait time based on conversion time setting

 drivers/hwmon/ina3221.c | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 10e8347a3c80..07dd6ef58d3e 100644
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
@@ -150,6 +183,10 @@ static int ina3221_read_in(struct device *dev, u32 attr, int channel, long *val)
 		if (!ina3221_is_enabled(ina, channel))
 			return -ENODATA;
 
+		ret = ina3221_wait_for_data(ina);
+		if (ret)
+			return ret;
+
 		ret = ina3221_read_value(ina, reg, &regval);
 		if (ret)
 			return ret;
@@ -189,6 +226,11 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 	case hwmon_curr_input:
 		if (!ina3221_is_enabled(ina, channel))
 			return -ENODATA;
+
+		ret = ina3221_wait_for_data(ina);
+		if (ret)
+			return ret;
+
 		/* fall through */
 	case hwmon_curr_crit:
 	case hwmon_curr_max:
-- 
2.17.1


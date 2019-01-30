Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF071C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D65218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWfwgR/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfA3XlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:41:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42970 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfA3Xk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:40:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so1304139wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=va7FohJb74SnkxiSXy6OUyKOGugG7nKO/rjO0ClvdL4=;
        b=DWfwgR/S65dcnqcYoUckc6KHlMzIkfG4A8idX/JzQvfSySSk+bp3uUPO7LG+ENuhJ+
         vB7T8r2WOTzdvHXrOdnnfBTHwXB3ubrcgB/yEtgWtBqiWOSgTYxSr0LKnxKptFBgW0VQ
         EA4rm2oiXDoj35lNwruiQOFi5x9WFDmF9RxYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=va7FohJb74SnkxiSXy6OUyKOGugG7nKO/rjO0ClvdL4=;
        b=CxRgNCpktXitRaBGHVKH4c9OiwaL2f3K9oTvbNAJT8sIH1Ngy1jA/WNdg/WdyeLLug
         zbQ4uzLUkEIMOvL7ENsliGTL+9bpPT1dVd8cJW7dswdR8AB9OyxIZ7xu8eyUpW8BSdEZ
         0CXljibIf3j0ikeCNWB3T4ZFJy32IB7y46ujoppy1EoCHN3iVc7ZHv4hXJeA79aFb4eh
         jwOQBP9W8rM+/lOjESl//MAlk7ljUvhNpfmHQbYNqFELjgcCT5TFnSI90MtQmzv0ySAV
         MLya8FHGFwhmmuuga4v8oGSDM1X8nSALhmDTbf4gnvyzVPD1DZo85qYKRRaUfs/m4Dik
         /zQg==
X-Gm-Message-State: AJcUukdxOpycxQPp4zwOmDXnSMzAA7gG/U2U/NsWhIT2uV1Q2lYWvKFE
        CTAKDUogEsgVyAKRGEDM9W976A==
X-Google-Smtp-Source: ALg8bN7HGJLOhi1O1SwzEq1m44+HzyrXHdnw0E1alfZC1PbnvM1Tc40WWTc+6HuSLzHfYO0JzrCdVQ==
X-Received: by 2002:adf:f4c2:: with SMTP id h2mr31258198wrp.21.1548891657975;
        Wed, 30 Jan 2019 15:40:57 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
        by smtp.gmail.com with ESMTPSA id s3sm2344770wmj.23.2019.01.30.15.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 15:40:57 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     mike.leach@linaro.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, saiprakash.ranjan@codeaurora.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com, arm@kernel.org
Subject: [PATCH v4 1/3] drivers: amba: Updates to component identification for driver matching.
Date:   Wed, 30 Jan 2019 23:40:49 +0000
Message-Id: <20190130234051.2294-2-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190130234051.2294-1-mike.leach@linaro.org>
References: <20190130234051.2294-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CoreSight specification (ARM IHI 0029E), updates the ID register
requirements for components on an AMBA bus, to cover both traditional
ARM Primecell type devices, and newer CoreSight and other components.

The Peripheral ID (PID) / Component ID (CID) pair is extended in certain
cases to uniquely identify components. CoreSight components related to
a single function can share Peripheral ID values, and must be further
identified using a Unique Component Identifier (UCI). e.g. the ETM, CTI,
PMU and Debug hardware of the A35 all share the same PID.

Bits 15:12 of the CID are defined to be the device class.
Class 0xF remains for PrimeCell and legacy components.
Class 0x9 defines the component as CoreSight (CORESIGHT_CID above)
Class 0x0, 0x1, 0xB, 0xE define components that do not have driver support
at present.
Class 0x2-0x8,0xA and 0xD-0xD are presently reserved.

The specification futher defines which classes of device use the standard
CID/PID pair, and when additional ID registers are required.

This patch introduces the amba_cs_uci_id structure which will be used in
all coresight drivers for indentification via the private data pointer in
the amba_id structure.

Existing drivers that currently use the amba_id->data pointer for private
data are updated to use the amba_cs_uci_id->data pointer. Macros and
inline functions are added to simplify this code.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x.c | 44 ++++++-------------
 drivers/hwtracing/coresight/coresight-priv.h  | 32 ++++++++++++++
 drivers/hwtracing/coresight/coresight-stm.c   | 14 ++----
 drivers/hwtracing/coresight/coresight-tmc.c   | 30 ++++---------
 include/linux/amba/bus.h                      | 33 ++++++++++++++
 5 files changed, 90 insertions(+), 63 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index fd5c4cca7db5..88c1280fdf91 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -871,7 +871,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	pm_runtime_put(&adev->dev);
-	dev_info(dev, "%s initialized\n", (char *)id->data);
+	dev_info(dev, "%s initialized\n", (char *)coresight_get_uci_data(id));
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
 		drvdata->boot_enable = true;
@@ -915,36 +915,18 @@ static const struct dev_pm_ops etm_dev_pm_ops = {
 };
 
 static const struct amba_id etm_ids[] = {
-	{	/* ETM 3.3 */
-		.id	= 0x000bb921,
-		.mask	= 0x000fffff,
-		.data	= "ETM 3.3",
-	},
-	{	/* ETM 3.5 - Cortex-A5 */
-		.id	= 0x000bb955,
-		.mask	= 0x000fffff,
-		.data	= "ETM 3.5",
-	},
-	{	/* ETM 3.5 */
-		.id	= 0x000bb956,
-		.mask	= 0x000fffff,
-		.data	= "ETM 3.5",
-	},
-	{	/* PTM 1.0 */
-		.id	= 0x000bb950,
-		.mask	= 0x000fffff,
-		.data	= "PTM 1.0",
-	},
-	{	/* PTM 1.1 */
-		.id	= 0x000bb95f,
-		.mask	= 0x000fffff,
-		.data	= "PTM 1.1",
-	},
-	{	/* PTM 1.1 Qualcomm */
-		.id	= 0x000b006f,
-		.mask	= 0x000fffff,
-		.data	= "PTM 1.1",
-	},
+	/* ETM 3.3 */
+	CS_AMBA_ID_DATA(0x000bb921, "ETM 3.3"),
+	/* ETM 3.5 - Cortex-A5 */
+	CS_AMBA_ID_DATA(0x000bb955, "ETM 3.5"),
+	/* ETM 3.5 */
+	CS_AMBA_ID_DATA(0x000bb956, "ETM 3.5"),
+	/* PTM 1.0 */
+	CS_AMBA_ID_DATA(0x000bb950, "PTM 1.0"),
+	/* PTM 1.1 */
+	CS_AMBA_ID_DATA(0x000bb95f, "PTM 1.1"),
+	/* PTM 1.1 Qualcomm */
+	CS_AMBA_ID_DATA(0x000b006f, "PTM 1.1"),
 	{ 0, 0},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 579f34943bf1..02a1f5204f9d 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -6,6 +6,7 @@
 #ifndef _CORESIGHT_PRIV_H
 #define _CORESIGHT_PRIV_H
 
+#include <linux/amba/bus.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/coresight.h>
@@ -159,4 +160,35 @@ static inline int etm_readl_cp14(u32 off, unsigned int *val) { return 0; }
 static inline int etm_writel_cp14(u32 off, u32 val) { return 0; }
 #endif
 
+/*
+ * Macros and inline functions to handle CoreSight UCI data and driver
+ * private data in AMBA ID table entries, and extract data values.
+ */
+
+/* coresight AMBA ID, no UCI, no driver data: id table entry */
+#define CS_AMBA_ID(pid)			\
+	{				\
+		.id	= pid,		\
+		.mask	= 0x000fffff,	\
+	}
+
+/* coresight AMBA ID, UCI with driver data only: id table entry. */
+#define CS_AMBA_ID_DATA(pid, dval)				\
+	{							\
+		.id	= pid,					\
+		.mask	= 0x000fffff,				\
+		.data	=  (void *)&(struct amba_cs_uci_id)	\
+			{				\
+				.data = (void *)dval,	\
+			}				\
+	}
+
+/* extract the data value from a UCI structure given amba_id pointer. */
+static inline void *coresight_get_uci_data(const struct amba_id *id)
+{
+	if (id->data)
+		return ((struct amba_cs_uci_id *)(id->data))->data;
+	return 0;
+}
+
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 35d6f9709274..31ff4e6279bc 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -874,7 +874,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 
 	pm_runtime_put(&adev->dev);
 
-	dev_info(dev, "%s initialized\n", (char *)id->data);
+	dev_info(dev, "%s initialized\n", (char *)coresight_get_uci_data(id));
 	return 0;
 
 stm_unregister:
@@ -909,16 +909,8 @@ static const struct dev_pm_ops stm_dev_pm_ops = {
 };
 
 static const struct amba_id stm_ids[] = {
-	{
-		.id     = 0x000bb962,
-		.mask   = 0x000fffff,
-		.data	= "STM32",
-	},
-	{
-		.id	= 0x000bb963,
-		.mask	= 0x000fffff,
-		.data	= "STM500",
-	},
+	CS_AMBA_ID_DATA(0x000bb962, "STM32"),
+	CS_AMBA_ID_DATA(0x000bb963, "STM500"),
 	{ 0, 0},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index ea249f0bcd73..2a02da3d630f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -443,7 +443,8 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		desc.type = CORESIGHT_DEV_TYPE_SINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
 		desc.ops = &tmc_etr_cs_ops;
-		ret = tmc_etr_setup_caps(drvdata, devid, id->data);
+		ret = tmc_etr_setup_caps(drvdata, devid,
+					 coresight_get_uci_data(id));
 		if (ret)
 			goto out;
 		break;
@@ -475,26 +476,13 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 }
 
 static const struct amba_id tmc_ids[] = {
-	{
-		.id     = 0x000bb961,
-		.mask   = 0x000fffff,
-	},
-	{
-		/* Coresight SoC 600 TMC-ETR/ETS */
-		.id	= 0x000bb9e8,
-		.mask	= 0x000fffff,
-		.data	= (void *)(unsigned long)CORESIGHT_SOC_600_ETR_CAPS,
-	},
-	{
-		/* Coresight SoC 600 TMC-ETB */
-		.id	= 0x000bb9e9,
-		.mask	= 0x000fffff,
-	},
-	{
-		/* Coresight SoC 600 TMC-ETF */
-		.id	= 0x000bb9ea,
-		.mask	= 0x000fffff,
-	},
+	CS_AMBA_ID(0x000bb961),
+	/* Coresight SoC 600 TMC-ETR/ETS */
+	CS_AMBA_ID_DATA(0x000bb9e8, (unsigned long)CORESIGHT_SOC_600_ETR_CAPS),
+	/* Coresight SoC 600 TMC-ETB */
+	CS_AMBA_ID(0x000bb9e9),
+	/* Coresight SoC 600 TMC-ETF */
+	CS_AMBA_ID(0x000bb9ea),
 	{ 0, 0},
 };
 
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index d143c13bed26..e3c36223e40b 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -25,6 +25,39 @@
 #define AMBA_CID	0xb105f00d
 #define CORESIGHT_CID	0xb105900d
 
+/*
+ * CoreSight Architecture specification updates the ID specification
+ * for components on the AMBA bus. (ARM IHI 0029E)
+ *
+ * Bits 15:12 of the CID are the device class.
+ *
+ * Class 0xF remains for PrimeCell and legacy components. (AMBA_CID above)
+ * Class 0x9 defines the component as CoreSight (CORESIGHT_CID above)
+ * Class 0x0, 0x1, 0xB, 0xE define components that do not have driver support
+ * at present.
+ * Class 0x2-0x8,0xA and 0xD-0xD are presently reserved.
+ *
+ * Remaining CID bits stay as 0xb105-00d
+ */
+
+/**
+ * Class 0x9 components use additional values to form a Unique Component
+ * Identifier (UCI), where peripheral ID values are identical for different
+ * components. Passed to the amba bus code from the component driver via
+ * the amba_id->data pointer.
+ * @devarch	: coresight devarch register value
+ * @devarch_mask: mask bits used for matching. 0 indicates UCI not used.
+ * @devtype	: coresight device type value
+ * @data	: additional driver data. As we have usurped the original
+ *		pointer some devices may still need additional data
+ */
+struct amba_cs_uci_id {
+	unsigned int devarch;
+	unsigned int devarch_mask;
+	unsigned int devtype;
+	void *data;
+};
+
 struct clk;
 
 struct amba_device {
-- 
2.19.1


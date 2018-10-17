Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C839ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB7221528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u+s1xYxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB7221528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeJQXuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:50:07 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:31522 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeJQXuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:50:04 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181017155340epoutp0292464d300eb7fd3c238239ba75661a73~ecFIkRy0Z2037720377epoutp02M;
        Wed, 17 Oct 2018 15:53:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181017155340epoutp0292464d300eb7fd3c238239ba75661a73~ecFIkRy0Z2037720377epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791620;
        bh=IPE4QZwtj36iCYq+US3BoBvPhzhDgbiYj05fqSwL6Io=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=u+s1xYxXtz+CIK06uxqJP3F8DCP3UXVjjFRrJ1aowxCjpHkPQQWwKOCSzSnKVSKpk
         rVCNINyqSilktx5mEN0KCALMGy30nvpSfg2XpFe+vPLvFs8Yuo9m1HiWyuy97wiau4
         Z+3q646fLojtH4Mjq59kPGv8l5mZ7AmX11v4ICIA=
Received: from epsmges1p3.samsung.com (unknown [182.195.42.55]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181017155339epcas1p3f720192fada686db2ad5391167b7e557~ecFHaptJT0323503235epcas1p3m;
        Wed, 17 Oct 2018 15:53:39 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.82.04073.30B57CB5; Thu, 18 Oct 2018 00:53:39 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181017155338epcas1p3a22cd0b22e757c3e51eb72ccee545478~ecFG8MQc90486304863epcas1p3R;
        Wed, 17 Oct 2018 15:53:38 +0000 (GMT)
X-AuditID: b6c32a37-3edff70000000fe9-9b-5bc75b0312c6
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 64.A6.03743.20B57CB5; Thu, 18 Oct
        2018 00:53:38 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:53:38 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Amit kucheria <amit.kucheria@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH v2 04/17] thermal: separate sensor registration and
 enable+check operations
Date:   Wed, 17 Oct 2018 17:52:30 +0200
Message-id: <1539791563-5959-5-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG+7Zzzo7LxWGKfiqIDqQUs8SsDy81xOiAFRER1KgcelDxNnbU
        0j90aVbeMy1NzWQaybC0uZx5IZ26ZZSZiop2wRTJuzDN0tCcR/97nu/9Pd/7vvCSfHEm7khG
        xSUwyjh5jIQQYk1d7l6H+TKT7OjyjCPKUFXz0OvSehxNm00AvczrwdCzoWEcddweBGjr5xyO
        PujTeehOmRpDNVMTAjTYUkEgc143QBWL4wI0NZFPoF86e6StHSXQ35ZKDLV/NwOpmE5fMhJ0
        2Y9PBP227JuAfjPmS1e3zfBorSaLoL8OtxF0XsYiQefrNIDWD1fy6fclaxhtGtXzaLPW+YLo
        qjAgnImJSmKUR06GCiN1C5mEYusJuLWasY6rwEpaNrAiIXUM5nc+xrOBkBRTzQDOF4zzOLMG
        oLm8COxR6oJljCs0AKjKKiU4sw7gbM1vvoUiKD9YeE+znSBJWyoE6upIyzOf6sHgpNndom2o
        a3B6SCOwaIxyg3WZI7gFF1FnYGORNdfLGfYai3CLtqJo2LdVtdMKUiUCuLGxvDtQMOzZaOJx
        2gbOmnQCyz+QcoIDPYG7/PY2688xztQDWPfRuBvwh12mLzg33AG4uJqLc2ERvH9XzCE0XJpo
        5XM7lgNoGswVPAAOVWCfBtgxCjY2gmG9FT5erDyWTYyL8AqLj9WCnePwONEMGvrOGgBFAom1
        qNnOKBPj8iQ2OdYAIMmX2IpSXE0ysShcnpzCKONvKBNjGNYAnEhMYi+acnwqE1MR8gQmmmEU
        jHKvyiOtHFUAcwk+dJp5pz4oT/YPYs8P/PP7HL8Srg4sdus7lyNb9bT/Qyw5Z7vM+9w0dEjb
        9USq/dPGSd/o/utzl3trE/uVLxoCFguPj6lthAP705yKN9nWK0hvHH4YikZCwra6H7EXF3Jk
        k2OunauXPFMrX4X5BTU5+FU2n8qR1ko3pesCCcZGyr09+EpW/h+PK1YqGAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t9jQV2m6OPRBkdPmFo0Nyxmstg4Yz2r
        xbPPxxkt1vYeZbGYf+Uaq8WBxsuMFv8fvWa1OLW9icmiZdYiFoslTx6yW1zeNYfN4nPvEUaL
        Oe9us1s8edjHZvFii7jFphU32Cx+7prHYrH33mdGByGPpvfH2Dxm3T/L5rFz1l12j623TD0W
        73nJ5LFpVSebx51re9g8epvfsXn0bVnF6LH92jxmjxPTv7N4HL+xncnj8ya5AN4oLpuU1JzM
        stQifbsErowtb1vZCv7PZKz42vyLtYHxS30XIyeHhICJxKL+DyxdjFwcQgLrGCU6tv5jhHB+
        MUpMPXafHaSKTcBKYmL7KqAEB4eIgLfEljUcIDXMAkdZJNbO+MYGUiMsECvx7MoqsHoWAVWJ
        Na3XWUHqeQXcJTZP5oFYJidx8thkVhCbU8BD4tz/BWCtQkAlJ3e8ZJ/AyLOAkWEVo2RqQXFu
        em6xUYFhXmq5XnFibnFpXrpecn7uJkZgBGw7rNW3g/H+kvhDjAIcjEo8vDvEjkULsSaWFVfm
        HmKU4GBWEuGtUjweLcSbklhZlVqUH19UmpNafIhRmoNFSZz3dt6xSCGB9MSS1OzU1ILUIpgs
        EwenVAPjSs1thVyVcs5G5ktX72v9+Pv+6YNvdq77qfDgZfbG31anRKdXB75e5SbQyPyTt0jl
        y/s/Rksi/xneV/awlzxydc4atvC8364ZJ8KPvK7b/VzeuT2ZMfF8alj97l8Gyi/DQv6LXimT
        imN3sgu9beYjWcVk+urPl/zAn3YH9lyt9357pSmqOppbiaU4I9FQi7moOBEA+TV+CXwCAAA=
X-CMS-MailID: 20181017155338epcas1p3a22cd0b22e757c3e51eb72ccee545478
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181017155338epcas1p3a22cd0b22e757c3e51eb72ccee545478
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155338epcas1p3a22cd0b22e757c3e51eb72ccee545478@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[devm]_thermal_zone_of_sensor_register() is used to register
thermal sensor by thermal drivers using DeviceTree. Besides
registering sensor this function also immediately:

- enables it:

  tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED)
  (->set_mode is set to of_thermal_set_mode() in of-thermal.c)

- checks it (indirectly by using of_thermal_set_mode()):

  thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
  (which in turn ends up using ->get_temp method).

For many DT thermal drivers this causes a problem because:

- [devm]_thermal_zone_of_sensor_register() need to be called in
  order to obtain data about thermal trips which are then used to
  finish hardware sensor setup (only after which ->get_temp can
  be used)

There is also related issue for DT thermal drivers that support
IRQ (i.e. exynos and rockchip ones):

- sensor hardware should be enabled only after IRQ handler is
  requested (because otherwise we might get IRQs that we can't
  handle)

- IRQ handler needs tzd structure which is obtained from
  [devm_]thermal_zone_of_sensor_register()

- after [devm_]thermal_zone_of_sensor_register() call core
  thermal code assumes that sensor is enabled and ready to use
  (i.e. that IRQ handler has been requested and sensor hardware
  has been enabled)

In order to prepare for fixing all abovementioned issues separate
sensor registration and enable+check operations in the core DT
thermal code and update DT thermal drivers accordingly:

* Move thermal_zone_[set_mode,device_check]() calls to the users of
  [devm]_thermal_zone_of_sensor_register().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/ahci_imx.c                             | 10 ++++++++--
 drivers/hwmon/hwmon.c                              |  5 +++++
 drivers/hwmon/ntc_thermistor.c                     |  4 ++++
 drivers/hwmon/scpi-hwmon.c                         |  4 ++++
 drivers/iio/adc/sun4i-gpadc-iio.c                  |  5 +++++
 drivers/input/touchscreen/sun4i-ts.c               |  8 +++++++-
 drivers/regulator/max8973-regulator.c              |  3 +++
 drivers/thermal/armada_thermal.c                   |  3 +++
 drivers/thermal/broadcom/bcm2835_thermal.c         |  3 +++
 drivers/thermal/broadcom/brcmstb_thermal.c         |  3 +++
 drivers/thermal/broadcom/ns-thermal.c              |  3 +++
 drivers/thermal/hisi_thermal.c                     |  3 +++
 drivers/thermal/max77620_thermal.c                 |  3 +++
 drivers/thermal/mtk_thermal.c                      |  3 +++
 drivers/thermal/of-thermal.c                       |  6 ------
 drivers/thermal/qcom-spmi-temp-alarm.c             |  3 +++
 drivers/thermal/qcom/tsens.c                       |  6 ++++++
 drivers/thermal/qoriq_thermal.c                    |  3 +++
 drivers/thermal/rcar_gen3_thermal.c                |  4 ++++
 drivers/thermal/rcar_thermal.c                     |  4 ++++
 drivers/thermal/rockchip_thermal.c                 |  3 +++
 drivers/thermal/samsung/exynos_tmu.c               |  3 +++
 drivers/thermal/tango_thermal.c                    |  5 +++++
 drivers/thermal/tegra/soctherm.c                   |  3 +++
 drivers/thermal/tegra/tegra-bpmp-thermal.c         |  3 +++
 drivers/thermal/thermal-generic-adc.c              |  3 +++
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  3 +++
 drivers/thermal/uniphier_thermal.c                 |  3 +++
 drivers/thermal/zx2967_thermal.c                   |  3 +++
 29 files changed, 106 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index b00799d..f1dcc3d 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -1141,6 +1141,7 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	    IS_ENABLED(CONFIG_HWMON)) {
 		/* Add the temperature monitor */
 		struct device *hwmon_dev;
+		struct thermal_zone_device *tzd;
 
 		hwmon_dev =
 			devm_hwmon_device_register_with_groups(dev,
@@ -1151,8 +1152,13 @@ static int imx_ahci_probe(struct platform_device *pdev)
 			ret = PTR_ERR(hwmon_dev);
 			goto disable_clk;
 		}
-		devm_thermal_zone_of_sensor_register(hwmon_dev, 0, hwmon_dev,
-					     &fsl_sata_ahci_of_thermal_ops);
+		tzd = devm_thermal_zone_of_sensor_register(hwmon_dev, 0,
+						hwmon_dev,
+						&fsl_sata_ahci_of_thermal_ops);
+		if (!IS_ERR(tzd)) {
+			thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
+			thermal_zone_device_check(tzd);
+		}
 		dev_info(dev, "%s: sensor 'sata_ahci'\n", dev_name(hwmon_dev));
 	}
 
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index ac1cdf8..486d7a0 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -161,6 +161,11 @@ static int hwmon_thermal_add_sensor(struct device *dev,
 	if (IS_ERR(tzd) && (PTR_ERR(tzd) != -ENODEV))
 		return PTR_ERR(tzd);
 
+	if (!IS_ERR(tzd)) {
+		thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check(tzd);
+	}
+
 	return 0;
 }
 #else
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index c52d07c..d423b0f 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -647,6 +647,10 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
 						  &ntc_of_thermal_ops);
 	if (IS_ERR(tz))
 		dev_dbg(dev, "Failed to register to thermal fw.\n");
+	else {
+		thermal_zone_set_mode(tz, THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check(tz);
+	}
 
 	return 0;
 }
diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 111d521..ad5c5d7 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -288,6 +288,10 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 		 */
 		if (IS_ERR(z))
 			devm_kfree(dev, zone);
+		else {
+			thermal_zone_set_mode(z, THERMAL_DEVICE_ENABLED);
+			thermal_zone_device_check(z);
+		}
 	}
 
 	return 0;
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 04d7147..ff67f72 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -659,6 +659,11 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 				PTR_ERR(info->tzd));
 			return PTR_ERR(info->tzd);
 		}
+		if (!IS_ERR(info->tzd)) {
+			thermal_zone_set_mode(info->tzd,
+					      THERMAL_DEVICE_ENABLED);
+			thermal_zone_device_check(info->tzd);
+		}
 	}
 
 	ret = devm_iio_device_register(&pdev->dev, indio_dev);
diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index d2e14d9..d38bf69 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -246,6 +246,7 @@ static int sun4i_ts_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct device *hwmon;
+	struct thermal_zone_device *tzd;
 	int error;
 	u32 reg;
 	bool ts_attached;
@@ -365,7 +366,12 @@ static int sun4i_ts_probe(struct platform_device *pdev)
 	if (IS_ERR(hwmon))
 		return PTR_ERR(hwmon);
 
-	devm_thermal_zone_of_sensor_register(ts->dev, 0, ts, &sun4i_ts_tz_ops);
+	tzd = devm_thermal_zone_of_sensor_register(ts->dev, 0, ts,
+						   &sun4i_ts_tz_ops);
+	if (!IS_ERR(tzd)) {
+		thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check(tzd);
+	}
 
 	writel(TEMP_IRQ_EN(1), ts->base + TP_INT_FIFOC);
 
diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index 9a522ed..65b445e 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -523,6 +523,9 @@ static int max8973_thermal_init(struct max8973_chip *mchip)
 		return ret;
 	}
 
+	thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(tzd);
+
 	if (mchip->irq <= 0)
 		return 0;
 
diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 2c2f6d9..5a07a8d 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -692,6 +692,9 @@ static int armada_thermal_probe(struct platform_device *pdev)
 			devm_kfree(&pdev->dev, sensor);
 			continue;
 		}
+
+		thermal_zone_set_mode(tz, THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check(tz);
 	}
 
 	return 0;
diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 23ad4f9..687a00c 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -227,6 +227,9 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
+	thermal_zone_set_mode(tz, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(tz);
+
 	/*
 	 * right now the FW does set up the HW-block, so we are not
 	 * touching the configuration registers.
diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 1919f91..3511ce6 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -336,6 +336,9 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	thermal_zone_set_mode(thermal, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(thermal);
+
 	priv->thermal = thermal;
 
 	irq = platform_get_irq(pdev, 0);
diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broadcom/ns-thermal.c
index 322e741..8ace201 100644
--- a/drivers/thermal/broadcom/ns-thermal.c
+++ b/drivers/thermal/broadcom/ns-thermal.c
@@ -71,6 +71,9 @@ static int ns_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(ns_thermal->tz);
 	}
 
+	thermal_zone_set_mode(ns_thermal->tz, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(ns_thermal->tz);
+
 	platform_set_drvdata(pdev, ns_thermal);
 
 	return 0;
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 6151e55..cc4e2ca 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -488,6 +488,9 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 		return ret;
 	}
 
+	thermal_zone_set_mode(sensor->tzd, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(sensor->tzd);
+
 	trip = of_thermal_get_trip_points(sensor->tzd);
 
 	for (i = 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
index e6bc69f..ffca9a7 100644
--- a/drivers/thermal/max77620_thermal.c
+++ b/drivers/thermal/max77620_thermal.c
@@ -125,6 +125,9 @@ static int max77620_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	thermal_zone_set_mode(mtherm->tz_device, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(mtherm->tz_device);
+
 	ret = devm_request_threaded_irq(&pdev->dev, mtherm->irq_tjalarm1, NULL,
 					max77620_thermal_irq,
 					IRQF_ONESHOT | IRQF_SHARED,
diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 0691f26..e18cb0e 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -766,6 +766,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_peri_therm;
 	}
 
+	thermal_zone_set_mode(tzdev, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(tzdev);
+
 	return 0;
 
 err_disable_clk_peri_therm:
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index f1dcb7d..523ac5c 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -494,12 +494,6 @@ struct thermal_zone_device *
 		if (sensor_specs.np == sensor_np && id == sensor_id) {
 			tzd = thermal_zone_of_add_sensor(child, sensor_np,
 							 data, ops);
-			if (!IS_ERR(tzd)) {
-				thermal_zone_set_mode(tzd,
-						      THERMAL_DEVICE_ENABLED);
-				thermal_zone_device_check(tzd);
-			}
-
 			of_node_put(sensor_specs.np);
 			of_node_put(child);
 			goto exit;
diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
index d3910be..7ba73ca 100644
--- a/drivers/thermal/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom-spmi-temp-alarm.c
@@ -320,6 +320,9 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 		return PTR_ERR(chip->tz_dev);
 	}
 
+	thermal_zone_set_mode(chip->tz_dev, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(chip->tz_dev);
+
 	return 0;
 }
 
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index a2c9bfa..dbd2556 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -98,12 +98,18 @@ static int tsens_register(struct tsens_device *tmdev)
 	for (i = 0;  i < tmdev->num_sensors; i++) {
 		tmdev->sensor[i].tmdev = tmdev;
 		tmdev->sensor[i].id = i;
+
 		tzd = devm_thermal_zone_of_sensor_register(tmdev->dev, i,
 							   &tmdev->sensor[i],
 							   &tsens_of_ops);
 		if (IS_ERR(tzd))
 			continue;
+
+		thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check(tzd);
+
 		tmdev->sensor[i].tzd = tzd;
+
 		if (tmdev->ops->enable)
 			tmdev->ops->enable(tmdev, i);
 	}
diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 450ed66..d8a80448 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -233,6 +233,9 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		goto err_tmu;
 	}
 
+	thermal_zone_set_mode(data->tz, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(data->tz);
+
 	/* Enable monitoring */
 	site = 0x1 << (15 - data->sensor_id);
 	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index e0d9424..c72453e 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -420,6 +420,10 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 			ret = PTR_ERR(zone);
 			goto error_unregister;
 		}
+
+		thermal_zone_set_mode(zone, THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check(zone);
+
 		tsc->zone = zone;
 
 		ret = of_thermal_get_ntrips(tsc->zone);
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 6619a48..f2f7ad3 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -566,6 +566,10 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		}
 
 		if (chip->use_of_thermal) {
+			thermal_zone_set_mode(priv->zone,
+					      THERMAL_DEVICE_ENABLED);
+			thermal_zone_device_check(priv->zone);
+
 			/*
 			 * thermal_zone doesn't enable hwmon as default,
 			 * but, enable it here to keep compatible
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 715f4cd..90d8175 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1161,6 +1161,9 @@ static int rockchip_configure_from_dt(struct device *dev,
 		return error;
 	}
 
+	thermal_zone_set_mode(sensor->tzd, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(sensor->tzd);
+
 	return 0;
 }
 
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 9e98b12..8ec74a62 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1109,6 +1109,9 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_sclk;
 	}
 
+	thermal_zone_set_mode(data->tzd, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(data->tzd);
+
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize TMU\n");
diff --git a/drivers/thermal/tango_thermal.c b/drivers/thermal/tango_thermal.c
index 4e67795..caa4036 100644
--- a/drivers/thermal/tango_thermal.c
+++ b/drivers/thermal/tango_thermal.c
@@ -90,6 +90,11 @@ static int tango_thermal_probe(struct platform_device *pdev)
 	tango_thermal_init(priv);
 
 	tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, priv, &ops);
+	if (!IS_ERR(tzdev)) {
+		thermal_zone_set_mode(tzdev, THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check(tzdev);
+	}
+
 	return PTR_ERR_OR_ZERO(tzdev);
 }
 
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index ed28110..2ac9f81 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1375,6 +1375,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			goto disable_clocks;
 		}
 
+		thermal_zone_set_mode(z, THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check(z);
+
 		zone->tz = z;
 		tegra->thermctl_tzs[soc->ttgs[i]->id] = z;
 
diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
index b0980db..3181110 100644
--- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
+++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
@@ -213,6 +213,9 @@ static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check(tzd);
+
 		zone->tzd = tzd;
 		INIT_WORK(&zone->tz_device_update_work,
 			  tz_device_update_work_fn);
diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index bf1c628..c1c3746 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -143,6 +143,9 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	thermal_zone_set_mode(gti->tz_dev, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(gti->tz_dev);
+
 	return 0;
 }
 
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index b80b6e2..aa15719 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -197,6 +197,9 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
 		return PTR_ERR(data->ti_thermal);
 	}
 
+	thermal_zone_set_mode(data->ti_thermal, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(data->ti_thermal);
+
 	ti_bandgap_set_sensor_data(bgp, id, data);
 	ti_bandgap_write_update_interval(bgp, data->sensor_id,
 					data->ti_thermal->polling_delay);
diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index bb95983..ed3a920 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -307,6 +307,9 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return PTR_ERR(tdev->tz_dev);
 	}
 
+	thermal_zone_set_mode(tdev->tz_dev, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(tdev->tz_dev);
+
 	/* get trip points */
 	trips = of_thermal_get_trip_points(tdev->tz_dev);
 	ntrips = of_thermal_get_ntrips(tdev->tz_dev);
diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
index 6acce0b..3c08e1d 100644
--- a/drivers/thermal/zx2967_thermal.c
+++ b/drivers/thermal/zx2967_thermal.c
@@ -168,6 +168,9 @@ static int zx2967_thermal_probe(struct platform_device *pdev)
 		goto disable_clk_all;
 	}
 
+	thermal_zone_set_mode(priv->tzd, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(priv->tzd);
+
 	if (priv->tzd->tzp->slope == 0) {
 		thermal_zone_of_sensor_unregister(&pdev->dev, priv->tzd);
 		dev_err(&pdev->dev, "coefficients of sensor is invalid\n");
-- 
1.9.1


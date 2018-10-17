Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836A9ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3596A2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VgzyAxaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3596A2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJQXto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:49:44 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:63163 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbeJQXtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:49:43 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181017155322epoutp012efa71b25e477579e11d8b0a67951db6~ecE3SZxfP2823228232epoutp01V;
        Wed, 17 Oct 2018 15:53:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181017155322epoutp012efa71b25e477579e11d8b0a67951db6~ecE3SZxfP2823228232epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791602;
        bh=zXiQkIrgh934kgpE1fNu/NcAgjpz4HbWCFW9J27Tr7I=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=VgzyAxaC0cwZ+qXceriaWTBZGODVYPX2VUgXM3owivqP7A2sZ+3qWW6mv42Ou9fAk
         mNnYkt3Re97RpodCOoSHUYxZ0Yu1BGnb/te1F6UoL/+lcuIGe+a0yDx56GmLhPoBfX
         Wl1HRDb4Xv4tIH1mxKXo1MfJpk7sItgNGXiKzOmg=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20181017155321epcas2p3012c65e8926fa7d3341db4b477877b90~ecE2nX5GY1998019980epcas2p3f;
        Wed, 17 Oct 2018 15:53:21 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.57.04015.1FA57CB5; Thu, 18 Oct 2018 00:53:21 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20181017155320epcas2p439b713149d94aa485b3c2ffba063ea03~ecE1lbude2479824798epcas2p4Y;
        Wed, 17 Oct 2018 15:53:20 +0000 (GMT)
X-AuditID: b6c32a45-6c1ff70000000faf-ce-5bc75af15d23
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id DF.34.03633.FEA57CB5; Thu, 18 Oct
        2018 00:53:20 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:53:19 +0900 (KST)
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
Subject: [PATCH v2 01/17] thermal: add thermal_zone_set_mode() helper
Date:   Wed, 17 Oct 2018 17:52:27 +0200
Message-id: <1539791563-5959-2-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTYRTHe+69u7sbrW7z7VFDaiSpmKaoPGWlH7JuFBGBUY6ooZcpOh27
        Kml9MCdp1kQNU9Y0U4MYvqSY74I63a0sWWim5guamKUYscoUzZi3vv3Oc35/nnPgULg8R+RB
        JSSnsrpkVZKClBItFt+wQ99jeOVhvsgZ6bOqMdRY1iBCC3YeoDrDAIEej4yKUM/tYYC25pZE
        6HVrNoZyjFUEqpmfFaPhDhOJ7IZ+gEwrH8VofraARIvNbqjp2RiJ1joqCNQ9bQeRcib7m5Vk
        jDNvSabdOCVmXkyEMtVdXzCmyXyXZCZHu0jGoF8hmYJmM2BaRytw5mXpKsHwY60YY2/yuiCL
        kR6LY5MS0lld4Inr0vjSkRpcOxN+436njcwCncH5QEJBOgTqV21YPpBScroNwJlaExCKVQDr
        B5fxfEBtW6WTnCMgp58D+LPsvOCsAzg8XSN2NEj6KCzKNQOH70yfhc21lOMZpwcI+Mnu62An
        OgpWrbVs6wTtDWfrxzAHy+jTsNtgwIWBvOAr6wORgyU0A4e2KknHX5CuEMOCiWJMkE7C3ie1
        QGAn+JVvFgvsCRfMjUAIlAK4vP6UEIoGAGvfWP+lw6GFfycSxtsF8yybYmFLGcy7IxcUBlr7
        B3Fhy0cAbtXxoBC4V4IdZuDKajmNmuWCtUEBnErDpSWrA2JTNE1g+zb8otpA2dC5PkBTQLFT
        RrtblXKRKp3L0PQBSOEKZ1nmfl4pl8WpMjJZXco1XVoSy/UBT4pQuMnmPMuVclqtSmUTWVbL
        6v53MUrikQUkpj8D0WHeuUb9qdwjEnN7odv8nDq3jN7r5dcT2Vty83fCQX+esW1c1upDjBs+
        amJfV3DWnoASS7k5tMDF9XNcNO/vs3jpXmDiVL2sYuH4mPTWxhnM5cCq/cPDFvdsNvaqKTxC
        snu88YetenTzom5tvm8porxRY7vyqzjF//24guDiVUF+uI5T/QVS2jxNFwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t9jQd0PUcejDb4t57NobljMZLFxxnpW
        i2efjzNarO09ymIx/8o1VosDjZcZLf4/es1qcWp7E5NFy6xFLBZLnjxkt7i8aw6bxefeI4wW
        c97dZrd48rCPzeLFFnGLTStusFn83DWPxWLvvc+MDkIeTe+PsXnMun+WzWPnrLvsHltvmXos
        3vOSyWPTqk42jzvX9rB59Da/Y/Po27KK0WP7tXnMHiemf2fxOH5jO5PH501yAbxRXDYpqTmZ
        ZalF+nYJXBnTryxhLrhvXdGz+wJbA+Nuoy5GDg4JAROJ6XeKuxi5OIQE1jFKbJ4xjwXC+cUo
        sX7TD6YuRk4ONgEriYntqxhBGkQEvCW2rOEAqWEWOMoisXbGNzaQGmEBV4lFP7exg9gsAqoS
        D9fdAOvlFXCX2NvbywxiSwjISZw8NpkVxOYU8JA4938BWK8QUM3JHS/ZJzDyLGBkWMUomVpQ
        nJueW2xUYJSXWq5XnJhbXJqXrpecn7uJERj+2w5r9e9gfLwk/hCjAAejEg/vDrFj0UKsiWXF
        lbmHGCU4mJVEeKsUj0cL8aYkVlalFuXHF5XmpBYfYpTmYFES5+XPPxYpJJCeWJKanZpakFoE
        k2Xi4JRqYFzxZu+/OQ/N2zQV1pld55Z8d9jbrKa1+WCB8PrtGzPcfd3esjN/y/rlzeV76lnK
        vMmG9d+lJ7x+48Rl/+L8/czvz/LLBENabR3chOpV1Lbo3p+jlng9xfw1a07hO+dra3eu3bd3
        uTfPM6UJLzfM2zaxfF1XqrdvSV/i0h/nat4bNO1Z8pPZhlWJpTgj0VCLuag4EQBeA3DAewIA
        AA==
X-CMS-MailID: 20181017155320epcas2p439b713149d94aa485b3c2ffba063ea03
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181017155320epcas2p439b713149d94aa485b3c2ffba063ea03
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155320epcas2p439b713149d94aa485b3c2ffba063ea03@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to remove the code duplication and prepare for further
changes:

* Add thermal_zone_set_mode() helper. Then update core code and
  drivers to use it.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/hisi_thermal.c     | 14 ++------------
 drivers/thermal/of-thermal.c       |  3 ++-
 drivers/thermal/rockchip_thermal.c | 26 +++++++++-----------------
 drivers/thermal/thermal_helpers.c  | 14 ++++++++++++++
 drivers/thermal/thermal_sysfs.c    |  8 +++++---
 include/linux/thermal.h            |  5 +++++
 6 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 761d055..b3f8d9f 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -515,15 +515,6 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 };
 MODULE_DEVICE_TABLE(of, of_hisi_thermal_match);
 
-static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
-				       bool on)
-{
-	struct thermal_zone_device *tzd = sensor->tzd;
-
-	tzd->ops->set_mode(tzd,
-		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
-}
-
 static int hisi_thermal_probe(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data;
@@ -571,7 +562,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		}
 	}
 
-	hisi_thermal_toggle_sensor(&data->sensor, true);
+	thermal_zone_set_mode((&data->sensor)->tzd, THERMAL_DEVICE_ENABLED);
 
 	return 0;
 }
@@ -579,9 +570,8 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 static int hisi_thermal_remove(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
-	struct hisi_thermal_sensor *sensor = &data->sensor;
 
-	hisi_thermal_toggle_sensor(sensor, false);
+	thermal_zone_set_mode((&data->sensor)->tzd, THERMAL_DEVICE_DISABLED);
 
 	data->disable_sensor(data);
 
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 4f28165..118910c 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -496,7 +496,8 @@ struct thermal_zone_device *
 			tzd = thermal_zone_of_add_sensor(child, sensor_np,
 							 data, ops);
 			if (!IS_ERR(tzd))
-				tzd->ops->set_mode(tzd, THERMAL_DEVICE_ENABLED);
+				thermal_zone_set_mode(tzd,
+						      THERMAL_DEVICE_ENABLED);
 
 			of_node_put(sensor_specs.np);
 			of_node_put(child);
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index f36375d..2edd44c 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1022,15 +1022,6 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 };
 MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
 
-static void
-rockchip_thermal_toggle_sensor(struct rockchip_thermal_sensor *sensor, bool on)
-{
-	struct thermal_zone_device *tzd = sensor->tzd;
-
-	tzd->ops->set_mode(tzd,
-		on ? THERMAL_DEVICE_ENABLED : THERMAL_DEVICE_DISABLED);
-}
-
 static irqreturn_t rockchip_thermal_alarm_irq_thread(int irq, void *dev)
 {
 	struct rockchip_thermal_data *thermal = dev;
@@ -1292,7 +1283,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	thermal->chip->control(thermal->regs, true);
 
 	for (i = 0; i < thermal->chip->chn_num; i++)
-		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
+		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
+				      THERMAL_DEVICE_ENABLED);
 
 	platform_set_drvdata(pdev, thermal);
 
@@ -1311,11 +1303,9 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
 	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < thermal->chip->chn_num; i++) {
-		struct rockchip_thermal_sensor *sensor = &thermal->sensors[i];
-
-		rockchip_thermal_toggle_sensor(sensor, false);
-	}
+	for (i = 0; i < thermal->chip->chn_num; i++)
+		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
+				      THERMAL_DEVICE_DISABLED);
 
 	thermal->chip->control(thermal->regs, false);
 
@@ -1332,7 +1322,8 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
 	int i;
 
 	for (i = 0; i < thermal->chip->chn_num; i++)
-		rockchip_thermal_toggle_sensor(&thermal->sensors[i], false);
+		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
+				      THERMAL_DEVICE_DISABLED);
 
 	thermal->chip->control(thermal->regs, false);
 
@@ -1383,7 +1374,8 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 	thermal->chip->control(thermal->regs, true);
 
 	for (i = 0; i < thermal->chip->chn_num; i++)
-		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
+		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
+				      THERMAL_DEVICE_ENABLED);
 
 	pinctrl_pm_select_default_state(dev);
 
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 2ba756a..b18cee2 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -224,3 +224,17 @@ int thermal_zone_get_offset(struct thermal_zone_device *tz)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_offset);
+
+/**
+ * thermal_zone_set_mode() - sets mode of thermal zone device
+ * @tz: a valid pointer to a struct thermal_zone_device
+ * @mode: mode to be set
+ *
+ * Return: On success returns 0, an error code otherwise.
+ */
+int thermal_zone_set_mode(struct thermal_zone_device *tz,
+			  enum thermal_device_mode mode)
+{
+	return tz->ops->set_mode(tz, mode);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_set_mode);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 2241cea..2e9e762 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -69,17 +69,19 @@
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	int result;
+	enum thermal_device_mode mode;
 
 	if (!tz->ops->set_mode)
 		return -EPERM;
 
 	if (!strncmp(buf, "enabled", sizeof("enabled") - 1))
-		result = tz->ops->set_mode(tz, THERMAL_DEVICE_ENABLED);
+		mode = THERMAL_DEVICE_ENABLED;
 	else if (!strncmp(buf, "disabled", sizeof("disabled") - 1))
-		result = tz->ops->set_mode(tz, THERMAL_DEVICE_DISABLED);
+		mode = THERMAL_DEVICE_DISABLED;
 	else
-		result = -EINVAL;
+		return -EINVAL;
 
+	result = thermal_zone_set_mode(tz, mode);
 	if (result)
 		return result;
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5f4705f..9d21fd1 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -452,6 +452,8 @@ struct thermal_cooling_device *
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 int thermal_zone_get_slope(struct thermal_zone_device *tz);
 int thermal_zone_get_offset(struct thermal_zone_device *tz);
+int thermal_zone_set_mode(struct thermal_zone_device *tz,
+			  enum thermal_device_mode mode);
 
 int get_tz_trend(struct thermal_zone_device *, int);
 struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
@@ -518,6 +520,9 @@ static inline int thermal_zone_get_slope(
 static inline int thermal_zone_get_offset(
 		struct thermal_zone_device *tz)
 { return -ENODEV; }
+static inline int thermal_zone_set_mode(
+		struct thermal_zone_device *tz, enum thermal_device_mode mode)
+{ return -ENODEV; }
 static inline int get_tz_trend(struct thermal_zone_device *tz, int trip)
 { return -ENODEV; }
 static inline struct thermal_instance *
-- 
1.9.1


Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7614ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C14321528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AZrx7/HQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C14321528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeJQXt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:49:58 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:31501 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeJQXt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:49:58 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181017155334epoutp02bd8925a5f3fd046b73d015c2fddabcda~ecFDHUVWv2037720377epoutp02L;
        Wed, 17 Oct 2018 15:53:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181017155334epoutp02bd8925a5f3fd046b73d015c2fddabcda~ecFDHUVWv2037720377epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791614;
        bh=53+PoU65i0BeaWqbTJPfGy0Z01gG7y7JijUIPI9SaCc=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=AZrx7/HQwJoqCY3BJbhFziB+pOQhrtZTIU6Nyku82rorjzQF88Snf3h8Iebn4zL+y
         MFFYOmJ8HIBDpsBtJoHtAH/MJH9FR/ZHraFQOdGB4nDPPB9Fu+j0Z0FKXpzhfknHp+
         Ji6stQX/8sbKV9aHvLD5xHoWikp8t6sy9tx3g7MI=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20181017155333epcas2p260b5a85d31424e3733b8ba46fe906fbc~ecFB-it-k1311413114epcas2p2q;
        Wed, 17 Oct 2018 15:53:33 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1C.57.04015.DFA57CB5; Thu, 18 Oct 2018 00:53:33 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20181017155332epcas2p499ac9d53678d82a9984b3533e723a0dd~ecFBJmu-t0750407504epcas2p45;
        Wed, 17 Oct 2018 15:53:32 +0000 (GMT)
X-AuditID: b6c32a45-6c1ff70000000faf-dc-5bc75afd992a
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 32.44.03633.CFA57CB5; Thu, 18 Oct
        2018 00:53:32 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:53:32 +0900 (KST)
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
Subject: [PATCH v2 03/17] thermal: separate sensor enable and check
 operations
Date:   Wed, 17 Oct 2018 17:52:29 +0200
Message-id: <1539791563-5959-4-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTHO3d3d9fR4jbN/VTwsfAPJS2j6Ic9SMq6VIRSgrSoRl5UdDo2
        FTXyMR+poBhFLVsmLkNWYY6V71CnW0aKj2GiltlDKqMHI5aGWdvV/z7nfL+H8z1waIG0VOhP
        p2ZkcZoMZbqcEpNPrWF7IlbO2BU7ZuaDcUmRkcCt+hYhXnDaAT+qHiTxXcekEPcWTwBefbco
        xC/adAQurWsk8b0P8yI80WmgsLN6ALDh24wIf5ivofAniwybm6covNRZT+KeN044KGV1320U
        Wzc3TLEdda9F7JPp3ayx+zPBmk2VFDs72U2x1SXfKLbGYgK2bbJewD6/6SJZ+1QbwTrNgXGS
        M+J9SVx6ag6n2X7ggjjlQcczQt19Mnd4dExQBGUxVeBFI2YX6vk7J3SzlGkHVN4UXQXi/+wC
        5OhbFaybzKVGIS88BuTqvUvxxTKgxi/jHhfFRKOrV0xQBTTtwxxHloe0uy1gBkn03hnmZm8m
        DhlK68HNJBOKPq/+8LCEOYqKHa+AXxaIhmzXPIm8GBaNrDZ4diHmpgiNm26RvOkwMnTZ1tgb
        fbFbRDwHoAVTK6wNAPq63ETyRQughy9tBO/ai6z2MSEfbxOqsK6I3KkRI0EV5VIeWdTyK5s/
        8jagBn0bUQt+DbDBBL6cWqtK5rQ71VGRWqVKm52RHHkxU2UGz2+Ex7aDfuREPzA0yDdKGD+b
        QipU5mjzVP2AaIHcR5IfYldIJUnKvHxOk3lek53OafshgCblMsm7gDsKKZOszOLSOE7NadZV
        gvbyL4LEAu/FBEU5bA2W0eJKY7zx99PNA1t0UwXnshz6tzm109tOCw7Fu3JrFyNiy/Cxj2OG
        uqDCy7LJjsSwa44bf4LO/TyVCkMrK73NvmcTHUfuDyZZO9HobIJqrqAvRJbQ5Ty/sL/Z1BFk
        N9X/DB1p0S1dclkthdBeHZNAXNdvS5OT2hRlVLhAo1X+A2bQrIQXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t9jQd0/UcejDZ4d1rBobljMZLFxxnpW
        i2efjzNarO09ymIx/8o1VosDjZcZLf4/es1qcWp7E5NFy6xFLBZLnjxkt7i8aw6bxefeI4wW
        c97dZrd48rCPzeLFFnGLTStusFn83DWPxWLvvc+MDkIeTe+PsXnMun+WzWPnrLvsHltvmXos
        3vOSyWPTqk42jzvX9rB59Da/Y/Po27KK0WP7tXnMHiemf2fxOH5jO5PH501yAbxRXDYpqTmZ
        ZalF+nYJXBmrd+5jKtjjV3H2wkXmBsZWxy5GTg4JAROJTS2LWbsYuTiEBNYxSiyf8p0dwvnF
        KLF9/zxWkCo2ASuJie2rGLsYOThEBLwltqzhAKlhFjjKIrF2xjc2kBphAT+JQ1sfMYLYLAKq
        Ei//fwCzeQXcJRqvXGeE2CYncfLYZLCZnAIeEuf+LwDrFQKqObnjJfsERp4FjAyrGCVTC4pz
        03OLjQqM8lLL9YoTc4tL89L1kvNzNzECI2DbYa3+HYyPl8QfYhTgYFTi4d0hdixaiDWxrLgy
        9xCjBAezkghvleLxaCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8/PnHIoUE0hNLUrNTUwtSi2Cy
        TBycUg2Mm/7zrt3Sttqe4Z4JQ9bKuV7bOApe3WyozV8uw6zzxGTrhjnXfL4aqa1j6N4XUsz6
        L3DOGZvsbRm5FceknvAtWbTMf0b9HLvwf/cSfuXp/F1mvky7sbcy46rYw9h1duwHBE0FInY4
        s135/2jJ4nsT/PqjVbzV1020NlDbObmqxT93SZYqb8ViJZbijERDLeai4kQALGxvvnwCAAA=
X-CMS-MailID: 20181017155332epcas2p499ac9d53678d82a9984b3533e723a0dd
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181017155332epcas2p499ac9d53678d82a9984b3533e723a0dd
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155332epcas2p499ac9d53678d82a9984b3533e723a0dd@epcas2p4.samsung.com>
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
sensor enable and check operations in the core thermal code and
update thermal drivers accordingly:

* Add set_mode_skip_check flag to struct thermal_zone_device_ops and
  set it in drivers that don't check the thermal zone device in their
  ->set_mode method implementations.

* Move thermal_zone_device_check() from ->set_mode implementations to
  the users of thermal_zone_set_mode() (only place which calls
  ->set_mode). Modify mode_store() in thermal_sysfs.c accordingly.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/acpi/thermal.c                             |  2 ++
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  2 --
 drivers/platform/x86/acerhdf.c                     |  2 ++
 drivers/thermal/db8500_thermal.c                   |  2 ++
 drivers/thermal/hisi_thermal.c                     |  2 ++
 drivers/thermal/imx_thermal.c                      |  2 --
 drivers/thermal/int340x_thermal/int3400_thermal.c  |  1 +
 drivers/thermal/of-thermal.c                       |  6 +++---
 drivers/thermal/rockchip_thermal.c                 | 16 ++++++++++++----
 drivers/thermal/thermal_sysfs.c                    |  3 +++
 include/linux/thermal.h                            |  2 ++
 11 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index b8b275e1..a7e3d9e 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -879,6 +879,8 @@ static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
 	.get_crit_temp = thermal_get_crit_temp,
 	.get_trend = thermal_get_trend,
 	.notify = thermal_notify,
+
+	.set_mode_skip_check = true,
 };
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index b0afd36..5f4b3bd 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -170,8 +170,6 @@ static int mlxsw_thermal_set_mode(struct thermal_zone_device *tzdev,
 
 	thermal->mode = mode;
 
-	thermal_zone_device_check(tzdev);
-
 	return 0;
 }
 
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 5a2b93a..884fd83 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -507,6 +507,8 @@ static int acerhdf_get_crit_temp(struct thermal_zone_device *thermal,
 	.get_trip_hyst = acerhdf_get_trip_hyst,
 	.get_trip_temp = acerhdf_get_trip_temp,
 	.get_crit_temp = acerhdf_get_crit_temp,
+
+	.set_mode_skip_check = true,
 };
 
 
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index ab66b2d7..c4d0fb1 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -220,6 +220,8 @@ static int db8500_sys_get_crit_temp(struct thermal_zone_device *thermal,
 	.get_trip_type = db8500_sys_get_trip_type,
 	.get_trip_temp = db8500_sys_get_trip_temp,
 	.get_crit_temp = db8500_sys_get_crit_temp,
+
+	.set_mode_skip_check = true,
 };
 
 static void db8500_thermal_update_config(struct db8500_thermal_zone *pzone,
diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 63d4fc3..6151e55 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -561,6 +561,7 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 	}
 
 	thermal_zone_set_mode((&data->sensor)->tzd, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check((&data->sensor)->tzd);
 
 	return 0;
 }
@@ -570,6 +571,7 @@ static int hisi_thermal_remove(struct platform_device *pdev)
 	struct hisi_thermal_data *data = platform_get_drvdata(pdev);
 
 	thermal_zone_set_mode((&data->sensor)->tzd, THERMAL_DEVICE_DISABLED);
+	thermal_zone_device_check((&data->sensor)->tzd);
 
 	data->disable_sensor(data);
 
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 22f57ef..7abad6c 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -385,8 +385,6 @@ static int imx_set_mode(struct thermal_zone_device *tz,
 
 	data->mode = mode;
 
-	thermal_zone_device_check(tz);
-
 	return 0;
 }
 
diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index e26b01c..d1f0641 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -305,6 +305,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 	if (priv->uuid_bitmap & 1 << INT3400_THERMAL_PASSIVE_1) {
 		int3400_thermal_ops.get_mode = int3400_thermal_get_mode;
 		int3400_thermal_ops.set_mode = int3400_thermal_set_mode;
+		int3400_thermal_ops.set_mode_skip_check = true;
 	}
 	priv->thermal = thermal_zone_device_register("INT3400 Thermal", 0, 0,
 						priv, &int3400_thermal_ops,
diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index c422b08..f1dcb7d 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -272,8 +272,6 @@ static int of_thermal_set_mode(struct thermal_zone_device *tz,
 
 	data->mode = mode;
 
-	thermal_zone_device_check(tz);
-
 	return 0;
 }
 
@@ -496,9 +494,11 @@ struct thermal_zone_device *
 		if (sensor_specs.np == sensor_np && id == sensor_id) {
 			tzd = thermal_zone_of_add_sensor(child, sensor_np,
 							 data, ops);
-			if (!IS_ERR(tzd))
+			if (!IS_ERR(tzd)) {
 				thermal_zone_set_mode(tzd,
 						      THERMAL_DEVICE_ENABLED);
+				thermal_zone_device_check(tzd);
+			}
 
 			of_node_put(sensor_specs.np);
 			of_node_put(child);
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 5640675..715f4cd 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1281,9 +1281,11 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	thermal->chip->control(thermal->regs, true);
 
-	for (i = 0; i < thermal->chip->chn_num; i++)
+	for (i = 0; i < thermal->chip->chn_num; i++) {
 		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
 				      THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check((&thermal->sensors[i])->tzd);
+	}
 
 	platform_set_drvdata(pdev, thermal);
 
@@ -1302,9 +1304,11 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
 	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < thermal->chip->chn_num; i++)
+	for (i = 0; i < thermal->chip->chn_num; i++) {
 		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
 				      THERMAL_DEVICE_DISABLED);
+		thermal_zone_device_check((&thermal->sensors[i])->tzd);
+	}
 
 	thermal->chip->control(thermal->regs, false);
 
@@ -1320,9 +1324,11 @@ static int __maybe_unused rockchip_thermal_suspend(struct device *dev)
 	struct rockchip_thermal_data *thermal = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < thermal->chip->chn_num; i++)
+	for (i = 0; i < thermal->chip->chn_num; i++) {
 		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
 				      THERMAL_DEVICE_DISABLED);
+		thermal_zone_device_check((&thermal->sensors[i])->tzd);
+	}
 
 	thermal->chip->control(thermal->regs, false);
 
@@ -1372,9 +1378,11 @@ static int __maybe_unused rockchip_thermal_resume(struct device *dev)
 
 	thermal->chip->control(thermal->regs, true);
 
-	for (i = 0; i < thermal->chip->chn_num; i++)
+	for (i = 0; i < thermal->chip->chn_num; i++) {
 		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
 				      THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check((&thermal->sensors[i])->tzd);
+	}
 
 	pinctrl_pm_select_default_state(dev);
 
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 3b38fb9..ac39fb6 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -85,6 +85,9 @@
 	if (result)
 		return result;
 
+	if (!tz->ops->set_mode_skip_check)
+		thermal_zone_device_check(tz);
+
 	return count;
 }
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 3e325b3..92c460e 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -113,6 +113,8 @@ struct thermal_zone_device_ops {
 			  enum thermal_trend *);
 	int (*notify) (struct thermal_zone_device *, int,
 		       enum thermal_trip_type);
+
+	bool set_mode_skip_check;
 };
 
 struct thermal_cooling_device_ops {
-- 
1.9.1


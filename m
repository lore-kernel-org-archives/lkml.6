Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AEEECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2BD2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dAMSNETS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2BD2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeJQXvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:51:23 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:13018 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:51:23 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181017155501epoutp045191e2d958d75bf6499617949fd5cccc~ecGUCVN1e0668806688epoutp04A;
        Wed, 17 Oct 2018 15:55:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181017155501epoutp045191e2d958d75bf6499617949fd5cccc~ecGUCVN1e0668806688epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791701;
        bh=pxP8DeqDYXDPZXv4SFu8SA/qiItJUsaW7Awn5Qn1Be0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=dAMSNETSIcj8dLe9dodtUIqpMspcbShWqKbbkEH/ZjZY4cJw8/uhF2ulkl9KN9d23
         G3eQiWQUEqtyCyjEJIPARt6u35BYyt/H/UzBNtR4q9640lPwi+yjCHZVi6ecaQPA6m
         XlfzdgDiqGAVA8efkz6KSG9OH5Na9X+e1E6Rnv/M=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181017155500epcas1p30b76f626586f26847a992f2333dc01dc~ecGSsGYO40486304863epcas1p3l;
        Wed, 17 Oct 2018 15:55:00 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.3F.04073.45B57CB5; Thu, 18 Oct 2018 00:55:00 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181017155459epcas1p470bd73f433cdbb0f7a11aa8d46212e4e~ecGSCM97Z0540205402epcas1p4a;
        Wed, 17 Oct 2018 15:54:59 +0000 (GMT)
X-AuditID: b6c32a35-69fff70000000fe9-0b-5bc75b548924
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id EE.A6.03743.35B57CB5; Thu, 18 Oct
        2018 00:54:59 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:54:59 +0900 (KST)
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
Subject: [PATCH v2 17/17] thermal: warn on attempts to read temperature on
 disabled sensors
Date:   Wed, 17 Oct 2018 17:52:43 +0200
Message-id: <1539791563-5959-18-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHfXcuO4qzwzR9VTAaSGhqCUkvXaQPSgf1Q0EYNDVHHlTadOyo
        pRF4WWrWpMhSl5rmpRBFHTMvKYi6rQ0TzUtiamhmmmblKNGw1Tz67fd/nt/D87zwUpj4DuFF
        JaeksaoUmVxCOuGvBvyCAi9JTdLj40suKC+7VoDayloItGQ1AdSsMeDo2fgkgfpyxgCyLawS
        yNKRK0Bq7XMc1S3OC9FYdwWJrJpBgCrWPwjR4nwxiZb1Hkj3copEW91VOOqds4JzYib3u5Fk
        tB/fkkyXdlbItE+HMLU9KwJG13iXZGYme0hGk7dOMsX6RsB0TFZhzJvSTZwxTXUIGKvO54Lo
        itOZBFaenMGqjoXGOyUZ84YIZfGBm3NbZiwbdDgXAUcK0idgbqsNKwJOlJjuBFA7mUfyYRNA
        y5dmsG+VzPYRfKMVwC5LKc6HbQDV9U27Fkmfgg8LGv8zRbnRkVDfRNnLGG3A4Sern51d6Vi4
        sNCM2xmnfeGTIT1mZxHNwPLVcZJf5gPNxkeEnR3/14dt1bsXQbpUCMt/FGC8FAbXXmuEPLvC
        rya90L4X0t7wneHsng/g2nY9zocWAJuGjAJ+4DQcMI0S/HUucP3XfYIfFsHCfDGvMNBc1rb3
        yKcAlhRWkA+AZzVwaATurJJTJLJcsDI4iJMpuPSUxKBrqQod2P0c/iGdoGQ4qh/QFJA4izrd
        jVIxIcvgMhX9AFKYxE2UddgkFYsSZJlZrCr1qipdznL9wJvCJR6iRa9KqZhOlKWx11lWyar2
        uwLK0SsbmOmoGxXKeZ/Lnr+tf0cjZz7bonMCFA5/Yridg+raiZ/56qqm+frAjX6d74tmOXHb
        p118qyHm6HnGIbB7Rd0bQU+HWwySythD75NKvThvYYTemNV+pD4uPD0kumFEuNx3rybKJb7u
        cVJA6MmJGlk4Wxl3UTr4bdhBu7EyshMWLsG5JFmwP6biZP8As9ovKxgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t9jQd3g6OPRBsuOylo0Nyxmstg4Yz2r
        xbPPxxkt1vYeZbGYf+Uaq8WBxsuMFv8fvWa1OLW9icmiZdYiFoslTx6yW1zeNYfN4nPvEUaL
        Oe9us1s8edjHZvFii7jFphU32Cx+7prHYrH33mdGByGPpvfH2Dxm3T/L5rFz1l12j623TD0W
        73nJ5LFpVSebx51re9g8epvfsXn0bVnF6LH92jxmjxPTv7N4HL+xncnj8ya5AN4oLpuU1JzM
        stQifbsEroxjzWdYC/r4K+79PMncwLidp4uRk0NCwERiyt0DrF2MXBxCAusYJe7cmAPl/GKU
        eDT1HCtIFZuAlcTE9lWMXYwcHCIC3hJb1nCA1DALHGWRWDvjGxtIjbBArMSjR2tZQGwWAVWJ
        aWe2MIPYvAIeEjNfX2GD2CYncfLYZLCZnEDxc/8XgMWFBNwlTu54yT6BkWcBI8MqRsnUguLc
        9NxiowLDvNRyveLE3OLSvHS95PzcTYzACNh2WKtvB+P9JfGHGAU4GJV4eHeIHYsWYk0sK67M
        PcQowcGsJMJbpXg8Wog3JbGyKrUoP76oNCe1+BCjNAeLkjjv7bxjkUIC6YklqdmpqQWpRTBZ
        Jg5OqQZG4U83D1r9+hdfezDspmNX+PREh4AaIx2P5NUFirrPNrIxKq5IZnE1XxKkyVZp8TFx
        ovu5AwtrlmwUb3vPtf2VRd76Pg+HY+silKOPxvhr8ivw3rBwtBX+cPjwzLi2Jt77u7OCrq7x
        1FE9PUlY/vDm9G1lJy96C8u+Wl2ju1IoLLr205+fzV+VWIozEg21mIuKEwGb2RIwfAIAAA==
X-CMS-MailID: 20181017155459epcas1p470bd73f433cdbb0f7a11aa8d46212e4e
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181017155459epcas1p470bd73f433cdbb0f7a11aa8d46212e4e
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155459epcas1p470bd73f433cdbb0f7a11aa8d46212e4e@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Add ops_of_thermal flag to struct thermal_zone_device_ops and
  set it in of-thermal.c.

* Add checking sensor mode for drivers using of-thermal.c to
  thermal_zone_get_temp() (print a warning if sensor is disabled).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/of-thermal.c      |  2 ++
 drivers/thermal/thermal_helpers.c | 12 ++++++++++++
 include/linux/thermal.h           |  1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 523ac5c..912bd85 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -378,6 +378,8 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 
 	.bind = of_thermal_bind,
 	.unbind = of_thermal_unbind,
+
+	.ops_of_thermal = true,
 };
 
 /***   sensor API   ***/
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 14b7a7e..12d1f53 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -84,6 +84,18 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
 		goto exit;
 
+	if (tz->ops->ops_of_thermal) {
+		enum thermal_device_mode mode;
+
+		ret = tz->ops->get_mode(tz, &mode);
+		if (ret)
+			goto exit;
+
+		if (mode == THERMAL_DEVICE_DISABLED)
+			dev_warn_once(&tz->device,
+				 "trying to read out disabled thermal zone\n");
+	}
+
 	mutex_lock(&tz->lock);
 
 	ret = tz->ops->get_temp(tz, temp);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 92c460e..2215e11 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -115,6 +115,7 @@ struct thermal_zone_device_ops {
 		       enum thermal_trip_type);
 
 	bool set_mode_skip_check;
+	bool ops_of_thermal;
 };
 
 struct thermal_cooling_device_ops {
-- 
1.9.1


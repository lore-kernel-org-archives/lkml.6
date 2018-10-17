Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC167ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CC821528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EACGM29p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CC821528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeJQXu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:50:29 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:18354 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:50:28 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181017155406epoutp03538e316b4a990c068c5e462cf58fe10b~ecFgWozoZ1091710917epoutp03O;
        Wed, 17 Oct 2018 15:54:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181017155406epoutp03538e316b4a990c068c5e462cf58fe10b~ecFgWozoZ1091710917epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791646;
        bh=iglxUMcPMhfUuAOYi+sNjf7vJUSJgka/85V7M93nyvo=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=EACGM29piTvSiEhaji4eos+8X4qK51JbT2mkk/T4h6aalTldLIuJnnC51nsckKNjO
         immpZDnPcgdyoCNXh1PB5FeRYyJKWk8YZKjTk78y3voLTZ6lrqZLi+IYWjHBISUcED
         S+PWwkAsuH0AkQtQ0mEJb/Egcjn/pZsTQxM9JLuA=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20181017155405epcas2p476aa1492bd61ab944ab4b6a3dd14c842~ecFfuBoPz2479824798epcas2p4r;
        Wed, 17 Oct 2018 15:54:05 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        EE.4F.04069.D1B57CB5; Thu, 18 Oct 2018 00:54:05 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181017155403epcas2p1ed9777e96c6b2c77c2c5b67466be9843~ecFeBb2NA1266212662epcas2p1Y;
        Wed, 17 Oct 2018 15:54:03 +0000 (GMT)
X-AuditID: b6c32a48-e59ff70000000fe5-05-5bc75b1dc546
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 44.44.03633.B1B57CB5; Thu, 18 Oct
        2018 00:54:03 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:54:03 +0900 (KST)
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
Subject: [PATCH v2 08/17] thermal: qcom: tsens: enable+check sensor after
 its setup is finished
Date:   Wed, 17 Oct 2018 17:52:34 +0200
Message-id: <1539791563-5959-9-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSfyyUcRzue/e+771uvXo74huLdeUPNkqjfadm2TTfJat/2lrXlot3KI7d
        i+IP49xE7aQwOT9HoZuSC4exyY87STZdM0tIocKU3WRYiXv573k+z/Ps83y2Dy2WaUk3Ok6V
        zKlVyng5JSXa+rwDfY8oLIqT602eKDuzVoSanzSRaN5mAeiFboBAVR/HSNSTZQVo6+siiYZM
        GhHS6msI9HR2RoKsneUUsun6ASpfnpCg2Zl8Cv1ocUXGhnEKrXdWEqh7ygbOybDml5nC+un3
        FO7QT0pw66dAXNv1U4SNhjwKfx7rorAue5nC+S0GgE1jlWI8WLJGYMu4SYRtRo/LzDXp2Wgu
        Pi6VU58IjpTGvnkwIErapO6acivEmWCJvA8caMgGwA+Tq9tYSsvYdgBzXveKBbIG4JcyPbHn
        yl0pogThFYCLOVVAIBsATi48FO+4KDYIPrpn2BZo2pkNhy2N9M5YzA4Q8JvNe2fsxCrhYL3d
        TbBeUPOu0I4ZNgx2dzdIhF0e8K250N7OgcVwZKvavheyJRI4M7EIBFMobNP8EQnYCS5YWnbD
        7nDe0Ax2AwAubTwjBNIEYOOweTdxBvZZRkmhnSPM7fsr2WkHWQbm5sgEC4YldXX262VsGYBD
        LyUF4HA12GcALlwSnxDD8aeSAvx4ZQKfoorxi0pMMAL7b/jgdtAzcrEXsDSQ72faXcwKGalM
        5dMSegGkxXJnJv2oRSFjopVp6Zw68YY6JZ7je4E7TchdmRn3CoWMjVEmc7c5LolT76ki2sEt
        Ewy5aPs9T49Pe80HZF/Q3XI0FwbjfwXqoOUiaePc0OM7xSuLYW2xq7rwno6brdczagaXv0c6
        eVr1qoNRx7SXj4eEGKvN02RGSL8jebXJNcuqag+9Ej43ZZOPVkmHbaUbv/N8/cNKD5mKI7wY
        n0vODBsxqrWe33TlD9S7jfY/z5YTfKzS30es5pX/Ad6jLTAXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t9jQV3p6OPRBgd7NC2aGxYzWWycsZ7V
        4tnn44wWa3uPsljMv3KN1eJA42VGi/+PXrNanNrexGTRMmsRi8WSJw/ZLS7vmsNm8bn3CKPF
        nHe32S2ePOxjs3ixRdxi04obbBY/d81jsdh77zOjg5BH0/tjbB6z7p9l89g56y67x9Zbph6L
        97xk8ti0qpPN4861PWwevc3v2Dz6tqxi9Nh+bR6zx4np31k8jt/YzuTxeZNcAG8Ul01Kak5m
        WWqRvl0CV8bB7qNMBb/ZKrZ3zGVuYHzD2sXIySEhYCLR8XEKWxcjF4eQwDpGiV2nvzFBOL8Y
        Jb7t/c4OUsUmYCUxsX0VYxcjB4eIgLfEljUcIDXMAkdZJNbO+MYGUiMskCjx+948MJtFQFWi
        6fRkZhCbV8BdYu/eFewQ2+QkTh6bDLaZU8BD4tz/BWD1QkA1J3e8ZJ/AyLOAkWEVo2RqQXFu
        em6xUYFRXmq5XnFibnFpXrpecn7uJkZgBGw7rNW/g/HxkvhDjAIcjEo8vDvEjkULsSaWFVfm
        HmKU4GBWEuGtUjweLcSbklhZlVqUH19UmpNafIhRmoNFSZyXP/9YpJBAemJJanZqakFqEUyW
        iYNTqoGxPL7QbOLq24dLm6Idy07EH+s5GpKs/N/4+Ldkl5i/xRETfOZdurn1tVtBoucpvVPH
        76XOfl+f4rXucp53UFabJXf0vVLFvVM+cz48lLxOt+iPTMSHXy07eFOC2WqWxm7ZNOWJkde3
        qRv3hot++vGx6dYlm3Vzptu3PW8JFfkvs0mVIzlCQ+awEktxRqKhFnNRcSIAY1i+L3wCAAA=
X-CMS-MailID: 20181017155403epcas2p1ed9777e96c6b2c77c2c5b67466be9843
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181017155403epcas2p1ed9777e96c6b2c77c2c5b67466be9843
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155403epcas2p1ed9777e96c6b2c77c2c5b67466be9843@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable+check sensor after setting tmdev->sensor[i].tzd and calling
chipset specific enable operation.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/qcom/tsens.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index dbd2556..01bff96 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -105,13 +105,13 @@ static int tsens_register(struct tsens_device *tmdev)
 		if (IS_ERR(tzd))
 			continue;
 
-		thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
-		thermal_zone_device_check(tzd);
-
 		tmdev->sensor[i].tzd = tzd;
 
 		if (tmdev->ops->enable)
 			tmdev->ops->enable(tmdev, i);
+
+		thermal_zone_set_mode(tzd, THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check(tzd);
 	}
 	return 0;
 }
-- 
1.9.1


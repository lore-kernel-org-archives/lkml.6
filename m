Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D992FECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E562150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e/WnkwCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E562150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbeJQXur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:50:47 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:18416 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:50:46 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181017155424epoutp036af53c68a83d83721de404c5f7b6c4a9~ecFxqA1Er1091710917epoutp03S;
        Wed, 17 Oct 2018 15:54:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181017155424epoutp036af53c68a83d83721de404c5f7b6c4a9~ecFxqA1Er1091710917epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791664;
        bh=EVdvRRzAO2L/q6VAysCXdYzmLoTBThv6IQRdbpQDC8g=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=e/WnkwCGr1aaqxvtyTfysIwhUEulEeKGOkacVp6xh/fGu2Ed7PyQchMyLXNNw8+rj
         sqNgfcWB89po3KSMjW68lRYqLZ9bNltfvJJawOG2F33xMfhtAQpoMcS6kHg65S5R0+
         NauurvQaXJpLKLOqGzX4mfbAEIBju+VqK7uPPWPY=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017155423epcas1p2915446b973abf6fffd0f48c11b2941f4~ecFwtwIfD2587525875epcas1p2B;
        Wed, 17 Oct 2018 15:54:23 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.4D.04078.F2B57CB5; Thu, 18 Oct 2018 00:54:23 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017155422epcas1p1644d897c62ceb36b57d33ecd4e3bc81c~ecFvYHYxN2660926609epcas1p11;
        Wed, 17 Oct 2018 15:54:22 +0000 (GMT)
X-AuditID: b6c32a36-b25ff70000000fee-f6-5bc75b2fd120
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id E9.A6.03743.E2B57CB5; Thu, 18 Oct
        2018 00:54:22 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:54:22 +0900 (KST)
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
Subject: [PATCH v2 11/17] thermal: rockchip_thermal: enable+check sensor
 after its setup is finished
Date:   Wed, 17 Oct 2018 17:52:37 +0200
Message-id: <1539791563-5959-12-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHfXcuO462TkfTt1mSCz+oeIuMN03xg8IJ+xB9EdsHHXqalzll
        RyUNwksX0zYyMctMzXvLsuY1MdB5WYYKqZiYZpaEulRkiCmEOU9++z/P8/s//+eFl8KYAkJO
        JWkzOJ1WpVGQErxzwMvX119pUQasWXxQQW6dCL170kqgXzYLQK/1QziqnpomUF/eJEB7P6wE
        +tSVL0K3K2pxVL+0KEaTPZUksukHAapc/ypGS4sGEi23uyJT8wyJdnqqcPThmw2EM2z+xjDJ
        ViyMkez7inkx2zEbxNb1rohYk/E+yc5N95KsvmCdZA3tRsB2TVdh7MfybZy1zHSJWJvJ/Yr0
        muRiAqdJyuJ0/mFxksS6hi0svUR6Y/CRVZQLdiRFwJGC9DnYY3iMFQEJxdDdAM5uLmD2AUNv
        A1i9yhxC+tEiQoDeAvj7adN/xy6AVVUmwk6RdDAsuWcERYCinOko2N5C2dsYPYTDnzYvu3ai
        r8OR1mKxXeO0J8ydqiftWkqz8N78MiaEucOR4dKDlY77/fG9GtKeBelSMexrWiMFKAJWvOnH
        Be0EVy3tYnsupN3gxFCowJfvH7rbgAtFK4Ato8MiwRACByyfCeE6GVzfekAIZiksvMsIkoU7
        Vo3wxmcAbpjbwENwogY4GIELl86nqjk+MP2sH69K5TO1ar/4tFQTOPga3ue7Qe34ZTOgKaA4
        Iu12GVYyhCqLz041A0hhCmdpjodFyUgTVNk5nC4tVpep4XgzcKNwhat0Sf5cydBqVQaXwnHp
        nO5wKqIc5bngjiHle1njy0Zr5pmjEk/1i7GFzajwYx5Tmo7jDpE+2gunT8YTtD+8mekf7iUu
        HpBpL/15BTfd+cKQiQ0cj4uJlq3pA1Z85jLiwlb02Wmhnd5zKltblmjIkBcRaSqTJdMOUVeT
        bf3z3c2nvIy30oKjx2uCdF/+ymLMgcHyWEqB84mqQG9Mx6v+AdzyqlIWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t9jQV296OPRBpO/Clo0Nyxmstg4Yz2r
        xbPPxxkt1vYeZbGYf+Uaq8WBxsuMFv8fvWa1OLW9icmiZdYiFoslTx6yW1zeNYfN4nPvEUaL
        Oe9us1s8edjHZvFii7jFphU32Cx+7prHYrH33mdGByGPpvfH2Dxm3T/L5rFz1l12j623TD0W
        73nJ5LFpVSebx51re9g8epvfsXn0bVnF6LH92jxmjxPTv7N4HL+xncnj8ya5AN4oLpuU1JzM
        stQifbsErozFS78yF0zkrTgy6TVTA+NPri5GTg4JAROJ3jNdrF2MXBxCAusYJbbe6mSCcH4x
        Ssw4dosRpIpNwEpiYvsqIJuDQ0TAW2LLGg6QGmaBoywSa2d8YwOpERZIk1h5pgHMZhFQlWi4
        sgTM5hXwkGi/+4IZYpucxMljk1lBbE6g+Ln/C8BqhATcJU7ueMk+gZFnASPDKkbJ1ILi3PTc
        YqMCw7zUcr3ixNzi0rx0veT83E2MwAjYdlirbwfj/SXxhxgFOBiVeHh3iB2LFmJNLCuuzD3E
        KMHBrCTCW6V4PFqINyWxsiq1KD++qDQntfgQozQHi5I47+28Y5FCAumJJanZqakFqUUwWSYO
        TqkGxrSzzj9bny7+asyXrLpl1UEZCX7WqJAKY2ejGvWYfAljD7E0a4uVss83Hu1YxCc4Odtz
        1ybZn5cfvAva3mH3lVvBoLy2RIcvtWVRp2xv+mne2FvP8vXbwm453Q1I7g3+fHfZhg+nE6ZG
        bJc3n9SV+TyTl+1Klt6io67HWh7/0Cjy/bi8dvodJZbijERDLeai4kQADcsMZnwCAAA=
X-CMS-MailID: 20181017155422epcas1p1644d897c62ceb36b57d33ecd4e3bc81c
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181017155422epcas1p1644d897c62ceb36b57d33ecd4e3bc81c
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155422epcas1p1644d897c62ceb36b57d33ecd4e3bc81c@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Enable+check sensor explicitly in rockchip_thermal_probe() (also
  check sensor after doing chipset specific control operation).

* Remove superfluous second sensor enable+check attempt.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/rockchip_thermal.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 90d8175..ef9e2aa 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1161,9 +1161,6 @@ static int rockchip_configure_from_dt(struct device *dev,
 		return error;
 	}
 
-	thermal_zone_set_mode(sensor->tzd, THERMAL_DEVICE_ENABLED);
-	thermal_zone_device_check(sensor->tzd);
-
 	return 0;
 }
 
@@ -1272,6 +1269,10 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 		}
 	}
 
+	for (i = 0; i < thermal->chip->chn_num; i++)
+		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
+				      THERMAL_DEVICE_ENABLED);
+
 	error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					  &rockchip_thermal_alarm_irq_thread,
 					  IRQF_ONESHOT,
@@ -1284,11 +1285,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	thermal->chip->control(thermal->regs, true);
 
-	for (i = 0; i < thermal->chip->chn_num; i++) {
-		thermal_zone_set_mode((&thermal->sensors[i])->tzd,
-				      THERMAL_DEVICE_ENABLED);
+	for (i = 0; i < thermal->chip->chn_num; i++)
 		thermal_zone_device_check((&thermal->sensors[i])->tzd);
-	}
 
 	platform_set_drvdata(pdev, thermal);
 
-- 
1.9.1


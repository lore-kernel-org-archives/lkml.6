Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73D3ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38A92150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CdaqCIiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38A92150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeJQXuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:50:15 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:12808 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:50:14 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181017155352epoutp043607b889f6e2ff3cd430dd41af30d6c8~ecFT2duyJ1081110811epoutp04M;
        Wed, 17 Oct 2018 15:53:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181017155352epoutp043607b889f6e2ff3cd430dd41af30d6c8~ecFT2duyJ1081110811epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791632;
        bh=+LQAm2YggAZ+WEiZTLMgtllvteUFmBuEekm20hRy5lQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=CdaqCIiq/b4mNO3D4puA+U8gndAJmOXF5X21hGuFzv5npF5kASoEPgGdMZBfA0dKV
         T5qZqVKqfb/CzM6Ndn8uU+epMX94oie88xUtFzQofZs9gg94D1146fTu7QDkjTx1I3
         7uTxrv/nX3mjR71gC4YYDHXxBuMGJ6aTXvg9tA78=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017155352epcas1p17a3b7143594b6af0954f966abbf18055~ecFTin_ZK2660926609epcas1p1q;
        Wed, 17 Oct 2018 15:53:52 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.D9.04081.01B57CB5; Thu, 18 Oct 2018 00:53:52 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017155351epcas1p171637911ef29cdec96dda648cfac51a5~ecFSfWAxx1224012240epcas1p1T;
        Wed, 17 Oct 2018 15:53:51 +0000 (GMT)
X-AuditID: b6c32a39-689ff70000000ff1-39-5bc75b10e106
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 07.A6.03743.F0B57CB5; Thu, 18 Oct
        2018 00:53:51 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:53:51 +0900 (KST)
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
Subject: [PATCH v2 06/17] thermal: brcmstb: enable+check sensor after its
 setup is finished
Date:   Wed, 17 Oct 2018 17:52:32 +0200
Message-id: <1539791563-5959-7-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe3cuO44Wp03cm4K1VR9UNAWF17KQKDxggX6KNcRGnnR5ZUdF
        zcLmmjp0ZFKaecsbJl7SLM0L2XRbeaNamKYzvGRWYsQwyQ8Z89S3//95fs8NHgqT6AlPSpOS
        zmpT1EkKUoQ/G/EJ9KdVNlXgerEM5ec1CFBXRSeBVp02gNpLLDiqfT9NoOGbdoB2lr4TaKxX
        J0D6ynocNa4sCpG9v4pEzpJRgKo25oRoZdFEorUeGepumSHR7/4aHA0tOEG4hNH9sJJM5adJ
        knle6RAyTz+GMA2DXwVMd2sRycxPD5JMSf4GyZh6WgHTO12DMa/Kt3DGNtMrYJzd3lHii6Kw
        ODZJk8lqj526JEow/Sok0x4Js77cH8XyQD1pBBQF6WD4p0BjBCJKQvcBOKAbI3izBeBE75TQ
        CNx2IYO5GuMTjwE0zzTivNkGsHq1g3BRJH0clha0AldbdzoS9rRRrjBGW3C47PRxaSkdA0u7
        9MClcfooNPwsx1xaTEdAR4cd54d5w9fWst2WbjQDp3bqSNcsSJcL4VyFGfDQGWgyfiZ5LYXf
        bD1C/hwv+M5y8h8P4Pp2E86bTgDbJqwCvuAEHLG9Jfjt9sGNzWKCLxbDQoOERxioG9om+SMf
        AGhfuovfBgfqwJ5W4MGmccnxLBeUFhLAqZO5jJT4gMupyd1g9zd8Q/uAdeqcGdAUUOwV93lY
        VRJCncllJ5sBpDCFuzhHblNJxHHq7BxWmxqrzUhiOTPwonCFTLziWa2S0PHqdDaRZdNY7f+s
        gHLzzAPps0yWLbvgjlCxHNmgV1JtLzlZtMFSIG8WLCid5sl5h7T6YH/s0pXFRPt4xUJWzJNb
        D68VSY1dh4PfBJ7fxE6b/HTXE3Ob3T1VL/RJoTciokLLripb7F5HBsI0Zw/BaPm4dj7XsWn3
        q51VXtg/HL52b/WDxX+yWdmU2WGVtytwLkEd5ItpOfVf6sam6RcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t9jQV3+6OPRBhNuClg0Nyxmstg4Yz2r
        xbPPxxkt1vYeZbGYf+Uaq8WBxsuMFv8fvWa1OLW9icmiZdYiFoslTx6yW1zeNYfN4nPvEUaL
        Oe9us1s8edjHZvFii7jFphU32Cx+7prHYrH33mdGByGPpvfH2Dxm3T/L5rFz1l12j623TD0W
        73nJ5LFpVSebx51re9g8epvfsXn0bVnF6LH92jxmjxPTv7N4HL+xncnj8ya5AN4oLpuU1JzM
        stQifbsEroy+bx1sBSvZK57PPMLcwLiIrYuRk0NCwESi7dBc5i5GLg4hgXWMEhs3XIRyfjFK
        rJ/3gh2kik3ASmJi+yrGLkYODhEBb4ktazhAapgFjrJIrJ3xDWySsECsxOZ9a8FsFgFVibaP
        05lBbF4Bd4m76y6zQGyTkzh5bDIriM0p4CFx7v8CsHohoJqTO16yT2DkWcDIsIpRMrWgODc9
        t9iowDAvtVyvODG3uDQvXS85P3cTIzACth3W6tvBeH9J/CFGAQ5GJR7eHWLHooVYE8uKK3MP
        MUpwMCuJ8FYpHo8W4k1JrKxKLcqPLyrNSS0+xCjNwaIkzns771ikkEB6YklqdmpqQWoRTJaJ
        g1OqgZFt5WLJ65GTZlpt3jHj78xQd61ikVPbNzlvqf/xWEy7ptSGKYPtqc3FedcWC7hseZW4
        d9K5beqBr4Wn2rtO+f51VbdbWMyDYJafvuGLrXJ/3rjYYqdcwzTrRumtdV+3VHnsFryQqLDq
        Yf+C5ACpK2UJO7P/1q1jfut5POnkdIcXol/tjth1Wt1XYinOSDTUYi4qTgQA75LOYXwCAAA=
X-CMS-MailID: 20181017155351epcas1p171637911ef29cdec96dda648cfac51a5
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181017155351epcas1p171637911ef29cdec96dda648cfac51a5
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155351epcas1p171637911ef29cdec96dda648cfac51a5@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable+check sensor after setting priv->thermal.

Cc: Markus Mayer <mmayer@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 3511ce6..5650a6a 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -336,11 +336,11 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	priv->thermal = thermal;
+
 	thermal_zone_set_mode(thermal, THERMAL_DEVICE_ENABLED);
 	thermal_zone_device_check(thermal);
 
-	priv->thermal = thermal;
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "could not get IRQ\n");
-- 
1.9.1


Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CAFECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047C021537
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dp8Qmq57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047C021537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeJQXue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:50:34 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:12874 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:50:33 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20181017155411epoutp043b3a9aa575bb8570a99b7df764b657ac~ecFltWc_-0668806688epoutp044;
        Wed, 17 Oct 2018 15:54:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20181017155411epoutp043b3a9aa575bb8570a99b7df764b657ac~ecFltWc_-0668806688epoutp044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791652;
        bh=fjqApFgO1XTp91HWbt7qKPbS5qEV11jI5OGBzjdAFiY=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=dp8Qmq57p/KQ/u4Wp3A0+XVvVbYPAfJH11IpeivpdGLy1eoDjosfGQWsCiso+xflk
         LuEzyTICqEDNmoKfkYVwDEEV3cLvY4jlORHAGV3toPE/fUszgXHwmC2trf8PgwDC4q
         1DikfeYXtDnm9VcMoaRjouI/z/PR9lvRHF4X66D4=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20181017155411epcas2p3c90e292309e9b0b754e4fcf11cade851~ecFk-rUiG2604526045epcas2p3f;
        Wed, 17 Oct 2018 15:54:11 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.67.04015.32B57CB5; Thu, 18 Oct 2018 00:54:11 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20181017155409epcas2p41b5770668abdb4af99646841a3dd24ec~ecFjzPh010750407504epcas2p4J;
        Wed, 17 Oct 2018 15:54:09 +0000 (GMT)
X-AuditID: b6c32a45-6a9ff70000000faf-0d-5bc75b23fdbd
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 75.44.03633.12B57CB5; Thu, 18 Oct
        2018 00:54:09 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:54:09 +0900 (KST)
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
Subject: [PATCH v2 09/17] thermal: qoriq: enable+check sensor after its
 setup is finished
Date:   Wed, 17 Oct 2018 17:52:35 +0200
Message-id: <1539791563-5959-10-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzVSZ0xTYRTla997fTRWX8r6AIOhaCIYUIzK5wjyw/GMI/pDYqyDCi+ATFtA
        lglLVgAlhEDKagQjaSBAKYIVHAXaQhjBKsGFMiwKhGoaJeBAyoN/55x7Tu65ySW5wru4Cxke
        HcdIoyWRIoKPPe729PP2EOvFe4aXbVFmWi0HtZQ34chk0QPUWNiLoZrXozh6kW4EaGVyDkf9
        7RkclCV/gKG66QkeMmoqCWQp7AGocuE9D01PFBHoq9oJqerHCLSkqcZQ17gFBAjpDLOOoOWf
        Bgn6ifwjj257t5+u7fzGoVXKPIL+MNpJ0IWZCwRdpFYCun20mksbyhYxWj/WzqEtKrfzgsv8
        IyFMZHgCI93tH8QPe1ldyo3N5CX+MP8j0sBvPB/YkpDaByta3nLzAZ8UUh0A9tVPApYsAjin
        KuRsuEytwzg7aAbwy2ctwZJlALuMzzGri6AOweIc5WqcJO2p01DdQFplLtWLwSmLpxXbUWJY
        pBzlWTFG7YB1+aWEFQsoGvYrmnnsMjfYpytZq2e7qg+tKAhWL+PBqjfbWHwMjssb18vZwVm9
        ej3rCk3KlrULVv0Azi8/xFjSBGDDgG49cRh260dwtt1mmNv9l2ctDSkBzM0WshYarmh614+s
        AHCs14DfB84KYKMEjkysLCqUke2N9fWRSaJk8dGhPsExUSqw9hxexztA+dAZLaBIINokoJx1
        YiEuSZAlRWkBJLkie0Gyu14sFIRIkpIZacx1aXwkI9MCVxITOQkmXavEQipUEsdEMEwsI92Y
        ckhblzQwXfyoPSVQE3FhKfS7+8WChDoPt7Zrqc1n/dMDFrKOKrqcDPLhZ+fyth801ao84L3A
        oJtjJb5bZvKxwGxhwa6p8PlBf+MfXaKr5WrJrTuS1BH8xBWb6aIaubk1xe+UQ4/7pcYcg91W
        n5ngpwMO2OzJKW/fX69Ut42OkTd2mn8eQCEiTBYm8fXiSmWS/7E5krMYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t9jQV3F6OPRBuemmFs0Nyxmstg4Yz2r
        xbPPxxkt1vYeZbGYf+Uaq8WBxsuMFv8fvWa1OLW9icmiZdYiFoslTx6yW1zeNYfN4nPvEUaL
        Oe9us1s8edjHZvFii7jFphU32Cx+7prHYrH33mdGByGPpvfH2Dxm3T/L5rFz1l12j623TD0W
        73nJ5LFpVSebx51re9g8epvfsXn0bVnF6LH92jxmjxPTv7N4HL+xncnj8ya5AN4oLpuU1JzM
        stQifbsEroyD86YyFzSzV3x8/4+tgfE3axcjJ4eEgInEs83ngWwuDiGBdYwSHTdmsUE4vxgl
        PjQcYAGpYhOwkpjYvoqxi5GDQ0TAW2LLGg6QGmaBoywSa2d8YwOpERaIlljRtpcJxGYRUJVY
        0jUVLM4r4CFxasEGdohtchInj00G28wJFD/3fwFYjZCAu8TJHS/ZJzDyLGBkWMUomVpQnJue
        W2xUYJSXWq5XnJhbXJqXrpecn7uJERgB2w5r9e9gfLwk/hCjAAejEg/vDrFj0UKsiWXFlbmH
        GCU4mJVEeKsUj0cL8aYkVlalFuXHF5XmpBYfYpTmYFES5+XPPxYpJJCeWJKanZpakFoEk2Xi
        4JRqYNRMOrn/cse2gxdNZL1nuGnF7j0nyBB2ZLv/zBlLJ1evuf+lRuDoheqYlXLcyU7LHVyL
        nKbqu8y0eJW78jJjSn6U3b/p+e0brryYK1il99D9TXdxEusWrfidrLK3QnZfrJzaoaRxUEsz
        dIHBsh85P67mWOf67dynxPPacfcG6R1b9h60OSYmHaDEUpyRaKjFXFScCABt4OTgfAIAAA==
X-CMS-MailID: 20181017155409epcas2p41b5770668abdb4af99646841a3dd24ec
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181017155409epcas2p41b5770668abdb4af99646841a3dd24ec
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155409epcas2p41b5770668abdb4af99646841a3dd24ec@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable+check sensor after enabling monitoring.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/qoriq_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index d8a80448..fb1750f 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -233,13 +233,13 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 		goto err_tmu;
 	}
 
-	thermal_zone_set_mode(data->tz, THERMAL_DEVICE_ENABLED);
-	thermal_zone_device_check(data->tz);
-
 	/* Enable monitoring */
 	site = 0x1 << (15 - data->sensor_id);
 	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
 
+	thermal_zone_set_mode(data->tz, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(data->tz);
+
 	return 0;
 
 err_tmu:
-- 
1.9.1


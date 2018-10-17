Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610C7ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5042150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z+u2/OAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5042150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeJQXvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:51:17 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:18484 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:51:16 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181017155454epoutp0362736228c3f58e5f5f49772990c8205e~ecGNos2lr1091710917epoutp03W;
        Wed, 17 Oct 2018 15:54:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181017155454epoutp0362736228c3f58e5f5f49772990c8205e~ecGNos2lr1091710917epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791694;
        bh=LbMNnsGTpMcl/rBDxuDnGfFAAXGRpSxdja42TCVwLdc=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Z+u2/OAwf77eAcrXlU/1k/3qwyDP4lbpG4vgnJeEL+jQIzJfqo0SRDfNSBVlRSZ/6
         EQNPSQhbxnk+We9dgs0pYazYXoYXhRI3Q85kZHY+UgkCtcWQYR3QT3TyDbKZnL3Nn0
         cyTP87hDSi33PUYirkXygHhOpOe9/87yp8MzDOo0=
Received: from epsmges1p5.samsung.com (unknown [182.195.42.57]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181017155454epcas1p446c53c16fc040b74bd226497dfc4fc1e~ecGNL2-dn0539705397epcas1p4X;
        Wed, 17 Oct 2018 15:54:54 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.D9.04081.E4B57CB5; Thu, 18 Oct 2018 00:54:54 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181017155453epcas1p3be6976375c18583bcbebc7ff7853ae50~ecGMQeGj90323503235epcas1p39;
        Wed, 17 Oct 2018 15:54:53 +0000 (GMT)
X-AuditID: b6c32a39-689ff70000000ff1-85-5bc75b4e5db7
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id BD.A6.03743.D4B57CB5; Thu, 18 Oct
        2018 00:54:53 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:54:53 +0900 (KST)
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
Subject: [PATCH v2 16/17] thermal: zx2967: enable+check sensor after its
 setup is finished
Date:   Wed, 17 Oct 2018 17:52:42 +0200
Message-id: <1539791563-5959-17-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe7dzzs5Gs9M0fVOQWvhBK01JeC27UBEvKVKUUK6wYSeTvMwd
        L2V+mDO6iJPMSvHWyowainOuNNOKqZuZGeUF84q17GZTWxlWZOnJb//n//yeGzy0UJZNetJx
        iSmsOlEZL6ckxP0W3w3rIxQ2xQZ9pSvK1lQIUG1RDYnGnTaAqnVtBLre00eiJ1ndAM29+Uyi
        jnqtAJ0tvkmgW/YxEepuLKWQU9cKUKljUITsY3kU+mD2QKY7/RSabSwnUPOIE2yXYe2klcLF
        o88p/KB4WITvDQTjiqaPAmwyXKTwUF8ThXXZDgrnmQ0A1/eVC3F74Q8C2/rrBdhp8t4rjZKE
        HmPj49JYdcDWo5ITX3rbRSqb+JRhWiPUgBI6B4hpyGyEN67WUTlAQsuYBgBr2i+TfPADwJcd
        M8JF6n3HlIBPGAGc0k39p34COJn/bYGimE0w/7wB5ACadmPCoLlqYYSQaSPgW6fvvO3KHIZ2
        zYp5m2B84MjEHzCvpQyGs9MFJD/LGz618lr8z++a0y9sB5kCEXSMZwl4aBfUNNpFvHaFn2xm
        0Xx/yHjBV21beL4QwImflQQf1ABY1Wn9X7wZtthekvxyLtDxPZfki6XwwjkZLzG0FuznTywB
        cOT3uPASWKkHSwzAnVVxCbEsF6gK9ueUCVxqYqx/TFKCCSy8hl9IA7B2hVsAQwP5UmmDu1Uh
        I5Vp3OkEC4C0UO4mzVhtU8ikx5SnM1h1UrQ6NZ7lLMCLJuQeUrtnmULGxCpT2JMsq2LVi1kB
        LfbUgCPT7yZeJ1evexTnYZr5NrpNxx06j2MccUODQZE9w4PRxkgL3uFnvp2/z+XrlaLeSGkz
        YXcva70W/gLsXl6/8+CjlLC6gT1rI1qWidOT79Z2PnyhFXRaukNDDvwKCCQfrzkTNeKj185Z
        jPSq3MxGc1DL8brZabmx90J65qDrs1KlnOBOKAP9hGpO+RdwOPhtFgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t9jQV3f6OPRBk/XC1o0Nyxmstg4Yz2r
        xbPPxxkt1vYeZbGYf+Uaq8WBxsuMFv8fvWa1OLW9icmiZdYiFoslTx6yW1zeNYfN4nPvEUaL
        Oe9us1s8edjHZvFii7jFphU32Cx+7prHYrH33mdGByGPpvfH2Dxm3T/L5rFz1l12j623TD0W
        73nJ5LFpVSebx51re9g8epvfsXn0bVnF6LH92jxmjxPTv7N4HL+xncnj8ya5AN4oLpuU1JzM
        stQifbsEroy3V0+wFxznrFj1sYG5gXE2RxcjJ4eEgInE81MfmLoYuTiEBNYxSry+dZUVwvnF
        KLHu02NmkCo2ASuJie2rGLsYOThEBLwltqzhAKlhFjjKIrF2xjc2kBphgRiJD9MXM4LYLAKq
        Evfe/AOzeQU8JH5+nMwKsU1O4uQxCJsTKH7u/wKwXiEBd4mTO16yT2DkWcDIsIpRMrWgODc9
        t9iowDAvtVyvODG3uDQvXS85P3cTIzACth3W6tvBeH9J/CFGAQ5GJR7eHWLHooVYE8uKK3MP
        MUpwMCuJ8FYpHo8W4k1JrKxKLcqPLyrNSS0+xCjNwaIkzns771ikkEB6YklqdmpqQWoRTJaJ
        g1OqgdGuIFB8tnrljOZPNvIJl1Q7JV9UKbWunbvjaJV6py17is6HOLeOTYyioReE2bo6c7Yf
        1lkhyD9FVedXRO5evcwQacU5KTt3P6tyCeINK7nRZ63kZPFQY7rf16tSNroeeh3fDolvyP3A
        NtfkUf/iz6fF+dcmHCjg3XmokONa9O0LvPU665hUlFiKMxINtZiLihMBWBlVI3wCAAA=
X-CMS-MailID: 20181017155453epcas1p3be6976375c18583bcbebc7ff7853ae50
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181017155453epcas1p3be6976375c18583bcbebc7ff7853ae50
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155453epcas1p3be6976375c18583bcbebc7ff7853ae50@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable+check sensor after checking sensor coefficients.

Cc: Jun Nie <jun.nie@linaro.org>
Cc: Baoyou Xie <baoyou.xie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/zx2967_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/zx2967_thermal.c b/drivers/thermal/zx2967_thermal.c
index 3c08e1d..4e30b1f 100644
--- a/drivers/thermal/zx2967_thermal.c
+++ b/drivers/thermal/zx2967_thermal.c
@@ -168,9 +168,6 @@ static int zx2967_thermal_probe(struct platform_device *pdev)
 		goto disable_clk_all;
 	}
 
-	thermal_zone_set_mode(priv->tzd, THERMAL_DEVICE_ENABLED);
-	thermal_zone_device_check(priv->tzd);
-
 	if (priv->tzd->tzp->slope == 0) {
 		thermal_zone_of_sensor_unregister(&pdev->dev, priv->tzd);
 		dev_err(&pdev->dev, "coefficients of sensor is invalid\n");
@@ -178,6 +175,9 @@ static int zx2967_thermal_probe(struct platform_device *pdev)
 		goto disable_clk_all;
 	}
 
+	thermal_zone_set_mode(priv->tzd, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(priv->tzd);
+
 	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
 
-- 
1.9.1


Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F355ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08D52150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EyOrKyub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08D52150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeJQXuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:50:08 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:63290 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:50:07 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181017155346epoutp01a97af298635505c65307adb5a6ef3caa~ecFOESDfM2806228062epoutp01h;
        Wed, 17 Oct 2018 15:53:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181017155346epoutp01a97af298635505c65307adb5a6ef3caa~ecFOESDfM2806228062epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791626;
        bh=G9v961x7gTaUJ3IgOF7OjZMws+07qhAKZWxmjW9kIhg=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=EyOrKyubSlC1adEZvBP44L/8wW/QYOTz4AfGQMX9pCrOaGAy54V3DEkyYhOgHJA8m
         OVNXda2rkrsHL/UPdrAaD8TcaZ8Ues6PRk7MAOCE8vTUNhOFXR5UblGnTBjo9PvEb5
         w0xw8Av5zuFeUHac5Q3yVgjf5VEFvQaCgaJ0dBOg=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017155345epcas1p13d4067385b5ccdc39eb3691ec37c8b6c~ecFNTNsfv1224012240epcas1p1Q;
        Wed, 17 Oct 2018 15:53:45 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.3F.04073.90B57CB5; Thu, 18 Oct 2018 00:53:45 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017155345epcas1p18dee37b9a46f2bf0b68aa3ded43f2717~ecFMq4zcf2660926609epcas1p1o;
        Wed, 17 Oct 2018 15:53:45 +0000 (GMT)
X-AuditID: b6c32a35-69fff70000000fe9-b5-5bc75b09eec9
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 95.A6.03743.80B57CB5; Thu, 18 Oct
        2018 00:53:45 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:53:44 +0900 (KST)
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
Subject: [PATCH v2 05/17] thermal: bcm2835: enable+check sensor after its
 setup is finished
Date:   Wed, 17 Oct 2018 17:52:31 +0200
Message-id: <1539791563-5959-6-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG+7Zz22hxXKJfGkIDLaM0K+EryySCDlpkUf3RqBztpLJN146G
        FcR0kstaNyNr3m+QK6nW5iwK1HKnIruZJmYta9Sy0GReSkJrHv3ved739z7vx8dLieUmPIzK
        zMphDVkqrYKQYs2PomNWSpS8cpXHtQKZjHUidOfqLRx99fMANVk6MFT1tgdHrfldAE1//oGj
        Z64CESq01mKo3jtAoq775QTyWx4DVD70nkTegXME8jlCkf16L4H+3K/E0MOPfpAkZwqG3QRj
        9XQSzD3rB5Jx9sUzdQ++ixi77TTB9Pc8IBiLaYhgzjlsgHH1VIqZJ6UTGMP3ukSM3x6RKtsn
        3aBmtZlHWUNsYpo0o6jKSupLJXnXe0zACL6RxUBCQXot9JvLQDGQUnK6BUCf5TwpmAkAzY3d
        2BzlKyvChMZtAC+db8UFMwlgzS/nTBZBr4cXi2z/sygqmE6BjptUoCymOzD4xR8d0Avp/dDe
        WQUCGqMjYX79XzKAy+itMP/MEWFXBHzqLsEDWkIz8MV0NRFYBekSEn7qLsQDPKS3wIH+VIFf
        CAd5BymUw+Gbjo0CXgrgz8kGTDC3ALz53C0SBhLgI/41LrxtARwaOzubKYPmU3IBYeDtmrbZ
        XykD8Ef+a9EFsKgazLOBEFbP6dJZLk4fF8OpdFxuVnrMoWydHcycxvL4FnD5xbZ2QFNAMV/W
        EuJWynHVUe6Yrh1ASqwIlh1fwivlMrXq2HHWkH3QkKtluXYQTmGKUJk3rEIpp9NVOayGZfWs
        Ya4roiRhRrDOkShrSlwV2VGb5hv97fuSd+fK+Deze9jbEGXdHNS3eo8miXvZtPtdasKkiDc0
        V1i2qg9vmnJ38mSGr3FppXLQE+oZd4Z37zx5QBPCrxlNDp1StnU5b4wVqkcu7F2cHBWbV3Nt
        pGG7TxX0yuWpFGOTKTu4uxO7jcu0ak39rhMKjMtQxS0XGzjVP55NM5QWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t9jQV3O6OPRBk8+M1s0Nyxmstg4Yz2r
        xbPPxxkt1vYeZbGYf+Uaq8WBxsuMFv8fvWa1OLW9icmiZdYiFoslTx6yW1zeNYfN4nPvEUaL
        Oe9us1s8edjHZvFii7jFphU32Cx+7prHYrH33mdGByGPpvfH2Dxm3T/L5rFz1l12j623TD0W
        73nJ5LFpVSebx51re9g8epvfsXn0bVnF6LH92jxmjxPTv7N4HL+xncnj8ya5AN4oLpuU1JzM
        stQifbsEroz2+bPYC6ZzVqy41szYwPicvYuRk0NCwETixex2li5GLg4hgXWMEs/3/mWHcH4x
        SvxbcJMRpIpNwEpiYvsqIJuDQ0TAW2LLGg6QGmaBoywSa2d8YwOpERaIldjbeA7MZhFQlWhc
        8ocdpJ5XwF2isbsQYpmcxMljk1lBbE4BD4lz/xeAlQsBlZzc8ZJ9AiPPAkaGVYySqQXFuem5
        xUYFhnmp5XrFibnFpXnpesn5uZsYgeG/7bBW3w7G+0viDzEKcDAq8fDuEDsWLcSaWFZcmXuI
        UYKDWUmEt0rxeLQQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5xyKFBNITS1KzU1MLUotgskwc
        nFINjO1d26wyVQwMDxh8CLj8+IFudoSUxQfmtvYvSuwOUeeCS520dnrNW/lmVeLkR00hNxSY
        XSfsl/666tDmcNF583t+5nGaFUbV7H5e8OrWjMVvX50XFz4w8+0E3e4d9U8zMyWnLjpXWHnL
        WjDG6KGW7PUXn09+LfOfWJ7vNG1JvKOBEf9Of0dFKyWW4oxEQy3mouJEAIqMWl17AgAA
X-CMS-MailID: 20181017155345epcas1p18dee37b9a46f2bf0b68aa3ded43f2717
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181017155345epcas1p18dee37b9a46f2bf0b68aa3ded43f2717
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155345epcas1p18dee37b9a46f2bf0b68aa3ded43f2717@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable+check sensor after HW-block setup (if necessary) and setting
data->tz.

Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 687a00c..ec82fef 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -227,9 +227,6 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	thermal_zone_set_mode(tz, THERMAL_DEVICE_ENABLED);
-	thermal_zone_device_check(tz);
-
 	/*
 	 * right now the FW does set up the HW-block, so we are not
 	 * touching the configuration registers.
@@ -276,6 +273,9 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 
 	data->tz = tz;
 
+	thermal_zone_set_mode(tz, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check(tz);
+
 	platform_set_drvdata(pdev, tz);
 
 	bcm2835_thermal_debugfs(pdev);
-- 
1.9.1


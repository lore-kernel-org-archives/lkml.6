Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8F2C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9841A206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FNGewhDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9841A206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeKTXH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:07:56 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46292 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTXHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:07:55 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181120123857euoutp0130ec33e7d88eeecdae9f5c69fb7d64e8~o1W0eNOFR2517425174euoutp01T;
        Tue, 20 Nov 2018 12:38:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181120123857euoutp0130ec33e7d88eeecdae9f5c69fb7d64e8~o1W0eNOFR2517425174euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542717537;
        bh=T3aWJmrFtpoYPl94LWMU2junfDU4l3TEFHah795NpCo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FNGewhDFU0vHjAz/9uAofq27segRLkYE3STOmckaWjT9BOEABr/u/AR/6mq0kKf64
         VyQzewI8u6LuNLeB6cQUdM+5bBq3rhI2bHM+CuDyc6+z/v78rPT2p7Vodlz3EpydTb
         wisqXKCfXvgpEqWncorcuduk/TV+WPZ61ASfxpCw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181120123855eucas1p2fb407e9c9b6632d4bbb72f5d76590afc~o1WzY5sZ42021720217eucas1p2y;
        Tue, 20 Nov 2018 12:38:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 48.B5.04294.F5004FB5; Tue, 20
        Nov 2018 12:38:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181120123855eucas1p1a969fba923e9243e576cae0b632504af~o1WyoS9Bx0254902549eucas1p1o;
        Tue, 20 Nov 2018 12:38:55 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-b8-5bf4005fae2b
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 43.73.04128.E5004FB5; Tue, 20
        Nov 2018 12:38:54 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PIH0030FSGPKL50@eusync4.samsung.com>;
        Tue, 20 Nov 2018 12:38:54 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] regulator: s2mps11: Fix GPIO descriptor initialization
Date:   Tue, 20 Nov 2018 13:38:44 +0100
Message-id: <20181120123844.3003-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7djP87rxDF+iDZ5/U7LYOGM9q8XUh0/Y
        LM6f38Bu8e1KB5PF5V1z2CxmnN/HZLH2yF12i4srvjA5cHjsnHWX3WPTqk42j74tqxg9Pm+S
        C2CJ4rJJSc3JLEst0rdL4Mr4ve00c8Epjor3/xcwNjDOZe9i5OSQEDCROHR8D1sXIxeHkMAK
        Rom+IwsZIZzPjBIH7+1lg6naOv0ME4gtJLCMUeLDDxGIogYmidbpy1hAEmwChhJdb7vAGkQE
        HCUOTd4IFmcW+McosahHFsQWFnCXuDe9ixHEZhFQlZh/eT0ziM0rYCPR/mM6M8QyeYnVGw4w
        gyyQEHjJKnGt9xXUrS4Sc7b0skDYwhKvjm+BistIXJ7czQLR0Mwo0T5jFjuE08MosXXODqgf
        rCUOH7/ICnESn8SkbSDrOIDivBIdbUIQJR4S6zY9Yod4M1ZiyuSlrBMYJRYwMqxiFE8tLc5N
        Ty02ykst1ytOzC0uzUvXS87P3cQIjLTT/45/2cG460/SIUYBDkYlHt4dJp+jhVgTy4orcw8x
        SnAwK4nwvo0GCvGmJFZWpRblxxeV5qQWH2KU5mBREuetZngQLSSQnliSmp2aWpBaBJNl4uCU
        amDc/LPTL749oTBm6U9h65MveYsWLOG6f0/V89PVY7fm6UySC8yzefL/9fztFa8cGN/yhEx+
        OT9yz9fmrKjSiNuzdfsyj04ubG+p/BI/R3+l+lmr+IV1O6dO/6S6Mmb3taROPr0P/Z5f06bw
        Tn2Y/mHmFI8v0v0/7pRvuxTD935xSZcj8zubavsUJZbijERDLeai4kQArbnx0bACAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJMWRmVeSWpSXmKPExsVy+t/xa7pxDF+iDfoW2VhsnLGe1WLqwyds
        FufPb2C3+Halg8ni8q45bBYzzu9jslh75C67xcUVX5gcODx2zrrL7rFpVSebR9+WVYwenzfJ
        BbBEcdmkpOZklqUW6dslcGX83naaueAUR8X7/wsYGxjnsncxcnJICJhIbJ1+hqmLkYtDSGAJ
        o8Ta00+ZIZwmJomps94zglSxCRhKdL3tYgOxRQQcJQ5N3sgCUsQs8I9R4t3VVWAJYQF3iXvT
        u8AaWARUJeZfXs8MYvMK2Ei0/5jODLFOXmL1hgPMExi5FjAyrGIUSS0tzk3PLTbSK07MLS7N
        S9dLzs/dxAgMh23Hfm7Zwdj1LvgQowAHoxIPr4D552gh1sSy4srcQ4wSHMxKIrxvo4FCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEec8bVEYJCaQnlqRmp6YWpBbBZJk4OKUaGPflz77Sfo09v+45
        /33D+BieqXGHOk5X71JM+MMQ85Il7pYUs/Tia6+K91y8ez/9iJnm71czmRktT7//tmjd2f67
        smW918TF7rl9EXNyvaQxUa8sjlOqPKaM70fpb/fJRj0+32qSJ9Yb+t9kdUm+WfE6IHKjGxO7
        8yM7M83pk+xvvW/smL7vlRJLcUaioRZzUXEiANxJDY0DAgAA
X-CMS-MailID: 20181120123855eucas1p1a969fba923e9243e576cae0b632504af
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181120123855eucas1p1a969fba923e9243e576cae0b632504af
References: <CGME20181120123855eucas1p1a969fba923e9243e576cae0b632504af@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO descriptor array must be zero initialized to ensure that core will
properly handle also the case when no external GPIO pin is defined.

Fixes: 1c984942f0a4 ("regulator: s2mps11: Pass descriptor instead of GPIO number")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This fixes broken eMMC boot on Artik, Rinato and Odroid XU3/XU4/HC1
boards.
---
 drivers/regulator/s2mps11.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 6fec45897194..63e66f485cc0 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -1134,9 +1134,8 @@ static int s2mps11_pmic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	s2mps11->ext_control_gpiod = devm_kmalloc_array(&pdev->dev,
-			rdev_num, sizeof(*s2mps11->ext_control_gpiod),
-			GFP_KERNEL);
+	s2mps11->ext_control_gpiod = devm_kcalloc(&pdev->dev, rdev_num,
+			       sizeof(*s2mps11->ext_control_gpiod), GFP_KERNEL);
 	if (!s2mps11->ext_control_gpiod)
 		return -ENOMEM;
 
-- 
2.17.1


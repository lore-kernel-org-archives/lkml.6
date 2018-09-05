Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1AFC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A46206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JyD5vy/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A46206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeIEOCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:02:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57342 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeIEOCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:02:30 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180905093307euoutp01ab1977976f5246aa60f19301c021898a~Rdy3zpoH12685726857euoutp01p;
        Wed,  5 Sep 2018 09:33:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180905093307euoutp01ab1977976f5246aa60f19301c021898a~Rdy3zpoH12685726857euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536139987;
        bh=2usRkawckmVip8LLVholFNJl+qoSNb5lNKXogfnlYGg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=JyD5vy/1LS5PUtgjA5r64JPySmQoz/xF87jc60nUrLMzFrbw6RdeoTy5H0+dEbXgT
         S/6hrgxZ/te235y1xKghRCNlv1/iyRsg2o0J4Pg6DslPxu3UxaHrmmH8ZYJe8eS9eN
         NpTZeCorWQ9L0KyzMJAGHluIKtA9cnwFbLyjjWPY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180905093306eucas1p264e0a2d2d25fac7719f1cc78c900449d~Rdy3Vnyqx2266822668eucas1p2V;
        Wed,  5 Sep 2018 09:33:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E7.28.04806.2D2AF8B5; Wed,  5
        Sep 2018 10:33:06 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180905093305eucas1p19cbdec510c32cedaf9a9de58fd2de9e1~Rdy2lOzrP1947919479eucas1p1y;
        Wed,  5 Sep 2018 09:33:05 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-3f-5b8fa2d25164
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 01.7A.04284.1D2AF8B5; Wed,  5
        Sep 2018 10:33:05 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PEK00BNHT71V970@eusync1.samsung.com>;
        Wed, 05 Sep 2018 10:33:05 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] mfd: max8997: Enale irq-wakeup unconditionally
Date:   Wed, 05 Sep 2018 11:32:43 +0200
Message-id: <20180905093243.3861-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZduzned1Li/qjDXqPiFlsnLGe1eL+16OM
        Fpd3zWGzmHF+H5PF2iN32S1uN65gc2DzuHNtD5tH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVw
        ZTStii34y1HxddJilgbGtexdjJwcEgImEvvWvmLtYuTiEBJYwSgx78ElZgjnM6PEm655bF2M
        HGBVd266Q8SXMUoc2T6fEcJpYJLYsOcLK8goNgFDia63XWwgtoiAs8TtD99YQIqYBbYwSky/
        +ogFJCEsYC+xYMYBJhCbRUBV4uHs22BxXgEbiaWtO9kgbpKXWL3hADOEfZNV4tizXAjbReL1
        64dQNcISr45vgfpBRqKz4yATyDIJgWZGifYZs9ghnB5Gia1zdkB1WEscPn4R7FRmAT6JSdum
        M0P8xivR0SYEUeIhcX33GkYQW0ggVuLOz3ksExglFjAyrGIUTy0tzk1PLTbOSy3XK07MLS7N
        S9dLzs/dxAiMpNP/jn/dwbjvT9IhRgEORiUeXo2Wvmgh1sSy4srcQ4wSHMxKIrwqXP3RQrwp
        iZVVqUX58UWlOanFhxilOViUxHn5tNKihQTSE0tSs1NTC1KLYLJMHJxSDYzMsWVnEyJk5dnr
        n71Kfj5pAvO8onm7VoTpxgWvPPyUYUbN1SYptyPnfHMq+a8cbu1MSK7fVXr7nGf91asmndel
        1HfzSjfJasQmO89bUBDybG0ey97tflvmLxFUr5j7N/a8oumyo1wdbN/Xhl+L72iYc3dL2NX4
        rWeWsfEU8WyrPjRx+718TUclluKMREMt5qLiRAAZNGVVoAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPJMWRmVeSWpSXmKPExsVy+t/xy7oXF/VHG7S0G1hsnLGe1eL+16OM
        Fpd3zWGzmHF+H5PF2iN32S1uN65gc2DzuHNtD5tH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVw
        ZTStii34y1HxddJilgbGtexdjBwcEgImEnduuncxcnEICSxhlLg9aRcbhNPEJDFl72TGLkZO
        DjYBQ4mut11sILaIgLPE7Q/fWECKmAW2MEq83LGfBSQhLGAvsWDGASYQm0VAVeLh7NtgcV4B
        G4mlrTvBmiUE5CVWbzjAPIGRawEjwypGkdTS4tz03GJDveLE3OLSvHS95PzcTYxAb2879nPz
        DsZLG4MPMQpwMCrx8Gq09EULsSaWFVfmHmKU4GBWEuFV4eqPFuJNSaysSi3Kjy8qzUktPsQo
        zcGiJM573qAySkggPbEkNTs1tSC1CCbLxMEp1cDIOntJ6JmbZY0vNp/uehaykmeei9jnB5NX
        Wa9eGH1QUzdR3MDugVDdu7f/lKqqOh7OOM8fm31rX6uInpbVLqVEZf/wycsd6z1fvX/14vGW
        fxsdNytdiIhasv7+ZjuuecvTMjp2nvE9nd40bVbb5Zd7vdLjZjw6HZJTM2Xv7wkrHaQvzN54
        RqzPUYmlOCPRUIu5qDgRAOWbD53yAQAA
X-CMS-MailID: 20180905093305eucas1p19cbdec510c32cedaf9a9de58fd2de9e1
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180905093305eucas1p19cbdec510c32cedaf9a9de58fd2de9e1
References: <CGME20180905093305eucas1p19cbdec510c32cedaf9a9de58fd2de9e1@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ wakeup support for MAX8997 driver was initially configured by
respective property in pdata. However, after the driver conversion to
device-tree, setting it was left as 'todo'. Nowadays most of other MAX PMIC
MFD drivers initialized from device-tree simply assume unconditionally that
they can be an irq wakeup source, so enable wakeup support also for
MAX8997. This fixes support for wakeup from MAX8997 RTC alarm.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mfd/max8997.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index 3f554c447521..7155e991cb82 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -152,12 +152,7 @@ static struct max8997_platform_data *max8997_i2c_parse_dt_pdata(
 		return ERR_PTR(-ENOMEM);
 
 	pd->ono = irq_of_parse_and_map(dev->of_node, 1);
-
-	/*
-	 * ToDo: the 'wakeup' member in the platform data is more of a linux
-	 * specfic information. Hence, there is no binding for that yet and
-	 * not parsed here.
-	 */
+	pd->wakeup = true;
 
 	return pd;
 }
-- 
2.17.1


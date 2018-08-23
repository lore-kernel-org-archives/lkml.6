Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2732AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877CE2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gQuvKNUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877CE2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeHWK4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 06:56:32 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33603 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbeHWK4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 06:56:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180823072814euoutp01bcf65f0d864cbdd63791005424b3490e~NctIPvhMJ1229312293euoutp014;
        Thu, 23 Aug 2018 07:28:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180823072814euoutp01bcf65f0d864cbdd63791005424b3490e~NctIPvhMJ1229312293euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535009294;
        bh=amqvdV27f97JYJIVofARGomSGMD+6TfJ7pYzBWpn7KM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=gQuvKNURGG4K2famaS5PPaGdFOZ43bbsB7LhFeGdeCgYJ6QVyNOpwc/nMlu1bAD5+
         G/AtHmnPQLjOEWi9wZKjRLPhJqHsp0f/Z0BDi8H2AU8NEwhDvmnnAbGROq0/eoh2AS
         KVZew/CLddUVRNLTjP/Bx6Ps0n2ZCBBT52yS648U=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180823072814eucas1p13c564a189a7bb9e25057bab2a06ba668~NctH1xaJ80477404774eucas1p1a;
        Thu, 23 Aug 2018 07:28:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7B.66.04806.D026E7B5; Thu, 23
        Aug 2018 08:28:13 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180823072813eucas1p2a534b4be94a3a2bc3480adcefca2ca22~NctHFmIqA2411024110eucas1p2a;
        Thu, 23 Aug 2018 07:28:13 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-d5-5b7e620dda37
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6A.AA.04128.D026E7B5; Thu, 23
        Aug 2018 08:28:13 +0100 (BST)
Received: from localhost.localdomain ([10.88.99.240]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PDW00LMHKQTZW30@eusync1.samsung.com>; Thu, 23 Aug
        2018 08:28:13 +0100 (BST)
From:   Huijin Park <huijin.park@samsung.com>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Huijin Park <huijin.park@samsung.com>, bbanghj.park@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: cast to u64 to avoid unexpected error
Date:   Thu, 23 Aug 2018 03:28:02 -0400
Message-id: <1535009282-1480-1-git-send-email-huijin.park@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7djP87q8SXXRBrvbDSxe7j3EbLHvVD+L
        RcdFF4vLu+awWexuWsZucXTPPWYHNo95a6o9ds66y+6xeUm9R9+WVYwenzfJBbBGcdmkpOZk
        lqUW6dslcGXsmD+JsWA3e8Wp1Z+YGhgXsXUxcnJICJhIzH5zgqmLkYtDSGAFo8SEJZ/ZIJzP
        jBL9s97CVf1uWAWVWMYo8eRJEwuE85dRYsOeo8wgVWwC2hLX125lBLFFBNQlZk1dAtbBLLCR
        UWLa35dgRcIC1hJz/i1mBbFZBFQlnu5ZB9TAwcEr4Cbx/W8+xDY5iZvnOplBeiUEHrJK3Ng0
        mR0i4SLxtncZlC0s8er4FihbRuLy5G4WCDtb4tejVhaQmRICFRJv56lAhI0l3r1dC3YCswCf
        xKRt05khSnglOtqEIEo8JO7+WwR2vpBArMSCtefZJjBKLGBkWMUonlpanJueWmycl1quV5yY
        W1yal66XnJ+7iREYVaf/Hf+6g3Hfn6RDjAIcjEo8vAKFtdFCrIllxZW5hxglOJiVRHifb66J
        FuJNSaysSi3Kjy8qzUktPsQozcGiJM7Lp5UWLSSQnliSmp2aWpBaBJNl4uCUamBc/CTF/pp9
        pqWD79lHk7RLVrbcm7/t6NKbDM0sVm82cYqdm+C/eYXx/ZVLPA7e7dbs2FJ79OoeyV5+uXcf
        ZHZ3raif7n96wnWxrQq73voF9L1WvKVo76zX8vrLlfCIOdL3VDuv2UutZ/+yLbi4+1zRgs8X
        GeMUL8QXFS09wX+04+9aR86SOwe8lViKMxINtZiLihMBg7QNV6YCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJMWRmVeSWpSXmKPExsVy+t/xy7q8SXXRBtd/8Fu83HuI2WLfqX4W
        i46LLhaXd81hs9jdtIzd4uiee8wObB7z1lR77Jx1l91j85J6j74tqxg9Pm+SC2CN4rJJSc3J
        LEst0rdL4MrYMX8SY8Fu9opTqz8xNTAuYuti5OSQEDCR+N2wCsjm4hASWMIosXvVQWYI5z+j
        xPL1N8Cq2AS0Ja6v3coIYosIqEvMmroErINZYCOjxKRHS5lBEsIC1hJz/i1mBbFZBFQlnu5Z
        B9TAwcEr4Cbx/W8+xDY5iZvnOpknMHItYGRYxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJEej9
        bcd+btnB2PUu+BCjAAejEg9vRnFttBBrYllxZe4hRgkOZiUR3ueba6KFeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ8543qIwSEkhPLEnNTk0tSC2CyTJxcEo1MOZ4/lw5pWtnp+a+XwfWTP4S6Ltg
        0py7L5cFX9+kIPRorr/ujibR7zOzgsXVF2ppXK4/ILnn380ZMeEm+Z4qr9wvVdxi91xyIOeu
        Zs3eFt39Wi6zbMUbnNSKa7WuKkRWalquN1i15fgetwVbD7RM2Ff0wq/+ifDrffkpq7d2hX31
        YQj89TJn72clluKMREMt5qLiRABBF9MX+gEAAA==
X-CMS-MailID: 20180823072813eucas1p2a534b4be94a3a2bc3480adcefca2ca22
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180823072813eucas1p2a534b4be94a3a2bc3480adcefca2ca22
References: <CGME20180823072813eucas1p2a534b4be94a3a2bc3480adcefca2ca22@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huijin.park" <huijin.park@samsung.com>

the params->size is defined as "u64"
and, "info->sector_size" and "info->n_sectors" is defined as unsgined and u16
thus, u64 data might have strange data(loss data) if data is overflow.
this patch cast it to u64.

Signed-off-by: huijin.park <huijin.park@samsung.com>
---
 drivers/mtd/spi-nor/spi-nor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d9c368c..527f281 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2459,7 +2459,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	memset(params, 0, sizeof(*params));
 
 	/* Set SPI NOR sizes. */
-	params->size = info->sector_size * info->n_sectors;
+	params->size = (u64)info->sector_size * (u64)info->n_sectors;
 	params->page_size = info->page_size;
 
 	/* (Fast) Read settings. */
-- 
1.7.9.5


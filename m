Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036C1C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD9B20861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qFavYPi0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD9B20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeIERBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:01:01 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52272 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeIERBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:01:00 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180905123055euoutp02c368ab80f8518d11ed8b6141ec052857~RgOHY0W2i0585205852euoutp02h;
        Wed,  5 Sep 2018 12:30:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180905123055euoutp02c368ab80f8518d11ed8b6141ec052857~RgOHY0W2i0585205852euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536150655;
        bh=3ZYwq2uQyq8vrXwit6gkpx8VsoO57eIOkAw7AvurhOs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qFavYPi0fHGLjEcOfkU81knlsbMqbWubXPhnBFKDe+zsfvwkAhLuuQwcP4iGEjmNH
         +XUcRMqZEm90Je5y0K46ZY0yqBj76gNr7RX/Sgzt0zi/Lbp+8ki+ujyp6b+ZzFwNSA
         BMln7Ns8nyWVjNeAKM02mqJ5Sdcy5+BrQhaXAiAg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180905123054eucas1p299204664c9d7f4ed45784a80c740c9d4~RgOGfz5501390013900eucas1p2r;
        Wed,  5 Sep 2018 12:30:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CB.11.04806.E7CCF8B5; Wed,  5
        Sep 2018 13:30:54 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180905123053eucas1p196633ed9d661f79ed1c2e06a14a2b964~RgOFr2eOQ1996019960eucas1p13;
        Wed,  5 Sep 2018 12:30:53 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-7d-5b8fcc7e2c53
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 05.D2.04284.D7CCF8B5; Wed,  5
        Sep 2018 13:30:53 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PEL00LQW1FEPT80@eusync4.samsung.com>;
        Wed, 05 Sep 2018 13:30:53 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] mfd: max8997: Disable interrupt handling for suspend/resume
 cycle
Date:   Wed, 05 Sep 2018 14:30:43 +0200
Message-id: <20180905123043.22604-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42LZduzned26M/3RBjNucVpsnLGe1eL+16OM
        Fpd3zWGzmHF+H5PF2iN32S1uN65gc2DzuHNtD5tH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVw
        ZcydOIe54Cx7xeVNRxkbGJexdTFycEgImEg0TC3tYuTiEBJYwShxcMFXdgjnM6PEv69XWLoY
        OcGKmnq3sEEkljFKHGr5wwzhNDBJrPn2ixmkik3AUKLrbRcbiC0i4Cxx+8M3FpAiZoEtjBLT
        rz4CGyUsECJx8ftbMJtFQFXiy8wrjCA2r4CtxLNFR5kg1slLrN5wAGyDhMBVVomOy/tZIRIu
        EnvWbmKHsIUlXh3fAmXLSHR2HGSCaGhmlGifMYsdwulhlNg6ZwcbRJW1xOHjF8EmMQvwSUza
        Np0ZEgS8Eh1tQhAlHhLn9naAvSMkECtxevJt5gmMEgsYGVYxiqeWFuempxYb56WW6xUn5haX
        5qXrJefnbmIERtPpf8e/7mDc9yfpEKMAB6MSD69GS1+0EGtiWXFl7iFGCQ5mJRFeo5P90UK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5+bTSooUE0hNLUrNTUwtSi2CyTBycUg2M62z+Tpgxg3/9
        slU33/b1P9zI93HB1Iivq298KDq56/T9UzZ7XRMb4r+82xXpu+6Kjevs1TxclQIzue+u/Lb8
        lIeNTgOz5MJZb43DTs9wPdA8n/9Y2H2V6IAHaybYxaocW3fh9L6rp8N8KpM+n/M3SdSbVvKx
        ZLtKgOs/q6lPjnU+1C5/+GZPXYoSS3FGoqEWc1FxIgCWi1KGogIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJMWRmVeSWpSXmKPExsVy+t/xa7q1Z/qjDRbMkbfYOGM9q8X9r0cZ
        LS7vmsNmMeP8PiaLtUfuslvcblzB5sDmcefaHjaPvi2rGD0+b5ILYI7isklJzcksSy3St0vg
        ypg7cQ5zwVn2isubjjI2MC5j62Lk5JAQMJFo6t0CZHNxCAksYZQ4MOUzE4TTxCTxv2cRO0gV
        m4ChRNfbLrAOEQFnidsfvrGAFDELbGGUeLljPwtIQlggROLi97dgNouAqsSXmVcYQWxeAVuJ
        Z4uOMkGsk5dYveEA8wRGrgWMDKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECPb7t2M/NOxgv
        bQw+xCjAwajEw6vR0hctxJpYVlyZe4hRgoNZSYTX6GR/tBBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXHe8waVUUIC6YklqdmpqQWpRTBZJg5OqQbGWX0bpge3ixqeWL90oWyj4bRaD355C/WASY8S
        tkwSe2doZy684YXutwbJRJcdG534yt66zTzl3jC/kPn6FUMxztt/LjwytbtoUvzg94Pzf6c8
        cuk1WNg/tX9SNhPf5FeOqzrzDNqO8SSvEa3xuHRCWsj91AfBoMK4JH+Ff9NkzW+7/WFssrms
        xFKckWioxVxUnAgAJ7K48fQBAAA=
X-CMS-MailID: 20180905123053eucas1p196633ed9d661f79ed1c2e06a14a2b964
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180905123053eucas1p196633ed9d661f79ed1c2e06a14a2b964
References: <CGME20180905123053eucas1p196633ed9d661f79ed1c2e06a14a2b964@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable IRQs during suspend/resume cycle to ensure handling of wakeup
interrupts (i.e. RTC wake alarm) after max8997_resume(). This way it can
be properly handled when I2C bus is finally available. This pattern is
also used in other MAX PMIC MFD drivers.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mfd/max8997.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index d1495d76bf2c..5a50ea976c70 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -464,6 +464,7 @@ static int max8997_suspend(struct device *dev)
 
 	if (device_may_wakeup(dev))
 		irq_set_irq_wake(max8997->irq, 1);
+	disable_irq(max8997->irq);
 	return 0;
 }
 
@@ -474,6 +475,7 @@ static int max8997_resume(struct device *dev)
 
 	if (device_may_wakeup(dev))
 		irq_set_irq_wake(max8997->irq, 0);
+	enable_irq(max8997->irq);
 	return max8997_irq_resume(max8997);
 }
 
-- 
2.17.1


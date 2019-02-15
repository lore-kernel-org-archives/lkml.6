Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B5FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65B52192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nY6w9dJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfBOOs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:48:28 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:47564 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfBOOs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:48:28 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190215144824epoutp013499d9ae3637be0c04defb4e0b909b90~DkPrn56_d0718407184epoutp01V;
        Fri, 15 Feb 2019 14:48:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190215144824epoutp013499d9ae3637be0c04defb4e0b909b90~DkPrn56_d0718407184epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550242104;
        bh=EcLDy/NdmvrbzjAGLVvQ2n7dKDTesDLM5sls5OuqF4g=;
        h=From:To:Cc:Subject:Date:References:From;
        b=nY6w9dJnCD8w057cLMk205+gtRgeyToNVN3C5VQlDlVSP0UxFgfQtXDSHe8q2M6Zn
         JyTYK24RUI4ktTfNm763o1EV5lagHQVPfkxzs+h9RKpjOYyOdrPCQdVqgXQUR4A+it
         ztx0Z7IHQNUof2LwMznLLBTaeNLYO8GtIo2UaGEU=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190215144823epcas2p1a3ce2df7eb9525c3277a5711f59f2cde~DkPrJiNWo2842828428epcas2p1t;
        Fri, 15 Feb 2019 14:48:23 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.71.04093.731D66C5; Fri, 15 Feb 2019 23:48:23 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190215144822epcas2p4a6187a4e4d45c7ac3ea067ac428b3678~DkPqbGnIP1019610196epcas2p4S;
        Fri, 15 Feb 2019 14:48:22 +0000 (GMT)
X-AuditID: b6c32a48-18bff70000000ffd-34-5c66d137bcf4
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.D3.03689.631D66C5; Fri, 15 Feb 2019 23:48:22 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMZ00AU92GC5G00@mmp1.samsung.com>; Fri, 15 Feb 2019
        23:48:22 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 1/2] ASoC: samsung: i2s: Fix the secondary platform device
 registration
Date:   Fri, 15 Feb 2019 15:48:08 +0100
Message-id: <20190215144809.28007-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCmqa75xbQYg8OTpS2uXDzEZDH14RM2
        i/PnN7BbfLvSwWRxedccNou1R+6yWxx+085qcXHFFyYHDo8Nn5vYPHbOusvusWlVJ5tH35ZV
        jB6fN8kFsEZx2aSk5mSWpRbp2yVwZez+PpW54DBnRf+Ui2wNjH/Zuxg5OSQETCSOnbrP2MXI
        xSEksINRYs2fxVDOd0aJGTt/MsJULd6+nxkisZtRovHvM6iqX4wS6x8tAJvFJmAo0Xu0D6xD
        REBM4vacTrAOZoHDjBIH77SAFQkLREqsf3iDBcRmEVCVuDoVIs4rYC1x49NfVoh18hKrNxwA
        a5YQ+MoqcXzmSahrXSTm/PnODGFLSzxbtRHqvmqJXdu7oRo6GCVaLmyHKrKWOHz8IthUZgE+
        iY7DIG9zAMV5JTrahCBKPCQWNWwHO0hIIFbi/LrvTBMYxRcwMqxiFEstKM5NTy02KjDRK07M
        LS7NS9dLzs/dxAiOLS2PHYwHzvkcYhTgYFTi4b2xLy1GiDWxrLgy9xCjBAezkggv51mgEG9K
        YmVValF+fFFpTmrxIUZpDhYlcd6H0nOjhQTSE0tSs1NTC1KLYLJMHJxSDYxF15a5Vh/4+HV3
        yYyJOtsNHWfp1OTwsCoVM9hWHGG9VXjlXKDpX+aHz07+7Mg4//aySk8O17abD9/klghsfV11
        5ESl07QU3u+X760OVfx9IMAwNsl79rG1DzNNXp76yTl31QmFdVOPTrz9dOmWuWLW9npz288t
        35h/2iDg1E3OnetUPxu+ObScVYmlOCPRUIu5qDgRAM87e0WpAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJJMWRmVeSWpSXmKPExsVy+t9jAV2zi2kxBpN/qltcuXiIyWLqwyds
        FufPb2C3+Halg8ni8q45bBZrj9xltzj8pp3V4uKKL0wOHB4bPjexeeycdZfdY9OqTjaPvi2r
        GD0+b5ILYI3isklJzcksSy3St0vgytj9fSpzwWHOiv4pF9kaGP+ydzFyckgImEgs3r6fuYuR
        i0NIYCejxOu761ghnF+MEm/XLmYGqWITMJToPdrHCGKLCIhJ3J7TCRZnFjjMKHFxRRCILSwQ
        KbH+4Q0WEJtFQFXi6tQWsA28AtYSNz79ZYXYJi+xesMB5gmMXAsYGVYxSqYWFOem5xYbFRjl
        pZbrFSfmFpfmpesl5+duYgQGyLbDWv07GB8viT/EKMDBqMTDe2NfWowQa2JZcWXuIUYJDmYl
        EV7Os0Ah3pTEyqrUovz4otKc1OJDjNIcLErivPz5xyKFBNITS1KzU1MLUotgskwcnFINjAvX
        m/1gE7K+uLT3OY/A6va/d5Z8cug+13Szn9HEr6gn+JdZyoKNF3iWnJQTthQzTLVumab0sDXz
        TujeIz1mKzlr71fc11O+sPAs1yOFCSfkm9JjT0Sszdjfx2lusfyFWPeWM1c+eNxKvJy5PNl5
        RVAiT/OWblbZXxHLXuscuee7RnhZfuDZRUosxRmJhlrMRcWJAEYcKhYMAgAA
X-CMS-MailID: 20190215144822epcas2p4a6187a4e4d45c7ac3ea067ac428b3678
CMS-TYPE: 102P
X-CMS-RootMailID: 20190215144822epcas2p4a6187a4e4d45c7ac3ea067ac428b3678
References: <CGME20190215144822epcas2p4a6187a4e4d45c7ac3ea067ac428b3678@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes unregistration of the secondary platform device so all
resources are properly released. The test for NULL priv->pdev_sec
is not necessary and it is removed.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
This patch is based off of ASoC for-next and patches:
 ASoC: samsung: odroid: Ensure proper sample rate on pri/sec PCM 
 ASoC: samsung: i2s: Prevent potential NULL platform data dereference 
 ASoC: samsung: odroid: Add missing DAPM routes
 
 sound/soc/samsung/i2s.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 6bf0f55d1e51..e36c44e2f1bb 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1359,11 +1359,10 @@ static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
 
 static void i2s_delete_secondary_device(struct samsung_i2s_priv *priv)
 {
-	if (priv->pdev_sec) {
-		platform_device_del(priv->pdev_sec);
-		priv->pdev_sec = NULL;
-	}
+	platform_device_unregister(priv->pdev_sec);
+	priv->pdev_sec = NULL;
 }
+
 static int samsung_i2s_probe(struct platform_device *pdev)
 {
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
-- 
2.17.1


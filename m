Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62D4ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751112150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="r7QTb6dO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751112150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeJQXu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:50:57 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:63425 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:50:56 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181017155435epoutp01feea25e17fef6f07078a495b592bef70~ecF7ul2Uj2806228062epoutp01o;
        Wed, 17 Oct 2018 15:54:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181017155435epoutp01feea25e17fef6f07078a495b592bef70~ecF7ul2Uj2806228062epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791675;
        bh=q0417HQ33V8ssuZYKNqKRW9dtdIEQNq9i6uyn1Jgybk=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=r7QTb6dO7IWX72v3DhAxiIESnRuUH5zFXVud5Eu718ju5+d+G+yW2Iha0J5y9YGYK
         5oiq5ux11pKB37LODzbpxq9H9Q8eW7CKkAkXCIMLbVQQ6Wp/QutnQg/GtAXbdj6BhS
         OkmR0WASf7/MpEIvu3d3jO1LyvbZjC/Ymi9kfTSQ=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181017155435epcas1p383f48a2d3cb5b81fccb4a06ea948ecd7~ecF7VRzTG0486304863epcas1p3g;
        Wed, 17 Oct 2018 15:54:35 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        59.4D.04078.B3B57CB5; Thu, 18 Oct 2018 00:54:35 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181017155434epcas1p33a6de1fda3c69cc966f954796a95a935~ecF67ZgmI0883908839epcas1p3a;
        Wed, 17 Oct 2018 15:54:34 +0000 (GMT)
X-AuditID: b6c32a36-b3dff70000000fee-05-5bc75b3b1c4a
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 1B.A6.03743.A3B57CB5; Thu, 18 Oct
        2018 00:54:34 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:54:34 +0900 (KST)
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
Subject: [PATCH v2 13/17] thermal: tegra: enable+check sensor after its
 setup is finished
Date:   Wed, 17 Oct 2018 17:52:39 +0200
Message-id: <1539791563-5959-14-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUhTURjGO3f33l2ta7cpelIQWkVoqC0sTloRkXHDAqH/2h829KKi07Gr
        koriV2nTSSJimKlomi3DD8zNj0CmbjnK8qNpmZo5QkvUmKIZuZxX//u97/O8PM+BQ4kkeYQ3
        FZeYzKkTFQlS0hXv7PcLDAiVm+VnVnoPorzsegy1PW4h0A+7GaBX2kEc1YxbCdSXMwaQ4/sv
        Aln0uRjKr6zD0TPbnBiNdVeRyK4dAKhqeUqMbHMlJFro8ELtTZMk+tNdjaM3M3ZwRcLmrphI
        tnL2Pcl2VU6L2ddfzrH1vYsY2657SLJfrb0kq81bJtmSDh1g9dZqEfu2YgNnzZN6jLW3+0bQ
        d1wvRnMJcamcOujyXdfYmno9UK1R9zTdPUQ2MIk1wIWCTDAsMjtwDXClJIwBwO1qCyEMGwAu
        VVvJfddmiUMkCK0AWuvrCKcgYbYANG7fcjLJhMDSAh3QAIryYMJhRzPlXIuYQRzO2/2c7M7I
        oanFsJuMMyfhYF+5yMk0w8ImzTghZPnCIVPZLrvs7IcdtXsdKsRwqTRL4Guwc/YFJrA7/Gnu
        EDtjIeMDRwcvOWvu2Hf6bzXgwtACYPM7095BKOw3jxBCOTe4vF5MCMc0LHwgESwsXJvSYcJ7
        nwC4UFuGPQJHa8EBHfDkVLwyhuNlqrOBvELJpyTGBEYlKdvB7tfwP28AdcM3jYChgPQQbfA0
        ySWEIpVPUxoBpERSDzr9mFkuoaMVaemcOilSnZLA8UbgQ+FSL9rm/VQuYWIUyVw8x6k49b6K
        US7e2SDy/ujp8HWtWhl/u9w9w9u6pRn6rPGyWCaSToyfMkwetg/kNObH6zcXCmWrXaOWlLDl
        +Q9TSRdaZQvKzIAjfy2xNv1LKv9fkEfbRibKXxs6fmNE1ujVkBGy+jEqzi2rMr732yKd/btl
        LKIofaLH9ul6crCquIDZBsbQsKvTM8+lOB+rkPmL1LziP3wYO9QWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t9jQV2r6OPRBhf6NS2aGxYzWWycsZ7V
        4tnn44wWa3uPsljMv3KN1eJA42VGi/+PXrNanNrexGTRMmsRi8WSJw/ZLS7vmsNm8bn3CKPF
        nHe32S2ePOxjs3ixRdxi04obbBY/d81jsdh77zOjg5BH0/tjbB6z7p9l89g56y67x9Zbph6L
        97xk8ti0qpPN4861PWwevc3v2Dz6tqxi9Nh+bR6zx4np31k8jt/YzuTxeZNcAG8Ul01Kak5m
        WWqRvl0CV8b8xdsZC75wVHTt2s3awHiMvYuRk0NCwETiR99/5i5GLg4hgXWMEicWf2SHcH4x
        SsyaM40NpIpNwEpiYvsqxi5GDg4RAW+JLWs4QGqYBY6ySKyd8Q2sRlggWuLewh4mEJtFQFXi
        6IGpzCA2r4CHxIquK6wQ2+QkTh6bDGZzAsXP/V8A1isk4C5xcsdL9gmMPAsYGVYxSqYWFOem
        5xYbFRjmpZbrFSfmFpfmpesl5+duYgRGwLbDWn07GO8viT/EKMDBqMTDu0PsWLQQa2JZcWXu
        IUYJDmYlEd4qxePRQrwpiZVVqUX58UWlOanFhxilOViUxHlv5x2LFBJITyxJzU5NLUgtgsky
        cXBKNTAaP50292yIUP+7DPOi0IeH/jeIJc25MuPp+sCTzpEGkXdzJ5y7ZPw6yGXFk0oh4d7Y
        N1phHe9fnD5wZv/2YwYC/NOOJ8x+eiyofWngFhENzXV72MN+PZfPiTrgUyvra3cz0/7evPKa
        ik7LTbPusVs+0FhcmZ3jVyzc2FrVKHzq4sG03uszvgkqsRRnJBpqMRcVJwIATPVN/3wCAAA=
X-CMS-MailID: 20181017155434epcas1p33a6de1fda3c69cc966f954796a95a935
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181017155434epcas1p33a6de1fda3c69cc966f954796a95a935
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155434epcas1p33a6de1fda3c69cc966f954796a95a935@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable+check sensor after setting zone->tz and programming hwtrips.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/tegra/soctherm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 2ac9f81..394b34e 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1375,9 +1375,6 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 			goto disable_clocks;
 		}
 
-		thermal_zone_set_mode(z, THERMAL_DEVICE_ENABLED);
-		thermal_zone_device_check(z);
-
 		zone->tz = z;
 		tegra->thermctl_tzs[soc->ttgs[i]->id] = z;
 
@@ -1385,6 +1382,9 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
 		err = tegra_soctherm_set_hwtrips(&pdev->dev, soc->ttgs[i], z);
 		if (err)
 			goto disable_clocks;
+
+		thermal_zone_set_mode(z, THERMAL_DEVICE_ENABLED);
+		thermal_zone_device_check(z);
 	}
 
 	soctherm_debug_init(pdev);
-- 
1.9.1


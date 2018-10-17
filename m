Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BE0ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE06621528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MZIdGFi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE06621528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeJQXux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:50:53 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:63400 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:50:52 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181017155430epoutp018e84d6d39ec6a3c6e95cc037bc3b043b~ecF29lpfw3012130121epoutp01D;
        Wed, 17 Oct 2018 15:54:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181017155430epoutp018e84d6d39ec6a3c6e95cc037bc3b043b~ecF29lpfw3012130121epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791670;
        bh=U1IhVFsSqW2TG06k3HCt9gp0mnPHXvzkI3ko6pz8vZs=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=MZIdGFi5liua3bG5uUyQVdUMynBrvfKJvDRLzTbruoAy6XVNquCV0pigXbbAxBRdN
         ls9TBK5xMIysjiZqwoAVIh2RmVrmTXZ/gUAnCJsO3Ho/+RJPqr5WwGvZUFQ0dK/s2n
         +ecKWn/XCk9G4IS39YOwyKISLOEXOOfkpir3eTPo=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20181017155429epcas2p4248d231b6e5ebae6c9df0f02b411546a~ecF18wDyQ0750407504epcas2p4V;
        Wed, 17 Oct 2018 15:54:29 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.5F.04069.53B57CB5; Thu, 18 Oct 2018 00:54:29 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181017155428epcas2p1aca0b5e7b30b89db7be7026dfa740fc6~ecF1IC3ZR2791227912epcas2p1Q;
        Wed, 17 Oct 2018 15:54:28 +0000 (GMT)
X-AuditID: b6c32a48-e59ff70000000fe5-21-5bc75b35ce67
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id F7.44.03633.43B57CB5; Thu, 18 Oct
        2018 00:54:28 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:54:28 +0900 (KST)
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
Subject: [PATCH v2 12/17] thermal: exynos: enable+check sensor after its
 setup is finished
Date:   Wed, 17 Oct 2018 17:52:38 +0200
Message-id: <1539791563-5959-13-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHfbezs7PZ5DBN3zSsFhIKWYnG25UgPxyywE9dXGWHdpiSm7Iz
        Jf1QpuUNp+WMeVmz1EyGlxzLTbPwumXkogyz0tVKzC5YtEDSwtyOfvv/n+f/8HseeAi+tEgQ
        TqSrtYxGTWfIcDHWPRS9e3uC3Cnf+du2HhXmN/FQV02nAM16nQC160Yw1PBqQoD6r4wDtPzx
        mwA9tRXw0NW6Rgw1z3iEaLzXiCOvbhgg4/w7IZrxVOBozhqGLK2TOPrTa8LQI7cXHJJSBT8c
        OFX3fgyneuqmhdSDtwlUU98XHmUxl+LU1EQfTukK53GqwmoGlG3CxKeeGBYwyjlp41FeS2Sy
        JEW8X8FkpOcwmh0Hz4nTBjp6+Fk14ot6nR3LBy6iDIgISMbD6govvwyICSlpB3DIWQ84swCg
        y9gtWEt9vuPBucZ9AMvdvRhnFgEs7O/AfSmc3AtvFJtXxgkihEyC1jY/gk+OYPCTN9qng8nT
        cE7fjfk0RkbBxp8DQp+WkBRcbO3jcbBIOOrQ+8Gilbpr+bYfDEmTEA7rDUIulAgnizpWdTD8
        6rSu6gg4a+4C3IABwO+LdzHOdALY9syxiti3cugLAbdeECwZ+if0bQ1JCSwpknIRCv6d0/G4
        K+sBdBjHBNfBhtsgwAxCmSxWpWTYuKz4WJZWsdlqZez5TJUF+L8jhrKDftfRQUASQLZOYg91
        yKUCOofNVQ0CSPBlIZK8LU65VKKgc/MYTWaqJjuDYQdBBIHJwiSeiFtyKamktcwFhsliNGtd
        HiEKzwdOddzLY+0iV3FDRNI29/zSvcqoma05pD6FDjmbOp3Y0GdS3EyJ0lY9Tj5iEeoMKZs1
        J8vrWhvdtR/esM+XRp1zQZ7qEhk95a7tP+FQBJ3x6F/nVREt7RvD05pbutHMpqLS45XXHmpP
        KRoNgfWHjcr0wEu/pgLQZEukrPLA5T0yjE2jd8XwNSz9H5E9JIQZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t9jQV2T6OPRBg3T5SyaGxYzWWycsZ7V
        4tnn44wWa3uPsljMv3KN1eJA42VGi/+PXrNanNrexGTRMmsRi8WSJw/ZLS7vmsNm8bn3CKPF
        nHe32S2ePOxjs3ixRdxi04obbBY/d81jsdh77zOjg5BH0/tjbB6z7p9l89g56y67x9Zbph6L
        97xk8ti0qpPN4861PWwevc3v2Dz6tqxi9Nh+bR6zx4np31k8jt/YzuTxeZNcAG8Ul01Kak5m
        WWqRvl0CV8bBdTuZC2ZwVUzu3cHSwHiOo4uRk0NCwETi+cKHbF2MXBxCAusYJf5/2sEO4fxi
        lLi2sJkJpIpNwEpiYvsqxi5GDg4RAW+JLWs4QGqYBY6ySKyd8Y0NJC4sECMxcY8DSDmLgKrE
        og8H2UFsXgEPiV8r9jBBLJOTOHlsMiuIzQkUP/d/ARuILSTgLnFyx0v2CYw8CxgZVjFKphYU
        56bnFhsVGOWllusVJ+YWl+al6yXn525iBIb/tsNa/TsYHy+JP8QowMGoxMO7Q+xYtBBrYllx
        Ze4hRgkOZiUR3irF49FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEefnzj0UKCaQnlqRmp6YWpBbB
        ZJk4OKUaGE1/twZwfon7nu5neGT65ZmCt+5OsNq8XMol8nuFlGBO3F6jImm7yXrKU9prf044
        waZ96Nj5M9qHd7733XorNfEJx8+iy1vctpidZp+57AtL0EUB+7q2HQsX16yRktv26dX5ZS7l
        F6XrPDklEnrW96QG5K6cL3CIv2J5yd84DSldI6Ub+js3rVRiKc5INNRiLipOBADFkLNLewIA
        AA==
X-CMS-MailID: 20181017155428epcas2p1aca0b5e7b30b89db7be7026dfa740fc6
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181017155428epcas2p1aca0b5e7b30b89db7be7026dfa740fc6
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155428epcas2p1aca0b5e7b30b89db7be7026dfa740fc6@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable sensor after doing chipset specific initialization operation and
check sensor after doing chipset specific control operation.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 8ec74a62..796a868 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1109,15 +1109,14 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		goto err_sclk;
 	}
 
-	thermal_zone_set_mode(data->tzd, THERMAL_DEVICE_ENABLED);
-	thermal_zone_device_check(data->tzd);
-
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize TMU\n");
 		goto err_thermal;
 	}
 
+	thermal_zone_set_mode(data->tzd, THERMAL_DEVICE_ENABLED);
+
 	ret = devm_request_irq(&pdev->dev, data->irq, exynos_tmu_irq,
 		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
 	if (ret) {
@@ -1126,6 +1125,9 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	}
 
 	exynos_tmu_control(pdev, true);
+
+	thermal_zone_device_check(data->tzd);
+
 	return 0;
 
 err_thermal:
-- 
1.9.1


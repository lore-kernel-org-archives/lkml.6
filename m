Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F35ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C89821528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VUBQ1a/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C89821528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeJQXuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:50:22 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:18323 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:50:21 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181017155359epoutp03daca6f889c99df4b424a420a10afec6e~ecFaLBLjq1144411444epoutp03D;
        Wed, 17 Oct 2018 15:53:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181017155359epoutp03daca6f889c99df4b424a420a10afec6e~ecFaLBLjq1144411444epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539791639;
        bh=BjHWSgE6ioPfo1cNsI+0aulJ9sCAkQ2i4MrtRlzD37Y=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=VUBQ1a/1721XQrT7RIXAZN3NIebztTmd1G2xVL0ElZEK6JAygeUbsL4Ryd4McxAU1
         oGBF+h6IwsGWTHbqDGZqu302nSAb5wu28q0s8Be+d+QWLi6V8u/z08+ppnxVIWMLLL
         IeApuchZQFu0qpuNMjM5F2WsIDNvxCcK6++etgeU=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017155358epcas1p2ed29860f0fc6594a3eee6c81bb039a9f~ecFZkgmVF2440224402epcas1p22;
        Wed, 17 Oct 2018 15:53:58 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.4D.04078.61B57CB5; Thu, 18 Oct 2018 00:53:58 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181017155357epcas1p3900b1d3522c636fdee27ab9928c076e1~ecFYR7OVr0486304863epcas1p3Z;
        Wed, 17 Oct 2018 15:53:57 +0000 (GMT)
X-AuditID: b6c32a36-b25ff70000000fee-d6-5bc75b1637ef
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 38.A6.03743.51B57CB5; Thu, 18 Oct
        2018 00:53:57 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PGR00KZM2SD3M00@mmp2.samsung.com>; Thu, 18 Oct 2018
        00:53:57 +0900 (KST)
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
Subject: [PATCH v2 07/17] thermal: hisi_thermal: enable+check sensor after
 its setup is finished
Date:   Wed, 17 Oct 2018 17:52:33 +0200
Message-id: <1539791563-5959-8-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSXUiTYRTHe7b3a9bi5VXmk4LRwIspaUbmY37kReBrdlE3BQ6pmS8qTV2b
        H2lBS6OpNCm60OYnamVL03TmFCvxY0stzRyiqZU6zTT0YoofFdZ89e5/zvn9zzkcDiVkcnEP
        KikljVOnKJRSwgV73S3zPyqRW+XHLD+CUK62WoBeFTfgaN5hBahe34uhCtsojjrvjAC0PbOE
        o/7WHAG6a6jCUI19mkQj7aUEcuh7ACpdniCRfbqQQAsmd9RUO0agzfZyDL356gARDJuzYiFY
        w7ePBNtmmCLZli+BbHXHTwHbZMwn2MnRDoLV5y4TbKHJCNjW0XIh+75oHWOtY60C1tHkdV4c
        4xIazymTMji1f/gVl0TDSx2patx/ozC3j9SCYVEBEFGQPgHLv7dgBcCFYmgzgPP6BpIP1gFc
        MlWBParY9o50aoZuBHB2nOGhLQALHIO4s0DQp+BDnfG/gaLc6GhoqqOcaSHdi8FZh8ypXek4
        2DZiFjo1RnvDufISoRMX05GwYiWCH+UF+yyPdjqKaBYOblcSzlGQLiLhXE8twUNnYLP57a52
        hYtWE+nsA2lP+Lk3bJcH8NfWE4wPGgCs+2AR8IYQ2G0dxvnlDsLltfs4bxbDvHsMj7DQWriw
        e4gSAPWmp+ABOFQJ9hmBhFNpkhM4TYDquJ9GkaxJT0nwu5qa3AR2XsPnpBlUDZ7rAjQFpAfE
        ZolFzuCKDE1WcheAlFDqJs4+YpUz4nhFVjanTr2sTldymi7gSWFSd7Hdo0zO0AmKNO4ax6k4
        9V5VQIk8tKDztFf9qmAya85XtjEkuzQZvAQWqwz9h4v7O65XBt6KtiX9jbGPByXFTJ3Nj8uc
        CB0I2cjMrI7MCAuPYmzKFPGFZ/Xet4Ozmz1rbla7CmdTdXbV0EBsFOX7XCeKbVyulckj8kS1
        n7TDoRftv/9srr6QR5pncKVkrSzssS81uSDFNImKAB+hWqP4ByUcBXYWAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t9jQV3R6OPRBs++yVg0Nyxmstg4Yz2r
        xbPPxxkt1vYeZbGYf+Uaq8WBxsuMFv8fvWa1OLW9icmiZdYiFoslTx6yW1zeNYfN4nPvEUaL
        Oe9us1s8edjHZvFii7jFphU32Cx+7prHYrH33mdGByGPpvfH2Dxm3T/L5rFz1l12j623TD0W
        73nJ5LFpVSebx51re9g8epvfsXn0bVnF6LH92jxmjxPTv7N4HL+xncnj8ya5AN4oLpuU1JzM
        stQifbsEroxZ69rZCzZwV/Q1n2RvYLzI2cXIySEhYCIx48p+9i5GLg4hgXWMEs1tCxghnF+M
        Eu+3zWACqWITsJKY2L4KKMHBISLgLbFlDQdIDbPAURaJtTO+sYHUCAskScy8eIoFxGYRUJV4
        Om82M0g9r4C7xPz3DhDL5CROHpvMCmJzCnhInPu/AKxVCKjk5I6X7BMYeRYwMqxilEwtKM5N
        zy02KjDMSy3XK07MLS7NS9dLzs/dxAgM/22Htfp2MN5fEn+IUYCDUYmHd4fYsWgh1sSy4src
        Q4wSHMxKIrxVisejhXhTEiurUovy44tKc1KLDzFKc7AoifPezjsWKSSQnliSmp2aWpBaBJNl
        4uCUamD0koo+tP+kiGRPxJ7FGyYHsxnPqtt1xUnE/qBc5s63rJyfsuStly2ptbhgt+5gbcdE
        +6T9qkrrdz76Mm93Smvz9cuSbcbHhSYIu8U8fyHxWaQx0Evk6+RApuA18QI5l847b1tXe708
        qmXeivz0TkWr75WGEzVW5BlY+W8108k4KvXvyOFI691KLMUZiYZazEXFiQCOnuUxewIAAA==
X-CMS-MailID: 20181017155357epcas1p3900b1d3522c636fdee27ab9928c076e1
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181017155357epcas1p3900b1d3522c636fdee27ab9928c076e1
References: <1539791563-5959-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20181017155357epcas1p3900b1d3522c636fdee27ab9928c076e1@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Enable+check sensor after checking ntrips and doing chipset specific
  enable operation.

* Remove superfluous second sensor enable+check attempt.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/hisi_thermal.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index cc4e2ca..370696c 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -488,9 +488,6 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 		return ret;
 	}
 
-	thermal_zone_set_mode(sensor->tzd, THERMAL_DEVICE_ENABLED);
-	thermal_zone_device_check(sensor->tzd);
-
 	trip = of_thermal_get_trip_points(sensor->tzd);
 
 	for (i = 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
@@ -553,6 +550,9 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	thermal_zone_set_mode((&data->sensor)->tzd, THERMAL_DEVICE_ENABLED);
+	thermal_zone_device_check((&data->sensor)->tzd);
+
 	if (data->irq) {
 		ret = devm_request_threaded_irq(dev, data->irq, NULL,
 				hisi_thermal_alarm_irq_thread,
@@ -563,9 +563,6 @@ static int hisi_thermal_probe(struct platform_device *pdev)
 		}
 	}
 
-	thermal_zone_set_mode((&data->sensor)->tzd, THERMAL_DEVICE_ENABLED);
-	thermal_zone_device_check((&data->sensor)->tzd);
-
 	return 0;
 }
 
-- 
1.9.1


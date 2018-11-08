Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83F7ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E8F20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MJbOXuUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E8F20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeKHXVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:21:32 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55119 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeKHXVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:21:30 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181108134555euoutp01a0dfea03ef25b92004ecb5651e807f81~lKh3fVK6X0612206122euoutp01A;
        Thu,  8 Nov 2018 13:45:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181108134555euoutp01a0dfea03ef25b92004ecb5651e807f81~lKh3fVK6X0612206122euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541684755;
        bh=qvh3V9PLthjx6o4AmMgdFWNv2iBqoQahmEOZ2QTJhmI=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=MJbOXuUP+xdlJOZRUyqeeDkytNzLqQVuMFJLKGqRvYstUmteyXJI10QPc7TwDSeDI
         XewTGwr9pO+v2XcPVPXuXgFXOKy4ALkxxfGf42oj2qxugB2vnLFTb7IIm06cYJGd5b
         4E1uKrqSKMHqcJvXiwOza5TUSQQ0X+9kJbNmC2FY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181108134554eucas1p1c21490dc498a1c5eed4a8c653bbffdf3~lKh3Ee1Ii0883408834eucas1p1i;
        Thu,  8 Nov 2018 13:45:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6B.7A.04806.21E34EB5; Thu,  8
        Nov 2018 13:45:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181108134554eucas1p20df6cef615670df482e1f6c8ac4b86de~lKh2fC9XO1374713747eucas1p2I;
        Thu,  8 Nov 2018 13:45:54 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-b4-5be43e124df1
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 76.70.04284.21E34EB5; Thu,  8
        Nov 2018 13:45:54 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PHV00GNNNKETS20@eusync1.samsung.com>;
        Thu, 08 Nov 2018 13:45:54 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/4] extcon: max77843: Avoid forcing UART path on drive
 probe
Date:   Thu, 08 Nov 2018 14:45:45 +0100
Message-id: <20181108134548.31140-2-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181108134548.31140-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7djP87pCdk+iDTYfUbTYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLGef3MVmsPXKX3eJ24wo2B3aPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7Ms
        tUjfLoEro2FLbcEZoYrnW/kbGI/ydzFyckgImEjsXzGftYuRi0NIYAWjRNPv/1DOZ0aJ6Wu3
        MHUxcoBVPV6bBxFfxijxqHs2G4TTwCTx8Od2dpBRbAKGEl1vu9hAbBEBZ4nbH76xgNjMAg8Z
        JbZcVQCxhQX8JQ5P3gBWzyKgKrFqwhZWEJtXwFZi94GLrBAnyUus3nCAGcTmFLCTuPbuC9gy
        CYGvrBLrJjWwQBS5SHR0L4CyhSVeHd/CDmHLSHR2HGSCaGhmlGifMYsdwulhlNg6ZwcbRJW1
        xOHjEOuYBfgkJm2bzgzxJ69ER5sQRImHxKEjx5kh3pzIKHGjZTX7BEbJBYwMqxjFU0uLc9NT
        i43zUsv1ihNzi0vz0vWS83M3MQJj7fS/4193MO77k3SIUYCDUYmHV0LxcbQQa2JZcWXuIUYJ
        DmYlEd5NOk+ihXhTEiurUovy44tKc1KLDzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBK
        NTAeZpselNLkJaB30eZZyAb3nX6e7wSz3AxcN7b/kFTrPWPY+eHGrX28JqpuZY4f0r86CJtl
        pdiEBd3pr7wnzXl80r73uW+WG+zOlE27dSZWgm3hwTmJeb/idnWVP/IXaphkcaZO8W/Aq5n7
        fYs6bTLdG15FXnwgvfbek3VR6ZxJwe/ut00on6TEUpyRaKjFXFScCAAPG5XBsQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFJMWRmVeSWpSXmKPExsVy+t/xy7pCdk+iDSZsZLPYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLGef3MVmsPXKX3eJ24wo2B3aPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7Ms
        tUjfLoEro2FLbcEZoYrnW/kbGI/ydzFycEgImEg8XpvXxcjFISSwhFHi5YzbTBBOE5PE2saH
        rF2MnBxsAoYSXW+72EBsEQFnidsfvrGAFDELPGSUeLXlCCNIQljAV+LAst9gNouAqsSqCVvA
        mnkFbCV2H7gIZksIyEus3nCAGcTmFLCTuPbuCxvIFUJANcuvck1g5FnAyLCKUSS1tDg3PbfY
        UK84Mbe4NC9dLzk/dxMjMES2Hfu5eQfjpY3BhxgFOBiVeHgPyD2OFmJNLCuuzD3EKMHBrCTC
        u0nnSbQQb0piZVVqUX58UWlOavEhRmkOFiVx3vMGlVFCAumJJanZqakFqUUwWSYOTqkGRhvH
        zs9Hdj7Yo8jOLPI/0bHQ96got3JLXPNyOe3dK3tbl7/65cn39MoTOa/Mv3HHzX9P+/fEWit/
        c5guPw+3+JfG017xvwtVtQReRt4NbGV8ItqxKJaT7dLRrpm7inikAva+mj6bfe7E5ZI7962W
        K7wzhf3wbROxHRfdDJgW3+kP2WYtL7QyWomlOCPRUIu5qDgRAOSI3YkNAgAA
X-CMS-MailID: 20181108134554eucas1p20df6cef615670df482e1f6c8ac4b86de
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181108134554eucas1p20df6cef615670df482e1f6c8ac4b86de
References: <20181108134548.31140-1-m.szyprowski@samsung.com>
        <CGME20181108134554eucas1p20df6cef615670df482e1f6c8ac4b86de@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver unconditionally forces UART path during probe, probably to ensure
that one can get kernel serial log as soon as possible.

This approach causes some issues, especially when board is booted with
non-UART cable connected to micro-USB port. For example, when USB cable is
connected, UART TX/RX lines are unconditionally short-circuited to USB
D+/D- lines. This is in turn recognized by a series of serial BREAK
signals and some random characters when USB host tries to perform
enumeration procedure.

To solve the above issue and keep UART console operational as early as
possible, set UART path only when USB ID reports UART capable cable.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/extcon/extcon-max77843.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index b98cbd0362f5..a343a6ef3506 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -812,6 +812,8 @@ static int max77843_muic_probe(struct platform_device *pdev)
 	struct max77693_dev *max77843 = dev_get_drvdata(pdev->dev.parent);
 	struct max77843_muic_info *info;
 	unsigned int id;
+	int cable_type;
+	bool attached;
 	int i, ret;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
@@ -856,9 +858,19 @@ static int max77843_muic_probe(struct platform_device *pdev)
 	/* Set ADC debounce time */
 	max77843_muic_set_debounce_time(info, MAX77843_DEBOUNCE_TIME_25MS);
 
-	/* Set initial path for UART */
-	max77843_muic_set_path(info, MAX77843_MUIC_CONTROL1_SW_UART, true,
-			       false);
+	/* Set initial path for UART when JIG is connected to get serial logs */
+	ret = regmap_bulk_read(max77843->regmap_muic,
+			MAX77843_MUIC_REG_STATUS1, info->status,
+			MAX77843_MUIC_STATUS_NUM);
+	if (ret) {
+		dev_err(info->dev, "Cannot read STATUS registers\n");
+		goto err_muic_irq;
+	}
+	cable_type = max77843_muic_get_cable_type(info, MAX77843_CABLE_GROUP_ADC,
+					 &attached);
+	if (attached && cable_type == MAX77843_MUIC_ADC_FACTORY_MODE_UART_OFF)
+		max77843_muic_set_path(info, MAX77843_MUIC_CONTROL1_SW_UART,
+				       true, false);
 
 	/* Check revision number of MUIC device */
 	ret = regmap_read(max77843->regmap_muic, MAX77843_MUIC_REG_ID, &id);
-- 
2.17.1


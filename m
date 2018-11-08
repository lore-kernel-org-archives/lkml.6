Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB2DECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D5920825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dVKAD9Xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D5920825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeKHXVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:21:32 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54478 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbeKHXVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:21:31 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181108134556euoutp028d97dae99fa13e9c8e861907da0a8765~lKh4aMS2h2165821658euoutp02H;
        Thu,  8 Nov 2018 13:45:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181108134556euoutp028d97dae99fa13e9c8e861907da0a8765~lKh4aMS2h2165821658euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541684756;
        bh=SpTUG4XNSxiy49yB/2ovPC56gqyCOSPQBOPdlQJuoeM=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=dVKAD9XmEF3+d3kxShl01HghVsn1twQ6FGoPYol8LeBHjdHnw3xlA8amM8NTVpGVk
         oO2KIvLQPQjtGLZ1AokDnce/KEcPWkQNtPhArhhy4KRec8ajp7cCQQ8PuWUv2DxZoy
         2HgBfJ8lXaI4aBPbYPe+aFZVAf2rAaFY8NBG05Ng=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181108134555eucas1p21c794ef065f61e18ad16fdba54a9d58b~lKh4CydKR1373213732eucas1p2-;
        Thu,  8 Nov 2018 13:45:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FC.7A.04806.31E34EB5; Thu,  8
        Nov 2018 13:45:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181108134555eucas1p10f126bdad7538c224d97be4f7e31e4bb~lKh3ibjE21719217192eucas1p1B;
        Thu,  8 Nov 2018 13:45:55 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-b9-5be43e13fa88
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2A.F3.04128.31E34EB5; Thu,  8
        Nov 2018 13:45:55 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PHV00GNNNKETS20@eusync1.samsung.com>;
        Thu, 08 Nov 2018 13:45:55 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4/4] extcon: max8997: Avoid forcing UART path on drive probe
Date:   Thu, 08 Nov 2018 14:45:48 +0100
Message-id: <20181108134548.31140-5-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181108134548.31140-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7djPc7rCdk+iDRZNULPYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLGef3MVmsPXKX3eJ24wo2B3aPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7Ms
        tUjfLoErY8bxhIKZghXvdlo2MG7m62Lk5JAQMJF4/W0rSxcjF4eQwApGidurHkM5nxklrk2c
        ywpTteXuMqjEMkaJSb/msUE4DUwSBzpms4NUsQkYSnS97WIDsUUEnCVuf/jGAmIzCzxklNhy
        VQHEFhbwkXjUPZERxGYRUJXomb+ECcTmFbCV6Dm8lRlim7zE6g0HwGxOATuJa+++gC2TEPjK
        KjF3xjKoIheJPxuPskDYwhKvjm9hh7BlJC5P7maBaGhmlGifMYsdwulhlNg6ZwcbRJW1xOHj
        F1khzuOTmLRtOtBUDqA4r0RHmxBEiYfEzrsbwC4VEpjIKDFtee0ERskFjAyrGMVTS4tz01OL
        jfNSy/WKE3OLS/PS9ZLzczcxAmPt9L/jX3cw7vuTdIhRgINRiYdXQvFxtBBrYllxZe4hRgkO
        ZiUR3k06T6KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ81YzPIgWEkhPLEnNTk0tSC2CyTJxcEo1
        MMbp3BFZ+v9ippEXF98VdZbau2FH1qfpFU2vt3TlKd8/b3n0lc+zL2WkTvOImnbo0cU0t6Y0
        qSXm6mceronamLRzX/+tD8xT0xd0cuxg+7Jb2tWb4VGE9NKgvPLMPU2xB034z3ysuJK886lD
        a2eTu/3dve8jS3cVKR2vvhrlueqFhtl89xVVx5VYijMSDbWYi4oTAYImvq2xAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNJMWRmVeSWpSXmKPExsVy+t/xy7rCdk+iDc7v47HYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLGef3MVmsPXKX3eJ24wo2B3aPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7Ms
        tUjfLoErY8bxhIKZghXvdlo2MG7m62Lk5JAQMJHYcncZSxcjF4eQwBJGibctG9ghnCYmiRuf
        DrGCVLEJGEp0ve1iA7FFBJwlbn/4BtbBLPCQUeLVliOMIAlhAR+JR90TwWwWAVWJnvlLmEBs
        XgFbiZ7DW5kh1slLrN5wAMzmFLCTuPbuC9BQDqBtthLLr3JNYORZwMiwilEktbQ4Nz232Eiv
        ODG3uDQvXS85P3cTIzBIth37uWUHY9e74EOMAhyMSjy8B+QeRwuxJpYVV+YeYpTgYFYS4d2k
        8yRaiDclsbIqtSg/vqg0J7X4EKM0B4uSOO95g8ooIYH0xJLU7NTUgtQimCwTB6dUA+OhKbFx
        Lg+Y/Hq7P79LLptsx7FWlru68t6Xp6de7ytP8Pi2duo2uYTrM7q+G1xgUi7ecS+fPXz91Ssz
        T51utM7gkzjdaGG0j90xbWfe5N8Xheal16wXt7nHkCnqFDPtl56g3tcLzQUXGren7Lx/9fRs
        NqGMFWbVer5X/sXbpOev+/uU6UuikY0SS3FGoqEWc1FxIgB4o9G1DgIAAA==
X-CMS-MailID: 20181108134555eucas1p10f126bdad7538c224d97be4f7e31e4bb
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181108134555eucas1p10f126bdad7538c224d97be4f7e31e4bb
References: <20181108134548.31140-1-m.szyprowski@samsung.com>
        <CGME20181108134555eucas1p10f126bdad7538c224d97be4f7e31e4bb@eucas1p1.samsung.com>
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
 drivers/extcon/extcon-max8997.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index bdabb2479e0d..632192d027bf 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -632,6 +632,8 @@ static int max8997_muic_probe(struct platform_device *pdev)
 	struct max8997_platform_data *pdata = dev_get_platdata(max8997->dev);
 	struct max8997_muic_info *info;
 	int delay_jiffies;
+	int cable_type;
+	bool attached;
 	int ret, i;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(struct max8997_muic_info),
@@ -724,8 +726,17 @@ static int max8997_muic_probe(struct platform_device *pdev)
 		delay_jiffies = msecs_to_jiffies(DELAY_MS_DEFAULT);
 	}
 
-	/* Set initial path for UART */
-	 max8997_muic_set_path(info, info->path_uart, true);
+	/* Set initial path for UART when JIG is connected to get serial logs */
+	ret = max8997_bulk_read(info->muic, MAX8997_MUIC_REG_STATUS1,
+				2, info->status);
+	if (ret) {
+		dev_err(info->dev, "failed to read MUIC register\n");
+		return ret;
+	}
+	cable_type = max8997_muic_get_cable_type(info,
+					   MAX8997_CABLE_GROUP_ADC, &attached);
+	if (attached && cable_type == MAX8997_MUIC_ADC_FACTORY_MODE_UART_OFF)
+		max8997_muic_set_path(info, info->path_uart, true);
 
 	/* Set ADC debounce time */
 	max8997_muic_set_debounce_time(info, ADC_DEBOUNCE_TIME_25MS);
-- 
2.17.1


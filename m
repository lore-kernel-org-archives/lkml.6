Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8FDECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF1120825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sPGO5TEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF1120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbeKHXVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:21:31 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55131 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbeKHXVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:21:30 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181108134556euoutp014c1dad8f96abe970313edf63c44124de~lKh4QO4SC0572605726euoutp01D;
        Thu,  8 Nov 2018 13:45:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181108134556euoutp014c1dad8f96abe970313edf63c44124de~lKh4QO4SC0572605726euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541684756;
        bh=vRpUWpQL+tggvTY5uMit27WYvn6NjSQbU3SoxcMmhMA=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=sPGO5TEaWGS65WWnORrv8vwIWlYuf6YovvZZjg3voUximi3INeeaUxUa4DdC/YoZN
         lJD7S7S1po/A1s9SR6Xhuk3dt9+to4q5qrSbZplm5jOaQXW5Gd/61tMpjCDk2/n5hZ
         6Dv5ymKrdL00scSTySm4zdTTkW0k1UJ3ItiMCPUI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181108134555eucas1p221e4522e83bc10dce198b20ee9272a2f~lKh3rz2TY1373213732eucas1p29;
        Thu,  8 Nov 2018 13:45:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EB.7A.04806.31E34EB5; Thu,  8
        Nov 2018 13:45:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181108134554eucas1p12694abede1bf0ce633d4890e2297b685~lKh2y1f4b1720217202eucas1p1t;
        Thu,  8 Nov 2018 13:45:54 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-b5-5be43e134e02
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 69.F3.04128.21E34EB5; Thu,  8
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
Subject: [PATCH 2/4] extcon: max77693: Avoid forcing UART path on drive
 probe
Date:   Thu, 08 Nov 2018 14:45:46 +0100
Message-id: <20181108134548.31140-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181108134548.31140-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7djP87rCdk+iDX4d4bbYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLGef3MVmsPXKX3eJ24wo2B3aPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7Ms
        tUjfLoEr49bly6wF8wQrnj86zdLAuImvi5GTQ0LAROL6zXXMILaQwApGiftT+LsYuYDsz4wS
        J1vbmWGKlh9sZIVILGOUmHN5CZTTwCTx8Od2dpAqNgFDia63XWwgtoiAs8TtD99YQGxmgYeM
        EluuKnQxcnAIC/hLPJ2ZBxJmEVCVaG2czghi8wrYSvxct4kFYpm8xOoNB8AWcwrYSVx794UN
        ZJeEwE9Wicd/QK4AKXKRuPDwGFSDsMSr41vYIWwZicuTu1kgGpoZJdpnzGKHcHoYJbbO2cEG
        UWUtcfj4RVaI6/gkJm2bzgxynYQAr0RHmxBEiYfE1bndUF9OZJQ49qGZfQKj5AJGhlWM4qml
        xbnpqcXGeanlesWJucWleel6yfm5mxiB0Xb63/GvOxj3/Uk6xCjAwajEwyuh+DhaiDWxrLgy
        9xCjBAezkgjvJp0n0UK8KYmVValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJpCeWpGanphakFsFk
        mTg4pRoYVxX+nlpV6K2a8CPwXuFjiegNVh2r29z3/tLRD+fuZYhyeNNgobOL28rWeKK54DRO
        y86uxZYP/oguufVddv9euwzd33bc6hMfhsqkbf3x9fozz1Nth/b3r27UTP0xwUfL7Lm0dWFP
        6LEzqyb/PVVqGWv09c4zt5tqXFfE3zFNepBzuCnYavZuJZbijERDLeai4kQAKxap3LICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLJMWRmVeSWpSXmKPExsVy+t/xy7pCdk+iDa6skbHYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLGef3MVmsPXKX3eJ24wo2B3aPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7Ms
        tUjfLoEr49bly6wF8wQrnj86zdLAuImvi5GTQ0LARGL5wUbWLkYuDiGBJYwSU28/hHKamCTW
        NoI4nBxsAoYSXW+72EBsEQFnidsfvrGAFDELPGSUeLXlCCNIQljAV+L+rRPsIDaLgKpEa+N0
        sDivgK3Ez3WbWCDWyUus3nCAGcTmFLCTuPbuC9BQDqBtthLLr3JNYORZwMiwilEktbQ4Nz23
        2EivODG3uDQvXS85P3cTIzBQth37uWUHY9e74EOMAhyMSjy8B+QeRwuxJpYVV+YeYpTgYFYS
        4d2k8yRaiDclsbIqtSg/vqg0J7X4EKM0B4uSOO95g8ooIYH0xJLU7NTUgtQimCwTB6dUA2Od
        fI8CN0P/nC+//rQFbfi4n3m1zJtOfu3P8Wo9pekb3n16U7BU9snvfCu/hocVXRn3VTnEth5b
        u5GBa9HDuMq3l1+GfhOzFF5udDEuVfCggQEPg+NuOz63RxXHvxvLL91k+26BraGzxZKTwTrl
        Rx6FNCZziBUcTl4V9il0SdpzCY/TUzI25CuxFGckGmoxFxUnAgA+m6CCEAIAAA==
X-CMS-MailID: 20181108134554eucas1p12694abede1bf0ce633d4890e2297b685
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181108134554eucas1p12694abede1bf0ce633d4890e2297b685
References: <20181108134548.31140-1-m.szyprowski@samsung.com>
        <CGME20181108134554eucas1p12694abede1bf0ce633d4890e2297b685@eucas1p1.samsung.com>
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
 drivers/extcon/extcon-max77693.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index a79537ebb671..32fc5a66ffa9 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -1072,6 +1072,8 @@ static int max77693_muic_probe(struct platform_device *pdev)
 	struct max77693_reg_data *init_data;
 	int num_init_data;
 	int delay_jiffies;
+	int cable_type;
+	bool attached;
 	int ret;
 	int i;
 	unsigned int id;
@@ -1212,8 +1214,18 @@ static int max77693_muic_probe(struct platform_device *pdev)
 		delay_jiffies = msecs_to_jiffies(DELAY_MS_DEFAULT);
 	}
 
-	/* Set initial path for UART */
-	 max77693_muic_set_path(info, info->path_uart, true);
+	/* Set initial path for UART when JIG is connected to get serial logs */
+	ret = regmap_bulk_read(info->max77693->regmap_muic,
+			MAX77693_MUIC_REG_STATUS1, info->status, 2);
+	if (ret) {
+		dev_err(info->dev, "failed to read MUIC register\n");
+		return ret;
+	}
+	cable_type = max77693_muic_get_cable_type(info,
+					   MAX77693_CABLE_GROUP_ADC, &attached);
+	if (attached && (cable_type == MAX77693_MUIC_ADC_FACTORY_MODE_UART_ON ||
+			 cable_type == MAX77693_MUIC_ADC_FACTORY_MODE_UART_OFF))
+		max77693_muic_set_path(info, info->path_uart, true);
 
 	/* Check revision number of MUIC device*/
 	ret = regmap_read(info->max77693->regmap_muic,
-- 
2.17.1


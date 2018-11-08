Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF716ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978A120825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MpwfSApe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978A120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeKHXVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:21:32 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55129 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeKHXVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:21:30 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181108134556euoutp01bca31f16902bbc0331d97b2159239642~lKh4OwcLf0570905709euoutp01J;
        Thu,  8 Nov 2018 13:45:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181108134556euoutp01bca31f16902bbc0331d97b2159239642~lKh4OwcLf0570905709euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541684756;
        bh=bFujyy0o4H8gCi49hkwnl6cUPt+eOaf+xnWYuyuPuT0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=MpwfSApe8DTJd+rQxywpYzY7F83E0jrhRg7YHes/3SyJrd8rIz3uIw5f/26dNDY11
         XSgcG6AzQneZPy34e6M/1tyk+r4U2ZfmJkVZs2Pt23/TLmqN9+VoINAZwu5lY23/tY
         e/Hb7wJKGSiOnIAUqDKfumhH3FopUwm/TY74ubVI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181108134555eucas1p1734d251d6854d0bbc67a7ed70e07b54e~lKh32ZQvg0883808838eucas1p1d;
        Thu,  8 Nov 2018 13:45:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6C.7A.04806.31E34EB5; Thu,  8
        Nov 2018 13:45:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181108134554eucas1p26363910951ef941a3b80f47a1c0006c2~lKh3JD2b11557415574eucas1p20;
        Thu,  8 Nov 2018 13:45:54 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-b6-5be43e1384e6
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 47.70.04284.21E34EB5; Thu,  8
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
Subject: [PATCH 3/4] extcon: max14577: Avoid forcing UART path on drive
 probe
Date:   Thu, 08 Nov 2018 14:45:47 +0100
Message-id: <20181108134548.31140-4-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20181108134548.31140-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7djP87rCdk+iDRb95rfYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLGef3MVmsPXKX3eJ24wo2B3aPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7Ms
        tUjfLoEr4/6eVraCCYIVa68eZm9gXMfXxcjJISFgInF53SGWLkYuDiGBFYwSe1c/Z4NwPjNK
        PDr+nAWm6ufkSawQiWWMEuem3GGCcBqYJB7+3M4OUsUmYCjR9baLDcQWEXCWuP3hG1g3s8BD
        RoktVxVAbGEBf4krj9+zgtgsAqoSz/6vA6vhFbCVmPtpC9Q2eYnVGw4wg9icAnYS1959ATtJ
        QuAnq8Tk6a+BNnMAOS4Scz9UQNQLS7w6voUdwpaR6Ow4yARR38wo0T5jFjuE08MosXXODjaI
        KmuJw8cvskJcxycxadt0ZoihvBIdbUIQpofExXtyEE9OZJRo2XmLfQKj5AJGhlWM4qmlxbnp
        qcXGeanlesWJucWleel6yfm5mxiB0Xb63/GvOxj3/Uk6xCjAwajEwyuh+DhaiDWxrLgy9xCj
        BAezkgjvJp0n0UK8KYmVValF+fFFpTmpxYcYpTlYlMR5qxkeRAsJpCeWpGanphakFsFkmTg4
        pRoY989s3qm1M341q6LW8tM6/7sfN4ZuOu/30OWkw5LbtzJE7TV9TQTEd8yL/T/Dxcr+sebD
        gvwnMVpvcu4zrr9j/UhmRvB/C80HR5Y722Tz2F9Q1DCIuj9piWzIe54dxg8+HWqR+ZS2mpt/
        48r7NdllGx6EKu+YNcfU5JHitGdFSeqpjpaWpxRmK7EUZyQaajEXFScCAOb1FYiyAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLJMWRmVeSWpSXmKPExsVy+t/xy7pCdk+iDW5+MLLYOGM9q8X1L89Z
        Lc6f38BucXnXHDaLGef3MVmsPXKX3eJ24wo2B3aPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7Ms
        tUjfLoEr4/6eVraCCYIVa68eZm9gXMfXxcjJISFgIvFz8iTWLkYuDiGBJYwSXzc9g3KamCTW
        Nj5kBaliEzCU6HrbxQZiiwg4S9z+8I0FpIhZ4CGjxKstRxhBEsICvhL9Ly4yg9gsAqoSz/6v
        YwGxeQVsJeZ+2sICsU5eYvWGA2A1nAJ2EtfefQEaygG0zVZi+VWuCYw8CxgZVjGKpJYW56bn
        FhvqFSfmFpfmpesl5+duYgQGyrZjPzfvYLy0MfgQowAHoxIP7wG5x9FCrIllxZW5hxglOJiV
        RHg36TyJFuJNSaysSi3Kjy8qzUktPsQozcGiJM573qAySkggPbEkNTs1tSC1CCbLxMEp1cDI
        u18nVaIlQnx7xd9fr29XWOXtSGsIWu2yV/d35n3Bzw/7I9fds+F1TJh5xsL59qOMo8dvTyoL
        Lpr1jke+9Rav4S9zedfeh+tnv+IoaW3SNLNblGi+bEvn5Gs7tlkyO2/K3SF9eFI454sXrSXG
        TipP5oVrPzZZKz5pxo/06wFzxPr99UKMtrMpsRRnJBpqMRcVJwIAHcIfJhACAAA=
X-CMS-MailID: 20181108134554eucas1p26363910951ef941a3b80f47a1c0006c2
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181108134554eucas1p26363910951ef941a3b80f47a1c0006c2
References: <20181108134548.31140-1-m.szyprowski@samsung.com>
        <CGME20181108134554eucas1p26363910951ef941a3b80f47a1c0006c2@eucas1p2.samsung.com>
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
 drivers/extcon/extcon-max14577.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
index 22d2feb1f8bc..32f663436e6e 100644
--- a/drivers/extcon/extcon-max14577.c
+++ b/drivers/extcon/extcon-max14577.c
@@ -657,6 +657,8 @@ static int max14577_muic_probe(struct platform_device *pdev)
 	struct max14577 *max14577 = dev_get_drvdata(pdev->dev.parent);
 	struct max14577_muic_info *info;
 	int delay_jiffies;
+	int cable_type;
+	bool attached;
 	int ret;
 	int i;
 	u8 id;
@@ -725,8 +727,17 @@ static int max14577_muic_probe(struct platform_device *pdev)
 	info->path_uart = CTRL1_SW_UART;
 	delay_jiffies = msecs_to_jiffies(DELAY_MS_DEFAULT);
 
-	/* Set initial path for UART */
-	max14577_muic_set_path(info, info->path_uart, true);
+	/* Set initial path for UART when JIG is connected to get serial logs */
+	ret = max14577_bulk_read(info->max14577->regmap,
+			MAX14577_MUIC_REG_STATUS1, info->status, 2);
+	if (ret) {
+		dev_err(info->dev, "Cannot read STATUS registers\n");
+		return ret;
+	}
+	cable_type = max14577_muic_get_cable_type(info, MAX14577_CABLE_GROUP_ADC,
+					 &attached);
+	if (attached && cable_type == MAX14577_MUIC_ADC_FACTORY_MODE_UART_OFF)
+		max14577_muic_set_path(info, info->path_uart, true);
 
 	/* Check revision number of MUIC device*/
 	ret = max14577_read_reg(info->max14577->regmap,
-- 
2.17.1


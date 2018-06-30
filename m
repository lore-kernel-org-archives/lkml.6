Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAACC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F327323D59
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MBB1r1AI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F327323D59
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937033AbeF3KeC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 06:34:02 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43056 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936922AbeF3Kcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 06:32:47 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5UAWjc7064961;
        Sat, 30 Jun 2018 05:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530354765;
        bh=uZRUh2ZG1qyfO39Il1OIhm8YPqcSz+mQT19CzuhyxMo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MBB1r1AI03Z1WV/RufEELWFCG7DkjxkR2HDDKgZu5Lqe66pJxxN6jL+dZ3sWSywQD
         clCHl113l7ZTVsoCvTI9gIkC7gS9GCf+SCvMBg58naS/PK+p3Oh8220DOYWARrtU0V
         fSQUaS7dIQj2mK5yQOfEtXsy+35iek0IynFlHqb8=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5UAWj07020195;
        Sat, 30 Jun 2018 05:32:45 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sat, 30
 Jun 2018 05:32:45 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sat, 30 Jun 2018 05:32:45 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5UAWd6T013640;
        Sat, 30 Jun 2018 05:32:42 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     Vignesh R <vigneshr@ti.com>, <linux-iio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>
Subject: [PATCH 1/5] mfd: ti_am335x_tscadc: Don't mark TSCADC MFD as wakeup capable
Date:   Sat, 30 Jun 2018 16:03:14 +0530
Message-ID: <20180630103318.25355-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180630103318.25355-1-vigneshr@ti.com>
References: <20180630103318.25355-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently tscadc MFD is marked as wakeup capable which incorrect
because, its actually touch event by child TSC device that wakes up the
system. Therefore, remove device_init_wakeup() call that marks TSCADC
device as wakeup capable in favor of moving to mark TSC input device as
wakeup capable later.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/mfd/ti_am335x_tscadc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 47012c0899cd..858c1a071a81 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -270,7 +270,6 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto err_disable_clk;
 
-	device_init_wakeup(&pdev->dev, true);
 	platform_set_drvdata(pdev, tscadc);
 	return 0;
 
-- 
2.18.0


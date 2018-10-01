Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AC7C0044B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75C8208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75C8208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbeJAVMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:12:07 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:59654 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729439AbeJAVMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:12:06 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w91EXwJb027369;
        Mon, 1 Oct 2018 09:33:58 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2mugjdgbcj-1;
        Mon, 01 Oct 2018 09:33:58 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id A610D611C8BB;
        Mon,  1 Oct 2018 09:36:31 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 1 Oct 2018
 15:33:57 +0100
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w91EXvlp027435;        Mon, 1 Oct 2018 15:33:57 +0100
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] mfd: madera: Wait for BOOT_DONE before reading device ID
Date:   Mon, 1 Oct 2018 15:33:57 +0100
Message-ID: <20181001143357.28428-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181001143357.28428-1-rf@opensource.cirrus.com>
References: <20181001143357.28428-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810010143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It isn't safe to read the device ID in SOFTWARE_RESET register
until the silicon boot sequence has completed. This patch
rearranges the code to wait for BOOT_DONE first.

If we don't have a GPIO to control hard reset we must issue
a soft reset to get the silicon into a known-good booted state
before reading the device ID.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/mfd/madera-core.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 3ff9a0615658..b9d42edf96c9 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -454,10 +454,23 @@ int madera_dev_init(struct madera *madera)
 	regcache_cache_only(madera->regmap, false);
 	regcache_cache_only(madera->regmap_32bit, false);
 
+	/* If we don't have a reset GPIO use a soft reset */
+	if (!madera->pdata.reset) {
+		ret = madera_soft_reset(madera);
+		if (ret)
+			goto err_reset;
+	}
+
 	/*
-	 * Now we can power up and verify that this is a chip we know about
-	 * before we start doing any writes to its registers.
+	 * Must wait for internal boot sequence to complete before
+	 * reading the device ID
 	 */
+	ret = madera_wait_for_boot(madera);
+	if (ret) {
+		dev_err(madera->dev, "Device failed initial boot: %d\n", ret);
+		goto err_reset;
+	}
+
 	ret = regmap_read(madera->regmap, MADERA_SOFTWARE_RESET, &hwid);
 	if (ret) {
 		dev_err(dev, "Failed to read ID register: %d\n", ret);
@@ -519,22 +532,6 @@ int madera_dev_init(struct madera *madera)
 		goto err_reset;
 	}
 
-	/*
-	 * It looks like a device we support. If we don't have a hard reset
-	 * we can now attempt a soft reset.
-	 */
-	if (!madera->pdata.reset) {
-		ret = madera_soft_reset(madera);
-		if (ret)
-			goto err_reset;
-	}
-
-	ret = madera_wait_for_boot(madera);
-	if (ret) {
-		dev_err(madera->dev, "Device failed initial boot: %d\n", ret);
-		goto err_reset;
-	}
-
 	ret = regmap_read(madera->regmap, MADERA_HARDWARE_REVISION,
 			  &madera->rev);
 	if (ret) {
-- 
2.11.0


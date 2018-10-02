Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412C2C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D92204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D92204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeJBRYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:24:16 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:34820 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727007AbeJBRYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:24:15 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w92Aee4C030652;
        Tue, 2 Oct 2018 05:41:36 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2mugjdhm6q-1;
        Tue, 02 Oct 2018 05:41:36 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 91BD2611C8C1;
        Tue,  2 Oct 2018 05:41:35 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 2 Oct 2018
 11:41:34 +0100
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w92AfYlG022871;        Tue, 2 Oct 2018 11:41:34 +0100
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v2 2/2] mfd: madera: Wait for BOOT_DONE before reading device ID
Date:   Tue, 2 Oct 2018 11:41:34 +0100
Message-ID: <20181002104134.29003-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181002104134.29003-1-rf@opensource.cirrus.com>
References: <20181002104134.29003-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810020106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It isn't safe to read the device ID in the SOFTWARE_RESET
register until the silicon boot sequence has completed. This
patch rearranges the code to wait until BOOT_DONE is set.

If we don't have a hard reset line we want to defer writing a
soft reset command until we have identified the silicon as
something we recognize. As the BOOT_DONE bit is sticky it is
safe to wait for it without issuing a soft reset first, because
the most recent power-up will have caused a boot sequence and
set the bit. Note that the boot sequence is not the same as a
reset so we still have to soft reset to get the codec into a
known state.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/mfd/madera-core.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 1dedfe68a3dc..e114ca5e6c3f 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -455,10 +455,13 @@ int madera_dev_init(struct madera *madera)
 	regcache_cache_only(madera->regmap, false);
 	regcache_cache_only(madera->regmap_32bit, false);
 
-	/*
-	 * Now we can power up and verify that this is a chip we know about
-	 * before we start doing any writes to its registers.
-	 */
+	/* BOOT_DONE must be set before we can read the device ID */
+	ret = madera_wait_for_boot(madera);
+	if (ret) {
+		dev_err(madera->dev, "Device failed initial boot: %d\n", ret);
+		goto err_reset;
+	}
+
 	ret = regmap_read(madera->regmap, MADERA_SOFTWARE_RESET, &hwid);
 	if (ret) {
 		dev_err(dev, "Failed to read ID register: %d\n", ret);
@@ -528,12 +531,13 @@ int madera_dev_init(struct madera *madera)
 		ret = madera_soft_reset(madera);
 		if (ret)
 			goto err_reset;
-	}
 
-	ret = madera_wait_for_boot(madera);
-	if (ret) {
-		dev_err(madera->dev, "Device failed initial boot: %d\n", ret);
-		goto err_reset;
+		ret = madera_wait_for_boot(madera);
+		if (ret) {
+			dev_err(madera->dev, "Device failed initial soft reboot: %d\n",
+				ret);
+			goto err_reset;
+		}
 	}
 
 	ret = regmap_read(madera->regmap, MADERA_HARDWARE_REVISION,
-- 
2.11.0


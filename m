Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B920C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1462089C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1462089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbeHGLVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:21:55 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:49309 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726879AbeHGLVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:21:54 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7793qoT005499;
        Tue, 7 Aug 2018 04:08:30 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2kn8jkuns9-1;
        Tue, 07 Aug 2018 04:08:29 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id D7048611C8B5;
        Tue,  7 Aug 2018 04:10:10 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 7 Aug 2018
 10:08:29 +0100
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w7798SXt005072;        Tue, 7 Aug 2018 10:08:29 +0100
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] mfd: madera: Don't use regmap_read_poll_timeout to poll for BOOT_DONE
Date:   Tue, 7 Aug 2018 10:08:13 +0100
Message-ID: <20180807090813.15695-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180807090813.15695-1-rf@opensource.cirrus.com>
References: <20180807090813.15695-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=897 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808070093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While polling for BOOT_DONE the chip could NAK a read because it is
still booting, which would terminate the regmap_read_poll_timeout()
with an error.

Instead implement a polling loop that ignores read errors so we
always poll until the chip signals boot or the loop times out.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/mfd/madera-core.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 8cfea969b060..bc5545c53ee5 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -132,33 +132,43 @@ const char *madera_name_from_type(enum madera_type type)
 }
 EXPORT_SYMBOL_GPL(madera_name_from_type);
 
-#define MADERA_BOOT_POLL_MAX_INTERVAL_US  5000
-#define MADERA_BOOT_POLL_TIMEOUT_US	 25000
+#define MADERA_BOOT_POLL_INTERVAL_USEC		5000
+#define MADERA_BOOT_POLL_TIMEOUT_USEC		25000
 
 static int madera_wait_for_boot(struct madera *madera)
 {
-	unsigned int val;
-	int ret;
+	ktime_t timeout;
+	unsigned int val = 0;
+	int ret = 0;
 
 	/*
 	 * We can't use an interrupt as we need to runtime resume to do so,
 	 * so we poll the status bit. This won't race with the interrupt
 	 * handler because it will be blocked on runtime resume.
+	 * The chip could NAK a read request while it is booting so ignore
+	 * errors from regmap_read.
 	 */
-	ret = regmap_read_poll_timeout(madera->regmap,
-				       MADERA_IRQ1_RAW_STATUS_1,
-				       val,
-				       (val & MADERA_BOOT_DONE_STS1),
-				       MADERA_BOOT_POLL_MAX_INTERVAL_US,
-				       MADERA_BOOT_POLL_TIMEOUT_US);
-
-	if (ret)
-		dev_err(madera->dev, "Polling BOOT_DONE_STS failed: %d\n", ret);
+	regmap_read(madera->regmap, MADERA_IRQ1_RAW_STATUS_1, &val);
+	if (val & MADERA_BOOT_DONE_STS1)
+		goto done;
+
+	timeout = ktime_add_us(ktime_get(), MADERA_BOOT_POLL_TIMEOUT_USEC);
+	do {
+		usleep_range(MADERA_BOOT_POLL_INTERVAL_USEC / 2,
+			     MADERA_BOOT_POLL_INTERVAL_USEC);
+		regmap_read(madera->regmap, MADERA_IRQ1_RAW_STATUS_1, &val);
+		if (val & MADERA_BOOT_DONE_STS1)
+			goto done;
+	} while (ktime_compare(ktime_get(), timeout) <= 0);
+
+	dev_err(madera->dev, "Polling BOOT_DONE_STS timed out\n");
+	ret = -ETIMEDOUT;
 
 	/*
 	 * BOOT_DONE defaults to unmasked on boot so we must ack it.
-	 * Do this unconditionally to avoid interrupt storms.
+	 * Do this even after a timeout to avoid interrupt storms.
 	 */
+done:
 	regmap_write(madera->regmap, MADERA_IRQ1_STATUS_1,
 		     MADERA_BOOT_DONE_EINT1);
 
-- 
2.11.0


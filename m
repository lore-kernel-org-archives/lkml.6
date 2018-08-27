Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DC5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDCE208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDCE208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeH0RiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:38:05 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:46822 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726883AbeH0RiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:38:04 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7RDnZ42022400;
        Mon, 27 Aug 2018 08:51:19 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2m34h1tc7k-1;
        Mon, 27 Aug 2018 08:51:19 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 1145B611E126;
        Mon, 27 Aug 2018 08:51:19 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 27 Aug 2018
 14:51:18 +0100
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w7RDpHoA007537;        Mon, 27 Aug 2018 14:51:18 +0100
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v2] mfd: madera: Don't use regmap_read_poll_timeout to poll for BOOT_DONE
Date:   Mon, 27 Aug 2018 14:51:15 +0100
Message-ID: <20180827135115.24231-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=841 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808270148
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
 drivers/mfd/madera-core.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 8cfea969b060..440030cecbbd 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -132,32 +132,39 @@ const char *madera_name_from_type(enum madera_type type)
 }
 EXPORT_SYMBOL_GPL(madera_name_from_type);
 
-#define MADERA_BOOT_POLL_MAX_INTERVAL_US  5000
-#define MADERA_BOOT_POLL_TIMEOUT_US	 25000
+#define MADERA_BOOT_POLL_INTERVAL_USEC		5000
+#define MADERA_BOOT_POLL_TIMEOUT_USEC		25000
 
 static int madera_wait_for_boot(struct madera *madera)
 {
+	ktime_t timeout;
 	unsigned int val;
-	int ret;
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
+	timeout = ktime_add_us(ktime_get(), MADERA_BOOT_POLL_TIMEOUT_USEC);
+	regmap_read(madera->regmap, MADERA_IRQ1_RAW_STATUS_1, &val);
+	while (!(val & MADERA_BOOT_DONE_STS1) &&
+	       !ktime_after(ktime_get(), timeout)) {
+		usleep_range(MADERA_BOOT_POLL_INTERVAL_USEC / 2,
+			     MADERA_BOOT_POLL_INTERVAL_USEC);
+		regmap_read(madera->regmap, MADERA_IRQ1_RAW_STATUS_1, &val);
+	};
+
+	if (!(val & MADERA_BOOT_DONE_STS1)) {
+		dev_err(madera->dev, "Polling BOOT_DONE_STS timed out\n");
+		ret = -ETIMEDOUT;
+	}
 
 	/*
 	 * BOOT_DONE defaults to unmasked on boot so we must ack it.
-	 * Do this unconditionally to avoid interrupt storms.
+	 * Do this even after a timeout to avoid interrupt storms.
 	 */
 	regmap_write(madera->regmap, MADERA_IRQ1_STATUS_1,
 		     MADERA_BOOT_DONE_EINT1);
-- 
2.11.0


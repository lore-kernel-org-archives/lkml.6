Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DB5C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82E6208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82E6208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbeJAVMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:12:06 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:59656 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729450AbeJAVMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:12:06 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w91EXtE9027359;
        Mon, 1 Oct 2018 09:33:58 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2mugjdgbck-1;
        Mon, 01 Oct 2018 09:33:58 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 9BE40611C8B3;
        Mon,  1 Oct 2018 09:36:31 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 1 Oct 2018
 15:33:57 +0100
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w91EXvlo027435;        Mon, 1 Oct 2018 15:33:57 +0100
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] mfd: madera: Increase wait for silicon reset
Date:   Mon, 1 Oct 2018 15:33:56 +0100
Message-ID: <20181001143357.28428-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
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

Based on latest silicon validation we should allow at least
2 milliseconds after DCVDD enable or hard reset released before
trying to communicate with the silicon.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/mfd/madera-core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 440030cecbbd..3ff9a0615658 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -135,6 +135,15 @@ EXPORT_SYMBOL_GPL(madera_name_from_type);
 #define MADERA_BOOT_POLL_INTERVAL_USEC		5000
 #define MADERA_BOOT_POLL_TIMEOUT_USEC		25000
 
+static void madera_por_delay(void)
+{
+	/*
+	 * After DCVDD enable or hard reset released wait for internal
+	 * POR (power-on-reset) before trying to communicate with the silicon
+	 */
+	usleep_range(2000, 3000);
+}
+
 static int madera_wait_for_boot(struct madera *madera)
 {
 	ktime_t timeout;
@@ -209,7 +218,7 @@ static void madera_disable_hard_reset(struct madera *madera)
 		return;
 
 	gpiod_set_raw_value_cansleep(madera->pdata.reset, 1);
-	usleep_range(1000, 2000);
+	madera_por_delay();
 }
 
 static int __maybe_unused madera_runtime_resume(struct device *dev)
@@ -225,6 +234,7 @@ static int __maybe_unused madera_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	madera_por_delay();
 	regcache_cache_only(madera->regmap, false);
 	regcache_cache_only(madera->regmap_32bit, false);
 
-- 
2.11.0


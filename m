Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A654ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1072B20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1072B20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeINU3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:29:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbeINU3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:29:13 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BC12B458EFE88;
        Fri, 14 Sep 2018 23:14:11 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Fri, 14 Sep 2018 23:14:11 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <airlied@linux.ie>
CC:     <ville.syrjala@linux.intel.com>, <alexander.deucher@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: i2c: use match_string() helper to simplify  the code
Date:   Fri, 14 Sep 2018 23:01:55 +0800
Message-ID: <1536937315-31350-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/i2c/ch7006_drv.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i2c/ch7006_drv.c b/drivers/gpu/drm/i2c/ch7006_drv.c
index 544a8a2..ecabc92 100644
--- a/drivers/gpu/drm/i2c/ch7006_drv.c
+++ b/drivers/gpu/drm/i2c/ch7006_drv.c
@@ -440,7 +440,7 @@ static int ch7006_encoder_init(struct i2c_client *client,
 			       struct drm_encoder_slave *encoder)
 {
 	struct ch7006_priv *priv;
-	int i;
+	int index;
 
 	ch7006_dbg(client, "\n");
 
@@ -464,14 +464,10 @@ static int ch7006_encoder_init(struct i2c_client *client,
 	priv->chip_version = ch7006_read(client, CH7006_VERSION_ID);
 
 	if (ch7006_tv_norm) {
-		for (i = 0; i < NUM_TV_NORMS; i++) {
-			if (!strcmp(ch7006_tv_norm_names[i], ch7006_tv_norm)) {
-				priv->norm = i;
-				break;
-			}
-		}
-
-		if (i == NUM_TV_NORMS)
+		index = match_string(ch7006_tv_norm_names, NUM_TV_NORMS, ch7006_tv_norm);
+		if (index >= 0)
+			priv->norm = index;
+		else
 			ch7006_err(client, "Invalid TV norm setting \"%s\".\n",
 				   ch7006_tv_norm);
 	}
-- 
1.7.12.4


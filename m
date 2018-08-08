Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB23C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB5B21AA9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB5B21AA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbeHIAe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:34:57 -0400
Received: from mail.ispras.ru ([83.149.199.45]:37182 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbeHIAe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:34:57 -0400
Received: from localhost.localdomain (ppp85-140-183-102.pppoe.mtu-net.ru [85.140.183.102])
        by mail.ispras.ru (Postfix) with ESMTPSA id C42E7540093;
        Thu,  9 Aug 2018 01:13:14 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Denis Osterland <Denis.Osterland@diehl.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] rtc: isl1208: fix error handling in isl1208_probe()
Date:   Thu,  9 Aug 2018 01:13:07 +0300
Message-Id: <1533766387-30529-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After moving rtc_register_device() sysfs group is left unremoved
on the error path.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 236b7187034e ("rtc: isl1208: switch to rtc_register_device")
---
 drivers/rtc/rtc-isl1208.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 1a2c38cc0178..4b5df9bfb8d4 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -674,7 +674,12 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		}
 	}
 
-	return rtc_register_device(rtc);
+	rc = rtc_register_device(rtc);
+	if (rc) {
+		sysfs_remove_group(&client->dev.kobj, &isl1208_rtc_sysfs_files);
+		return rc;
+	}
+	return 0;
 }
 
 static int
-- 
2.7.4


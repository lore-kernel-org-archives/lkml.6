Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933154AbeBLWzL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:55:11 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37561 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932935AbeBLWsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:36 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 19/45] rtc: rv8803: fix possible race condition
Date: Mon, 12 Feb 2018 23:47:33 +0100
Message-Id: <20180212224759.15999-20-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe function is not allowed to fail after registering the RTC. Call
rtc_register_device() at the end.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv8803.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 6fb5041f750b..29fc3d210392 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -590,14 +590,6 @@ static int rv8803_probe(struct i2c_client *client,
 		}
 	}
 
-	rv8803->rtc->ops = &rv8803_rtc_ops;
-	rv8803->rtc->nvram_old_abi = true;
-	err = rtc_register_device(rv8803->rtc);
-	if (err)
-		return err;
-
-	rtc_nvmem_register(rv8803->rtc, &nvmem_cfg);
-
 	err = rv8803_write_reg(rv8803->client, RV8803_EXT, RV8803_EXT_WADA);
 	if (err)
 		return err;
@@ -608,6 +600,14 @@ static int rv8803_probe(struct i2c_client *client,
 		return err;
 	}
 
+	rv8803->rtc->ops = &rv8803_rtc_ops;
+	rv8803->rtc->nvram_old_abi = true;
+	err = rtc_register_device(rv8803->rtc);
+	if (err)
+		return err;
+
+	rtc_nvmem_register(rv8803->rtc, &nvmem_cfg);
+
 	rv8803->rtc->max_user_freq = 1;
 
 	return 0;
-- 
2.16.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932669AbeBLWsU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:20 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37518 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbeBLWsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:16 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 03/45] rtc: nvmem: return error values
Date: Mon, 12 Feb 2018 23:47:17 +0100
Message-Id: <20180212224759.15999-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, make rtc_nvmem_register() able to return an error value
to its caller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/nvmem.c    | 10 ++++++----
 drivers/rtc/rtc-core.h | 11 +++++++----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
index 0a3522bcdd25..293df6db7c42 100644
--- a/drivers/rtc/nvmem.c
+++ b/drivers/rtc/nvmem.c
@@ -84,21 +84,23 @@ static void rtc_nvram_unregister(struct rtc_device *rtc)
 /*
  * New ABI, uses nvmem
  */
-void rtc_nvmem_register(struct rtc_device *rtc,
-			struct nvmem_config *nvmem_config)
+int rtc_nvmem_register(struct rtc_device *rtc,
+		       struct nvmem_config *nvmem_config)
 {
 	if (!nvmem_config)
-		return;
+		return -ENODEV;
 
 	nvmem_config->dev = &rtc->dev;
 	nvmem_config->owner = rtc->owner;
 	rtc->nvmem = nvmem_register(nvmem_config);
 	if (IS_ERR_OR_NULL(rtc->nvmem))
-		return;
+		return PTR_ERR(rtc->nvmem);
 
 	/* Register the old ABI */
 	if (rtc->nvram_old_abi)
 		rtc_nvram_register(rtc, nvmem_config->size);
+
+	return 0;
 }
 
 void rtc_nvmem_unregister(struct rtc_device *rtc)
diff --git a/drivers/rtc/rtc-core.h b/drivers/rtc/rtc-core.h
index 5f60e3b11cde..05a67837fd76 100644
--- a/drivers/rtc/rtc-core.h
+++ b/drivers/rtc/rtc-core.h
@@ -48,11 +48,14 @@ static inline const struct attribute_group **rtc_get_dev_attribute_groups(void)
 #endif
 
 #ifdef CONFIG_RTC_NVMEM
-void rtc_nvmem_register(struct rtc_device *rtc,
-			struct nvmem_config *nvmem_config);
+int rtc_nvmem_register(struct rtc_device *rtc,
+		       struct nvmem_config *nvmem_config);
 void rtc_nvmem_unregister(struct rtc_device *rtc);
 #else
-static inline void rtc_nvmem_register(struct rtc_device *rtc,
-				      struct nvmem_config *nvmem_config) {}
+static inline int rtc_nvmem_register(struct rtc_device *rtc,
+				     struct nvmem_config *nvmem_config)
+{
+	return -ENODEV;
+}
 static inline void rtc_nvmem_unregister(struct rtc_device *rtc) {}
 #endif
-- 
2.16.1

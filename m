Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932892AbeBLWsd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:33 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37527 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932673AbeBLWs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:26 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 05/45] rtc: export rtc_nvmem_register() to drivers
Date: Mon, 12 Feb 2018 23:47:19 +0100
Message-Id: <20180212224759.15999-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export rtc_nvmem_register() so it can be called from drivers instead of
only the core.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/nvmem.c    |  3 +--
 drivers/rtc/rtc-core.h | 13 -------------
 include/linux/rtc.h    | 13 +++++++++++++
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/rtc/nvmem.c b/drivers/rtc/nvmem.c
index fd1c39a5ade5..3a02357eb783 100644
--- a/drivers/rtc/nvmem.c
+++ b/drivers/rtc/nvmem.c
@@ -14,8 +14,6 @@
 #include <linux/rtc.h>
 #include <linux/sysfs.h>
 
-#include "rtc-core.h"
-
 /*
  * Deprecated ABI compatibility, this should be removed at some point
  */
@@ -105,6 +103,7 @@ int rtc_nvmem_register(struct rtc_device *rtc,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(rtc_nvmem_register);
 
 void rtc_nvmem_unregister(struct rtc_device *rtc)
 {
diff --git a/drivers/rtc/rtc-core.h b/drivers/rtc/rtc-core.h
index 05a67837fd76..0abf98983e13 100644
--- a/drivers/rtc/rtc-core.h
+++ b/drivers/rtc/rtc-core.h
@@ -46,16 +46,3 @@ static inline const struct attribute_group **rtc_get_dev_attribute_groups(void)
 	return NULL;
 }
 #endif
-
-#ifdef CONFIG_RTC_NVMEM
-int rtc_nvmem_register(struct rtc_device *rtc,
-		       struct nvmem_config *nvmem_config);
-void rtc_nvmem_unregister(struct rtc_device *rtc);
-#else
-static inline int rtc_nvmem_register(struct rtc_device *rtc,
-				     struct nvmem_config *nvmem_config)
-{
-	return -ENODEV;
-}
-static inline void rtc_nvmem_unregister(struct rtc_device *rtc) {}
-#endif
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index fc6c90b57be0..fbc92fff7c2e 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -271,4 +271,17 @@ extern int rtc_hctosys_ret;
 #define rtc_hctosys_ret -ENODEV
 #endif
 
+#ifdef CONFIG_RTC_NVMEM
+int rtc_nvmem_register(struct rtc_device *rtc,
+		       struct nvmem_config *nvmem_config);
+void rtc_nvmem_unregister(struct rtc_device *rtc);
+#else
+static inline int rtc_nvmem_register(struct rtc_device *rtc,
+				     struct nvmem_config *nvmem_config)
+{
+	return -ENODEV;
+}
+static inline void rtc_nvmem_unregister(struct rtc_device *rtc) {}
+#endif
+
 #endif /* _LINUX_RTC_H_ */
-- 
2.16.1

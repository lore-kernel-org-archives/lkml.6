Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596F6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB002075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB002075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbeGRQsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:48:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32784 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbeGRQsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:48:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E4BE027DFDB
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, bleung@chromium.org, kernel@collabora.com,
        lee.jones@linaro.org, Olof Johansson <olof@lixom.net>
Subject: [PATCH 1/2] platform/chrome: Move mfd/cros_ec_lpc* includes to drivers/platform.
Date:   Wed, 18 Jul 2018 18:09:55 +0200
Message-Id: <20180718160956.19864-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718160956.19864-1-enric.balletbo@collabora.com>
References: <20180718160956.19864-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cros-ec-lpc driver lives in drivers/platform because is platform
specific, however there are two includes (cros_ec_lpc_mec.h and
cros_ec_lpc_reg.h) that lives in include/linux/mfd. These two includes
are only used for the platform driver and are not really related to the
MFD subsystem, so move the includes from include/linux/mfd to
drivers/platform/chrome.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_lpc.c                       | 3 ++-
 drivers/platform/chrome/cros_ec_lpc_mec.c                   | 3 ++-
 .../linux/mfd => drivers/platform/chrome}/cros_ec_lpc_mec.h | 6 +++---
 drivers/platform/chrome/cros_ec_lpc_reg.c                   | 3 ++-
 .../linux/mfd => drivers/platform/chrome}/cros_ec_lpc_reg.h | 6 +++---
 5 files changed, 12 insertions(+), 9 deletions(-)
 rename {include/linux/mfd => drivers/platform/chrome}/cros_ec_lpc_mec.h (96%)
 rename {include/linux/mfd => drivers/platform/chrome}/cros_ec_lpc_reg.h (94%)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 31c8b8c49e45..7ec8789bf161 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -27,12 +27,13 @@
 #include <linux/io.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/mfd/cros_ec_commands.h>
-#include <linux/mfd/cros_ec_lpc_reg.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/suspend.h>
 
+#include "cros_ec_lpc_reg.h"
+
 #define DRV_NAME "cros_ec_lpcs"
 #define ACPI_DRV_NAME "GOOG0004"
 
diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
index 2eda2c2fc210..c4edfa83e493 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.c
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
@@ -24,10 +24,11 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/mfd/cros_ec_commands.h>
-#include <linux/mfd/cros_ec_lpc_mec.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 
+#include "cros_ec_lpc_mec.h"
+
 /*
  * This mutex must be held while accessing the EMI unit. We can't rely on the
  * EC mutex because memmap data may be accessed without it being held.
diff --git a/include/linux/mfd/cros_ec_lpc_mec.h b/drivers/platform/chrome/cros_ec_lpc_mec.h
similarity index 96%
rename from include/linux/mfd/cros_ec_lpc_mec.h
rename to drivers/platform/chrome/cros_ec_lpc_mec.h
index 176496ddc66c..105068c0e919 100644
--- a/include/linux/mfd/cros_ec_lpc_mec.h
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.h
@@ -21,8 +21,8 @@
  * expensive.
  */
 
-#ifndef __LINUX_MFD_CROS_EC_MEC_H
-#define __LINUX_MFD_CROS_EC_MEC_H
+#ifndef __CROS_EC_LPC_MEC_H
+#define __CROS_EC_LPC_MEC_H
 
 #include <linux/mfd/cros_ec_commands.h>
 
@@ -87,4 +87,4 @@ void cros_ec_lpc_mec_destroy(void);
 u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
 			    unsigned int offset, unsigned int length, u8 *buf);
 
-#endif /* __LINUX_MFD_CROS_EC_MEC_H */
+#endif /* __CROS_EC_LPC_MEC_H */
diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.c b/drivers/platform/chrome/cros_ec_lpc_reg.c
index dcc7a3e30604..fc23d535c404 100644
--- a/drivers/platform/chrome/cros_ec_lpc_reg.c
+++ b/drivers/platform/chrome/cros_ec_lpc_reg.c
@@ -24,7 +24,8 @@
 #include <linux/io.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/mfd/cros_ec_commands.h>
-#include <linux/mfd/cros_ec_lpc_mec.h>
+
+#include "cros_ec_lpc_mec.h"
 
 static u8 lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
 {
diff --git a/include/linux/mfd/cros_ec_lpc_reg.h b/drivers/platform/chrome/cros_ec_lpc_reg.h
similarity index 94%
rename from include/linux/mfd/cros_ec_lpc_reg.h
rename to drivers/platform/chrome/cros_ec_lpc_reg.h
index 5560bef63c2b..1c12c38b306a 100644
--- a/include/linux/mfd/cros_ec_lpc_reg.h
+++ b/drivers/platform/chrome/cros_ec_lpc_reg.h
@@ -21,8 +21,8 @@
  * expensive.
  */
 
-#ifndef __LINUX_MFD_CROS_EC_REG_H
-#define __LINUX_MFD_CROS_EC_REG_H
+#ifndef __CROS_EC_LPC_REG_H
+#define __CROS_EC_LPC_REG_H
 
 /**
  * cros_ec_lpc_read_bytes - Read bytes from a given LPC-mapped address.
@@ -58,4 +58,4 @@ void cros_ec_lpc_reg_init(void);
  */
 void cros_ec_lpc_reg_destroy(void);
 
-#endif /* __LINUX_MFD_CROS_EC_REG_H */
+#endif /* __CROS_EC_LPC_REG_H */
-- 
2.18.0


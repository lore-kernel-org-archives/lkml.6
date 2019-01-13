Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67322C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458EC20675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfAMUBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:01:05 -0500
Received: from mail5.windriver.com ([192.103.53.11]:47592 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfAMUA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:00:56 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0DIdtvO025176
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 13 Jan 2019 10:40:11 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 13 Jan 2019
 10:39:45 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 15/18] mfd: wm831x-core: drop unused module infrastructure from non-modular code
Date:   Sun, 13 Jan 2019 13:36:46 -0500
Message-ID: <1547404609-14161-16-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
References: <1547404609-14161-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MFD_WM831X
drivers/mfd/Kconfig:    bool

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

We delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Previous demodularizaion work has made wm831x_device_exit() no longer
used, so it is also removed from the 831x core code.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/wm831x-core.c       | 15 ++-------------
 include/linux/mfd/wm831x/core.h |  1 -
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/wm831x-core.c b/drivers/mfd/wm831x-core.c
index e70d35ef5c6d..25fbbaf39cb9 100644
--- a/drivers/mfd/wm831x-core.c
+++ b/drivers/mfd/wm831x-core.c
@@ -13,7 +13,8 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/bcd.h>
 #include <linux/delay.h>
 #include <linux/mfd/core.h>
@@ -1892,14 +1893,6 @@ int wm831x_device_init(struct wm831x *wm831x, int irq)
 	return ret;
 }
 
-void wm831x_device_exit(struct wm831x *wm831x)
-{
-	wm831x_otp_exit(wm831x);
-	mfd_remove_devices(wm831x->dev);
-	free_irq(wm831x_irq(wm831x, WM831X_IRQ_AUXADC_DATA), wm831x);
-	wm831x_irq_exit(wm831x);
-}
-
 int wm831x_device_suspend(struct wm831x *wm831x)
 {
 	int reg, mask;
@@ -1944,7 +1937,3 @@ void wm831x_device_shutdown(struct wm831x *wm831x)
 	}
 }
 EXPORT_SYMBOL_GPL(wm831x_device_shutdown);
-
-MODULE_DESCRIPTION("Core support for the WM831X AudioPlus PMIC");
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Mark Brown");
diff --git a/include/linux/mfd/wm831x/core.h b/include/linux/mfd/wm831x/core.h
index b49fa67612f1..6fcb8eb00282 100644
--- a/include/linux/mfd/wm831x/core.h
+++ b/include/linux/mfd/wm831x/core.h
@@ -418,7 +418,6 @@ int wm831x_bulk_read(struct wm831x *wm831x, unsigned short reg,
 		     int count, u16 *buf);
 
 int wm831x_device_init(struct wm831x *wm831x, int irq);
-void wm831x_device_exit(struct wm831x *wm831x);
 int wm831x_device_suspend(struct wm831x *wm831x);
 void wm831x_device_shutdown(struct wm831x *wm831x);
 int wm831x_irq_init(struct wm831x *wm831x, int irq);
-- 
2.7.4


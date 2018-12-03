Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E469AC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5115214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5115214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbeLCEZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 23:25:16 -0500
Received: from mail.windriver.com ([147.11.1.11]:62559 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeLCEZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 23:25:13 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wB34P6HT026641
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 2 Dec 2018 20:25:07 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 2 Dec 2018
 20:25:06 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH 07/22] mfd: da9055-core: make it explicitly non-modular
Date:   Sun, 2 Dec 2018 23:23:14 -0500
Message-ID: <1543811009-15112-8-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MFD_DA9055
drivers/mfd/Kconfig-    bool "Dialog Semiconductor DA9055 PMIC Support"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

The exit function deleted here wasn't even registered with module_exit,
so it truly was dead code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

We replace module.h with init.h and export.h ; the latter since the
file does export some symbols

Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/da9055-core.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
index 177e65a12c12..b55f13061547 100644
--- a/drivers/mfd/da9055-core.c
+++ b/drivers/mfd/da9055-core.c
@@ -11,7 +11,8 @@
  *  option) any later version.
  */
 
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/device.h>
 #include <linux/input.h>
 #include <linux/irq.h>
@@ -416,13 +417,3 @@ int da9055_device_init(struct da9055 *da9055)
 	mfd_remove_devices(da9055->dev);
 	return ret;
 }
-
-void da9055_device_exit(struct da9055 *da9055)
-{
-	regmap_del_irq_chip(da9055->chip_irq, da9055->irq_data);
-	mfd_remove_devices(da9055->dev);
-}
-
-MODULE_DESCRIPTION("Core support for the DA9055 PMIC");
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
-- 
2.7.4


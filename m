Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA1BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0D020848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 04:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0D020848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeLCEZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 23:25:20 -0500
Received: from mail1.windriver.com ([147.11.146.13]:60539 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeLCEZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 23:25:20 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wB34P8C2015530
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 2 Dec 2018 20:25:08 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 2 Dec 2018
 20:25:07 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mattias Nilsson <mattias.i.nilsson@stericsson.com>
Subject: [PATCH 08/22] mfd: db8500-prcmu: drop unused MODULE_ tags from non-modular code
Date:   Sun, 2 Dec 2018 23:23:15 -0500
Message-ID: <1543811009-15112-9-git-send-email-paul.gortmaker@windriver.com>
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

drivers/mfd/Kconfig:config MFD_DB8500_PRCMU
drivers/mfd/Kconfig:    bool "ST-Ericsson DB8500 Power Reset Control Management Unit"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

We delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

We replace module.h with init.h and export.h ; the latter since the
file does export some symbols.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mattias Nilsson <mattias.i.nilsson@stericsson.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/mfd/db8500-prcmu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index aec20e1c7d3d..65666b624ae8 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -1,4 +1,6 @@
 /*
+ * DB8500 PRCM Unit driver
+ *
  * Copyright (C) STMicroelectronics 2009
  * Copyright (C) ST-Ericsson SA 2010
  *
@@ -10,7 +12,8 @@
  * U8500 PRCM Unit interface driver
  *
  */
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -3188,9 +3191,4 @@ static int __init db8500_prcmu_init(void)
 {
 	return platform_driver_register(&db8500_prcmu_driver);
 }
-
 core_initcall(db8500_prcmu_init);
-
-MODULE_AUTHOR("Mattias Nilsson <mattias.i.nilsson@stericsson.com>");
-MODULE_DESCRIPTION("DB8500 PRCM Unit driver");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4


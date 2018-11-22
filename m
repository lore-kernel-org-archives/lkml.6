Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A61C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A2B20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 04:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A2B20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391590AbeKVPNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:13:13 -0500
Received: from mail5.windriver.com ([192.103.53.11]:53062 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732270AbeKVPNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:13:11 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wAM4XWFf012233
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 21 Nov 2018 20:35:01 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Wed, 21 Nov 2018
 20:34:53 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mattias Nilsson <mattias.i.nilsson@stericsson.com>
Subject: [PATCH 03/11] mfd: db8500-prcmu: drop unused MODULE_ tags from non-modular code
Date:   Wed, 21 Nov 2018 23:32:51 -0500
Message-ID: <1542861179-8941-4-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542861179-8941-1-git-send-email-paul.gortmaker@windriver.com>
References: <1542861179-8941-1-git-send-email-paul.gortmaker@windriver.com>
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


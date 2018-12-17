Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D1EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3EF21783
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733286AbeLQUfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:35:22 -0500
Received: from mail5.windriver.com ([192.103.53.11]:42764 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbeLQUfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:35:21 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wBHKYMBM030343
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 17 Dec 2018 12:34:32 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Dec 2018
 12:34:11 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dong Aisheng <dong.aisheng@linaro.org>
Subject: [PATCH 09/18] mfd: syscon: Make it explicitly non-modular
Date:   Mon, 17 Dec 2018 15:31:19 -0500
Message-ID: <1545078688-21217-10-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545078688-21217-1-git-send-email-paul.gortmaker@windriver.com>
References: <1545078688-21217-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/mfd/Kconfig:config MFD_SYSCON
drivers/mfd/Kconfig:    bool "System Controller Register R/W Based on Regmap"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dong Aisheng <dong.aisheng@linaro.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/syscon.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index b6d05cd934e6..0ecdffb3d967 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -15,7 +15,7 @@
 #include <linux/err.h>
 #include <linux/hwspinlock.h>
 #include <linux/io.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/list.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -272,13 +272,3 @@ static int __init syscon_init(void)
 	return platform_driver_register(&syscon_driver);
 }
 postcore_initcall(syscon_init);
-
-static void __exit syscon_exit(void)
-{
-	platform_driver_unregister(&syscon_driver);
-}
-module_exit(syscon_exit);
-
-MODULE_AUTHOR("Dong Aisheng <dong.aisheng@linaro.org>");
-MODULE_DESCRIPTION("System Control driver");
-MODULE_LICENSE("GPL v2");
-- 
2.7.4


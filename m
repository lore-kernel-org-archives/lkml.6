Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4051C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC5B217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389645AbeLQUeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:34:36 -0500
Received: from mail1.windriver.com ([147.11.146.13]:53262 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733183AbeLQUef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:34:35 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wBHKYAKB011052
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 17 Dec 2018 12:34:11 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Mon, 17 Dec 2018
 12:34:10 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alessandro Rubini <rubini@gnudd.com>,
        Davide Ciminaghi <ciminaghi@gnudd.com>
Subject: [PATCH 08/18] mfd: sta2x11: drop unused MODULE_ tags from non-modular code
Date:   Mon, 17 Dec 2018 15:31:18 -0500
Message-ID: <1545078688-21217-9-git-send-email-paul.gortmaker@windriver.com>
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

drivers/mfd/Kconfig:config MFD_STA2X11
drivers/mfd/Kconfig:    bool "STMicroelectronics STA2X11"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

We delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We replace module.h with init.h and export.h ; the latter since the
file does export some symbols.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Alessandro Rubini <rubini@gnudd.com>
Cc: Davide Ciminaghi <ciminaghi@gnudd.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Acked-by: Alessandro Rubini <rubini@gnudd.com>
Acked-by: Davide Ciminaghi <ciminaghi@gnudd.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/sta2x11-mfd.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/sta2x11-mfd.c b/drivers/mfd/sta2x11-mfd.c
index 3aeafa228baf..cab9aabcaa1f 100644
--- a/drivers/mfd/sta2x11-mfd.c
+++ b/drivers/mfd/sta2x11-mfd.c
@@ -1,4 +1,6 @@
 /*
+ * STA2x11 mfd for GPIO, SCTL and APBREG
+ *
  * Copyright (c) 2009-2011 Wind River Systems, Inc.
  * Copyright (c) 2011 ST Microelectronics (Alessandro Rubini, Davide Ciminaghi)
  *
@@ -18,7 +20,8 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/export.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/device.h>
@@ -653,8 +656,3 @@ static int __init sta2x11_mfd_init(void)
  */
 subsys_initcall(sta2x11_drivers_init);
 rootfs_initcall(sta2x11_mfd_init);
-
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Wind River");
-MODULE_DESCRIPTION("STA2x11 mfd for GPIO, SCTL and APBREG");
-MODULE_DEVICE_TABLE(pci, sta2x11_mfd_tbl);
-- 
2.7.4


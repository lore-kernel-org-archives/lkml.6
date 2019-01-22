Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FACDC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C43D205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfAVTCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:02:25 -0500
Received: from mail.windriver.com ([147.11.1.11]:48104 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfAVTCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:02:24 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x0MJ2HE3024137
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 22 Jan 2019 11:02:17 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Tue, 22 Jan 2019
 11:02:17 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH-next] reset: brcmstb: make it explicitly non-modular
Date:   Tue, 22 Jan 2019 14:02:07 -0500
Message-ID: <1548183727-5073-1-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/reset/Kconfig:  bool "Broadcom STB reset controller" if COMPILE_TEST
drivers/reset/Kconfig:  default ARCH_BRCMSTB

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

We also delete no-op MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Gregory Fong <gregory.0xf0@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Driver just recently appeared in linux-next - if rebasing, feel free
 to squash this change into the original commit. Or make it tristate?]

 drivers/reset/reset-brcmstb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
index 01ab1f71518b..5bc0c74cf97c 100644
--- a/drivers/reset/reset-brcmstb.c
+++ b/drivers/reset/reset-brcmstb.c
@@ -8,7 +8,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
@@ -123,8 +123,4 @@ static struct platform_driver brcmstb_reset_driver = {
 		.of_match_table = brcmstb_reset_of_match,
 	},
 };
-module_platform_driver(brcmstb_reset_driver);
-
-MODULE_AUTHOR("Broadcom");
-MODULE_DESCRIPTION("Broadcom STB reset controller");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(brcmstb_reset_driver);
-- 
2.7.4


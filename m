Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E594C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D7A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D7A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbeLJAgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 19:36:41 -0500
Received: from mail5.windriver.com ([192.103.53.11]:53866 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbeLJAgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 19:36:40 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wBA0ZEdA009974
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 9 Dec 2018 16:36:06 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 9 Dec 2018
 16:35:38 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 3/3] phy: make phy-armada375-usb2 explicitly non-modular
Date:   Sun, 9 Dec 2018 19:34:50 -0500
Message-ID: <1544402090-30970-4-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544402090-30970-1-git-send-email-paul.gortmaker@windriver.com>
References: <1544402090-30970-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/phy/marvell/Kconfig:config ARMADA375_USBCLUSTER_PHY
drivers/phy/marvell/Kconfig:    def_bool y

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple of traces of modular infrastructure, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/phy/marvell/phy-armada375-usb2.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/phy/marvell/phy-armada375-usb2.c b/drivers/phy/marvell/phy-armada375-usb2.c
index 1a3db288c0a9..4f0295992500 100644
--- a/drivers/phy/marvell/phy-armada375-usb2.c
+++ b/drivers/phy/marvell/phy-armada375-usb2.c
@@ -18,7 +18,6 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -142,7 +141,6 @@ static const struct of_device_id of_usb_cluster_table[] = {
 	{ .compatible = "marvell,armada-375-usb-cluster", },
 	{ /* end of list */ },
 };
-MODULE_DEVICE_TABLE(of, of_usb_cluster_table);
 
 static struct platform_driver armada375_usb_phy_driver = {
 	.probe	= armada375_usb_phy_probe,
@@ -151,8 +149,4 @@ static struct platform_driver armada375_usb_phy_driver = {
 		.name  = "armada-375-usb-cluster",
 	}
 };
-module_platform_driver(armada375_usb_phy_driver);
-
-MODULE_DESCRIPTION("Armada 375 USB cluster driver");
-MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(armada375_usb_phy_driver);
-- 
2.7.4


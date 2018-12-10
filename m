Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C11FC07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE05B20831
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE05B20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeLJAgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 19:36:20 -0500
Received: from mail5.windriver.com ([192.103.53.11]:53856 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbeLJAgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 19:36:20 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wBA0ZEd6009974
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 9 Dec 2018 16:35:30 -0800
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 9 Dec 2018
 16:35:03 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 2/3] phy: make phy-mvebu-sata explicitly non-modular
Date:   Sun, 9 Dec 2018 19:34:49 -0500
Message-ID: <1544402090-30970-3-git-send-email-paul.gortmaker@windriver.com>
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

drivers/phy/Kconfig:config PHY_MVEBU_SATA
drivers/phy/Kconfig:    def_bool y

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
Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/phy/marvell/phy-mvebu-sata.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-sata.c b/drivers/phy/marvell/phy-mvebu-sata.c
index 768ce92e81ce..369fece2be7a 100644
--- a/drivers/phy/marvell/phy-mvebu-sata.c
+++ b/drivers/phy/marvell/phy-mvebu-sata.c
@@ -10,7 +10,7 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/phy/phy.h>
 #include <linux/io.h>
@@ -122,7 +122,6 @@ static const struct of_device_id phy_mvebu_sata_of_match[] = {
 	{ .compatible = "marvell,mvebu-sata-phy" },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, phy_mvebu_sata_of_match);
 
 static struct platform_driver phy_mvebu_sata_driver = {
 	.probe	= phy_mvebu_sata_probe,
@@ -131,8 +130,4 @@ static struct platform_driver phy_mvebu_sata_driver = {
 		.of_match_table	= phy_mvebu_sata_of_match,
 	}
 };
-module_platform_driver(phy_mvebu_sata_driver);
-
-MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
-MODULE_DESCRIPTION("Marvell MVEBU SATA PHY driver");
-MODULE_LICENSE("GPL v2");
+builtin_platform_driver(phy_mvebu_sata_driver);
-- 
2.7.4


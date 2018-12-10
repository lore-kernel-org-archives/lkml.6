Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C46BC07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131092064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131092064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeLJAfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 19:35:04 -0500
Received: from mail1.windriver.com ([147.11.146.13]:60636 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLJAfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 19:35:04 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wBA0Z2oD027423
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 9 Dec 2018 16:35:02 -0800 (PST)
Received: from yow-cube1.wrs.com (128.224.56.98) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Sun, 9 Dec 2018
 16:35:01 -0800
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/3] phy: make phy-core explicitly non-modular
Date:   Sun, 9 Dec 2018 19:34:48 -0500
Message-ID: <1544402090-30970-2-git-send-email-paul.gortmaker@windriver.com>
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

drivers/phy/Kconfig:config GENERIC_PHY
drivers/phy/Kconfig:    bool "PHY Core"

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We don't remove module.h since the file is using other modular fcns
(to load other phy modules) even though the core support itself is
non-modular.

We also delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/phy/phy-core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index df3d4ba516ab..f10110676572 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -1048,14 +1048,4 @@ static int __init phy_core_init(void)
 
 	return 0;
 }
-module_init(phy_core_init);
-
-static void __exit phy_core_exit(void)
-{
-	class_destroy(phy_class);
-}
-module_exit(phy_core_exit);
-
-MODULE_DESCRIPTION("Generic PHY Framework");
-MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-MODULE_LICENSE("GPL v2");
+device_initcall(phy_core_init);
-- 
2.7.4


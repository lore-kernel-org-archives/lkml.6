Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B043C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B995C2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B995C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeJKTG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:06:56 -0400
Received: from regular1.263xmail.com ([211.150.99.136]:33264 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbeJKTG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:06:56 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Oct 2018 15:06:55 EDT
Received: from jeffy.chen?rock-chips.com (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id F19CA282;
        Thu, 11 Oct 2018 19:32:43 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 8DA0D36E;
        Thu, 11 Oct 2018 19:32:42 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <d0840ac15ea214983dd321a4e87696e2>
X-ATTACHMENT-NUM: 0
X-SENDER: cjf@rock-chips.com
X-DNS-TYPE: 0
Received: from localhost (unknown [103.29.142.67])
        by smtp.263.net (Postfix) whith ESMTP id 10639NNHI7M;
        Thu, 11 Oct 2018 19:32:44 +0800 (CST)
From:   Jeffy Chen <jeffy.chen@rock-chips.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeffy Chen <jeffy.chen@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: core: Fix device link error when registering regulator
Date:   Thu, 11 Oct 2018 19:32:39 +0800
Message-Id: <20181011113239.2789-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sysfs device link can only be created after regulator device
registered.

Fixes: c438b9d017362 ("regulator: core: Move registration of regulator device")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/regulator/core.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2c66b528aedec..36e650b61f7a9 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1405,12 +1405,15 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 		if (regulator->supply_name == NULL)
 			goto overflow_err;
 
-		err = sysfs_create_link_nowarn(&rdev->dev.kobj, &dev->kobj,
-					buf);
-		if (err) {
-			rdev_dbg(rdev, "could not add device link %s err %d\n",
-				  dev->kobj.name, err);
-			/* non-fatal */
+		if (device_is_registered(dev)) {
+			err = sysfs_create_link_nowarn(&rdev->dev.kobj,
+						       &dev->kobj, buf);
+			if (err) {
+				rdev_dbg(rdev,
+					 "could not add device link %s err %d\n",
+					 dev->kobj.name, err);
+				/* non-fatal */
+			}
 		}
 	} else {
 		regulator->supply_name = kstrdup_const(supply_name, GFP_KERNEL);
@@ -4416,6 +4419,18 @@ regulator_register(const struct regulator_desc *regulator_desc,
 		goto unset_supplies;
 	}
 
+	/* Add a link to the device sysfs entry */
+	if (rdev->supply && rdev->supply->dev) {
+		ret = sysfs_create_link_nowarn(&rdev->supply->dev->kobj,
+					       &rdev->dev.kobj,
+					       rdev->supply->supply_name);
+		if (ret) {
+			rdev_dbg(rdev, "could not add device link %s err %d\n",
+				 rdev->dev.kobj.name, ret);
+			/* non-fatal */
+		}
+	}
+
 	rdev_init_debugfs(rdev);
 
 	/* try to resolve regulators supply since a new one was registered */
-- 
2.11.0



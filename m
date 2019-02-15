Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8689AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A6D20840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197995;
	bh=qH68Fl2yU3bUgRS7OMGYHjcZy3iDg2z3W84n3Nh/PJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oTH4Mg2KjAtVNAVY7o8Gs7Vn0Dyje5MB2VyOZ48nrwIIytX9f20O6XjQ7uBTCtruJ
	 2EbSHWeJ2yibJujXfUNaURb7olYoOHlsYJpOr9QZhzD/sE8wK47OddHurj60E7zPDi
	 ckFOgbnYaIJauwNEPR6gN45C35/Osgq3aoNCgQc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388237AbfBOCdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:33:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390994AbfBOCMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D106321B1C;
        Fri, 15 Feb 2019 02:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196725;
        bh=qH68Fl2yU3bUgRS7OMGYHjcZy3iDg2z3W84n3Nh/PJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GTvJWLw0JPoD5qLxKC0KrOvJ1d5v8mvmTfu/PJdR7wmkfaIE0OvcAWMce8Q28qwgq
         SorlWPnrkwD78ASlO9/DNyQn/YQYJMfhzXbUDwbX923Apxll4Vaur4xBlirCv7x9Vr
         h/Pbjhe3lVl3YQZo7yCVJKgpAxeT5d7Q5K067UtU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aaron Hill <aa1ronham@gmail.com>, Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 27/65] drivers: thermal: int340x_thermal: Fix sysfs race condition
Date:   Thu, 14 Feb 2019 21:10:43 -0500
Message-Id: <20190215021121.177674-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Hill <aa1ronham@gmail.com>

[ Upstream commit 129699bb8c7572106b5bbb2407c2daee4727ccad ]

Changes since V1:
* Use dev_info instead of printk
* Use dev_warn instead of BUG_ON

Previously, sysfs_create_group was called before all initialization had
fully run - specifically, before pci_set_drvdata was called. Since the
sysctl group is visible to userspace as soon as sysfs_create_group
returns, a small window of time existed during which a process could read
from an uninitialized/partially-initialized device.

This commit moves the creation of the sysctl group to after all
initialized is completed. This ensures that it's impossible for
userspace to read from a sysctl file before initialization has fully
completed.

To catch any future regressions, I've added a check to ensure
that proc_thermal_emum_mode is never PROC_THERMAL_NONE when a process
tries to read from a sysctl file. Previously, the aforementioned race
condition could result in the 'else' branch
running while PROC_THERMAL_NONE was set,
leading to a null pointer deference.

Signed-off-by: Aaron Hill <aa1ronham@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../processor_thermal_device.c                | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index 8e0f665cf06f..8e1cf4d789be 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -84,7 +84,12 @@ static ssize_t power_limit_##index##_##suffix##_show(struct device *dev, \
 	struct pci_dev *pci_dev; \
 	struct platform_device *pdev; \
 	struct proc_thermal_device *proc_dev; \
-\
+	\
+	if (proc_thermal_emum_mode == PROC_THERMAL_NONE) { \
+		dev_warn(dev, "Attempted to get power limit before device was initialized!\n"); \
+		return 0; \
+	} \
+	\
 	if (proc_thermal_emum_mode == PROC_THERMAL_PLATFORM_DEV) { \
 		pdev = to_platform_device(dev); \
 		proc_dev = platform_get_drvdata(pdev); \
@@ -298,11 +303,6 @@ static int proc_thermal_add(struct device *dev,
 	*priv = proc_priv;
 
 	ret = proc_thermal_read_ppcc(proc_priv);
-	if (!ret) {
-		ret = sysfs_create_group(&dev->kobj,
-					 &power_limit_attribute_group);
-
-	}
 	if (ret)
 		return ret;
 
@@ -316,8 +316,7 @@ static int proc_thermal_add(struct device *dev,
 
 	proc_priv->int340x_zone = int340x_thermal_zone_add(adev, ops);
 	if (IS_ERR(proc_priv->int340x_zone)) {
-		ret = PTR_ERR(proc_priv->int340x_zone);
-		goto remove_group;
+		return PTR_ERR(proc_priv->int340x_zone);
 	} else
 		ret = 0;
 
@@ -331,9 +330,6 @@ static int proc_thermal_add(struct device *dev,
 
 remove_zone:
 	int340x_thermal_zone_remove(proc_priv->int340x_zone);
-remove_group:
-	sysfs_remove_group(&proc_priv->dev->kobj,
-			   &power_limit_attribute_group);
 
 	return ret;
 }
@@ -364,7 +360,10 @@ static int int3401_add(struct platform_device *pdev)
 	platform_set_drvdata(pdev, proc_priv);
 	proc_thermal_emum_mode = PROC_THERMAL_PLATFORM_DEV;
 
-	return 0;
+	dev_info(&pdev->dev, "Creating sysfs group for PROC_THERMAL_PLATFORM_DEV\n");
+
+	return sysfs_create_group(&pdev->dev.kobj,
+					 &power_limit_attribute_group);
 }
 
 static int int3401_remove(struct platform_device *pdev)
@@ -441,7 +440,10 @@ static int  proc_thermal_pci_probe(struct pci_dev *pdev,
 			dev_err(&pdev->dev, "No auxiliary DTSs enabled\n");
 	}
 
-	return 0;
+	dev_info(&pdev->dev, "Creating sysfs group for PROC_THERMAL_PCI\n");
+
+	return sysfs_create_group(&pdev->dev.kobj,
+					 &power_limit_attribute_group);
 }
 
 static void  proc_thermal_pci_remove(struct pci_dev *pdev)
-- 
2.19.1


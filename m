Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754672AbeDYOkp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:40:45 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39540 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753632AbeDYOkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:40:42 -0400
X-Google-Smtp-Source: AB8JxZrGcvaECtFSEpd+0TbI7jRo79EsZasEyFAjJ7TsNiwcdqfcdFcAYwt4Ohr5EBWxoiOJAKvPAQ==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: linux@armlinux.org.uk, rafael.j.wysocki@intel.com,
        ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: locomo: use put_device() instead of kfree()
Date: Wed, 25 Apr 2018 20:10:29 +0530
Message-Id: <76a6e68332d57d67757bf2ba735fb2d3d3118d1f.1524667039.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error. Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 arch/arm/common/locomo.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 51936bd..23a5079 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -226,8 +226,7 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 
 	dev = kzalloc(sizeof(struct locomo_dev), GFP_KERNEL);
 	if (!dev) {
-		ret = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	/*
@@ -256,10 +255,9 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
 			NO_IRQ : lchip->irq_base + info->irq[0];
 
 	ret = device_register(&dev->dev);
-	if (ret) {
- out:
-		kfree(dev);
-	}
+	if (ret)
+		put_device(&dev->dev);
+
 	return ret;
 }
 
-- 
2.7.4

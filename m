Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CD3C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F8F20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfBABEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 20:04:04 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55336 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfBABEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 20:04:01 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id d669926520e7f436; Fri, 1 Feb 2019 02:03:58 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v2 7/9] IOMMU: Make dwo drivers use stateless device links
Date:   Fri, 01 Feb 2019 01:54:21 +0100
Message-ID: <2241080.hZz7uDQtY8@aspire.rjw.lan>
In-Reply-To: <1952449.TVsm6CJCTy@aspire.rjw.lan>
References: <1952449.TVsm6CJCTy@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The device links used by rockchip-iommu and exynos-iommu are
completely managed by these drivers within the IOMMU framework,
so there is no reason to involve the driver core in the management
of these links.

For this reason, make rockchip-iommu and exynos-iommu pass
DL_FLAG_STATELESS in flags to device_link_add(), so that the device
links used by them are stateless.

[Note that this change is requisite for a subsequent one that will
 rework the management of stateful device links in the driver core
 and it will not be compatible with the two drivers in question any
 more.]

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/exynos-iommu.c   |    1 +
 drivers/iommu/rockchip-iommu.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/iommu/rockchip-iommu.c
===================================================================
--- linux-pm.orig/drivers/iommu/rockchip-iommu.c
+++ linux-pm/drivers/iommu/rockchip-iommu.c
@@ -1071,7 +1071,8 @@ static int rk_iommu_add_device(struct de
 	iommu_group_put(group);
 
 	iommu_device_link(&iommu->iommu, dev);
-	data->link = device_link_add(dev, iommu->dev, DL_FLAG_PM_RUNTIME);
+	data->link = device_link_add(dev, iommu->dev,
+				     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
 
 	return 0;
 }
Index: linux-pm/drivers/iommu/exynos-iommu.c
===================================================================
--- linux-pm.orig/drivers/iommu/exynos-iommu.c
+++ linux-pm/drivers/iommu/exynos-iommu.c
@@ -1260,6 +1260,7 @@ static int exynos_iommu_add_device(struc
 		 * direct calls to pm_runtime_get/put in this driver.
 		 */
 		data->link = device_link_add(dev, data->sysmmu,
+					     DL_FLAG_STATELESS |
 					     DL_FLAG_PM_RUNTIME);
 	}
 	iommu_group_put(group);


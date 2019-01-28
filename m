Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1B6C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234F7214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfA1XOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:14:08 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56380 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfA1XOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:14:04 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 916cbbf4bdcce02e; Tue, 29 Jan 2019 00:14:02 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <jroedel@suse.de>
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
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 1/4] IOMMU: Make dwo drivers use stateless device links
Date:   Tue, 29 Jan 2019 00:05:21 +0100
Message-ID: <3532356.d9GMSSLOvP@aspire.rjw.lan>
In-Reply-To: <2405639.4es7pRLqn0@aspire.rjw.lan>
References: <2405639.4es7pRLqn0@aspire.rjw.lan>
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


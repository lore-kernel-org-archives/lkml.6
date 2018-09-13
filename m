Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27117C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E341720C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E341720C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbeIMTCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:02:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33564 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730327AbeIMTCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:02:23 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E1581D19;
        Thu, 13 Sep 2018 13:52:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 044/197] iommu/rockchip: Handle errors returned from PM framework
Date:   Thu, 13 Sep 2018 15:29:53 +0200
Message-Id: <20180913131843.308288149@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit 3fc7c5c0cff3150e471f5fd12f59971c6d2c6513 ]

pm_runtime_get_if_in_use can fail: either PM has been disabled
altogether (-EINVAL), or the device hasn't been enabled yet (0).
Sadly, the Rockchip IOMMU driver tends to conflate the two things
by considering a non-zero return value as successful.

This has the consequence of hiding other bugs, so let's handle this
case throughout the driver, with a WARN_ON_ONCE so that we can try
and work out what happened.

Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/rockchip-iommu.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -521,10 +521,11 @@ static irqreturn_t rk_iommu_irq(int irq,
 	u32 int_status;
 	dma_addr_t iova;
 	irqreturn_t ret = IRQ_NONE;
-	int i;
+	int i, err;
 
-	if (WARN_ON(!pm_runtime_get_if_in_use(iommu->dev)))
-		return 0;
+	err = pm_runtime_get_if_in_use(iommu->dev);
+	if (WARN_ON_ONCE(err <= 0))
+		return ret;
 
 	if (WARN_ON(clk_bulk_enable(iommu->num_clocks, iommu->clocks)))
 		goto out;
@@ -620,11 +621,15 @@ static void rk_iommu_zap_iova(struct rk_
 	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
 	list_for_each(pos, &rk_domain->iommus) {
 		struct rk_iommu *iommu;
+		int ret;
 
 		iommu = list_entry(pos, struct rk_iommu, node);
 
 		/* Only zap TLBs of IOMMUs that are powered on. */
-		if (pm_runtime_get_if_in_use(iommu->dev)) {
+		ret = pm_runtime_get_if_in_use(iommu->dev);
+		if (WARN_ON_ONCE(ret < 0))
+			continue;
+		if (ret) {
 			WARN_ON(clk_bulk_enable(iommu->num_clocks,
 						iommu->clocks));
 			rk_iommu_zap_lines(iommu, iova, size);
@@ -891,6 +896,7 @@ static void rk_iommu_detach_device(struc
 	struct rk_iommu *iommu;
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	unsigned long flags;
+	int ret;
 
 	/* Allow 'virtual devices' (eg drm) to detach from domain */
 	iommu = rk_iommu_from_dev(dev);
@@ -909,7 +915,9 @@ static void rk_iommu_detach_device(struc
 	list_del_init(&iommu->node);
 	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 
-	if (pm_runtime_get_if_in_use(iommu->dev)) {
+	ret = pm_runtime_get_if_in_use(iommu->dev);
+	WARN_ON_ONCE(ret < 0);
+	if (ret > 0) {
 		rk_iommu_disable(iommu);
 		pm_runtime_put(iommu->dev);
 	}
@@ -946,7 +954,8 @@ static int rk_iommu_attach_device(struct
 	list_add_tail(&iommu->node, &rk_domain->iommus);
 	spin_unlock_irqrestore(&rk_domain->iommus_lock, flags);
 
-	if (!pm_runtime_get_if_in_use(iommu->dev))
+	ret = pm_runtime_get_if_in_use(iommu->dev);
+	if (!ret || WARN_ON_ONCE(ret < 0))
 		return 0;
 
 	ret = rk_iommu_enable(iommu);



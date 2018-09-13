Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192BFC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C4620854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C4620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbeIMTCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:02:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33592 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730051AbeIMTCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:02:30 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3A07FD19;
        Thu, 13 Sep 2018 13:52:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 046/197] iommu/rockchip: Move irq request past pm_runtime_enable
Date:   Thu, 13 Sep 2018 15:29:55 +0200
Message-Id: <20180913131843.388158321@linuxfoundation.org>
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

[ Upstream commit 1aa55ca9b14af6cfd987ce4fdaf548f7067a5d07 ]

Enabling the interrupt early, before power has been applied to the
device, can result in an interrupt being delivered too early if:

- the IOMMU shares an interrupt with a VOP
- the VOP has a pending interrupt (after a kexec, for example)

In these conditions, we end-up taking the interrupt without
the IOMMU being ready to handle the interrupt (not powered on).

Moving the interrupt request past the pm_runtime_enable() call
makes sure we can at least access the IOMMU registers. Note that
this is only a partial fix, and that the VOP interrupt will still
be screaming until the VOP driver kicks in, which advocates for
a more synchronized interrupt enabling/disabling approach.

Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/rockchip-iommu.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1161,17 +1161,6 @@ static int rk_iommu_probe(struct platfor
 	if (iommu->num_mmu == 0)
 		return PTR_ERR(iommu->bases[0]);
 
-	i = 0;
-	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
-		if (irq < 0)
-			return irq;
-
-		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
-				       IRQF_SHARED, dev_name(dev), iommu);
-		if (err)
-			return err;
-	}
-
 	iommu->reset_disabled = device_property_read_bool(dev,
 					"rockchip,disable-mmu-reset");
 
@@ -1228,6 +1217,19 @@ static int rk_iommu_probe(struct platfor
 
 	pm_runtime_enable(dev);
 
+	i = 0;
+	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
+		if (irq < 0)
+			return irq;
+
+		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
+				       IRQF_SHARED, dev_name(dev), iommu);
+		if (err) {
+			pm_runtime_disable(dev);
+			goto err_remove_sysfs;
+		}
+	}
+
 	return 0;
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);



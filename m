Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9734721486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9734721486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbeIXSoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:44:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59276 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388102AbeIXSoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:44:05 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 33831109F;
        Mon, 24 Sep 2018 12:42:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 186/235] drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping
Date:   Mon, 24 Sep 2018 13:52:52 +0200
Message-Id: <20180924113123.154710693@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit b59fb482b52269977ee5de205308e5b236a03917 ]

Depending on the kernel configuration, early ARM architecture setup code
may have attached the GPU to a DMA/IOMMU mapping that transparently uses
the IOMMU to back the DMA API. Tegra requires special handling for IOMMU
backed buffers (a special bit in the GPU's MMU page tables indicates the
memory path to take: via the SMMU or directly to the memory controller).
Transparently backing DMA memory with an IOMMU prevents Nouveau from
properly handling such memory accesses and causes memory access faults.

As a side-note: buffers other than those allocated in instance memory
don't need to be physically contiguous from the GPU's perspective since
the GPU can map them into contiguous buffers using its own MMU. Mapping
these buffers through the IOMMU is unnecessary and will even lead to
performance degradation because of the additional translation. One
exception to this are compressible buffers which need large pages. In
order to enable these large pages, multiple small pages will have to be
combined into one large (I/O virtually contiguous) mapping via the
IOMMU. However, that is a topic outside the scope of this fix and isn't
currently supported. An implementation will want to explicitly create
these large pages in the Nouveau driver, so detaching from a DMA/IOMMU
mapping would still be required.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Acked-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
@@ -23,6 +23,10 @@
 #ifdef CONFIG_NOUVEAU_PLATFORM_DRIVER
 #include "priv.h"
 
+#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
+#include <asm/dma-iommu.h>
+#endif
+
 static int
 nvkm_device_tegra_power_up(struct nvkm_device_tegra *tdev)
 {
@@ -105,6 +109,15 @@ nvkm_device_tegra_probe_iommu(struct nvk
 	unsigned long pgsize_bitmap;
 	int ret;
 
+#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
+	if (dev->archdata.mapping) {
+		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+
+		arm_iommu_detach_device(dev);
+		arm_iommu_release_mapping(mapping);
+	}
+#endif
+
 	if (!tdev->func->iommu_bit)
 		return;
 



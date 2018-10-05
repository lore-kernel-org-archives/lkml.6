Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209DCC65BAA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC29D208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mytsd6QK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC29D208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbeJEXOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:14:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729679AbeJEXOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:14:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3593E214C5;
        Fri,  5 Oct 2018 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538756106;
        bh=OqPyXZUzvW9JXIH0lfb3dZSmhC7Tpk0eDq6wlRnn6lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mytsd6QKnJgGAoD5XEEtf5czwRvUpUX6hrJ49PpigS+aym020ox9pdCD/m2JGUFEz
         QAqHWrbv/QdixRQ9CJeH6hAu4KOZSRiUnG4SONmjk8I0JtzZszufsMlINiaYWW8obl
         eTpJv1A9dxi48yPdkb6rJOdkAUwaR6ShxSEtCXJE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yong Zhao <Yong.Zhao@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 46/48] drm/amdkfd: Fix ATS capablity was not reported correctly on some APUs
Date:   Fri,  5 Oct 2018 12:14:22 -0400
Message-Id: <20181005161424.20521-46-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181005161424.20521-1-sashal@kernel.org>
References: <20181005161424.20521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yong Zhao <Yong.Zhao@amd.com>

[ Upstream commit 44d8cc6f1a905e4bb1d4221a898abb0d7e9d100a ]

Because CRAT_CU_FLAGS_IOMMU_PRESENT was not set in some BIOS crat, we
need to workaround this.

For future compatibility, we also overwrite the bit in capability according
to the value of needs_iommu_device.

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c    | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 21 ++++++++++++++++-----
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
index c71817963eea..66c2f856d922 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -62,9 +62,20 @@ int kfd_iommu_device_init(struct kfd_dev *kfd)
 	struct amd_iommu_device_info iommu_info;
 	unsigned int pasid_limit;
 	int err;
+	struct kfd_topology_device *top_dev;
 
-	if (!kfd->device_info->needs_iommu_device)
+	top_dev = kfd_topology_device_by_id(kfd->id);
+
+	/*
+	 * Overwrite ATS capability according to needs_iommu_device to fix
+	 * potential missing corresponding bit in CRAT of BIOS.
+	 */
+	if (!kfd->device_info->needs_iommu_device) {
+		top_dev->node_props.capability &= ~HSA_CAP_ATS_PRESENT;
 		return 0;
+	}
+
+	top_dev->node_props.capability |= HSA_CAP_ATS_PRESENT;
 
 	iommu_info.flags = 0;
 	err = amd_iommu_device_info(kfd->pdev, &iommu_info);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 5e3990bb4c4b..c4de9b2baf1c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -796,6 +796,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu);
 int kfd_topology_remove_device(struct kfd_dev *gpu);
 struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
 						uint32_t proximity_domain);
+struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id);
 struct kfd_dev *kfd_device_by_id(uint32_t gpu_id);
 struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev);
 int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_dev **kdev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index bc95d4dfee2e..80f5db4ef75f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -63,22 +63,33 @@ struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
 	return device;
 }
 
-struct kfd_dev *kfd_device_by_id(uint32_t gpu_id)
+struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id)
 {
-	struct kfd_topology_device *top_dev;
-	struct kfd_dev *device = NULL;
+	struct kfd_topology_device *top_dev = NULL;
+	struct kfd_topology_device *ret = NULL;
 
 	down_read(&topology_lock);
 
 	list_for_each_entry(top_dev, &topology_device_list, list)
 		if (top_dev->gpu_id == gpu_id) {
-			device = top_dev->gpu;
+			ret = top_dev;
 			break;
 		}
 
 	up_read(&topology_lock);
 
-	return device;
+	return ret;
+}
+
+struct kfd_dev *kfd_device_by_id(uint32_t gpu_id)
+{
+	struct kfd_topology_device *top_dev;
+
+	top_dev = kfd_topology_device_by_id(gpu_id);
+	if (!top_dev)
+		return NULL;
+
+	return top_dev->gpu;
 }
 
 struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev)
-- 
2.17.1


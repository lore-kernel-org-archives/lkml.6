Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187EDC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D520A2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFHEDxjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D520A2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbeJQBGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728331AbeJQBGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:06:44 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB30020866;
        Tue, 16 Oct 2018 17:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710120;
        bh=TfCXKbXHcpaFlDe/Odv7RXaZihUGvRRbNNKBGr4yBjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uFHEDxjgYQznyQ4evcrYDO9WHCDCwTIJDwzf1XIVq9gjYKMNyRsCZBiU9rChY9Ee9
         PTB1+p1kiy/j//n1/pleJoOZ4Nfg1ATSmJcsHWn9dXHqbYJP20LT566NnS4YP2BBvR
         ov5dyJnlSvbrWkLap379s+yIyTxOb2Osw13oee2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        Yong Zhao <Yong.Zhao@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 108/135] drm/amdkfd: Fix ATS capablity was not reported correctly on some APUs
Date:   Tue, 16 Oct 2018 19:05:38 +0200
Message-Id: <20181016170522.803349109@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c    |   13 ++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |    1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c |   21 ++++++++++++++++-----
 3 files changed, 29 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -62,9 +62,20 @@ int kfd_iommu_device_init(struct kfd_dev
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
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -796,6 +796,7 @@ int kfd_topology_add_device(struct kfd_d
 int kfd_topology_remove_device(struct kfd_dev *gpu);
 struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
 						uint32_t proximity_domain);
+struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id);
 struct kfd_dev *kfd_device_by_id(uint32_t gpu_id);
 struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev);
 int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_dev **kdev);
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -63,22 +63,33 @@ struct kfd_topology_device *kfd_topology
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



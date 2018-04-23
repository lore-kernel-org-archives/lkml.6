Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755113AbeDWL47 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:56:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755012AbeDWL4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:56:38 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <will.deacon@arm.com>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC: <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <liubo95@huawei.com>, <dingtianhong@huawei.com>,
        Yisheng Xie <xieyisheng1@huawei.com>
Subject: [RFC 0/2] iommu/arm-smmu-v3: Support software retention for pm_resume
Date: Mon, 23 Apr 2018 19:45:57 +0800
Message-ID: <1524483959-54940-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Backgroud:
 Hisilicon's implement of smmuv3 do not support hardware retention if system
 do power gating when system suspend, however for embed system, we do need
 to do power gating at trust zone for lower power comsume. So software
 retention is need.

- Implement:
 From the process of smmu probe, it will get the feature of smmu from IDR
 registers and keep the status in struct arm_smmu_device, then
 arm_smmu_device_reset() will initial(set) most of the registers according
 to it. So we can use arm_smmu_device_reset() to re-initial the smmuv3
 device to make it can works again.
 
 To achieve this, patch 1 move the bypass parameter from arm_smmu_device_reset()
 to struct arm_smmu_device to make arm_smmu_device_reset() re-usable. Patch 2
 introduces probed parameter for struct arm_smmu_device, so once smmuv3 is probed
 we can avoid request irqs once more. It also introduce a struct arm_smmu_msi_val
 to keep the value of smmuv3's msi register which can be restore when reset device
 after probed.

Yisheng Xie (2):
  iommu/arm-smmu-v3: Remove bypass in arm_smmu_reset_device
  iommu/arm-smmu-v3: Support software retention for pm_resume

 drivers/iommu/arm-smmu-v3.c | 80 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 8 deletions(-)

-- 
1.7.12.4

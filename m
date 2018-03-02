Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428967AbeCBO6q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:58:46 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46373 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428939AbeCBO6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:58:31 -0500
X-Google-Smtp-Source: AG47ELvLjxs5I8L2PvIt1zn1tqY7q/BIkhMHms6FVLLSDFzAgpg36JSdKFn5mxWVSFelS6zQ7Up8SA==
From: srinivas.kandagatla@linaro.org
To: will.deacon@arm.com, robin.murphy@arm.com, bjorn.andersson@linaro.org
Cc: joro@8bytes.org, ohad@wizery.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] iommu: armsmmu: set iommu ops for rpmsg bus
Date: Fri,  2 Mar 2018 14:55:31 +0000
Message-Id: <20180302145531.20463-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
References: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On Qualcomm SoCs, ADSP exposes many functions like audio and
others. These services need iommu access to allocate any
memory for the DSP. As these drivers are childeren of
rpmsg bus, able to allocate memory from iommus is basic
requirement. So set arm smmu iommu ops for this bus type.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/iommu/arm-smmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e6920d32ac9e..9b63489af15c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -53,6 +53,7 @@
 #include <linux/spinlock.h>
 
 #include <linux/amba/bus.h>
+#include <linux/rpmsg.h>
 
 #include "io-pgtable.h"
 #include "arm-smmu-regs.h"
@@ -2168,6 +2169,10 @@ static void arm_smmu_bus_init(void)
 		bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 	}
 #endif
+#ifdef CONFIG_RPMSG
+	if (!iommu_present(&rpmsg_bus))
+		bus_set_iommu(&rpmsg_bus, &arm_smmu_ops);
+#endif
 }
 
 static int arm_smmu_device_probe(struct platform_device *pdev)
-- 
2.15.1

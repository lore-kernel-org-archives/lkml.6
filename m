Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754704AbeDWJzN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:55:13 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35767 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754431AbeDWJzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:55:11 -0400
X-Google-Smtp-Source: AIpwx4/fArOBzuGUzjC76nPv8vmMC8Nufd+DNk22hMcnhkIAy6WT9BJqYhNHfx7FIInL7Kp3KpQGVw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] gpu: host1x: Fix dma_free_wc() argument in the error path
Date: Mon, 23 Apr 2018 12:54:56 +0300
Message-Id: <20180423095456.16697-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IOVA allocation or IOMMU mapping fails, dma_free_wc() is invoked with
size=0 because of a typo, that triggers "kernel BUG at mm/vmalloc.c:124!".

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/cdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index 93df28228721..0724122afeac 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -127,7 +127,7 @@ static int host1x_pushbuffer_init(struct push_buffer *pb)
 iommu_free_iova:
 	__free_iova(&host1x->iova, alloc);
 iommu_free_mem:
-	dma_free_wc(host1x->dev, pb->alloc_size, pb->mapped, pb->phys);
+	dma_free_wc(host1x->dev, size, pb->mapped, pb->phys);
 
 	return err;
 }
-- 
2.17.0

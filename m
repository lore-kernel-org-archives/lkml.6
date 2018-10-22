Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A41EECDE47
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2140C20853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWHANVkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2140C20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeJVSiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbeJVSiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:38:02 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D5572089E;
        Mon, 22 Oct 2018 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203607;
        bh=2wyoH0NZHk6eDTFzARw9sKAuxgJzaG84FyAPOtCJllM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWHANVkWXgxxBahEPDBpjE641CNqoG8jfCesoWk3Egmum2cFC4W766HKuqDfvyzKG
         wQo49Z2REMKTU3QPYbtOC/sxWBQR5W2PmczXBeS+PZpzLku26c9C7zYrZkkQ4k8Wu+
         4LBs+9PB+2kHSi2TtV81Pi/vosdNHRacAsLQb9Ws=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Valentine Fatiev <Valentinef@mellanox.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 20/27] IB/mlx5: Unmap DMA addr from HCA before IOMMU
Date:   Mon, 22 Oct 2018 06:19:17 -0400
Message-Id: <20181022101924.40531-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022101924.40531-1-sashal@kernel.org>
References: <20181022101924.40531-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentine Fatiev <Valentinef@mellanox.com>

[ Upstream commit dd9a403495704fc80fb9f399003013ef2be2ee23 ]

The function that puts back the MR in cache also removes the DMA address
from the HCA. Therefore we need to call this function before we remove
the DMA mapping from MMU. Otherwise the HCA may access a memory that
is no longer DMA mapped.

Call trace:
NMI: IOCK error (debug interrupt?) for reason 71 on CPU 0.
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0-rc6+ #4
Hardware name: HP ProLiant DL360p Gen8, BIOS P71 08/20/2012
RIP: 0010:intel_idle+0x73/0x120
Code: 80 5c 01 00 0f ae 38 0f ae f0 31 d2 65 48 8b 04 25 80 5c 01 00 48 89 d1 0f 60 02
RSP: 0018:ffffffff9a403e38 EFLAGS: 00000046
RAX: 0000000000000030 RBX: 0000000000000005 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff9a5790c0 RDI: 0000000000000000
RBP: 0000000000000030 R08: 0000000000000000 R09: 0000000000007cf9
R10: 000000000000030a R11: 0000000000000018 R12: 0000000000000000
R13: ffffffff9a5792b8 R14: ffffffff9a5790c0 R15: 0000002b48471e4d
FS:  0000000000000000(0000) GS:ffff9c6caf400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5737185000 CR3: 0000000590c0a002 CR4: 00000000000606f0
Call Trace:
 cpuidle_enter_state+0x7e/0x2e0
 do_idle+0x1ed/0x290
 cpu_startup_entry+0x6f/0x80
 start_kernel+0x524/0x544
 ? set_init_arg+0x55/0x55
 secondary_startup_64+0xa4/0xb0
DMAR: DRHD: handling fault status reg 2
DMAR: [DMA Read] Request device [04:00.0] fault addr b34d2000 [fault reason 06] PTE Read access is not set
DMAR: [DMA Read] Request device [01:00.2] fault addr bff8b000 [fault reason 06] PTE Read access is not set

Fixes: f3f134f5260a ("RDMA/mlx5: Fix crash while accessing garbage pointer and freed memory")
Signed-off-by: Valentine Fatiev <valentinef@mellanox.com>
Reviewed-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/mr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 308456d28afb..73339fd47dd8 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -544,6 +544,9 @@ void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	int shrink = 0;
 	int c;
 
+	if (!mr->allocated_from_cache)
+		return;
+
 	c = order2idx(dev, mr->order);
 	if (c < 0 || c >= MAX_MR_CACHE_ENTRIES) {
 		mlx5_ib_warn(dev, "order %d, cache index %d\n", mr->order, c);
@@ -1647,18 +1650,19 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 		umem = NULL;
 	}
 #endif
-
 	clean_mr(dev, mr);
 
+	/*
+	 * We should unregister the DMA address from the HCA before
+	 * remove the DMA mapping.
+	 */
+	mlx5_mr_cache_free(dev, mr);
 	if (umem) {
 		ib_umem_release(umem);
 		atomic_sub(npages, &dev->mdev->priv.reg_pages);
 	}
-
 	if (!mr->allocated_from_cache)
 		kfree(mr);
-	else
-		mlx5_mr_cache_free(dev, mr);
 }
 
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr)
-- 
2.17.1


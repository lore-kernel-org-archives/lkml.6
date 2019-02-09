Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D45C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CA620643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738586;
	bh=q194z93Dz4zTJ417OY+FBmmB8Y1WED/dvhUReIbhpxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1vcLtA9RArcEW3CseqtGyI8HLH2Wf2vNFNCdZfU0E9YS85hPerSjlTABH/sDTufpY
	 csGw8q7OB4POaMQt6NRp3QMo5XiBz49nlsSg0cqXBH50DHdrQGhh+gU71jaWoJVSVD
	 GhLVCPcy6D4Lj+WnNLbeu6nrmsSqz0ZH4/QIkAXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfBISsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:48:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfBISr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:47:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5113021916;
        Sat,  9 Feb 2019 18:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738078;
        bh=q194z93Dz4zTJ417OY+FBmmB8Y1WED/dvhUReIbhpxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CWtnG5q7+xq+mQiSL2zrVaN3T21Y/gpPe0FsHkh6B1TRTjMfkDVND/NbFZtsk7fvv
         eLOCsJEFsfzKnwVmeZepHo+dX/++9GlsLy2CwBsZnho0k9m3NrugSllXC/JFAA1205
         asbx+izmew0CwrkSh1qGTzI2OLL1czsAPhwrvbps=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liviu Dudau <liviu@dudau.co.uk>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.20 21/42] nvme-pci: use the same attributes when freeing host_mem_desc_bufs.
Date:   Sat,  9 Feb 2019 13:47:13 -0500
Message-Id: <20190209184734.125935-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liviu Dudau <liviu@dudau.co.uk>

[ Upstream commit cc667f6d5de023ee131e96bb88e5cddca23272bd ]

When using HMB the PCIe host driver allocates host_mem_desc_bufs using
dma_alloc_attrs() but frees them using dma_free_coherent(). Use the
correct dma_free_attrs() function to free the buffers.

Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c33bb201b884..0f45868e8af9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1748,8 +1748,9 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 		struct nvme_host_mem_buf_desc *desc = &dev->host_mem_descs[i];
 		size_t size = le32_to_cpu(desc->size) * dev->ctrl.page_size;
 
-		dma_free_coherent(dev->dev, size, dev->host_mem_desc_bufs[i],
-				le64_to_cpu(desc->addr));
+		dma_free_attrs(dev->dev, size, dev->host_mem_desc_bufs[i],
+			       le64_to_cpu(desc->addr),
+			       DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
 	}
 
 	kfree(dev->host_mem_desc_bufs);
@@ -1815,8 +1816,9 @@ out_free_bufs:
 	while (--i >= 0) {
 		size_t size = le32_to_cpu(descs[i].size) * dev->ctrl.page_size;
 
-		dma_free_coherent(dev->dev, size, bufs[i],
-				le64_to_cpu(descs[i].addr));
+		dma_free_attrs(dev->dev, size, bufs[i],
+			       le64_to_cpu(descs[i].addr),
+			       DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
 	}
 
 	kfree(bufs);
-- 
2.19.1


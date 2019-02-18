Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B2FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA30921904
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497869;
	bh=QAYKQUkQsUGhaL0TS0Sf73iRmo1Lfx56+mNR5UHG+zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nRlwQ52XBYvc6bEnLL35uf/uvaFfetqvAS8pLktql1piIPy6juj8mWFBy+4BkR3lD
	 QCoR1walIqOYzuqXaI6WxMq+rlfR6BgvhC+fFqJTlMK5ZJHv4RFUxfHNOR8mV1uP+L
	 jwz8YWqYFSRSV4RQpbudrqKm8Hp2a+rUdpnVDiGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbfBRNvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:51:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:58886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731430AbfBRNvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:51:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12DC720842;
        Mon, 18 Feb 2019 13:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497863;
        bh=QAYKQUkQsUGhaL0TS0Sf73iRmo1Lfx56+mNR5UHG+zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hD/riLlYfbjoTzf8Xyz/Dd0HnCA4k1kNbEsVgTMY/F6gcA/Tp50iRMgCHbDxrCPBk
         rPvmubrq+5YL7jPQGzi91aU8AvBlTgXc32eQqKc57TQO/fq1fqcLA8Fe4kCoJUgs5R
         ISQkVXPh8PdJyRL8LVz2Yo46LmkWyzct6HA6eKck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liviu Dudau <liviu@dudau.co.uk>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 34/85] nvme-pci: use the same attributes when freeing host_mem_desc_bufs.
Date:   Mon, 18 Feb 2019 14:43:00 +0100
Message-Id: <20190218133503.537761497@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d668682f91df..40f76b4f08fc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1727,8 +1727,9 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 		struct nvme_host_mem_buf_desc *desc = &dev->host_mem_descs[i];
 		size_t size = le32_to_cpu(desc->size) * dev->ctrl.page_size;
 
-		dma_free_coherent(dev->dev, size, dev->host_mem_desc_bufs[i],
-				le64_to_cpu(desc->addr));
+		dma_free_attrs(dev->dev, size, dev->host_mem_desc_bufs[i],
+			       le64_to_cpu(desc->addr),
+			       DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
 	}
 
 	kfree(dev->host_mem_desc_bufs);
@@ -1794,8 +1795,9 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
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




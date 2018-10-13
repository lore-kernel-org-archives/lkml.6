Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEF6C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A242151D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 15:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RR1zzHcN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A242151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJMWys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:54:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeJMWys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VOOg2jZR93ZgSDWc4idp7gl5WiJmFFr+34LQzsxinKE=; b=RR1zzHcNLIADP7ppNXFDffWt00
        YPuPqmMC1ELUMqtg5VnAv9hKrG5qadhYMoM2dmB83dRvlv/zTDhGK5sAJ3+jRhxV7mNO1j78bIgf0
        P+DKgfeVtaI8y4B2CwDUq+2abRVU1OE2uWXY0O3Bm9aYO9029LxjpGCZin2MRtFgvtdzXwB9BPQtW
        lUS++vL5+97R7OQuSSOIfYms32ZwVTRTt0cmnyFmW19HEwrqsTQqlZ1N4HxoRIjHZHEvkghLVTp5Q
        7Woq+BBP3MU3A0GcGpZY/ex+lsdXk1f6f8Hb7FPhtq2kDVXnoS1Wsmbx/YRVta75PhOqOQD+O38Rc
        M1MShsTQ==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBLfH-0004zy-7L; Sat, 13 Oct 2018 15:17:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] firmware: tegra: don't pass GFP_DMA32 to dma_alloc_coherent
Date:   Sat, 13 Oct 2018 17:17:01 +0200
Message-Id: <20181013151707.32210-3-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181013151707.32210-1-hch@lst.de>
References: <20181013151707.32210-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA API does its own zone decisions based on the coherent_dma_mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/firmware/tegra/bpmp-debugfs.c | 11 +++++------
 drivers/firmware/tegra/bpmp.c         |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
index f7f6a0a5cb07..567160897bac 100644
--- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -218,12 +218,12 @@ static int debugfs_show(struct seq_file *m, void *p)
 		return -ENOENT;
 
 	namevirt = dma_alloc_coherent(bpmp->dev, namesize, &namephys,
-				      GFP_KERNEL | GFP_DMA32);
+				      GFP_KERNEL);
 	if (!namevirt)
 		return -ENOMEM;
 
 	datavirt = dma_alloc_coherent(bpmp->dev, datasize, &dataphys,
-				      GFP_KERNEL | GFP_DMA32);
+				      GFP_KERNEL);
 	if (!datavirt) {
 		ret = -ENOMEM;
 		goto free_namebuf;
@@ -269,12 +269,12 @@ static ssize_t debugfs_store(struct file *file, const char __user *buf,
 		return -ENOENT;
 
 	namevirt = dma_alloc_coherent(bpmp->dev, namesize, &namephys,
-				      GFP_KERNEL | GFP_DMA32);
+				      GFP_KERNEL);
 	if (!namevirt)
 		return -ENOMEM;
 
 	datavirt = dma_alloc_coherent(bpmp->dev, datasize, &dataphys,
-				      GFP_KERNEL | GFP_DMA32);
+				      GFP_KERNEL);
 	if (!datavirt) {
 		ret = -ENOMEM;
 		goto free_namebuf;
@@ -422,8 +422,7 @@ int tegra_bpmp_init_debugfs(struct tegra_bpmp *bpmp)
 	if (!root)
 		return -ENOMEM;
 
-	virt = dma_alloc_coherent(bpmp->dev, sz, &phys,
-				  GFP_KERNEL | GFP_DMA32);
+	virt = dma_alloc_coherent(bpmp->dev, sz, &phys, GFP_KERNEL);
 	if (!virt) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 14a456afa379..e6d2356ccec3 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -531,7 +531,7 @@ static int tegra_bpmp_get_firmware_tag(struct tegra_bpmp *bpmp, char *tag,
 	int err;
 
 	virt = dma_alloc_coherent(bpmp->dev, MSG_DATA_MIN_SZ, &phys,
-				  GFP_KERNEL | GFP_DMA32);
+				  GFP_KERNEL);
 	if (!virt)
 		return -ENOMEM;
 
-- 
2.19.1


Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9CAC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1524920851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f975eRVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1524920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeLDWnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:43:01 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43103 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeLDWnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:43:00 -0500
Received: by mail-io1-f67.google.com with SMTP id f10so9251658iop.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9vknFr4Z42GGDO9i6nv+cy57/ZPFP0XYl61BZl2VGnU=;
        b=f975eRVTK/er5fImh3jVwsM64EKlLASLdj1tZ8yG4XQUZO8vdVWQtHkrbYtkwpQ4cv
         pKmXCQuh+FbwbDo3KzuBYxArASQQIhK+DfCyuW5KmoeYt1MHAGr4i+aOw5CnjqUpbRao
         c9VVPxTEn8iP2HC9uZPys1JryooilQtDYmDl0ec2rjuhGbqgrssNPIi8HbJf6brjE4v9
         mxlVCvOM3RomtXvVNzu8kl9HXJFubIaHka2IKPsoH9GJRMikrLFqAmm/UFo2Pnm+TdHH
         ddCK4Pod4//BNEcTUcjNYy2NSmppPMDEUXBaSXs/bWM5yc6C17cswHAoBY9EcfTs7kW5
         wA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9vknFr4Z42GGDO9i6nv+cy57/ZPFP0XYl61BZl2VGnU=;
        b=QT2ygonbpm17WDS49l82++sKYejXrIFIGiLprjJxhu82sXckEN4+PP/Nu3B1/xlxF1
         ByXDJhCPgVkSO6FLd1JNi/LzeIS5lpJwEPHYIJ2dLClxbyon7F5AO0/LqwQ/irncpp07
         bfT+sLwpCJkc1LAtYjsQsfiJmPDHFLOLHi9nThpMSFk/oiOMT7+4DcLPTAS2EoJQpCZj
         Cii2oH/0YAi3y/Y6RM+Gc4bWCF2z281NpkymwSy+QfLcqdT6xamb6ANlVe6gpyl/Tekf
         7Da0iwNgov35nhl5562hZsmaApjJU1pDyN9K519qpVOhwmfhJZjtt5JyPGlg4hdBMbJ9
         +Vzg==
X-Gm-Message-State: AA+aEWbLnhoc8PZSAC0BQMbsyL6fv1HIqDeoYXDFHi7/zr5Dbxilo857
        0jPYYIZ5v/VS3d2f34kxP1wRNg==
X-Google-Smtp-Source: AFSGD/WDUW52Bve9+0FM9athxP4TgXmSEaGe1HXS/daoHkTp4kqS41aIABVRnK+a7pUurYECrKFMnw==
X-Received: by 2002:a6b:8d11:: with SMTP id p17mr19414921iod.74.1543963378610;
        Tue, 04 Dec 2018 14:42:58 -0800 (PST)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id 196sm2985872itu.37.2018.12.04.14.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 14:42:57 -0800 (PST)
From:   Yu Zhao <yuzhao@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        aroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Daniel Kurtz <djkurtz@chromium.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH 1/2] ASoC: use DMA addr rather than CPU pa for acp_audio_dma
Date:   Tue,  4 Dec 2018 15:42:52 -0700
Message-Id: <20181204224253.216075-1-yuzhao@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We shouldn't assume CPU physical address we get from page_to_phys()
is same as DMA address we get from dma_alloc_coherent(). On x86_64,
we won't run into any problem with the assumption when dma_ops is
nommu_dma_ops. However, DMA address is IOVA when IOMMU is enabled.
And it's most likely different from CPU physical address when AMD
IOMMU is not in passthrough mode.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 sound/soc/amd/acp-pcm-dma.c | 15 +++++----------
 sound/soc/amd/acp.h         |  2 +-
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index cdebab2f8ce5..fd3db4c37882 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -303,11 +303,10 @@ static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio, u32 size,
 }
 
 /* Create page table entries in ACP SRAM for the allocated memory */
-static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
+static void acp_pte_config(void __iomem *acp_mmio, dma_addr_t addr,
 			   u16 num_of_pages, u32 pte_offset)
 {
 	u16 page_idx;
-	u64 addr;
 	u32 low;
 	u32 high;
 	u32 offset;
@@ -317,7 +316,6 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 		/* Load the low address of page int ACP SRAM through SRBM */
 		acp_reg_write((offset + (page_idx * 8)),
 			      acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
-		addr = page_to_phys(pg);
 
 		low = lower_32_bits(addr);
 		high = upper_32_bits(addr);
@@ -333,7 +331,7 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 		acp_reg_write(high, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
 
 		/* Move to next physically contiguos page */
-		pg++;
+		addr += PAGE_SIZE;
 	}
 }
 
@@ -343,7 +341,7 @@ static void config_acp_dma(void __iomem *acp_mmio,
 {
 	u16 ch_acp_sysmem, ch_acp_i2s;
 
-	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
+	acp_pte_config(acp_mmio, rtd->dma_addr, rtd->num_of_pages,
 		       rtd->pte_offset);
 
 	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -850,7 +848,6 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	int status;
 	uint64_t size;
 	u32 val = 0;
-	struct page *pg;
 	struct snd_pcm_runtime *runtime;
 	struct audio_substream_data *rtd;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
@@ -986,16 +983,14 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		return status;
 
 	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
-	pg = virt_to_page(substream->dma_buffer.area);
 
-	if (pg) {
+	if (substream->dma_buffer.area) {
 		acp_set_sram_bank_state(rtd->acp_mmio, 0, true);
 		/* Save for runtime private data */
-		rtd->pg = pg;
+		rtd->dma_addr = substream->dma_buffer.addr;
 		rtd->order = get_order(size);
 
 		/* Fill the page table entries in ACP SRAM */
-		rtd->pg = pg;
 		rtd->size = size;
 		rtd->num_of_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 		rtd->direction = substream->stream;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index dbbb1a85638d..e5ab6c6040a6 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -123,7 +123,7 @@ enum acp_dma_priority_level {
 };
 
 struct audio_substream_data {
-	struct page *pg;
+	dma_addr_t dma_addr;
 	unsigned int order;
 	u16 num_of_pages;
 	u16 i2s_instance;
-- 
2.20.0.rc1.387.gf8505762e3-goog


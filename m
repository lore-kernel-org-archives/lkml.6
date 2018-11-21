Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B9BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5912148E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aDHl3ByL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5912148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbeKURLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 12:11:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39732 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbeKURLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 12:11:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so4001307pla.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 22:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RGLCkqahISwC4vlHT0y91a6MaGY0OERKfY8BG0Tp2wo=;
        b=aDHl3ByL5vtebZKl960NivHiY1cD1BYGxPgcvXDcVoiRj31ZP4qVvF2vWpy0z+Nxfg
         EE65l7a9HUcTcEOANA97pdP9Aj8MzCvmB46dl/1VyVZ8wjRu0YE/eNnZVc0ob9+ZyyaZ
         FuZ+iAMQf4gmyfsBri7i0TzvjIA/ckBdn/XnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RGLCkqahISwC4vlHT0y91a6MaGY0OERKfY8BG0Tp2wo=;
        b=NcRebBDOfnHFWVrbZRPISRzwDyVKYeabUfK5sWra0cLxTRadCWyjWT5m0ZEYR45JFD
         GbspXAKVH8oYPHN0QoTDxWU6u2M84rk4wP5HS5bMCIWDSUJGWiQqAfa6UYjl3PT9w4TX
         Fmg896gY7o5oIv2ja2PaMI0OLQrK42UehWY0tk8pt4z1S6/qxLr5G1yL7UuZrUK3jye+
         yAB9A/qVJZo0j5unj+XOJtWn3qYodywZ9BhXX9Xwtspzh2OllqfmPNF5MloO8H1kl7is
         kyyHn8CjC5DSW/SteUOeMhyLl8FJcrRSg5FRrrZ/PQb9p0RaF7+9L3g70FOhBGQs++gL
         78Tg==
X-Gm-Message-State: AGRZ1gJL4fXeLgPJUi6Fe4ZxktLMdEWvfEy9FATv8+MOGx0pZAoMZN1a
        tC3Q4Qvs8H3BhlAo8nOwJMJahQ==
X-Google-Smtp-Source: AJdET5e2LXvM/6ZN1VpqAgChWY976d83gkpvXOnUK+hy6zqLo8Sjfiqb2Mkec4xhEtgYiLpYl5w3vw==
X-Received: by 2002:a62:682:: with SMTP id 124-v6mr5515308pfg.161.1542782285681;
        Tue, 20 Nov 2018 22:38:05 -0800 (PST)
Received: from tfiga.tok.corp.google.com ([2401:fa00:4:4:5b21:5966:1198:d1e9])
        by smtp.gmail.com with ESMTPSA id e14-v6sm50847369pfn.46.2018.11.20.22.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 22:38:05 -0800 (PST)
From:   Tomasz Figa <tfiga@chromium.org>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hiroh@chromium.org,
        Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH] media: mtk-vcodec: Remove VA from encoder frame buffers
Date:   Wed, 21 Nov 2018 15:37:59 +0900
Message-Id: <20181121063759.26374-1-tfiga@chromium.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The encoder driver has no need to do any CPU access to the source frame
buffers. Use a separate structure for holding DMA addresses and sizes
for those and remove, so we do not end up introducing any erroneous
dereferences of those VAs.

This fixes DMA-buf import from exporters that do not provide contiguous
kernel mappings, which includes the MTK DRM driver.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c  | 6 +-----
 drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h | 5 +++++
 drivers/media/platform/mtk-vcodec/venc_drv_if.h     | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 54631ad1c71e..d1f12257bf66 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -1087,7 +1087,6 @@ static void mtk_venc_worker(struct work_struct *work)
 	src_buf = v4l2_m2m_src_buf_remove(ctx->m2m_ctx);
 	memset(&frm_buf, 0, sizeof(frm_buf));
 	for (i = 0; i < src_buf->num_planes ; i++) {
-		frm_buf.fb_addr[i].va = vb2_plane_vaddr(src_buf, i);
 		frm_buf.fb_addr[i].dma_addr =
 				vb2_dma_contig_plane_dma_addr(src_buf, i);
 		frm_buf.fb_addr[i].size =
@@ -1098,14 +1097,11 @@ static void mtk_venc_worker(struct work_struct *work)
 	bs_buf.size = (size_t)dst_buf->planes[0].length;
 
 	mtk_v4l2_debug(2,
-			"Framebuf VA=%p PA=%llx Size=0x%zx;VA=%p PA=0x%llx Size=0x%zx;VA=%p PA=0x%llx Size=%zu",
-			frm_buf.fb_addr[0].va,
+			"Framebuf PA=%llx Size=0x%zx;PA=0x%llx Size=0x%zx;PA=0x%llx Size=%zu",
 			(u64)frm_buf.fb_addr[0].dma_addr,
 			frm_buf.fb_addr[0].size,
-			frm_buf.fb_addr[1].va,
 			(u64)frm_buf.fb_addr[1].dma_addr,
 			frm_buf.fb_addr[1].size,
-			frm_buf.fb_addr[2].va,
 			(u64)frm_buf.fb_addr[2].dma_addr,
 			frm_buf.fb_addr[2].size);
 
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
index 06c254f5c171..9bf6e8d1b9c9 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
@@ -25,6 +25,11 @@ struct mtk_vcodec_mem {
 	dma_addr_t dma_addr;
 };
 
+struct mtk_vcodec_fb {
+	size_t size;
+	dma_addr_t dma_addr;
+};
+
 struct mtk_vcodec_ctx;
 struct mtk_vcodec_dev;
 
diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_if.h b/drivers/media/platform/mtk-vcodec/venc_drv_if.h
index a6e7d32e55cb..55ecda844894 100644
--- a/drivers/media/platform/mtk-vcodec/venc_drv_if.h
+++ b/drivers/media/platform/mtk-vcodec/venc_drv_if.h
@@ -106,7 +106,7 @@ struct venc_enc_param {
  * @fb_addr: plane frame buffer addresses
  */
 struct venc_frm_buf {
-	struct mtk_vcodec_mem fb_addr[MTK_VCODEC_MAX_PLANES];
+	struct mtk_vcodec_fb fb_addr[MTK_VCODEC_MAX_PLANES];
 };
 
 /*
-- 
2.19.1.1215.g8438c0b245-goog


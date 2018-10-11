Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DF7C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AA02077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jpVsnuvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AA02077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJKOMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:12:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37241 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJKOMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:12:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id u6-v6so981881plz.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 23:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qehop1mbGHd5EyLAVWNETV3o1NhcD/oA3XpnKQJXnos=;
        b=jpVsnuvvo2rrILrbEpz2t9mkbZaOuVCu6V0WjTIEsXoAL0fcSbYCNSCOIDnuwcGvf3
         AA/YvQK1jPE5a65bcZv0Qti72XIwH2s+iujIFXv5EWIdA59IX+026KXCk8z7m1QN4H2h
         XcxHn+aHmLBws1j54WapgT6tIUhip9pgFSmMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qehop1mbGHd5EyLAVWNETV3o1NhcD/oA3XpnKQJXnos=;
        b=UnPQLwR/qzkYxh/84gvVHNL7fWueCqQ2GCe5ldAxpjE8y+2Zv/YImCnKyCJ7TLjCdT
         nRw3m/KkwgbxqWasqlZ+nM1HJfkuY1f+EghsMO4fwdpzs1Elsuu/FcZmLUDJ4oAjIM0H
         9ZSnJ4wsA8KSdc0Bi1B/Pr5N+WGb650ZwkWD28pgPEO9Mm/zAoEKhsxzwZ3VO16X8h7K
         PJp9+iv2pGdXMpsIoEYvsI5nn55ADvrujjYiWiPEGw2EyQ3qsFtApJiHRck5EbbRWyZg
         pOn5vuqPn2pvfRUR4KuB4T9FTvAJQSOVzhmiwimK/Eeg3x1LWln8hsEwF4O7RDgq2MdY
         TgiQ==
X-Gm-Message-State: ABuFfoj1orXv/NeOOrrI162Z6HkuFoJaG2LBmArQ5TMDXG25NVfzN2Ey
        SxMrMGby5bvrCBmqbb7sCirJV+fMuTcY7g==
X-Google-Smtp-Source: ACcGV60TQN/j1joR5O+y14AmgrA0QBz2R+w9zmPVVwPy5LrM6Fdu6kw2pgHEFhdYLANEfCulDqdLSA==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7-v6mr336949plt.268.1539240384184;
        Wed, 10 Oct 2018 23:46:24 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id 189-v6sm41336699pfe.121.2018.10.10.23.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 23:46:23 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH] media: venus: support VB2_USERPTR IO mode
Date:   Thu, 11 Oct 2018 15:46:08 +0900
Message-Id: <20181011064608.37435-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The venus codec can work just fine with USERPTR buffers. Enable this
possibility.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 4 ++--
 drivers/media/platform/qcom/venus/venc.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 33320c5025313f..dfc2260e8d213a 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -984,7 +984,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 	int ret;
 
 	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
-	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
+	src_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
 	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
 	src_vq->ops = &vdec_vb2_ops;
 	src_vq->mem_ops = &vb2_dma_sg_memops;
@@ -999,7 +999,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 		return ret;
 
 	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
-	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
+	dst_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
 	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
 	dst_vq->ops = &vdec_vb2_ops;
 	dst_vq->mem_ops = &vb2_dma_sg_memops;
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index d2805b5e28a1b2..71ca59a24991be 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -1073,7 +1073,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 	int ret;
 
 	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
-	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
+	src_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
 	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
 	src_vq->ops = &venc_vb2_ops;
 	src_vq->mem_ops = &vb2_dma_sg_memops;
@@ -1090,7 +1090,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 		return ret;
 
 	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
-	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
+	dst_vq->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
 	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
 	dst_vq->ops = &venc_vb2_ops;
 	dst_vq->mem_ops = &vb2_dma_sg_memops;
-- 
2.19.0.605.g01d371f741-goog


Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88ECC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617DD2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWn9Ky9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617DD2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbeJKG6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:58:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40775 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeJKG6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:58:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id 1-v6so3244133plv.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 16:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oq/1X2eWSUAz4jFjB/D59QGpN992y5YOc8MZYE9CqZQ=;
        b=GWn9Ky9IucSpJsGk7CsZsX30oSpZRgynTQlcnX7q9DfhWv7MvLJnhj54tPeCsgmAE6
         KSoWepqwO0mNLVW8mLg3yUuurEJYT4g2UGbwQTkTcHgK0C8SRQsAUjEMDY9YBBb68LOl
         uC/+EH7gST+vfYyerzahVzCnNnEfdSHUXvyj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oq/1X2eWSUAz4jFjB/D59QGpN992y5YOc8MZYE9CqZQ=;
        b=CZ8bI3F8MA0ynViEXMmNyQNjeKpLwu7FcpnA05ce94ORRod9wGTIVM4jw5NAnv6UUz
         5XzOBfwSmQ0w6X1ak6qzIEWwLM6PeDMrWMfqMAVu+YvxYrsm5WpVZzsFy82P/wIVDECv
         ULyhQ577LJdxCogFvIki9ThK+7a4q4pHAOPHRfl3MnnrruK10aAXesRyx+trHw8GMbUm
         gjTwY4Fzhkz3WRAHcLhU/F99WPSaJNqg/fa3kb1P4IjrbiiFkm4tuI9dOoFynxsRqtMd
         NnQR016ArQN7C2iAhKMw15Wl7maI6s4W9T1SH5PYQqNqc8aLvcZeP8EyTjWYoyCA4/23
         29qw==
X-Gm-Message-State: ABuFfojSygylziCSVEx0tFX7oGNfuQb/GDGtd36HyCzgEM+MHYT2RCvW
        BzRBQK5oukCBg5/j8TLLQ5AQqp6GHI0=
X-Google-Smtp-Source: ACcGV60JxTJ0RziMCXqSDS12eA4/uWBZXhfDl7BX/z7MFmSkvHZ6KsLfMi9Qwomeq3xvu1V1Q6HYlA==
X-Received: by 2002:a17:902:7c8b:: with SMTP id y11-v6mr1377404pll.321.1539214420377;
        Wed, 10 Oct 2018 16:33:40 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id q127-v6sm31115235pgq.19.2018.10.10.16.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Oct 2018 16:33:38 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Matt Szczesiak <matt.szczesiak@arm.com>,
        Anders Pedersen <Anders.Pedersen@arm.com>,
        John Reitan <John.Reitan@arm.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] staging: ion: Rework ion_map_dma_buf() to minimize re-mapping
Date:   Wed, 10 Oct 2018 16:33:33 -0700
Message-Id: <1539214413-26173-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 4.12, much later narrowed down to commit 2a55e7b5e544
("staging: android: ion: Call dma_map_sg for syncing and mapping"),
we have seen graphics performance issues on the HiKey960.

This was initially confounded by the fact that the out-of-tree
DRM driver was using HiSi custom ION heap which broke with the
4.12 ION abi changes, so there was lots of suspicion that the
performance problems were due to switching to a somewhat simple
cma based DRM driver for HiKey960. Additionally, as no
performance regression was seen w/ the original HiKey board
(which is SMP, not big.LITTLE as w/ HiKey960), there was some
thought that the out-of-tree EAS code wasn't quite optimized.

But after chasing a number of other leads, I found that
reverting the ION code to 4.11-era got the majority of the
graphics performance back (there may yet be further EAS tweaks
needed), which lead me to the dma_map_sg change.

In talking w/ Laura and Liam, it was suspected that the extra
cache operations were causing the trouble. Additionally, I found
that part of the reason we didn't see this w/ the original
HiKey board is that its (proprietary blob) GL code uses ion_mmap
and ion_map_dma_buf is called very rarely, where as with
HiKey960, the (also proprietary blob) GL code calls
ion_map_dma_buf much more frequently via the kernel driver.

Anyway, with the cause of the performance regression isolated,
I've tried to find a way to improve the performance of the
current code.

This approach, which I've mostly copied from the drm_prime
implementation is to try to track the direction we're mapping
the buffers so we can avoid calling dma_map/unmap_sg on every
ion_map_dma_buf/ion_unmap_dma_buf call, and instead try to do
the work in attach/detach paths.

I'm not 100% sure of the correctness here, so close review would
be good, but it gets the performance back to being similar to
reverting the ION code to the 4.11-era.

Feedback would be greatly appreciated!

Cc: Beata Michalska <Beata.Michalska@arm.com>
Cc: Matt Szczesiak <matt.szczesiak@arm.com>
Cc: Anders Pedersen <Anders.Pedersen@arm.com>
Cc: John Reitan <John.Reitan@arm.com>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Todd Kjos <tkjos@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/staging/android/ion/ion.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 9907332..a4d7fca 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -199,6 +199,7 @@ struct ion_dma_buf_attachment {
 	struct device *dev;
 	struct sg_table *table;
 	struct list_head list;
+	enum dma_data_direction dir;
 };
 
 static int ion_dma_buf_attach(struct dma_buf *dmabuf,
@@ -220,6 +221,7 @@ static int ion_dma_buf_attach(struct dma_buf *dmabuf,
 
 	a->table = table;
 	a->dev = attachment->dev;
+	a->dir = DMA_NONE;
 	INIT_LIST_HEAD(&a->list);
 
 	attachment->priv = a;
@@ -236,6 +238,18 @@ static void ion_dma_buf_detatch(struct dma_buf *dmabuf,
 {
 	struct ion_dma_buf_attachment *a = attachment->priv;
 	struct ion_buffer *buffer = dmabuf->priv;
+	struct sg_table *table;
+
+	if (!a)
+		return;
+
+	table = a->table;
+	if (table) {
+		if (a->dir != DMA_NONE)
+			dma_unmap_sg(attachment->dev, table->sgl, table->nents,
+				     a->dir);
+		sg_free_table(table);
+	}
 
 	free_duped_table(a->table);
 	mutex_lock(&buffer->lock);
@@ -243,6 +257,7 @@ static void ion_dma_buf_detatch(struct dma_buf *dmabuf,
 	mutex_unlock(&buffer->lock);
 
 	kfree(a);
+	attachment->priv = NULL;
 }
 
 static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
@@ -251,12 +266,24 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
 	struct ion_dma_buf_attachment *a = attachment->priv;
 	struct sg_table *table;
 
-	table = a->table;
+	if (WARN_ON(direction == DMA_NONE || !a))
+		return ERR_PTR(-EINVAL);
 
-	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
-			direction))
-		return ERR_PTR(-ENOMEM);
+	if (a->dir == direction)
+		return a->table;
 
+	if (WARN_ON(a->dir != DMA_NONE))
+		return ERR_PTR(-EBUSY);
+
+	table = a->table;
+	if (!IS_ERR(table)) {
+		if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
+				direction)) {
+			table = ERR_PTR(-ENOMEM);
+		} else {
+			a->dir = direction;
+		}
+	}
 	return table;
 }
 
@@ -264,7 +291,6 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
 			      struct sg_table *table,
 			      enum dma_data_direction direction)
 {
-	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
 }
 
 static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
-- 
2.7.4


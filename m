Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7C2C5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABE220850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l0xfzVJF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IcbAiLnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfARSiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:38:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36122 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729126AbfARSiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:38:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 75F5A608EA; Fri, 18 Jan 2019 18:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547836682;
        bh=t2obj2KYN0yWx1JS1XYvQGTnqXCVaTHFozGLl/GXT1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l0xfzVJF2V2ZNjHP09urtk+t1zstnBVt9lI+lzj3qQ+kIsj/mKRrHrKEuEeM8FI5B
         3zi5XDYb0g89hsVgBn/D0iGwLOS55uecbapPDfAGq/vqEdWutTkMx/dIKzq0gc+8Mn
         y+XHNEO0XsoSqXvSas0gsbrTi19Mz9SUml413lA8=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 716BE6087D;
        Fri, 18 Jan 2019 18:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547836681;
        bh=t2obj2KYN0yWx1JS1XYvQGTnqXCVaTHFozGLl/GXT1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcbAiLnweMFMJqHN3VgoNmdQ5Rk7v90GLk1FOKhs+0/ofS2R7VhqTvb3Xa+fSR7WV
         4Fu7GnWBRxL0SSPsGyQhAOiYFzLLDVgfaXu42Nj3y+yJy8vhkY6Wj89eduXnHq2LhQ
         euW5cjP1mdTZXcUnL7+YnVkLAUqvvUa38pkEKD0A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 716BE6087D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
From:   Liam Mark <lmark@codeaurora.org>
To:     labbott@redhat.com, sumit.semwal@linaro.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        afd@ti.com, john.stultz@linaro.org,
        Liam Mark <lmark@codeaurora.org>
Subject: [PATCH 2/4] staging: android: ion: Restrict cache maintenance to dma mapped memory
Date:   Fri, 18 Jan 2019 10:37:45 -0800
Message-Id: <1547836667-13695-3-git-send-email-lmark@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ION begin_cpu_access and end_cpu_access functions use the
dma_sync_sg_for_cpu and dma_sync_sg_for_device APIs to perform cache
maintenance.

Currently it is possible to apply cache maintenance, via the
begin_cpu_access and end_cpu_access APIs, to ION buffers which are not
dma mapped.

The dma sync sg APIs should not be called on sg lists which have not been
dma mapped as this can result in cache maintenance being applied to the
wrong address. If an sg list has not been dma mapped then its dma_address
field has not been populated, some dma ops such as the swiotlb_dma_ops ops
use the dma_address field to calculate the address onto which to apply
cache maintenance.

Also I don’t think we want CMOs to be applied to a buffer which is not
dma mapped as the memory should already be coherent for access from the
CPU. Any CMOs required for device access taken care of in the
dma_buf_map_attachment and dma_buf_unmap_attachment calls.
So really it only makes sense for begin_cpu_access and end_cpu_access to
apply CMOs if the buffer is dma mapped.

Fix the ION begin_cpu_access and end_cpu_access functions to only apply
cache maintenance to buffers which are dma mapped.

Fixes: 2a55e7b5e544 ("staging: android: ion: Call dma_map_sg for syncing and mapping")
Signed-off-by: Liam Mark <lmark@codeaurora.org>
---
 drivers/staging/android/ion/ion.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 6f5afab7c1a1..1fe633a7fdba 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -210,6 +210,7 @@ struct ion_dma_buf_attachment {
 	struct device *dev;
 	struct sg_table *table;
 	struct list_head list;
+	bool dma_mapped;
 };
 
 static int ion_dma_buf_attach(struct dma_buf *dmabuf,
@@ -231,6 +232,7 @@ static int ion_dma_buf_attach(struct dma_buf *dmabuf,
 
 	a->table = table;
 	a->dev = attachment->dev;
+	a->dma_mapped = false;
 	INIT_LIST_HEAD(&a->list);
 
 	attachment->priv = a;
@@ -261,12 +263,18 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
 {
 	struct ion_dma_buf_attachment *a = attachment->priv;
 	struct sg_table *table;
+	struct ion_buffer *buffer = attachment->dmabuf->priv;
 
 	table = a->table;
 
+	mutex_lock(&buffer->lock);
 	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
-			direction))
+			direction)) {
+		mutex_unlock(&buffer->lock);
 		return ERR_PTR(-ENOMEM);
+	}
+	a->dma_mapped = true;
+	mutex_unlock(&buffer->lock);
 
 	return table;
 }
@@ -275,7 +283,13 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
 			      struct sg_table *table,
 			      enum dma_data_direction direction)
 {
+	struct ion_dma_buf_attachment *a = attachment->priv;
+	struct ion_buffer *buffer = attachment->dmabuf->priv;
+
+	mutex_lock(&buffer->lock);
 	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
+	a->dma_mapped = false;
+	mutex_unlock(&buffer->lock);
 }
 
 static int ion_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
@@ -346,8 +360,9 @@ static int ion_dma_buf_begin_cpu_access(struct dma_buf *dmabuf,
 
 	mutex_lock(&buffer->lock);
 	list_for_each_entry(a, &buffer->attachments, list) {
-		dma_sync_sg_for_cpu(a->dev, a->table->sgl, a->table->nents,
-				    direction);
+		if (a->dma_mapped)
+			dma_sync_sg_for_cpu(a->dev, a->table->sgl,
+					    a->table->nents, direction);
 	}
 
 unlock:
@@ -369,8 +384,9 @@ static int ion_dma_buf_end_cpu_access(struct dma_buf *dmabuf,
 
 	mutex_lock(&buffer->lock);
 	list_for_each_entry(a, &buffer->attachments, list) {
-		dma_sync_sg_for_device(a->dev, a->table->sgl, a->table->nents,
-				       direction);
+		if (a->dma_mapped)
+			dma_sync_sg_for_device(a->dev, a->table->sgl,
+					       a->table->nents, direction);
 	}
 	mutex_unlock(&buffer->lock);
 
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project


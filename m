Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6248EC5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EC420850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oKGWMVIz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jpxCEJsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfARSiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:38:12 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36474 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbfARSiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:38:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 820D660995; Fri, 18 Jan 2019 18:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547836686;
        bh=6JuJxs4HPDumXfxdtDnOf3zSKXhTCiVJ0MqsPuOWOBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKGWMVIzindoD6SVdu7DXkEYB0kEHzu7vsAVKSZSfir7W61BK3G0u0hRA1RcvAC6q
         13yVbOL3g+HcmO+qmLQqqbwuVgMgj+6f7lSKt/oxaa7LtrQterrM8qVOKvzApme69h
         oVfAZBB1D1bAkYw6+MExvasVd2usZ3ra8ftNtBbQ=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E19FF60954;
        Fri, 18 Jan 2019 18:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547836685;
        bh=6JuJxs4HPDumXfxdtDnOf3zSKXhTCiVJ0MqsPuOWOBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jpxCEJsfXXPjI19fWPaO5oIOE+l7KMKNaLud35HMONgFDsj5BPzIr8gZhVauTs4sv
         2UJlkj+eJ9OKImHhQ6jyhDtxBnLgCdwvi7nqe5EGPNd2G2bYu6t34ie2jczEGHUYt2
         ySWwnDm0ZBxJiSaeZBfbWo8hhofA9Tw+AFDCDg1g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E19FF60954
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
Subject: [PATCH 4/4] staging: android: ion: Support for mapping with dma mapping attributes
Date:   Fri, 18 Jan 2019 10:37:47 -0800
Message-Id: <1547836667-13695-5-git-send-email-lmark@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for configuring dma mapping attributes when mapping
and unmapping memory through dma_buf_map_attachment and
dma_buf_unmap_attachment.

For example this will allow ION clients to skip cache maintenance, by
using DMA_ATTR_SKIP_CPU_SYNC, for buffers which are clean and haven't been
accessed by the CPU.

Signed-off-by: Liam Mark <lmark@codeaurora.org>
---
 drivers/staging/android/ion/ion.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 1fe633a7fdba..0aae845b20ba 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -268,8 +268,8 @@ static struct sg_table *ion_map_dma_buf(struct dma_buf_attachment *attachment,
 	table = a->table;
 
 	mutex_lock(&buffer->lock);
-	if (!dma_map_sg(attachment->dev, table->sgl, table->nents,
-			direction)) {
+	if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
+			      direction, attachment->dma_map_attrs)) {
 		mutex_unlock(&buffer->lock);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -287,7 +287,8 @@ static void ion_unmap_dma_buf(struct dma_buf_attachment *attachment,
 	struct ion_buffer *buffer = attachment->dmabuf->priv;
 
 	mutex_lock(&buffer->lock);
-	dma_unmap_sg(attachment->dev, table->sgl, table->nents, direction);
+	dma_unmap_sg_attrs(attachment->dev, table->sgl, table->nents, direction,
+			   attachment->dma_map_attrs);
 	a->dma_mapped = false;
 	mutex_unlock(&buffer->lock);
 }
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project


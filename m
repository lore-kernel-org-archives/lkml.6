Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E510AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A959F2192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198347;
	bh=9/vIXNjYur0fMrot25rWyv4k3CjtT9Ba7PlQfyShXjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uHkuqwOHWrYSxWa1qbTD6WQclSFri0SuK+RPCUZawM4mX7NlWZpW9eUfW+LNYYRxc
	 a+4EfoaI9D8v0wNutyTsnw239olniTxthpsuruxIc3ASpitFXczflmHKAY75Xgn5S1
	 wZ9ApOVngq9LC3CqM2GSsKCRtBPHU6koTcBE552I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfBOCjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:39:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390228AbfBOCKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:10:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95A07222C9;
        Fri, 15 Feb 2019 02:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196615;
        bh=9/vIXNjYur0fMrot25rWyv4k3CjtT9Ba7PlQfyShXjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1YH3pyDzFh6pD3qoNvVNgFW4yUpGgP7/HKLXr83RYk9gkUBie0vyguWufFqYohI6j
         ZGmNFeAowaf0ElBkvmB69ZW/miYh1ZFhkpywXdBCMKqRloqlLD7YsBflb/hSHeqDaB
         K2UOG4vlMCiQQrPGlxz5E07zIJWmAe0aBAXJHo2I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liam Mark <lmark@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.20 47/77] staging: android: ion: Support cpu access during dma_buf_detach
Date:   Thu, 14 Feb 2019 21:08:25 -0500
Message-Id: <20190215020855.176727-47-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Mark <lmark@codeaurora.org>

[ Upstream commit 31eb79db420a3f94c4c45a8c0a05cd30e333f981 ]

Often userspace doesn't know when the kernel will be calling dma_buf_detach
on the buffer.
If userpace starts its CPU access at the same time as the sg list is being
freed it could end up accessing the sg list after it has been freed.

Thread A				Thread B
- DMA_BUF_IOCTL_SYNC IOCT
 - ion_dma_buf_begin_cpu_access
  - list_for_each_entry
					- ion_dma_buf_detatch
					 - free_duped_table
   - dma_sync_sg_for_cpu

Fix this by getting the ion_buffer lock before freeing the sg table memory.

Fixes: 2a55e7b5e544 ("staging: android: ion: Call dma_map_sg for syncing and mapping")
Signed-off-by: Liam Mark <lmark@codeaurora.org>
Acked-by: Laura Abbott <labbott@redhat.com>
Acked-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/android/ion/ion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 99073325b0c0..45c7f829e387 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -237,10 +237,10 @@ static void ion_dma_buf_detatch(struct dma_buf *dmabuf,
 	struct ion_dma_buf_attachment *a = attachment->priv;
 	struct ion_buffer *buffer = dmabuf->priv;
 
-	free_duped_table(a->table);
 	mutex_lock(&buffer->lock);
 	list_del(&a->list);
 	mutex_unlock(&buffer->lock);
+	free_duped_table(a->table);
 
 	kfree(a);
 }
-- 
2.19.1


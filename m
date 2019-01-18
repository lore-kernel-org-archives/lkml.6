Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B9FC5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7220820850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Zolbx6k/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RI2zIGwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfARSiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:38:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35934 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbfARSiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:38:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 14A6560881; Fri, 18 Jan 2019 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547836680;
        bh=PPIHWCIuL9ZdxLrN3TWiV+KHqNtXKzHC+BhUea4ckkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zolbx6k/wUrrQQWxGPn4j2mYjYy9k0rrdUcCO2Xvp3NXBcbTW+2jn5XrJBDx2/ab+
         ryPWsEeDy5yz62GchrNmK4tUFMfazQM9LRxqn4eH/esQovn8+DVGB3E9M3EnyGSjP/
         QREiehQXwhWpxKkqIv7lLQWKPyzKlyzT7sEBg8lk=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6A1EC6079B;
        Fri, 18 Jan 2019 18:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547836679;
        bh=PPIHWCIuL9ZdxLrN3TWiV+KHqNtXKzHC+BhUea4ckkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RI2zIGwE1oO8fnHE44T/8e1zOWTiYG8ESYGHErLgrzczMfI9Ig5PuMaQOt4zjRe60
         tF148m0EV5XWugVt+lg9+TTBIjJbaUOtnap7YVdfEg/5LY1KntGIrQwPKCXQJDKD7l
         ZQZNsdCFjtWcZCL0JYN6HFJapaod0RhOZCahIcJE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A1EC6079B
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
Subject: [PATCH 1/4] staging: android: ion: Support cpu access during dma_buf_detach
Date:   Fri, 18 Jan 2019 10:37:44 -0800
Message-Id: <1547836667-13695-2-git-send-email-lmark@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/staging/android/ion/ion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index a0802de8c3a1..6f5afab7c1a1 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -248,10 +248,10 @@ static void ion_dma_buf_detatch(struct dma_buf *dmabuf,
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
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project


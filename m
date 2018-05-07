Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeEGJ7k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 05:59:40 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40129 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeEGJ7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 05:59:39 -0400
X-Google-Smtp-Source: AB8JxZoE45FVY3KzVcPhHKSsXLDEOg1WMbXa54qN6l16yiU9Q311QjaqVpifNtp+wMkhk5MER6mCLA==
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org
Cc: Jann Horn <jannh@google.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH] tee: shm: fix use-after-free via temporarily dropped reference
Date: Mon,  7 May 2018 11:58:41 +0200
Message-Id: <20180507095841.6452-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

Bump the file's refcount before moving the reference into the fd table,
not afterwards. The old code could drop the file's refcount to zero for a
short moment before calling get_file() via get_dma_buf().

This code can only be triggered on ARM systems that use Linaro's OP-TEE.

Fixes: 967c9cca2cc5 ("tee: generic TEE subsystem")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 556960a1bab3..07d3be6f0780 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -360,9 +360,10 @@ int tee_shm_get_fd(struct tee_shm *shm)
 	if (!(shm->flags & TEE_SHM_DMA_BUF))
 		return -EINVAL;
 
+	get_dma_buf(shm->dmabuf);
 	fd = dma_buf_fd(shm->dmabuf, O_CLOEXEC);
-	if (fd >= 0)
-		get_dma_buf(shm->dmabuf);
+	if (fd < 0)
+		dma_buf_put(shm->dmabuf);
 	return fd;
 }
 
-- 
2.17.0

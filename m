Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933351AbeEWOxT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:53:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55803 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933132AbeEWOxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:53:17 -0400
X-Google-Smtp-Source: AB8JxZp9Ar4Bg9UWrYrkOAc9yHUkFSt+PU8WokNVnNTo//Zk+md39aV6rudYQgCBaxJ7yCTJoBW+HA==
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, Ivan Bornyakov <brnkv.i1@gmail.com>
Subject: [PATCH] nvme: host: core: fix precedence of ternary operator
Date: Wed, 23 May 2018 17:56:11 +0300
Message-Id: <20180523145611.10297-1-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ternary operator have lower precedence then bitwise or, so 'cdw10' was
calculated wrong.

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b070c659391f..1eba9b0cb9dc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1577,7 +1577,7 @@ static int nvme_pr_reserve(struct block_device *bdev, u64 key,
 static int nvme_pr_preempt(struct block_device *bdev, u64 old, u64 new,
 		enum pr_type type, bool abort)
 {
-	u32 cdw10 = nvme_pr_type(type) << 8 | abort ? 2 : 1;
+	u32 cdw10 = nvme_pr_type(type) << 8 | (abort ? 2 : 1);
 	return nvme_pr_command(bdev, cdw10, old, new, nvme_cmd_resv_acquire);
 }
 
@@ -1589,7 +1589,7 @@ static int nvme_pr_clear(struct block_device *bdev, u64 key)
 
 static int nvme_pr_release(struct block_device *bdev, u64 key, enum pr_type type)
 {
-	u32 cdw10 = nvme_pr_type(type) << 8 | key ? 1 << 3 : 0;
+	u32 cdw10 = nvme_pr_type(type) << 8 | (key ? 1 << 3 : 0);
 	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
 }
 
-- 
2.16.1

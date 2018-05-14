Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbeENL1N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:27:13 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35624 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbeENLYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:24:36 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 5/8] ubi: fastmap: Fixup pool sizes for preseeded fastmaps
Date: Mon, 14 May 2018 13:24:19 +0200
Message-Id: <20180514112422.23988-6-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180514112422.23988-1-richard@nod.at>
References: <20180514112422.23988-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A preseeded fastmap has, by definition, no dirty PEBs and therefore all
pools are empty. The creation tool can also not calculate the maximal
pool sizes. This means we have to set them during attach.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/fastmap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index f40cd2b18d4c..0d1274b69274 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -620,8 +620,15 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 
 	pool_size = be16_to_cpu(fmpl->size);
 	wl_pool_size = be16_to_cpu(fmpl_wl->size);
-	fm->max_pool_size = be16_to_cpu(fmpl->max_size);
-	fm->max_wl_pool_size = be16_to_cpu(fmpl_wl->max_size);
+
+	if (fm->flags & UBI_FM_SB_PRESEEDED_FLG) {
+		fm->max_pool_size = ubi->fm_pool.max_size;
+		fm->max_wl_pool_size = ubi->fm_wl_pool.max_size;
+
+	} else {
+		fm->max_pool_size = be16_to_cpu(fmpl->max_size);
+		fm->max_wl_pool_size = be16_to_cpu(fmpl_wl->max_size);
+	}
 
 	if (pool_size > UBI_FM_MAX_POOL_SIZE || pool_size < 0) {
 		ubi_err(ubi, "bad pool size: %i", pool_size);
-- 
2.13.6

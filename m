Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeENLY6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:24:58 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35644 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752570AbeENLYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:24:38 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 7/8] ubi: fastmap: Relax size check
Date: Mon, 14 May 2018 13:24:21 +0200
Message-Id: <20180514112422.23988-8-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180514112422.23988-1-richard@nod.at>
References: <20180514112422.23988-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While attaching via fastmap we verify whether the found fastmap
is as large as we have computed.
With preseeded Fastmaps this assumtion can fail since ubinize cannot
know the total size of the MTD and uses the number if used PEBs for
the calculation.
Therefore the found fastmap might be smaller than the kernel expects.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/fastmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 5ec14fd70c13..262497996954 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -1120,7 +1120,7 @@ int ubi_scan_fastmap(struct ubi_device *ubi, struct ubi_attach_info *ai,
 	}
 
 	fm_size = ubi->leb_size * used_blocks;
-	if (fm_size != ubi->fm_size) {
+	if (fm_size > ubi->fm_size) {
 		ubi_err(ubi, "bad fastmap size: %zi, expected: %zi",
 			fm_size, ubi->fm_size);
 		ret = UBI_BAD_FASTMAP;
-- 
2.13.6

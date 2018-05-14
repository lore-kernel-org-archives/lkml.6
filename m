Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeENLYn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:24:43 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35654 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752576AbeENLYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:24:38 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 8/8] ubi: Fix assert in ubi_wl_init
Date: Mon, 14 May 2018 13:24:22 +0200
Message-Id: <20180514112422.23988-9-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180514112422.23988-1-richard@nod.at>
References: <20180514112422.23988-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple PEBs are used for a fastmap, found_pebs
can be wrong and the assert triggers.

The current approach is broken in two ways:
1. The "continue" in list_for_each_entry() over all fastmap PEBs
   misses the counter at all.
2. When the fastmap changes in size, growing due to a preseeded fastmap
   or shrinking due to new bad blocks, iterating over the current
   fastmap will give wrong numbers. We have to exclude the fastmap size
   at all from the calculation to be able to compare the numbers.
   At this stage we simply have no longer the information whether the
   fastmap changed in size.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/wl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 2052a647220e..7e242f5fac27 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1698,10 +1698,11 @@ int ubi_wl_init(struct ubi_device *ubi, struct ubi_attach_info *ai)
 			if (err)
 				goto out_free;
 		}
-
-		found_pebs++;
 	}
 
+	if (ubi->fm)
+		found_pebs += ubi->fm->used_blocks;
+
 	dbg_wl("found %i PEBs", found_pebs);
 
 	ubi_assert(ubi->good_peb_count == found_pebs);
-- 
2.13.6

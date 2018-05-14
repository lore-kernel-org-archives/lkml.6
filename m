Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeENLYi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:24:38 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:35608 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbeENLYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:24:36 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/8] ubi: fastmap: Handle bad block count for preseeded fastmap case
Date: Mon, 14 May 2018 13:24:18 +0200
Message-Id: <20180514112422.23988-5-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180514112422.23988-1-richard@nod.at>
References: <20180514112422.23988-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the fastmap is preseeded the bad block count is created while
scanning for bad blocks in the PEB fixup code.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/fastmap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index a351860f420a..f40cd2b18d4c 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -692,7 +692,16 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 	}
 
 	ai->mean_ec = div_u64(ai->ec_sum, ai->ec_count);
-	ai->bad_peb_count = be32_to_cpu(fmhdr->bad_peb_count);
+
+	if (fm->flags & UBI_FM_SB_PRESEEDED_FLG) {
+		/* When we have a preseeded Fastmap cannot use the provided bad block number */
+		if (be32_to_cpu(fmhdr->bad_peb_count) != 0) {
+			ubi_err(ubi, "Bad block count in preseeded Fastmap is non-zero");
+			goto fail_bad;
+		}
+	} else {
+		ai->bad_peb_count = be32_to_cpu(fmhdr->bad_peb_count);
+	}
 
 	/* Iterate over all volumes and read their EBA table */
 	for (i = 0; i < be32_to_cpu(fmhdr->vol_count); i++) {
-- 
2.13.6

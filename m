Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 98392C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DD5208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DD5208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935880AbeFMVYF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:24:05 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:45340 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935695AbeFMVYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:24:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id ED503181B504D;
        Wed, 13 Jun 2018 23:24:00 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 02/14] ubi: Fix assert in ubi_wl_init
Date:   Wed, 13 Jun 2018 23:23:32 +0200
Message-Id: <20180613212344.11608-3-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180613212344.11608-1-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
 drivers/mtd/ubi/wl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index f66b3b22f328..6bbb968fe9da 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1695,11 +1695,19 @@ int ubi_wl_init(struct ubi_device *ubi, struct ubi_attach_info *ai)
 			err = erase_aeb(ubi, aeb, sync);
 			if (err)
 				goto out_free;
-		}
 
-		found_pebs++;
+			/*
+			 * If no fastmap is used, all fastmap PEBs will get be
+			 * erased and are member of ai->fastmap.
+			 */
+			if (!ubi->fm)
+				found_pebs++;
+		}
 	}
 
+	if (ubi->fm)
+		found_pebs += ubi->fm->used_blocks;
+
 	dbg_wl("found %i PEBs", found_pebs);
 
 	ubi_assert(ubi->good_peb_count == found_pebs);
-- 
2.13.6


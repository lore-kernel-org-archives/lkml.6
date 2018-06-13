Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 224D3C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FEA208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FEA208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754600AbeFMVYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:24:17 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:45392 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935885AbeFMVYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:24:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 9DEAE18198DC5;
        Wed, 13 Jun 2018 23:24:06 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 10/14] ubi: fastmap: Change a WARN_ON() to ubi_err()
Date:   Wed, 13 Jun 2018 23:23:40 +0200
Message-Id: <20180613212344.11608-11-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180613212344.11608-1-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This WARN_ON() was used while development of fastmap, now
it can be a regular ubi_err().

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/fastmap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index dabeb01af24a..d5506152c9f7 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -949,14 +949,16 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 	ubi_assert(list_empty(&free));
 
 	/*
-	 * If fastmap is leaking PEBs (must not happen), raise a
-	 * fat warning and fall back to scanning mode.
-	 * We do this here because in ubi_wl_init() it's too late
-	 * and we cannot fall back to scanning.
+	 * The orginal purpose of this check was detecting fastmap bugs were
+	 * it missed blocks. Now it helps to detect mis-flashed UBIs.
+	 * E.g. when a fastmap enabled UBI is copied to another target with
+	 * different bad blocks.
 	 */
-	if (WARN_ON(count_fastmap_pebs(ai) != ubi->peb_count -
-		    ai->bad_peb_count - fm->used_blocks))
+	if (count_fastmap_pebs(ai) != ubi->peb_count - ai->bad_peb_count -
+		fm->used_blocks) {
+		ubi_err(ubi, "number of PEBs referenced by fastmap does not match MTD!");
 		goto fail_bad;
+	}
 
 	return 0;
 
-- 
2.13.6


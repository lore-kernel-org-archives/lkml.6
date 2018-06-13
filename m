Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E09A4C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FDF208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FDF208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936064AbeFMV00 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:26:26 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:45376 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935823AbeFMVYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:24:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id DE6F5181B5052;
        Wed, 13 Jun 2018 23:24:03 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 06/14] ubi: fastmap: Handle bad block count for preseeded fastmap case
Date:   Wed, 13 Jun 2018 23:23:36 +0200
Message-Id: <20180613212344.11608-7-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180613212344.11608-1-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the fastmap is preseeded the bad block count is created while
scanning for bad blocks in the PEB fixup code.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/fastmap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
index 279d02874297..69b855b3cf2a 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -725,7 +725,16 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 	}
 
 	ai->mean_ec = div_u64(ai->ec_sum, ai->ec_count);
-	ai->bad_peb_count = be32_to_cpu(fmhdr->bad_peb_count);
+
+	if (fm->flags & UBI_FM_SB_PRESEEDED_FLG) {
+		/* When we have a preseeded Fastmap we cannot use the provided bad block number */
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


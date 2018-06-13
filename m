Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D14E9C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92327208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92327208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754575AbeFMVYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:24:16 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:45368 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935839AbeFMVYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:24:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 339BE181A2BDA;
        Wed, 13 Jun 2018 23:24:04 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 07/14] ubi: fastmap: Fixup pool sizes for preseeded fastmaps
Date:   Wed, 13 Jun 2018 23:23:37 +0200
Message-Id: <20180613212344.11608-8-richard@nod.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180613212344.11608-1-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index 69b855b3cf2a..976d371d7cef 100644
--- a/drivers/mtd/ubi/fastmap.c
+++ b/drivers/mtd/ubi/fastmap.c
@@ -645,8 +645,15 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
 
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


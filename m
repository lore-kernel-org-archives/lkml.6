Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E573FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9E62192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198391;
	bh=RQbOA/2qXbXRj/PnuDPXS1pwUexYP1IRfzbwEV7TUHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zGG/qCiYXfXFb9T26jUf5ze0h73Hk3IBtXSBbPLY/3d+CBi7m+dpHgS3y+XSG82f4
	 Ia5UAcRLQVNkwudn/9YRrSxqcp3VUFl5Ysss8NELxAFyiRTOTZJaWoPSQDAFe+68Hy
	 k3l652j5ccetOyDJ1ikg+S/8J+VERfrzd+u29OOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbfBOCjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:39:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390082AbfBOCKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:10:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F8F5222D4;
        Fri, 15 Feb 2019 02:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196607;
        bh=RQbOA/2qXbXRj/PnuDPXS1pwUexYP1IRfzbwEV7TUHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqzQssBx8ipHGGSL4fRFUrC/zWA00+Kne3aJ9/J1SvYtS/B3qcv3kijxRdSzQGzva
         XFjY+P86HfTj6132NvtxkaAxGGaIJeCsoIf/2pQ+LZt2+yMHgqDNyeiFYdRldztlP0
         Z6GwX+89wcyU/WlUeqUzeickQ2MlrZpBtroq54pQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Snitzer <snitzer@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 42/77] dm: fix clone_bio() to trigger blk_recount_segments()
Date:   Thu, 14 Feb 2019 21:08:20 -0500
Message-Id: <20190215020855.176727-42-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Snitzer <snitzer@redhat.com>

[ Upstream commit 57c36519e4b949f89381053f7283f5d605595b42 ]

DM's clone_bio() now benefits from using bio_trim() by fixing the fact
that clone_bio() wasn't clearing BIO_SEG_VALID like bio_trim() does;
which triggers blk_recount_segments() via bio_phys_segments().

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 63a7c416b224..7138e69d40e0 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1318,7 +1318,7 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 
 	__bio_clone_fast(clone, bio);
 
-	if (unlikely(bio_integrity(bio) != NULL)) {
+	if (bio_integrity(bio)) {
 		int r;
 
 		if (unlikely(!dm_target_has_integrity(tio->ti->type) &&
@@ -1334,11 +1334,7 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 			return r;
 	}
 
-	bio_advance(clone, to_bytes(sector - clone->bi_iter.bi_sector));
-	clone->bi_iter.bi_size = to_bytes(len);
-
-	if (unlikely(bio_integrity(bio) != NULL))
-		bio_integrity_trim(clone);
+	bio_trim(clone, sector - clone->bi_iter.bi_sector, len);
 
 	return 0;
 }
-- 
2.19.1


Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A0218C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A870208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A870208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933230AbeFLHdn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:33:43 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:58180 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754160AbeFLHdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:33:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 967901819E5F1;
        Tue, 12 Jun 2018 09:33:40 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, juergen.lachmann@harman.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH] ubi: Initialize Fastmap checkmapping correctly
Date:   Tue, 12 Jun 2018 09:33:16 +0200
Message-Id: <20180612073316.7131-1-richard@nod.at>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot do it last, otherwithse it will be skipped for dynamic
volumes.

Reported-by: Lachmann, Juergen <juergen.lachmann@harman.com>
Fixes: 34653fd8c46e ("ubi: fastmap: Check each mapping only once")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/vtbl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/ubi/vtbl.c b/drivers/mtd/ubi/vtbl.c
index 94d7a865b135..7504f430c011 100644
--- a/drivers/mtd/ubi/vtbl.c
+++ b/drivers/mtd/ubi/vtbl.c
@@ -579,6 +579,16 @@ static int init_volumes(struct ubi_device *ubi,
 		reserved_pebs += vol->reserved_pebs;
 
 		/*
+		 * We use ubi->peb_count and not vol->reserved_pebs because
+		 * we want to keep the code simple. Otherwise we'd have to
+		 * resize/check the bitmap upon volume resize too.
+		 * Allocating a few bytes more does not hurt.
+		 */
+		err = ubi_fastmap_init_checkmap(vol, ubi->peb_count);
+		if (err)
+			return err;
+
+		/*
 		 * In case of dynamic volume UBI knows nothing about how many
 		 * data is stored there. So assume the whole volume is used.
 		 */
@@ -620,16 +630,6 @@ static int init_volumes(struct ubi_device *ubi,
 			(long long)(vol->used_ebs - 1) * vol->usable_leb_size;
 		vol->used_bytes += av->last_data_size;
 		vol->last_eb_bytes = av->last_data_size;
-
-		/*
-		 * We use ubi->peb_count and not vol->reserved_pebs because
-		 * we want to keep the code simple. Otherwise we'd have to
-		 * resize/check the bitmap upon volume resize too.
-		 * Allocating a few bytes more does not hurt.
-		 */
-		err = ubi_fastmap_init_checkmap(vol, ubi->peb_count);
-		if (err)
-			return err;
 	}
 
 	/* And add the layout volume */
-- 
2.13.6


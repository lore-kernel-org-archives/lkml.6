Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A896AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 00:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3423321760
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 00:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3423321760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbeHUDmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 23:42:47 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:16232 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbeHUDmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 23:42:47 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 3C1D0103A1B746452CEC;
        Tue, 21 Aug 2018 08:24:57 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w7L0OsKw014309;
        Tue, 21 Aug 2018 08:24:54 +0800 (GMT-8)
        (envelope-from liu.song11@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018082108245706-5358268 ;
          Tue, 21 Aug 2018 08:24:57 +0800 
From:   Liu Song <liu.song11@zte.com.cn>
To:     dedekind1@gmail.com, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        liu.song11@zte.com.cn, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: [PATCH v2] mtd/ubi: Make sure to read volume record from LEB 0 or LEB 1
Date:   Tue, 21 Aug 2018 08:22:38 +0800
Message-Id: <1534810958-178116-1-git-send-email-liu.song11@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-21 08:24:57,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-21 08:24:51,
        Serialize complete at 2018-08-21 08:24:51
X-MAIL: mse01.zte.com.cn w7L0OsKw014309
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though we protect on-flash data by CRC checksums,
we still don't trust the media. If lnum is not 0 or 1,
access exceed array boundary can lead to bad situation.

Signed-off-by: Liu Song <liu.song11@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
v2: fix the name in *From*.

 drivers/mtd/ubi/vtbl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/ubi/vtbl.c b/drivers/mtd/ubi/vtbl.c
index 94d7a86..64a2937 100644
--- a/drivers/mtd/ubi/vtbl.c
+++ b/drivers/mtd/ubi/vtbl.c
@@ -410,6 +410,10 @@ static struct ubi_vtbl_record *process_lvol(struct ubi_device *ubi,
 
 	/* Read both LEB 0 and LEB 1 into memory */
 	ubi_rb_for_each_entry(rb, aeb, &av->root, u.rb) {
+		if (aeb->lnum != 0 && aeb->lnum != 1) {
+			ubi_warn(ubi, "volume store in LEB %d", aeb->lnum);
+			continue;
+		}
 		leb[aeb->lnum] = vzalloc(ubi->vtbl_size);
 		if (!leb[aeb->lnum]) {
 			err = -ENOMEM;
-- 
2.1.0.GIT


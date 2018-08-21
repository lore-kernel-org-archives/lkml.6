Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DEAC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 03:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4992151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 03:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4992151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeHUGhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 02:37:31 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:45088 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725734AbeHUGhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 02:37:31 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 5FA5C438120F78E34551;
        Tue, 21 Aug 2018 11:19:14 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w7L3J9xW058952;
        Tue, 21 Aug 2018 11:19:09 +0800 (GMT-8)
        (envelope-from liu.song11@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018082111191213-5392430 ;
          Tue, 21 Aug 2018 11:19:12 +0800 
From:   Liu Song <liu.song11@zte.com.cn>
To:     richard@nod.at, dedekind1@gmail.com, adrian.hunter@intel.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        liu.song11@zte.com.cn, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: [PATCH] ubifs: remove unnecessary check in ubifs_log_start_commit
Date:   Tue, 21 Aug 2018 11:17:22 +0800
Message-Id: <1534821442-178518-1-git-send-email-liu.song11@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-21 11:19:12,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-21 11:19:05,
        Serialize complete at 2018-08-21 11:19:05
X-MAIL: mse01.zte.com.cn w7L3J9xW058952
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of c->lhead_offs cannot exceed max_len which much
smaller than c->leb_size. So the check will never be true.
Just remove it.

Signed-off-by: Liu Song <liu.song11@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 fs/ubifs/log.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ubifs/log.c b/fs/ubifs/log.c
index 7cffa120a750..5a338737223b 100644
--- a/fs/ubifs/log.c
+++ b/fs/ubifs/log.c
@@ -427,10 +427,6 @@ int ubifs_log_start_commit(struct ubifs_info *c, int *ltail_lnum)
 	*ltail_lnum = c->lhead_lnum;
 
 	c->lhead_offs += len;
-	if (c->lhead_offs == c->leb_size) {
-		c->lhead_lnum = ubifs_next_log_lnum(c, c->lhead_lnum);
-		c->lhead_offs = 0;
-	}
 
 	remove_buds(c);
 
-- 
2.17.1


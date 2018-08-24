Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F46C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E118321557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E118321557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeHXEue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 00:50:34 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:60294 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbeHXEud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 00:50:33 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id E334AAC401FE62B0ABDB;
        Fri, 24 Aug 2018 09:18:15 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w7O1I9Fp087795;
        Fri, 24 Aug 2018 09:18:09 +0800 (GMT-8)
        (envelope-from liu.song11@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018082409181718-5941213 ;
          Fri, 24 Aug 2018 09:18:17 +0800 
From:   Liu Song <liu.song11@zte.com.cn>
To:     richard@nod.at, dedekind1@gmail.com, adrian.hunter@intel.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        liu.song11@zte.com.cn, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: [PATCH v2] ubifs: remove unnecessary check in ubifs_log_start_commit
Date:   Fri, 24 Aug 2018 09:15:45 +0800
Message-Id: <1535073345-88009-1-git-send-email-liu.song11@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-24 09:18:17,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-24 09:17:54,
        Serialize complete at 2018-08-24 09:17:54
X-MAIL: mse01.zte.com.cn w7O1I9Fp087795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ubifs_log_start_commit, the value of c->lhead_offs is zero or set
to zero by code bellow.

	/* Switch to the next log LEB */
	if (c->lhead_offs) {
		c->lhead_lnum = ubifs_next_log_lnum(c, c->lhead_lnum);
		ubifs_assert(c->lhead_lnum != c->ltail_lnum);
		c->lhead_offs = 0;
	}

The value of 'len' can not exceed 'max_len' which assigned value by
code bellow.

	max_len = UBIFS_CS_NODE_SZ + c->jhead_cnt * UBIFS_REF_NODE_SZ;

The value of c->lhead_offs changed by code bellow and cannot exceed
'max_len'.

	c->lhead_offs += len;
	if (c->lhead_offs == c->leb_size) {
		c->lhead_lnum = ubifs_next_log_lnum(c, c->lhead_lnum);
		c->lhead_offs = 0;
	}

Usually, the size of PEB is between 64KB and 256KB. So the value of
c->lhead_offs is far less than c->leb_size. The check 
'if (c->lhead_offs == c->leb_size)' could never to be true.

Signed-off-by: Liu Song <liu.song11@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
v2: Improve description and code as suggestted by Richard.

 fs/ubifs/log.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ubifs/log.c b/fs/ubifs/log.c
index 7cffa12..78afb78 100644
--- a/fs/ubifs/log.c
+++ b/fs/ubifs/log.c
@@ -427,10 +427,7 @@ int ubifs_log_start_commit(struct ubifs_info *c, int *ltail_lnum)
 	*ltail_lnum = c->lhead_lnum;
 
 	c->lhead_offs += len;
-	if (c->lhead_offs == c->leb_size) {
-		c->lhead_lnum = ubifs_next_log_lnum(c, c->lhead_lnum);
-		c->lhead_offs = 0;
-	}
+	ubifs_assert(c->lhead_offs < c->leb_size);
 
 	remove_buds(c);
 
-- 
2.1.0.GIT


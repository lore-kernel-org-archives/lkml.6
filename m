Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BA6C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369AB208DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369AB208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeGDOCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:02:39 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:52062 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbeGDOCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:02:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 3F58F18186370;
        Wed,  4 Jul 2018 16:02:37 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH] ubifs: Handle LPT corruption better in ubifs_garbage_collect_leb()
Date:   Wed,  4 Jul 2018 16:02:30 +0200
Message-Id: <20180704140230.5606-1-richard@nod.at>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If ubifs_garbage_collect_leb() notes a LPT problem, empty LEB, but
LPT has it makred as used, an ubifs_assert() is not enough.
We have to abort GC. Otherwise list_entry() returns an invalid
scan object and the kernel crashes.

c: <stable@vger.kernel.org>
Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/gc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
index a03a47cf880d..11c09ce3c795 100644
--- a/fs/ubifs/gc.c
+++ b/fs/ubifs/gc.c
@@ -513,7 +513,13 @@ int ubifs_garbage_collect_leb(struct ubifs_info *c, struct ubifs_lprops *lp)
 	if (IS_ERR(sleb))
 		return PTR_ERR(sleb);
 
-	ubifs_assert(!list_empty(&sleb->nodes));
+	if (list_empty(&sleb->nodes)) {
+		ubifs_err(c, "Bad accouting information, LEB %i is marked as used but no nodes found!",
+			  lnum);
+		dump_stack();
+		return -EUCLEAN;
+	}
+
 	snod = list_entry(sleb->nodes.next, struct ubifs_scan_node, list);
 
 	if (snod->type == UBIFS_IDX_NODE) {
-- 
2.18.0


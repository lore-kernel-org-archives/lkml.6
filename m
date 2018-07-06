Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D83DC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D4522BD3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yBD0ksqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D4522BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeGFVJM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753630AbeGFVJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:09:06 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A73022BD3;
        Fri,  6 Jul 2018 21:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530911345;
        bh=TRlVdaCsB8gZK2AQsBxYaO4yqUH0/ljnJBZ5tmFqYz4=;
        h=From:To:Cc:Subject:Date:From;
        b=yBD0ksqUwBXc7kPUSSwK3kyhDb0xVVSk2Eucjzr3Aq9gU3ZSN8uZnyVPlAbrjdVzK
         gvXZjz2h3A4dq+k6mgCfpEl9xzx/3kgVPMe5s0b4oEwRwfrVsGFPv3Ob5a1TQlj62j
         p+dKRl56INEeSfmN6PzOZj1cAbGICPZW8nGOj2rQ=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs: flush journal nat entries for nat_bits during unmount
Date:   Fri,  6 Jul 2018 14:09:00 -0700
Message-Id: <20180706210903.77887-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's flush journal nat entries for speed up in the next run.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 29237aeca041..0f076fb0d828 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2613,6 +2613,13 @@ void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	nid_t set_idx = 0;
 	LIST_HEAD(sets);
 
+	/* during unmount, let's flush nat_bits before checking dirty_nat_cnt */
+	if (enabled_nat_bits(sbi, cpc)) {
+		down_write(&nm_i->nat_tree_lock);
+		remove_nats_in_journal(sbi);
+		up_write(&nm_i->nat_tree_lock);
+	}
+
 	if (!nm_i->dirty_nat_cnt)
 		return;
 
-- 
2.17.0.441.gb46fe60e1d-goog


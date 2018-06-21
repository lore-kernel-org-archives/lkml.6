Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7880BC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D762219A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD4p1JbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D762219A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbeFUSFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752650AbeFUSFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:05:20 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE8652199D;
        Thu, 21 Jun 2018 18:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529604320;
        bh=QlKvFfMSBgsbMyfNDYdmUrTncJImvRb0WNtgQrjQW6o=;
        h=From:To:Cc:Subject:Date:From;
        b=fD4p1JbXGYFMtdOJw4iUADv/cA0qsbpkvr8te+TfLlu3ExKqHFpia363XR4HnuBjN
         JH5umt5hdqIH3rKHgWNYb7KCg6NvPRvS9EipW+p66E6NB4Nlo+EdBOGMPS5TSVsdwM
         5Tv5d4cbjv04uBpWk3YpzGvwkqtZ5qzSOMbKLGPk=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: don't issue discard commands in online discard is on
Date:   Thu, 21 Jun 2018 11:05:18 -0700
Message-Id: <20180621180518.76856-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, we don't need to issue discard commands, if discard is on, as
mentioned in the comment.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6dbdf2c48fba..553075973be4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2469,23 +2469,24 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 	if (err)
 		goto out;
 
-	start_block = START_BLOCK(sbi, start_segno);
-	end_block = START_BLOCK(sbi, end_segno + 1);
-
-	__init_discard_policy(sbi, &dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
-	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
-
 	/*
 	 * We filed discard candidates, but actually we don't need to wait for
 	 * all of them, since they'll be issued in idle time along with runtime
 	 * discard option. User configuration looks like using runtime discard
 	 * or periodic fstrim instead of it.
 	 */
-	if (!test_opt(sbi, DISCARD)) {
-		trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
+	if (test_opt(sbi, DISCARD))
+		goto out;
+
+	start_block = START_BLOCK(sbi, start_segno);
+	end_block = START_BLOCK(sbi, end_segno + 1);
+
+	__init_discard_policy(sbi, &dpolicy, DPOLICY_FSTRIM, cpc.trim_minlen);
+	__issue_discard_cmd_range(sbi, &dpolicy, start_block, end_block);
+
+	trimmed = __wait_discard_cmd_range(sbi, &dpolicy,
 					start_block, end_block);
-		range->len = F2FS_BLK_TO_BYTES(trimmed);
-	}
+	range->len = F2FS_BLK_TO_BYTES(trimmed);
 out:
 	return err;
 }
-- 
2.17.0.441.gb46fe60e1d-goog


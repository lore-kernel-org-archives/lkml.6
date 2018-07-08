Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11793C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95AB208CC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdZLLXrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95AB208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753760AbeGHOIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 10:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbeGHOIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 10:08:37 -0400
Received: from localhost.localdomain (unknown [49.77.239.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 895C620870;
        Sun,  8 Jul 2018 14:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531058916;
        bh=IDtQJgykS/DqNwNfcuC/B3VotMAW2ssyOTEHrTwrarU=;
        h=From:To:Cc:Subject:Date:From;
        b=EdZLLXrd8n67cNRy5OuCYGQ6BciYKpSE8NXsHo1WCT2Ber30cf8fgbMGBjGaJ7Wfm
         tLUsx2JIzjW72aWDN1cMdMJ+vQCmxhzlGCadFG0jKl8uNaNW/uCOJ+x/sp1oIhdh4B
         Qrj9IRDqZQdbH8I8Jb+bivG82wW4F1AVfKoA9res=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: stop issuing discard immediately if there is queued IO
Date:   Sun,  8 Jul 2018 22:08:09 +0800
Message-Id: <20180708140809.23571-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

For background discard policy, even if there is queued user IO, still
we will check max_requests times for next discard entry, it is unneeded,
let's just stop this round submission immediately.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 99beaf0a2dea..aee198869b1f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1190,7 +1190,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	struct list_head *pend_list;
 	struct discard_cmd *dc, *tmp;
 	struct blk_plug plug;
-	int i, iter = 0, issued = 0;
+	int i, issued = 0;
 	bool io_interrupted = false;
 
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
@@ -1211,20 +1211,19 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
 								!is_idle(sbi)) {
 				io_interrupted = true;
-				goto skip;
+				break;
 			}
 
 			__submit_discard_cmd(sbi, dpolicy, dc);
-			issued++;
-skip:
-			if (++iter >= dpolicy->max_requests)
+
+			if (++issued >= dpolicy->max_requests)
 				break;
 		}
 		blk_finish_plug(&plug);
 next:
 		mutex_unlock(&dcc->cmd_lock);
 
-		if (iter >= dpolicy->max_requests)
+		if (issued >= dpolicy->max_requests || io_interrupted)
 			break;
 	}
 
-- 
2.16.2.17.g38e79b1fd


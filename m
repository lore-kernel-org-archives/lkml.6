Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106C8C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF61F21479
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 05:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544763696;
	bh=Tpzrwyk0FRh7zMpjqK9YCm+lq4Jj9gYQXggiSPATu/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P3IQs7d58HzXJG0BKS7sVHZMqEenclDbIFWbxePjiQdzd8fVZyGz8kZANwwce/FlQ
	 BYOi5Nk4IxtLucbr8RVyIVAFM3gFkTo01iPxfAeBKDcjQIUAxVKe4nM+Hjib/PL8lK
	 EER2Zmcg1S8b3ZrQ7Af062KWUWZrnbmBlhMyspMY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF61F21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbeLNFBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 00:01:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbeLNFBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 00:01:30 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63E6820892;
        Fri, 14 Dec 2018 05:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544763690;
        bh=Tpzrwyk0FRh7zMpjqK9YCm+lq4Jj9gYQXggiSPATu/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CvVlj0OXUsNPwNEl7qGBuMoMyi3JweAaj81fFn7OlM8EAZ5u+srvhVKjqO4ygEh+C
         6Ru9VJ7em/f/XZa7YmcgHdaYBSyUAAUCs6d3DP+0etU8gYSEk3us15s5b6UHTqZAJL
         NFd6lng3ZsMVc1mytCJyrYFrf7YPaFEk08g6QdUA=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: flush stale issued discard candidates
Date:   Thu, 13 Dec 2018 21:01:27 -0800
Message-Id: <20181214050127.45025-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181214050127.45025-1-jaegeuk@kernel.org>
References: <20181214050127.45025-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, I could observe # of issuing_discard to be 1 which blocks background
jobs due to is_idle()=false.
The only way to get out of it was to trigger gc_urgent. This patch avoids that
by checking any candidates as done in the list.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 49ea9009ab5a..acbbc924e518 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1651,6 +1651,10 @@ static int issue_discard_thread(void *data)
 		if (dcc->discard_wake)
 			dcc->discard_wake = 0;
 
+		/* clean up pending candidates before going to sleep */
+		if (atomic_read(&dcc->queued_discard))
+			__wait_all_discard_cmd(sbi, NULL);
+
 		if (try_to_freeze())
 			continue;
 		if (f2fs_readonly(sbi->sb))
-- 
2.19.0.605.g01d371f741-goog


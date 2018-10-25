Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E1AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC2820868
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV/UVvlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC2820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbeJYWwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbeJYWv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:51:59 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5C6120848;
        Thu, 25 Oct 2018 14:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477142;
        bh=pHsw4aAj1soAzow5yxAcRacW7YtrQo/D1v8/ifgA84Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WV/UVvlkT49Hw6SO5Z2xS9YomkpzzFUEtMIY5YVTrbZ2KwqyzV0EvtZ0BnlPM5Osj
         gFMh0SMgTqFk5bbo1ziPTYwBEpWHizv7qWsvIqjbLq1Vutwa+Pxp2avJ5OtBdRyCR3
         brTSWlhYUPQKiQ1cH7KbmWxaFl24MJ1XyCKdXu+E=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     alex chen <alex.chen@huawei.com>, Joel Becker <jlbec@evilplan.org>,
        Mark Fasheh <mfasheh@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 02/98] ocfs2: fix journal commit deadlock in ocfs2_convert_inline_data_to_extents
Date:   Thu, 25 Oct 2018 10:17:17 -0400
Message-Id: <20181025141853.214051-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: alex chen <alex.chen@huawei.com>

[ Upstream commit 15eba0fe3eeaeb1b80489c1ebb9d47d6d7003f57 ]

Similar to ocfs2_write_end_nolock() which is metioned at commit
136f49b91710 ("ocfs2: fix journal commit deadlock"), we should unlock
pages before ocfs2_commit_trans() in ocfs2_convert_inline_data_to_extents.

Otherwise, it will cause a deadlock with journal commit threads.

Signed-off-by: Alex Chen <alex.chen@huawei.com>
Reviewed-by: Joseph Qi <joseph.qi@huawei.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Mark Fasheh <mfasheh@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/alloc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index d9db90446c9d..3564b896a92e 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -6871,7 +6871,7 @@ int ocfs2_convert_inline_data_to_extents(struct inode *inode,
 	if (IS_ERR(handle)) {
 		ret = PTR_ERR(handle);
 		mlog_errno(ret);
-		goto out_unlock;
+		goto out;
 	}
 
 	ret = ocfs2_journal_access_di(handle, INODE_CACHE(inode), di_bh,
@@ -6929,7 +6929,7 @@ int ocfs2_convert_inline_data_to_extents(struct inode *inode,
 		if (ret) {
 			mlog_errno(ret);
 			need_free = 1;
-			goto out_commit;
+			goto out_unlock;
 		}
 
 		page_end = PAGE_CACHE_SIZE;
@@ -6962,12 +6962,16 @@ int ocfs2_convert_inline_data_to_extents(struct inode *inode,
 		if (ret) {
 			mlog_errno(ret);
 			need_free = 1;
-			goto out_commit;
+			goto out_unlock;
 		}
 
 		inode->i_blocks = ocfs2_inode_sector_count(inode);
 	}
 
+out_unlock:
+	if (pages)
+		ocfs2_unlock_and_free_pages(pages, num_pages);
+
 out_commit:
 	if (ret < 0 && did_quota)
 		dquot_free_space_nodirty(inode,
@@ -6987,15 +6991,11 @@ int ocfs2_convert_inline_data_to_extents(struct inode *inode,
 
 	ocfs2_commit_trans(osb, handle);
 
-out_unlock:
+out:
 	if (data_ac)
 		ocfs2_free_alloc_context(data_ac);
-
-out:
-	if (pages) {
-		ocfs2_unlock_and_free_pages(pages, num_pages);
+	if (pages)
 		kfree(pages);
-	}
 
 	return ret;
 }
-- 
2.17.1


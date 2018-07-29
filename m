Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4692BC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 04:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF02F20870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 04:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS65S2Yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF02F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbeG2Fqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 01:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbeG2Fqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 01:46:54 -0400
Received: from localhost.localdomain (unknown [180.111.102.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 233B520870;
        Sun, 29 Jul 2018 04:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532837877;
        bh=P8hgaICj+HdVFp+aDFifcKkfopLSUnSVCp/LmThKpKs=;
        h=From:To:Cc:Subject:Date:From;
        b=QS65S2YjWs7USYkZj0qaxORmkrP2Y6ZOsjCQbqR9/Qkf2UNNOMT+Iv8ZaMiFJjQqp
         PAyD3kz/467vGMA+A8nLs0gY9Vjj5esa1y+k1T/7fCulevpn1bmNFD/c6V8dEUV4DF
         txKRy9s072xkvzqxi0DDQc2EP6jF8N/x1yuPctzM=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Weichao Guo <guoweichao@huawei.com>
Subject: [PATCH] f2fs: fix to clear PG_checked flag in set_page_dirty()
Date:   Sun, 29 Jul 2018 12:16:59 +0800
Message-Id: <20180729041659.19420-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

PG_checked flag will be set on data page during GC, later, we can
recognize such page by the flag and migrate page to cold segment.

But previously, we don't clear this flag when invalidating data page,
after page redirtying, we will write it into wrong log.

Let's clear PG_checked flag in set_page_dirty() to avoid this.

Signed-off-by: Weichao Guo <guoweichao@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bac667831052..eb994c66fe66 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2549,6 +2549,10 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 
+	/* don't remain PG_checked flag which was set during GC */
+	if (is_cold_data(page))
+		clear_cold_data(page);
+
 	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
 		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
 			f2fs_register_inmem_page(inode, page);
-- 
2.18.0


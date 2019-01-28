Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBBEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59C82082C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693552;
	bh=9o9+Siai116CY/TijCI5icA5JXF/lj8LoOUXWJ+pvrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Lep8rt3raCbLDzVVdo5xmYBBRN+PeoMtwmE/Xebnz7nAxPUiT1q4cr3wv9p+qfOg
	 teBw26e3cCXwV1LtyWx81Ob7geTIhyiEVEvUcs9F+iucq38yv9iukjYRjHeeBt1wV7
	 55+XJ/YvkFwvGPB3qMpceWnllvR3tEz5B2Zg828o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389753AbfA1QYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:24:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389738AbfA1QYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:24:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCE272147A;
        Mon, 28 Jan 2019 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692673;
        bh=9o9+Siai116CY/TijCI5icA5JXF/lj8LoOUXWJ+pvrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DGusKVbH2kwr3JnDK1cCQNDy6WKtqVDHrIjp025rRfNroTEFr0cPzC1Ltgloyqf6O
         T/hhoWuBFRN+NTGlsgwpV3EsVLTEwaZ+AFEtjLi1ki5m+cOwr+EVT8OTOXfX/DRVh4
         3AE1dMOpq2Z7KxOyhiwttEXLIrUEydemErxm+clQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tiezhu Yang <kernelpatch@126.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.4 21/80] f2fs: fix wrong return value of f2fs_acl_create
Date:   Mon, 28 Jan 2019 11:23:02 -0500
Message-Id: <20190128162401.58841-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162401.58841-1-sashal@kernel.org>
References: <20190128162401.58841-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <kernelpatch@126.com>

[ Upstream commit f6176473a0c7472380eef72ebeb330cf9485bf0a ]

When call f2fs_acl_create_masq() failed, the caller f2fs_acl_create()
should return -EIO instead of -ENOMEM, this patch makes it consistent
with posix_acl_create() which has been fixed in commit beaf226b863a
("posix_acl: don't ignore return value of posix_acl_create_masq()").

Fixes: 83dfe53c185e ("f2fs: fix reference leaks in f2fs_acl_create")
Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/acl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 83dcf7bfd7b8..f0ea91925343 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -350,12 +350,14 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
 		return PTR_ERR(p);
 
 	clone = f2fs_acl_clone(p, GFP_NOFS);
-	if (!clone)
-		goto no_mem;
+	if (!clone) {
+		ret = -ENOMEM;
+		goto release_acl;
+	}
 
 	ret = f2fs_acl_create_masq(clone, mode);
 	if (ret < 0)
-		goto no_mem_clone;
+		goto release_clone;
 
 	if (ret == 0)
 		posix_acl_release(clone);
@@ -369,11 +371,11 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
 
 	return 0;
 
-no_mem_clone:
+release_clone:
 	posix_acl_release(clone);
-no_mem:
+release_acl:
 	posix_acl_release(p);
-	return -ENOMEM;
+	return ret;
 }
 
 int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
-- 
2.19.1


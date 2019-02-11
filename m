Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB56C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFD521B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898420;
	bh=MXBCZJUlaLgLnuEiJIM0Ke3cA2GhbR9MaTK17IlgMYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sWRKzfofL5arGreV2ku+3EeNFSEJDqGJEDemMtLKl2oJW4h8zQN0wCMV4aaS/9M3K
	 /khS2n8rdoo17Xks79kktOpwAFgLrJyzdOxIbHaJJopoLabOByaSr9edde/tGJDGlP
	 ZIVsz+yqEOjnVoWtKSwonU+j4oeuOvg4ndypPB8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390995AbfBKPF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:05:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390009AbfBKPFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:05:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79572222A7;
        Mon, 11 Feb 2019 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897522;
        bh=MXBCZJUlaLgLnuEiJIM0Ke3cA2GhbR9MaTK17IlgMYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2tg41F4Q6tyyLP1XO6GMrhJwgYcwGh/8c/cg+jmOqA2CcqDdau79MPNzMjEI/AXEF
         iht2Du9bzCbuy29A2R9incMBSH5RxuzuvViWurkyjlf8EgHDodwSvlvp6DdAB8+4rf
         44DotQOm5KrABh9GTKFgEY+Xz4yLcEMFkjcM346Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiezhu Yang <kernelpatch@126.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 026/137] f2fs: fix wrong return value of f2fs_acl_create
Date:   Mon, 11 Feb 2019 15:18:27 +0100
Message-Id: <20190211141814.375411788@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 55aa29c0c78d..a9894089d9dc 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -348,12 +348,14 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
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
@@ -367,11 +369,11 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
 
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




Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A1BECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CDE21479
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKFelYWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CDE21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbeJYWx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730386AbeJYWxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:55 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CB10214ED;
        Thu, 25 Oct 2018 14:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477257;
        bh=leyCJ8JPbvjvU1MqH+dq3Knrq/O28mba7F+CXLOq6uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FKFelYWlmRCisLz0W3mjO6190DAHf3IRMJ0tpXXsdJ6tP85J6UKUb0NS88fwlIfoj
         UT9uCH6wcqvELvfbn5WOuyBgpDwTvJ6mScAzNwP4Svs5WxWCJIp2i7cPp8Y9nB8FUS
         SNh6bxDAVRaM0sCu+DI0uACOP8QSTiPLbP2yU7Lc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 81/98] Btrfs: do not ignore errors from btrfs_lookup_xattr in do_setxattr
Date:   Thu, 25 Oct 2018 10:18:36 -0400
Message-Id: <20181025141853.214051-81-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 5cdf83edb8e41cad1ec8eab2d402b4f9d9eb7ee0 ]

The return value from btrfs_lookup_xattr() can be a pointer encoding an
error, therefore deal with it. This fixes commit 5f5bc6b1e2d5
("Btrfs: make xattr replace operations atomic").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/xattr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index fbb0533e977f..de5d69a63e3f 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -111,6 +111,8 @@ static int do_setxattr(struct btrfs_trans_handle *trans,
 					name, name_len, -1);
 		if (!di && (flags & XATTR_REPLACE))
 			ret = -ENODATA;
+		else if (IS_ERR(di))
+			ret = PTR_ERR(di);
 		else if (di)
 			ret = btrfs_delete_one_dir_name(trans, root, path, di);
 		goto out;
@@ -127,10 +129,12 @@ static int do_setxattr(struct btrfs_trans_handle *trans,
 		ASSERT(mutex_is_locked(&inode->i_mutex));
 		di = btrfs_lookup_xattr(NULL, root, path, btrfs_ino(inode),
 					name, name_len, 0);
-		if (!di) {
+		if (!di)
 			ret = -ENODATA;
+		else if (IS_ERR(di))
+			ret = PTR_ERR(di);
+		if (ret)
 			goto out;
-		}
 		btrfs_release_path(path);
 		di = NULL;
 	}
-- 
2.17.1


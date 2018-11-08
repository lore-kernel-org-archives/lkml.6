Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633DCECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB4121019
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXg17P9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB4121019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbeKIHdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbeKIHdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:53 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79AA620989;
        Thu,  8 Nov 2018 21:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714185;
        bh=T8hLcoGkrM9HCUpAUGJrHhnx7PDWbP8+reHjbOTT2zU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXg17P9HyAL/NdorW9spqHru/aa7Nd76AF13OSDtudxheAmNyzpyz8HzpsHbv/A7E
         Uj9qVSrtIW2Fh+jwsENxcyYwa035aUHQ6wARhTejCMHa/q/UZmRzA3/lN1x1Lfn+OX
         daRUc38JaMA1VQN7CjFgK9E991bf/5sNe+XhEjp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Chris Mason <clm@fb.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 109/144] Btrfs: do not ignore errors from btrfs_lookup_xattr in do_setxattr
Date:   Thu,  8 Nov 2018 13:51:20 -0800
Message-Id: <20181108215105.755120337@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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




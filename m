Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF11FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EABD2087F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999353;
	bh=3F6NBzr9R+1Xoa8LQJovnhrnZgpjVMO8Lc7mzInUCow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s0dV8WvConGiHYW2k1TfQ+W41E1ASUbU7eM5094i67EOtKEmJliV2Em+vOsBe11PZ
	 Fbkcox4p1okDPPVnkJRn9fBuuL4Eky76dg4oIlhUOxpiZqtpJFMl3luDSgE63UgGdC
	 Vo07ci9wSOIjzs4A2CKYLLfrBaMh4wT1wnqGjaHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732552AbeL1MPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:15:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732539AbeL1MPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:15:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A70342146F;
        Fri, 28 Dec 2018 12:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999350;
        bh=3F6NBzr9R+1Xoa8LQJovnhrnZgpjVMO8Lc7mzInUCow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aEnv3qEv5pznZpfnru8bu3VpEjnasHk+4xEkx8cxgHW+gj6wSf4iSzBziZJ+hAg32
         F+m4l8k4wXiNKii0nAni8gKg2tIWF9e25FBH/gIFzct7w2R8FuQRPjbHu07ueGnj0s
         WFgcr/bAU/+vMADuBR2aa8SyK4H6rZkSu47B+FCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 04/36] ubifs: Fix directory size calculation for symlinks
Date:   Fri, 28 Dec 2018 12:52:20 +0100
Message-Id: <20181228113126.808825407@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 00ee8b60102862f4daf0814d12a2ea2744fc0b9b upstream

We have to account the name of the symlink and not the target length.

Fixes: ca7f85be8d6c ("ubifs: Add support for encrypted symlinks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ubifs/dir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index ef820f803176..4e6e32c0c08a 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1147,8 +1147,7 @@ static int ubifs_symlink(struct inode *dir, struct dentry *dentry,
 	struct ubifs_inode *ui;
 	struct ubifs_inode *dir_ui = ubifs_inode(dir);
 	struct ubifs_info *c = dir->i_sb->s_fs_info;
-	int err, len = strlen(symname);
-	int sz_change = CALC_DENT_SIZE(len);
+	int err, sz_change, len = strlen(symname);
 	struct fscrypt_str disk_link = FSTR_INIT((char *)symname, len + 1);
 	struct fscrypt_symlink_data *sd = NULL;
 	struct ubifs_budget_req req = { .new_ino = 1, .new_dent = 1,
@@ -1189,6 +1188,8 @@ static int ubifs_symlink(struct inode *dir, struct dentry *dentry,
 	if (err)
 		goto out_budg;
 
+	sz_change = CALC_DENT_SIZE(fname_len(&nm));
+
 	inode = ubifs_new_inode(c, dir, S_IFLNK | S_IRWXUGO);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
-- 
2.19.1




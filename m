Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF08C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193082146F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDv25ilO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193082146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbeKZVwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:52:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbeKZVwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:52:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 380F920817;
        Mon, 26 Nov 2018 10:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229933;
        bh=n2qdwHn0fdICCvhig6j8DPvKrfLjveBAVmnlF0paWyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JDv25ilOHfm1bt5aX0kuqm17Op7n0D/mTMH8Tx+jzKeQ9eH6I2KXW8hMk5cvV+xT4
         9r1DchMzV7kP1NyzcSR/eydRv/XqRZXN9stRMDFxUbqYY2ao28X04sXdHIeFSgV4nu
         Zo08/JguKETS0T+GYGRs0INoa8ozkcYzwLdDrDgI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 01/62] cifs: dont dereference smb_file_target before null check
Date:   Mon, 26 Nov 2018 11:50:42 +0100
Message-Id: <20181126105051.013117079@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8c6c9bed8773375b1d54ccca2911ec892c59db5d ]

There is a null check on dst_file->private data which suggests
it can be potentially null. However, before this check, pointer
smb_file_target is derived from dst_file->private and dereferenced
in the call to tlink_tcon, hence there is a potential null pointer
deference.

Fix this by assigning smb_file_target and target_tcon after the
null pointer sanity checks.

Detected by CoverityScan, CID#1475302 ("Dereference before null check")

Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 44a7b2dea688..c5fd5abf7206 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -933,8 +933,8 @@ static int cifs_clone_file_range(struct file *src_file, loff_t off,
 	struct inode *src_inode = file_inode(src_file);
 	struct inode *target_inode = file_inode(dst_file);
 	struct cifsFileInfo *smb_file_src = src_file->private_data;
-	struct cifsFileInfo *smb_file_target = dst_file->private_data;
-	struct cifs_tcon *target_tcon = tlink_tcon(smb_file_target->tlink);
+	struct cifsFileInfo *smb_file_target;
+	struct cifs_tcon *target_tcon;
 	unsigned int xid;
 	int rc;
 
@@ -948,6 +948,9 @@ static int cifs_clone_file_range(struct file *src_file, loff_t off,
 		goto out;
 	}
 
+	smb_file_target = dst_file->private_data;
+	target_tcon = tlink_tcon(smb_file_target->tlink);
+
 	/*
 	 * Note: cifs case is easier than btrfs since server responsible for
 	 * checks for proper open modes and file type and if it wants
-- 
2.17.1




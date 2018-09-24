Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBE6C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85D1208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:18:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85D1208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbeIXSUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:20:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56168 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbeIXSUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:20:35 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D54161087;
        Mon, 24 Sep 2018 12:18:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 112/173] vfs: fix freeze protection in mnt_want_write_file() for overlayfs
Date:   Mon, 24 Sep 2018 13:52:26 +0200
Message-Id: <20180924113124.279800352@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit a6795a585929d94ca3e931bc8518f8deb8bbe627 ]

The underlying real file used by overlayfs still contains the overlay path.
This results in mnt_want_write_file() calls by the filesystem getting
freeze protection on the wrong inode (the overlayfs one instead of the real
one).

Fix by using file_inode(file)->i_sb instead of file->f_path.mnt->mnt_sb.

Reported-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/namespace.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -446,10 +446,10 @@ int mnt_want_write_file_path(struct file
 {
 	int ret;
 
-	sb_start_write(file->f_path.mnt->mnt_sb);
+	sb_start_write(file_inode(file)->i_sb);
 	ret = __mnt_want_write_file(file);
 	if (ret)
-		sb_end_write(file->f_path.mnt->mnt_sb);
+		sb_end_write(file_inode(file)->i_sb);
 	return ret;
 }
 
@@ -540,7 +540,8 @@ void __mnt_drop_write_file(struct file *
 
 void mnt_drop_write_file_path(struct file *file)
 {
-	mnt_drop_write(file->f_path.mnt);
+	__mnt_drop_write_file(file);
+	sb_end_write(file_inode(file)->i_sb);
 }
 
 void mnt_drop_write_file(struct file *file)



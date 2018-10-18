Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1D3ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5D7205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnxSxEOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5D7205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbeJSCDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbeJSCDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:03:15 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8065F205C9;
        Thu, 18 Oct 2018 18:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885670;
        bh=vrE0/SuZQ4G0J3qA+Walsn0S5SlXByPdQq7EqWLpTmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tnxSxEOYFuj5NXWFOyhNNNEew01nyuL6whZmSOgPaU4UcqFHQgylT/GFY6++HdeO8
         JUQrzadiAQkxAred/HpYJN3NIvlyWJJSC14RKLdXFj+9cCoCxE8VLQ3Lgf6PGQf3Zj
         20YusNqqEIYjPVJsRShz0Owu8WpddjyZIw9QhoKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 31/41] Revert "vfs: fix freeze protection in mnt_want_write_file() for overlayfs"
Date:   Thu, 18 Oct 2018 19:54:46 +0200
Message-Id: <20181018175422.226233899@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
References: <20181018175416.718399607@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 4f4374a9bd25b333971e6f2656b642d29e2efe7b which was
commit a6795a585929d94ca3e931bc8518f8deb8bbe627 upstream.

Turns out this causes problems and was to fix a patch only in the 4.19
and newer tree.

Reported-by: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/namespace.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -446,10 +446,10 @@ int mnt_want_write_file_path(struct file
 {
 	int ret;
 
-	sb_start_write(file_inode(file)->i_sb);
+	sb_start_write(file->f_path.mnt->mnt_sb);
 	ret = __mnt_want_write_file(file);
 	if (ret)
-		sb_end_write(file_inode(file)->i_sb);
+		sb_end_write(file->f_path.mnt->mnt_sb);
 	return ret;
 }
 
@@ -540,8 +540,7 @@ void __mnt_drop_write_file(struct file *
 
 void mnt_drop_write_file_path(struct file *file)
 {
-	__mnt_drop_write_file(file);
-	sb_end_write(file_inode(file)->i_sb);
+	mnt_drop_write(file->f_path.mnt);
 }
 
 void mnt_drop_write_file(struct file *file)



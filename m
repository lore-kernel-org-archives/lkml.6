Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D059AC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9608A2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570447;
	bh=oU/Kkc3dJtAxPwnwuvAEiCggfiJK/+EHIXU8fz7DulI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vJcK692ckTCr9twGm0fRD8dLEM4If4CoKbYdwFAH+SpuBiBor4jqd90CN6H48DqbZ
	 uiMttiLal6h/4L7hYHJjLSOx9EuERhs4RQ1moNttORtGDlGsD01p9tY0++rUaiPOox
	 Wb4ljJ0k2cmWqMp4nH37QvBGfwW70DHoL23PuHUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbfAOQkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:40:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:57184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730407AbfAOQkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:40:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D5062054F;
        Tue, 15 Jan 2019 16:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570443;
        bh=oU/Kkc3dJtAxPwnwuvAEiCggfiJK/+EHIXU8fz7DulI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9NR7azpZLdNuXoeCfliW7ar+pl7tQ+UtDqTNfRhl5JCQkPcuY5yqHEM0gePghxge
         xKn6kYaMex6GATDYJANx9VZe9eD1u1jlp66K7A5ziN2PRsbjgHZX4/iGLTku167Hcf
         kekLKaqHwX3uCFDV3CJrt6EhfOAYAFfJrNS59668=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.14 24/27] ext4: use ext4_write_inode() when fsyncing w/o a journal
Date:   Tue, 15 Jan 2019 17:36:13 +0100
Message-Id: <20190115154902.985906218@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154901.189747728@linuxfoundation.org>
References: <20190115154901.189747728@linuxfoundation.org>
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

From: Theodore Ts'o <tytso@mit.edu>

commit ad211f3e94b314a910d4af03178a0b52a7d1ee0a upstream.

In no-journal mode, we previously used __generic_file_fsync() in
no-journal mode.  This triggers a lockdep warning, and in addition,
it's not safe to depend on the inode writeback mechanism in the case
ext4.  We can solve both problems by calling ext4_write_inode()
directly.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/fsync.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -116,8 +116,16 @@ int ext4_sync_file(struct file *file, lo
 		goto out;
 	}
 
+	ret = file_write_and_wait_range(file, start, end);
+	if (ret)
+		return ret;
+
 	if (!journal) {
-		ret = __generic_file_fsync(file, start, end, datasync);
+		struct writeback_control wbc = {
+			.sync_mode = WB_SYNC_ALL
+		};
+
+		ret = ext4_write_inode(inode, &wbc);
 		if (!ret)
 			ret = ext4_sync_parent(inode);
 		if (test_opt(inode->i_sb, BARRIER))
@@ -125,9 +133,6 @@ int ext4_sync_file(struct file *file, lo
 		goto out;
 	}
 
-	ret = file_write_and_wait_range(file, start, end);
-	if (ret)
-		return ret;
 	/*
 	 * data=writeback,ordered:
 	 *  The caller's filemap_fdatawrite()/wait will sync the data.



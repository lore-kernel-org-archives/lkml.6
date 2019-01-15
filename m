Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1CEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D9020651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571230;
	bh=2VdWfanIbIWr2isazSkeq/j7oOLTsIBKwve0cfnWIlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RYeQ8ZEhJ5XFCkDu/gvuQa8TZ73SXHG2GWAzN8Jr7+HoJ2qMle07APJxA7RxkR+sI
	 kxID/s3+4QF+Aya5M31I2BfOGTuVV3bjX3fm9mFFpOkgDjpxxxHJt5F7hEoiQRepfK
	 O3RCA6XDN3CQbkjXOS2KhXZBVJqOOf+DK+yV7ACw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbfAOQxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:53:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:32828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733225AbfAOQnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:43:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9C1E2054F;
        Tue, 15 Jan 2019 16:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570602;
        bh=2VdWfanIbIWr2isazSkeq/j7oOLTsIBKwve0cfnWIlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2cDaVM7t8ko2aZUqhbOqAskyx8Gp4f4NklOiv1QShbeX4PzvpTj37ln38Zd6Iu/Xc
         OHoi3TPCiwMwUtSrmbVzIUSr+L6C5oPxjJpPEjamnCEfek9KHJvPL63pBvbjfSBseA
         k9QOg7XiStn+rlHI9CWxhjzLXwRl08ODS81cKHbY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
        stable@kernel.org
Subject: [PATCH 4.19 41/50] ext4: use ext4_write_inode() when fsyncing w/o a journal
Date:   Tue, 15 Jan 2019 17:36:17 +0100
Message-Id: <20190115154912.272756570@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



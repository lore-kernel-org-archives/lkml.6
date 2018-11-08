Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754D1C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3821E20883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct+NNSih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3821E20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbeKIHvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:51:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732633AbeKIHqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:46:07 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8EF420989;
        Thu,  8 Nov 2018 22:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714915;
        bh=DE7Bkjn2vn/MJEGj2ozEuEkZlpH5oigDUiRUN7GdeHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ct+NNSihbjcc6p616wgb4g03UkW+mUzrm2HKAaRT0vYX4LTeYjFrUMYB/cMlytX2W
         hPUKrYPt5gqFLlLOKXY5dtCtYsaLNRX+vZ3hijoB5YzGzVlQM2aiIurlwjRpOaBXVG
         5a644D5WS3P6CYwgZLZ2Nvhyz9RtUDwbmCG78zBM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 08/31] fsnotify: fix ignore mask logic in fsnotify()
Date:   Thu,  8 Nov 2018 13:52:32 -0800
Message-Id: <20181108215130.389974170@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
References: <20181108215129.641434673@linuxfoundation.org>
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

[ Upstream commit 9bdda4e9cf2dcecb60a0683b10ffb8cd7e5f2f45 ]

Commit 92183a42898d ("fsnotify: fix ignore mask logic in
send_to_group()") acknoledges the use case of ignoring an event on
an inode mark, because of an ignore mask on a mount mark of the same
group (i.e. I want to get all events on this file, except for the events
that came from that mount).

This change depends on correctly merging the inode marks and mount marks
group lists, so that the mount mark ignore mask would be tested in
send_to_group(). Alas, the merging of the lists did not take into
account the case where event in question is not in the mask of any of
the mount marks.

To fix this, completely remove the tests for inode and mount event masks
from the lists merging code.

Fixes: 92183a42898d ("fsnotify: fix ignore mask logic in send_to_group")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
[amir: backport to v4.14.y]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fsnotify.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index d76c81323dc1..2bc61e7543dd 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -286,17 +286,13 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
 
 	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
 
-	if ((mask & FS_MODIFY) ||
-	    (test_mask & to_tell->i_fsnotify_mask)) {
-		inode_conn = srcu_dereference(to_tell->i_fsnotify_marks,
+	inode_conn = srcu_dereference(to_tell->i_fsnotify_marks,
+				      &fsnotify_mark_srcu);
+	if (inode_conn)
+		inode_node = srcu_dereference(inode_conn->list.first,
 					      &fsnotify_mark_srcu);
-		if (inode_conn)
-			inode_node = srcu_dereference(inode_conn->list.first,
-						      &fsnotify_mark_srcu);
-	}
 
-	if (mnt && ((mask & FS_MODIFY) ||
-		    (test_mask & mnt->mnt_fsnotify_mask))) {
+	if (mnt) {
 		inode_conn = srcu_dereference(to_tell->i_fsnotify_marks,
 					      &fsnotify_mark_srcu);
 		if (inode_conn)
-- 
2.17.1




Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23BEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAE220864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAE220864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966889AbeFRIaA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:30:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33562 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966875AbeFRI35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:29:57 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4BAFEC50;
        Mon, 18 Jun 2018 08:29:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 008/189] fsnotify: fix ignore mask logic in send_to_group()
Date:   Mon, 18 Jun 2018 10:11:44 +0200
Message-Id: <20180618081209.571435455@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 92183a42898dc400b89da35685d1814ac6acd3d8 ]

The ignore mask logic in send_to_group() does not match the logic
in fanotify_should_send_event(). In the latter, a vfsmount mark ignore
mask precedes an inode mark mask and in the former, it does not.

That difference may cause events to be sent to fanotify backend for no
reason. Fix the logic in send_to_group() to match that of
fanotify_should_send_event().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/notify/fsnotify.c |   25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -192,8 +192,9 @@ static int send_to_group(struct inode *t
 			 struct fsnotify_iter_info *iter_info)
 {
 	struct fsnotify_group *group = NULL;
-	__u32 inode_test_mask = 0;
-	__u32 vfsmount_test_mask = 0;
+	__u32 test_mask = (mask & ~FS_EVENT_ON_CHILD);
+	__u32 marks_mask = 0;
+	__u32 marks_ignored_mask = 0;
 
 	if (unlikely(!inode_mark && !vfsmount_mark)) {
 		BUG();
@@ -213,29 +214,25 @@ static int send_to_group(struct inode *t
 	/* does the inode mark tell us to do something? */
 	if (inode_mark) {
 		group = inode_mark->group;
-		inode_test_mask = (mask & ~FS_EVENT_ON_CHILD);
-		inode_test_mask &= inode_mark->mask;
-		inode_test_mask &= ~inode_mark->ignored_mask;
+		marks_mask |= inode_mark->mask;
+		marks_ignored_mask |= inode_mark->ignored_mask;
 	}
 
 	/* does the vfsmount_mark tell us to do something? */
 	if (vfsmount_mark) {
-		vfsmount_test_mask = (mask & ~FS_EVENT_ON_CHILD);
 		group = vfsmount_mark->group;
-		vfsmount_test_mask &= vfsmount_mark->mask;
-		vfsmount_test_mask &= ~vfsmount_mark->ignored_mask;
-		if (inode_mark)
-			vfsmount_test_mask &= ~inode_mark->ignored_mask;
+		marks_mask |= vfsmount_mark->mask;
+		marks_ignored_mask |= vfsmount_mark->ignored_mask;
 	}
 
 	pr_debug("%s: group=%p to_tell=%p mask=%x inode_mark=%p"
-		 " inode_test_mask=%x vfsmount_mark=%p vfsmount_test_mask=%x"
+		 " vfsmount_mark=%p marks_mask=%x marks_ignored_mask=%x"
 		 " data=%p data_is=%d cookie=%d\n",
-		 __func__, group, to_tell, mask, inode_mark,
-		 inode_test_mask, vfsmount_mark, vfsmount_test_mask, data,
+		 __func__, group, to_tell, mask, inode_mark, vfsmount_mark,
+		 marks_mask, marks_ignored_mask, data,
 		 data_is, cookie);
 
-	if (!inode_test_mask && !vfsmount_test_mask)
+	if (!(test_mask & marks_mask & ~marks_ignored_mask))
 		return 0;
 
 	return group->ops->handle_event(group, to_tell, inode_mark,



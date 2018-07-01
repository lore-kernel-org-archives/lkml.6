Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA00C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB6624F35
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB6624F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeGAQL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:11:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59704 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbeGAQLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:11:24 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 57826AEF;
        Sun,  1 Jul 2018 16:11:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 04/85] fsnotify: fix ignore mask logic in send_to_group()
Date:   Sun,  1 Jul 2018 18:01:22 +0200
Message-Id: <20180701153122.540490240@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -135,8 +135,9 @@ static int send_to_group(struct inode *t
 			 const unsigned char *file_name)
 {
 	struct fsnotify_group *group = NULL;
-	__u32 inode_test_mask = 0;
-	__u32 vfsmount_test_mask = 0;
+	__u32 test_mask = (mask & ~FS_EVENT_ON_CHILD);
+	__u32 marks_mask = 0;
+	__u32 marks_ignored_mask = 0;
 
 	if (unlikely(!inode_mark && !vfsmount_mark)) {
 		BUG();
@@ -156,29 +157,25 @@ static int send_to_group(struct inode *t
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



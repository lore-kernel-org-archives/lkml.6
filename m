Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6904FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3294E213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0XHsHx7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3294E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388878AbeK3BgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:36:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388288AbeK3BgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:36:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 781942146D;
        Thu, 29 Nov 2018 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501841;
        bh=NmwN7OLb5hPJCztU4RpgnHKGI1wXmt9Iyh8GHXhRPBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0XHsHx7KRxIphTI0j7LxPrfl3BfE68OGWykhIffRFSP4Lxc8sIogxbCy1e6IiwY2B
         EGeZ+3PVDUEHp9TJLoPTLw26OG03K7y33YNIwdchBIOKWVW3AYw5ivCHxm1YQcLYhI
         83Ii/eYbfmg0eaITEl7bcBzOYN3PNiZuz7Zn8RhM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.19 064/110] fanotify: fix handling of events on child sub-directory
Date:   Thu, 29 Nov 2018 15:12:35 +0100
Message-Id: <20181129135923.838481094@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit b469e7e47c8a075cc08bcd1e85d4365134bdcdd5 upstream.

When an event is reported on a sub-directory and the parent inode has
a mark mask with FS_EVENT_ON_CHILD|FS_ISDIR, the event will be sent to
fsnotify() even if the event type is not in the parent mark mask
(e.g. FS_OPEN).

Further more, if that event happened on a mount or a filesystem with
a mount/sb mark that does have that event type in their mask, the "on
child" event will be reported on the mount/sb mark.  That is not
desired, because user will get a duplicate event for the same action.

Note that the event reported on the victim inode is never merged with
the event reported on the parent inode, because of the check in
should_merge(): old_fsn->inode == new_fsn->inode.

Fix this by looking for a match of an actual event type (i.e. not just
FS_ISDIR) in parent's inode mark mask and by not reporting an "on child"
event to group if event type is only found on mount/sb marks.

[backport hint: The bug seems to have always been in fanotify, but this
                patch will only apply cleanly to v4.19.y]

Cc: <stable@vger.kernel.org> # v4.19
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
[amir: backport to v4.19]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/notify/fanotify/fanotify.c |   10 +++++-----
 fs/notify/fsnotify.c          |    8 ++++++--
 2 files changed, 11 insertions(+), 7 deletions(-)

--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -115,12 +115,12 @@ static bool fanotify_should_send_event(s
 			continue;
 		mark = iter_info->marks[type];
 		/*
-		 * if the event is for a child and this inode doesn't care about
-		 * events on the child, don't send it!
+		 * If the event is for a child and this mark doesn't care about
+		 * events on a child, don't send it!
 		 */
-		if (type == FSNOTIFY_OBJ_TYPE_INODE &&
-		    (event_mask & FS_EVENT_ON_CHILD) &&
-		    !(mark->mask & FS_EVENT_ON_CHILD))
+		if (event_mask & FS_EVENT_ON_CHILD &&
+		    (type != FSNOTIFY_OBJ_TYPE_INODE ||
+		     !(mark->mask & FS_EVENT_ON_CHILD)))
 			continue;
 
 		marks_mask |= mark->mask;
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -161,9 +161,9 @@ int __fsnotify_parent(const struct path
 	parent = dget_parent(dentry);
 	p_inode = parent->d_inode;
 
-	if (unlikely(!fsnotify_inode_watches_children(p_inode)))
+	if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
 		__fsnotify_update_child_dentry_flags(p_inode);
-	else if (p_inode->i_fsnotify_mask & mask) {
+	} else if (p_inode->i_fsnotify_mask & mask & ALL_FSNOTIFY_EVENTS) {
 		struct name_snapshot name;
 
 		/* we are notifying a parent so come up with the new mask which
@@ -331,6 +331,10 @@ int fsnotify(struct inode *to_tell, __u3
 	else
 		mnt = NULL;
 
+	/* An event "on child" is not intended for a mount mark */
+	if (mask & FS_EVENT_ON_CHILD)
+		mnt = NULL;
+
 	/*
 	 * Optimization: srcu_read_lock() has a memory barrier which can
 	 * be expensive.  It protects walking the *_fsnotify_marks lists.



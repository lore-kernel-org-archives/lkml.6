Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC0C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2C52073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278193;
	bh=nd4ZWXPbclofJEdgWRDnS8a4VKwrqDw2zD0LhpdrywE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FsI5ZrMyvle2ilzwnAZdqIgHoKY33FQKtQZFZodVtF9RP2/harMZ4WoLgSdFRJA6l
	 vI5fgzZyErgg0zNaqOz9eww9JBzGIQ2k8D7QykKfgmpDv+37neJsLQepeJsRtdHM2X
	 63v5GeqVN8xsjg9mRc5KXm4HfW5vMbGdmoXIxk8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbfBDKql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730996AbfBDKqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:46:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 304FC217F9;
        Mon,  4 Feb 2019 10:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277196;
        bh=nd4ZWXPbclofJEdgWRDnS8a4VKwrqDw2zD0LhpdrywE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6Q3P+b1p85B/1T8ArqVlDSRXePGZD0QotXTrb4p3xQsF8ujPB9yGZqMxORMwAmTp
         z381kYIEKqVAIEytXAglWjHCByKFEiF7q+UMfaudgIWyG4I24pOtYqCw9jTs6WWwRA
         bSMhWjdgjl2odQjP0Rp+7kd/Lm6lm8d63ec82KV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.14 46/46] fanotify: fix handling of events on child sub-directory
Date:   Mon,  4 Feb 2019 11:37:17 +0100
Message-Id: <20190204103616.791566363@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
References: <20190204103608.651205056@linuxfoundation.org>
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
[amir: backport to v4.9]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/notify/fsnotify.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -158,9 +158,9 @@ int __fsnotify_parent(const struct path
 	parent = dget_parent(dentry);
 	p_inode = parent->d_inode;
 
-	if (unlikely(!fsnotify_inode_watches_children(p_inode)))
+	if (unlikely(!fsnotify_inode_watches_children(p_inode))) {
 		__fsnotify_update_child_dentry_flags(p_inode);
-	else if (p_inode->i_fsnotify_mask & mask) {
+	} else if (p_inode->i_fsnotify_mask & mask & ~FS_EVENT_ON_CHILD) {
 		struct name_snapshot name;
 
 		/* we are notifying a parent so come up with the new mask which
@@ -264,6 +264,10 @@ int fsnotify(struct inode *to_tell, __u3
 	else
 		mnt = NULL;
 
+	/* An event "on child" is not intended for a mount mark */
+	if (mask & FS_EVENT_ON_CHILD)
+		mnt = NULL;
+
 	/*
 	 * Optimization: srcu_read_lock() has a memory barrier which can
 	 * be expensive.  It protects walking the *_fsnotify_marks lists.



Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F167DC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25B020876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25B020876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeJNXMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36498 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728373AbeJNXMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:17 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM4-0004io-Q8; Sun, 14 Oct 2018 16:30:57 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLR-0000JO-PB; Sun, 14 Oct 2018 16:30:17 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jan Kara" <jack@suse.cz>,
        "Amir Goldstein" <amir73il@gmail.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.372472858@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 126/366] fanotify: fix logic of events on child
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 54a307ba8d3cd00a3902337ffaae28f436eeb1a4 upstream.

When event on child inodes are sent to the parent inode mark and
parent inode mark was not marked with FAN_EVENT_ON_CHILD, the event
will not be delivered to the listener process. However, if the same
process also has a mount mark, the event to the parent inode will be
delivered regadless of the mount mark mask.

This behavior is incorrect in the case where the mount mark mask does
not contain the specific event type. For example, the process adds
a mark on a directory with mask FAN_MODIFY (without FAN_EVENT_ON_CHILD)
and a mount mark with mask FAN_CLOSE_NOWRITE (without FAN_ONDIR).

A modify event on a file inside that directory (and inside that mount)
should not create a FAN_MODIFY event, because neither of the marks
requested to get that event on the file.

Fixes: 1968f5eed54c ("fanotify: use both marks when possible")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/notify/fanotify/fanotify.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -92,7 +92,7 @@ static bool fanotify_should_send_event(s
 				       u32 event_mask,
 				       void *data, int data_type)
 {
-	__u32 marks_mask, marks_ignored_mask;
+	__u32 marks_mask = 0, marks_ignored_mask = 0;
 	struct path *path = data;
 
 	pr_debug("%s: inode_mark=%p vfsmnt_mark=%p mask=%x data=%p"
@@ -108,24 +108,20 @@ static bool fanotify_should_send_event(s
 	    !S_ISDIR(path->dentry->d_inode->i_mode))
 		return false;
 
-	if (inode_mark && vfsmnt_mark) {
-		marks_mask = (vfsmnt_mark->mask | inode_mark->mask);
-		marks_ignored_mask = (vfsmnt_mark->ignored_mask | inode_mark->ignored_mask);
-	} else if (inode_mark) {
-		/*
-		 * if the event is for a child and this inode doesn't care about
-		 * events on the child, don't send it!
-		 */
-		if ((event_mask & FS_EVENT_ON_CHILD) &&
-		    !(inode_mark->mask & FS_EVENT_ON_CHILD))
-			return false;
-		marks_mask = inode_mark->mask;
-		marks_ignored_mask = inode_mark->ignored_mask;
-	} else if (vfsmnt_mark) {
-		marks_mask = vfsmnt_mark->mask;
-		marks_ignored_mask = vfsmnt_mark->ignored_mask;
-	} else {
-		BUG();
+	/*
+	 * if the event is for a child and this inode doesn't care about
+	 * events on the child, don't send it!
+	 */
+	if (inode_mark &&
+	    (!(event_mask & FS_EVENT_ON_CHILD) ||
+	     (inode_mark->mask & FS_EVENT_ON_CHILD))) {
+		marks_mask |= inode_mark->mask;
+		marks_ignored_mask |= inode_mark->ignored_mask;
+	}
+
+	if (vfsmnt_mark) {
+		marks_mask |= vfsmnt_mark->mask;
+		marks_ignored_mask |= vfsmnt_mark->ignored_mask;
 	}
 
 	if (S_ISDIR(path->dentry->d_inode->i_mode) &&


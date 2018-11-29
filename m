Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08782C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A0D2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z3YjCSr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A0D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbeK3Bhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:37:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732374AbeK3Bhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:37:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C55F4213A2;
        Thu, 29 Nov 2018 14:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501923;
        bh=Rg8vS4vubc6PUEg2Sd0sAGZrvdMFA3au/UrElaoB9t8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z3YjCSr5BQ/c357EKJ/Mq5LFtDFIGuL2DMCZqY2r/WxH1pJlET7JLvcygtCj+Zzxk
         QOc4lRmSV037trZRFk/3YsamR/jQBwsCWTE1IDzX9ly3cEYR9nrJ85xP1HGfaVHt53
         J2diZB3ao7XWYrX7UmsJel+D8KAwQq6F7/qXVv30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.19 063/110] fsnotify: generalize handling of extra event flags
Date:   Thu, 29 Nov 2018 15:12:34 +0100
Message-Id: <20181129135923.798155157@linuxfoundation.org>
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

commit 007d1e8395eaa59b0e7ad9eb2b53a40859446a88 upstream.

FS_EVENT_ON_CHILD gets a special treatment in fsnotify() because it is
not a flag specifying an event type, but rather an extra flags that may
be reported along with another event and control the handling of the
event by the backend.

FS_ISDIR is also an "extra flag" and not an "event type" and therefore
desrves the same treatment. With inotify/dnotify backends it was never
possible to set FS_ISDIR in mark masks, so it did not matter.
With fanotify backend, mark adding code jumps through hoops to avoid
setting the FS_ISDIR in the commulative object mask.

Separate the constant ALL_FSNOTIFY_EVENTS to ALL_FSNOTIFY_FLAGS and
ALL_FSNOTIFY_EVENTS, so the latter can be used to test for specific
event types.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/notify/fsnotify.c             |    7 +++----
 include/linux/fsnotify_backend.h |    9 +++++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -193,7 +193,7 @@ static int send_to_group(struct inode *t
 			 struct fsnotify_iter_info *iter_info)
 {
 	struct fsnotify_group *group = NULL;
-	__u32 test_mask = (mask & ~FS_EVENT_ON_CHILD);
+	__u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
 	__u32 marks_mask = 0;
 	__u32 marks_ignored_mask = 0;
 	struct fsnotify_mark *mark;
@@ -324,8 +324,7 @@ int fsnotify(struct inode *to_tell, __u3
 	struct fsnotify_iter_info iter_info = {};
 	struct mount *mnt;
 	int ret = 0;
-	/* global tests shouldn't care about events on child only the specific event */
-	__u32 test_mask = (mask & ~FS_EVENT_ON_CHILD);
+	__u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
 
 	if (data_is == FSNOTIFY_EVENT_PATH)
 		mnt = real_mount(((const struct path *)data)->mnt);
@@ -389,7 +388,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUG_ON(hweight32(ALL_FSNOTIFY_EVENTS) != 23);
+	BUG_ON(hweight32(ALL_FSNOTIFY_BITS) != 23);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -68,15 +68,20 @@
 
 #define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM)
 
+/* Events that can be reported to backends */
 #define ALL_FSNOTIFY_EVENTS (FS_ACCESS | FS_MODIFY | FS_ATTRIB | \
 			     FS_CLOSE_WRITE | FS_CLOSE_NOWRITE | FS_OPEN | \
 			     FS_MOVED_FROM | FS_MOVED_TO | FS_CREATE | \
 			     FS_DELETE | FS_DELETE_SELF | FS_MOVE_SELF | \
 			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
-			     FS_OPEN_PERM | FS_ACCESS_PERM | FS_EXCL_UNLINK | \
-			     FS_ISDIR | FS_IN_ONESHOT | FS_DN_RENAME | \
+			     FS_OPEN_PERM | FS_ACCESS_PERM | FS_DN_RENAME)
+
+/* Extra flags that may be reported with event or control handling of events */
+#define ALL_FSNOTIFY_FLAGS  (FS_EXCL_UNLINK | FS_ISDIR | FS_IN_ONESHOT | \
 			     FS_DN_MULTISHOT | FS_EVENT_ON_CHILD)
 
+#define ALL_FSNOTIFY_BITS   (ALL_FSNOTIFY_EVENTS | ALL_FSNOTIFY_FLAGS)
+
 struct fsnotify_group;
 struct fsnotify_event;
 struct fsnotify_mark;



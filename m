Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3ACC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBD32087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975622;
	bh=JHVnP8ykc/kXNooKkd6LVOEefLJ7d/95lgsaSFGwwKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kmFgd5Ck9xEqrG2958hOVFRRzQ36Z6uS0MKKgNakkwt5ZsNBBmOenuBe6eOsO08R4
	 tiYRHIo6v8ENu4cMXbnal/GqoJhFszbCuNJhXrO/KmIhmlhhzahsFeJEq2B5RXHAi0
	 A+zmuC6hMHOm7/dXbnv6zWGPykENf7QgAfIBjQvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfAHT1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:27:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:32794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729317AbfAHT04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:26:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC522087F;
        Tue,  8 Jan 2019 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975615;
        bh=JHVnP8ykc/kXNooKkd6LVOEefLJ7d/95lgsaSFGwwKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqPXewkdtTo/W95qdSCe5Y+SL4xAgovKWWx/VXrJy1XOFZkbZsmmDY3J+9944GrVs
         9II94+ptGqXXVqKPjBjDcM1MYbLd6c0yrFtjP01mmm1C88fLUTb2o8Fo8PkzbcV75F
         VDygGUJS9j9yi13mc7ti2ypIba1LcbEQZvuyDFeU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 016/117] fanotify: return only user requested event types in event mask
Date:   Tue,  8 Jan 2019 14:24:44 -0500
Message-Id: <20190108192628.121270-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Bobrowski <mbobrowski@mbobrowski.org>

[ Upstream commit 2d10b23082a7eb8be508b3789f2e7250a88a5ddb ]

Modify fanotify_should_send_event() so that it now returns a mask for
an event that contains ONLY flags for the event types that have been
specifically requested by the user. Flags that may have been included
within the event mask, but have not been explicitly requested by the
user will not be present in the returned value.

As an example, given the situation where a user requests events of type
FAN_OPEN. Traditionally, the event mask returned within an event that
occurred on a filesystem object that has been marked for monitoring and is
opened, will only ever have the FAN_OPEN bit set. With the introduction of
the new flags like FAN_OPEN_EXEC, and perhaps any other future event
flags, there is a possibility of the returned event mask containing more
than a single bit set, despite having only requested the single event type.
Prior to these modifications performed to fanotify_should_send_event(), a
user would have received a bundled event mask containing flags FAN_OPEN
and FAN_OPEN_EXEC in the instance that a file was opened for execution via
execve(), for example. This means that a user would receive event types
in the returned event mask that have not been requested. This runs the
possibility of breaking existing systems and causing other unforeseen
issues.

To mitigate this possibility, fanotify_should_send_event() has been
modified to return the event mask containing ONLY event types explicitly
requested by the user. This means that we will NOT report events that the
user did no set a mask for, and we will NOT report events that the user
has set an ignore mask for.

The function name fanotify_should_send_event() has also been updated so
that it's more relevant to what it has been designed to do.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index e08a6647267b..f4f8359bc597 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -89,7 +89,13 @@ static int fanotify_get_response(struct fsnotify_group *group,
 	return ret;
 }
 
-static bool fanotify_should_send_event(struct fsnotify_iter_info *iter_info,
+/*
+ * This function returns a mask for an event that only contains the flags
+ * that have been specifically requested by the user. Flags that may have
+ * been included within the event mask, but have not been explicitly
+ * requested by the user, will not be present in the returned mask.
+ */
+static u32 fanotify_group_event_mask(struct fsnotify_iter_info *iter_info,
 				       u32 event_mask, const void *data,
 				       int data_type)
 {
@@ -101,14 +107,14 @@ static bool fanotify_should_send_event(struct fsnotify_iter_info *iter_info,
 	pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
 		 __func__, iter_info->report_mask, event_mask, data, data_type);
 
-	/* if we don't have enough info to send an event to userspace say no */
+	/* If we don't have enough info to send an event to userspace say no */
 	if (data_type != FSNOTIFY_EVENT_PATH)
-		return false;
+		return 0;
 
-	/* sorry, fanotify only gives a damn about files and dirs */
+	/* Sorry, fanotify only gives a damn about files and dirs */
 	if (!d_is_reg(path->dentry) &&
 	    !d_can_lookup(path->dentry))
-		return false;
+		return 0;
 
 	fsnotify_foreach_obj_type(type) {
 		if (!fsnotify_iter_should_report_type(iter_info, type))
@@ -129,13 +135,10 @@ static bool fanotify_should_send_event(struct fsnotify_iter_info *iter_info,
 
 	if (d_is_dir(path->dentry) &&
 	    !(marks_mask & FS_ISDIR & ~marks_ignored_mask))
-		return false;
-
-	if (event_mask & FANOTIFY_OUTGOING_EVENTS &
-	    marks_mask & ~marks_ignored_mask)
-		return true;
+		return 0;
 
-	return false;
+	return event_mask & FANOTIFY_OUTGOING_EVENTS & marks_mask &
+		~marks_ignored_mask;
 }
 
 struct fanotify_event_info *fanotify_alloc_event(struct fsnotify_group *group,
@@ -210,7 +213,8 @@ static int fanotify_handle_event(struct fsnotify_group *group,
 
 	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 10);
 
-	if (!fanotify_should_send_event(iter_info, mask, data, data_type))
+	mask = fanotify_group_event_mask(iter_info, mask, data, data_type);
+	if (!mask)
 		return 0;
 
 	pr_debug("%s: group=%p inode=%p mask=%x\n", __func__, group, inode,
-- 
2.19.1


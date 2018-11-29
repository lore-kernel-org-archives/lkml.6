Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5086C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18B721019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18B721019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeK3KNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:13:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:36792 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeK3KNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:13:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3391AC66;
        Thu, 29 Nov 2018 23:06:02 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>
Date:   Fri, 30 Nov 2018 10:04:08 +1100
Subject: [PATCH 02/12] fs/locks: split out __locks_wake_up_blocks().
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154353264830.32133.5441260415101610552.stgit@noble>
In-Reply-To: <154353251599.32133.1085882002675619240.stgit@noble>
References: <154353251599.32133.1085882002675619240.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This functionality will be useful in future patches, so
split it out from locks_wake_up_blocks().

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/locks.c |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index c6df0c8b3d13..6adb22a21a92 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -672,6 +672,21 @@ static void __locks_delete_block(struct file_lock *waiter)
 	waiter->fl_blocker = NULL;
 }
 
+static void __locks_wake_up_blocks(struct file_lock *blocker)
+{
+	while (!list_empty(&blocker->fl_blocked_requests)) {
+		struct file_lock *waiter;
+
+		waiter = list_first_entry(&blocker->fl_blocked_requests,
+					  struct file_lock, fl_blocked_member);
+		__locks_delete_block(waiter);
+		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
+			waiter->fl_lmops->lm_notify(waiter);
+		else
+			wake_up(&waiter->fl_wait);
+	}
+}
+
 static void locks_delete_block(struct file_lock *waiter)
 {
 	spin_lock(&blocked_lock_lock);
@@ -727,17 +742,7 @@ static void locks_wake_up_blocks(struct file_lock *blocker)
 		return;
 
 	spin_lock(&blocked_lock_lock);
-	while (!list_empty(&blocker->fl_blocked_requests)) {
-		struct file_lock *waiter;
-
-		waiter = list_first_entry(&blocker->fl_blocked_requests,
-				struct file_lock, fl_blocked_member);
-		__locks_delete_block(waiter);
-		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
-			waiter->fl_lmops->lm_notify(waiter);
-		else
-			wake_up(&waiter->fl_wait);
-	}
+	__locks_wake_up_blocks(blocker);
 	spin_unlock(&blocked_lock_lock);
 }
 



Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FB1C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1492720671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 22:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1492720671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeJXHLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 03:11:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:36272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbeJXHLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 03:11:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2DE3AAF84;
        Tue, 23 Oct 2018 22:45:49 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Wed, 24 Oct 2018 09:43:54 +1100
Subject: [PATCH 2/9] fs/locks: split out __locks_wake_up_blocks().
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154033463440.29542.7694639999612998712.stgit@noble>
In-Reply-To: <154033435272.29542.13985568983074440924.stgit@noble>
References: <154033435272.29542.13985568983074440924.stgit@noble>
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
---
 fs/locks.c |   27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index a6c6d601286c..b8f33792a0a6 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -672,6 +672,21 @@ static void __locks_delete_block(struct file_lock *waiter)
 	waiter->fl_blocker = NULL;
 }
 
+static void __locks_wake_up_blocks(struct file_lock *blocker)
+{
+	while (!list_empty(&blocker->fl_blocked)) {
+		struct file_lock *waiter;
+
+		waiter = list_first_entry(&blocker->fl_blocked,
+					  struct file_lock, fl_block);
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
@@ -726,17 +741,7 @@ static void locks_wake_up_blocks(struct file_lock *blocker)
 		return;
 
 	spin_lock(&blocked_lock_lock);
-	while (!list_empty(&blocker->fl_blocked)) {
-		struct file_lock *waiter;
-
-		waiter = list_first_entry(&blocker->fl_blocked,
-				struct file_lock, fl_block);
-		__locks_delete_block(waiter);
-		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
-			waiter->fl_lmops->lm_notify(waiter);
-		else
-			wake_up(&waiter->fl_wait);
-	}
+	__locks_wake_up_blocks(blocker);
 	spin_unlock(&blocked_lock_lock);
 }
 



Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB588C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4756208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4756208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbeKLLHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:07:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:56696 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbeKLLHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:07:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E936FADE3;
        Mon, 12 Nov 2018 01:16:55 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 12 Nov 2018 12:14:48 +1100
Subject: [PATCH 02/12] fs/locks: split out __locks_wake_up_blocks().
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154198528894.14364.16208552172968406455.stgit@noble>
In-Reply-To: <154198490921.14364.13726904731989686092.stgit@noble>
References: <154198490921.14364.13726904731989686092.stgit@noble>
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
 



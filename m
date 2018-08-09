Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7009C4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691CC21C19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691CC21C19
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeHIEaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:30:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:60590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725757AbeHIEaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:30:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A05AACE8;
        Thu,  9 Aug 2018 02:07:54 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Thu, 09 Aug 2018 12:04:41 +1000
Subject: [PATCH 4/5] fs/locks: split out __locks_wake_one()
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <153378028117.1220.6771440459821567385.stgit@noble>
In-Reply-To: <153378012255.1220.6754153662007899557.stgit@noble>
References: <153378012255.1220.6754153662007899557.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This functionality will be useful in the next patch, so
split it out from __locks_wake_up_blocks().

Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/locks.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index d06658b2dc7a..fc64016d01ee 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -710,6 +710,15 @@ static void __locks_delete_block(struct file_lock *waiter)
 	waiter->fl_blocker = NULL;
 }
 
+static void __locks_wake_one(struct file_lock *waiter)
+{
+	__locks_delete_block(waiter);
+	if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
+		waiter->fl_lmops->lm_notify(waiter);
+	else
+		wake_up(&waiter->fl_wait);
+}
+
 static void __locks_wake_up_blocks(struct file_lock *blocker)
 {
 	while (!list_empty(&blocker->fl_blocked)) {
@@ -717,11 +726,7 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
 
 		waiter = list_first_entry(&blocker->fl_blocked,
 				struct file_lock, fl_block);
-		__locks_delete_block(waiter);
-		if (waiter->fl_lmops && waiter->fl_lmops->lm_notify)
-			waiter->fl_lmops->lm_notify(waiter);
-		else
-			wake_up(&waiter->fl_wait);
+		__locks_wake_one(waiter);
 	}
 }
 



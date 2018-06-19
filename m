Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6601BC5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9F520660
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 03:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9F520660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=themaw.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937227AbeFSDC1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 23:02:27 -0400
Received: from icp-osb-irony-out7.external.iinet.net.au ([203.59.1.107]:50319
        "EHLO icp-osb-irony-out7.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755409AbeFSDCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 23:02:25 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CPHABicShb/6c80XZcHQEBIgEGAYMxg?=
 =?us-ascii?q?ToVEiiDeZRWRgEBAQEBBoENNJRgFIFkHhgBhECCYSE1FwECAQEBAQEBAm0ohVI?=
 =?us-ascii?q?EUigBDAIYDgJJFhOFGAyqU4FpMxoCiC2BaIELh0mBDIEHgQ8whzmDGYJVAocyF?=
 =?us-ascii?q?4VXP4s3CY8JiBiFI5MPATaBUk0uCoJ+kFwyMHoBAZBSAQE?=
X-IPAS-Result: =?us-ascii?q?A2CPHABicShb/6c80XZcHQEBIgEGAYMxgToVEiiDeZRWRgE?=
 =?us-ascii?q?BAQEBBoENNJRgFIFkHhgBhECCYSE1FwECAQEBAQEBAm0ohVIEUigBDAIYDgJJF?=
 =?us-ascii?q?hOFGAyqU4FpMxoCiC2BaIELh0mBDIEHgQ8whzmDGYJVAocyF4VXP4s3CY8JiBi?=
 =?us-ascii?q?FI5MPATaBUk0uCoJ+kFwyMHoBAZBSAQE?=
X-IronPort-AV: E=Sophos;i="5.51,241,1526313600"; 
   d="scan'208";a="90294621"
Received: from unknown (HELO pluto.themaw.net) ([118.209.60.167])
  by icp-osb-irony-out7.iinet.net.au with ESMTP; 19 Jun 2018 11:01:58 +0800
Subject: [PATCH 1/6] autofs - fix inconsistent use of now variable
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Jun 2018 11:01:57 +0800
Message-ID: <152937731702.21213.7371321165189170865.stgit@pluto.themaw.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global variable "now" in fs/autofs/expire.c is used in
an inconsistent way, sometimes using jiffies directly, and
sometimes using the "now" variable, and setting it isn't done
consistently either.

But the autofs dentry info last_used field is only updated
during path walks or during expire so jiffies can be used
directly and the global variable "now" removed.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/expire.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
index b332d3f6e730..295feec10ea6 100644
--- a/fs/autofs/expire.c
+++ b/fs/autofs/expire.c
@@ -10,8 +10,6 @@
 
 #include "autofs_i.h"
 
-static unsigned long now;
-
 /* Check if a dentry can be expired */
 static inline int autofs_can_expire(struct dentry *dentry,
 				    unsigned long timeout, int do_now)
@@ -24,7 +22,7 @@ static inline int autofs_can_expire(struct dentry *dentry,
 
 	if (!do_now) {
 		/* Too young to die */
-		if (!timeout || time_after(ino->last_used + timeout, now))
+		if (!timeout || time_after(ino->last_used + timeout, jiffies))
 			return 0;
 	}
 	return 1;
@@ -307,7 +305,6 @@ struct dentry *autofs_expire_direct(struct super_block *sb,
 	if (!root)
 		return NULL;
 
-	now = jiffies;
 	timeout = sbi->exp_timeout;
 
 	if (!autofs_direct_busy(mnt, root, timeout, do_now)) {
@@ -442,7 +439,6 @@ struct dentry *autofs_expire_indirect(struct super_block *sb,
 	if (!root)
 		return NULL;
 
-	now = jiffies;
 	timeout = sbi->exp_timeout;
 
 	dentry = NULL;
@@ -575,7 +571,7 @@ int autofs_expire_run(struct super_block *sb,
 	spin_lock(&sbi->fs_lock);
 	ino = autofs_dentry_ino(dentry);
 	/* avoid rapid-fire expire attempts if expiry fails */
-	ino->last_used = now;
+	ino->last_used = jiffies;
 	ino->flags &= ~(AUTOFS_INF_EXPIRING|AUTOFS_INF_WANT_EXPIRE);
 	complete_all(&ino->expire_complete);
 	spin_unlock(&sbi->fs_lock);
@@ -605,7 +601,7 @@ int autofs_do_expire_multi(struct super_block *sb, struct vfsmount *mnt,
 
 		spin_lock(&sbi->fs_lock);
 		/* avoid rapid-fire expire attempts if expiry fails */
-		ino->last_used = now;
+		ino->last_used = jiffies;
 		ino->flags &= ~(AUTOFS_INF_EXPIRING|AUTOFS_INF_WANT_EXPIRE);
 		complete_all(&ino->expire_complete);
 		spin_unlock(&sbi->fs_lock);


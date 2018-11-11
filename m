Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF610C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D247214F1
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D247214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbeKLFsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50114 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730255AbeKLFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:16 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsc-0000l6-3k; Sun, 11 Nov 2018 19:58:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001pq-Dl; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Dae R. Jeong" <threeearcat@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.643022449@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 320/366] make sure that __dentry_kill() always
 invalidates d_seq, unhashed or not
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 4c0d7cd5c8416b1ef41534d19163cb07ffaa03ab upstream.

RCU pathwalk relies upon the assumption that anything that changes
->d_inode of a dentry will invalidate its ->d_seq.  That's almost
true - the one exception is that the final dput() of already unhashed
dentry does *not* touch ->d_seq at all.  Unhashing does, though,
so for anything we'd found by RCU dcache lookup we are fine.
Unfortunately, we can *start* with an unhashed dentry or jump into
it.

We could try and be careful in the (few) places where that could
happen.  Or we could just make the final dput() invalidate the damn
thing, unhashed or not.  The latter is much simpler and easier to
backport, so let's do it that way.

Reported-by: "Dae R. Jeong" <threeearcat@gmail.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/dcache.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -340,14 +340,11 @@ static void dentry_unlink_inode(struct d
 	__releases(dentry->d_inode->i_lock)
 {
 	struct inode *inode = dentry->d_inode;
-	bool hashed = !d_unhashed(dentry);
 
-	if (hashed)
-		raw_write_seqcount_begin(&dentry->d_seq);
+	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_clear_type_and_inode(dentry);
 	hlist_del_init(&dentry->d_u.d_alias);
-	if (hashed)
-		raw_write_seqcount_end(&dentry->d_seq);
+	raw_write_seqcount_end(&dentry->d_seq);
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&inode->i_lock);
 	if (!inode->i_nlink)


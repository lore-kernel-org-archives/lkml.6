Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F56C64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B222720673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B222720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeK3KNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:13:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:36914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeK3KN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:13:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0980EAD1A;
        Thu, 29 Nov 2018 23:06:21 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>
Date:   Fri, 30 Nov 2018 10:04:08 +1100
Subject: [PATCH 05/12] ocfs2: properly initial file_lock used for unlock.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154353264841.32133.11628489131872441919.stgit@noble>
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

Rather than assuming all-zeros is sufficient, use the available API to
initialize the file_lock structure use for unlock.  VFS-level changes
will soon make it important that the list_heads in file_lock are
always properly initialized.

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/ocfs2/locks.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/locks.c b/fs/ocfs2/locks.c
index d56f0079b858..b11acd34001a 100644
--- a/fs/ocfs2/locks.c
+++ b/fs/ocfs2/locks.c
@@ -52,6 +52,7 @@ static int ocfs2_do_flock(struct file *file, struct inode *inode,
 	if (lockres->l_flags & OCFS2_LOCK_ATTACHED &&
 	    lockres->l_level > LKM_NLMODE) {
 		int old_level = 0;
+		struct file_lock request;
 
 		if (lockres->l_level == LKM_EXMODE)
 			old_level = 1;
@@ -66,11 +67,10 @@ static int ocfs2_do_flock(struct file *file, struct inode *inode,
 		 * level.
 		 */
 
-		locks_lock_file_wait(file,
-				&(struct file_lock) {
-					.fl_type = F_UNLCK,
-					.fl_flags = FL_FLOCK
-				});
+		locks_init_lock(&request);
+		request.fl_type = F_UNLCK;
+		request.fl_flags = FL_FLOCK;
+		locks_lock_file_wait(file, &request);
 
 		ocfs2_file_unlock(file);
 	}



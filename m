Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B22C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560DA2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560DA2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbeKLLH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:07:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:56816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726674AbeKLLH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:07:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97D43ADE3;
        Mon, 12 Nov 2018 01:17:15 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 12 Nov 2018 12:14:49 +1100
Subject: [PATCH 05/12] ocfs2: properly initial file_lock used for unlock.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154198528906.14364.3671063027499306155.stgit@noble>
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

Rather than assuming all-zeros is sufficient, use the available API to
initialize the file_lock structure use for unlock.
VFS-level changes will soon make it important that the
list_heads in file_lock are always properly initialized.

Signed-off-by: NeilBrown <neilb@suse.com>
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



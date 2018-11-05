Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27756ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF72B20685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF72B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeKEKtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 05:49:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:60638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeKEKtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 05:49:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A63C2AFD9;
        Mon,  5 Nov 2018 01:32:03 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 05 Nov 2018 12:30:47 +1100
Subject: [PATCH 04/12] gfs2: properly initial file_lock used for unlock.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154138144777.31651.4516223215037533891.stgit@noble>
In-Reply-To: <154138128401.31651.1381177427603557514.stgit@noble>
References: <154138128401.31651.1381177427603557514.stgit@noble>
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
 fs/gfs2/file.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 45a17b770d97..271f847705e3 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1199,13 +1199,13 @@ static int do_flock(struct file *file, int cmd, struct file_lock *fl)
 	mutex_lock(&fp->f_fl_mutex);
 
 	if (gfs2_holder_initialized(fl_gh)) {
+		struct file_lock request;
 		if (fl_gh->gh_state == state)
 			goto out;
-		locks_lock_file_wait(file,
-				     &(struct file_lock) {
-					     .fl_type = F_UNLCK,
-					     .fl_flags = FL_FLOCK
-				     });
+		locks_init_lock(&request);
+		request.fl_type = F_UNLOCK;
+		request.fl_flags = FL_FLOCK;
+		locks_lock_file_wait(file, &request);
 		gfs2_glock_dq(fl_gh);
 		gfs2_holder_reinit(state, flags, fl_gh);
 	} else {



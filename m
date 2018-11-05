Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2F1ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5A120685
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 01:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5A120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeKEKtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 05:49:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:60564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbeKEKtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 05:49:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B90AAFDA;
        Mon,  5 Nov 2018 01:31:57 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 05 Nov 2018 12:30:47 +1100
Subject: [PATCH 03/12] NFS: use locks_copy_lock() to copy locks.
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Message-ID: <154138144774.31651.16441435015576031050.stgit@noble>
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

Using memcpy() to copy lock requests leave the various
list_head in an inconsistent state.
As we will soon attach a list of conflicting request to
another pending request, we need these lists to be consistent.
So change NFS to use locks_init_lock/locks_copy_lock instead
of memcpy.

Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/nfs/nfs4proc.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 867457d6dfbe..0ba2b0fb8ff3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6311,7 +6311,8 @@ static struct nfs4_unlockdata *nfs4_alloc_unlockdata(struct file_lock *fl,
 	/* Ensure we don't close file until we're done freeing locks! */
 	p->ctx = get_nfs_open_context(ctx);
 	p->l_ctx = nfs_get_lock_context(ctx);
-	memcpy(&p->fl, fl, sizeof(p->fl));
+	locks_init_lock(&p->fl);
+	locks_copy_lock(&p->fl, fl);
 	p->server = NFS_SERVER(inode);
 	return p;
 }
@@ -6533,7 +6534,8 @@ static struct nfs4_lockdata *nfs4_alloc_lockdata(struct file_lock *fl,
 	p->server = server;
 	refcount_inc(&lsp->ls_count);
 	p->ctx = get_nfs_open_context(ctx);
-	memcpy(&p->fl, fl, sizeof(p->fl));
+	locks_init_lock(&p->fl);
+	locks_copy_lock(&p->fl, fl);
 	return p;
 out_free_seqid:
 	nfs_free_seqid(p->arg.open_seqid);



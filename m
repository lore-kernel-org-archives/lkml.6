Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A20ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB005214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB005214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeJQWNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:13:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbeJQWNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:13:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CE80C04F2AE;
        Wed, 17 Oct 2018 14:17:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16DA15C6B5;
        Wed, 17 Oct 2018 14:17:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/4] cachefiles: fix the race between
 cachefiles_bury_object() and rmdir(2)
From:   David Howells <dhowells@redhat.com>
To:     gregkh@linux-foundation.org
Cc:     stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        viro@zeniv.linux.org.uk, sandeen@redhat.com, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 17 Oct 2018 15:17:01 +0100
Message-ID: <153978582166.7579.12678499150203462777.stgit@warthog.procyon.org.uk>
In-Reply-To: <153978580402.7579.15833925372019979447.stgit@warthog.procyon.org.uk>
References: <153978580402.7579.15833925372019979447.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 17 Oct 2018 14:17:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

the victim might've been rmdir'ed just before the lock_rename();
unlike the normal callers, we do not look the source up after the
parents are locked - we know it beforehand and just recheck that it's
still the child of what used to be its parent.  Unfortunately,
the check is too weak - we don't spot a dead directory since its
->d_parent is unchanged, dentry is positive, etc.  So we sail all
the way to ->rename(), with hosting filesystems _not_ expecting
to be asked renaming an rmdir'ed subdirectory.

The fix is easy, fortunately - the lock on parent is sufficient for
making IS_DEADDIR() on child safe.

Cc: stable@vger.kernel.org
Fixes: 9ae326a69004 (CacheFiles: A cache that backs onto a mounted filesystem)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/namei.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index af2b17b21b94..95983c744164 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -343,7 +343,7 @@ static int cachefiles_bury_object(struct cachefiles_cache *cache,
 	trap = lock_rename(cache->graveyard, dir);
 
 	/* do some checks before getting the grave dentry */
-	if (rep->d_parent != dir) {
+	if (rep->d_parent != dir || IS_DEADDIR(d_inode(rep))) {
 		/* the entry was probably culled when we dropped the parent dir
 		 * lock */
 		unlock_rename(cache->graveyard, dir);


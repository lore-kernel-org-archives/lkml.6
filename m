Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300D6C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1BB21486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789130;
	bh=w4d8c//xKQoFD/GX3KylrBSR/vDnUxgUeskBmyrMBTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U44UPi78cXWe4KWmFSu/8YqXdKJfQPzyEVsSOp/VBdLSO4qnLb4R9ivn7i66gsjIn
	 Y66SQG6pc92UTHYf4SWe8Fihp3khsLdjKGPAEZX4uDu29Uk6p1XE6lw48YFhdck/D0
	 Xdmu/6ow2pp89hjyZUSqNKYxNyDozABN4ipfFO1Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1BB21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbeLNMF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:05:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730698AbeLNMF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:05:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E744A21486;
        Fri, 14 Dec 2018 12:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789125;
        bh=w4d8c//xKQoFD/GX3KylrBSR/vDnUxgUeskBmyrMBTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MW/UhI0UP5d07xTGps1zXApzD0Fbuo11dH/T99Pn3EzLVUhMJeh/4fJb/zhbUHCkc
         JDC9mRmRf+BwtGoCDh4Gpd+u3UJgfhySvJsna3OKy3ddbafWnzU0QKtWgy3SY9LNXF
         9TZC67yKngC8IwJ4akVU/WP4f2H+ekVyg51CqHs4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhibin Li <zhibli@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 104/142] cachefiles: Fix an assertion failure when trying to update a failed object
Date:   Fri, 14 Dec 2018 12:59:49 +0100
Message-Id: <20181214115751.218924732@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e6bc06faf64a83384cc0abc537df954c9d3ff942 ]

If cachefiles gets an error other then ENOENT when trying to look up an
object in the cache (in this case, EACCES), the object state machine will
eventually transition to the DROP_OBJECT state.

This state invokes fscache_drop_object() which tries to sync the auxiliary
data with the cache (this is done lazily since commit 402cb8dda949d) on an
incomplete cache object struct.

The problem comes when cachefiles_update_object_xattr() is called to
rewrite the xattr holding the data.  There's an assertion there that the
cache object points to a dentry as we're going to update its xattr.  The
assertion trips, however, as dentry didn't get set.

Fix the problem by skipping the update in cachefiles if the object doesn't
refer to a dentry.  A better way to do it could be to skip the update from
the DROP_OBJECT state handler in fscache, but that might deny the cache the
opportunity to update intermediate state.

If this error occurs, the kernel log includes lines that look like the
following:

 CacheFiles: Lookup failed error -13
 CacheFiles:
 CacheFiles: Assertion failed
 ------------[ cut here ]------------
 kernel BUG at fs/cachefiles/xattr.c:138!
 ...
 Workqueue: fscache_object fscache_object_work_func [fscache]
 RIP: 0010:cachefiles_update_object_xattr.cold.4+0x18/0x1a [cachefiles]
 ...
 Call Trace:
  cachefiles_update_object+0xdd/0x1c0 [cachefiles]
  fscache_update_aux_data+0x23/0x30 [fscache]
  fscache_drop_object+0x18e/0x1c0 [fscache]
  fscache_object_work_func+0x74/0x2b0 [fscache]
  process_one_work+0x18d/0x340
  worker_thread+0x2e/0x390
  ? pwq_unbound_release_workfn+0xd0/0xd0
  kthread+0x112/0x130
  ? kthread_bind+0x30/0x30
  ret_from_fork+0x35/0x40

Note that there are actually two issues here: (1) EACCES happened on a
cache object and (2) an oops occurred.  I think that the second is a
consequence of the first (it certainly looks like it ought to be).  This
patch only deals with the second.

Fixes: 402cb8dda949 ("fscache: Attach the index key and aux data to the cookie")
Reported-by: Zhibin Li <zhibli@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cachefiles/xattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 0a29a00aed2e..511e6c68156a 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -135,7 +135,8 @@ int cachefiles_update_object_xattr(struct cachefiles_object *object,
 	struct dentry *dentry = object->dentry;
 	int ret;
 
-	ASSERT(dentry);
+	if (!dentry)
+		return -ESTALE;
 
 	_enter("%p,#%d", object, auxdata->len);
 
-- 
2.19.1




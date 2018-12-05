Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A494C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5342084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rn+HcoPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5342084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbeLEJlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:41:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeLEJlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:41:02 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 199B120850;
        Wed,  5 Dec 2018 09:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002862;
        bh=xSsXuhGdBxSpS2iw2aQoeric6mX2S0zyQGx+7LHxbuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rn+HcoPh7IUf4RmFRWoRPdpLt7TKydhYV/hCTuT84vgzXyROKAOcvrqTmgP/0t19d
         MlWjBKf/73XG+UgNTRumow+10aW/rgZ1WlDemYvMQzTIOS+G8mSpxHafR6gCW9ORZ8
         gSHpBl2VT0SRQkHvglX/3z7xBF5ue2HMLf1lHFUQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 091/123] cachefiles: Fix an assertion failure when trying to update a failed object
Date:   Wed,  5 Dec 2018 04:35:23 -0500
Message-Id: <20181205093555.5386-91-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

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
2.17.1


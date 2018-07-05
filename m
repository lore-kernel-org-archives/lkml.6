Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5B6C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36B6240CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36B6240CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754306AbeGEQb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:31:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753982AbeGEQbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:31:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4792C401CB89;
        Thu,  5 Jul 2018 16:31:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 370862166BA9;
        Thu,  5 Jul 2018 16:31:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/4] cachefiles: Fix missing clear of the
 CACHEFILES_OBJECT_ACTIVE flag
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     kiran.modukuri@gmail.com, carmark.dlut@gmail.com,
        vegard.nossum@gmail.com, linux-kernel@vger.kernel.org,
        neilb@suse.com, aderobertis@metrics.net, dhowells@redhat.com,
        dja@axtens.net
Date:   Thu, 05 Jul 2018 17:31:23 +0100
Message-ID: <153080828373.5496.13488467818713940417.stgit@warthog.procyon.org.uk>
In-Reply-To: <153080826773.5496.7106875523806885716.stgit@warthog.procyon.org.uk>
References: <153080826773.5496.7106875523806885716.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 05 Jul 2018 16:31:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 05 Jul 2018 16:31:25 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KiranKumar Modukuri <kiran.modukuri@gmail.com>

In cachefiles_mark_object_active(), the new object is marked active and
then we try to add it to the active object tree.  If a conflicting object
is already present, we want to wait for that to go away.  After the wait,
we go round again and try to re-mark the object as being active - but it's
already marked active from the first time we went through and a BUG is
issued.

Fix this by clearing the CACHEFILES_OBJECT_ACTIVE flag before we try again.

Analysis from Kiran Kumar Modukuri:

[Impact]
Oops during heavy NFS + FSCache + Cachefiles

CacheFiles: Error: Overlong wait for old active object to go away.

BUG: unable to handle kernel NULL pointer dereference at 0000000000000002

CacheFiles: Error: Object already active kernel BUG at
fs/cachefiles/namei.c:163!

[Cause]
In a heavily loaded system with big files being read and truncated, an
fscache object for a cookie is being dropped and a new object being
looked. The new object being looked for has to wait for the old object
to go away before the new object is moved to active state.

[Fix]
Clear the flag 'CACHEFILES_OBJECT_ACTIVE' for the new object when
retrying the object lookup.

[Testcase]
Have run ~100 hours of NFS stress tests and have not seen this bug recur.

[Regression Potential]
 - Limited to fscache/cachefiles.

Signed-off-by: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/namei.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index ab0bbe93b398..b5d6dd72dfa0 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -186,6 +186,7 @@ static int cachefiles_mark_object_active(struct cachefiles_cache *cache,
 	 * need to wait for it to be destroyed */
 wait_for_old_object:
 	trace_cachefiles_wait_active(object, dentry, xobject);
+	clear_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags);
 
 	if (fscache_object_is_live(&xobject->fscache)) {
 		pr_err("\n");
@@ -248,7 +249,6 @@ static int cachefiles_mark_object_active(struct cachefiles_cache *cache,
 	goto try_again;
 
 requeue:
-	clear_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags);
 	cache->cache.ops->put_object(&xobject->fscache, cachefiles_obj_put_wait_timeo);
 	_leave(" = -ETIMEDOUT");
 	return -ETIMEDOUT;


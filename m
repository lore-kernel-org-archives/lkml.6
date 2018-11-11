Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2820C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72610214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:27:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72610214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbeKLGQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:16:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50836 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730609AbeKLFs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:26 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsl-0000lG-MD; Sun, 11 Nov 2018 19:58:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsY-0001mL-7A; Sun, 11 Nov 2018 19:58:42 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Kiran Kumar Modukuri" <kiran.modukuri@gmail.com>,
        "David Howells" <dhowells@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.31400808@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 291/366] cachefiles: Fix missing clear of the
 CACHEFILES_OBJECT_ACTIVE flag
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

From: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>

commit 5ce83d4bb7d8e11e8c1c687d09f4b5ae67ef3ce3 upstream.

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

Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
Signed-off-by: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cachefiles/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -189,6 +189,7 @@ try_again:
 	/* an old object from a previous incarnation is hogging the slot - we
 	 * need to wait for it to be destroyed */
 wait_for_old_object:
+	clear_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags);
 	if (fscache_object_is_live(&object->fscache)) {
 		pr_err("\n");
 		pr_err("Error: Unexpected object collision\n");
@@ -250,7 +251,6 @@ wait_for_old_object:
 	goto try_again;
 
 requeue:
-	clear_bit(CACHEFILES_OBJECT_ACTIVE, &object->flags);
 	cache->cache.ops->put_object(&xobject->fscache);
 	_leave(" = -ETIMEDOUT");
 	return -ETIMEDOUT;


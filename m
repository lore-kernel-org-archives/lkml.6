Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CECC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5476921508
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5476921508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbeKLGQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:16:09 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50882 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730636AbeKLFs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:27 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsl-0000l7-Pv; Sun, 11 Nov 2018 19:58:56 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsY-0001m6-36; Sun, 11 Nov 2018 19:58:42 +0000
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
Message-ID: <lsq.1541965745.901763988@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 288/366] fscache: Allow cancelled operations to be
 enqueued
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

commit d0eb06afe712b7b103b6361f40a9a0c638524669 upstream.

Alter the state-check assertion in fscache_enqueue_operation() to allow
cancelled operations to be given processing time so they can be cleaned up.

Also fix a debugging statement that was requiring such operations to have
an object assigned.

Fixes: 9ae326a69004 ("CacheFiles: A cache that backs onto a mounted filesystem")
Reported-by: Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/fscache/operation.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/fscache/operation.c
+++ b/fs/fscache/operation.c
@@ -37,7 +37,8 @@ void fscache_enqueue_operation(struct fs
 	ASSERT(op->processor != NULL);
 	ASSERT(fscache_object_is_available(op->object));
 	ASSERTCMP(atomic_read(&op->usage), >, 0);
-	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_IN_PROGRESS);
+	ASSERTIFCMP(op->state != FSCACHE_OP_ST_IN_PROGRESS,
+		    op->state, ==,  FSCACHE_OP_ST_CANCELLED);
 
 	fscache_stat(&fscache_n_op_enqueue);
 	switch (op->flags & FSCACHE_OP_TYPE) {
@@ -401,7 +402,8 @@ void fscache_put_operation(struct fscach
 	struct fscache_cache *cache;
 
 	_enter("{OBJ%x OP%x,%d}",
-	       op->object->debug_id, op->debug_id, atomic_read(&op->usage));
+	       op->object ? op->object->debug_id : 0,
+	       op->debug_id, atomic_read(&op->usage));
 
 	ASSERTCMP(atomic_read(&op->usage), >, 0);
 


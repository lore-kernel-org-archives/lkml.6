Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F71FC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD476210E0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD476210E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbeGEQbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:31:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753818AbeGEQbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:31:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CD2B401CB89;
        Thu,  5 Jul 2018 16:31:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54D2D2026D74;
        Thu,  5 Jul 2018 16:31:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/4] cachefiles: Fix assertion "6 == 5 is false" at
 fs/fscache/operation.c:494
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     kiran.modukuri@gmail.com, carmark.dlut@gmail.com,
        vegard.nossum@gmail.com, linux-kernel@vger.kernel.org,
        neilb@suse.com, aderobertis@metrics.net, dhowells@redhat.com,
        dja@axtens.net
Date:   Thu, 05 Jul 2018 17:31:07 +0100
Message-ID: <153080826773.5496.7106875523806885716.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 05 Jul 2018 16:31:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 05 Jul 2018 16:31:09 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kiran modukuri <kiran.modukuri@gmail.com>

There is a potential race in fscache operation enqueuing for reading and
copying multiple pages from cachefiles to netfs.
Under some heavy load system, it will happen very often.

If this race occurs, an oops similar to the following is seen:

 kernel BUG at fs/fscache/operation.c:69!
 invalid opcode: 0000 [#1] SMP
 ...
 #0 [ffff883fff0838d8] machine_kexec at ffffffff81051beb
 #1 [ffff883fff083938] crash_kexec at ffffffff810f2542
 #2 [ffff883fff083a08] oops_end at ffffffff8163e1a8
 #3 [ffff883fff083a30] die at ffffffff8101859b
 #4 [ffff883fff083a60] do_trap at ffffffff8163d860
 #5 [ffff883fff083ab0] do_invalid_op at ffffffff81015204
 #6 [ffff883fff083b60] invalid_op at ffffffff8164701e
    [exception RIP: fscache_enqueue_operation+246]
    RIP: ffffffffa0b793c6  RSP: ffff883fff083c18  RFLAGS: 00010046
    RAX: 0000000000000019  RBX: ffff8832ed1a9ec0  RCX: 0000000000000006
    RDX: 0000000000000000  RSI: 0000000000000046  RDI: 0000000000000046
    RBP: ffff883fff083c20   R8: 0000000000000086   R9: 000000000000178f
    R10: ffffffff816aeb00  R11: ffff883fff08392e  R12: ffff8802f0525620
    R13: ffff88407ffc01d8  R14: 0000000000000000  R15: 0000000000000003
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
 #7 [ffff883fff083c10] fscache_enqueue_operation at ffffffffa0b793c6
 #8 [ffff883fff083c28] cachefiles_read_waiter at ffffffffa0b15a48
 #9 [ffff883fff083c48] __wake_up_common at ffffffff810af028

Reported-by: Lei Xue <carmark.dlut@gmail.com>
Reported-by: Vegard Nossum <vegard.nossum@gmail.com>
Reported-by: Anthony DeRobertis <aderobertis@metrics.net>
Reported-by: NeilBrown <neilb@suse.com>
Reported-by: Daniel Axtens <dja@axtens.net>
Reported-by: KiranKumar Modukuri <kiran.modukuri@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/rdwr.c   |   17 ++++++++++++-----
 fs/fscache/operation.c |    6 ++++--
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 5082c8a49686..40f7595aad10 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -27,6 +27,7 @@ static int cachefiles_read_waiter(wait_queue_entry_t *wait, unsigned mode,
 	struct cachefiles_one_read *monitor =
 		container_of(wait, struct cachefiles_one_read, monitor);
 	struct cachefiles_object *object;
+	struct fscache_retrieval *op = monitor->op;
 	struct wait_bit_key *key = _key;
 	struct page *page = wait->private;
 
@@ -51,16 +52,22 @@ static int cachefiles_read_waiter(wait_queue_entry_t *wait, unsigned mode,
 	list_del(&wait->entry);
 
 	/* move onto the action list and queue for FS-Cache thread pool */
-	ASSERT(monitor->op);
+	ASSERT(op);
 
-	object = container_of(monitor->op->op.object,
-			      struct cachefiles_object, fscache);
+	/* We need to temporarily bump the usage count as we don't own a ref
+	 * here otherwise cachefiles_read_copier() may free the op between the
+	 * monitor being enqueued on the op->to_do list and the op getting
+	 * enqueued on the work queue.
+	 */
+	fscache_get_retrieval(op);
 
+	object = container_of(op->op.object, struct cachefiles_object, fscache);
 	spin_lock(&object->work_lock);
-	list_add_tail(&monitor->op_link, &monitor->op->to_do);
+	list_add_tail(&monitor->op_link, &op->to_do);
 	spin_unlock(&object->work_lock);
 
-	fscache_enqueue_retrieval(monitor->op);
+	fscache_enqueue_retrieval(op);
+	fscache_put_retrieval(op);
 	return 0;
 }
 
diff --git a/fs/fscache/operation.c b/fs/fscache/operation.c
index e30c5975ea58..8d265790374c 100644
--- a/fs/fscache/operation.c
+++ b/fs/fscache/operation.c
@@ -70,7 +70,8 @@ void fscache_enqueue_operation(struct fscache_operation *op)
 	ASSERT(op->processor != NULL);
 	ASSERT(fscache_object_is_available(op->object));
 	ASSERTCMP(atomic_read(&op->usage), >, 0);
-	ASSERTCMP(op->state, ==, FSCACHE_OP_ST_IN_PROGRESS);
+	ASSERTIFCMP(op->state != FSCACHE_OP_ST_IN_PROGRESS,
+		    op->state, ==,  FSCACHE_OP_ST_CANCELLED);
 
 	fscache_stat(&fscache_n_op_enqueue);
 	switch (op->flags & FSCACHE_OP_TYPE) {
@@ -499,7 +500,8 @@ void fscache_put_operation(struct fscache_operation *op)
 	struct fscache_cache *cache;
 
 	_enter("{OBJ%x OP%x,%d}",
-	       op->object->debug_id, op->debug_id, atomic_read(&op->usage));
+	       op->object ? op->object->debug_id : 0,
+	       op->debug_id, atomic_read(&op->usage));
 
 	ASSERTCMP(atomic_read(&op->usage), >, 0);
 


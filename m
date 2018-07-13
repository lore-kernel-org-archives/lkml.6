Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16851ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E3F208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E3F208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbeGMN5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:57:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729623AbeGMN5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:57:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E5287DAC8;
        Fri, 13 Jul 2018 13:43:09 +0000 (UTC)
Received: from llong.com (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50FC310FFE54;
        Fri, 13 Jul 2018 13:43:06 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, chuhu@redhat.com,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] debugobjects: Disable lockdep tracking of debugobjects internal locks
Date:   Fri, 13 Jul 2018 09:42:27 -0400
Message-Id: <1531489347-26826-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 13 Jul 2018 13:43:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 13 Jul 2018 13:43:09 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was discovered that running the ltp openposix_testsuite sigqueue-09-1
test on a certain 8-sock IvyBridge system caused it to have a hard lockup
with a full debug kernel.

 [89981.861500] NMI watchdog: Watchdog detected hard LOCKUP on cpu 17
   :
 [89981.939812] irq event stamp: 1166122
 [89981.943799] hardirqs last  enabled at (1166121): [<ffffffffb1048342>] kprobe_ftrace_handler+0x52/0x170
 [89981.954215] hardirqs last disabled at (1166122): [<ffffffffb08a3725>] tasklist_write_lock_irq+0x15/0x50
   :
 [89982.103134]  [<ffffffffb093a399>] lock_acquire+0x99/0x1e0
 [89982.109163]  [<ffffffffb0c0d19b>] ? debug_check_no_obj_freed+0xfb/0x270
 [89982.116562]  [<ffffffffb1042e1e>] _raw_spin_lock_irqsave+0x5e/0xa0
 [89982.123470]  [<ffffffffb0c0d19b>] ? debug_check_no_obj_freed+0xfb/0x270
 [89982.130851]  [<ffffffffb0c0d19b>] debug_check_no_obj_freed+0xfb/0x270
 [89982.138045]  [<ffffffffb08bf9f3>] ? __sigqueue_free.part.11+0x33/0x40
 [89982.145239]  [<ffffffffb0a6868a>] kmem_cache_free+0xca/0x390
 [89982.151553]  [<ffffffffb08bf9f3>] __sigqueue_free.part.11+0x33/0x40
 [89982.158552]  [<ffffffffb08c07b0>] flush_sigqueue+0x50/0x60
 [89982.164673]  [<ffffffffb08ad102>] release_task+0x3e2/0x6d0
   :

IRQ was disabled by the tasklist_write_lock_irq() call in
release_task(). The lockup is probably caused by the debug code running
for too long. We certainly want the debug code to verify the correctness
of the production code. However, there may not have too much value for
one piece of the debug code to verify the correctness of another piece
of debug code. In this particular case, the lockdep code is verifying
the correctness of the raw debug bucket lock within the debugobjects
code.

The use of spin locks in the debugobjects code for synchronization is
pretty standard and looks to be correct to me. So it is probably not
worth the effort to verify lock usage within the debugobjects code.

This patch disables the checking of the debugobjects internal locks by
lockdep. In fact, with this change, the hard lockup was not observed
anymore.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 994be48..592d2ba 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1103,8 +1103,15 @@ void __init debug_objects_early_init(void)
 {
 	int i;
 
-	for (i = 0; i < ODEBUG_HASH_SIZE; i++)
+	/*
+	 * We don't need lockdep to verify correctness of debugobjects
+	 * internal locks.
+	 */
+	lockdep_set_novalidate_class(&pool_lock);
+	for (i = 0; i < ODEBUG_HASH_SIZE; i++) {
 		raw_spin_lock_init(&obj_hash[i].lock);
+		lockdep_set_novalidate_class(&obj_hash[i].lock);
+	}
 
 	for (i = 0; i < ODEBUG_POOL_SIZE; i++)
 		hlist_add_head(&obj_static_pool[i].node, &obj_pool);
-- 
1.8.3.1


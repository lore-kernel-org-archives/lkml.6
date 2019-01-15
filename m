Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25CAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9998920866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390790AbfAOV4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:56:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733202AbfAOV4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:56:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FAE4811D9;
        Tue, 15 Jan 2019 21:56:03 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 583255C225;
        Tue, 15 Jan 2019 21:55:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        SRINIVAS <srinivas.eeda@oracle.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/qspinlock: Add bug check for exceeding MAX_NODES
Date:   Tue, 15 Jan 2019 16:55:44 -0500
Message-Id: <1547589344-11504-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 15 Jan 2019 21:56:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures, it is possible to have nested NMIs taking
spinlocks nestedly. Even though the chance of having more than 4 nested
spinlocks with contention is extremely small, there could still be a
possibility that it may happen some days leading to system panic.

What we don't want is a silent corruption with system panic somewhere
else. So add a BUG_ON() check to make sure that a system panic caused
by this will show the correct root cause.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 8a8c3c2..f823221 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -412,6 +412,16 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
 
+	/*
+	 * 4 nodes are allocated based on the assumption that there will
+	 * not be nested NMIs taking spinlocks. That may not be true in
+	 * some architectures even though the chance of needing more than
+	 * 4 nodes will still be extremely unlikely. Adding a bug check
+	 * here to make sure there won't be a silent corruption in case
+	 * this condition happens.
+	 */
+	BUG_ON(idx >= MAX_NODES);
+
 	node = grab_mcs_node(node, idx);
 
 	/*
-- 
1.8.3.1


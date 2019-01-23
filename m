Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C06C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A877021726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfAWDt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 22:49:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfAWDtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 22:49:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 182E52D7E4;
        Wed, 23 Jan 2019 03:49:24 +0000 (UTC)
Received: from llong.com (ovpn-120-224.rdu2.redhat.com [10.10.120.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 695A15D6A9;
        Wed, 23 Jan 2019 03:49:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        James Morse <james.morse@arm.com>,
        SRINIVAS <srinivas.eeda@oracle.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/4] locking/qspinlock: Handle > 4 slowpath nesting levels
Date:   Tue, 22 Jan 2019 22:49:08 -0500
Message-Id: <1548215351-18896-2-git-send-email-longman@redhat.com>
In-Reply-To: <1548215351-18896-1-git-send-email-longman@redhat.com>
References: <1548215351-18896-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 23 Jan 2019 03:49:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Four queue nodes per cpu are allocated to enable up to 4 nesting levels
using the per-cpu nodes. Nested NMIs are possible in some architectures.
Still it is very unlikely that we will ever hit more than 4 nested
levels with contention in the slowpath.

When that rare condition happens, however, it is likely that the system
will hang or crash shortly after that. It is not good and we need to
handle this exception case.

This is done by spinning directly on the lock using repeated trylock.
This alternative code path should only be used when there is nested
NMIs. Assuming that the locks used by those NMI handlers will not be
heavily contended, a simple TAS locking should work out.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 8a8c3c2..0875053 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -412,6 +412,21 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
 
+	/*
+	 * 4 nodes are allocated based on the assumption that there will
+	 * not be nested NMIs taking spinlocks. That may not be true in
+	 * some architectures even though the chance of needing more than
+	 * 4 nodes will still be extremely unlikely. When that happens,
+	 * we fall back to spinning on the lock directly without using
+	 * any MCS node. This is not the most elegant solution, but is
+	 * simple enough.
+	 */
+	if (unlikely(idx >= MAX_NODES)) {
+		while (!queued_spin_trylock(lock))
+			cpu_relax();
+		goto release;
+	}
+
 	node = grab_mcs_node(node, idx);
 
 	/*
-- 
1.8.3.1


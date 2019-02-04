Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13B9C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798AC2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbfBDI6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:58:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33741 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfBDI6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:58:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x148wErA358409
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 00:58:14 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x148wEIC358406;
        Mon, 4 Feb 2019 00:58:14 -0800
Date:   Mon, 4 Feb 2019 00:58:14 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-d682b596d99345ef0000e7017db714ba7f29e017@git.kernel.org>
Cc:     mingo@kernel.org, will.deacon@arm.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        longman@redhat.com, bp@alien8.de, peterz@infradead.org,
        hpa@zytor.com, srinivas.eeda@oracle.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        james.morse@arm.com, zhenzhong.duan@oracle.com
Reply-To: srinivas.eeda@oracle.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
          james.morse@arm.com, zhenzhong.duan@oracle.com,
          peterz@infradead.org, bp@alien8.de, hpa@zytor.com,
          torvalds@linux-foundation.org, akpm@linux-foundation.org,
          longman@redhat.com, mingo@kernel.org, will.deacon@arm.com
In-Reply-To: <1548798828-16156-2-git-send-email-longman@redhat.com>
References: <1548798828-16156-2-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/qspinlock: Handle > 4 slowpath nesting
 levels
Git-Commit-ID: d682b596d99345ef0000e7017db714ba7f29e017
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d682b596d99345ef0000e7017db714ba7f29e017
Gitweb:     https://git.kernel.org/tip/d682b596d99345ef0000e7017db714ba7f29e017
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Tue, 29 Jan 2019 22:53:45 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 09:03:29 +0100

locking/qspinlock: Handle > 4 slowpath nesting levels

Four queue nodes per CPU are allocated to enable up to 4 nesting levels
using the per-CPU nodes. Nested NMIs are possible in some architectures.
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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: James Morse <james.morse@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: SRINIVAS <srinivas.eeda@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Link: https://lkml.kernel.org/r/1548798828-16156-2-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/qspinlock.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 8a8c3c208c5e..0875053c4050 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -412,6 +412,21 @@ pv_queue:
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

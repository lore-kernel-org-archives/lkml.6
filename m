Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FF8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BB0218E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991697;
	bh=L+Y1DuHfZGLNVEoa0qIA/AZrCA7NGIYo11vaqyPf4Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G9Ly8tJMboGWA6kgBaOmLqQ+tmhLbgTVzzp5muB8/ruL9BYpujwZ2GYAa1Q1Bakru
	 pvl2cuuFv20MEd6Thtcy0prpAVdg7WAmfVYG75ATs9rC4oiygb5/I9/pTTHGGeA2uB
	 gVOkkKu20/n0UoeKPty4QY/281y44ftOHU6wzV7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbfBLRO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:14:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731413AbfBLROx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:14:53 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CEDC218CD;
        Tue, 12 Feb 2019 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991692;
        bh=L+Y1DuHfZGLNVEoa0qIA/AZrCA7NGIYo11vaqyPf4Fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yOfqMfOipjd/QrMKHeY4LLJRgip0gOiD9za7YWjRzRjas6m58iHYfDQJRud52VRHe
         cenqHKQamwLYQgOMsie+M/yf5dV2TJtQiX1Yru1zXh70eQUuaISZaeQvEGHWz//ovl
         5O/3+8nJCJffjVOOyFozXpeWdm4qbb3VaIPmxggs=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 07/32] locking/lockdep: Prepare state_verbose() to handle all softirqs
Date:   Tue, 12 Feb 2019 18:13:58 +0100
Message-Id: <20190212171423.8308-8-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loosely handle all the softirq vectors verbosity under the same
function.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bb66327e5cc3..baba291f2cab 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2755,17 +2755,13 @@ static int SOFTIRQ_verbose(struct lock_class *class)
 
 #define STRICT_READ_CHECKS	1
 
-static int (*state_verbose_f[])(struct lock_class *class) = {
-#define LOCKDEP_STATE(__STATE) \
-	__STATE##_verbose,
-#include "lockdep_states.h"
-#undef LOCKDEP_STATE
-};
-
 static inline int state_verbose(enum lock_usage_bit bit,
 				struct lock_class *class)
 {
-	return state_verbose_f[bit >> 2](class);
+	if (bit < LOCK_USED_IN_SOFTIRQ)
+		return HARDIRQ_verbose(class);
+	else
+		return SOFTIRQ_verbose(class);
 }
 
 typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
-- 
2.17.1


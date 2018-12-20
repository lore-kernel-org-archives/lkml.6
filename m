Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB689C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C78E218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297822;
	bh=4mgxCwN3c7stIF7DaRR6hpA8/s978jHfoai1o3qzOXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KFuSJ50VLieSPjTEA8UL0EwdjUkhOEuHOpUBhfTT7K1oO4YFkVZ8taKQyXuXBwaWv
	 TfkL8CWu+xaeZqRV/gcMzaprWPPVzBjkcsgtebwjXGJzaTUkTaI0iz/eC1HDl3fjne
	 cGpspdNBkPvU620d3qhC25bomRQ9RM/0WG9g/t80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbeLTJXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:23:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731633AbeLTJXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:23:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E2CB218A6;
        Thu, 20 Dec 2018 09:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297817;
        bh=4mgxCwN3c7stIF7DaRR6hpA8/s978jHfoai1o3qzOXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D9SbbLr0hwT1cnkgSqvTnt5vFIgxYorPmgBYSm+7qxjhvDqWwN5P9NknclP1Dg95V
         d89Xh7Wb/0lskhCt7Ftq3Dy/wQqC3NvR6a00dIu6p2MPKGoPk77kCqVKXFkg0eP3zW
         PAWec3zacFpjWy9OILdc5M0ov7XKsW28t5fMcIYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, boqun.feng@gmail.com,
        linux-arm-kernel@lists.infradead.org, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 28/61] locking/qspinlock/x86: Increase _Q_PENDING_LOOPS upper bound
Date:   Thu, 20 Dec 2018 10:18:28 +0100
Message-Id: <20181220085844.858853635@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

commit b247be3fe89b6aba928bf80f4453d1c4ba8d2063 upstream.

On x86, atomic_cond_read_relaxed will busy-wait with a cpu_relax() loop,
so it is desirable to increase the number of times we spin on the qspinlock
lockword when it is found to be transitioning from pending to locked.

According to Waiman Long:

 | Ideally, the spinning times should be at least a few times the typical
 | cacheline load time from memory which I think can be down to 100ns or
 | so for each cacheline load with the newest systems or up to several
 | hundreds ns for older systems.

which in his benchmarking corresponded to 512 iterations.

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-5-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/qspinlock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index e07cc206919d..8b1ba1607091 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -5,6 +5,8 @@
 #include <asm-generic/qspinlock_types.h>
 #include <asm/paravirt.h>
 
+#define _Q_PENDING_LOOPS	(1 << 9)
+
 #define	queued_spin_unlock queued_spin_unlock
 /**
  * queued_spin_unlock - release a queued spinlock
-- 
2.19.1




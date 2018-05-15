Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeEOWqT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:46:19 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:44940 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeEOWqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:46:18 -0400
X-Google-Smtp-Source: AB8JxZqIYC91ohHUhYROA+VN/FSZITpgUN9HXcevcc5fRjkznSahZdw1ERYRd8xIyBWAeDOL0cJFFQ==
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v7 1/6] softirq: reorder trace_softirqs_on to prevent lockdep splat
Date: Tue, 15 May 2018 15:45:54 -0700
Message-Id: <20180515224559.199279-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180515224559.199279-1-joel@joelfernandes.org>
References: <20180515224559.199279-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm able to reproduce a lockdep splat with config options:
CONFIG_PROVE_LOCKING=y,
CONFIG_DEBUG_LOCK_ALLOC=y and
CONFIG_PREEMPTIRQ_EVENTS=y

$ echo 1 > /d/tracing/events/preemptirq/preempt_enable/enable
---
 kernel/softirq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 177de3640c78..8a040bcaa033 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -139,9 +139,13 @@ static void __local_bh_enable(unsigned int cnt)
 {
 	lockdep_assert_irqs_disabled();
 
+	if (preempt_count() == cnt)
+		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
+
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
 		trace_softirqs_on(_RET_IP_);
-	preempt_count_sub(cnt);
+
+	__preempt_count_sub(cnt);
 }
 
 /*
-- 
2.17.0.441.gb46fe60e1d-goog

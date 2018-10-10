Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC39C46463
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D690E2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aylXBfl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D690E2150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeJKGhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbeJKGhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:02 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E918721470;
        Wed, 10 Oct 2018 23:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213161;
        bh=sdmMctHRff1kBDwHUErxtowZf2iV1Aq4LBgBL1UOs0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aylXBfl3Kx8osCRc8kGrFwL3pRZnhfy0XUXGavHARphu4DXMCifh0D/lu7Duzp7vo
         6oRP3nYn9rjUZUli7ZaXFGz7wpdLBHCFHvmRMvIxC9vcrK4oH4fOnJb/ZntyVfNNWq
         /gazwAyFDlGGFu6rcfvlU9cavZ4GvpPZz/FpmiQs=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 03/30] softirq: Implement local_softirq_pending() below softirq vector definition
Date:   Thu, 11 Oct 2018 01:11:50 +0200
Message-Id: <1539213137-13953-4-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The future extensions of this API are going to depend on the vector
definitions. So order the code accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/interrupt.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5888545..1de87ec 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -432,18 +432,6 @@ extern bool force_irqthreads;
 #define force_irqthreads	(0)
 #endif
 
-#ifndef local_softirq_pending
-
-#ifndef local_softirq_data_ref
-#define local_softirq_data_ref irq_stat.__softirq_data
-#endif
-
-#define local_softirq_pending()	(__this_cpu_read(local_softirq_data_ref))
-#define set_softirq_pending(x)	(__this_cpu_write(local_softirq_data_ref, (x)))
-#define or_softirq_pending(x)	(__this_cpu_or(local_softirq_data_ref, (x)))
-
-#endif /* local_softirq_pending */
-
 /* Some architectures might implement lazy enabling/disabling of
  * interrupts. In some cases, such as stop_machine, we might want
  * to ensure that after a local_irq_disable(), interrupts have
@@ -479,6 +467,19 @@ enum
 
 #define SOFTIRQ_STOP_IDLE_MASK (~(1 << RCU_SOFTIRQ))
 
+#ifndef local_softirq_pending
+
+#ifndef local_softirq_data_ref
+#define local_softirq_data_ref irq_stat.__softirq_data
+#endif
+
+#define local_softirq_pending()	(__this_cpu_read(local_softirq_data_ref))
+#define set_softirq_pending(x)	(__this_cpu_write(local_softirq_data_ref, (x)))
+#define or_softirq_pending(x)	(__this_cpu_or(local_softirq_data_ref, (x)))
+
+#endif /* local_softirq_pending */
+
+
 /* map softirq index to softirq name. update 'softirq_to_name' in
  * kernel/softirq.c when adding a new softirq.
  */
-- 
2.7.4


Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3102C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C18222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991901;
	bh=DUcofyO8/UmAYNhgoQstOpkbXlN1AH31spkP270JnjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wGAtzrJC173SS4TAdUR0WWeGOMSk7mKQTapI/AAjnuSi8bo6FBZhXZSlok2JaA2OC
	 Dp67Vdow2VGCNKD3ak1dH3A2F57kuJEq8R/jscszcN1r7Qvb824O5WH68J+bb8xFsB
	 L2KR2kEK/fKH55YfYHROjJnnnsYxK+GoDc8S9/DU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbfBLRPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:15:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731501AbfBLRPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:16 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBCCD21B25;
        Tue, 12 Feb 2019 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991715;
        bh=DUcofyO8/UmAYNhgoQstOpkbXlN1AH31spkP270JnjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=El7EGAzoI5V9PsDmAmamD6+MH8BpTUDgRoMt21Ot1nYAMhKYqal9LkVCE2smVi+p8
         oyly0SEcMxZTnEZl5vJJUVXB1ds/Wal5Y1AwLgFR/1YrnhVsHbjKLEkZGGkOufe0Pc
         /h09ufI+lFgOnkssfAMMf4PMB2LgtGiwDPMWsSbs=
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
Subject: [PATCH 14/32] x86: Revert "x86/irq: Demote irq_cpustat_t::__softirq_pending to u16"
Date:   Tue, 12 Feb 2019 18:14:05 +0100
Message-Id: <20190212171423.8308-15-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9aee5f8a7e30330d0a8f4c626dc924ca5590aba5.

We are going to need the 16 high bits above in order to implement
a softirq enable mask. x86 is the only architecture that doesn't use
unsigned int to implement softirq_pending.

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
 arch/x86/include/asm/hardirq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index d9069bb26c7f..a8e8e126b421 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -5,7 +5,7 @@
 #include <linux/threads.h>
 
 typedef struct {
-	u16	     __softirq_pending;
+	unsigned int __softirq_pending;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 	u8	     kvm_cpu_l1tf_flush_l1d;
 #endif
-- 
2.17.1


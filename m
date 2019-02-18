Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91661C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACB321738
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389338AbfBRQbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:31:40 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57145 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732378AbfBRQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:31:40 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gvlpR-0003AQ-Tn; Mon, 18 Feb 2019 17:31:38 +0100
Date:   Mon, 18 Feb 2019 17:31:37 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/2] x86: lazy-preempt: properly check against preempt-mask
Message-ID: <20190218163137.cmor4ek3odus5m6j@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

should_resched() should check against preempt_offset after unmasking the
need-resched-bit. Otherwise should_resched() won't work for
preempt_offset != 0 and lazy-preempt set.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/preempt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 22992c8377952..f667087792747 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -118,7 +118,7 @@ static __always_inline bool should_resched(int preempt_offset)
 
 	/* preempt count == 0 ? */
 	tmp &= ~PREEMPT_NEED_RESCHED;
-	if (tmp)
+	if (tmp != preempt_offset)
 		return false;
 	if (current_thread_info()->preempt_lazy_count)
 		return false;
-- 
2.20.1


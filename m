Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE04EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD8622438
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="FzQo4Hxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD8622438
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754053AbeGESGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:06:38 -0400
Received: from mail.efficios.com ([167.114.142.138]:58766 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753921AbeGESGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:06:13 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CA4A3231D5E;
        Thu,  5 Jul 2018 14:06:12 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ldwRbtWtUQsq; Thu,  5 Jul 2018 14:06:12 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6200C231D50;
        Thu,  5 Jul 2018 14:06:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6200C231D50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530813972;
        bh=wTjhC11xQ/uetC2sAZfYnMYWq3bmN6FdTrWxKZ8sUZk=;
        h=From:To:Date:Message-Id;
        b=FzQo4Hxr1gaTEAh7rJ17eCnkHNLvJPiWEbb/xich/ydeinfCH4L+LNNUpYhDBwPWg
         agqTouyw/MoAb+MP729hr19Quz4y7Ash1f/Dw8PR0RQBplvcalHcOcJVvTRhTJmg2C
         oN1idGXPSd0l408XPzxJyYmqRf/nKIo50fiC5JRFHxcW466xDenhEquaM4vM+uchFY
         Qfe8LZ7O0aowUCY/f0eOpZC89ZaX3KwpMpkAQ3t2WH1tt4AXD+U7fQnjm6esVu0Q54
         YjVJIqtEBaPDV3EBidsqRjBztdRaaAxBwBaav0mrx/4K3S52O5PuUjHwiTditUyIlF
         csFZaikDQ/T8A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id qWKLFuEnwRHO; Thu,  5 Jul 2018 14:06:12 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 03A9C231D41;
        Thu,  5 Jul 2018 14:06:11 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 4.18 5/5] rseq/selftests: cleanup: update comment above rseq_prepare_unload
Date:   Thu,  5 Jul 2018 14:06:01 -0400
Message-Id: <20180705180601.18423-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180705180601.18423-1-mathieu.desnoyers@efficios.com>
References: <20180705180601.18423-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rseq as it was merged does not have rseq_finish_*() in the user-space
selftests anymore. Update the rseq_prepare_unload() helper comment to
adapt to this reality.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul Turner <pjt@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: linux-api@vger.kernel.org
---
 tools/testing/selftests/rseq/rseq.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index f2073cfa4448..86ce22417e0d 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -143,12 +143,13 @@ static inline void rseq_clear_rseq_cs(void)
 }
 
 /*
- * rseq_prepare_unload() should be invoked by each thread using rseq_finish*()
- * at least once between their last rseq_finish*() and library unload of the
- * library defining the rseq critical section (struct rseq_cs). This also
- * applies to use of rseq in code generated by JIT: rseq_prepare_unload()
- * should be invoked at least once by each thread using rseq_finish*() before
- * reclaim of the memory holding the struct rseq_cs.
+ * rseq_prepare_unload() should be invoked by each thread executing a rseq
+ * critical section at least once between their last critical section and
+ * library unload of the library defining the rseq critical section
+ * (struct rseq_cs). This also applies to use of rseq in code generated by
+ * JIT: rseq_prepare_unload() should be invoked at least once by each
+ * thread executing a rseq critical section before reclaim of the memory
+ * holding the struct rseq_cs.
  */
 static inline void rseq_prepare_unload(void)
 {
-- 
2.11.0


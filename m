Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027D8C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC450208DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="g4oiTt3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC450208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeGHVE1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:04:27 -0400
Received: from mail.efficios.com ([167.114.142.138]:42224 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932766AbeGHVDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:03:43 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 48FA61C3B10;
        Sun,  8 Jul 2018 17:03:42 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id NWcgZ8W5ODua; Sun,  8 Jul 2018 17:03:41 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D1FAE1C3B00;
        Sun,  8 Jul 2018 17:03:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D1FAE1C3B00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531083821;
        bh=wTjhC11xQ/uetC2sAZfYnMYWq3bmN6FdTrWxKZ8sUZk=;
        h=From:To:Date:Message-Id;
        b=g4oiTt3VHeLq+K1yO8PgkRIR74RVNSEY6R8k/XVvXp8ASq6XT/va3Evv9VtqV/OcR
         oYuYp7mdodJnXau4QLbCjarHKovMUnQyXpNH9E5UZ45g6nsJUjOYjyGlJOm9hm23Bc
         8JJg3qJHcWWKjtF1ngXkHrjde21mmuOlVrKcxAnGY5/ZnBtZrQGiYUyNkKLC/bv4Ae
         jkL+w5MONckue7+F+zrcMLsHDevB8nKjXhApa4PZeAHZdc7yUEc5iAVuHZNr08h3oN
         OK9IxpASDro6Ve0UT2ZO3PEF5VTJMT5Jf/DtcjCqFIcQJtiv4zFgWLoE5lmw0usduP
         FlPhc+9Y50nnQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id bjOBPxriBggd; Sun,  8 Jul 2018 17:03:41 -0400 (EDT)
Received: from thinkos.etherlink (cable-192.222.247.4.electronicbox.net [192.222.247.4])
        by mail.efficios.com (Postfix) with ESMTPSA id 66EC81C3AF1;
        Sun,  8 Jul 2018 17:03:41 -0400 (EDT)
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
Subject: [PATCH for 4.18 6/6] rseq/selftests: cleanup: update comment above rseq_prepare_unload
Date:   Sun,  8 Jul 2018 17:03:30 -0400
Message-Id: <20180708210330.27324-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180708210330.27324-1-mathieu.desnoyers@efficios.com>
References: <20180708210330.27324-1-mathieu.desnoyers@efficios.com>
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


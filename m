Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB35DC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 20:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E80208AF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 20:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lhu9tN5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E80208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933079AbeFPUUh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 16:20:37 -0400
Received: from mail.efficios.com ([167.114.142.138]:53940 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932554AbeFPUUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 16:20:34 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1081E1AD662;
        Sat, 16 Jun 2018 16:20:34 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id LnAYrlEjVhV4; Sat, 16 Jun 2018 16:20:32 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D37FB1AD65D;
        Sat, 16 Jun 2018 16:20:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D37FB1AD65D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529180432;
        bh=YMwjhGfL5TbbSDYTVCSkBW8k9LlUjO4Q638FR6qXUIs=;
        h=From:To:Date:Message-Id;
        b=lhu9tN5ObIhGJ4Hzz/CaS1PzsKJoR7esz5J9php2bZuU33CF1dkz/lUufdMtq4N3f
         l3Sfk4eWfyvqrikQvhH2aoU783XB9OVHujPo9z624ykkhZQFO1cypAbateVqc+Mnvv
         yyByPjK9xi7HYYhAqHnBP5jwFtLQrVYi/rrDu7imnUpk8hA+8Yitx9EVjXORYdZuYZ
         UNNwE/PXZ95UmImPrZ/SG3lVyGOptfmtVlQvTQp2ZmjYzg7v0DqrtJkxgDtLSIU73Y
         Dn6vHkkMSk32izkFPp3dd4KTeTk88/tfSwoxJ5plefiDvTSKpsnrOQGgqBuW3VRMom
         K5xkDIqds7kAw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id yus46nI0XdfV; Sat, 16 Jun 2018 16:20:32 -0400 (EDT)
Received: from thinkos.etherlink (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 875851AD658;
        Sat, 16 Jun 2018 16:20:31 -0400 (EDT)
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH for 4.18] rseq: cleanup: no need to abort rseq c.s. in child on fork
Date:   Sat, 16 Jun 2018 16:20:13 -0400
Message-Id: <20180616202013.32354-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering that we explicitly forbid system calls in rseq critical
sections, it is not valid to issue a fork or clone system call within a
rseq critical section, so rseq_fork() is not required to restart an
active rseq c.s. in the child process.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: linux-kselftest@vger.kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Chris Lameter <cl@linux.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: linux-api@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/sched.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 87bf02d93a27..c1882643d455 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1831,9 +1831,7 @@ static inline void rseq_migrate(struct task_struct *t)
 
 /*
  * If parent process has a registered restartable sequences area, the
- * child inherits. Only applies when forking a process, not a thread. In
- * case a parent fork() in the middle of a restartable sequence, set the
- * resume notifier to force the child to retry.
+ * child inherits. Only applies when forking a process, not a thread.
  */
 static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 {
@@ -1847,7 +1845,6 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 		t->rseq_len = current->rseq_len;
 		t->rseq_sig = current->rseq_sig;
 		t->rseq_event_mask = current->rseq_event_mask;
-		rseq_preempt(t);
 	}
 }
 
-- 
2.11.0


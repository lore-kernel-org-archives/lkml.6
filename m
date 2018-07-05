Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC554C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572F92168D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="IIO20gJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572F92168D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754209AbeGESHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:07:06 -0400
Received: from mail.efficios.com ([167.114.142.138]:58666 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753816AbeGESGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:06:12 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DD44A231D3E;
        Thu,  5 Jul 2018 14:06:11 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id XcLUi5r3WMAR; Thu,  5 Jul 2018 14:06:11 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 54580231D2F;
        Thu,  5 Jul 2018 14:06:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 54580231D2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530813971;
        bh=HYFGqKYMw/NcIn/7WaghCLFrTvxg19v0iEAy6DeihaQ=;
        h=From:To:Date:Message-Id;
        b=IIO20gJVXG5nGTOf0AsPvX0fE2Zq0q++IarFv0TOU5taJOoqOGI7STzT75M33AuYN
         4Ak0JevAd7QCfLKNtDSA6glkQ+FZmZ902xf7+s58cz2BISM82PcO81qeKtxKdMeZS3
         YM9aWbGYTXLYgA3GYtimESHMGPFsXeFhtxHMthie41STRKxMRl19OnA4IWORZzoqUG
         QjdvpKAoksHa3PHgjPGVHPj66WLFOiFg1mdn5OBpzEHges57BypCFDqA35occaIfAL
         oMeOLGrzWfAss417Ry7/deDdqKAq7Y/fQTIQ11R4X4uzYddlwzZylMfy8v/D5Wzb6X
         KYhB8UDkJqf1Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 4-ZVpjxsYPz2; Thu,  5 Jul 2018 14:06:11 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id E80EE231D20;
        Thu,  5 Jul 2018 14:06:10 -0400 (EDT)
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
Subject: [RFC PATCH for 4.18 2/5] rseq: uapi: update uapi comments
Date:   Thu,  5 Jul 2018 14:05:58 -0400
Message-Id: <20180705180601.18423-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180705180601.18423-1-mathieu.desnoyers@efficios.com>
References: <20180705180601.18423-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update rseq uapi header comments to reflect that user-space need to do
thread-local loads/stores from/to the struct rseq fields.

As a consequence of this added requirement, the kernel does not need
to perform loads/stores with single-copy atomicity.

Update the comment associated to the "flags" fields to describe
more accurately that it's only useful to facilitate single-stepping
through rseq critical sections with debuggers.

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
 include/uapi/linux/rseq.h | 69 ++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 519ad6e176d1..bf4188c13bec 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -67,28 +67,30 @@ struct rseq_cs {
 struct rseq {
 	/*
 	 * Restartable sequences cpu_id_start field. Updated by the
-	 * kernel, and read by user-space with single-copy atomicity
-	 * semantics. Aligned on 32-bit. Always contains a value in the
-	 * range of possible CPUs, although the value may not be the
-	 * actual current CPU (e.g. if rseq is not initialized). This
-	 * CPU number value should always be compared against the value
-	 * of the cpu_id field before performing a rseq commit or
-	 * returning a value read from a data structure indexed using
-	 * the cpu_id_start value.
+	 * kernel. Read by user-space with single-copy atomicity
+	 * semantics. This field should only be read by the thread which
+	 * registered this data structure. Aligned on 32-bit. Always
+	 * contains a value in the range of possible CPUs, although the
+	 * value may not be the actual current CPU (e.g. if rseq is not
+	 * initialized). This CPU number value should always be compared
+	 * against the value of the cpu_id field before performing a rseq
+	 * commit or returning a value read from a data structure indexed
+	 * using the cpu_id_start value.
 	 */
 	__u32 cpu_id_start;
 	/*
-	 * Restartable sequences cpu_id field. Updated by the kernel,
-	 * and read by user-space with single-copy atomicity semantics.
-	 * Aligned on 32-bit. Values RSEQ_CPU_ID_UNINITIALIZED and
-	 * RSEQ_CPU_ID_REGISTRATION_FAILED have a special semantic: the
-	 * former means "rseq uninitialized", and latter means "rseq
-	 * initialization failed". This value is meant to be read within
-	 * rseq critical sections and compared with the cpu_id_start
-	 * value previously read, before performing the commit instruction,
-	 * or read and compared with the cpu_id_start value before returning
-	 * a value loaded from a data structure indexed using the
-	 * cpu_id_start value.
+	 * Restartable sequences cpu_id field. Updated by the kernel.
+	 * Read by user-space with single-copy atomicity semantics. This
+	 * field should only be read by the thread which registered this
+	 * data structure. Aligned on 32-bit. Values
+	 * RSEQ_CPU_ID_UNINITIALIZED and RSEQ_CPU_ID_REGISTRATION_FAILED
+	 * have a special semantic: the former means "rseq uninitialized",
+	 * and latter means "rseq initialization failed". This value is
+	 * meant to be read within rseq critical sections and compared
+	 * with the cpu_id_start value previously read, before performing
+	 * the commit instruction, or read and compared with the
+	 * cpu_id_start value before returning a value loaded from a data
+	 * structure indexed using the cpu_id_start value.
 	 */
 	__u32 cpu_id;
 	/*
@@ -105,27 +107,28 @@ struct rseq {
 	 * targeted by the rseq_cs. Also needs to be set to NULL by user-space
 	 * before reclaiming memory that contains the targeted struct rseq_cs.
 	 *
-	 * Read and set by the kernel with single-copy atomicity semantics.
-	 * Set by user-space with single-copy atomicity semantics. Aligned
-	 * on 64-bit.
+	 * Read and set by the kernel. Set by user-space with single-copy
+	 * atomicity semantics. This field should only be updated by the
+	 * thread which registered this data structure. Aligned on 64-bit.
 	 */
 	LINUX_FIELD_u32_u64(rseq_cs);
 	/*
-	 * - RSEQ_DISABLE flag:
+	 * Restartable sequences flags field.
+	 *
+	 * This field should only be updated by the thread which
+	 * registered this data structure. Read by the kernel.
+	 * Mainly used for single-stepping through rseq critical sections
+	 * with debuggers.
 	 *
-	 * Fallback fast-track flag for single-stepping.
-	 * Set by user-space if lack of progress is detected.
-	 * Cleared by user-space after rseq finish.
-	 * Read by the kernel.
 	 * - RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
-	 *     Inhibit instruction sequence block restart and event
-	 *     counter increment on preemption for this thread.
+	 *     Inhibit instruction sequence block restart on preemption
+	 *     for this thread.
 	 * - RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
-	 *     Inhibit instruction sequence block restart and event
-	 *     counter increment on signal delivery for this thread.
+	 *     Inhibit instruction sequence block restart on signal
+	 *     delivery for this thread.
 	 * - RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
-	 *     Inhibit instruction sequence block restart and event
-	 *     counter increment on migration for this thread.
+	 *     Inhibit instruction sequence block restart on migration for
+	 *     this thread.
 	 */
 	__u32 flags;
 } __attribute__((aligned(4 * sizeof(__u64))));
-- 
2.11.0


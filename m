Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5E3C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C32E224F9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cBvyLOB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C32E224F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934727AbeGFTXv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:23:51 -0400
Received: from mail.efficios.com ([167.114.142.138]:45810 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934536AbeGFTXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:23:41 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 951CF1C10EF;
        Fri,  6 Jul 2018 15:23:40 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id sEUlVwyMAtsB; Fri,  6 Jul 2018 15:23:39 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CC0331C10EB;
        Fri,  6 Jul 2018 15:23:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CC0331C10EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530905019;
        bh=5MNr4wsxLNaZ/ZmsPc+A165ovENYMSeQJN45boPnPo4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=cBvyLOB1PGx45EuQ9Pm7pz4P4KmD4gjK0pQ3f+S25cfOySJ+RqHntXYCoGqqM3GuY
         aCv9f6Itx3lNQrYnJBZezIQ88Pg9SVS8KzAZRoInVWWdb6wo4eefmwGPU/sUPYK4PU
         00EJpA6CdA0A4o9mkYziZfiuI4JTI0uSJRk9roWojUbPbUiP9A6dLbPGBndOkVX1un
         yjm3xVFGJcWLt1VLZyl+MHSoWXGBRjJ1MsHW55EyBysxS1C58PYeDGnlN8RrEcYA6v
         UGUBhY7l3u6xMz3HERijOAxYDNZEG/hzO6DmoK/YB+9gzmQHlVX0fHouSqMlXu/OzD
         ARWdqV1wI98Eg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id JT8ylWdGr3-7; Fri,  6 Jul 2018 15:23:39 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id AB4841C10E5;
        Fri,  6 Jul 2018 15:23:39 -0400 (EDT)
Date:   Fri, 6 Jul 2018 15:23:39 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <436937568.1359.1530905019620.JavaMail.zimbra@efficios.com>
In-Reply-To: <1846432971.1245.1530892973439.JavaMail.zimbra@efficios.com>
References: <20180705180601.18423-1-mathieu.desnoyers@efficios.com> <20180705180601.18423-4-mathieu.desnoyers@efficios.com> <1846432971.1245.1530892973439.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH for 4.18 3/5] rseq: uapi: declare rseq_cs field as
 union, update includes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: uapi: declare rseq_cs field as union, update includes
Thread-Index: dumXrrE9QXvjX6oA+zFCjsAeDEp42YgCpk5+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 6, 2018, at 12:02 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Jul 5, 2018, at 2:05 PM, Mathieu Desnoyers
> mathieu.desnoyers@efficios.com wrote:
> 
[...]
> The 0-day bot noticed that __get_user() is unimplemented for 64-bit
> values on arm32 (although get_user() is implemented).
> 
> The following diff fixes this discrepancy, and allows this rseq patch
> to build on arm32:
> 

For -rc, I would favor the following simpler approach. Or I could even
just use get_user() instead. Thoughts ?

    rseq: implement work-around for missing 8-byte __get_user on arm
    
    Now that rseq uses __u64 for its pointer fields, 32-bit architectures
    need to read this 64-bit value from user-space.
    
    __get_user is used to read this value, given that its access check has
    already been performed with access_ok() on rseq registration.
    
    arm does not implement 8-byte __get_user. Work-around this limitation
    by using get_user() on ARM instead, with its redundant access check.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    CC: Thomas Gleixner <tglx@linutronix.de>
    Cc: Joel Fernandes <joelaf@google.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Catalin Marinas <catalin.marinas@arm.com>
    Cc: Dave Watson <davejwatson@fb.com>
    Cc: Will Deacon <will.deacon@arm.com>
    Cc: Andi Kleen <andi@firstfloor.org>
    Cc: "H . Peter Anvin" <hpa@zytor.com>
    Cc: Chris Lameter <cl@linux.com>
    Cc: Russell King <linux@arm.linux.org.uk>
    Cc: Andrew Hunter <ahh@google.com>
    Cc: Michael Kerrisk <mtk.manpages@gmail.com>
    Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
    Cc: Paul Turner <pjt@google.com>
    Cc: Boqun Feng <boqun.feng@gmail.com>
    Cc: Josh Triplett <josh@joshtriplett.org>
    Cc: Steven Rostedt <rostedt@goodmis.org>
    Cc: Ben Maurer <bmaurer@fb.com>
    Cc: linux-api@vger.kernel.org
    CC: linux-arm-kernel@lists.infradead.org
    Cc: Andy Lutomirski <luto@amacapital.net>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 3081e67..0e67625 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -18,6 +18,16 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/rseq.h>
 
+/*
+ * ARM does not implement 8 bytes __get_user. Use get_user on that
+ * architecture instead.
+ */
+#ifdef CONFIG_ARM
+#define __rseq_get_user                get_user
+#else
+#define __rseq_get_user                __get_user
+#endif
+
 #define RSEQ_CS_PREEMPT_MIGRATE_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE | \
                                       RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT)
 
@@ -120,7 +130,7 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rs
        u32 sig;
        int ret;
 
-       ret = __get_user(ptr, &t->rseq->rseq_cs.ptr64);
+       ret = __rseq_get_user(ptr, &t->rseq->rseq_cs.ptr64);
        if (ret)
                return ret;
        if (!ptr) {



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7361FC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8372416F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RMw2NZSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8372416F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934478AbeGCS3H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:29:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47634 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934309AbeGCS3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A02AvGlvRCLOXz68szV/oVNQj9HI/k8LTtkNgv04PDQ=; b=RMw2NZSiwZGCgsQmhmx1VlLq/
        zV4/i8943bi9ZHfFvKIgrBRmj6GczM/ZT6JRCP4S7CCqBTklk/qyg26zok44ISeHXbocGjuLNa0mR
        UHWc0CIs0HIahj369hRJDlU9S85H04pMeCYE9N1qNjZ87BVTu/YgsfbLpCrBVFjIQwVMUPpPa9Z/v
        qBJVXe4YvtrhyFhwiAh6qRkXmpNFgra+ssPK+Uyrbo22W1AryCsxLJMHIAqHJ4qLaX0qrG0gqlJA5
        doi56+z5fYkwM05943XG6YqkoczjwGzrPwxn+J6MWYm2f/ISKXUiAGHYRcG3z/f9r1y45jThgOVYv
        jjhaD9PbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faQ2Y-0004oL-Cq; Tue, 03 Jul 2018 18:28:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1654320291063; Tue,  3 Jul 2018 20:28:37 +0200 (CEST)
Date:   Tue, 3 Jul 2018 20:28:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <andi@firstfloor.org>,
        heiko carstens <heiko.carstens@de.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        schwidefsky <schwidefsky@de.ibm.com>, gor <gor@linux.ibm.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
Message-ID: <20180703182837.GC2494@hirez.programming.kicks-ass.net>
References: <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com>
 <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org>
 <CA+55aFzYEQgEhCnrwtbGuCy36Wh+aiw0_9rgMcjUgbn1JtZAPQ@mail.gmail.com>
 <20180703173451.GX2494@hirez.programming.kicks-ass.net>
 <399697782.11820.1530639539750.JavaMail.zimbra@efficios.com>
 <20180703174833.GZ2494@hirez.programming.kicks-ass.net>
 <1048940999.11846.1530640717837.JavaMail.zimbra@efficios.com>
 <20180703181143.GB2494@hirez.programming.kicks-ass.net>
 <1708848118.11868.1530641734202.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708848118.11868.1530641734202.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 02:15:34PM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 3, 2018, at 2:11 PM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Tue, Jul 03, 2018 at 01:58:37PM -0400, Mathieu Desnoyers wrote:
> >> I can modify the ABI to put the cpu_id_start and cpu_id fields inside
> >> a union, and update it with a single store.
> >> 
> >> Thoughts ?
> > 
> > Let's keep them for now, we can always frob this later, they are aligned
> > and proper, no need to expose that union to userspace.
> 
> Isn't it weird to change the API of an exposed public uapi header ?

Sure, just keep it as is. We don't need an exposed union to do a single
store there.

Something like the ugly below preserves API but still does a single
store.

But sure, if you want to expose that union for some reason, then now is
the time.

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 22b6acf1ad63..e956c48b5f83 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -85,10 +85,17 @@ static int rseq_update_cpu_id(struct task_struct *t)
 {
 	u32 cpu_id = raw_smp_processor_id();
 
-	if (__put_user(cpu_id, &t->rseq->cpu_id_start))
-		return -EFAULT;
-	if (__put_user(cpu_id, &t->rseq->cpu_id))
+	union {
+		struct {
+			u32 cpu_id_start;
+			u32 cpu_id;
+		};
+		u64 val;
+	} x = { { .cpu_id_start = cpu_id, .cpu_id = cpu_id, } };
+
+	if (__put_user(x.val, (u64 *)&t->rseq->cpu_id_start))
 		return -EFAULT;
+
 	trace_rseq_update(t);
 	return 0;
 }

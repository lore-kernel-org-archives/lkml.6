Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357B9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB878248F3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="O5+DhWuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB878248F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934462AbeGCSPh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:15:37 -0400
Received: from mail.efficios.com ([167.114.142.138]:60090 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934392AbeGCSPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:15:35 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DA52E230F94;
        Tue,  3 Jul 2018 14:15:34 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id asVSSc4ZTi03; Tue,  3 Jul 2018 14:15:34 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 73ED3230F8E;
        Tue,  3 Jul 2018 14:15:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 73ED3230F8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530641734;
        bh=rdz9WjrHPD9GSxSAZqqRfxyGetqyWoYbu7XLqefShzw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=O5+DhWuMXJ3tApQzkATWJ3xS6NfcwV3q+cMkl4ww4BEGrSQOdQhhL+DeVwL/XVwsH
         5k9OFF+sIdV7HWp2JW82Z0LvYUZSsQpjPSanXf90X7I425C+BOq8fBmUG0R8LcG8jg
         wMyjFWzcDXJxs4LS/sAXl5k59bDNZWXOQpfIh19J4MJmWl+0K1kbDkl5O+8St/Pv0z
         pptF4vrBCATW6TsW6TogM5FfodKE5WQrkEItgcXOoXjNP9WrSHvAkcW2JhaBeE9b4n
         Xs7hdTnMW6mugaG7k7JZYD2PqhsvXPxl0ayYAq68vAztuWpo4dglsGrYFZEUEhuMCp
         lukmOZAvPe42A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id hv1mUjqXn0ZK; Tue,  3 Jul 2018 14:15:34 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 5662B230F87;
        Tue,  3 Jul 2018 14:15:34 -0400 (EDT)
Date:   Tue, 3 Jul 2018 14:15:34 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <1708848118.11868.1530641734202.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180703181143.GB2494@hirez.programming.kicks-ass.net>
References: <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com> <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org> <CA+55aFzYEQgEhCnrwtbGuCy36Wh+aiw0_9rgMcjUgbn1JtZAPQ@mail.gmail.com> <20180703173451.GX2494@hirez.programming.kicks-ass.net> <399697782.11820.1530639539750.JavaMail.zimbra@efficios.com> <20180703174833.GZ2494@hirez.programming.kicks-ass.net> <1048940999.11846.1530640717837.JavaMail.zimbra@efficios.com> <20180703181143.GB2494@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use __u64 for rseq_cs fields, validate user inputs
Thread-Index: qpFjzL0ilmYomLVPp7bOS76dHloPpw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 3, 2018, at 2:11 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Jul 03, 2018 at 01:58:37PM -0400, Mathieu Desnoyers wrote:
>> I can modify the ABI to put the cpu_id_start and cpu_id fields inside
>> a union, and update it with a single store.
>> 
>> Thoughts ?
> 
> Let's keep them for now, we can always frob this later, they are aligned
> and proper, no need to expose that union to userspace.

Isn't it weird to change the API of an exposed public uapi header ? What
if userspace chooses to do sizeof(__rseq_abi.cpu_id) ? We would break
this unless we use a transparent union, which puts constraints I would
hope not to have on compilers supporting transparent unions (I recall
C++ had issues with this).

I'd prefer to expose the union right away if it's fine with you.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF00C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CACE20841
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NvrfBaGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CACE20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeG1PPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 11:15:42 -0400
Received: from mail.efficios.com ([167.114.142.138]:33068 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeG1PPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 11:15:42 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 86D3D1B4B97;
        Sat, 28 Jul 2018 09:49:06 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id nwO1ApqsiVYh; Sat, 28 Jul 2018 09:49:05 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 29E1C1B4B90;
        Sat, 28 Jul 2018 09:49:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 29E1C1B4B90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1532785745;
        bh=Pw8cQCLbzhL8BoIiiUMe0LL9GmUXqORs2zqnO/cTgBc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NvrfBaGGtJTTakc+V8J7bHEUVtA15NLsMmNIZnhW5imh4cnS0sLPBhCwZPx0uYO1O
         Ch/hU/6C5wdvsNHjAn9RKzUEVXjfDlGZxdPCPXy3zGmImZumE/B8ASnvefKRWS4o+I
         LHmlR/Kuhj+qW2HDEqED36eWhuK9tdN2LB31maoOd3YA3rpphyP203Weg8Claqpnng
         xJAlTZ7ix6xcUln31L8CgX0tEJIQBClt7ZU7LMY5dwF7uIlRz4CE78ZXapl0p7YcAG
         qmOHBnan0BARfHeNToQ5Ryrf+A8kMvqwGpXnMIOmT+y1sAAj8q9sONvhmXRpnia5QU
         aJnsKP6ltFsEA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id QM8Alt8GXv75; Sat, 28 Jul 2018 09:49:05 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 05F001B4B7E;
        Sat, 28 Jul 2018 09:49:05 -0400 (EDT)
Date:   Sat, 28 Jul 2018 09:49:04 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Pavel Machek <pavel@ucw.cz>, Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <1210024721.6363.1532785744879.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180727220115.GA18879@amd>
References: <20180602124408.8430-1-mathieu.desnoyers@efficios.com> <20180727220115.GA18879@amd>
Subject: Re: [RFC PATCH for 4.18 00/16] Restartable Sequences
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.9_GA_2055 (ZimbraWebClient - FF52 (Linux)/8.8.9_GA_2055)
Thread-Topic: Restartable Sequences
Thread-Index: SDQJj2vXVSLWjJuSihi7nqF1t35b9Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 27, 2018, at 6:01 PM, Pavel Machek pavel@ucw.cz wrote:

> Hi!
> 
>> So for instance, this turns:
>> 
>>   int cpu = rseq_per_cpu_lock(lock, target_cpu);
>>   [...]
>>   rseq_per_cpu_unlock(lock, cpu);
>> 
>> into
>> 
>>   int cpu = rseq_this_cpu_lock(lock);
>>   [...]
>>   rseq_per_cpu_unlock(lock, cpu);
>> 
>> and:
>> 
>>   per_cpu_list_push(list, node, target_cpu);
>>   [...]
>>   per_cpu_list_pop(list, node, target_cpu);
>> 
>> into
>> 
>>   this_cpu_list_push(list, node, &cpu);  /* cpu is an output parameter. */
>>   [...]
>>   node = this_cpu_list_pop(list, &cpu);  /* cpu is an output parameter. */
>> 
>> Eventually integrating cpu_opv or some alternative will allow passing
>> the cpu number as parameter rather than requiring the algorithm to work
>> on the current CPU.
>> 
>> The second effect of not having the cpu_opv fallback is that
>> line and instruction single-stepping with a debugger transforms rseq
>> critical sections based on retry loops into never-ending loops.
>> Debuggers need to use the __rseq_table section to skip those critical
>> sections in order to correctly behave when single-stepping a thread
>> which uses rseq in a retry loop. However, applications which use an
>> alternative fallback method rather than retrying on rseq fast-path abort
>> won't be affected by this kind of single-stepping issue.
>> 
>> Thanks for your feedback!
> 
> Would it make sense to include Documentation/ patch? I guess at least
> manpage describing the syscall will be needed....

Hi Pavel,

Documentation-wise, I have posted a rseq man page rfc here:

https://lkml.kernel.org/r/20180616195803.29877-1-mathieu.desnoyers@efficios.com

comments are welcome!

It does not include any details about user-space library APIs though, as
this is not the purpose of the syscall documentation.

We're currently discussing integration of rseq thread registration into
glibc.

Once this is settled, I plan to provide a librseq which will contain headers
and documentation on how to use rseq without having to re-create the low-level
assembly every time.

Does this plan make sense to you ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

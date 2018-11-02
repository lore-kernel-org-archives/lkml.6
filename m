Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7800C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE9E20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fnlv2DVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE9E20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeKCATu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:19:50 -0400
Received: from mail.efficios.com ([167.114.142.138]:40580 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbeKCATu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:19:50 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 355A823837B;
        Fri,  2 Nov 2018 11:12:25 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id LsGapA0_mxDm; Fri,  2 Nov 2018 11:12:24 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A6586238372;
        Fri,  2 Nov 2018 11:12:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A6586238372
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1541171544;
        bh=FMT4afYSIxiNq8Boha7u49U6AnJvCmo/YgDzIreHAV8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=fnlv2DVVJJ78M7v1oCpHbrxNbR1Zoe7ZiQSo1FVcqCW7v0IzUfvouF54/T9+EsglP
         YOTTDr8/L4sWA7f3mFJPbR2O8dgKu4z5LTA6Ja0/73sVG6mylrk6KvzbKA/tnpZkF1
         rbi4uhC39H87VVIeRucwAcZre+6iCchMBvXsUAZip9samX/Qevfbf7nMwYvcFhuTNg
         edy1hIVU4Y+befBzpklIrDvv7e2Ec8G41Yr28wnf+DoQEmpCm7yqhT4iZZvu2FB8SA
         78f+lUdo9iAfo5ILs542grc8rP3s4otKx13mZynDJbWcqP4xAzrfrlQMZ1HvOei6JF
         i2CBuBnftowyQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 0KqKnruDxgTJ; Fri,  2 Nov 2018 11:12:24 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 85100238369;
        Fri,  2 Nov 2018 11:12:24 -0400 (EDT)
Date:   Fri, 2 Nov 2018 11:12:24 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Richard Henderson <rth@twiddle.net>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>, Ben Maurer <bmaurer@fb.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <313542172.8.1541171544337.JavaMail.zimbra@efficios.com>
Subject: Supporting core-specific instruction sets (e.g. big.LITTLE) with
 restartable sequences
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF52 (Linux)/8.8.10_GA_3041)
Thread-Index: xWnqFvmB9UO5++Ah0yHPR4XP7DDblw==
Thread-Topic: Supporting core-specific instruction sets (e.g. big.LITTLE) with restartable sequences
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

I stumbled on these articles:

- https://medium.com/@jadr2ddude/a-big-little-problem-a-tale-of-big-little-gone-wrong-e7778ce744bb
- https://www.mono-project.com/news/2016/09/12/arm64-icache/

and discussed them with Will Deacon. He told me you were looking into gcc atomics and it might be
worthwhile to discuss the possible use of the new rseq system call that has been added in Linux 4.18
for those use-cases.

Basically, the use-cases targeted are those where some cores on the system support a larger instruction
set than others. So for instance, some cores could use a faster atomic add instruction than others, which
should rely on a slower fallback. This is also the same story for reading the performance monitoring
unit counters from user-space: it depends on the feature-set supported by the CPU on which the instruction
is issued. Same applies to cores having different cache-line sizes.

The main problem is that the kernel can migrate a thread at any point between user-space reading the
current cpu number and issuing the instruction. This is where rseq can help.

The core idea to solve the instruction set issue is to set a mask of cpus supporting the new instruction
in a library constructor, and then load cpu_id, use it with the mask, and branch to either the new or
old instruction, all with a rseq critical section. If the kernel needs to abort due to preemption or
signal delivery, the abort behavior would be to issue the fallback (slow) atomic operation, which
guarantees progress even if single-stepping.

As long as the load, test and branch is faster than the performance delta between the old and new atomic
instruction, it would be worth it.

In the case of PMU read from user-space, using rseq to figure out how to issue the PMU read enables a
use-case which is not otherwise possible to do on big.LITTLE. On rseq abort, it would fallback to a
system call to read the PMU counter. This abort behavior guarantees forward progress.

The second article is about cache line size discrepancy between CPUs. Here again, doing the cacheline
flushing in a rseq critical section could allow tuning it to characteristics of the actual core it is
running on. The fast-path would use a stride fitting the current core characteristics, and if rseq
needs to abort, the slow-path would fall-back to a conservative value which would fit all cores (smaller
cache line size on the overall system). Once again, this abort behavior guarantees forward progress.
This would only work, of course, if cacheline invalidation done on a big core end up being propagated
to other cores in a way that clears all the cache lines corresponding to the one targeted on the big
core.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

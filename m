Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D8AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD64248BD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZQkdpgR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD64248BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbeGBVDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:03:48 -0400
Received: from mail.efficios.com ([167.114.142.138]:39390 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbeGBVDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:03:46 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8DA1E22F835;
        Mon,  2 Jul 2018 17:03:45 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ZMdIVMDTBgO2; Mon,  2 Jul 2018 17:03:45 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 108E522F82E;
        Mon,  2 Jul 2018 17:03:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 108E522F82E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530565425;
        bh=wvl4uJHURxP1UylxkJHiv1sYHYCnRrI4bCo/tUz8HOw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZQkdpgR8PW/JlIwxPRBpKW5jruN6L9Iw4yqOrPsaO2RDqQwqM4HX5QeRkiF35b2Dr
         t8hsn9X9sYlTH/zUDtq7HF7cZMGqNTTj2tzacJKT4vZj0tyN5BP3V09YIF+MFFhVEl
         ngjYGlkyLf6JjZlOSZO6rM1Pzdm9sRGK/Yv8ejl4hudV5IAESRFFsga6QPA4Sil68l
         7+52MQJRaAdRyW0oyjMybNnWEvZ0PzyLqHrTiRMJMBFwMv1cW9wVF/OAF2XQ6+kKtR
         Udeqkhkjn8gKf/WU6FLFsHsOGK3WPns2IySUCCmWVxobdNdeVxeG7eK1y9u4f/1shm
         PzEAtz1NUwNUQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id uwL21qBLVeRt; Mon,  2 Jul 2018 17:03:44 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id E85AE22F827;
        Mon,  2 Jul 2018 17:03:44 -0400 (EDT)
Date:   Mon, 2 Jul 2018 17:03:44 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <1307337131.10790.1530565424717.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFzH+4=Aeh_P1ptFn5nVm7yFuEGpxUJ0kNB-sUHVOv8rcw@mail.gmail.com>
References: <20180702204058.819-1-mathieu.desnoyers@efficios.com> <CA+55aFzH+4=Aeh_P1ptFn5nVm7yFuEGpxUJ0kNB-sUHVOv8rcw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: use __u64 for rseq_cs fields,
 validate abort_ip < TASK_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use __u64 for rseq_cs fields, validate abort_ip < TASK_SIZE
Thread-Index: JNOpKk/IeSrVNfOAIkDLHe4DdDI+MA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 2, 2018, at 4:52 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Mon, Jul 2, 2018 at 1:41 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> -       if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
>> +       if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)) ||
>> +           rseq_cs->abort_ip >= TASK_SIZE)
>>                 return -EFAULT;
> 
> I think the abort_ip check should have the same error value as the
> other sanity checks, ie just be of this format:
> 
>>         if (rseq_cs->version > 0)
>>                 return -EINVAL;

OK, so I'll go for -EINVAL.

> 
> also, I think you should check start_ip to be consistent. You kind of
> accidentally do it with the check for
> 
>        if (rseq_cs->abort_ip - rseq_cs->start_ip - rseq_cs->post_commit_offset)

The check is actually:

        /* Ensure that abort_ip is not in the critical section. */
        if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
                return -EINVAL;

> 
> but honestly, that has underflow issues already, so I think you want
> to basically make the check be
> 
>        if (rseq_cs->abort_ip >= TASK_SIZE)
>                return -EINVAL;

that works.

> 
>        if (rseq_cs->start_ip >= rseq_cs->abort_ip)
>                return -EINVAL;

this one does not work. We need to ensure that abort_ip
is not between [ start_ip, start_ip + post_commit_offset ]. The
check you propose validates that start_ip is below abort_ip,
which is bogus. For instance, abort_ip can very well be in a
different section of the binary, at an address either below
or above start_ip.


> 
> which takes care of checkint  start_ip, and also the underflow for the
> post_commit_offset check.

What underflow issues are you concerned with ?

> 
> If somebody is depending on negative offsets, then that
> post_commit_offset logic is already wrong.
> 
>> +       usig = (u32 __user *)(unsigned long)(rseq_cs->abort_ip - sizeof(u32));
>>         ret = get_user(sig, usig);
> 
> That can underflow too, but I guess we can just rely on get_user()
> getting it right.

Yes, get_user() should handle that one properly.

Thanks,

Mathieu

> 
>                Linus

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

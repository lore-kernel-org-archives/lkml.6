Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5759EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A6E25187
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XLYrRj1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A6E25187
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932842AbeGBXAY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:00:24 -0400
Received: from mail.efficios.com ([167.114.142.138]:47008 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932213AbeGBXAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:00:20 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BC61222F860;
        Mon,  2 Jul 2018 19:00:19 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id hSvqn4siwX1t; Mon,  2 Jul 2018 19:00:19 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2B36F22F85D;
        Mon,  2 Jul 2018 19:00:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2B36F22F85D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530572419;
        bh=751AlYfhH14RHiUOzu/+/a7kvkFwuBpEIBKW6rX8qdQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=XLYrRj1RdUNKfCoiDrSqbZh3Iqd4XVl2kh5Ac9lswJwVtuws67EUmJ8LcFfP08ccZ
         enUijtCU/gv6+Te0TFx454WOU8T8NbVRELSLDmJTIQGDzHXjuKaZTKM1iHS4xROam0
         XsPxiaGMCGSAnibW7IaA2H7jJjIYx19ubgtUHVkYmmTSF9OfK+OKZaqtasWEhBKVgP
         VXKMJKmZaJXjGxonPjPF1Mv/95A/RAbIXWMYfP2b/JU023hD3IzXWpe6EMJNuSkaD1
         kpAoXghjRc8PieZXeG6gXOCwiRFUxUbNwJY9g1UEvY1qQWEw4sLcJU1ASaE9zrbxnZ
         5A4gaXxjt8jPQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 0aYL-8Bt_eyX; Mon,  2 Jul 2018 19:00:19 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 0C5EA22F856;
        Mon,  2 Jul 2018 19:00:19 -0400 (EDT)
Date:   Mon, 2 Jul 2018 19:00:18 -0400 (EDT)
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
Message-ID: <415287289.10831.1530572418907.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFxrX+wRoe+5HDaTrRXg1K-Qpks4jJ9Buc_OevoG8hoGFw@mail.gmail.com>
References: <20180702223143.4663-1-mathieu.desnoyers@efficios.com> <CA+55aFxrX+wRoe+5HDaTrRXg1K-Qpks4jJ9Buc_OevoG8hoGFw@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use __u64 for rseq_cs fields, validate user inputs
Thread-Index: v1eEGYKuadK8hiZjpAVSo1GQwiHEtQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 2, 2018, at 6:45 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Mon, Jul 2, 2018 at 3:31 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Change the rseq ABI so rseq_cs start_ip, post_commit_offset and abort_ip
>> fields are seen as 64-bit fields by both 32-bit and 64-bit kernels rather
>> that ignoring the 32 upper bits on 32-bit kernels. This ensures we have a
>> consistent behavior for a 32-bit binary executed on 32-bit kernels and in
>> compat mode on 64-bit kernels.
> 
> Actually, now that I see this again, I react to:
> 
> 
>> +static int check_rseq_cs_padding(struct task_struct *t)
>> +{
>> +       u32 pad;
>> +       int ret;
>> +
>> +       ret = __get_user(pad, &t->rseq->rseq_cs_padding);
>> +       if (ret)
>> +               return ret;
>> +       if (pad)
>> +               return -EINVAL;
>> +       return 0;
>> +}
> 
> This is all wrong.
> 
> Just make "rseq_cs" be an __u64" too. That will clean up everything,
> and user space will have a much easier time filling it in too, since
> it's just one field. Instead of having to remember about the "let's
> fill in padding for 32-bit cases".
> 
> Then the rseq_get_rseq_cs() will be
> 
>        __u64 rseq_cs;
> 
>        ret = get_user(rseq_cs, &t->rseq->rseq_cs);
>        if (ret)
>                return ret;
>        ptr = (void *)rseq_cs;
>        if (rseq_cs != (unsigned long)ptr)
>                return -EINVAL;
> 
> and it's all good, no #ifdef's etc needed.
> 
> Hmm?

Unfortunately, that rseq->rseq_cs field needs to be updated by user-space
with single-copy atomicity. Therefore, we want 32-bit user-space to initialize
the padding with 0, and only update the low bits with single-copy atomicity.

> 
> Sorry for the bike-shedding, but this is now the last remaining user
> of that LINUX_FIELD_u32_u64, so let's just get rid of it entirely, ok?
>
> Then we can also get rid of that silly uapi/linux/types_32_64.h header
> file entirely.
> 
> That would be *lovely*. Simpler code, simpler and less error-prone
> interfaces, and one less specialized header file.

We can easily switch from LINUX_FIELD_u32_u64 to __u64 for fields within
struct rseq_cs because we have no requirement on update single-copy
atomicity. However, this is not true for the rseq->rseq_cs pointer.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

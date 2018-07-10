Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ADCC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1C620854
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="r4bE6hGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1C620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933428AbeGJNsx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:48:53 -0400
Received: from mail.efficios.com ([167.114.142.138]:40338 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933145AbeGJNsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:48:38 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A56F8232BF6;
        Tue, 10 Jul 2018 09:48:36 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id cghXN_bTder1; Tue, 10 Jul 2018 09:48:35 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B2EC6232BEF;
        Tue, 10 Jul 2018 09:48:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B2EC6232BEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1531230515;
        bh=lWGIZO34swsmW97bbYHaCUvedxcC2taPZFLaDMqh8xk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=r4bE6hGDQ15JsIaXQdYub1jQL3vzqXba6h4oK5IrY90jeUtRDcbtGN8ruccmhnxS4
         WQt3z7t8e0ErcJ0jnci+2ZOCrMNflfS3V305F0V16JX3ETtudP4a056UAwQiZvFy9u
         bY7gpiyMwYazwy5vHojuXGtJM/s8VcSGUckkPd1sOo3qT1CmPGU6SJ4M67/YA34D+G
         sisKXUfHOgGpLBzgctVwdxMxeGBRder+Ebut+oCygrRSubRBacKbj2Devn0KumPOPX
         YAizOtLyg9Po/fDZ92zMGcE7oWBFtiFwAhFv1IKtv0WMKHT3yLOiTqonCxuYcufJtE
         fW5bWCI8JgjNw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id yTq0YGWZMGru; Tue, 10 Jul 2018 09:48:35 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 92B54232BE8;
        Tue, 10 Jul 2018 09:48:35 -0400 (EDT)
Date:   Tue, 10 Jul 2018 09:48:35 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Andrew Hunter <ahh@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <1050939005.3002.1531230515472.JavaMail.zimbra@efficios.com>
In-Reply-To: <87tvp7mx8j.fsf@concordia.ellerman.id.au>
References: <20180708210330.27324-1-mathieu.desnoyers@efficios.com> <20180708210330.27324-3-mathieu.desnoyers@efficios.com> <854203778.2272.1531157327328.JavaMail.zimbra@efficios.com> <87tvp7mx8j.fsf@concordia.ellerman.id.au>
Subject: Re: [PATCH for 4.18 2/6] rseq: use get_user/put_user rather than
 __get_user/__put_user
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use get_user/put_user rather than __get_user/__put_user
Thread-Index: cbcRBub5G431Y2yaJ9I+DLXYZjtjEA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 10, 2018, at 2:16 AM, Michael Ellerman mpe@ellerman.id.au wrote:

> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
>> ----- On Jul 8, 2018, at 5:03 PM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>>
>>> In preparation to use __u64 for the rseq_cs pointer field, 32-bit
>>> architectures need to read this 64-bit value located in user-space
>>> addresses.
>>> 
>>> __get_user is used to read this value, given that its access check has
>>> already been performed with access_ok() on rseq registration.
>>> 
>>> arm does not implement 8-byte __get_user. Rather than trying to
>>> improve __get_user on ARM, use get_user/put_user across rseq instead.
>>> 
>>> If those end up showing up in benchmarks, the proper approach would be to
>>> use user_access_begin() / unsafe_get/put_user() / user_access_end()
>>> anyway.
>>
>> So, another twist to this story: ppc32 does not implement u64 get_user().
> 
> Or __get_user() for that matter.
> 
> But we should just fix it.
> 
> We have the asm to do it, it's just the fact that __gu_val is unsigned
> long causes the size > sizeof(x) check here to fail:
> 
> #define __get_user_size(x, ptr, size, retval)			\
> do {								\
>	retval = 0;						\
>	__chk_user_ptr(ptr);					\
>	if (size > sizeof(x))					\
>		(x) = __get_user_bad();				\
> 
> 
> 
> We seem to be able to fix that with the __inttype() trick that x86 uses.
> 
> That's probably not 4.18 material though. But if you want to go with
> copy_from_user() for now you could then switch to get_user() for 4.19.

I agree. Let's use copy_from_user() for 4.18. Once get_user() ends up supporting
u64 on ppc32 for 4.19, rseq will happily move back to it.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

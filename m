Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED7FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D1224FAF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="SVDvnKJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D1224FAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753652AbeGCBTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:19:05 -0400
Received: from mail.efficios.com ([167.114.142.138]:56180 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeGCBTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:19:03 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C2B9F22F659;
        Mon,  2 Jul 2018 21:19:02 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 3QzhvvoBv1N7; Mon,  2 Jul 2018 21:19:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6086322F644;
        Mon,  2 Jul 2018 21:19:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6086322F644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530580742;
        bh=SZOuEhZ27PFV2ZA1LvcZgLT+HN/octKUOOXpnMwNT1M=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=SVDvnKJsaC89Fq8UT1tk6CWEHM6UnJuQqAbeEntpx1mFJzIxiyTreShhg22En22eY
         /DwWXbdizt8GqSl2t38gjfsGsh1BnzkH5rCEEec21YVJCS4wK+e/D4UW2dlKsLj0nV
         BGFYccaY7HjLrVjXctljMz2IcDomw8gGG9Lo5X+alS1Ed1OaFyCnJZF7GWxDp9ZpQI
         q33gd7bPZCU9/uvsdidyC2VE2LGWl6+JypG/XS9acHEJolyfd2Cx8CY4IAM7JOIwzv
         l9C3UenUADCPGM6avLr9eyBmuWknVrPHOzunwVN3W3W3mCcWBjYDQQGkzfhkR/Me5d
         1Hd9VfgAkiA1w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id IgkjfsgWhrYx; Mon,  2 Jul 2018 21:19:02 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 3CEED22F636;
        Mon,  2 Jul 2018 21:19:02 -0400 (EDT)
Date:   Mon, 2 Jul 2018 21:19:02 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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
Message-ID: <459661281.10865.1530580742205.JavaMail.zimbra@efficios.com>
In-Reply-To: <8B2E4CEB-3080-4602-8B62-774E400892EB@amacapital.net>
References: <20180702223143.4663-1-mathieu.desnoyers@efficios.com> <CA+55aFxrX+wRoe+5HDaTrRXg1K-Qpks4jJ9Buc_OevoG8hoGFw@mail.gmail.com> <415287289.10831.1530572418907.JavaMail.zimbra@efficios.com> <CA+55aFzZYOatOtjrm7fD7878_SzCAmEoEu74n0+pgd7faH-sTQ@mail.gmail.com> <825871008.10839.1530573419561.JavaMail.zimbra@efficios.com> <1959930320.10843.1530573742647.JavaMail.zimbra@efficios.com> <8B2E4CEB-3080-4602-8B62-774E400892EB@amacapital.net>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use __u64 for rseq_cs fields, validate user inputs
Thread-Index: erm+LR4InFsVzMK0uwedmMsmP9wzeQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 2, 2018, at 7:37 PM, Andy Lutomirski luto@amacapital.net wrote=
:

>> On Jul 2, 2018, at 4:22 PM, Mathieu Desnoyers <mathieu.desnoyers@efficio=
s.com>
>> wrote:
>>=20
>> ----- On Jul 2, 2018, at 7:16 PM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>>=20
>>> ----- On Jul 2, 2018, at 7:06 PM, Linus Torvalds torvalds@linux-foundat=
ion.org
>>> wrote:
>>>=20
>>>> On Mon, Jul 2, 2018 at 4:00 PM Mathieu Desnoyers
>>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>>=20
>>>>> Unfortunately, that rseq->rseq_cs field needs to be updated by user-s=
pace
>>>>> with single-copy atomicity. Therefore, we want 32-bit user-space to i=
nitialize
>>>>> the padding with 0, and only update the low bits with single-copy ato=
micity.
>>>>=20
>>>> Well... It's actually still single-copy atomicity as a 64-bit value.
>>>>=20
>>>> Why? Because it doesn't matter how you write the upper bits. You'll be
>>>> writing the same value to them (zero) anyway.
>>>>=20
>>>> So who cares if the write ends up being two instructions, because the
>>>> write to the upper bits doesn't actually *do* anything.
>>>>=20
>>>> Hmm?
>>>=20
>>> Are there any kind of guarantees that a __u64 update on a 32-bit archit=
ecture
>>> won't be torn into something daft like byte-per-byte stores when perfor=
med
>>> from C code ?
>>>=20
>>> I don't worry whether the upper bits get updated or how, but I really c=
are
>>> about not having store tearing of the low bits update.
>>=20
>> For the records, most updates of those low bits are done in assembly
>> from critical sections, for which we control exactly how the update is
>> performed.
>>=20
>> However, there is one helper function in user-space that updates that va=
lue
>> from C through a volatile store, e.g.:
>>=20
>> static inline void rseq_prepare_unload(void)
>> {
>>        __rseq_abi.rseq_cs =3D 0;
>> }
>=20
> How about making the field be:
>=20
> union {
> __u64 rseq_cs;
> struct {
>   __u32 rseq_cs_low;
>   __u32 rseq_cs_high;
> };
> };
>=20
> 32-bit user code that cares about performance can just write to rseq_cs_l=
ow
> because it already knows that rseq_cs_high =3D=3D 0.
>=20
> The header could even supply a static inline helper write_rseq_cs() that
> atomically writes a pointer and just does the right thing for 64-bit, for
> 32-bit BE, and for 32-bit LE.
>=20
> I think the union really is needed because we can=E2=80=99t rely on user =
code being
> built with -fno-strict-aliasing.  Or the helper could use inline asm.
>=20
> Anyway, the point is that we get optimal code generation (a single instru=
ction
> write of the correct number of bits) without any compat magic in the kern=
el.

That works for me! Any objection from anyone else for this approach ?

Thanks,

Mathieu

>=20
>>=20
>> Thanks,
>>=20
>> Mathieu
>>=20
>>>=20
>>> Thanks,
>>>=20
>>> Mathieu
>>>=20
>>>=20
>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> http://www.efficios.com
>>=20
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
> > http://www.efficios.com

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

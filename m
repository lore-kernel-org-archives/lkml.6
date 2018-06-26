Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA49DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C2E26C08
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 22:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pisfk5sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C2E26C08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbeFZWR1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 18:17:27 -0400
Received: from mail.efficios.com ([167.114.142.138]:44702 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbeFZWRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 18:17:24 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 66D5E22D66E;
        Tue, 26 Jun 2018 18:17:23 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 88WgwhZt-1hj; Tue, 26 Jun 2018 18:17:23 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E5F3F22D66B;
        Tue, 26 Jun 2018 18:17:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E5F3F22D66B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530051442;
        bh=ITrLFb2+kuvkM3T4EeU5OI5lRnUjFaGcc+gpOhLtOmo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=pisfk5sfuadyYx6O1qlmFhk+404n3pzwfHN3TOtyrlmIVe2w1aETejduzvmCs1GlJ
         aBK4jTObAHVUablWN6Mqu4OIL+w1vL5pw2sZiZlBeecBsUsvtMtW424vF84R38Of/3
         rFrxC66iay0YR7sW871L3C+A3v/jbm0MI6ublQSOi8osw2aY5Z+bv4rPdEzw0OM/74
         zxxt46JrEHMwwLHCkNuthN/csfhu+9cjVCaDe+IwIuxqciHpW8HqkTi+xNcwdurWRA
         cP0XnxUXlgDopABcKXThxP4/4L2llS0hrSdjJP3rdfQs+7+J2XU7PvygfIhw14XdhY
         oKCFxQT6yMNGw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id W_4YYFusHGF5; Tue, 26 Jun 2018 18:17:22 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id C84AB22D660;
        Tue, 26 Jun 2018 18:17:22 -0400 (EDT)
Date:   Tue, 26 Jun 2018 18:17:22 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>,
        Andi Kleen <andi@firstfloor.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Lameter <cl@linux.com>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Hunter <ahh@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        rostedt <rostedt@goodmis.org>, Ben Maurer <bmaurer@fb.com>,
        linux-api <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, x86 <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <107389573.6464.1530051442686.JavaMail.zimbra@efficios.com>
In-Reply-To: <D9B93DE9-F61C-4488-B109-432C2DFDCEC2@amacapital.net>
References: <20180626211617.8933-1-mathieu.desnoyers@efficios.com> <20180626211617.8933-2-mathieu.desnoyers@efficios.com> <D9B93DE9-F61C-4488-B109-432C2DFDCEC2@amacapital.net>
Subject: Re: [RFC PATCH for 4.18 2/2] rseq: compat: clear high bits of
 rseq_cs fields
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: compat: clear high bits of rseq_cs fields
Thread-Index: zlTfuRBxhDPVt/I6Vlni5mSLhjY16g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 26, 2018, at 5:58 PM, Andy Lutomirski luto@amacapital.net wrot=
e:

>> On Jun 26, 2018, at 2:16 PM, Mathieu Desnoyers <mathieu.desnoyers@effici=
os.com>
>> wrote:
>>=20
>> Make the behavior rseq on compat tasks more robust by ensuring that
>> kernel/rseq.c:rseq_get_rseq_cs() clears the high bits of
>> rseq_cs->abort_ip, rseq_cs->start_ip and rseq_cs->post_commit_offset
>> when a 32-bit binary is run on a 64-bit kernel.
>>=20
>> The intent here is that if user-space has garbage rather than zeroes
>> in its struct rseq_cs fields padding, the behavior will be the same
>> whether the binary is run on 32-bit or 64-bit kernels.
>>=20
>> Use in_compat_syscall() when rseq_get_rseq_cs() is invoked from
>> system call context, and use is_compat_frame() when invoked from
>> signal delivery.
>>=20
>=20
> And when it=E2=80=99s invoked due to preemption unrelated to a syscall or=
 signal, you
> malfunction?

Fair point! Hence the "RFC". ;)

So I understand better your intent to use the pt_regs to figure out whether=
 it
is compat or not. My is_compat_frame()+in_compat_syscall() approach does no=
t
handle this correctly.

>=20
> I think the only sane solution is to make these fields be u64,

I'm OK with turning the rseq_cs start_ip, post_commit_offset, and abort_ip
fields into normal u64.

> delete the
> LINUX_FIELD_ macros,

The LINUX_FIELD_ macros are still needed to ensure single-copy updates of
the (struct rseq *__tls_abi)->rseq_cs pointer by 32-bit user-space.

> and possibly teach the x86 slowpath return to inject a
> signal if it=E2=80=99s trying to return to a 32-bit context with garbage =
in the high
> bits of regs->ip so that we determistically fail if the user screws up.

I like the approach of dealing with the rseq_cs fields as u64 even on 32-bi=
t
architectures. As a downside, it will require 32-bit architectures to do
arithmetic on 64-bit values, but it's not a fast-path. As you point out, th=
e
tricky bit is to decide what happens when architecture code returns to
userspace with regs->ip containing garbage in the high bits.

An alternative approach is to ensure the high bits are cleared when returni=
ng
to an IP with garbage in the high bits.

> Rseq is brand new. It should not need compat code at all.

Dealing with u64 for start_ip, post_commit_offset, and abort_ip at the kern=
el
level would indeed provide this characteristic. However, I'm uneasy adding
64-bit arithmetic on operations really caring about 32 bits on 32-bit archs=
,
even though those are not fast paths.

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

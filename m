Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F32C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47CA327ABB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 00:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="f1cOGhGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47CA327ABB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936422AbeF2Ayv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 20:54:51 -0400
Received: from mail.efficios.com ([167.114.142.138]:37190 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933008AbeF2Ays (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 20:54:48 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 54E2422EA2E;
        Thu, 28 Jun 2018 20:54:47 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id mfij72EvQCZN; Thu, 28 Jun 2018 20:54:46 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BB54822EA2A;
        Thu, 28 Jun 2018 20:54:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BB54822EA2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530233686;
        bh=2aRCpAgCcd0NQt6EShYSQfT3/P6w3x8WNNZ4CVcsfh0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=f1cOGhGFYFH0Vy9HE67LPnC2F8BD/+ur/g6p6gBeBvgnaG7Rj8bS4GqZitIYJqbIc
         X7CrfQSrG2GbNzoubptLnu7A+Wt+kiVwgs3IB5y2efiscAQ5lMBPa80BarRhTyf71+
         3+jx7jO0erFu53b8BNkm3gkGsi+LF2aMElOCajmGdS7mqhh0Tr/NugdIsBHEswgMxl
         cW1yZzAhJAdMu6JScaQd3RSBQxs6ppuUN0BJLReWIfogYEsJn0tpvnp4kYaao9P4pU
         nNyHtGzA8BTSk8rgKa7Cof9hG9OO+43qt59NPmDVWB5JyXaxIWIAgEzEuxpFjBf9Ev
         ibdsKXHTGzM8w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id i8gpuH29ZuRj; Thu, 28 Jun 2018 20:54:46 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 9CA5B22EA14;
        Thu, 28 Jun 2018 20:54:46 -0400 (EDT)
Date:   Thu, 28 Jun 2018 20:54:46 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <665398433.9488.1530233686432.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFzxCjkSbfRUeX3W_oXSJ6LMUdRVYB=DR2b3rUNkiixM1A@mail.gmail.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com> <CALCETrULo_VP4XHbXcZTevWY5d-6PdHUtrDS8DEF_OaozQOaNg@mail.gmail.com> <CA+55aFxZrv9koOGKNzpBjcpzwaKQBg9ybqcvQ9u=5d94y1F+mQ@mail.gmail.com> <CALCETrUrXk3wRg8SKhWf98v8jK=HwX9XLvP+Ypi+TktZoNx_Jg@mail.gmail.com> <CA+55aFzxCjkSbfRUeX3W_oXSJ6LMUdRVYB=DR2b3rUNkiixM1A@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are <
 TASK_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: validate rseq_cs fields are < TASK_SIZE
Thread-Index: Ni+KcT6w8fHZnMfOQpG8vowZ5X/7cg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 28, 2018, at 8:18 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Thu, Jun 28, 2018 at 4:30 PM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> The idea is that, if someone screws up and sticks a number like
>> 0xbaadf00d00045678 into their rseq abort_ip in a 32-bit x86 program
>> (when they actually mean 0x00045678), we want to something consistent.
> 
> I think the "something consistent" is perfectly fine with just "it won't work".
> 
> Make it do
> 
>        if (rseq_cs->abort_ip != (unsigned long)rseq_cs->abort_ip)
>                return -EINVAL;
> 
> at abort time.
> 
> Done.
> 
> If it's a 32-bit kernel, the above will reject the thing, and if it's
> a 64-bit kernel, it will be a no-op, but the abort won't work in a
> 32-bit caller.
> 
> Problem solved.

This assumes a 64-bit kernel returning to a 32-bit compat task with
garbage it the upper 32 bits of regs->ip behaves correctly (e.g.
kill the offending process rather than crash the kernel) on all
architectures.

Is this something we can rely on ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B79C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B5025558
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hw238xHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B5025558
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936689AbeF2OFs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:05:48 -0400
Received: from mail.efficios.com ([167.114.142.138]:56582 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932280AbeF2OFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:05:46 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3EB8C22D3FE;
        Fri, 29 Jun 2018 10:05:45 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id WTczEU2ZVxew; Fri, 29 Jun 2018 10:05:44 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CEB4922D3F4;
        Fri, 29 Jun 2018 10:05:44 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CEB4922D3F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530281144;
        bh=5ByuItJs0OiOc9kbxFpQMItF7m9NGxB+wpaTyGrZVNE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=hw238xHjjt2SHSODQK6bqFh0xgtRlHi4aDZv2cLfoSOa+9dxJaG5QB1jV+UU4ptan
         8Pf76UmHGzvEZ3nqsmwnaX26ESmhjfws2WbSPbApPlJ/SB3lCIQSG2lfkO5f6kpMqB
         mZMrT6oXu4J1kUMou5XTQdKvZdAVRClyS3Cega05PdAa9pYLPe2eqjftbP1H31De3N
         rWGCxtAOOItS4DVfeRcMNLThMCL1zTU8FAzzCYyOl+2yNdRBh8PZmUMlY3hOUOwmD2
         UCNcjlangoXVGuSGd0philnkVnCYjfL0vhq/m3WHXV3Hiq5qP+CCXWg02Gh9OXRUWi
         E+Y6zYx2bBbsg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id ZjB5QL1XcIkA; Fri, 29 Jun 2018 10:05:44 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B1F8922D3E1;
        Fri, 29 Jun 2018 10:05:44 -0400 (EDT)
Date:   Fri, 29 Jun 2018 10:05:44 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <1706339668.9644.1530281144560.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFzpD5xF80iiFNd+EMkJnRQdKPumM5p24Sr+LeBt8Gg=wg@mail.gmail.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com> <CALCETrULo_VP4XHbXcZTevWY5d-6PdHUtrDS8DEF_OaozQOaNg@mail.gmail.com> <CA+55aFxZrv9koOGKNzpBjcpzwaKQBg9ybqcvQ9u=5d94y1F+mQ@mail.gmail.com> <CALCETrUrXk3wRg8SKhWf98v8jK=HwX9XLvP+Ypi+TktZoNx_Jg@mail.gmail.com> <CA+55aFzxCjkSbfRUeX3W_oXSJ6LMUdRVYB=DR2b3rUNkiixM1A@mail.gmail.com> <9200ED2A-AE4B-4094-81C9-E92240B4840F@amacapital.net> <CA+55aFzpD5xF80iiFNd+EMkJnRQdKPumM5p24Sr+LeBt8Gg=wg@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are <
 TASK_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: validate rseq_cs fields are < TASK_SIZE
Thread-Index: LCPV3Tf5U+eY2oj4yJoy1Hp5/5f7Hw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 29, 2018, at 10:02 AM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Thu, Jun 28, 2018 at 6:08 PM Andy Lutomirski <luto@amacapital.net> wrote:
>> > On Jun 28, 2018, at 5:18 PM, Linus Torvalds <torvalds@linux-foundation.org>
>> > wrote:
>> >
>> >
>> > Make it do
>> >
>> >        if (rseq_cs->abort_ip != (unsigned long)rseq_cs->abort_ip)
>> >                return -EINVAL;
>> >
>> > at abort time.
>>
>> You sure?  Because, unless I remember wrong, a 32-bit user program on a 64-bit
>> kernel will actually work at least most of the time even if high bits are set.
> 
> Sure.
> 
> If you run a 32-bit binary on a 64-bit kernel,. you will have access
> to the 0xc0000000 - 0xffffffff area that you wouldn't have had access
> to if it ran on a 32-bit kernel.
> 
> But exactly *because* you have access to that area, those addresses
> are actually valid addresses for the 32-bit case, so they shouldn't be
> considered bad. They can't happen on a native 32-bit kerne, but a
> 32-bit program doesn't even care. If it has user memory mapped in that
> area, it should work.
> 
> And if it *doesn't* have user memory mapped in that area, then it will
> fail when the trying to execute the (non-existent) abort sequence.
> 
> After all, depending on configuration, a native 32-bit kernel might
> limit user space even more (ie some vendors had a 2G:2G split instead
> of the traditional 3G:1G split.
> 
> Was that the case you were thinking of, or was it something else?

What I'm worried about is setting regs->ip of a compat 32-bit task to
addresses in the range 0x100000000-0xFFFFFFFFFFFFFFFF.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

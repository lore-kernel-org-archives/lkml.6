Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D08AC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDC727F73
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RBK3FiRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDC727F73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935204AbeF2Nzr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:55:47 -0400
Received: from mail.efficios.com ([167.114.142.138]:55670 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeF2Nzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:55:45 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5B67C22D097;
        Fri, 29 Jun 2018 09:55:44 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id CfE0YLhB3LtQ; Fri, 29 Jun 2018 09:55:43 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CE70622D094;
        Fri, 29 Jun 2018 09:55:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CE70622D094
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530280543;
        bh=E4WIywRkT6q1+sgTnr5yUnx4yaTA5nWtQ+BnOJ+uCZA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=RBK3FiRDd6DduOJ9Vrr2hf7sn/NCPjtF+5scTuOKqeqx2K9SRegSTVDvEYlLALnPt
         8uMAtCmowuCHDX6DyWHYqW2KpqMNh/zWJpccS/3bhNvWUglUfu98zU37qsGXrQMPC5
         H5yfXaUifH00mNZvnYiMFQ9FDnD1Ra3C00V/MdC2zK6H+ddmioYDauZ6SpE7elgyyU
         RK1Q4kv2Wg4KfgtWg2q5LmamT7gHlJ3LkyepuERraOMbeULjFzGzz1RiBDY3OOw7CW
         iSL+9GwIi6PKhJyWTX6u0MecDP1Lgp8/yY+Nf3izMSZjEfQHAg49RTirFgXj46gI0h
         ++Ndls24nOHuQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id fU8TQKLBSMrq; Fri, 29 Jun 2018 09:55:43 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B32F522D08D;
        Fri, 29 Jun 2018 09:55:43 -0400 (EDT)
Date:   Fri, 29 Jun 2018 09:55:43 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>
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
Message-ID: <820874666.9567.1530280543568.JavaMail.zimbra@efficios.com>
In-Reply-To: <CALCETrUrXk3wRg8SKhWf98v8jK=HwX9XLvP+Ypi+TktZoNx_Jg@mail.gmail.com>
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com> <CALCETrULo_VP4XHbXcZTevWY5d-6PdHUtrDS8DEF_OaozQOaNg@mail.gmail.com> <CA+55aFxZrv9koOGKNzpBjcpzwaKQBg9ybqcvQ9u=5d94y1F+mQ@mail.gmail.com> <CALCETrUrXk3wRg8SKhWf98v8jK=HwX9XLvP+Ypi+TktZoNx_Jg@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are <
 TASK_SIZE
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: validate rseq_cs fields are < TASK_SIZE
Thread-Index: M/QysoCtxfYa/h1k7UmBXhz0Y8lILQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 28, 2018, at 7:29 PM, Andy Lutomirski luto@kernel.org wrote:

> On Thu, Jun 28, 2018 at 2:22 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Thu, Jun 28, 2018 at 1:23 PM Andy Lutomirski <luto@kernel.org> wrote:
>>>
>>> This is okay with me for a fix outside the merge window.  Can you do a
>>> followup for the next merge window that fixes it better, though?  In
>>> particular, TASK_SIZE is generally garbage.  I think a better fix
>>> would be something like adding a new arch-overridable helper like:
>>>
>>> static inline unsigned long current_max_user_addr(void) { return TASK_SIZE; }
>>
>> We already have that. It's called "user_addr_max()".
> 
> Nah, that one is more or less equivalent to TASK_SIZE_MAX, except that
> it's different if set_fs() is used.

So which one would be right in this case ? AFAIU we want to ensure we don't
populate regs->ip with a bogus address that would make SYSRET or other return
to userspace instructions explode.

Is that guaranteed by TASK_SIZE or TASK_SIZE_MAX (aliased by user_addr_max()) ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

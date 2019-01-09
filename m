Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A06C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70B7214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546999508;
	bh=Ickqk2IZkIG8p04SgQek3hIsU1ZxkvWNSEhuLaJp8Mw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iaU3NTZOcGTrG9zBypsycOfbZwYuI8PGQ0CIsrfBYz4xJOdtAdI69Pokw12pmS/fo
	 OzQXs2cSk/UVCcb/kbxAyMbSBUYB7qa3x4kLGneTKcLMWZxF+uGSqF4mPqCe32Prvv
	 vrtRxaCkHf7lL5qQEQkWk48PqUoZWdqfPxpCmjNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfAICFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbfAICFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:05:07 -0500
Received: from devnote (p103030-mobac01.tokyo.ocn.ne.jp [153.233.94.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21085206BB;
        Wed,  9 Jan 2019 02:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546999506;
        bh=Ickqk2IZkIG8p04SgQek3hIsU1ZxkvWNSEhuLaJp8Mw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2AigcZnMw1WQlONJhKEoRIJcREnBHjp7eqluXdmyCKIr5U8I9VVFR0H+7GAI1ciyO
         ciZqVwHQOi0ZHkjJ5/tblVIwzgGKd4/ZIRQ3rFcBsXeJgO9KBL2XUdsEDRFA4lfVZM
         keNRAWE9I4zF9m49i5lO0uXSP3vB0vU1wVbZZVWA=
Date:   Wed, 9 Jan 2019 11:05:00 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: kprobes: Move extable address check into
 arch_prepare_kprobe()
Message-Id: <20190109110500.b4b5049f4c67dfc85b9ced4e@kernel.org>
In-Reply-To: <b4109104-c438-f4c2-352a-d8b0ec47db37@arm.com>
References: <154502881646.30629.9938335052821665530.stgit@devbox>
        <154502884653.30629.3172839440883293817.stgit@devbox>
        <aec51c10-d744-df0f-1216-d3372e779cb1@arm.com>
        <20190108113953.8bc0cc7d196ddba370377217@kernel.org>
        <b4109104-c438-f4c2-352a-d8b0ec47db37@arm.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Tue, 8 Jan 2019 17:13:36 +0000
James Morse <james.morse@arm.com> wrote:

> Hi!
> 
> On 08/01/2019 02:39, Masami Hiramatsu wrote:
> > On Thu, 3 Jan 2019 17:05:18 +0000
> > James Morse <james.morse@arm.com> wrote:
> >> On 17/12/2018 06:40, Masami Hiramatsu wrote:
> >>> Move extable address check into arch_prepare_kprobe() from
> >>> arch_within_kprobe_blacklist().
> >>
> >> I'm trying to work out the pattern for what should go in the blacklist, and what
> >> should be rejected by the arch code.
> >>
> >> It seems address-ranges should be blacklisted as the contents don't matter.
> >> easy-example: the idmap text.
> > 
> > Yes, more precisely, the code smaller than a function (symbol), it must be
> > rejected by arch_prepare_kprobe(), since blacklist is poplated based on
> > kallsyms.
> 
> Ah, okay, so the pattern is the blacklist should only be for whole symbols,
> (which explains why its usually based on sections).

Correct. Actually, the blacklist is generated based on the symbol info
from symbol address.

> I see kprobe_add_ksym_blacklist() would go wrong if you give it something like:
> platform_drv_probe+0x50/0xb0, as it will log platform_drv_probe+0x50 as the
> start_addr and platform_drv_probe+0x50+0xb0 as the end.

Yes, it expects given address is the entry of a symbol.

> 
> But how does anything from the arch code's blacklist get into the
> kprobe_blacklist list?

It should be done via arch_populate_kprobe_blacklist().

> 
> We don't have an arch_populate_kprobe_blacklist(), so rely on
> within_kprobe_blacklist() calling arch_within_kprobe_blacklist() with the
> address, as well as walking kprobe_blacklist.
> 
> Is this cleanup ahead of a series that does away with
> arch_within_kprobe_blacklist() so that debugfs list is always complete?

Right, after this cleanup, I will send arch_populate_kprobe_blacklist()
patch for arm64 and others. My plan is to move all arch_within_kprobe_blacklist()
to arch_populate_kprobe_blacklist() so that user can get more precise blacklist
via debugfs.


> > As I pointed, the exception_table contains some range of code which inside
> > functions, must be smaller than function.
> > Since those instructions are expected to cause exception (that is main reason
> > why it can not be probed on arm64), I thought such situation was similar to
> > the limitation of instruction.
> > 
> > So I think below will be better.
> > ----
> > Please do not blacklisting instructions on exception_table,
> > since those are smaller than one function.
> > ----
> 
> I keep tripping over this because the exception_table lists addresses that are
> allowed to fault. Nothing looks at the instruction, and we happily kprobe the
> same instruction elsewhere.

Thanks!

> 
> (based on my assumptions about where you are going next!,), How about:
> | The blacklist is exposed via debugfs as a list of symbols. extable entries are
> | smaller, so must be filtered out by arch_prepare_kprobe().

This looks much better for me too :)
Should I resend with the description?

Thank you!

> 
> (only we currently have more than one blacklist...)
> 
> 
> Thanks,
> 
> James


-- 
Masami Hiramatsu <mhiramat@kernel.org>

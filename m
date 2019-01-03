Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1956C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F55D2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbfACRFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:05:22 -0500
Received: from foss.arm.com ([217.140.101.70]:53250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730870AbfACRFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:05:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5A8615AD;
        Thu,  3 Jan 2019 09:05:21 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B8AB3F5D4;
        Thu,  3 Jan 2019 09:05:20 -0800 (PST)
Subject: Re: [PATCH 1/3] arm64: kprobes: Move extable address check into
 arch_prepare_kprobe()
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <154502881646.30629.9938335052821665530.stgit@devbox>
 <154502884653.30629.3172839440883293817.stgit@devbox>
From:   James Morse <james.morse@arm.com>
Message-ID: <aec51c10-d744-df0f-1216-d3372e779cb1@arm.com>
Date:   Thu, 3 Jan 2019 17:05:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <154502884653.30629.3172839440883293817.stgit@devbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 17/12/2018 06:40, Masami Hiramatsu wrote:
> Move extable address check into arch_prepare_kprobe() from
> arch_within_kprobe_blacklist().

I'm trying to work out the pattern for what should go in the blacklist, and what
should be rejected by the arch code.

It seems address-ranges should be blacklisted as the contents don't matter.
easy-example: the idmap text.

The arch code should also reject instructions that can't be probed from
arch_prepare_kprobe(). easy-example: exclusive load or store.


> Please do not blacklisting instructions on exception_table,
> since it is a kind of architectural unsupported instruction.

This doesn't fit the pattern, ... what should it be?

The instructions in the exception_table don't matter, its the address that
indicates there is a fixup for page-faults that occur here. We don't need to
look at the instruction to determine this, why can't we treated these as a
blacklisted range?


Thanks,

James


> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 2a5b338b2542..b2d4b7428ebc 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -102,6 +102,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  
>  	if (in_exception_text(probe_addr))
>  		return -EINVAL;
> +
> +	if (search_exception_tables(probe_addr))
> +		return -EINVAL;
> +
>  	if (probe_addr >= (unsigned long) __start_rodata &&
>  	    probe_addr <= (unsigned long) __end_rodata)
>  		return -EINVAL;
> @@ -477,8 +481,7 @@ bool arch_within_kprobe_blacklist(unsigned long addr)
>  	    (addr >= (unsigned long)__entry_text_start &&
>  	    addr < (unsigned long)__entry_text_end) ||
>  	    (addr >= (unsigned long)__idmap_text_start &&
> -	    addr < (unsigned long)__idmap_text_end) ||
> -	    !!search_exception_tables(addr))
> +	    addr < (unsigned long)__idmap_text_end))
>  		return true;
>  
>  	if (!is_kernel_in_hyp_mode()) {
> 


Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474CBC7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DED2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfAUMUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:20:11 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60964 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbfAUMUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:20:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B5EA80D;
        Mon, 21 Jan 2019 04:20:10 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 531CE3F614;
        Mon, 21 Jan 2019 04:20:09 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 4/4] arm64: kprobes: Use
 arch_populate_kprobe_blacklist()
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
 <154753353370.31541.14485875717131836689.stgit@devbox>
Message-ID: <7f840cc8-4e62-e1d7-9035-4361204fc134@arm.com>
Date:   Mon, 21 Jan 2019 12:20:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <154753353370.31541.14485875717131836689.stgit@devbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 15/01/2019 06:25, Masami Hiramatsu wrote:
> Use arch_populate_kprobe_blacklist() instead of
> arch_within_kprobe_blacklist() so that we can see the full
> blacklisted symbols under the debugfs.
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index b9e9758b6534..6c066c34c8a4 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -465,26 +465,30 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
>  	return DBG_HOOK_HANDLED;
>  }
>  
> -bool arch_within_kprobe_blacklist(unsigned long addr)
> +int __init arch_populate_kprobe_blacklist(void)
>  {
> -	if ((addr >= (unsigned long)__kprobes_text_start &&
> -	    addr < (unsigned long)__kprobes_text_end) ||
> -	    (addr >= (unsigned long)__entry_text_start &&
> -	    addr < (unsigned long)__entry_text_end) ||
> -	    (addr >= (unsigned long)__idmap_text_start &&
> -	    addr < (unsigned long)__idmap_text_end) ||

> -	    in_exception_text(addr))

You added this one in the previous patch, but it disappears here.


> -		return true;
> -
> -	if (!is_kernel_in_hyp_mode()) {
> -		if ((addr >= (unsigned long)__hyp_text_start &&
> -		    addr < (unsigned long)__hyp_text_end) ||
> -		    (addr >= (unsigned long)__hyp_idmap_text_start &&
> -		    addr < (unsigned long)__hyp_idmap_text_end))
> -			return true;
> -	}
> -
> -	return false;
> +	int ret;


> +	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
> +					(unsigned long)__kprobes_text_end);
> +	if (ret)
> +		return ret;

Now that we have arch_populate_kprobe_blacklist(), does the arch-code need to
blacklist the kprobes section itself?

The weak arch_within_kprobe_blacklist() will test it at kprobe-load time, and
populate_kprobe_blacklist() adds it to the list before it calls
arch_populate_kprobe_blacklist().

Won't this result in duplicate entries?


> +	ret = kprobe_add_area_blacklist((unsigned long)__entry_text_start,
> +					(unsigned long)__entry_text_end);
> +	if (ret)
> +		return ret;

> +	ret = kprobe_add_area_blacklist((unsigned long)__idmap_text_start,
> +					(unsigned long)__idmap_text_end);

> +	if (ret || is_kernel_in_hyp_mode())
> +		return ret;


Hmmm, I think we have a bug here today.

This is saying we can kprobe KVM when we have VHE, because all of KVMs code runs
at the same exception-level as the kernel. Which is true...
But KVM switches VBAR_EL1, so if we run over one of kprobes BRK instructions,
we're going to hyp-panic, because KVM doesn't handle synchronous exceptions from
EL2.

The __hyp_text also contains the guest entry/exit code, which we mustn't probe,
even on VHE.

I think we should always blacklist the __hyp_text, and KVM should mark its
vhe-only functions with __kprobes. I'll post patches for this.


Thanks,

James


> +	ret = kprobe_add_area_blacklist((unsigned long)__hyp_text_start,
> +					(unsigned long)__hyp_text_end);
> +	if (ret)
> +		return ret;
> +	ret = kprobe_add_area_blacklist((unsigned long)__hyp_idmap_text_start,
> +					(unsigned long)__hyp_idmap_text_end);
> +	return ret;
>  }
>  
>  void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
> 


Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92709C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695D420815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbfACRH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:07:26 -0500
Received: from foss.arm.com ([217.140.101.70]:53304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730915AbfACRHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:07:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75E8515AD;
        Thu,  3 Jan 2019 09:07:25 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3159F3F5D4;
        Thu,  3 Jan 2019 09:07:24 -0800 (PST)
Subject: Re: [PATCH 2/3] arm64: kprobes: Remove unneeded RODATA check
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <154502881646.30629.9938335052821665530.stgit@devbox>
 <154502887509.30629.17754148993239954461.stgit@devbox>
From:   James Morse <james.morse@arm.com>
Message-ID: <3bebf737-fe6b-33c8-e535-5d155591b303@arm.com>
Date:   Thu, 3 Jan 2019 17:07:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <154502887509.30629.17754148993239954461.stgit@devbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 17/12/2018 06:41, Masami Hiramatsu wrote:
> Remove unneeded RODATA check from arch_prepare_kprobe().
> 
> Since check_kprobe_address_safe() already ensured that
> the probe address is in kernel text, we don't need to
> check whether the address in RODATA or not. That must
> be always false.

So it does!

Reviewed-by: James Morse <james.morse@arm.com>


Thanks

James

> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index b2d4b7428ebc..1dae500d0a81 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -91,8 +91,6 @@ static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
>  int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  {
>  	unsigned long probe_addr = (unsigned long)p->addr;
> -	extern char __start_rodata[];
> -	extern char __end_rodata[];
>  
>  	if (probe_addr & 0x3)
>  		return -EINVAL;
> @@ -106,10 +104,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  	if (search_exception_tables(probe_addr))
>  		return -EINVAL;
>  
> -	if (probe_addr >= (unsigned long) __start_rodata &&
> -	    probe_addr <= (unsigned long) __end_rodata)
> -		return -EINVAL;
> -
>  	/* decode instruction */
>  	switch (arm_kprobe_decode_insn(p->addr, &p->ainsn)) {
>  	case INSN_REJECTED:	/* insn not supported */
> 


Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E52C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908E120657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfAOLUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 06:20:21 -0500
Received: from foss.arm.com ([217.140.101.70]:48258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbfAOLUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 06:20:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B02A1596;
        Tue, 15 Jan 2019 03:20:21 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9487D3F70D;
        Tue, 15 Jan 2019 03:20:19 -0800 (PST)
Date:   Tue, 15 Jan 2019 11:20:17 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 2/4] arm64: kprobes: Remove unneeded RODATA check
Message-ID: <20190115112016.GD43491@lakrids.cambridge.arm.com>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
 <154753347659.31541.11277302003578292109.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154753347659.31541.11277302003578292109.stgit@devbox>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 03:24:36PM +0900, Masami Hiramatsu wrote:
> Remove unneeded RODATA check from arch_prepare_kprobe().
> 
> Since check_kprobe_address_safe() already ensured that
> the probe address is in kernel text, we don't need to
> check whether the address in RODATA or not. That must
> be always false.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/probes/kprobes.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
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

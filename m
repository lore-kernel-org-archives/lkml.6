Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B05C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55BA2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 18:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55BA2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbeKHDc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:32:58 -0500
Received: from foss.arm.com ([217.140.101.70]:56066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbeKHDc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:32:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43FB315AB;
        Wed,  7 Nov 2018 10:01:28 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 771C13F5C0;
        Wed,  7 Nov 2018 10:01:26 -0800 (PST)
Date:   Wed, 7 Nov 2018 18:01:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, christoffer.dall@linaro.org,
        marc.zyngier@arm.com, Christoffer Dall <christoffer.dall@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] KVM: arm64: don't single-step for non-emulated faults
Message-ID: <20181107180120.urnvkcrkh46ytsdb@lakrids.cambridge.arm.com>
References: <20181107171031.22573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181107171031.22573-1-alex.bennee@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 05:10:31PM +0000, Alex Bennée wrote:
> Not all faults handled by handle_exit are instruction emulations. For
> example a ESR_ELx_EC_IABT will result in the page tables being updated
> but the instruction that triggered the fault hasn't actually executed
> yet. We use the simple heuristic of checking for a changed PC before
> seeing if kvm_arm_handle_step_debug wants to claim we stepped an
> instruction.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  arch/arm64/kvm/handle_exit.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index e5e741bfffe1..b8252e72f882 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -214,6 +214,7 @@ static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
>  static int handle_trap_exceptions(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  {
>  	int handled;
> +        unsigned long old_pc = *vcpu_pc(vcpu);
>  
>  	/*
>  	 * See ARM ARM B1.14.1: "Hyp traps on instructions
> @@ -233,7 +234,8 @@ static int handle_trap_exceptions(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  	 * kvm_arm_handle_step_debug() sets the exit_reason on the kvm_run
>  	 * structure if we need to return to userspace.
>  	 */
> -	if (handled > 0 && kvm_arm_handle_step_debug(vcpu, run))
> +	if (handled > 0 && *vcpu_pc(vcpu) != old_pc &&

This doesn't work if the emulation is equivalent to a branch-to-self, so
I don't think that we want to do this.

When are we failing to advance the single-step state machine correctly?

Thanks,
Mark.

> +	    kvm_arm_handle_step_debug(vcpu, run))
>  		handled = 0;
>  
>  	return handled;
> -- 
> 2.17.1
> 

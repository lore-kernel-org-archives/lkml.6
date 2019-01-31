Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8970C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865FD20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfAaRzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:55:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48846 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfAaRzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:55:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 490F4A78;
        Thu, 31 Jan 2019 09:55:08 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D82133F59C;
        Thu, 31 Jan 2019 09:55:05 -0800 (PST)
Date:   Thu, 31 Jan 2019 17:55:02 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        mlangsdo@redhat.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, julien.thierry@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        steven.price@arm.com, ykaukab@suse.de, dave.martin@arm.com,
        shankerd@codeaurora.org
Subject: Re: [PATCH v4 09/12] arm64: Use firmware to detect CPUs that are
 not affected by Spectre-v2
Message-ID: <20190131175502.12bed0f0@donnerap.cambridge.arm.com>
In-Reply-To: <20190125180711.1970973-10-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
        <20190125180711.1970973-10-jeremy.linton@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 12:07:08 -0600
Jeremy Linton <jeremy.linton@arm.com> wrote:

> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> The SMCCC ARCH_WORKAROUND_1 service can indicate that although the
> firmware knows about the Spectre-v2 mitigation, this particular
> CPU is not vulnerable, and it is thus not necessary to call
> the firmware on this CPU.
> 
> Let's use this information to our benefit.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Yes, I stumbled over this in the firmware spec as well:

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

> ---
>  arch/arm64/kernel/cpu_errata.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 4d23b4d4cfa8..024c83ffff99 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -217,22 +217,36 @@ static int detect_harden_bp_fw(void)
>  	case PSCI_CONDUIT_HVC:
>  		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
>  				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
> -		if ((int)res.a0 < 0)
> +		switch ((int)res.a0) {
> +		case 1:
> +			/* Firmware says we're just fine */
> +			return 0;
> +		case 0:
> +			cb = call_hvc_arch_workaround_1;
> +			/* This is a guest, no need to patch KVM vectors */
> +			smccc_start = NULL;
> +			smccc_end = NULL;
> +			break;
> +		default:
>  			return -1;
> -		cb = call_hvc_arch_workaround_1;
> -		/* This is a guest, no need to patch KVM vectors */
> -		smccc_start = NULL;
> -		smccc_end = NULL;
> +		}
>  		break;
>  
>  	case PSCI_CONDUIT_SMC:
>  		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
>  				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
> -		if ((int)res.a0 < 0)
> +		switch ((int)res.a0) {
> +		case 1:
> +			/* Firmware says we're just fine */
> +			return 0;
> +		case 0:
> +			cb = call_smc_arch_workaround_1;
> +			smccc_start = __smccc_workaround_1_smc_start;
> +			smccc_end = __smccc_workaround_1_smc_end;
> +			break;
> +		default:
>  			return -1;
> -		cb = call_smc_arch_workaround_1;
> -		smccc_start = __smccc_workaround_1_smc_start;
> -		smccc_end = __smccc_workaround_1_smc_end;
> +		}
>  		break;
>  
>  	default:


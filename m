Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7985C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932FB20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfA3SDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:03:31 -0500
Received: from foss.arm.com ([217.140.101.70]:59160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfA3SDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:03:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48D3180D;
        Wed, 30 Jan 2019 10:03:30 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 927163F557;
        Wed, 30 Jan 2019 10:03:27 -0800 (PST)
Date:   Wed, 30 Jan 2019 18:03:24 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        Jonathan Corbet <corbet@lwn.net>, mlangsdo@redhat.com,
        linux-doc@vger.kernel.org, suzuki.poulose@arm.com,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        julien.thierry@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, steven.price@arm.com,
        ykaukab@suse.de, dave.martin@arm.com, shankerd@codeaurora.org
Subject: Re: [PATCH v4 02/12] arm64: Provide a command line to disable
 spectre_v2 mitigation
Message-ID: <20190130180254.0b716b2c@donnerap.cambridge.arm.com>
In-Reply-To: <20190125180711.1970973-3-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
        <20190125180711.1970973-3-jeremy.linton@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2019 12:07:01 -0600
Jeremy Linton <jeremy.linton@arm.com> wrote:

Hi,

> There are various reasons, including bencmarking, to disable spectrev2
> mitigation on a machine. Provide a command-line to do so.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  Documentation/admin-guide/kernel-parameters.txt |  8 ++++----
>  arch/arm64/kernel/cpu_errata.c                  | 11 +++++++++++
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt index
> 9475f02c79da..2ae77979488e 100644 ---
> a/Documentation/admin-guide/kernel-parameters.txt +++
> b/Documentation/admin-guide/kernel-parameters.txt @@ -2849,10
> +2849,10 @@ check bypass). With this option data leaks are possible
>  			in the system.
>  
> -	nospectre_v2	[X86,PPC_FSL_BOOK3E] Disable all
> mitigations for the Spectre variant 2
> -			(indirect branch prediction) vulnerability.
> System may
> -			allow data leaks with this option, which is
> equivalent
> -			to spectre_v2=off.
> +	nospectre_v2	[X86,PPC_FSL_BOOK3E,ARM64] Disable all
> mitigations for
> +			the Spectre variant 2 (indirect branch
> prediction)
> +			vulnerability. System may allow data leaks
> with this
> +			option.
>  
>  	nospec_store_bypass_disable
>  			[HW] Disable all mitigations for the
> Speculative Store Bypass vulnerability diff --git
> a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 9950bb0cbd52..9a7b5fca51a0 100644 ---
> a/arch/arm64/kernel/cpu_errata.c +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -220,6 +220,14 @@ static void qcom_link_stack_sanitization(void)
>  		     : "=&r" (tmp));
>  }
>  
> +static bool __nospectre_v2;
> +static int __init parse_nospectre_v2(char *str)
> +{
> +	__nospectre_v2 = true;
> +	return 0;
> +}
> +early_param("nospectre_v2", parse_nospectre_v2);
> +
>  static void
>  enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities
> *entry) {
> @@ -231,6 +239,9 @@ enable_smccc_arch_workaround_1(const struct
> arm64_cpu_capabilities *entry) if (!entry->matches(entry,
> SCOPE_LOCAL_CPU)) return;
>  
> +	if (__nospectre_v2)
> +		return;
> +
>  	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
>  		return;
>  


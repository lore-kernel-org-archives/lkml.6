Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BA1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7772086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7772086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbeIDPNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:13:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39388 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbeIDPNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:13:11 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N_De4pobJ573; Tue,  4 Sep 2018 12:48:19 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC9A500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:a500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB1131EC0513;
        Tue,  4 Sep 2018 12:48:18 +0200 (CEST)
Date:   Tue, 4 Sep 2018 12:48:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 05/16] x86/pmu: enable Hygon support to PMU
 infrastructure
Message-ID: <20180904104812.GF32615@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <dcd5b900e26e3175e4cafded91ec28e53c79adf8.1535459013.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcd5b900e26e3175e4cafded91ec28e53c79adf8.1535459013.git.puwen@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 08:43:54PM +0800, Pu Wen wrote:
> Hygon PMU arch is similar to AMD Family 17h. To support Hygon PMU, the
> initialization flow for it just call amd_pmu_init() and change PMU name

That sentence reads funny.

> to "HYGON". To share AMD's flow, add code check for Hygon family ID 18h

s/family ID/family/

> to run the code path of AMD family 17h in core/uncore functions.
> 
> Also it returns the bit offset of the performance counter register and
> event selection register for Hygon CPU in the similar way as AMD does.

In general, you seem to be explaining *what* your patches do and not
*why*. This is the wrong. Always explain the *why* - the *what* is
visible from the diff.

You probably need to brush up on
Documentation/process/submitting-patches.rst, section 2.

> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/events/amd/core.c             |  6 ++++++
>  arch/x86/events/amd/uncore.c           | 15 ++++++++++-----
>  arch/x86/events/core.c                 |  4 ++++
>  arch/x86/kernel/cpu/perfctr-watchdog.c |  2 ++
>  4 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index c84584b..6c13c9d 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -669,6 +669,12 @@ static int __init amd_core_pmu_init(void)
>  		 * We fallback to using default amd_get_event_constraints.
>  		 */
>  		break;
> +	case 0x18:
> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
> +			pr_cont("Fam18h ");

Didn't we agree that you'll verify whether family 0x18 is going to be
Hygon only?

What happened to that checking?

> +			/* Using default amd_get_event_constraints. */
> +			break;
> +		}
>  	default:
>  		pr_err("core perfctr but no constraints; unknown hardware!\n");
>  		return -ENODEV;
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 981ba5e..9f2eb43 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -507,17 +507,22 @@ static int __init amd_uncore_init(void)
>  {
>  	int ret = -ENODEV;
>  
> -	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
> +	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
>  		return -ENODEV;
>  
>  	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
>  		return -ENODEV;
>  
> -	if (boot_cpu_data.x86 == 0x17) {
> +	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> +	     boot_cpu_data.x86 == 0x17) ||
> +	    (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON &&
> +	     boot_cpu_data.x86 == 0x18)) {

Same here.

What's up?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

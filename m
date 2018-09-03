Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5F5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6182220862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6182220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeICXZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:25:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40090 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbeICXZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:25:21 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xhfh28O4FYGw; Mon,  3 Sep 2018 21:03:31 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCF4100329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcf:4100:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE78E1EC00E5;
        Mon,  3 Sep 2018 21:03:31 +0200 (CEST)
Date:   Mon, 3 Sep 2018 21:04:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 03/16] x86/mtrr: get MTRR number and support TOP_MEM2
Message-ID: <20180903190438.GF10249@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <36ea05160d886ebf8d4a645c0fe8efdc9d6760c3.1535459013.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36ea05160d886ebf8d4a645c0fe8efdc9d6760c3.1535459013.git.puwen@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 08:43:23PM +0800, Pu Wen wrote:
> Hygon CPU have a special magic MSR way to force WB for memory >4GB,

It was "Hygon Dhyana" before now "Hygon" only. Can we agree on the
naming nomenclature and stick with it.

Also, it is "The ... CPU has a special..."

> and also support TOP_MEM2. Therefore, it is necessary to add Hygon
> support in amd_special_default_mtrr().
> 
> The MtrrFixDramModEn bit on Hygon platform should also be set to 1
> during BIOS initialization of the fixed MTRRs, then cleared to 0 for
> operation.
> 
> The number of variable MTRRs for Hygon is 2 as AMD's.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/cpu/mtrr/cleanup.c | 3 ++-
>  arch/x86/kernel/cpu/mtrr/generic.c | 5 +++--
>  arch/x86/kernel/cpu/mtrr/mtrr.c    | 2 +-
>  3 files changed, 6 insertions(+), 4 deletions(-)

...

> diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
> index e12ee86..77c3eaa 100644
> --- a/arch/x86/kernel/cpu/mtrr/generic.c
> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
> @@ -49,8 +49,9 @@ static inline void k8_check_syscfg_dram_mod_en(void)
>  {
>  	u32 lo, hi;
>  
> -	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
> -	      (boot_cpu_data.x86 >= 0x0f)))
> +	if (!((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> +	       boot_cpu_data.x86 >= 0x0f) ||
> +	       boot_cpu_data.x86_vendor == X86_VENDOR_HYGON))

Why are you even touching this statement? The function returns early on
!X86_VENDOR_AMD.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

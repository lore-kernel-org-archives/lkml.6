Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7400BC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0072077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0072077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeIDNkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:40:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36192 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbeIDNkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:40:15 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yb5bC5t3mX_e; Tue,  4 Sep 2018 11:15:42 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC9A500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:a500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 605DF1EC01AF;
        Tue,  4 Sep 2018 11:15:42 +0200 (CEST)
Date:   Tue, 4 Sep 2018 11:15:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 04/16] x86/smpboot: smp init nodelay and no flush
 caches before sleep
Message-ID: <20180904091536.GE32615@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <eaa743fb27e191e9e353db34c0960eede18c7213.1535459013.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eaa743fb27e191e9e353db34c0960eede18c7213.1535459013.git.puwen@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 08:43:41PM +0800, Pu Wen wrote:
> Dhyana use no delay in smp_quirk_init_udelay(), and return in
> mwait_play_dead() as AMD does.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/smpboot.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index f02ecaf..5369d7f 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -676,6 +676,7 @@ static void __init smp_quirk_init_udelay(void)
>  
>  	/* if modern processor, use no delay */
>  	if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 6)) ||
> +	    ((boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) && (boot_cpu_data.x86 >= 0x18)) ||
>  	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF))) {
>  		init_udelay = 0;
>  		return;
> @@ -1592,7 +1593,8 @@ static inline void mwait_play_dead(void)
>  	void *mwait_ptr;
>  	int i;
>  
> -	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>  		return;
>  	if (!this_cpu_has(X86_FEATURE_MWAIT))
>  		return;
> -- 

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7724CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBA2206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBA2206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeIDW7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:59:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55784 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbeIDW7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:59:46 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uwAH3MIH5ESy; Tue,  4 Sep 2018 20:33:08 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC9A500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc9:a500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF84D1EC02C1;
        Tue,  4 Sep 2018 20:33:07 +0200 (CEST)
Date:   Tue, 4 Sep 2018 20:33:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 08/16] x86/apic: add modern APIC support for Hygon
Message-ID: <20180904183301.GN32615@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <969a367a0b2d58f3e68bc6f97b6e8238e2390991.1535459013.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <969a367a0b2d58f3e68bc6f97b6e8238e2390991.1535459013.git.puwen@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 08:44:30PM +0800, Pu Wen wrote:
> Hygon processors use modern APIC, so just return in modern_apic() and
> sync_Arb_IDs(). And should break in switch case in detect_init_API().
> 
> When running on 32 bit mode, should set bigsmp if there are more than
> 8 cores.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/apic/apic.c     | 19 ++++++++++++++-----
>  arch/x86/kernel/apic/probe_32.c |  1 +
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 84132ed..a62968e 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -220,10 +220,15 @@ static inline int lapic_is_integrated(void)
>   */
>  static int modern_apic(void)
>  {
> -	/* AMD systems use old APIC versions, so check the CPU */
> -	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> -	    boot_cpu_data.x86 >= 0xf)
> +	/*
> +	 * Old AMD systems use old APIC versions, newer AMD systems
> +	 * and Hygon systems use modern APIC, so check the CPU
> +	 */
> +	if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> +	     boot_cpu_data.x86 >= 0xf) ||
> +	     boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>  		return 1;

Those compound conditionals are not nice to read. Just add yours
underneath:

	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
	    boot_cpu_data.x86 >= 0xf)
		return 1;

	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
		return 1;

Do that where applicable and where it makes sense, syntax-wise to have a
separate vendor == HYGON check in the other patches too.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

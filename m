Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FE3C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3BC20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D3BC20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeIKPNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:13:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35896 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbeIKPNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:13:35 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id n_swhVtXMV34; Tue, 11 Sep 2018 12:14:56 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC6F600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:f600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B8421EC0645;
        Tue, 11 Sep 2018 12:14:56 +0200 (CEST)
Date:   Tue, 11 Sep 2018 12:14:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pu Wen <puwen@hygon.cn>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 08/16] x86/apic: Add Hygon Dhyana support to APIC
Message-ID: <20180911101454.GE12094@zn.tnic>
References: <cover.1536550549.git.puwen@hygon.cn>
 <4f03e734faa5b2b69b0947a156bea29cddcc95ce.1536550550.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f03e734faa5b2b69b0947a156bea29cddcc95ce.1536550550.git.puwen@hygon.cn>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 09:17:27PM +0800, Pu Wen wrote:
> Add Hygon Dhyana support to the APIC subsystem as it use modern APIC.
> When running on 32 bit mode, bigsmp should be enabled if there are
> more than 8 cores online.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/kernel/apic/apic.c     | 13 +++++++++++--
>  arch/x86/kernel/apic/probe_32.c |  1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 84132ed..709daf2 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -224,6 +224,11 @@ static int modern_apic(void)
>  	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
>  	    boot_cpu_data.x86 >= 0xf)
>  		return 1;
> +
> +	/* Hygon systems use modern APIC */
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +		return 1;
> +
>  	return lapic_get_version() >= 0x14;
>  }
>  
> @@ -1211,9 +1216,11 @@ void __init sync_Arb_IDs(void)
>  {
>  	/*
>  	 * Unsupported on P4 - see Intel Dev. Manual Vol. 3, Ch. 8.6.1 And not
> -	 * needed on AMD.
> +	 * needed on AMD or Hygon.
>  	 */
> -	if (modern_apic() || boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +	if (modern_apic() ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)

This change is not needed, after the above hunk in modern_apic(), right?

With it removed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

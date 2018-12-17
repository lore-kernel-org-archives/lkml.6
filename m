Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2EAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166D82146E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PmddviDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732516AbeLQNBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:01:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35786 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbeLQNBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:01:33 -0500
Received: from zn.tnic (p200300EC2BC8CE00D4EA132E5C1A5535.dip0.t-ipconnect.de [IPv6:2003:ec:2bc8:ce00:d4ea:132e:5c1a:5535])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 56DC51EC0B8E;
        Mon, 17 Dec 2018 14:01:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1545051691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rgJ5C0IaBtYbPn2yaT/5YTDU0gB+kOEGct8IFlveftc=;
        b=PmddviDUSBxZ/d+ezGamzMaoHvmYqzwIZn3Xxw1ss4SOfNFTEGhNIsDnsKRJDvpp0GQ1Tr
        zCtn/YYxtPvu/o8fgHDgN4jLms28wle8zzZu11yO28SxW0d5zsmqXUzfuj4wnmZCUK2H94
        Z1yY6xNNRTIrzYluQRaCOOYpDHudM4Q=
Date:   Mon, 17 Dec 2018 14:01:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2 v3] kdump,vmcoreinfo: Export the value of sme mask to
 vmcoreinfo
Message-ID: <20181217130129.GE12165@zn.tnic>
References: <20181216131617.2612-1-lijiang@redhat.com>
 <20181216131617.2612-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181216131617.2612-3-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 09:16:17PM +0800, Lianbo Jiang wrote:
> For AMD machine with SME feature, makedumpfile tools need to know
> whether the crash kernel was encrypted or not. If SME is enabled
> in the first kernel, the crash kernel's page table(pgd/pud/pmd/pte)
> contains the memory encryption mask, so need to remove the sme mask
> to obtain the true physical address.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 4c8acdfdc5a7..1860fe24117d 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -352,10 +352,24 @@ void machine_kexec(struct kimage *image)
>  
>  void arch_crash_save_vmcoreinfo(void)
>  {
> +	u64 sme_mask = sme_me_mask;
> +
>  	VMCOREINFO_NUMBER(phys_base);
>  	VMCOREINFO_SYMBOL(init_top_pgt);
>  	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>  			pgtable_l5_enabled());
> +	/*
> +	 * Currently, the local variable 'sme_mask' stores the value of
> +	 * sme_me_mask(bit 47), and also write the value of sme_mask to
> +	 * the vmcoreinfo.
> +	 * If need, the bit(sme_mask) might be redefined in the future,
> +	 * but the 'bit63' will be reserved.
> +	 * For example:
> +	 * [ misc	   ][ enc bit  ][ other misc SME info       ]
> +	 * 0000_0000_0000_0000_1000_0000_0000_0000_0000_0000_..._0000
> +	 * 63   59   55   51   47   43   39   35   31   27   ... 3
> +	 */

This text belongs into the document.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

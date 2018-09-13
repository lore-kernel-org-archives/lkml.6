Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B213BC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED7020853
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 23:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED7020853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeINEgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 00:36:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46622 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeINEgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 00:36:38 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0ayk-0003GU-BU; Fri, 14 Sep 2018 01:24:54 +0200
Date:   Fri, 14 Sep 2018 01:24:53 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v8 1/2] x86/mm: add .bss..decrypted section to hold shared
 variables
In-Reply-To: <1536875471-17391-2-git-send-email-brijesh.singh@amd.com>
Message-ID: <alpine.DEB.2.21.1809140122590.1473@nanos.tec.linutronix.de>
References: <1536875471-17391-1-git-send-email-brijesh.singh@amd.com> <1536875471-17391-2-git-send-email-brijesh.singh@amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018, Brijesh Singh wrote:
>  
> +void __weak mem_encrypt_free_decrypted_mem(void) { }
> +
>  void __ref free_initmem(void)
>  {
>  	e820__reallocate_tables();
>  
> +	mem_encrypt_free_decrypted_mem();
> +
>  	free_kernel_image_pages(&__init_begin, &__init_end);
>  }
>  
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index b2de398..718acdf 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -348,6 +348,16 @@ bool sev_active(void)
>  EXPORT_SYMBOL(sev_active);
>  
>  /* Architecture __weak replacement functions */
> +void __init mem_encrypt_free_decrypted_mem(void)
> +{
> +	if (mem_encrypt_active())
> +		return;

Why?

> +
> +	free_init_pages("unused decrypted",
> +			(unsigned long)__start_bss_decrypted_unused,
> +			(unsigned long)__end_bss_decrypted);

Everything _AFTER_ __start_bss_decrypted_unused _IS_ unused and can be
freed. No conditional nothing. It's unused in any case.

Thanks,

	tglx



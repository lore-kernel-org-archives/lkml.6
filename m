Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76DAC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616F02075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616F02075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbeIFQ7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:59:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:50332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727757AbeIFQ7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:59:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8E85AAD53;
        Thu,  6 Sep 2018 12:24:25 +0000 (UTC)
Date:   Thu, 6 Sep 2018 14:24:23 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
Message-ID: <20180906122423.GA11144@zn.tnic>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 06:43:02AM -0500, Brijesh Singh wrote:
> Currently, the per-cpu pvclock data is allocated dynamically when
> cpu > HVC_BOOT_ARRAY_SIZE. The physical address of this variable is
> shared between the guest and the hypervisor hence it must be mapped as
> unencrypted (ie. C=0) when SEV is active.
> 
> When SEV is active, we will be wasting fairly sizeable amount of memory
> since each CPU will be doing a separate 4k allocation so that it can clear
> C-bit. Let's define few extra static page sized array of pvclock data.
> In the preparatory stage of CPU hotplug, use the element of this static
> array to avoid the dynamic allocation. This array will be put in
> the .data..decrypted section so that its mapped with C=0 during the boot.
> 
> In non-SEV case, this static page will unused and free'd by the
> free_decrypted_mem().
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: kvm@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: kvm@vger.kernel.org
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> ---
>  arch/x86/include/asm/mem_encrypt.h |  4 ++++
>  arch/x86/kernel/kvmclock.c         | 22 +++++++++++++++++++---
>  arch/x86/kernel/vmlinux.lds.S      |  3 +++
>  arch/x86/mm/init.c                 |  3 +++
>  arch/x86/mm/mem_encrypt.c          | 10 ++++++++++
>  5 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 802b2eb..aa204af 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -48,11 +48,13 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
>  
>  /* Architecture __weak replacement functions */
>  void __init mem_encrypt_init(void);
> +void __init free_decrypted_mem(void);
>  
>  bool sme_active(void);
>  bool sev_active(void);
>  
>  #define __decrypted __attribute__((__section__(".data..decrypted")))
> +#define __decrypted_hvclock __attribute__((__section__(".data..decrypted_hvclock")))

So are we going to be defining a decrypted section for every piece of
machinery now?

That's a bit too much in my book.

Why can't you simply free everything in .data..decrypted on !SVE guests?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 

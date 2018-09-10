Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EA7C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B60D20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 11:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B60D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeIJQaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:30:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:33036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727646AbeIJQaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:30:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA014AEE6;
        Mon, 10 Sep 2018 11:36:45 +0000 (UTC)
Date:   Mon, 10 Sep 2018 13:36:45 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v6 2/5] x86/mm: fix sme_populate_pgd() to update page
 flags
Message-ID: <20180910113645.GB21815@zn.tnic>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
 <1536343050-18532-3-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536343050-18532-3-git-send-email-brijesh.singh@amd.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:57:27PM -0500, Brijesh Singh wrote:
> Fix sme_populate_pgd() to update page flags if the PMD/PTE entry
> already exists.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
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
>  arch/x86/mm/mem_encrypt_identity.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index 92265d3..7659e65 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -154,9 +154,6 @@ static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
>  		return;
>  
>  	pmd = pmd_offset(pud, ppd->vaddr);
> -	if (pmd_large(*pmd))
> -		return;
> -
>  	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
>  }
>  
> @@ -182,8 +179,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
>  		return;
>  
>  	pte = pte_offset_map(pmd, ppd->vaddr);
> -	if (pte_none(*pte))
> -		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
> +	set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
>  }
>  
>  static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
> -- 

This looks like a bugfix to me and as such should be:

* at the beginning of the series
* contain a Fixes: tag
* contain Cc: <stable@vger.kernel.org>

Right?

With that addressed:

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 

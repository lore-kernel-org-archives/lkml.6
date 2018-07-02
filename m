Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5E4C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C555224176
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C555224176
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752664AbeGBPBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:01:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752055AbeGBPBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:01:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 162247A7E5;
        Mon,  2 Jul 2018 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-57.ams2.redhat.com [10.36.116.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 217B82026D5B;
        Mon,  2 Jul 2018 15:01:32 +0000 (UTC)
Subject: Re: [PATCH v3 08/20] kvm: arm/arm64: Abstract stage2 pgd table
 allocation
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-9-git-send-email-suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        marc.zyngier@arm.com, cdall@kernel.org, julien.grall@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <ac15d082-22eb-54d1-d695-6a0a3ac2d1eb@redhat.com>
Date:   Mon, 2 Jul 2018 17:01:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-9-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 02 Jul 2018 15:01:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 02 Jul 2018 15:01:34 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki

On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
> Abstract the allocation of stage2 entry level tables for
> given VM, so that later we can choose to fall back to the
> normal page table levels (i.e, avoid entry level table
> concatenation) on arm64.

the justification is not crystal clear to me but it does no harm I think.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2:
>  - New patch
> ---
>  arch/arm/include/asm/kvm_mmu.h   | 6 ++++++
>  arch/arm64/include/asm/kvm_mmu.h | 6 ++++++
>  virt/kvm/arm/mmu.c               | 2 +-
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index f36eb20..b2da5a4 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -372,6 +372,12 @@ static inline int hyp_map_aux_data(void)
>  	return 0;
>  }
>  
> +static inline void *stage2_alloc_pgd(struct kvm *kvm)
> +{
> +	return alloc_pages_exact(stage2_pgd_size(kvm),
> +				 GFP_KERNEL | __GFP_ZERO);
> +}
> +
>  #define kvm_phys_to_vttbr(addr)		(addr)
>  
>  #endif	/* !__ASSEMBLY__ */
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 5da8f52..dbaf513 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -501,5 +501,11 @@ static inline int hyp_map_aux_data(void)
>  
>  #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
>  
> +static inline void *stage2_alloc_pgd(struct kvm *kvm)
> +{
> +	return alloc_pages_exact(stage2_pgd_size(kvm),
> +				 GFP_KERNEL | __GFP_ZERO);
> +}
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ARM64_KVM_MMU_H__ */
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 82dd571..a339e00 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -868,7 +868,7 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
>  	}
>  
>  	/* Allocate the HW PGD, making sure that each page gets its own refcount */
> -	pgd = alloc_pages_exact(stage2_pgd_size(kvm), GFP_KERNEL | __GFP_ZERO);
> +	pgd = stage2_alloc_pgd(kvm);
>  	if (!pgd)
>  		return -ENOMEM;
>  
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

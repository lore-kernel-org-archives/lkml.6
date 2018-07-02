Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19A3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9740208B7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9740208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965036AbeGBK5j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:57:39 -0400
Received: from foss.arm.com ([217.140.101.70]:57276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753200AbeGBK5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:57:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB76E18A;
        Mon,  2 Jul 2018 03:57:37 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF8643F5BA;
        Mon,  2 Jul 2018 03:57:35 -0700 (PDT)
Subject: Re: [PATCH v3 09/20] kvm: arm64: Make stage2 page table layout
 dynamic
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-10-git-send-email-suzuki.poulose@arm.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <8a6b81ef-ff78-41b5-b004-c60ba7e5a9a7@arm.com>
Date:   Mon, 2 Jul 2018 11:57:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-10-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/18 12:15, Suzuki K Poulose wrote:
> So far we had a static stage2 page table handling code, based on a
> fixed IPA of 40bits. As we prepare for a configurable IPA size per
> VM, make our stage2 page table code dynamic, to do the right thing
> for a given VM. We ensure the existing condition is always true even
> when we lift the limit on the IPA. i.e,
> 
> 	page table levels in stage1 >= page table levels in stage2
> 
> Support for the IPA size configuration needs other changes in the way
> we configure the EL2 registers (VTTBR and VTCR). So, the IPA is still
> fixed to 40bits. The patch also moves the kvm_page_empty() in asm/kvm_mmu.h
> to the top, before including the asm/stage2_pgtable.h to avoid a forward
> declaration.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V2
>   - Restrict the stage2 page table to allow reusing the host page table
>     helpers for now, until we get stage1 independent page table helpers.

...

> -#define stage2_pgd_none(kvm, pgd)		pgd_none(pgd)
> -#define stage2_pgd_clear(kvm, pgd)		pgd_clear(pgd)
> -#define stage2_pgd_present(kvm, pgd)		pgd_present(pgd)
> -#define stage2_pgd_populate(kvm, pgd, pud)	pgd_populate(NULL, pgd, pud)
> -#define stage2_pud_offset(kvm, pgd, address)	pud_offset(pgd, address)
> -#define stage2_pud_free(kvm, pud)		pud_free(NULL, pud)
> +#define __s2_pud_index(addr) \
> +	(((addr) >> __S2_PUD_SHIFT) & (PTRS_PER_PTE - 1))
> +#define __s2_pmd_index(addr) \
> +	(((addr) >> __S2_PMD_SHIFT) & (PTRS_PER_PTE - 1))
>   
> -#define stage2_pud_table_empty(kvm, pudp)	kvm_page_empty(pudp)
> +#define __kvm_has_stage2_levels(kvm, min_levels)	\
> +  ((CONFIG_PGTABLE_LEVELS >= min_levels) && (kvm_stage2_levels(kvm) >= min_levels))

On another look, I have renamed the helpers as follows :

kvm_stage2_has_pud(kvm) => kvm_stage2_has_pmd(kvm)
kvm_stage2_has_pgd(kvm) => kvm_stage2_has_pud(kvm)

below and everywhere.

> +
> +#define kvm_stage2_has_pgd(kvm)	__kvm_has_stage2_levels(kvm, 4)
> +#define kvm_stage2_has_pud(kvm) __kvm_has_stage2_levels(kvm, 3)


Suzuki

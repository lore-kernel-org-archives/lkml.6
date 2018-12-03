Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3570DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B5120850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 13:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B5120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeLCNdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 08:33:21 -0500
Received: from foss.arm.com ([217.140.101.70]:37218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbeLCNdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 08:33:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D46E80D;
        Mon,  3 Dec 2018 05:32:19 -0800 (PST)
Received: from [10.1.37.145] (p8cg001049571a15.cambridge.arm.com [10.1.37.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49D473F614;
        Mon,  3 Dec 2018 05:32:17 -0800 (PST)
Subject: Re: [PATCH v9 2/8] KVM: arm/arm64: Re-factor setting the Stage 2
 entry to exec on fault
To:     Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
Cc:     suzuki.poulose@arm.com, marc.zyngier@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        punitagrawal@gmail.com, linux-arm-kernel@lists.infradead.org
References: <20181031175745.18650-1-punit.agrawal@arm.com>
 <20181031175745.18650-3-punit.agrawal@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <12212830-ffc6-a0e0-5de6-3e6a15ed7141@arm.com>
Date:   Mon, 3 Dec 2018 19:02:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181031175745.18650-3-punit.agrawal@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2018 11:27 PM, Punit Agrawal wrote:
> Stage 2 fault handler marks a page as executable if it is handling an
> execution fault or if it was a permission fault in which case the
> executable bit needs to be preserved.
> 
> The logic to decide if the page should be marked executable is
> duplicated for PMD and PTE entries. To avoid creating another copy
> when support for PUD hugepages is introduced refactor the code to
> share the checks needed to mark a page table entry as executable.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  virt/kvm/arm/mmu.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 59595207c5e1..6912529946fb 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1475,7 +1475,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  			  unsigned long fault_status)
>  {
>  	int ret;
> -	bool write_fault, exec_fault, writable, force_pte = false;
> +	bool write_fault, writable, force_pte = false;
> +	bool exec_fault, needs_exec;

New line not required, still within 80 characters.

>  	unsigned long mmu_seq;
>  	gfn_t gfn = fault_ipa >> PAGE_SHIFT;
>  	struct kvm *kvm = vcpu->kvm;
> @@ -1598,19 +1599,25 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	if (exec_fault)
>  		invalidate_icache_guest_page(pfn, vma_pagesize);
>  
> +	/*
> +	 * If we took an execution fault we have made the
> +	 * icache/dcache coherent above and should now let the s2

Coherent or invalidated with invalidate_icache_guest_page ?

> +	 * mapping be executable.
> +	 *
> +	 * Write faults (!exec_fault && FSC_PERM) are orthogonal to
> +	 * execute permissions, and we preserve whatever we have.
> +	 */

Otherwise looks good.

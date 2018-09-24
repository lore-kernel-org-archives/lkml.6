Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2B1ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B2D2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B2D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeIYC5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:57:08 -0400
Received: from foss.arm.com ([217.140.101.70]:41860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbeIYC5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:57:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82C017A9;
        Mon, 24 Sep 2018 13:53:04 -0700 (PDT)
Received: from [10.37.9.1] (unknown [10.37.9.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A9FA3F5B7;
        Mon, 24 Sep 2018 13:53:02 -0700 (PDT)
Subject: Re: [PATCH v7 1/9] KVM: arm/arm64: Ensure only THP is candidate for
 adjustment
To:     Punit Agrawal <punit.agrawal@arm.com>, kvmarm@lists.cs.columbia.edu
Cc:     marc.zyngier@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        stable@vger.kernel.org
References: <20180924174552.8387-1-punit.agrawal@arm.com>
 <20180924174552.8387-2-punit.agrawal@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2827f67b-d734-aca5-d790-c350a81f0792@arm.com>
Date:   Mon, 24 Sep 2018 21:54:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180924174552.8387-2-punit.agrawal@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Punit,

On 09/24/2018 06:45 PM, Punit Agrawal wrote:
> PageTransCompoundMap() returns true for hugetlbfs and THP
> hugepages. This behaviour incorrectly leads to stage 2 faults for
> unsupported hugepage sizes (e.g., 64K hugepage with 4K pages) to be
> treated as THP faults.
> 
> Tighten the check to filter out hugetlbfs pages. This also leads to
> consistently mapping all unsupported hugepage sizes as PTE level
> entries at stage 2.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: stable@vger.kernel.org # v4.13+
> ---
>   virt/kvm/arm/mmu.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 7e477b3cae5b..c23a1b323aad 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1231,8 +1231,14 @@ static bool transparent_hugepage_adjust(kvm_pfn_t *pfnp, phys_addr_t *ipap)
>   {
>   	kvm_pfn_t pfn = *pfnp;
>   	gfn_t gfn = *ipap >> PAGE_SHIFT;
> +	struct page *page = pfn_to_page(pfn);
>   
> -	if (PageTransCompoundMap(pfn_to_page(pfn))) {
> +	/*
> +	 * PageTransCompoungMap() returns true for THP and
> +	 * hugetlbfs. Make sure the adjustment is done only for THP
> +	 * pages.
> +	 */
> +	if (!PageHuge(page) && PageTransCompoundMap(page)) {

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

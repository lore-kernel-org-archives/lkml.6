Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EA282C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA900208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA900208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935055AbeFMJRl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:17:41 -0400
Received: from foss.arm.com ([217.140.101.70]:44712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934512AbeFMJRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:17:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E090980D;
        Wed, 13 Jun 2018 02:17:39 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 894853F557;
        Wed, 13 Jun 2018 02:17:38 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] arm64/mm: migrate swapper_pg_dir and tramp_pg_dir
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, labbott@redhat.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <20180606043921.19851-1-yaojun8558363@gmail.com>
 <20180606043921.19851-4-yaojun8558363@gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <1ef0fd31-001d-0872-7089-70ec22bab59f@arm.com>
Date:   Wed, 13 Jun 2018 10:17:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606043921.19851-4-yaojun8558363@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

On 06/06/18 05:39, Jun Yao wrote:
> Migrate swapper_pg_dir and tramp_pg_dir. And their virtual addresses
> do not correlate with kernel's address.

This is all to make 'KSMA' harder, where an single arbitrary write is used to
add a block mapping to the page-tables, giving the attacker full access to
physical memory.

This series is pretty complicated, and would still be overcome by arbitrary-read
of __pa_swapper_pg_dir. Any attacker already has to defeat KASLR, but I guess
that can be done without having read-access.


> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 94056e064c6f..ba0b55158971 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -637,10 +647,29 @@ static void __init map_kernel(pgd_t *pgdp)
>   */
>  void __init paging_init(void)
>  {
> -	phys_addr_t pgd_phys = early_pgtable_alloc();
> -	pgd_t *pgdp = pgd_set_fixmap(pgd_phys);
> +	phys_addr_t pgd_phys;
> +	pgd_t *pgdp;
> +	phys_addr_t mem_size;
>
> -	__pa_swapper_pg_dir = __pa_symbol(swapper_pg_dir);
> +	mem_size = __pa_symbol(swapper_pg_dir) + PAGE_SIZE
> +			- (__pa_symbol(idmap_pg_dir) + IDMAP_DIR_SIZE);
> +
> +	if (mem_size == PAGE_SIZE) {
> +		pgd_phys = early_pgtable_alloc();

This is where we migrated swapper_pg_dir to, its the first memblock_alloc()
call, and is guaranteed to be at the top of memory. Moving this allocation later
will still cause a predictable page to be allocated as this setup code is the
only thing running. I don't think we are in a better position after this series.


Ideally we would put these pgd entries in the read-only section. We only modify
swapper_pg_dir for vmalloc()/vmap() once its generated, which we could do
through a fixmap entry.

Like this, an attacker can find where swapper_pg_dir is, but can't write to it.
(the tricky bit will be breaking swapper_pg_dir up, as we free parts of it)


Thanks,

James

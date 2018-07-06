Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDA0C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBE420871
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBE420871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932352AbeGFI6t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:58:49 -0400
Received: from foss.arm.com ([217.140.101.70]:32858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753864AbeGFI6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:58:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AC30ED1;
        Fri,  6 Jul 2018 01:58:43 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CCA93F2EA;
        Fri,  6 Jul 2018 01:58:41 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] arm64/mm: Make swapper_pg_dir smaller
To:     Jun Yao <yaojun8558363@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
 <20180702111659.25570-5-yaojun8558363@gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <00553a1b-f354-ea74-c0c2-e68f9c6a16a5@arm.com>
Date:   Fri, 6 Jul 2018 09:58:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702111659.25570-5-yaojun8558363@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

On 02/07/18 12:16, Jun Yao wrote:
> Make swapper_pg_dir smaller so we don't need to memblock_free() it.

Patch looks good, but could the commit message explain why its now safe to do this?

Thanks,

James


> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index d4fc68286a49..d69e11ad92e3 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -236,7 +236,7 @@ SECTIONS
>  	. += RESERVED_TTBR0_SIZE;
>  #endif
>  	swapper_pg_dir = .;
> -	. += SWAPPER_DIR_SIZE;
> +	. += PAGE_SIZE;
>  	swapper_pg_end = .;
>  
>  	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index a7ab0010ff80..a1e8fc624324 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -632,14 +632,6 @@ void __init paging_init(void)
>  	map_mem(swapper_pg_dir);
>  	cpu_replace_ttbr1(swapper_pg_dir);
>  	init_mm.pgd = swapper_pg_dir;
> -
> -	/*
> -	 * We only reuse the PGD from the swapper_pg_dir, not the pud + pmd
> -	 * allocated with it.
> -	 */
> -	memblock_free(__pa_symbol(swapper_pg_dir) + PAGE_SIZE,
> -		      __pa_symbol(swapper_pg_end) - __pa_symbol(swapper_pg_dir)
> -		      - PAGE_SIZE);
>  }
>  
>  /*
> 


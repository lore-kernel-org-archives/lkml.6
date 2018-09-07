Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CF1C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7A5204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7A5204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeIGOhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:37:24 -0400
Received: from foss.arm.com ([217.140.101.70]:57844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbeIGOhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:37:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3972ED1;
        Fri,  7 Sep 2018 02:57:13 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2BD03F614;
        Fri,  7 Sep 2018 02:57:12 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 1/6] arm64/mm: Introduce the init_pg_dir.
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
 <20180822095432.12125-2-yaojun8558363@gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <6e614449-5574-98f6-cc39-f6fbddea48d8@arm.com>
Date:   Fri, 7 Sep 2018 10:57:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822095432.12125-2-yaojun8558363@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

On 22/08/18 10:54, Jun Yao wrote:
> To make the swapper_pg_dir read only, we will move it to the rodata
> section. And force the kernel to set up the initial page table in
> the init_pg_dir. After generating all levels page table, we copy
> only the top level into the swapper_pg_dir during paging_init().

Could you add v3's
| Add init_pg_dir to vmlinux.lds.S and boiler-plate
| clearing/cleaning/invalidating it in head.S.

too. This makes it obvious that 'init_pg_dir isn't used yet' is deliberate.

Reviewed-by: James Morse <james.morse@arm.com>


Some boring nits:

> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 0bcc98dbba56..eb363a915c0e 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -456,6 +456,35 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU

> +/*
> + * clear_pages - clear contiguous pages
> + *
> + *	start, end: page aligend virtual addresses

(Nit: aligned)


> + */
> +	.macro clear_pages, start:req, end:req

> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 605d1b60469c..61d7cee3eaa6 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -68,6 +68,12 @@ jiffies = jiffies_64;
>  #define TRAMP_TEXT
>  #endif
>  
> +#define INIT_PG_TABLES					\

                               ^ These are tabs ...

> +	. = ALIGN(PAGE_SIZE);                           \

                               ^ ... but these are spaces.

> +	init_pg_dir = .;                                \
> +	. += SWAPPER_DIR_SIZE;                          \
> +	init_pg_end = .;

Please pick one and stick with it. The macro above,
CONFIG_UNMAP_KERNEL_AT_EL0, uses tabs, please do the same.



Thanks,

James

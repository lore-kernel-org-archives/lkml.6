Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56459C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E28021571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E28021571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeI1Dei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:34:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41086 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbeI1Deh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:34:37 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eRuZGft152Vs; Thu, 27 Sep 2018 23:14:23 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC7FB00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:fb00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 113E21EC0104;
        Thu, 27 Sep 2018 23:14:23 +0200 (CEST)
Date:   Thu, 27 Sep 2018 23:14:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] ACPI / NUMA: Add warning message if the padding
 size for KASLR is not enough
Message-ID: <20180927211425.GC19687@zn.tnic>
References: <20180927203146.12201-1-msys.mizuma@gmail.com>
 <20180927203146.12201-3-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927203146.12201-3-msys.mizuma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 04:31:45PM -0400, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> Add warning message if the padding size for KASLR,
> rand_mem_physical_padding, is not enough. The message also
> says the suitable padding size.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  arch/x86/include/asm/setup.h |  2 ++
>  drivers/acpi/numa.c          | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
> index ae13bc9..65a5bf8 100644
> --- a/arch/x86/include/asm/setup.h
> +++ b/arch/x86/include/asm/setup.h
> @@ -80,6 +80,8 @@ static inline unsigned long kaslr_offset(void)
>  	return (unsigned long)&_text - __START_KERNEL;
>  }
>  
> +extern int rand_mem_physical_padding;
> +
>  /*
>   * Do NOT EVER look at the BIOS memory size location.
>   * It does not work on many machines.
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index 8516760..9c3cc3c 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -32,6 +32,7 @@
>  #include <linux/numa.h>
>  #include <linux/nodemask.h>
>  #include <linux/topology.h>
> +#include <asm/setup.h>
>  
>  static nodemask_t nodes_found_map = NODE_MASK_NONE;
>  
> @@ -435,6 +436,8 @@ acpi_table_parse_srat(enum acpi_srat_type id,
>  int __init acpi_numa_init(void)
>  {
>  	int cnt = 0;
> +	u32 max_phys_addr_tb;
> +	u64 max_phys_addr;
>  
>  	if (acpi_disabled)
>  		return -EINVAL;
> @@ -463,6 +466,17 @@ int __init acpi_numa_init(void)
>  
>  		cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
>  					    acpi_parse_memory_affinity, 0);
> +
> +		if (parsed_numa_memblks && kaslr_enabled()) {
> +			max_phys_addr = PFN_PHYS(max_possible_pfn);
> +			max_phys_addr_tb = (roundup(max_phys_addr, 1ULL << 40)) >> 40;
> +
> +			if (max_phys_addr_tb > rand_mem_physical_padding)
> +				pr_warn("Set 'rand_mem_physical_padding=%d' "
> +					"as the kernel parameter. "
> +					"Otherwise, memory hotadd may be failed.\n",
> +					max_phys_addr_tb);

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense:

WARNING: quoted string split across lines
#75: FILE: drivers/acpi/numa.c:476:
+                               pr_warn("Set 'rand_mem_physical_padding=%d' "
+                                       "as the kernel parameter. "

WARNING: quoted string split across lines
#76: FILE: drivers/acpi/numa.c:477:
+                                       "as the kernel parameter. "
+                                       "Otherwise, memory hotadd may be failed.\n",

total: 0 errors, 2 warnings, 40 lines checked

Also, that sentence needs polishing:

				pr_warn("Set 'rand_mem_physical_padding=%d' to avoid memory hotadd failure.\n",


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

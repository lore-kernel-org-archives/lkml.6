Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64108C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9A3214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9A3214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeHUSMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:12:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726730AbeHUSMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:12:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C105401EF05;
        Tue, 21 Aug 2018 14:51:44 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ACB32157F4A;
        Tue, 21 Aug 2018 14:51:43 +0000 (UTC)
Date:   Tue, 21 Aug 2018 22:51:40 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND] [PATCH 1/2] x86/mm: Add an option to change the padding
 used for the physical memory mapping.
Message-ID: <20180821145140.GD29313@MiWiFi-R3L-srv>
References: <20180821132401.14563-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821132401.14563-1-msys.mizuma@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 21 Aug 2018 14:51:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 21 Aug 2018 14:51:44 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masa,

On 08/21/18 at 09:24am, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> There are some exceptional cases that the padding used for the physical
> memory mapping section is not enough.
> 
> For example of the cases:
> - As Baoquan reported in the following, SGI UV system.
>   https://lkml.org/lkml/2017/9/7/87
> - Each node of physical memory layout has huge space for hotplug.
>   For exapmle of the layout:
>     SRAT: Node 6 PXM 4 [mem 0x100000000000-0x13ffffffffff] hotplug
>     SRAT: Node 7 PXM 5 [mem 0x140000000000-0x17ffffffffff] hotplug
>     SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
>     SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
> 
> We can increase the padding by CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
> however, the available entropy is decreased if the padding is increased.
> So the config change is not very good for the other most of systems.
> And, the needed padding size depends on the system environment, for
> example physical memory layout, so the kernel option is better than
> changing the config.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  arch/x86/mm/kaslr.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
> index 61db77b..8c7b4f6 100644
> --- a/arch/x86/mm/kaslr.c
> +++ b/arch/x86/mm/kaslr.c
> @@ -33,6 +33,9 @@
>  
>  #define TB_SHIFT 40

I think this fix makes sense. Since we usually compiled in hotplug code
by default, while may not really hot plug a memory board on most of
systems. However on those systems which really need do hot plug, and
might plug memory board onto physical position above 10TB, this will
cause issues.

One tiny concern is that we have below definition for 5-level, means we
can only have 4PB of system RAM for now. Not sure if one day it will be
enlarged to 32PB as Documentation/x86/x86_64/mm.txt tell.

# define MAX_PHYSMEM_BITS       (pgtable_l5_enabled() ? 52 : 46)

Otherwise this patchset looks good to me.

Thanks
Baoquan

>  
> +#define MAX_PADDING_L4 63
> +#define MAX_PADDING_L5 32767
> +
>  /*
>   * The end address could depend on more configuration options to make the
>   * highest amount of space for randomization available, but that's too hard
> @@ -40,6 +43,7 @@
>   */
>  static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
>  
> +static int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
>  /*
>   * Memory regions randomized by KASLR (except modules that use a separate logic
>   * earlier during boot). The list is ordered based on virtual addresses. This
> @@ -69,6 +73,20 @@ static inline bool kaslr_memory_enabled(void)
>  	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
>  }
>  
> +static int __init rand_mem_physical_padding_setup(char *str)
> +{
> +	int max_padding = pgtable_l5_enabled() ? MAX_PADDING_L5 : MAX_PADDING_L4;
> +
> +	get_option(&str, &rand_mem_physical_padding);
> +	if (rand_mem_physical_padding < 0)
> +		rand_mem_physical_padding = 0;
> +	else if (rand_mem_physical_padding > max_padding)
> +		rand_mem_physical_padding = max_padding;
> +
> +	return 0;
> +}
> +early_param("rand_mem_physical_padding", rand_mem_physical_padding_setup);
> +
>  /* Initialize base and padding for each memory region randomized with KASLR */
>  void __init kernel_randomize_memory(void)
>  {
> @@ -102,7 +120,7 @@ void __init kernel_randomize_memory(void)
>  	 */
>  	BUG_ON(kaslr_regions[0].base != &page_offset_base);
>  	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
> -		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
> +		rand_mem_physical_padding;
>  
>  	/* Adapt phyiscal memory region size based on available memory */
>  	if (memory_tb < kaslr_regions[0].size_tb)
> -- 
> 2.18.0
> 

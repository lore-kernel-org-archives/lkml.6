Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25A4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915F9222B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549893639;
	bh=gAcLZCvaf697fBssYCzqmTNdBjX5B3sShmA/VEMU08Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M0/oKGLXOHGajl4uxRuI2ln2SnBW6s1G8yZK9lbXk2NdjxaI+M8C97QAA9VdgQGdD
	 k4LYLXNgY0zidoTpzsKkegV8N+jVNdM6WvteSZGq+ddWDOnY6zE+80C+x56y7++G9c
	 XPBgv/l6dpzed+byzwSxwrrs0BtGTIC1uxu67rck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfBKOAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:00:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:49426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfBKOAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:00:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3A27ACB5;
        Mon, 11 Feb 2019 14:00:34 +0000 (UTC)
Date:   Mon, 11 Feb 2019 15:00:31 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH] arm: use memblocks_present
Message-ID: <20190211140031.GD15609@dhcp22.suse.cz>
References: <20190211131602.3294-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211131602.3294-1-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-02-19 13:04:59, Peng Fan wrote:
> arm_memory_present is doing same thing as memblocks_present, so
> let's use common code memblocks_present instead of platform
> specific arm_memory_present.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/arm/mm/init.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 478ea8b7db87..6c50dd407ba8 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -182,21 +182,6 @@ int pfn_valid(unsigned long pfn)
>  EXPORT_SYMBOL(pfn_valid);
>  #endif
>  
> -#ifndef CONFIG_SPARSEMEM
> -static void __init arm_memory_present(void)
> -{
> -}
> -#else
> -static void __init arm_memory_present(void)
> -{
> -	struct memblock_region *reg;
> -
> -	for_each_memblock(memory, reg)
> -		memory_present(0, memblock_region_memory_base_pfn(reg),
> -			       memblock_region_memory_end_pfn(reg));
> -}
> -#endif
> -
>  static bool arm_memblock_steal_permitted = true;
>  
>  phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
> @@ -292,7 +277,7 @@ void __init bootmem_init(void)
>  	 * Sparsemem tries to allocate bootmem in memory_present(),
>  	 * so must be done after the fixed reservations
>  	 */
> -	arm_memory_present();
> +	memblocks_present();
>  
>  	/*
>  	 * sparse_init() needs the bootmem allocator up and running.
> -- 
> 2.16.4

-- 
Michal Hocko
SUSE Labs

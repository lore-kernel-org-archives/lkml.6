Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2780C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FDE20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kL0VTn13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfAOPgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:36:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfAOPgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bs9ahMtpRGHw9gEJAKE7tGeHnnlpDtM946YCPVveanI=; b=kL0VTn13Tn/2/UFCR0SUF6UO0
        tQAzM7U3dg7xEVj/dOPJH3DyYsj1vEg0cqf8z+HLSCr9uQ8am9lHvUx0iQUuJ6iBj5h+f38sOcDJj
        60vACHwfG2ovQBusuPSkdoJA/tPQM4J1n1PgQiAwnfo8VMuE/yAzLJqPBJyBNFhrmpAxTWEoJldkQ
        S7LckID5XVKVq/wHEkAvu0YR+ikrBpO/0YKefd0QKGvKJjNGGxb6T7Kb4IJYq6iW3R/IbzouygIrf
        cNVD2PBGVeXq7puW/YiGOC2vVnoxFHbUSRqR9Rv3dVEnR/VubnuENKdzfPHuu6C2S8YczaGooSZ4g
        M6Bwu+vSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjQlB-0003Zr-UR; Tue, 15 Jan 2019 15:36:13 +0000
Date:   Tue, 15 Jan 2019 07:36:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     guoren@kernel.org
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Mao Han <mao_han@c-sky.com>
Subject: Re: [PATCH] riscv: fixup max_low_pfn with PFN_DOWN.
Message-ID: <20190115153613.GC26443@infradead.org>
References: <1547280987-7630-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547280987-7630-1-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 04:16:27PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> max_low_pfn should be pfn_size not byte_size.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Signed-off-by: Mao Han <mao_han@c-sky.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> ---
>  arch/riscv/kernel/setup.c | 2 +-
>  arch/riscv/mm/init.c      | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index fc8006a..5463e67 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -174,7 +174,7 @@ static void __init setup_bootmem(void)
>  	BUG_ON(mem_size == 0);
>  
>  	set_max_mapnr(PFN_DOWN(mem_size));
> -	max_low_pfn = memblock_end_of_DRAM();
> +	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());

I know it is used just above, but can we please just switch this
code to use >> PAGE_SHIFT instead of PFN_DOWN, which just horribly
obsfucates what is going on?

>  
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	setup_initrd();
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 1d9bfaf..658ebf6 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -28,7 +28,8 @@ static void __init zone_sizes_init(void)
>  	unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
>  
>  #ifdef CONFIG_ZONE_DMA32
> -	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(min(4UL * SZ_1G, max_low_pfn));
> +	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(min(4UL * SZ_1G,
> +			(unsigned long) PFN_PHYS(max_low_pfn)));
>  #endif

Same comment as above here, plus I think we should just use
memblock_end_of_DRAM directly, e.g. something like:

static const phys_addr_t max_dma32_addr = 4UL * SZ_1G;

	max_zone_pfns[ZONE_DMA32] =
		min(memblock_end_of_DRAM(), max_dma32_addr) >> PAGE_SHIFT;


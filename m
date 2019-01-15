Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3C2C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4F220651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fXM3Hw6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbfAONrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:47:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbfAONrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HKwWGfjFsBOepYIjsvu+8/WUfnnmynO3PAyY32Kp0b4=; b=fXM3Hw6nCzDANnVvjxrhdpcvZ
        IjcTotK5uLRE45G5QGErESA9zg9CJxAljIx6qNqQq2boo8qKWQ6l3IO1z7gNJr1usQNAp8XOaHWRf
        +1GBP2YDC/osT3+VWdZhHXUxpA0aBUiX0UJ3FbQECARIJN5BX7lD1kzXeLLhv7QUnbv0Y/M6HvahZ
        cXqPM3WXIlCAKGzgFY1FOnrymPCxbBbZBobegrbwMsICWY536N9Ta8YuvZB4z0u+Pt1m1CRS8eIrV
        AR4rXxVzGDHiJfwNPTeLtMtNM9fKRL57Cgje7El0squU3jZgo2GI+OYv5BL8ePHzgAgCNPX32H3JP
        HBT4aSFmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjP4F-0007SO-0D; Tue, 15 Jan 2019 13:47:47 +0000
Date:   Tue, 15 Jan 2019 05:47:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 5/5] RISC-V: Implement compile-time fixed mappings
Message-ID: <20190115134746.GF13216@infradead.org>
References: <20190107161047.10516-1-anup@brainfault.org>
 <20190107161047.10516-6-anup@brainfault.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107161047.10516-6-anup@brainfault.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 09:40:47PM +0530, Anup Patel wrote:
> From: Anup Patel <anup.patel@wdc.com>
> 
> This patch implements compile-time virtual to physical
> mappings. These compile-time fixed mappings can be used
> by earlycon, ACPI, and early ioremap for creating fixed
> mappings when FIX_EARLYCON_MEM=y.
> 
> To start with, we have enabled compile-time fixed
> mappings for earlycon.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/Kconfig              |  3 ++
>  arch/riscv/include/asm/fixmap.h | 52 +++++++++++++++++++++++++++++++++
>  arch/riscv/mm/init.c            | 32 ++++++++++++++++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 arch/riscv/include/asm/fixmap.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e0d7d61779a6..66094aba9a59 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -86,6 +86,9 @@ config GENERIC_CSUM
>  config GENERIC_HWEIGHT
>  	def_bool y
>  
> +config FIX_EARLYCON_MEM
> +	def_bool y
> +

Can you please throw in a prep patch to move FIX_EARLYCON_MEM to
drivers/tty/serial/Kconfig and only select it from the architectures
that use it?

> + * fixmap.h: compile-time virtual memory allocation

No need to mention the header name.

> + */
> +
> +#ifndef _ASM_RISCV_FIXMAP_H
> +#define _ASM_RISCV_FIXMAP_H
> +
> +#ifndef __ASSEMBLY__

As far as I can tell we never include this header from assembly files,
so this ifdef should not be needed.

> +/*
> + * Here we define all the compile-time 'special' virtual
> + * addresses. The point is to have a constant address at
> + * compile time, but to set the physical address only
> + * in the boot process.
> + *
> + * These 'compile-time allocated' memory buffers are
> + * page-sized. Use set_fixmap(idx,phys) to associate
> + * physical memory with fixmap indices.
> + */

Please use up the available 80 chars per line for comments.

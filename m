Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E14CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97831206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97831206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeGTJ5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:57:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39595 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbeGTJ5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:57:34 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 71AF72073D; Fri, 20 Jul 2018 11:10:14 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 21E8E20618;
        Fri, 20 Jul 2018 11:10:04 +0200 (CEST)
Date:   Fri, 20 Jul 2018 11:10:04 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 1/2] ia64: use asm-generic/io.h
Message-ID: <20180720111004.3bbb6b8f@bbrezillon>
In-Reply-To: <20180711120824.3882108-1-arnd@arndb.de>
References: <20180711120824.3882108-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Miquel

On Wed, 11 Jul 2018 14:08:05 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> asm-generic/io.h provides a generic implementation of all I/O accessors,
> which the architectures can override.
> 
> Since ia64 does not provide readsl/writesl etc, any driver using those
> fails to build, and including asm-generic/io.h will provide the
> missing interfaces, as well as any other future interfaces that get
> added there. We need to #define a couple of symbols to themselves
> in the ia64 to ensure that we use the ia64 specific version of those
> rather than the generic one.
> 
> There should be no other effect than adding {read,write}s{b,w,l}()
> as well as {in,out}s{b,w,l}_p(), which were also not provided
> by ia64 but are provided by the generic header for historic reasons.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

As for the other patch, I compile-tested it and it fixes the
compilation errors reported by kbuild robots.

Tested-by: Boris Brezillon <boris.brezillon@bootlin.com>

If everyone is fine with that, we'll take the patch through the NAND
tree.

Thanks,

Boris

> ---
>  arch/ia64/include/asm/io.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
> index fb0651961e2c..6f952171abf9 100644
> --- a/arch/ia64/include/asm/io.h
> +++ b/arch/ia64/include/asm/io.h
> @@ -83,12 +83,14 @@ virt_to_phys (volatile void *address)
>  {
>  	return (unsigned long) address - PAGE_OFFSET;
>  }
> +#define virt_to_phys virt_to_phys
>  
>  static inline void*
>  phys_to_virt (unsigned long address)
>  {
>  	return (void *) (address + PAGE_OFFSET);
>  }
> +#define phys_to_virt phys_to_virt
>  
>  #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
>  extern u64 kern_mem_attribute (unsigned long phys_addr, unsigned long size);
> @@ -433,9 +435,11 @@ static inline void __iomem * ioremap_cache (unsigned long phys_addr, unsigned lo
>  {
>  	return ioremap(phys_addr, size);
>  }
> +#define ioremap ioremap
> +#define ioremap_nocache ioremap_nocache
>  #define ioremap_cache ioremap_cache
>  #define ioremap_uc ioremap_nocache
> -
> +#define iounmap iounmap
>  
>  /*
>   * String version of IO memory access ops:
> @@ -444,6 +448,13 @@ extern void memcpy_fromio(void *dst, const volatile void __iomem *src, long n);
>  extern void memcpy_toio(volatile void __iomem *dst, const void *src, long n);
>  extern void memset_io(volatile void __iomem *s, int c, long n);
>  
> +#define memcpy_fromio memcpy_fromio
> +#define memcpy_toio memcpy_toio
> +#define memset_io memset_io
> +#define xlate_dev_kmem_ptr xlate_dev_kmem_ptr
> +#define xlate_dev_mem_ptr xlate_dev_mem_ptr
> +#include <asm-generic/io.h>
> +
>  # endif /* __KERNEL__ */
>  
>  #endif /* _ASM_IA64_IO_H */


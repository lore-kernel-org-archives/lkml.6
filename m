Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD89ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2EC20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2EC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbeGTJKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:10:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38283 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbeGTJKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:10:49 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 831A8207AD; Fri, 20 Jul 2018 10:23:39 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 33EF420618;
        Fri, 20 Jul 2018 10:23:39 +0200 (CEST)
Date:   Fri, 20 Jul 2018 10:23:39 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-ia64@vger.kernel.org, linux-alpha@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 2/2] sparc64: add reads{b,w,l}/writes{b,w,l}
Message-ID: <20180720102339.22c9aa57@bbrezillon>
In-Reply-To: <20180711120824.3882108-2-arnd@arndb.de>
References: <20180711120824.3882108-1-arnd@arndb.de>
        <20180711120824.3882108-2-arnd@arndb.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Miquel who's in charge of the NAND tree for this release

On Wed, 11 Jul 2018 14:08:06 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> Some drivers need these for compile-testing. On most architectures
> they come from asm-generic/io.h, but not on sparc64, which has its
> own definitions.
> 
> Since we already have ioread*_rep()/iowrite*_rep() that have the
> same behavior on sparc64 (i.e. all PCI I/O space is memory mapped),
> we can rename the existing helpers and add macros to define them
> to the same implementation.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I tried to compile a sparc64 kernel with COMPILE_TEST=y plus the
orion and s3c2410 NAND drivers enabled and it compiles fine (it does
without this patch). So it seems to fix the compilation error reported
by kbuild robots.

Tested-by: Boris Brezillon <boris.brezillon@bootlin>
(only compile-tested)

Dave gave his A-b, so, if everyone is okay with that, I'd like this
patch to go trough the NAND tree.

Thanks,

Boris

> ---
>  arch/sparc/include/asm/io_64.h | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
> index 9a1e9cbc7e6d..b162c23ae8c2 100644
> --- a/arch/sparc/include/asm/io_64.h
> +++ b/arch/sparc/include/asm/io_64.h
> @@ -243,35 +243,42 @@ void insb(unsigned long, void *, unsigned long);
>  void insw(unsigned long, void *, unsigned long);
>  void insl(unsigned long, void *, unsigned long);
>  
> -static inline void ioread8_rep(void __iomem *port, void *buf, unsigned long count)
> +static inline void readsb(void __iomem *port, void *buf, unsigned long count)
>  {
>  	insb((unsigned long __force)port, buf, count);
>  }
> -static inline void ioread16_rep(void __iomem *port, void *buf, unsigned long count)
> +static inline void readsw(void __iomem *port, void *buf, unsigned long count)
>  {
>  	insw((unsigned long __force)port, buf, count);
>  }
>  
> -static inline void ioread32_rep(void __iomem *port, void *buf, unsigned long count)
> +static inline void readsl(void __iomem *port, void *buf, unsigned long count)
>  {
>  	insl((unsigned long __force)port, buf, count);
>  }
>  
> -static inline void iowrite8_rep(void __iomem *port, const void *buf, unsigned long count)
> +static inline void writesb(void __iomem *port, const void *buf, unsigned long count)
>  {
>  	outsb((unsigned long __force)port, buf, count);
>  }
>  
> -static inline void iowrite16_rep(void __iomem *port, const void *buf, unsigned long count)
> +static inline void writesw(void __iomem *port, const void *buf, unsigned long count)
>  {
>  	outsw((unsigned long __force)port, buf, count);
>  }
>  
> -static inline void iowrite32_rep(void __iomem *port, const void *buf, unsigned long count)
> +static inline void writesl(void __iomem *port, const void *buf, unsigned long count)
>  {
>  	outsl((unsigned long __force)port, buf, count);
>  }
>  
> +#define ioread8_rep(p,d,l)	readsb(p,d,l)
> +#define ioread16_rep(p,d,l)	readsw(p,d,l)
> +#define ioread32_rep(p,d,l)	readsl(p,d,l)
> +#define iowrite8_rep(p,d,l)	writesb(p,d,l)
> +#define iowrite16_rep(p,d,l)	writesw(p,d,l)
> +#define iowrite32_rep(p,d,l)	writesl(p,d,l)
> +
>  /* Valid I/O Space regions are anywhere, because each PCI bus supported
>   * can live in an arbitrary area of the physical address range.
>   */


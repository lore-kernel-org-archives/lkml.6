Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeCZNkL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 09:40:11 -0400
Received: from verein.lst.de ([213.95.11.211]:35402 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751938AbeCZNkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 09:40:10 -0400
Date: Mon, 26 Mar 2018 15:40:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: linux-next: Failure to build using next-20180326 and
        next-20180323
Message-ID: <20180326134007.GA15204@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The real problem is commit 1f85b42a691cd8329ba82dbcaeec80ac1231b32a from
the arm64 tree, which eventually need to be reverted and redone properly.

But for now a fixup to rename the arm64 dma_to_phys and phys_to_dma
helper is enough to build.

On Mon, Mar 26, 2018 at 12:20:30PM +0200, Neil Armstrong wrote:
> Hi,
> 
> While building on arm64, the commit b6e05477c10c ("dma/direct: Handle the memory encryption bit in common code") breaks the compilation using defconfig:
> 
>   CC      arch/arm64/mm/dma-mapping.o
> In file included from arch/arm64/mm/dma-mapping.c:27:0:
> ./include/linux/dma-direct.h:40:26: error: redefinition of ‘phys_to_dma’
>  static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>                           ^~~~~~~~~~~
> In file included from ./include/linux/dma-direct.h:9:0,
>                  from arch/arm64/mm/dma-mapping.c:27:
> ./arch/arm64/include/asm/dma-direct.h:12:26: note: previous definition of ‘phys_to_dma’ was here
>  static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
>                           ^~~~~~~~~~~
> In file included from ./include/linux/dma-mapping.h:13:0,
>                  from ./include/linux/dma-direct.h:5,
>                  from arch/arm64/mm/dma-mapping.c:27:
> ./include/linux/dma-direct.h: In function ‘phys_to_dma’:
> ./include/linux/dma-direct.h:42:19: error: implicit declaration of function ‘__phys_to_dma’ [-Werror=implicit-function-declaration]
>   return __sme_set(__phys_to_dma(dev, paddr));
>                    ^
> ./include/linux/mem_encrypt.h:50:24: note: in definition of macro ‘__sme_set’
>  #define __sme_set(x)  (x)
>                         ^
> In file included from arch/arm64/mm/dma-mapping.c:27:0:
> ./include/linux/dma-direct.h: At top level:
> ./include/linux/dma-direct.h:45:27: error: redefinition of ‘dma_to_phys’
>  static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
>                            ^~~~~~~~~~~
> In file included from ./include/linux/dma-direct.h:9:0,
>                  from arch/arm64/mm/dma-mapping.c:27:
> ./arch/arm64/include/asm/dma-direct.h:19:27: note: previous definition of ‘dma_to_phys’ was here
>  static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
>                            ^~~~~~~~~~~
> In file included from ./include/linux/dma-mapping.h:13:0,
>                  from ./include/linux/dma-direct.h:5,
>                  from arch/arm64/mm/dma-mapping.c:27:
> ./include/linux/dma-direct.h: In function ‘dma_to_phys’:
> ./include/linux/dma-direct.h:47:19: error: implicit declaration of function ‘__dma_to_phys’ [-Werror=implicit-function-declaration]
>   return __sme_clr(__dma_to_phys(dev, daddr));
>                    ^
> ./include/linux/mem_encrypt.h:51:24: note: in definition of macro ‘__sme_clr’
>  #define __sme_clr(x)  (x)
>                         ^
> cc1: some warnings being treated as errors
> scripts/Makefile.build:312: recipe for target 'arch/arm64/mm/dma-mapping.o' failed
> make[1]: *** [arch/arm64/mm/dma-mapping.o] Error 1
> Makefile:1057: recipe for target 'arch/arm64/mm' failed
> make: *** [arch/arm64/mm] Error 2
> 
> Reverting the commit fixes the build.
> 
> Neil
> 
> -- 
> Neil Armstrong
> Embedded Linux Software Engineer
> BayLibre - At the Heart of Embedded Linux
> www.baylibre.com
---end quoted text---

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934993AbeEJK23 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:28:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:43563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756686AbeEJK21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:28:27 -0400
Message-ID: <1525948096.29445.4.camel@gmx.de>
Subject: Re: kernel spew from nouveau/ swiotlb
From: Mike Galbraith <efault@gmx.de>
To: nouveau <nouveau@lists.freedesktop.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ben Skeggs <bskeggs@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Roger He <Hongbo.He@amd.com>
Date: Thu, 10 May 2018 12:28:16 +0200
In-Reply-To: <1525943427.8013.11.camel@gmx.de>
References: <1525943427.8013.11.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:HmOHihd2tWH7fzhZErR5kHWaRaZFykvIz9GKVU8PIRT66+wtzEz
 0H+7jP+8ik7T06ILKq9gjryLDETJ8wUT0kG88pZOX0xmXCOmhtyAOAIFSRHiP6KfNF7mvAs
 KxEWAGM/u/X+8nbZX3G2oojVgJbrVJs17YMKvY/7a2mxK48aF6sTeuKYnK3LXsgGyGDn/m6
 tHtzehdFQhiySIRdXIBRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CZfBLTFEMxQ=:gqB+cdeGIHQdtElwI4mEQz
 92cL3Icd1sAYrnScOP4FRQTevYTMjqJDSWHdqufuPXkSeky32Gnsvysk/JsYAoyYQazFeMizV
 zXSfYonvV9SwnLebGW+xk1shT2NS7a7pSSosuHDfxMsRRDMphQy0Ssa+4+L3J37uBacDQXyIC
 dFlV0gqCIyOOPCI2iWhn/9cLX8PqGGjwoae3IvWdPA1VaclhtEGpVLYmvzSMZINz+ogvebopy
 OHNBnP6u7cDx1r1sq+em1SnAVVK1qqc8vh2tfNOGmrn1JKaE6m2I3b/uJgVdORbJeCFc2wYO3
 fVQKQ+ZdRUJ1KZp4QtBaNZ6mVLbIHfKXWcxOh9xgVdGlFdtAn53JNhDTOZY32TRQoNxvOAShm
 8FAUWwIx6pV/y3xznMu+CYFX+cNEMVFmFXpuKnT6Or094pBKUP/nQMG92D2U559JLroXbWyL9
 CwF+oBBQWB9QWQ6Nn8Dxao0TqX3hbN1OOGlHDFcKTCDpoYQj3QbIduW2MLierUKiEjx4rqnZK
 0gQ0Ox7KDv/X/CAz+4fT33vNhvLq7TkxbFyrJMSn+f/4NJiU4Gje8OfKw/W2QhUNkCmneoqhL
 r6+MvrMk3W1MVGROL/X6WIKeuVLU6wszSDR9zBgsap9PGklLI/PW3doHQxMNVGsaX/xMO9G1x
 FnQl/R8LWWOR+pc+nzUvbrMckxr9YFQue5I7YE4XKCgvx3J49dFNvWNa6KESIrLg4+G3Ig9GN
 rmh6TccJVuYi8+9ZHm03CHoaZpU53Zis3XUXwMH0lvJQb2WjHzYwpc1ouhiNJaPaLTjeYNbaU
 USgDu9c
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-10 at 11:10 +0200, Mike Galbraith wrote:
> Greetings,
> 
> When box is earning its keep, nouveau/swiotlb grumble.. a LOT.  The
> below is from master.today.
> 
> [12594.640959] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> [12594.693000] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> [12594.713787] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> [12594.743413] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> [12594.796740] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> [12607.000774] swiotlb_tbl_map_single: 54 callbacks suppressed
> [12607.000776] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> [12607.347941] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> [12608.677038] nouveau 0000:01:00.0: swiotlb buffer is full (sz: 2097152 bytes)
> homer:/novell/ssh # dmesg|grep 'swiotlb buffer is full'|wc -l
> 2052
> homer:/novell/ssh # dmesg|grep 'callbacks suppressed'|wc -l
> 171
> 
> lib/swiotlb.c:
>  573 not_found:
>  574         spin_unlock_irqrestore(&io_tlb_lock, flags);
>  575         if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
>  576                 dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
> 
> Does nouveau perhaps want one of those DMA_ATTR_NO_WARN thingies?

Or should ttm perhaps always use the one on hand?  (seems to work)

---
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
@@ -342,7 +342,7 @@ static struct dma_page *__ttm_dma_alloc_
 	if (!d_page)
 		return NULL;
 
-	if (pool->type & IS_HUGE)
+	if (1 || pool->type & IS_HUGE)
 		attrs = DMA_ATTR_NO_WARN;
 
 	vaddr = dma_alloc_attrs(pool->dev, pool->size, &d_page->dma,

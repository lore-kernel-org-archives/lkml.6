Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeBHNGy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 08:06:54 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:49433 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeBHNGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 08:06:53 -0500
Date: Thu, 8 Feb 2018 05:06:49 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Michal Hocko <mhocko@suse.com>, Laura Abbott <labbott@redhat.com>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression after commit 19809c2da28a ("mm, vmalloc: use
 __GFP_HIGHMEM implicitly")
Message-ID: <20180208130649.GA15846@bombadil.infradead.org>
References: <627DA40A-D0F6-41C1-BB5A-55830FBC9800@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <627DA40A-D0F6-41C1-BB5A-55830FBC9800@canonical.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 02:29:57PM +0800, Kai Heng Feng wrote:
> A user with i386 instead of AMD64 machine reports [1] that commit 19809c2da28a ("mm, vmalloc: use __GFP_HIGHMEM implicitly”) causes a regression.
> BUG_ON(PageHighMem(pg)) in drivers/media/common/saa7146/saa7146_core.c always gets triggered after that commit.

Well, the BUG_ON is wrong.  You can absolutely have pages which are both
HighMem and under the 4GB boundary.  Only the first 896MB (iirc) are LowMem,
and the next 3GB of pages are available to vmalloc_32().

> Also there are other BUG_ON(PageHighMem()) in drivers/media, I think they will get hit by same regression in 32bit machine too.

I fixed one of them.  I think the other three are also bogus, but it's
hard to say; the comments say "DMA to HighMem might not work", and they
probably mean "above the 4GB boundary", but I really don't know.

(since two drivers now have this code, maybe it should be part of the core
MM API?  Or maybe there's already something better they should be using?)

diff --git a/drivers/media/common/saa7146/saa7146_core.c b/drivers/media/common/saa7146/saa7146_core.c
index 9f7c5b0a6b45..329fd43228ff 100644
--- a/drivers/media/common/saa7146/saa7146_core.c
+++ b/drivers/media/common/saa7146/saa7146_core.c
@@ -160,7 +160,7 @@ static struct scatterlist* vmalloc_to_sg(unsigned char *virt, int nr_pages)
 		pg = vmalloc_to_page(virt);
 		if (NULL == pg)
 			goto err;
-		BUG_ON(PageHighMem(pg));
+		BUG_ON(page_to_pfn(pg) >= (1 << (32 - PAGE_SHIFT)));
 		sg_set_page(&sglist[i], pg, PAGE_SIZE, 0);
 	}
 	return sglist;
diff --git a/drivers/media/v4l2-core/videobuf-dma-sg.c b/drivers/media/v4l2-core/videobuf-dma-sg.c
index f412429cf5ba..b5ec74b9c867 100644
--- a/drivers/media/v4l2-core/videobuf-dma-sg.c
+++ b/drivers/media/v4l2-core/videobuf-dma-sg.c
@@ -77,7 +77,7 @@ static struct scatterlist *videobuf_vmalloc_to_sg(unsigned char *virt,
 		pg = vmalloc_to_page(virt);
 		if (NULL == pg)
 			goto err;
-		BUG_ON(PageHighMem(pg));
+		BUG_ON(page_to_pfn(pg) >= (1 << (32 - PAGE_SHIFT)));
 		sg_set_page(&sglist[i], pg, PAGE_SIZE, 0);
 	}
 	return sglist;

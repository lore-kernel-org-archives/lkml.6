Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966136AbeBMXGh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:06:37 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:54230 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966002AbeBMXGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:06:36 -0500
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 4/5] ALSA: emu10k1: make sure synth DMA pages are allocated
 with DMA functions
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Message-ID: <048a4aa9-4ca8-5d03-7ff6-097e87306da1@maciej.szmigiero.name>
Date: Wed, 14 Feb 2018 00:06:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a5003fc04113 ("[ALSA] emu10k1 - simplify page allocation for synth")
switched from using the DMA allocator for synth DMA pages to manually
calling alloc_page().
However, this usage has an implicit assumption that the DMA address space
for the emu10k1-family chip is the same as the CPU physical address space
which is not true for a system with a IOMMU.

Since this made the synth part of the driver non-functional on such systems
let's effectively revert that commit (while keeping the
__synth_free_pages() simplification).

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
Changes from v1: None in this patch.

Changes from v2: Keep the __synth_free_pages() simplification.

 sound/pci/emu10k1/memory.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/sound/pci/emu10k1/memory.c b/sound/pci/emu10k1/memory.c
index fcb04cbbc9ab..1d0ce7356bbd 100644
--- a/sound/pci/emu10k1/memory.c
+++ b/sound/pci/emu10k1/memory.c
@@ -461,10 +461,19 @@ static void get_single_page_range(struct snd_util_memhdr *hdr,
 static void __synth_free_pages(struct snd_emu10k1 *emu, int first_page,
 			       int last_page)
 {
+	struct snd_dma_buffer dmab;
 	int page;
 
+	dmab.dev.type = SNDRV_DMA_TYPE_DEV;
+	dmab.dev.dev = snd_dma_pci_data(emu->pci);
+
 	for (page = first_page; page <= last_page; page++) {
-		free_page((unsigned long)emu->page_ptr_table[page]);
+		if (emu->page_ptr_table[page] == NULL)
+			continue;
+		dmab.area = emu->page_ptr_table[page];
+		dmab.addr = emu->page_addr_table[page];
+		dmab.bytes = PAGE_SIZE;
+		snd_dma_free_pages(&dmab);
 		emu->page_addr_table[page] = 0;
 		emu->page_ptr_table[page] = NULL;
 	}
@@ -476,30 +485,31 @@ static void __synth_free_pages(struct snd_emu10k1 *emu, int first_page,
 static int synth_alloc_pages(struct snd_emu10k1 *emu, struct snd_emu10k1_memblk *blk)
 {
 	int page, first_page, last_page;
+	struct snd_dma_buffer dmab;
 
 	emu10k1_memblk_init(blk);
 	get_single_page_range(emu->memhdr, blk, &first_page, &last_page);
 	/* allocate kernel pages */
 	for (page = first_page; page <= last_page; page++) {
-		/* first try to allocate from <4GB zone */
-		struct page *p = alloc_page(GFP_KERNEL | GFP_DMA32 |
-					    __GFP_NOWARN);
-		if (!p || (page_to_pfn(p) & ~(emu->dma_mask >> PAGE_SHIFT))) {
-			if (p)
-				__free_page(p);
-			/* try to allocate from <16MB zone */
-			p = alloc_page(GFP_ATOMIC | GFP_DMA |
-				       __GFP_NORETRY | /* no OOM-killer */
-				       __GFP_NOWARN);
-		}
-		if (!p) {
-			__synth_free_pages(emu, first_page, page - 1);
-			return -ENOMEM;
+		if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
+					snd_dma_pci_data(emu->pci),
+					PAGE_SIZE, &dmab) < 0)
+			goto __fail;
+		if (!is_valid_page(emu, dmab.addr)) {
+			snd_dma_free_pages(&dmab);
+			goto __fail;
 		}
-		emu->page_addr_table[page] = page_to_phys(p);
-		emu->page_ptr_table[page] = page_address(p);
+		emu->page_addr_table[page] = dmab.addr;
+		emu->page_ptr_table[page] = dmab.area;
 	}
 	return 0;
+
+__fail:
+	/* release allocated pages */
+	last_page = page - 1;
+	__synth_free_pages(emu, first_page, last_page);
+
+	return -ENOMEM;
 }
 
 /*

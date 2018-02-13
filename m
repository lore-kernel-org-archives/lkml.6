Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966124AbeBMXGV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:06:21 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:54116 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966002AbeBMXGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:06:20 -0500
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 3/5] ALSA: emu10k1: add optional debug printouts with DMA
 addresses
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Message-ID: <b5fdde1e-c8ec-f1cc-94fb-780efb1b540b@maciej.szmigiero.name>
Date: Wed, 14 Feb 2018 00:06:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we get a IOMMU page fault for a emu10k1 device it is very hard to
discover which of chip many DMA allocations triggered it (since on a IOMMU
system the DMA address space is often very different from the CPU one).
Let's add optional debug printouts providing this information.

These debug printouts are only enabled on an explicit request via the
kernel dynamic debug mechanism.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
Changes from v1: Fix a sparse warning by changing a variable type in
__{get,set}_ptb_entry from u32 to __le32, don't open code EMUPAGESIZE.

Changes from v2: None in this patch.

 sound/pci/emu10k1/emu10k1_main.c |  8 ++++++++
 sound/pci/emu10k1/memory.c       | 15 +++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 11e868f569d6..8decd2a7a404 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1898,6 +1898,9 @@ int snd_emu10k1_create(struct snd_card *card,
 		err = -ENOMEM;
 		goto error;
 	}
+	dev_dbg(card->dev, "page table address range is %.8lx:%.8lx\n",
+		(unsigned long)emu->ptb_pages.addr,
+		(unsigned long)(emu->ptb_pages.addr + emu->ptb_pages.bytes));
 
 	emu->page_ptr_table = vmalloc(emu->max_cache_pages * sizeof(void *));
 	emu->page_addr_table = vmalloc(emu->max_cache_pages *
@@ -1912,6 +1915,11 @@ int snd_emu10k1_create(struct snd_card *card,
 		err = -ENOMEM;
 		goto error;
 	}
+	dev_dbg(card->dev, "silent page range is %.8lx:%.8lx\n",
+		(unsigned long)emu->silent_page.addr,
+		(unsigned long)(emu->silent_page.addr +
+				emu->silent_page.bytes));
+
 	emu->memhdr = snd_util_memhdr_new(emu->max_cache_pages * PAGE_SIZE);
 	if (emu->memhdr == NULL) {
 		err = -ENOMEM;
diff --git a/sound/pci/emu10k1/memory.c b/sound/pci/emu10k1/memory.c
index eaa61024ac7f..fcb04cbbc9ab 100644
--- a/sound/pci/emu10k1/memory.c
+++ b/sound/pci/emu10k1/memory.c
@@ -34,7 +34,10 @@
  * aligned pages in others
  */
 #define __set_ptb_entry(emu,page,addr) \
-	(((u32 *)(emu)->ptb_pages.area)[page] = cpu_to_le32(((addr) << (emu->address_mode)) | (page)))
+	(((__le32 *)(emu)->ptb_pages.area)[page] = \
+	 cpu_to_le32(((addr) << (emu->address_mode)) | (page)))
+#define __get_ptb_entry(emu, page) \
+	(le32_to_cpu(((__le32 *)(emu)->ptb_pages.area)[page]))
 
 #define UNIT_PAGES		(PAGE_SIZE / EMUPAGESIZE)
 #define MAX_ALIGN_PAGES0		(MAXPAGES0 / UNIT_PAGES)
@@ -44,8 +47,7 @@
 /* get offset address from aligned page */
 #define aligned_page_offset(page)	((page) << PAGE_SHIFT)
 
-#if PAGE_SIZE == 4096
-/* page size == EMUPAGESIZE */
+#if PAGE_SIZE == EMUPAGESIZE && !IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
 /* fill PTB entrie(s) corresponding to page with addr */
 #define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)
 /* fill PTB entrie(s) corresponding to page with silence pointer */
@@ -58,6 +60,8 @@ static inline void set_ptb_entry(struct snd_emu10k1 *emu, int page, dma_addr_t a
 	page *= UNIT_PAGES;
 	for (i = 0; i < UNIT_PAGES; i++, page++) {
 		__set_ptb_entry(emu, page, addr);
+		dev_dbg(emu->card->dev, "mapped page %d to entry %.8x\n", page,
+			(unsigned int)__get_ptb_entry(emu, page));
 		addr += EMUPAGESIZE;
 	}
 }
@@ -65,9 +69,12 @@ static inline void set_silent_ptb(struct snd_emu10k1 *emu, int page)
 {
 	int i;
 	page *= UNIT_PAGES;
-	for (i = 0; i < UNIT_PAGES; i++, page++)
+	for (i = 0; i < UNIT_PAGES; i++, page++) {
 		/* do not increment ptr */
 		__set_ptb_entry(emu, page, emu->silent_page.addr);
+		dev_dbg(emu->card->dev, "mapped silent page %d to entry %.8x\n",
+			page, (unsigned int)__get_ptb_entry(emu, page));
+	}
 }
 #endif /* PAGE_SIZE */
 

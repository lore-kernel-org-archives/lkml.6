Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966086AbeBMXIC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:08:02 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:57082 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965783AbeBMXIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:08:01 -0500
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 5/5] ALSA: emu10k1: add a IOMMU workaround
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Message-ID: <3939a80b-caf0-7feb-6f68-8abedc5b1754@maciej.szmigiero.name>
Date: Wed, 14 Feb 2018 00:07:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Audigy 2 CA0102 chip (but most likely others from the emu10k1 family,
too) has a problem that from time to time it likes to do few DMA reads a
bit beyond its normal allocation and gets very confused if these reads get
blocked by a IOMMU.

For the first (reserved) page this happens multiple times at every
playback, for various synth pages it happens randomly, rarely for PCM
playback buffers and the page table memory itself.
All these reads seem to follow a similar pattern, observed read offsets
beyond the allocation end were 0x00, 0x40, 0x80 and 0xc0 (PCI cache line
multiples), so it looks like the device tries to accesses up to 256 extra
bytes.

As a workaround let's widen these DMA allocations by an extra page if we
detect that the device is behind a non-passthrough IOMMU (the DMA memory
should be relatively plenty on IOMMU systems).

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
Changes from v1: Apply this workaround also to PCM playback buffers since
it seems they are affected, too.

Changes from v2: Use a common snd_emu10k1_alloc_pages_maybe_wider() helper
function, check if rounding the allocation size up to the nearest page
size already covers the necessary extra memory space.

 include/sound/emu10k1.h          |  3 +++
 sound/pci/emu10k1/emu10k1_main.c | 49 ++++++++++++++++++++++++++++++++++++----
 sound/pci/emu10k1/emupcm.c       | 10 +++++++-
 sound/pci/emu10k1/memory.c       | 40 +++++++++++++++++++++++++++++---
 4 files changed, 93 insertions(+), 9 deletions(-)

diff --git a/include/sound/emu10k1.h b/include/sound/emu10k1.h
index db32b7de52e0..5ebcc51c0a6a 100644
--- a/include/sound/emu10k1.h
+++ b/include/sound/emu10k1.h
@@ -1710,6 +1710,7 @@ struct snd_emu10k1 {
 	unsigned int ecard_ctrl;		/* ecard control bits */
 	unsigned int address_mode;		/* address mode */
 	unsigned long dma_mask;			/* PCI DMA mask */
+	bool iommu_workaround;			/* IOMMU workaround needed */
 	unsigned int delay_pcm_irq;		/* in samples */
 	int max_cache_pages;			/* max memory size / PAGE_SIZE */
 	struct snd_dma_buffer silent_page;	/* silent page */
@@ -1877,6 +1878,8 @@ void snd_p16v_resume(struct snd_emu10k1 *emu);
 /* memory allocation */
 struct snd_util_memblk *snd_emu10k1_alloc_pages(struct snd_emu10k1 *emu, struct snd_pcm_substream *substream);
 int snd_emu10k1_free_pages(struct snd_emu10k1 *emu, struct snd_util_memblk *blk);
+int snd_emu10k1_alloc_pages_maybe_wider(struct snd_emu10k1 *emu, size_t size,
+					struct snd_dma_buffer *dmab);
 struct snd_util_memblk *snd_emu10k1_synth_alloc(struct snd_emu10k1 *emu, unsigned int size);
 int snd_emu10k1_synth_free(struct snd_emu10k1 *emu, struct snd_util_memblk *blk);
 int snd_emu10k1_synth_bzero(struct snd_emu10k1 *emu, struct snd_util_memblk *blk, int offset, int size);
diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 8decd2a7a404..18267de3a269 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -36,6 +36,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/iommu.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -1758,6 +1759,38 @@ static struct snd_emu_chip_details emu_chip_details[] = {
 	{ } /* terminator */
 };
 
+/*
+ * The chip (at least the Audigy 2 CA0102 chip, but most likely others, too)
+ * has a problem that from time to time it likes to do few DMA reads a bit
+ * beyond its normal allocation and gets very confused if these reads get
+ * blocked by a IOMMU.
+ *
+ * This behaviour has been observed for the first (reserved) page
+ * (for which it happens multiple times at every playback), often for various
+ * synth pages and sometimes for PCM playback buffers and the page table
+ * memory itself.
+ *
+ * As a workaround let's widen these DMA allocations by an extra page if we
+ * detect that the device is behind a non-passthrough IOMMU.
+ */
+static void snd_emu10k1_detect_iommu(struct snd_emu10k1 *emu)
+{
+	struct iommu_domain *domain;
+
+	emu->iommu_workaround = false;
+
+	if (!iommu_present(emu->card->dev->bus))
+		return;
+
+	domain = iommu_get_domain_for_dev(emu->card->dev);
+	if (domain && domain->type == IOMMU_DOMAIN_IDENTITY)
+		return;
+
+	dev_notice(emu->card->dev,
+		   "non-passthrough IOMMU detected, widening DMA allocations");
+	emu->iommu_workaround = true;
+}
+
 int snd_emu10k1_create(struct snd_card *card,
 		       struct pci_dev *pci,
 		       unsigned short extin_mask,
@@ -1770,6 +1803,7 @@ int snd_emu10k1_create(struct snd_card *card,
 	struct snd_emu10k1 *emu;
 	int idx, err;
 	int is_audigy;
+	size_t page_table_size;
 	unsigned int silent_page;
 	const struct snd_emu_chip_details *c;
 	static struct snd_device_ops ops = {
@@ -1867,6 +1901,8 @@ int snd_emu10k1_create(struct snd_card *card,
 
 	is_audigy = emu->audigy = c->emu10k2_chip;
 
+	snd_emu10k1_detect_iommu(emu);
+
 	/* set addressing mode */
 	emu->address_mode = is_audigy ? 0 : 1;
 	/* set the DMA transfer mask */
@@ -1893,8 +1929,11 @@ int snd_emu10k1_create(struct snd_card *card,
 	emu->port = pci_resource_start(pci, 0);
 
 	emu->max_cache_pages = max_cache_bytes >> PAGE_SHIFT;
-	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
-				(emu->address_mode ? 32 : 16) * 1024, &emu->ptb_pages) < 0) {
+
+	page_table_size = sizeof(u32) * (emu->address_mode ? MAXPAGES1 :
+					 MAXPAGES0);
+	if (snd_emu10k1_alloc_pages_maybe_wider(emu, page_table_size,
+						&emu->ptb_pages) < 0) {
 		err = -ENOMEM;
 		goto error;
 	}
@@ -1910,8 +1949,8 @@ int snd_emu10k1_create(struct snd_card *card,
 		goto error;
 	}
 
-	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
-				EMUPAGESIZE, &emu->silent_page) < 0) {
+	if (snd_emu10k1_alloc_pages_maybe_wider(emu, EMUPAGESIZE,
+						&emu->silent_page) < 0) {
 		err = -ENOMEM;
 		goto error;
 	}
@@ -1995,7 +2034,7 @@ int snd_emu10k1_create(struct snd_card *card,
 		0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT;
 
 	/* Clear silent pages and set up pointers */
-	memset(emu->silent_page.area, 0, PAGE_SIZE);
+	memset(emu->silent_page.area, 0, emu->silent_page.bytes);
 	silent_page = emu->silent_page.addr << emu->address_mode;
 	for (idx = 0; idx < (emu->address_mode ? MAXPAGES1 : MAXPAGES0); idx++)
 		((u32 *)emu->ptb_pages.area)[idx] = cpu_to_le32(silent_page | idx);
diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 2683b9717215..cefe613ef7b7 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -411,12 +411,20 @@ static int snd_emu10k1_playback_hw_params(struct snd_pcm_substream *substream,
 	struct snd_emu10k1 *emu = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_emu10k1_pcm *epcm = runtime->private_data;
+	size_t alloc_size;
 	int err;
 
 	if ((err = snd_emu10k1_pcm_channel_alloc(epcm, params_channels(hw_params))) < 0)
 		return err;
-	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
+
+	alloc_size = params_buffer_bytes(hw_params);
+	if (emu->iommu_workaround)
+		alloc_size += EMUPAGESIZE;
+	err = snd_pcm_lib_malloc_pages(substream, alloc_size);
+	if (err < 0)
 		return err;
+	if (emu->iommu_workaround && runtime->dma_bytes >= EMUPAGESIZE)
+		runtime->dma_bytes -= EMUPAGESIZE;
 	if (err > 0) {	/* change */
 		int mapped;
 		if (epcm->memblk != NULL)
diff --git a/sound/pci/emu10k1/memory.c b/sound/pci/emu10k1/memory.c
index 1d0ce7356bbd..5865f3b90b34 100644
--- a/sound/pci/emu10k1/memory.c
+++ b/sound/pci/emu10k1/memory.c
@@ -377,6 +377,33 @@ int snd_emu10k1_free_pages(struct snd_emu10k1 *emu, struct snd_util_memblk *blk)
 	return snd_emu10k1_synth_free(emu, blk);
 }
 
+/*
+ * allocate DMA pages, widening the allocation if necessary
+ *
+ * See the comment above snd_emu10k1_detect_iommu() in emu10k1_main.c why
+ * this might be needed.
+ *
+ * If you modify this function check whether __synth_free_pages() also needs
+ * changes.
+ */
+int snd_emu10k1_alloc_pages_maybe_wider(struct snd_emu10k1 *emu, size_t size,
+					struct snd_dma_buffer *dmab)
+{
+	if (emu->iommu_workaround) {
+		size_t npages = (size + PAGE_SIZE - 1) / PAGE_SIZE;
+		size_t size_real = npages * PAGE_SIZE;
+
+		/*
+		 * The device has been observed to accesses up to 256 extra
+		 * bytes, but use 1k to be safe.
+		 */
+		if (size_real < size + 1024)
+			size += PAGE_SIZE;
+	}
+
+	return snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
+				   snd_dma_pci_data(emu->pci), size, dmab);
+}
 
 /*
  * memory allocation using multiple pages (for synth)
@@ -472,7 +499,15 @@ static void __synth_free_pages(struct snd_emu10k1 *emu, int first_page,
 			continue;
 		dmab.area = emu->page_ptr_table[page];
 		dmab.addr = emu->page_addr_table[page];
+
+		/*
+		 * please keep me in sync with logic in
+		 * snd_emu10k1_alloc_pages_maybe_wider()
+		 */
 		dmab.bytes = PAGE_SIZE;
+		if (emu->iommu_workaround)
+			dmab.bytes *= 2;
+
 		snd_dma_free_pages(&dmab);
 		emu->page_addr_table[page] = 0;
 		emu->page_ptr_table[page] = NULL;
@@ -491,9 +526,8 @@ static int synth_alloc_pages(struct snd_emu10k1 *emu, struct snd_emu10k1_memblk
 	get_single_page_range(emu->memhdr, blk, &first_page, &last_page);
 	/* allocate kernel pages */
 	for (page = first_page; page <= last_page; page++) {
-		if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-					snd_dma_pci_data(emu->pci),
-					PAGE_SIZE, &dmab) < 0)
+		if (snd_emu10k1_alloc_pages_maybe_wider(emu, PAGE_SIZE,
+							&dmab) < 0)
 			goto __fail;
 		if (!is_valid_page(emu, dmab.addr)) {
 			snd_dma_free_pages(&dmab);

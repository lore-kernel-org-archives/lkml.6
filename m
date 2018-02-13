Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966080AbeBMXFC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:05:02 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:52858 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965942AbeBMXFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:05:01 -0500
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 1/5] ALSA: emu10k1: remove reserved_page
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Message-ID: <87e066a9-99ec-31a4-111a-1d848b7d98ec@maciej.szmigiero.name>
Date: Wed, 14 Feb 2018 00:04:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The emu10k1-family chips need the first page (index 0) reserved in their
page tables for some reason (every emu10k1 driver I've checked does this
without much of an explanation).
Using the first page for normal samples results in a broken playback.

However, we already have a dummy page allocated - so called "silent page"
and, in fact, had always been setting it as the first page in the chip page
table because an initialization of every entry of the page table to point
to a silent page happens after and overwrites the reserved_page allocation.

So the only thing remaining to remove the reserved_page allocation is a
trivial change to the page allocation logic to ignore the first page entry
and start its allocations from the second entry (index 1).

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
Changes from v1, v2: None in this patch.

 include/sound/emu10k1.h          |  1 -
 sound/pci/emu10k1/emu10k1_main.c | 11 -----------
 sound/pci/emu10k1/memory.c       |  8 ++++++--
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/include/sound/emu10k1.h b/include/sound/emu10k1.h
index 4f42affe777c..db32b7de52e0 100644
--- a/include/sound/emu10k1.h
+++ b/include/sound/emu10k1.h
@@ -1718,7 +1718,6 @@ struct snd_emu10k1 {
 	struct snd_dma_buffer p16v_buffer;
 
 	struct snd_util_memhdr *memhdr;		/* page allocation list */
-	struct snd_emu10k1_memblk *reserved_page;	/* reserved page */
 
 	struct list_head mapped_link_head;
 	struct list_head mapped_order_link_head;
diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index ccf4415a1c7b..a0a4d31ded53 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1272,12 +1272,6 @@ static int snd_emu10k1_free(struct snd_emu10k1 *emu)
 	release_firmware(emu->dock_fw);
 	if (emu->irq >= 0)
 		free_irq(emu->irq, emu);
-	/* remove reserved page */
-	if (emu->reserved_page) {
-		snd_emu10k1_synth_free(emu,
-			(struct snd_util_memblk *)emu->reserved_page);
-		emu->reserved_page = NULL;
-	}
 	snd_util_memhdr_free(emu->memhdr);
 	if (emu->silent_page.area)
 		snd_dma_free_pages(&emu->silent_page);
@@ -1993,11 +1987,6 @@ int snd_emu10k1_create(struct snd_card *card,
 		SPCS_GENERATIONSTATUS | 0x00001200 |
 		0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT;
 
-	emu->reserved_page = (struct snd_emu10k1_memblk *)
-		snd_emu10k1_synth_alloc(emu, 4096);
-	if (emu->reserved_page)
-		emu->reserved_page->map_locked = 1;
-
 	/* Clear silent pages and set up pointers */
 	memset(emu->silent_page.area, 0, PAGE_SIZE);
 	silent_page = emu->silent_page.addr << emu->address_mode;
diff --git a/sound/pci/emu10k1/memory.c b/sound/pci/emu10k1/memory.c
index 4f1f69be1865..eaa61024ac7f 100644
--- a/sound/pci/emu10k1/memory.c
+++ b/sound/pci/emu10k1/memory.c
@@ -102,7 +102,7 @@ static void emu10k1_memblk_init(struct snd_emu10k1_memblk *blk)
  */
 static int search_empty_map_area(struct snd_emu10k1 *emu, int npages, struct list_head **nextp)
 {
-	int page = 0, found_page = -ENOMEM;
+	int page = 1, found_page = -ENOMEM;
 	int max_size = npages;
 	int size;
 	struct list_head *candidate = &emu->mapped_link_head;
@@ -147,6 +147,10 @@ static int map_memblk(struct snd_emu10k1 *emu, struct snd_emu10k1_memblk *blk)
 	page = search_empty_map_area(emu, blk->pages, &next);
 	if (page < 0) /* not found */
 		return page;
+	if (page == 0) {
+		dev_err(emu->card->dev, "trying to map zero (reserved) page\n");
+		return -EINVAL;
+	}
 	/* insert this block in the proper position of mapped list */
 	list_add_tail(&blk->mapped_link, next);
 	/* append this as a newest block in order list */
@@ -177,7 +181,7 @@ static int unmap_memblk(struct snd_emu10k1 *emu, struct snd_emu10k1_memblk *blk)
 		q = get_emu10k1_memblk(p, mapped_link);
 		start_page = q->mapped_page + q->pages;
 	} else
-		start_page = 0;
+		start_page = 1;
 	if ((p = blk->mapped_link.next) != &emu->mapped_link_head) {
 		q = get_emu10k1_memblk(p, mapped_link);
 		end_page = q->mapped_page;

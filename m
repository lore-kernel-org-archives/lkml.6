Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966095AbeBMXFT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:05:19 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:53252 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965942AbeBMXFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:05:18 -0500
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v3 2/5] ALSA: emu10k1: use dma_set_mask_and_coherent()
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Message-ID: <d1483681-e04f-ef2e-57fe-2ad9cfee2feb@maciej.szmigiero.name>
Date: Wed, 14 Feb 2018 00:05:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have been calling dma_set_mask() and then dma_set_coherent_mask() with
the same value, but there is a dma_set_mask_and_coherent() function that
does exactly that so let's use it instead.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
Changes from v1, v2: None in this patch.

 sound/pci/emu10k1/emu10k1_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index a0a4d31ded53..11e868f569d6 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1871,8 +1871,7 @@ int snd_emu10k1_create(struct snd_card *card,
 	emu->address_mode = is_audigy ? 0 : 1;
 	/* set the DMA transfer mask */
 	emu->dma_mask = emu->address_mode ? EMU10K1_DMA_MASK : AUDIGY_DMA_MASK;
-	if (dma_set_mask(&pci->dev, emu->dma_mask) < 0 ||
-	    dma_set_coherent_mask(&pci->dev, emu->dma_mask) < 0) {
+	if (dma_set_mask_and_coherent(&pci->dev, emu->dma_mask) < 0) {
 		dev_err(card->dev,
 			"architecture does not support PCI busmaster DMA with mask 0x%lx\n",
 			emu->dma_mask);

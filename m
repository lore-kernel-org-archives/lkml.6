Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95B4ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C46C20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba8oCr6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C46C20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbeKAIRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731860AbeKAILt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10CCB20866;
        Wed, 31 Oct 2018 23:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027496;
        bh=ypep3qN46xEJIGU2hAhp7JYEyzu+WgyE/RGbma3AZcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ba8oCr6Qp0DzXcKv9ttrZfyYkDaDKC8FV7ehXD+H/M7JaiHP7Aq2bLG2GtM5F0+sp
         iPG2d9W+9OhnMu3ERPoaYsUOSDuTSExALL0yRFan/wzopivtfqPcsmvvtAzsZBqj3u
         CPeA2HqnjbAOakN6L7xizMfdDpgCkFoxleYbUxrc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 48/48] ALSA: hda: Check the non-cached stream buffers more explicitly
Date:   Wed, 31 Oct 2018 19:10:54 -0400
Message-Id: <20181031231054.29333-48-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 78c9be61c3a5cd9e2439fd27a5ffad73a81958c7 ]

Introduce a new flag, uc_buffer, to indicate that the controller
requires the non-cached pages for stream buffers, either as a
chip-specific requirement or specified via snoop=0 option.
This improves the code-readability.

Also, this patch fixes the incorrect behavior for C-Media chip where
the stream buffers were never handled as non-cached due to the check
of driver_type even if you pass snoop=0 option.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_controller.h |  1 +
 sound/pci/hda/hda_intel.c      | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index a50e0532622a..b83feecf1e40 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -155,6 +155,7 @@ struct azx {
 	unsigned int msi:1;
 	unsigned int probing:1; /* codec probing phase */
 	unsigned int snoop:1;
+	unsigned int uc_buffer:1; /* non-cached pages for stream buffers */
 	unsigned int align_buffer_size:1;
 	unsigned int region_requested:1;
 	unsigned int disabled:1; /* disabled by vga_switcheroo */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index f913809a7de3..3557e3943ad5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -410,7 +410,7 @@ static void __mark_pages_wc(struct azx *chip, struct snd_dma_buffer *dmab, bool
 #ifdef CONFIG_SND_DMA_SGBUF
 	if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_SG) {
 		struct snd_sg_buf *sgbuf = dmab->private_data;
-		if (chip->driver_type == AZX_DRIVER_CMEDIA)
+		if (!chip->uc_buffer)
 			return; /* deal with only CORB/RIRB buffers */
 		if (on)
 			set_pages_array_wc(sgbuf->page_table, sgbuf->pages);
@@ -1503,6 +1503,7 @@ static void azx_check_snoop_available(struct azx *chip)
 		dev_info(chip->card->dev, "Force to %s mode by module option\n",
 			 snoop ? "snoop" : "non-snoop");
 		chip->snoop = snoop;
+		chip->uc_buffer = !snoop;
 		return;
 	}
 
@@ -1523,8 +1524,12 @@ static void azx_check_snoop_available(struct azx *chip)
 		snoop = false;
 
 	chip->snoop = snoop;
-	if (!snoop)
+	if (!snoop) {
 		dev_info(chip->card->dev, "Force to non-snoop mode\n");
+		/* C-Media requires non-cached pages only for CORB/RIRB */
+		if (chip->driver_type != AZX_DRIVER_CMEDIA)
+			chip->uc_buffer = true;
+	}
 }
 
 static void azx_probe_work(struct work_struct *work)
@@ -1947,7 +1952,7 @@ static void pcm_mmap_prepare(struct snd_pcm_substream *substream,
 #ifdef CONFIG_X86
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
 	struct azx *chip = apcm->chip;
-	if (!azx_snoop(chip) && chip->driver_type != AZX_DRIVER_CMEDIA)
+	if (chip->uc_buffer)
 		area->vm_page_prot = pgprot_writecombine(area->vm_page_prot);
 #endif
 }
-- 
2.17.1


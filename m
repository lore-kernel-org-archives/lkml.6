Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D612C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637ED206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEXvxC9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637ED206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391147AbeKLIrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:47:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:54376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387600AbeKLIWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:47 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37BF321582;
        Sun, 11 Nov 2018 22:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975569;
        bh=nXHc6oucnsDML8PkHS1KVGsyC4/rwYYVkXIwnmQ3HuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEXvxC9C4PhMbevzEWMTfrZT+sxt4eWvhrjnHBCBTSQH5y/2wI4pzktZN1YCc1d1a
         MzLRLtrr5CSzgBz/RNL7yU0v9900i8uBCNu0NbCoJ2chcCFNIPglXtBtaVB5gFcsU5
         gaBwc59bKJLTdtEzuYzQwE0+FGWU4Mc8Dcrgyw5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 108/222] ALSA: hda: Check the non-cached stream buffers more explicitly
Date:   Sun, 11 Nov 2018 14:23:25 -0800
Message-Id: <20181111221657.485405615@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/hda_controller.h |    1 +
 sound/pci/hda/hda_intel.c      |   11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -160,6 +160,7 @@ struct azx {
 	unsigned int msi:1;
 	unsigned int probing:1; /* codec probing phase */
 	unsigned int snoop:1;
+	unsigned int uc_buffer:1; /* non-cached pages for stream buffers */
 	unsigned int align_buffer_size:1;
 	unsigned int region_requested:1;
 	unsigned int disabled:1; /* disabled by vga_switcheroo */
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -410,7 +410,7 @@ static void __mark_pages_wc(struct azx *
 #ifdef CONFIG_SND_DMA_SGBUF
 	if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_SG) {
 		struct snd_sg_buf *sgbuf = dmab->private_data;
-		if (chip->driver_type == AZX_DRIVER_CMEDIA)
+		if (!chip->uc_buffer)
 			return; /* deal with only CORB/RIRB buffers */
 		if (on)
 			set_pages_array_wc(sgbuf->page_table, sgbuf->pages);
@@ -1634,6 +1634,7 @@ static void azx_check_snoop_available(st
 		dev_info(chip->card->dev, "Force to %s mode by module option\n",
 			 snoop ? "snoop" : "non-snoop");
 		chip->snoop = snoop;
+		chip->uc_buffer = !snoop;
 		return;
 	}
 
@@ -1654,8 +1655,12 @@ static void azx_check_snoop_available(st
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
@@ -2094,7 +2099,7 @@ static void pcm_mmap_prepare(struct snd_
 #ifdef CONFIG_X86
 	struct azx_pcm *apcm = snd_pcm_substream_chip(substream);
 	struct azx *chip = apcm->chip;
-	if (!azx_snoop(chip) && chip->driver_type != AZX_DRIVER_CMEDIA)
+	if (chip->uc_buffer)
 		area->vm_page_prot = pgprot_writecombine(area->vm_page_prot);
 #endif
 }



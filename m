Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5E5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469F12150D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469F12150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbeI0Pmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:42:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbeI0Pmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:42:51 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A72011113;
        Thu, 27 Sep 2018 09:25:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 05/44] ALSA: bebob: use address returned by kmalloc() instead of kernel stack for streaming DMA mapping
Date:   Thu, 27 Sep 2018 11:03:54 +0200
Message-Id: <20180927090118.686442215@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090117.997362691@linuxfoundation.org>
References: <20180927090117.997362691@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 493626f2d87a74e6dbea1686499ed6e7e600484e upstream.

When executing 'fw_run_transaction()' with 'TCODE_WRITE_BLOCK_REQUEST',
an address of 'payload' argument is used for streaming DMA mapping by
'firewire_ohci' module if 'size' argument is larger than 8 byte.
Although in this case the address should not be on kernel stack, current
implementation of ALSA bebob driver uses data in kernel stack for a cue
to boot M-Audio devices. This often brings unexpected result, especially
for a case of CONFIG_VMAP_STACK=y.

This commit fixes the bug.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=201021
Reference: https://forum.manjaro.org/t/firewire-m-audio-410-driver-wont-load-firmware/51165
Fixes: a2b2a7798fb6('ALSA: bebob: Send a cue to load firmware for M-Audio Firewire series')
Cc: <stable@vger.kernel.org> # v3.16+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/bebob/bebob_maudio.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -96,17 +96,13 @@ int snd_bebob_maudio_load_firmware(struc
 	struct fw_device *device = fw_parent_device(unit);
 	int err, rcode;
 	u64 date;
-	__le32 cues[3] = {
-		cpu_to_le32(MAUDIO_BOOTLOADER_CUE1),
-		cpu_to_le32(MAUDIO_BOOTLOADER_CUE2),
-		cpu_to_le32(MAUDIO_BOOTLOADER_CUE3)
-	};
+	__le32 *cues;
 
 	/* check date of software used to build */
 	err = snd_bebob_read_block(unit, INFO_OFFSET_SW_DATE,
 				   &date, sizeof(u64));
 	if (err < 0)
-		goto end;
+		return err;
 	/*
 	 * firmware version 5058 or later has date later than "20070401", but
 	 * 'date' is not null-terminated.
@@ -114,20 +110,28 @@ int snd_bebob_maudio_load_firmware(struc
 	if (date < 0x3230303730343031LL) {
 		dev_err(&unit->device,
 			"Use firmware version 5058 or later\n");
-		err = -ENOSYS;
-		goto end;
+		return -ENXIO;
 	}
 
+	cues = kmalloc_array(3, sizeof(*cues), GFP_KERNEL);
+	if (!cues)
+		return -ENOMEM;
+
+	cues[0] = cpu_to_le32(MAUDIO_BOOTLOADER_CUE1);
+	cues[1] = cpu_to_le32(MAUDIO_BOOTLOADER_CUE2);
+	cues[2] = cpu_to_le32(MAUDIO_BOOTLOADER_CUE3);
+
 	rcode = fw_run_transaction(device->card, TCODE_WRITE_BLOCK_REQUEST,
 				   device->node_id, device->generation,
 				   device->max_speed, BEBOB_ADDR_REG_REQ,
-				   cues, sizeof(cues));
+				   cues, 3 * sizeof(*cues));
+	kfree(cues);
 	if (rcode != RCODE_COMPLETE) {
 		dev_err(&unit->device,
 			"Failed to send a cue to load firmware\n");
 		err = -EIO;
 	}
-end:
+
 	return err;
 }
 



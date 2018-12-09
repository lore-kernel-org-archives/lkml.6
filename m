Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDB7C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085B520661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085B520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbeLIWHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:07:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37212 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727887AbeLIWH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:07:26 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73L-0002if-II; Sun, 09 Dec 2018 21:55:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003HU-GG; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.183358817@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 067/328] ALSA: vx: Fix possible transfer overflow
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 874e1f6fad9a5184b67f4cee37c1335cd2cc5677 upstream.

The pseudo DMA transfer codes in VX222 and VX-pocket driver have a
slight bug where they check the buffer boundary wrongly, and may
overflow.  Also, the zero sample count might be handled badly for the
playback (although it shouldn't happen in theory).  This patch
addresses these issues.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=141541
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/drivers/vx/vx_pcm.c   |  6 ++++--
 sound/pci/vx222/vx222_ops.c | 12 ++++++------
 sound/pcmcia/vx/vxp_ops.c   | 12 ++++++------
 3 files changed, 16 insertions(+), 14 deletions(-)

--- a/sound/drivers/vx/vx_pcm.c
+++ b/sound/drivers/vx/vx_pcm.c
@@ -1071,8 +1071,10 @@ static void vx_pcm_capture_update(struct
 		/* ok, let's accelerate! */
 		int align = pipe->align * 3;
 		space = (count / align) * align;
-		vx_pseudo_dma_read(chip, runtime, pipe, space);
-		count -= space;
+		if (space > 0) {
+			vx_pseudo_dma_read(chip, runtime, pipe, space);
+			count -= space;
+		}
 	}
 	/* read the rest of bytes */
 	while (count > 0) {
--- a/sound/pci/vx222/vx222_ops.c
+++ b/sound/pci/vx222/vx222_ops.c
@@ -264,12 +264,12 @@ static void vx2_dma_write(struct vx_core
 
 	/* Transfer using pseudo-dma.
 	 */
-	if (offset + count > pipe->buffer_bytes) {
+	if (offset + count >= pipe->buffer_bytes) {
 		int length = pipe->buffer_bytes - offset;
 		count -= length;
 		length >>= 2; /* in 32bit words */
 		/* Transfer using pseudo-dma. */
-		while (length-- > 0) {
+		for (; length > 0; length--) {
 			outl(cpu_to_le32(*addr), port);
 			addr++;
 		}
@@ -279,7 +279,7 @@ static void vx2_dma_write(struct vx_core
 	pipe->hw_ptr += count;
 	count >>= 2; /* in 32bit words */
 	/* Transfer using pseudo-dma. */
-	while (count-- > 0) {
+	for (; count > 0; count--) {
 		outl(cpu_to_le32(*addr), port);
 		addr++;
 	}
@@ -302,12 +302,12 @@ static void vx2_dma_read(struct vx_core
 	vx2_setup_pseudo_dma(chip, 0);
 	/* Transfer using pseudo-dma.
 	 */
-	if (offset + count > pipe->buffer_bytes) {
+	if (offset + count >= pipe->buffer_bytes) {
 		int length = pipe->buffer_bytes - offset;
 		count -= length;
 		length >>= 2; /* in 32bit words */
 		/* Transfer using pseudo-dma. */
-		while (length-- > 0)
+		for (; length > 0; length--)
 			*addr++ = le32_to_cpu(inl(port));
 		addr = (u32 *)runtime->dma_area;
 		pipe->hw_ptr = 0;
@@ -315,7 +315,7 @@ static void vx2_dma_read(struct vx_core
 	pipe->hw_ptr += count;
 	count >>= 2; /* in 32bit words */
 	/* Transfer using pseudo-dma. */
-	while (count-- > 0)
+	for (; count > 0; count--)
 		*addr++ = le32_to_cpu(inl(port));
 
 	vx2_release_pseudo_dma(chip);
--- a/sound/pcmcia/vx/vxp_ops.c
+++ b/sound/pcmcia/vx/vxp_ops.c
@@ -369,12 +369,12 @@ static void vxp_dma_write(struct vx_core
 	unsigned short *addr = (unsigned short *)(runtime->dma_area + offset);
 
 	vx_setup_pseudo_dma(chip, 1);
-	if (offset + count > pipe->buffer_bytes) {
+	if (offset + count >= pipe->buffer_bytes) {
 		int length = pipe->buffer_bytes - offset;
 		count -= length;
 		length >>= 1; /* in 16bit words */
 		/* Transfer using pseudo-dma. */
-		while (length-- > 0) {
+		for (; length > 0; length--) {
 			outw(cpu_to_le16(*addr), port);
 			addr++;
 		}
@@ -384,7 +384,7 @@ static void vxp_dma_write(struct vx_core
 	pipe->hw_ptr += count;
 	count >>= 1; /* in 16bit words */
 	/* Transfer using pseudo-dma. */
-	while (count-- > 0) {
+	for (; count > 0; count--) {
 		outw(cpu_to_le16(*addr), port);
 		addr++;
 	}
@@ -411,12 +411,12 @@ static void vxp_dma_read(struct vx_core
 	if (snd_BUG_ON(count % 2))
 		return;
 	vx_setup_pseudo_dma(chip, 0);
-	if (offset + count > pipe->buffer_bytes) {
+	if (offset + count >= pipe->buffer_bytes) {
 		int length = pipe->buffer_bytes - offset;
 		count -= length;
 		length >>= 1; /* in 16bit words */
 		/* Transfer using pseudo-dma. */
-		while (length-- > 0)
+		for (; length > 0; length--)
 			*addr++ = le16_to_cpu(inw(port));
 		addr = (unsigned short *)runtime->dma_area;
 		pipe->hw_ptr = 0;
@@ -424,7 +424,7 @@ static void vxp_dma_read(struct vx_core
 	pipe->hw_ptr += count;
 	count >>= 1; /* in 16bit words */
 	/* Transfer using pseudo-dma. */
-	while (count-- > 1)
+	for (; count > 1; count--)
 		*addr++ = le16_to_cpu(inw(port));
 	/* Disable DMA */
 	pchip->regDIALOG &= ~VXP_DLG_DMAREAD_SEL_MASK;


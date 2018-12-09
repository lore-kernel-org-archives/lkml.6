Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB78AC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B862C2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B862C2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbeLIWHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:07:49 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37248 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727923AbeLIWHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:07:45 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73L-0002ii-HJ; Sun, 09 Dec 2018 21:55:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003Hf-Ik; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.954392961@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 069/328] ALSA: vxpocket: Fix invalid endian conversions
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

commit 3acd3e3bab95ec3622ff98da313290ee823a0f68 upstream.

The endian conversions used in vxp_dma_read() and vxp_dma_write() are
superfluous and even wrong on big-endian machines, as inw() and outw()
already do conversions.  Kill them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pcmcia/vx/vxp_ops.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/sound/pcmcia/vx/vxp_ops.c
+++ b/sound/pcmcia/vx/vxp_ops.c
@@ -375,7 +375,7 @@ static void vxp_dma_write(struct vx_core
 		length >>= 1; /* in 16bit words */
 		/* Transfer using pseudo-dma. */
 		for (; length > 0; length--) {
-			outw(cpu_to_le16(*addr), port);
+			outw(*addr, port);
 			addr++;
 		}
 		addr = (unsigned short *)runtime->dma_area;
@@ -385,7 +385,7 @@ static void vxp_dma_write(struct vx_core
 	count >>= 1; /* in 16bit words */
 	/* Transfer using pseudo-dma. */
 	for (; count > 0; count--) {
-		outw(cpu_to_le16(*addr), port);
+		outw(*addr, port);
 		addr++;
 	}
 	vx_release_pseudo_dma(chip);
@@ -417,7 +417,7 @@ static void vxp_dma_read(struct vx_core
 		length >>= 1; /* in 16bit words */
 		/* Transfer using pseudo-dma. */
 		for (; length > 0; length--)
-			*addr++ = le16_to_cpu(inw(port));
+			*addr++ = inw(port);
 		addr = (unsigned short *)runtime->dma_area;
 		pipe->hw_ptr = 0;
 	}
@@ -425,12 +425,12 @@ static void vxp_dma_read(struct vx_core
 	count >>= 1; /* in 16bit words */
 	/* Transfer using pseudo-dma. */
 	for (; count > 1; count--)
-		*addr++ = le16_to_cpu(inw(port));
+		*addr++ = inw(port);
 	/* Disable DMA */
 	pchip->regDIALOG &= ~VXP_DLG_DMAREAD_SEL_MASK;
 	vx_outb(chip, DIALOG, pchip->regDIALOG);
 	/* Read the last word (16 bits) */
-	*addr = le16_to_cpu(inw(port));
+	*addr = inw(port);
 	/* Disable 16-bit accesses */
 	pchip->regDIALOG &= ~VXP_DLG_DMA16_SEL_MASK;
 	vx_outb(chip, DIALOG, pchip->regDIALOG);


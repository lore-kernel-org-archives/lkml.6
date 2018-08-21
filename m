Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2996C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A727A20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A727A20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbeHUJxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:53:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56972 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeHUJxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:53:01 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B4BF27F6;
        Tue, 21 Aug 2018 06:34:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 14/22] ALSA: vxpocket: Fix invalid endian conversions
Date:   Tue, 21 Aug 2018 08:21:40 +0200
Message-Id: <20180821055140.175040304@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055139.462620042@linuxfoundation.org>
References: <20180821055139.462620042@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 3acd3e3bab95ec3622ff98da313290ee823a0f68 upstream.

The endian conversions used in vxp_dma_read() and vxp_dma_write() are
superfluous and even wrong on big-endian machines, as inw() and outw()
already do conversions.  Kill them.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pcmcia/vx/vxp_ops.c |   10 +++++-----
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



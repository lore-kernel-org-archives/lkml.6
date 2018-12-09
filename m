Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E585FC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B520B2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B520B2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeLIWO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:14:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38062 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727655AbeLIWOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:14:24 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73L-0002ij-IK; Sun, 09 Dec 2018 21:55:55 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003HZ-HW; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.935360606@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 068/328] ALSA: vx222: Fix invalid endian conversions
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

commit fff71a4c050ba46e305d910c837b99ba1728135e upstream.

The endian conversions used in vx2_dma_read() and vx2_dma_write() are
superfluous and even wrong on big-endian machines, as inl() and outl()
already do conversions.  Kill them.

Spotted by sparse, a warning like:
  sound/pci/vx222/vx222_ops.c:278:30: warning: incorrect type in argument 1 (different base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/vx222/vx222_ops.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/sound/pci/vx222/vx222_ops.c
+++ b/sound/pci/vx222/vx222_ops.c
@@ -270,7 +270,7 @@ static void vx2_dma_write(struct vx_core
 		length >>= 2; /* in 32bit words */
 		/* Transfer using pseudo-dma. */
 		for (; length > 0; length--) {
-			outl(cpu_to_le32(*addr), port);
+			outl(*addr, port);
 			addr++;
 		}
 		addr = (u32 *)runtime->dma_area;
@@ -280,7 +280,7 @@ static void vx2_dma_write(struct vx_core
 	count >>= 2; /* in 32bit words */
 	/* Transfer using pseudo-dma. */
 	for (; count > 0; count--) {
-		outl(cpu_to_le32(*addr), port);
+		outl(*addr, port);
 		addr++;
 	}
 
@@ -308,7 +308,7 @@ static void vx2_dma_read(struct vx_core
 		length >>= 2; /* in 32bit words */
 		/* Transfer using pseudo-dma. */
 		for (; length > 0; length--)
-			*addr++ = le32_to_cpu(inl(port));
+			*addr++ = inl(port);
 		addr = (u32 *)runtime->dma_area;
 		pipe->hw_ptr = 0;
 	}
@@ -316,7 +316,7 @@ static void vx2_dma_read(struct vx_core
 	count >>= 2; /* in 32bit words */
 	/* Transfer using pseudo-dma. */
 	for (; count > 0; count--)
-		*addr++ = le32_to_cpu(inl(port));
+		*addr++ = inl(port);
 
 	vx2_release_pseudo_dma(chip);
 }


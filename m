Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F971C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4815D205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4815D205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeHUJnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:43:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeHUJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:43:21 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C4463516;
        Tue, 21 Aug 2018 06:24:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.17 19/42] ALSA: vx222: Fix invalid endian conversions
Date:   Tue, 21 Aug 2018 08:20:51 +0200
Message-Id: <20180821055018.557729659@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055017.596264829@linuxfoundation.org>
References: <20180821055017.596264829@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit fff71a4c050ba46e305d910c837b99ba1728135e upstream.

The endian conversions used in vx2_dma_read() and vx2_dma_write() are
superfluous and even wrong on big-endian machines, as inl() and outl()
already do conversions.  Kill them.

Spotted by sparse, a warning like:
  sound/pci/vx222/vx222_ops.c:278:30: warning: incorrect type in argument 1 (different base types)

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/vx222/vx222_ops.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/sound/pci/vx222/vx222_ops.c
+++ b/sound/pci/vx222/vx222_ops.c
@@ -275,7 +275,7 @@ static void vx2_dma_write(struct vx_core
 		length >>= 2; /* in 32bit words */
 		/* Transfer using pseudo-dma. */
 		for (; length > 0; length--) {
-			outl(cpu_to_le32(*addr), port);
+			outl(*addr, port);
 			addr++;
 		}
 		addr = (u32 *)runtime->dma_area;
@@ -285,7 +285,7 @@ static void vx2_dma_write(struct vx_core
 	count >>= 2; /* in 32bit words */
 	/* Transfer using pseudo-dma. */
 	for (; count > 0; count--) {
-		outl(cpu_to_le32(*addr), port);
+		outl(*addr, port);
 		addr++;
 	}
 
@@ -313,7 +313,7 @@ static void vx2_dma_read(struct vx_core
 		length >>= 2; /* in 32bit words */
 		/* Transfer using pseudo-dma. */
 		for (; length > 0; length--)
-			*addr++ = le32_to_cpu(inl(port));
+			*addr++ = inl(port);
 		addr = (u32 *)runtime->dma_area;
 		pipe->hw_ptr = 0;
 	}
@@ -321,7 +321,7 @@ static void vx2_dma_read(struct vx_core
 	count >>= 2; /* in 32bit words */
 	/* Transfer using pseudo-dma. */
 	for (; count > 0; count--)
-		*addr++ = le32_to_cpu(inl(port));
+		*addr++ = inl(port);
 
 	vx2_release_pseudo_dma(chip);
 }



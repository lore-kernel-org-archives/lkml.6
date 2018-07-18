Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813EDECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3579820850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="bMy1duDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3579820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbeGRTAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:00:08 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43356 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730810AbeGRTAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:00:08 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v2 13/17] dmaengine: dma-jz4780: Further residue status fix
Date:   Wed, 18 Jul 2018 20:20:19 +0200
Message-Id: <20180718182023.8182-14-paul@crapouillou.net>
In-Reply-To: <20180718182023.8182-1-paul@crapouillou.net>
References: <20180718182023.8182-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1531938060; bh=wLtygciA8kesCct7e/GjoIaL5q5d2hxkrc9IVMEKpJU=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bMy1duDPsmfp1EUXgdduwxtBlliTDpQqHKeT9aQ+Im40am95G8XWegjaBP+DPZ4ByoeKG2AGvoLW8yNmwL0AmQwKBd+lU+JcSX869majNDMUq8+5JBZKOlqKFVzi2X/sRL0ozFRkf56ICQDrZ9uLXVWea6ulLOyXa3v0bcCmKxc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Silsby <dansilsby@gmail.com>

Func jz4780_dma_desc_residue() expects the index to the next hw
descriptor as its last parameter. Caller func jz4780_dma_tx_status(),
however, applied modulus before passing it. When the current hw
descriptor was last in the list, the index passed became zero.

The resulting excess of reported residue especially caused problems
with cyclic DMA transfer clients, i.e. ALSA AIC audio output, which
rely on this for determining current DMA location within buffer.

Combined with the recent and related residue-reporting fixes, spurious
ALSA audio underruns on jz4770 hardware are now fixed.

Signed-off-by: Daniel Silsby <dansilsby@gmail.com>
Tested-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/dma/dma-jz4780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

 v2: No change

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 78849131c81d..b9db539a5b34 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -651,7 +651,7 @@ static enum dma_status jz4780_dma_tx_status(struct dma_chan *chan,
 					to_jz4780_dma_desc(vdesc), 0);
 	} else if (cookie == jzchan->desc->vdesc.tx.cookie) {
 		txstate->residue = jz4780_dma_desc_residue(jzchan, jzchan->desc,
-			  (jzchan->curr_hwdesc + 1) % jzchan->desc->count);
+					jzchan->curr_hwdesc + 1);
 	} else
 		txstate->residue = 0;
 
-- 
2.11.0


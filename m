Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA97C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706D120836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706D120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbeI0P3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:29:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55386 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeI0P3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:29:54 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 795E41117;
        Thu, 27 Sep 2018 09:12:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.18 41/88] mtd: rawnand: denali: fix a race condition when DMA is kicked
Date:   Thu, 27 Sep 2018 11:03:22 +0200
Message-Id: <20180927090305.746943986@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit cf51e4b9c34407bf0c3d9b582b7837e047e1df47 upstream.

I thought the read-back of the DMA_ENABLE register was unnecessary
(at least it is working on my boards), then deleted it in commit
586a2c52909d ("mtd: nand: denali: squash denali_enable_dma() helper
into caller").  Sorry, I was wrong - it caused a timing issue on
Cyclone5 SoCFPGAs.

Revive the register read-back, commenting why this is necessary.

Fixes: 586a2c52909d ("mtd: nand: denali: squash denali_enable_dma() helper into caller")
Cc: <stable@vger.kernel.org>
Reported-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/denali.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -604,6 +604,12 @@ static int denali_dma_xfer(struct denali
 	}
 
 	iowrite32(DMA_ENABLE__FLAG, denali->reg + DMA_ENABLE);
+	/*
+	 * The ->setup_dma() hook kicks DMA by using the data/command
+	 * interface, which belongs to a different AXI port from the
+	 * register interface.  Read back the register to avoid a race.
+	 */
+	ioread32(denali->reg + DMA_ENABLE);
 
 	denali_reset_irq(denali);
 	denali->setup_dma(denali, dma_addr, page, write);



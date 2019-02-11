Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC3BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C16B218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r58+n2Hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfBKNZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:25:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfBKNZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rhBgQnlDm1lE4eR+205CPt5ssFNDO9AGMDhit+VjOeI=; b=r58+n2Hsm4U+viYWrEeJh6yMO4
        1Lwv2buDAcUTwSef3o5j6r2mzvcsCKwaspTQgmZ6P5bzUd17DwNny5/e7Zu9pSF5s/2VbBVcoQpAG
        FAdzDC5AUJLi23waOClkwPX2MhjqvSIo36x08N3FIF1/HV5ILirRMGUB0F8u7IrLz1uRGvRmUSKLd
        dvHeEvuBEghqnWInn02MkgOPGUpmVmk8UViW8Qn4C8rIV1tX6z8BsD/aDRFUobu390ad+8G473bQt
        wOaAkISqIIttAkB2k+MKlmE5rhDW7z3GipIgZAkQG8LLbK2ZlAmqM9+/OaC3JoJMEatidSKkWo7xL
        IS0ZcAVg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBae-0003gk-Br; Mon, 11 Feb 2019 13:25:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty/synclink: remove ISA support
Date:   Mon, 11 Feb 2019 14:25:34 +0100
Message-Id: <20190211132534.29407-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211132534.29407-1-hch@lst.de>
References: <20190211132534.29407-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISA support in this driver is horribly outdated and the last
driver that passes a NULL dev argument to the DMA mapping routines.

Drop the support, if someone wants to go through the work of converting
it to a proper isa_driver we can resurrect it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/tty/synclink.c | 54 ------------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/drivers/tty/synclink.c b/drivers/tty/synclink.c
index d55c858d6058..84f26e43b229 100644
--- a/drivers/tty/synclink.c
+++ b/drivers/tty/synclink.c
@@ -4325,41 +4325,6 @@ static int mgsl_init_tty(void)
 	return 0;
 }
 
-/* enumerate user specified ISA adapters
- */
-static void mgsl_enum_isa_devices(void)
-{
-	struct mgsl_struct *info;
-	int i;
-		
-	/* Check for user specified ISA devices */
-	
-	for (i=0 ;(i < MAX_ISA_DEVICES) && io[i] && irq[i]; i++){
-		if ( debug_level >= DEBUG_LEVEL_INFO )
-			printk("ISA device specified io=%04X,irq=%d,dma=%d\n",
-				io[i], irq[i], dma[i] );
-		
-		info = mgsl_allocate_device();
-		if ( !info ) {
-			/* error allocating device instance data */
-			if ( debug_level >= DEBUG_LEVEL_ERROR )
-				printk( "can't allocate device instance data.\n");
-			continue;
-		}
-		
-		/* Copy user configuration info to device instance data */
-		info->io_base = (unsigned int)io[i];
-		info->irq_level = (unsigned int)irq[i];
-		info->irq_level = irq_canonicalize(info->irq_level);
-		info->dma_level = (unsigned int)dma[i];
-		info->bus_type = MGSL_BUS_TYPE_ISA;
-		info->io_addr_size = 16;
-		info->irq_flags = 0;
-		
-		mgsl_add_device( info );
-	}
-}
-
 static void synclink_cleanup(void)
 {
 	int rc;
@@ -4403,7 +4368,6 @@ static int __init synclink_init(void)
 
  	printk("%s %s\n", driver_name, driver_version);
 
-	mgsl_enum_isa_devices();
 	if ((rc = pci_register_driver(&synclink_pci_driver)) < 0)
 		printk("%s:failed to register PCI driver, error=%d\n",__FILE__,rc);
 	else
@@ -5025,12 +4989,6 @@ static void usc_set_sdlc_mode( struct mgsl_struct *info )
 	info->mbre_bit = BIT8;
 	outw( BIT8, info->io_base );			/* set Master Bus Enable (DCAR) */
 
-	if (info->bus_type == MGSL_BUS_TYPE_ISA) {
-		/* Enable DMAEN (Port 7, Bit 14) */
-		/* This connects the DMA request signal to the ISA bus */
-		usc_OutReg(info, PCR, (u16)((usc_InReg(info, PCR) | BIT15) & ~BIT14));
-	}
-
 	/* DMA Control Register (DCR)
 	 *
 	 * <15..14>	10	Priority mode = Alternating Tx/Rx
@@ -6007,12 +5965,6 @@ static void usc_set_async_mode( struct mgsl_struct *info )
 
 	usc_EnableMasterIrqBit( info );
 
-	if (info->bus_type == MGSL_BUS_TYPE_ISA) {
-		/* Enable INTEN (Port 6, Bit12) */
-		/* This connects the IRQ request signal to the ISA bus */
-		usc_OutReg(info, PCR, (u16)((usc_InReg(info, PCR) | BIT13) & ~BIT12));
-	}
-
 	if (info->params.loopback) {
 		info->loopback_bits = 0x300;
 		outw(0x0300, info->io_base + CCAR);
@@ -6107,12 +6059,6 @@ static void usc_set_sync_mode( struct mgsl_struct *info )
 	usc_loopback_frame( info );
 	usc_set_sdlc_mode( info );
 
-	if (info->bus_type == MGSL_BUS_TYPE_ISA) {
-		/* Enable INTEN (Port 6, Bit12) */
-		/* This connects the IRQ request signal to the ISA bus */
-		usc_OutReg(info, PCR, (u16)((usc_InReg(info, PCR) | BIT13) & ~BIT12));
-	}
-
 	usc_enable_aux_clock(info, info->params.clock_speed);
 
 	if (info->params.loopback)
-- 
2.20.1


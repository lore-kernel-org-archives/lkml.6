Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4215C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A010D20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfAOEXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:23:32 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37572 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbfAOEW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 23:22:29 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 7F60529E7C; Mon, 14 Jan 2019 23:22:24 -0500 (EST)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <7c2b0db81b7778a4f90b007a968d1af09b1a63bf.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 14/22] macintosh/via-cuda: Don't rely on Cuda to end a
 transfer
Date:   Tue, 15 Jan 2019 15:18:56 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain Cuda transfers have to be ended by the driver. According
to Apple's open source Cuda driver, as found in mkLinux and XNU, this
applies to any "open ended request such as PRAM read". This fixes an
infinite polling loop in cuda_pram_read_byte().

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-cuda.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index bbec6ac0a966..3581abfb0c6a 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -569,6 +569,7 @@ cuda_interrupt(int irq, void *arg)
     unsigned char ibuf[16];
     int ibuf_len = 0;
     int complete = 0;
+    bool full;
     
     spin_lock_irqsave(&cuda_lock, flags);
 
@@ -656,12 +657,13 @@ cuda_interrupt(int irq, void *arg)
 	break;
 
     case reading:
-	if (reading_reply ? ARRAY_FULL(current_req->reply, reply_ptr)
-	                  : ARRAY_FULL(cuda_rbuf, reply_ptr))
+	full = reading_reply ? ARRAY_FULL(current_req->reply, reply_ptr)
+	                     : ARRAY_FULL(cuda_rbuf, reply_ptr);
+	if (full)
 	    (void)in_8(&via[SR]);
 	else
 	    *reply_ptr++ = in_8(&via[SR]);
-	if (!TREQ_asserted(status)) {
+	if (!TREQ_asserted(status) || full) {
 	    if (mcu_is_egret)
 		assert_TACK();
 	    /* that's all folks */
-- 
2.19.2


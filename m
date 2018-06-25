Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879F7C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2B525844
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2B525844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932351AbeFYLpS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:45:18 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51886 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755221AbeFYLpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:45:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 91EF728D1C;
        Mon, 25 Jun 2018 07:45:14 -0400 (EDT)
Date:   Mon, 25 Jun 2018 21:46:11 +1000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <142066981b41910f4e645590a8b1734a1ea72fb8.1529926655.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] nubus: Set default dma mask for nubus_board devices
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 32-bit mask is used by default because a NuBus slot has 32
address/data lines and a NuBus board is free to use all of them.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/nubus/bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
index a59b6c4bb5b8..ad3d17c42e23 100644
--- a/drivers/nubus/bus.c
+++ b/drivers/nubus/bus.c
@@ -5,6 +5,7 @@
 // Copyright (C) 2017 Finn Thain
 
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/list.h>
 #include <linux/nubus.h>
 #include <linux/seq_file.h>
@@ -93,6 +94,8 @@ int nubus_device_register(struct nubus_board *board)
 	board->dev.release = nubus_device_release;
 	board->dev.bus = &nubus_bus_type;
 	dev_set_name(&board->dev, "slot.%X", board->slot);
+	board->dev.dma_mask = &board->dev.coherent_dma_mask;
+	dma_set_mask(&board->dev, DMA_BIT_MASK(32));
 	return device_register(&board->dev);
 }
 
-- 
2.16.4


Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F0AC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1062208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 05:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1062208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeJPN2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 09:28:07 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57234 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbeJPN2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 09:28:05 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 1687D27FFF; Tue, 16 Oct 2018 01:39:22 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <946e04372882bea6f6987852a49f006dfa1084ac.1539667885.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1539667885.git.fthain@telegraphics.com.au>
References: <cover.1539667885.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v3 6/6] esp_scsi: Optimize PIO loops
Date:   Tue, 16 Oct 2018 16:31:25 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid function calls in the inner PIO loops. On a Centris 660av this
improves throughput for sequential read transfers by about 40% and
sequential write by about 10%.

Unfortunately it is not possible to have methods like .esp_write8
placed inline so this is always going to be slow, even with LTO.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Michael Schmitz <schmitzmic@gmail.com>
---
Changed since v1:
 - Don't touch the scsi_esp_cmd(esp, ESP_CMD_FLUSH) as it's outside the loop.
---
 drivers/scsi/esp_scsi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index 0f0d486be486..c3077c064522 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -2783,7 +2783,7 @@ static inline unsigned int esp_wait_for_fifo(struct esp *esp)
 		if (fbytes)
 			return fbytes;
 
-		udelay(2);
+		udelay(1);
 	} while (--i);
 
 	shost_printk(KERN_ERR, esp->host, "FIFO is empty. sreg [%02x]\n",
@@ -2800,7 +2800,7 @@ static inline int esp_wait_for_intr(struct esp *esp)
 		if (esp->sreg & ESP_STAT_INTR)
 			return 0;
 
-		udelay(2);
+		udelay(1);
 	} while (--i);
 
 	shost_printk(KERN_ERR, esp->host, "IRQ timeout. sreg [%02x]\n",
@@ -2828,7 +2828,7 @@ void esp_send_pio_cmd(struct esp *esp, u32 addr, u32 esp_count,
 			if (!esp_wait_for_fifo(esp))
 				break;
 
-			*dst++ = esp_read8(ESP_FDATA);
+			*dst++ = readb(esp->fifo_reg);
 			--esp_count;
 
 			if (!esp_count)
@@ -2849,9 +2849,9 @@ void esp_send_pio_cmd(struct esp *esp, u32 addr, u32 esp_count,
 			}
 
 			if (phase == ESP_MIP)
-				scsi_esp_cmd(esp, ESP_CMD_MOK);
+				esp_write8(ESP_CMD_MOK, ESP_CMD);
 
-			scsi_esp_cmd(esp, ESP_CMD_TI);
+			esp_write8(ESP_CMD_TI, ESP_CMD);
 		}
 	} else {
 		unsigned int n = ESP_FIFO_SIZE;
@@ -2891,7 +2891,7 @@ void esp_send_pio_cmd(struct esp *esp, u32 addr, u32 esp_count,
 			src += n;
 			esp_count -= n;
 
-			scsi_esp_cmd(esp, ESP_CMD_TI);
+			esp_write8(ESP_CMD_TI, ESP_CMD);
 		}
 	}
 
-- 
2.18.1


Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869A7C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462E22077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 06:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462E22077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeJNOON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 10:14:13 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:42576 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeJNOON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 10:14:13 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 1779E2A1CB; Sun, 14 Oct 2018 02:34:18 -0400 (EDT)
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <11a3a80e74a006040460fa051747e6a79c6382ce.1539497520.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1539497520.git.fthain@telegraphics.com.au>
References: <cover.1539497520.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 2/6] esp_scsi: Track residual for PIO transfers
Date:   Sun, 14 Oct 2018 17:12:00 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a target disconnects during a PIO data transfer the command may
fail when the target reconnects:

scsi host1: DMA length is zero!
scsi host1: cur adr[04380000] len[00000000]

The scsi bus is then reset. This happens because the residual reached
zero before the transfer was completed.

The usual residual calculation relies on the Transfer Count registers
which works for DMA transfers but not for PIO transfers. Fix the problem
by storing the PIO transfer residual and using that to correctly
calculate bytes_sent.

Fixes: 6fe07aaffbf0
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Michael Schmitz <schmitzmic@gmail.com>
---
 drivers/scsi/esp_scsi.c | 1 +
 drivers/scsi/esp_scsi.h | 2 ++
 drivers/scsi/mac_esp.c  | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index c3fc34b9964d..9e5d3f7d29ae 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -1338,6 +1338,7 @@ static int esp_data_bytes_sent(struct esp *esp, struct esp_cmd_entry *ent,
 
 	bytes_sent = esp->data_dma_len;
 	bytes_sent -= ecount;
+	bytes_sent -= esp->send_cmd_residual;
 
 	/*
 	 * The am53c974 has a DMA 'pecularity'. The doc states:
diff --git a/drivers/scsi/esp_scsi.h b/drivers/scsi/esp_scsi.h
index 8163dca2071b..db4b6ea94caa 100644
--- a/drivers/scsi/esp_scsi.h
+++ b/drivers/scsi/esp_scsi.h
@@ -540,6 +540,8 @@ struct esp {
 
 	void			*dma;
 	int			dmarev;
+
+	int			send_cmd_residual;
 };
 
 /* A front-end driver for the ESP chip should do the following in
diff --git a/drivers/scsi/mac_esp.c b/drivers/scsi/mac_esp.c
index eb551f3cc471..71879f2207e0 100644
--- a/drivers/scsi/mac_esp.c
+++ b/drivers/scsi/mac_esp.c
@@ -427,6 +427,8 @@ static void mac_esp_send_pio_cmd(struct esp *esp, u32 addr, u32 esp_count,
 			scsi_esp_cmd(esp, ESP_CMD_TI);
 		}
 	}
+
+	esp->send_cmd_residual = esp_count;
 }
 
 static int mac_esp_irq_pending(struct esp *esp)
-- 
2.18.1


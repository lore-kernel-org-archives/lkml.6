Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56EFC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF93C2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfBCOVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55674 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730351AbfBCOVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:06 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIds-0006OG-Bb; Sun, 03 Feb 2019 14:21:04 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Y-0006xq-73; Sun, 03 Feb 2019 14:49:44 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Stan Johnson" <userm57@yahoo.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Finn Thain" <fthain@telegraphics.com.au>,
        "Michael Schmitz" <schmitzmic@gmail.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.181507776@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 099/305] scsi: esp_scsi: Track residual for PIO transfers
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>

commit fd47d919d0c336e7c22862b51ee94927ffea227a upstream.

If a target disconnects during a PIO data transfer the command may fail
when the target reconnects:

scsi host1: DMA length is zero!
scsi host1: cur adr[04380000] len[00000000]

The scsi bus is then reset. This happens because the residual reached
zero before the transfer was completed.

The usual residual calculation relies on the Transfer Count registers.
That works for DMA transfers but not for PIO transfers. Fix the problem
by storing the PIO transfer residual and using that to correctly
calculate bytes_sent.

Fixes: 6fe07aaffbf0 ("[SCSI] m68k: new mac_esp scsi driver")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/esp_scsi.c | 1 +
 drivers/scsi/esp_scsi.h | 2 ++
 drivers/scsi/mac_esp.c  | 2 ++
 3 files changed, 5 insertions(+)

--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -1316,6 +1316,7 @@ static int esp_data_bytes_sent(struct es
 
 	bytes_sent = esp->data_dma_len;
 	bytes_sent -= ecount;
+	bytes_sent -= esp->send_cmd_residual;
 
 	if (!(ent->flags & ESP_CMD_FLAG_WRITE))
 		bytes_sent -= fifo_cnt;
--- a/drivers/scsi/esp_scsi.h
+++ b/drivers/scsi/esp_scsi.h
@@ -524,6 +524,8 @@ struct esp {
 
 	void			*dma;
 	int			dmarev;
+
+	u32			send_cmd_residual;
 };
 
 /* A front-end driver for the ESP chip should do the following in
--- a/drivers/scsi/mac_esp.c
+++ b/drivers/scsi/mac_esp.c
@@ -426,6 +426,8 @@ static void mac_esp_send_pio_cmd(struct
 			scsi_esp_cmd(esp, ESP_CMD_TI);
 		}
 	}
+
+	esp->send_cmd_residual = esp_count;
 }
 
 static int mac_esp_irq_pending(struct esp *esp)


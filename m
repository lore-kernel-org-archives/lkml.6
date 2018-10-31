Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FDCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CC020843
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChcPGIuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3CC020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbeKAILh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731646AbeKAILd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C01522086D;
        Wed, 31 Oct 2018 23:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027480;
        bh=vhSu8B/avVRpE3msSMHtbA+HJ3J/a8PWhgCm93F+va8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ChcPGIuUZ9kg0D+6UxHkfGwCSHcM3nWAJRN+uO9BZbB+ZdSumOslI9TkKFduj7DVH
         7a9Lqs0LE2rfhPWXZU9youmvEHN/5YP+WapmXtInUECjcz/XR+ut4OYQvZawu8Aaqj
         2z/mpNUXMBLEwxyxq6qQirnakS1AiDG78YygiejM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 29/48] scsi: esp_scsi: Track residual for PIO transfers
Date:   Wed, 31 Oct 2018 19:10:35 -0400
Message-Id: <20181031231054.29333-29-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit fd47d919d0c336e7c22862b51ee94927ffea227a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/esp_scsi.c | 1 +
 drivers/scsi/esp_scsi.h | 2 ++
 drivers/scsi/mac_esp.c  | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index 71cb05b1c3eb..60be0742e2c8 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -1349,6 +1349,7 @@ static int esp_data_bytes_sent(struct esp *esp, struct esp_cmd_entry *ent,
 
 	bytes_sent = esp->data_dma_len;
 	bytes_sent -= ecount;
+	bytes_sent -= esp->send_cmd_residual;
 
 	/*
 	 * The am53c974 has a DMA 'pecularity'. The doc states:
diff --git a/drivers/scsi/esp_scsi.h b/drivers/scsi/esp_scsi.h
index 84dcbe4a6268..55be43fe7667 100644
--- a/drivers/scsi/esp_scsi.h
+++ b/drivers/scsi/esp_scsi.h
@@ -540,6 +540,8 @@ struct esp {
 
 	void			*dma;
 	int			dmarev;
+
+	u32			send_cmd_residual;
 };
 
 /* A front-end driver for the ESP chip should do the following in
diff --git a/drivers/scsi/mac_esp.c b/drivers/scsi/mac_esp.c
index 26c67c42985c..1002124bd8bf 100644
--- a/drivers/scsi/mac_esp.c
+++ b/drivers/scsi/mac_esp.c
@@ -426,6 +426,8 @@ static void mac_esp_send_pio_cmd(struct esp *esp, u32 addr, u32 esp_count,
 			scsi_esp_cmd(esp, ESP_CMD_TI);
 		}
 	}
+
+	esp->send_cmd_residual = esp_count;
 }
 
 static int mac_esp_irq_pending(struct esp *esp)
-- 
2.17.1


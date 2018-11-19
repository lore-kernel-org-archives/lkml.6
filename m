Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6503EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A26208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zFxE7bMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A26208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406349AbeKTD2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:28:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405689AbeKTD2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:28:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FFB02154B;
        Mon, 19 Nov 2018 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647027;
        bh=ceoj3GCtotAeO5Q2sPMKW3wac75oNqTarJlsYHbV6M0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zFxE7bMJVIGi8mCytkTnvrug9yPubtzB57x6DePe6LIAU2N/aJ8RtC0j3XodjO7BA
         ME8uiVgqN3aIt3CKw/fCuyyzT6fTyhTYWMx95HKlU1z/TZXqBWI4uxHO7QI9LeCxXp
         W2efl1MJGrFSXa0rdstd5Jv/8tMpL2wW+kR9nnWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 22/90] scsi: esp_scsi: Track residual for PIO transfers
Date:   Mon, 19 Nov 2018 17:29:04 +0100
Message-Id: <20181119162624.550078832@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/esp_scsi.c |    1 +
 drivers/scsi/esp_scsi.h |    2 ++
 drivers/scsi/mac_esp.c  |    2 ++
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



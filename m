Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F30C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8338B2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NEb/U4w4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfBGUrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:47:42 -0500
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:34110 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726691AbfBGUrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:47:42 -0500
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id BF5F830C162;
        Thu,  7 Feb 2019 12:47:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com BF5F830C162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1549572460;
        bh=l1LgYC/dzFHpWQxyL3nce/dgcerG3QvKq/LXHJdYimo=;
        h=From:To:Cc:Subject:Date:From;
        b=NEb/U4w4X4KNcVap7pwz+neQb8hFllsCoZm1QfLxHpklPtAmvPFMFdcNKBVR5xE58
         zWOyH+xjFRniG1XqpQoHRq1N98pYOk/OD7P2g5Bo0EGGY2uhYbRmB7ETsI9rSQGRE3
         BKpR6pKEzRN9nve5U8EEn39h+ySS1cUDe/X1dTrM=
Received: from stbirv-lnx-2.igp.broadcom.net (stbirv-lnx-2.igp.broadcom.net [10.67.48.34])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id B5413AC0788;
        Thu,  7 Feb 2019 12:47:40 -0800 (PST)
Received: by stbirv-lnx-2.igp.broadcom.net (Postfix, from userid 47169)
        id A6DA227ECE7; Thu,  7 Feb 2019 12:47:40 -0800 (PST)
From:   justinpopo6@gmail.com
To:     linux-spi@vger.kernel.org
Cc:     kdasu.kdev@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH] spi: bcm-qspi: when tx/rx buffer is NULL set to 0
Date:   Thu,  7 Feb 2019 12:47:27 -0800
Message-Id: <1549572447-45456-1-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

Currently we set the tx/rx buffer to 0xff when NULL. This causes
problems with some spi slaves where 0xff is a valid command. Looking
at other drivers, the tx/rx buffer is usually set to 0x00 when NULL.
Following this convention solves the issue.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 584bcb0..79456aa 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -681,7 +681,7 @@ static void read_from_hw(struct bcm_qspi *qspi, int slots)
 			if (buf)
 				buf[tp.byte] = read_rxram_slot_u8(qspi, slot);
 			dev_dbg(&qspi->pdev->dev, "RD %02x\n",
-				buf ? buf[tp.byte] : 0xff);
+				buf ? buf[tp.byte] : 0x00);
 		} else {
 			u16 *buf = tp.trans->rx_buf;
 
@@ -689,7 +689,7 @@ static void read_from_hw(struct bcm_qspi *qspi, int slots)
 				buf[tp.byte / 2] = read_rxram_slot_u16(qspi,
 								      slot);
 			dev_dbg(&qspi->pdev->dev, "RD %04x\n",
-				buf ? buf[tp.byte] : 0xffff);
+				buf ? buf[tp.byte] : 0x0000);
 		}
 
 		update_qspi_trans_byte_count(qspi, &tp,
@@ -744,13 +744,13 @@ static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spi)
 	while (!tstatus && slot < MSPI_NUM_CDRAM) {
 		if (tp.trans->bits_per_word <= 8) {
 			const u8 *buf = tp.trans->tx_buf;
-			u8 val = buf ? buf[tp.byte] : 0xff;
+			u8 val = buf ? buf[tp.byte] : 0x00;
 
 			write_txram_slot_u8(qspi, slot, val);
 			dev_dbg(&qspi->pdev->dev, "WR %02x\n", val);
 		} else {
 			const u16 *buf = tp.trans->tx_buf;
-			u16 val = buf ? buf[tp.byte / 2] : 0xffff;
+			u16 val = buf ? buf[tp.byte / 2] : 0x0000;
 
 			write_txram_slot_u16(qspi, slot, val);
 			dev_dbg(&qspi->pdev->dev, "WR %04x\n", val);
-- 
2.7.4


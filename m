Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA97AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FAD25A9C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CBJqeETx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZcmrFl+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FAD25A9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934147AbeFYNku (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:40:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43566 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755611AbeFYNkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:40:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4CF51608C8; Mon, 25 Jun 2018 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529934045;
        bh=g9YYiqqV7/ic363DvZSDSZyRk7ZGrh1UBgB6TXrt7g4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBJqeETxXIjnSOliRvorAiWpt/0GRgVN2Gywxfy+MvyNzDzmizCePlC8QCrr7f9Un
         0pGkGffQR34waTmTwMz/Vvn0fOutJlX9uzCshrTaWDSvfHYq2LWYRXO5eugqAjA7vf
         +EWAzOmbi7NlATux1vVx7IrSmQQJNT/3nXp88N3Q=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E73E760B18;
        Mon, 25 Jun 2018 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529934044;
        bh=g9YYiqqV7/ic363DvZSDSZyRk7ZGrh1UBgB6TXrt7g4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcmrFl+RrnT0UOwIKG6fBo3Hb95VsZ3mobGB4a85Al+eK0C+7iciciGOR4AP/UO3B
         Yr1oY7wx3bgCIkGJtHUVMW5z+UenD33MBVB4CY77gKI5Yr8jA30ofXljUNc92Jkb7m
         CDH3CGee91QyZltTl4YXBZUijnjT7kT5ufThQCUc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E73E760B18
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v8 6/7] Bluetooth: btqca: Add wcn3990 firmware download support.
Date:   Mon, 25 Jun 2018 19:10:12 +0530
Message-Id: <20180625134013.19684-7-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625134013.19684-1-bgodavar@codeaurora.org>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the RAM and NV patch download for wcn3990.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/btqca.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 3b25be1be19c..25ef67739de0 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -332,6 +332,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 {
 	struct rome_config config;
 	int err;
+	u8 rom_ver;
 
 	bt_dev_dbg(hdev, "QCA setup on UART");
 
@@ -346,11 +347,21 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		}
 		bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
 	}
-
 	/* Download rampatch file */
 	config.type = TLV_TYPE_PATCH;
-	snprintf(config.fwname, sizeof(config.fwname), "qca/rampatch_%08x.bin",
-		 soc_ver);
+	if (soc_type == QCA_WCN3990) {
+		/* Firmware files to download are based on ROM version.
+		 * ROM version is derived from last two bytes of soc_ver.
+		 */
+		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) |
+			    (soc_ver & 0x0000000f);
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/crbtfw%02x.tlv", rom_ver);
+	} else {
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/rampatch_%08x.bin", soc_ver);
+	}
+
 	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
@@ -359,8 +370,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
-	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x.bin",
-		 soc_ver);
+	if (soc_type == QCA_WCN3990)
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/crnv%02x.bin", rom_ver);
+	else
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/nvm_%08x.bin", soc_ver);
+
 	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


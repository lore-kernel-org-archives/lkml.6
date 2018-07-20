Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00509ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8CB20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kqKa50Vf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ug3x49B9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8CB20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbeGTOVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:21:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731356AbeGTOVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:21:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9544960131; Fri, 20 Jul 2018 13:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532093602;
        bh=abLE3lk2qCpC+BceGbjFdbBaMsnFRUeOl2TRBKiVI1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqKa50VfApyj0tPFvnN6sVYDM24tL6TFAdo4423Sv3yTby2tTsUdsIgnsHxq7T94n
         U+vDcGQtmsRo3Id6CLytUt8gupsi4i3PNZcJ+3FHlqEXwGEaYNFko6lHLj8qX9OCpH
         NEUWXbbz7fmKZLYx6e8zwg4hf2qi02V086gD2OeE=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2EE660B7D;
        Fri, 20 Jul 2018 13:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532093601;
        bh=abLE3lk2qCpC+BceGbjFdbBaMsnFRUeOl2TRBKiVI1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ug3x49B9TpsbHEwLf0zt+Si0QwRb+L7h5IwDNS0bd/Fz21zACLLriwMHkFDtlBKdY
         9hf3nV4PhMssHPdjbFCqfZRZfsHJMMa+EKps1M9rBzDtRRjD6AIP5stvYBgksf/xux
         GebL8Mmneedl9nLYDMyUa6wDwn31jhKa7ChH7Ijk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2EE660B7D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v10 6/7] Bluetooth: btqca: Add wcn3990 firmware download support.
Date:   Fri, 20 Jul 2018 19:02:42 +0530
Message-Id: <20180720133243.6851-7-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180720133243.6851-1-bgodavar@codeaurora.org>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the RAM and NV patch download for wcn3990.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/btqca.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index b556710ee1bd..5f9dd27a26a0 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -335,6 +335,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 {
 	struct rome_config config;
 	int err;
+	u8 rom_ver;
 
 	bt_dev_dbg(hdev, "QCA setup on UART");
 
@@ -342,8 +343,19 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 
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
@@ -352,8 +364,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 
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


Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BDAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6606921850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jMdaxPDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfBZUJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:09:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44811 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfBZUJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:09:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id c4so6734469pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 12:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5NuV4vceEo2RYDSujgIGTAC99HwvViKoTNjpZnGSkfc=;
        b=jMdaxPDwuqP+EAdv/v9lQGaNhR3nZXnHjVYoMMcsqdifri1KRX1BIIn6XHNCogSreD
         /OzfM8ehm8SdjJ9ETYhNEIYAloLuUMFNLI7L9D+mCMCR+h9Ftl0JPfTx3ZMhXH+UHmMn
         vsXif+QsEELXgr5C6tyWT/p2QEsAIK2Y0Ns9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5NuV4vceEo2RYDSujgIGTAC99HwvViKoTNjpZnGSkfc=;
        b=jbzPiB0tXic4TxN+pp4K2Y0TsBI2bqsfoADayK7pJM/y73aCfdQQdY281OBxxLPeWZ
         cHXMbdbDbD0RsTFf0BWzQdCsuVqRCZbHyg40//J6/xHvlqlbN7nXSMGTdpJSI8tqbClN
         UUif8iKI4iqnBol+54lYyL5S8/Egqd6ko+zo/xateig21h8sujkEHdGzYzxJkj1XbT+D
         aLy+FdIUxkQiXPH/0jiDFYvNvL/yumtrPaVGldkmSEKCVvenIPQ/GpYqWHW0Ju6Qenqk
         FZdIgcX759v10T1OnkkqcEAUAwCwNl1S04hXmSm3dLTLNp2MD1CHQRTQplD8Utc/L6UG
         iv9A==
X-Gm-Message-State: AHQUAuZ7Gmlki9+K4QIc5JQwUD7bMjSDTo1A+6tH79FSR4dz6aeg4bot
        xkVLfiDjb86zYLErHWPDnkFOMQ==
X-Google-Smtp-Source: AHgI3IZfhyAQ/Ej5xkVDhQ3x8Hv1GTCmnuHyB6qS5wEEJgQaM8Svsuzy5IPBxddJLt6nVr1S2hD5Fw==
X-Received: by 2002:a17:902:9008:: with SMTP id a8mr28089526plp.38.1551211744786;
        Tue, 26 Feb 2019 12:09:04 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l5sm7637328pfi.97.2019.02.26.12.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 12:09:04 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] hci_qca: Reduce delay after sending baudrate request for WCN3990
Date:   Tue, 26 Feb 2019 12:08:48 -0800
Message-Id: <20190226200848.154216-3-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
In-Reply-To: <20190226200848.154216-1-mka@chromium.org>
References: <20190226200848.154216-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current 300ms delay after a baudrate change is extremely long.
For WCM3990 it is sufficient to wait 10ms after the baudrate change
request has been sent over the wire.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 703e099515f24..fd018cc5605c6 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -59,8 +59,7 @@
 
 #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
 #define IBS_TX_IDLE_TIMEOUT_MS		2000
-#define BAUDRATE_SETTLE_TIMEOUT_MS	300
-#define POWER_PULSE_TRANS_TIMEOUT_MS	100
+#define CMD_TRANS_TIMEOUT_MS		100
 
 /* susclk rate */
 #define SUSCLK_RATE_32KHZ	32768
@@ -964,6 +963,7 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
+	struct qca_serdev *qcadev;
 	struct sk_buff *skb;
 	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
 
@@ -985,11 +985,25 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	skb_queue_tail(&qca->txq, skb);
 	hci_uart_tx_wakeup(hu);
 
-	/* wait 300ms to change new baudrate on controller side
-	 * controller will come back after they receive this HCI command
-	 * then host can communicate with new baudrate to controller
+	qcadev = serdev_device_get_drvdata(hu->serdev);
+
+	/* Wait for the baudrate change command to be sent and
+	 * processed by the controller.
 	 */
-	msleep(BAUDRATE_SETTLE_TIMEOUT_MS);
+	if (qcadev->btsoc_type == QCA_WCN3990) {
+		while (!skb_queue_empty(&qca->txq))
+			usleep_range(100, 200);
+
+		serdev_device_wait_until_sent(hu->serdev,
+			      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
+
+		/* Make sure there is enough time for the BT
+		 * controller to process the baudrate change
+		*/
+		msleep(10);
+	} else {
+		msleep(300);
+	}
 
 	return 0;
 }
@@ -1005,7 +1019,7 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
 {
 	int ret;
-	int timeout = msecs_to_jiffies(POWER_PULSE_TRANS_TIMEOUT_MS);
+	int timeout = msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS);
 
 	/* These power pulses are single byte command which are sent
 	 * at required baudrate to wcn3990. On wcn3990, we have an external
-- 
2.21.0.rc2.261.ga7da99ff1b-goog


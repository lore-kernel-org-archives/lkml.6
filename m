Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7321C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840E620856
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ea7hOzy4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fE/65OUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeL0HcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 02:32:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49994 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeL0HcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 02:32:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 88BCF60909; Thu, 27 Dec 2018 07:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545895923;
        bh=sxbJZsIl6dSwUQXUl+ptgK5p2se5Ox/n8dWLHLdYxkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ea7hOzy4oRTosQISc+WXiHvhqbVFbaRie7KmxvcP/beD/KSNNZGO7GG+KiTTB6j/s
         vJaWxyFgET1YjcbFK2YWNbMslZCcB7EmgzhEV+6jMFZ/BT4R92Yg+wuuBRlJGFBGcb
         2IZ/jGVGNvlGaUCxrZQvSY1h2Jq/rlPzjjn9h9i8=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 56EE0607F1;
        Thu, 27 Dec 2018 07:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545895916;
        bh=sxbJZsIl6dSwUQXUl+ptgK5p2se5Ox/n8dWLHLdYxkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fE/65OUgjT4+JZ9nMVMDkxHOEllYgxjLE1dxWK65eRlM0zS8OSoNvodqlD8jObZ36
         r9HtMWMx+YaWv8kQfbOviyO+BejIBJQ5PEN9WELv2OQjd3JzTZC3rgY19KHPrMfe42
         A66Xp6ua1PrcbfEVDPWVVLTzfal+iiTxqDhK7T5c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56EE0607F1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v6 3/6] Bluetooth: hci_qca: Fix frame reassembly errors for wcn3990
Date:   Thu, 27 Dec 2018 13:01:33 +0530
Message-Id: <20181227073136.8431-4-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181227073136.8431-1-bgodavar@codeaurora.org>
References: <20181227073136.8431-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During initalization of wcn3990, we observed UART is reading some
stray bytes on the Rx line. This is logging Frame reassembly errors
on the serial console. This could be because of tristate of Tx line
of wcn3990 during boot up.

[  176.929612] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
[  176.945734] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
[  176.953298] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
[  177.010660] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
[  177.067633] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)

Now we enable a flag during bootup to stop executing proto receive
function and clear it back once the initialization is done.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 63436023632d..0751b2359f6f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -56,6 +56,7 @@
 
 /* Controller states */
 #define STATE_IN_BAND_SLEEP_ENABLED	1
+#define STATE_DISCARD_RX		2
 
 #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
 #define IBS_TX_IDLE_TIMEOUT_MS		2000
@@ -511,6 +512,7 @@ static int qca_open(struct hci_uart *hu)
 		} else {
 			hu->init_speed = qcadev->init_speed;
 			hu->oper_speed = qcadev->oper_speed;
+			set_bit(STATE_DISCARD_RX, &qca->flags);
 			ret = qca_power_setup(hu, true);
 			if (ret) {
 				destroy_workqueue(qca->workqueue);
@@ -903,6 +905,13 @@ static int qca_recv(struct hci_uart *hu, const void *data, int count)
 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
 		return -EUNATCH;
 
+	/* We discard Rx data received while device is in booting
+	 * stage, This is because of BT chip Tx line is in tristate.
+	 * Due to this we read some garbage data on UART Rx.
+	 */
+	if (test_bit(STATE_DISCARD_RX, &qca->flags))
+		return 0;
+
 	qca->rx_skb = h4_recv_buf(hu->hdev, qca->rx_skb, data, count,
 				  qca_recv_pkts, ARRAY_SIZE(qca_recv_pkts));
 	if (IS_ERR(qca->rx_skb)) {
@@ -1195,6 +1204,7 @@ static int qca_setup(struct hci_uart *hu)
 		if (ret)
 			return ret;
 
+		clear_bit(STATE_DISCARD_RX, &qca->flags);
 		ret = qca_read_soc_version(hdev, &soc_ver);
 		if (ret)
 			return ret;
@@ -1271,6 +1281,12 @@ static const struct qca_vreg_data qca_soc_data = {
 
 static void qca_power_shutdown(struct hci_uart *hu)
 {
+	struct qca_data *qca = hu->priv;
+
+	/* From this point we go into power off state. But serial port is
+	 * still open, discard all the garbage data received on the Rx line.
+	 */
+	set_bit(STATE_DISCARD_RX, &qca->flags);
 	host_set_baudrate(hu, 2400);
 	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
 	qca_power_setup(hu, false);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeFETSf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:18:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38807 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbeFETSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:18:33 -0400
X-Google-Smtp-Source: ADUXVKI752pYLSlcT2/wylNOfxjhemGRSB5T1VuJD0sky7Zb/p5hJZObeIHscMwOrge4EcWgGrAMow==
From: =?UTF-8?q?Attila=20T=C5=91k=C3=A9s?= <attitokes@gmail.com>
Cc: =?UTF-8?q?Attila=20T=C5=91k=C3=A9s?= <attitokes@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Configure SCO routing automatically
Date: Tue,  5 Jun 2018 22:17:43 +0300
Message-Id: <20180605191743.27748-1-attitokes@gmail.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Attila Tőkés <attitokes@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 61 +++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ddbd8c6a..50c73eef 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -83,6 +83,16 @@
  * @hu: pointer to HCI UART controller struct,
  *	used to disable flow control during runtime suspend and system sleep
  * @is_suspended: whether flow control is currently disabled
+ *
+ *  SCO routing parameters:
+ *   used as the parameters for the bcm_set_pcm_int_params command
+ *	@sco_routing:
+ *	 >= 255 (skip SCO routing configuration)
+ *	 0-3 (PCM, Transport, Codec, I2S)
+ *	@pcm_interface_rate: 0-4 (128 Kbps - 2048 Kbps)
+ *	@pcm_frame_type: 0 (short), 1 (long)
+ *	@pcm_sync_mode: 0 (slave), 1 (master)
+ *	@pcm_clock_mode: 0 (slave), 1 (master)
  */
 struct bcm_device {
 	/* Must be the first member, hci_serdev.c expects this. */
@@ -114,6 +124,13 @@ struct bcm_device {
 	struct hci_uart		*hu;
 	bool			is_suspended;
 #endif
+
+	/* SCO routing parameters */
+	u32			sco_routing;
+	u32			pcm_interface_rate;
+	u32			pcm_frame_type;
+	u32			pcm_sync_mode;
+	u32			pcm_clock_mode;
 };
 
 /* generic bcm uart resources */
@@ -189,6 +206,35 @@ static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	return 0;
 }
 
+static int bcm_configure_sco_routing(struct hci_uart *hu, struct bcm_device *bcm_dev)
+{
+	struct hci_dev *hdev = hu->hdev;
+	struct sk_buff *skb;
+	struct bcm_set_pcm_int_params params;
+
+	bt_dev_dbg(hdev, "BCM: Configuring SCO routing (%d %d %d %d %d)",
+			bcm_dev->sco_routing, bcm_dev->pcm_interface_rate, bcm_dev->pcm_frame_type,
+			bcm_dev->pcm_sync_mode,	bcm_dev->pcm_clock_mode);
+
+	params.routing = bcm_dev->sco_routing;
+	params.rate = bcm_dev->pcm_interface_rate;
+	params.frame_sync = bcm_dev->pcm_frame_type;
+	params.sync_mode = bcm_dev->pcm_sync_mode;
+	params.clock_mode = bcm_dev->pcm_clock_mode;
+
+	// send the SCO routing configuration command
+	skb = __hci_cmd_sync(hdev, 0xfc1c, sizeof(params), &params, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		int err = PTR_ERR(skb);
+		bt_dev_err(hdev, "BCM: failed to configure SCO routing (%d)", err);
+		return err;
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
 /* bcm_device_exists should be protected by bcm_device_lock */
 static bool bcm_device_exists(struct bcm_device *device)
 {
@@ -534,6 +580,10 @@ static int bcm_setup(struct hci_uart *hu)
 			host_set_baudrate(hu, speed);
 	}
 
+	if (bcm->dev->sco_routing < 0xff) {
+		bcm_configure_sco_routing(hu, bcm->dev);
+	}
+
 finalize:
 	release_firmware(fw);
 
@@ -1007,6 +1057,11 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 static int bcm_of_probe(struct bcm_device *bdev)
 {
 	device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
+	device_property_read_u32(bdev->dev, "sco-routing", &bdev->sco_routing);
+	device_property_read_u32(bdev->dev, "pcm-interface-rate", &bdev->pcm_interface_rate);
+	device_property_read_u32(bdev->dev, "pcm-frame-type", &bdev->pcm_frame_type);
+	device_property_read_u32(bdev->dev, "pcm-sync-mode", &bdev->pcm_sync_mode);
+	device_property_read_u32(bdev->dev, "pcm-clock-mode", &bdev->pcm_clock_mode);
 	return 0;
 }
 
@@ -1022,6 +1077,9 @@ static int bcm_probe(struct platform_device *pdev)
 	dev->dev = &pdev->dev;
 	dev->irq = platform_get_irq(pdev, 0);
 
+	/* SCO routing configuration is disabled by default */
+	dev->sco_routing = 0xff;
+
 	if (has_acpi_companion(&pdev->dev)) {
 		ret = bcm_acpi_probe(dev);
 		if (ret)
@@ -1281,6 +1339,9 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 	bcmdev->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, bcmdev);
 
+	/* SCO routing configuration is disabled by default */
+	bcmdev->sco_routing = 0xff;
+
 	if (has_acpi_companion(&serdev->dev))
 		err = bcm_acpi_probe(bcmdev);
 	else
-- 
2.17.0

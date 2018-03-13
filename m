Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934412AbeCMQEG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:04:06 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41850 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934443AbeCMQDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:03:53 -0400
X-Google-Smtp-Source: AG47ELtRQcJq/UGERJxb3cr8ltf5/j8wnFrpGoMlqr5L5ZXvWnRvZD1wwvHiXyD/Rocm6jfzaawEIw==
From: Thierry Escande <thierry.escande@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: hci_qca: Add serdev support
Date: Tue, 13 Mar 2018 17:03:26 +0100
Message-Id: <20180313160326.18180-4-thierry.escande@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180313160326.18180-1-thierry.escande@linaro.org>
References: <20180313160326.18180-1-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Escande <thierry.escande@collabora.com>

Add support for Qualcomm serial slave devices. Probe the serial device,
retrieve its maximum speed and register a new hci uart device.

Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
---
 drivers/bluetooth/Kconfig   |   2 +-
 drivers/bluetooth/hci_qca.c | 102 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 07e55cd8f8c8..c2a6a7ebd14b 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -195,7 +195,7 @@ config BT_HCIUART_BCM
 
 config BT_HCIUART_QCA
 	bool "Qualcomm Atheros protocol support"
-	depends on BT_HCIUART
+	depends on BT_HCIUART_SERDEV
 	select BT_HCIUART_H4
 	select BT_QCA
 	help
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 05ec530b8a3a..ca5428898702 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -29,7 +29,11 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/clk.h>
 #include <linux/debugfs.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of.h>
+#include <linux/serdev.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -50,6 +54,9 @@
 #define IBS_TX_IDLE_TIMEOUT_MS		2000
 #define BAUDRATE_SETTLE_TIMEOUT_MS	300
 
+/* divclk4 rate */
+#define DIVCLK4_RATE_32KHZ	32768
+
 /* HCI_IBS transmit side sleep protocol states */
 enum tx_ibs_states {
 	HCI_IBS_TX_ASLEEP,
@@ -111,6 +118,12 @@ struct qca_data {
 	u64 votes_off;
 };
 
+struct qca_serdev {
+	struct hci_uart	 serdev_hu;
+	struct gpio_desc *bt_en;
+	struct clk	 *divclk4;
+};
+
 static void __serial_clock_on(struct tty_struct *tty)
 {
 	/* TODO: Some chipset requires to enable UART clock on client
@@ -386,6 +399,7 @@ static void hci_ibs_wake_retrans_timeout(struct timer_list *t)
 /* Initialize protocol */
 static int qca_open(struct hci_uart *hu)
 {
+	struct qca_serdev *qcadev;
 	struct qca_data *qca;
 
 	BT_DBG("hu %p qca_open", hu);
@@ -444,6 +458,13 @@ static int qca_open(struct hci_uart *hu)
 	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
 	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
 
+	if (hu->serdev) {
+		serdev_device_open(hu->serdev);
+
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		gpiod_set_value(qcadev->bt_en, 1);
+	}
+
 	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
 	       qca->tx_idle_delay, qca->wake_retrans);
 
@@ -512,6 +533,7 @@ static int qca_flush(struct hci_uart *hu)
 /* Close protocol */
 static int qca_close(struct hci_uart *hu)
 {
+	struct qca_serdev *qcadev;
 	struct qca_data *qca = hu->priv;
 
 	BT_DBG("hu %p qca close", hu);
@@ -525,6 +547,13 @@ static int qca_close(struct hci_uart *hu)
 	destroy_workqueue(qca->workqueue);
 	qca->hu = NULL;
 
+	if (hu->serdev) {
+		serdev_device_close(hu->serdev);
+
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		gpiod_set_value(qcadev->bt_en, 0);
+	}
+
 	kfree_skb(qca->rx_skb);
 
 	hu->priv = NULL;
@@ -885,6 +914,14 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	return 0;
 }
 
+static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
+{
+	if (hu->serdev)
+		serdev_device_set_baudrate(hu->serdev, speed);
+	else
+		hci_uart_set_baudrate(hu, speed);
+}
+
 static int qca_setup(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -905,7 +942,7 @@ static int qca_setup(struct hci_uart *hu)
 		speed = hu->proto->init_speed;
 
 	if (speed)
-		hci_uart_set_baudrate(hu, speed);
+		host_set_baudrate(hu, speed);
 
 	/* Setup user speed if needed */
 	speed = 0;
@@ -924,7 +961,7 @@ static int qca_setup(struct hci_uart *hu)
 				   ret);
 			return ret;
 		}
-		hci_uart_set_baudrate(hu, speed);
+		host_set_baudrate(hu, speed);
 	}
 
 	/* Setup patch / NVM configurations */
@@ -958,12 +995,73 @@ static struct hci_uart_proto qca_proto = {
 	.dequeue	= qca_dequeue,
 };
 
+static int qca_serdev_probe(struct serdev_device *serdev)
+{
+	struct qca_serdev *qcadev;
+
+	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
+	if (!qcadev)
+		return -ENOMEM;
+
+	qcadev->serdev_hu.serdev = serdev;
+	serdev_device_set_drvdata(serdev, qcadev);
+
+	qcadev->bt_en = devm_gpiod_get(&serdev->dev, "bt-disable-n",
+				       GPIOD_OUT_LOW);
+	if (IS_ERR(qcadev->bt_en)) {
+		dev_err(&serdev->dev, "failed to acquire bt-disable-n gpio\n");
+		return PTR_ERR(qcadev->bt_en);
+	}
+
+	gpiod_set_value(qcadev->bt_en, 0);
+
+	qcadev->divclk4 = devm_clk_get(&serdev->dev, NULL);
+	if (IS_ERR(qcadev->divclk4)) {
+		dev_err(&serdev->dev, "failed to acquire divclk4\n");
+		return PTR_ERR(qcadev->divclk4);
+	}
+
+	clk_set_rate(qcadev->divclk4, DIVCLK4_RATE_32KHZ);
+	clk_prepare_enable(qcadev->divclk4);
+
+	return hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
+}
+
+static void qca_serdev_remove(struct serdev_device *serdev)
+{
+	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
+
+	hci_uart_unregister_device(&qcadev->serdev_hu);
+
+	clk_disable(qcadev->divclk4);
+	clk_unprepare(qcadev->divclk4);
+}
+
+static const struct of_device_id qca_bluetooth_of_match[] = {
+	{ .compatible = "qcom,qca6174-bt" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
+
+static struct serdev_device_driver qca_serdev_driver = {
+	.probe = qca_serdev_probe,
+	.remove = qca_serdev_remove,
+	.driver = {
+		.name = "hci_uart_qca",
+		.of_match_table = qca_bluetooth_of_match,
+	},
+};
+
 int __init qca_init(void)
 {
+	serdev_device_driver_register(&qca_serdev_driver);
+
 	return hci_uart_register_proto(&qca_proto);
 }
 
 int __exit qca_deinit(void)
 {
+	serdev_device_driver_unregister(&qca_serdev_driver);
+
 	return hci_uart_unregister_proto(&qca_proto);
 }
-- 
2.14.1

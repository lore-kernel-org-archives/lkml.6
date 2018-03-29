Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeC2TQC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 15:16:02 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35111 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbeC2TPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 15:15:53 -0400
X-Google-Smtp-Source: AIpwx4/aV1i+tBRK2307ILIoYUPKN+ADJj2OFdI2X5eIevrjyqW8oAgFuSa0JM4+JzZkgHXLsQz7rw==
From: Thierry Escande <thierry.escande@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] Bluetooth: hci_qca: Add serdev support
Date: Thu, 29 Mar 2018 21:15:24 +0200
Message-Id: <20180329191524.30225-5-thierry.escande@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180329191524.30225-1-thierry.escande@linaro.org>
References: <20180329191524.30225-1-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Qualcomm serial slave devices. Probe the serial device,
retrieve its maximum speed and register a new hci uart device.

Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v7: no change

v6:
- Fix gpio name in error message

v5:
- Use gpio new name 'enable'

v4:
- Rename divclk4 as susclk (its name in the bt chip)
- Use gpiod_set_value_cansleep()
- Replace #include <linux/of.h> with <linux/mod_devicetable.h>
- Restore dependency on BT_HCIUART

v3:
- Remove redundant call to gpiod_set_value() after devm_gpiod_get()
- Check returned values for clk_set_rate() and clk_prepare_enable()
- Use clk_disable_unprepare()

v2:
- Fix author email

 drivers/bluetooth/Kconfig   |   1 +
 drivers/bluetooth/hci_qca.c | 110 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 07e55cd8f8c8..e0f1a6609b68 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -196,6 +196,7 @@ config BT_HCIUART_BCM
 config BT_HCIUART_QCA
 	bool "Qualcomm Atheros protocol support"
 	depends on BT_HCIUART
+	depends on BT_HCIUART_SERDEV
 	select BT_HCIUART_H4
 	select BT_QCA
 	help
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 05ec530b8a3a..1afa17ff6303 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -29,7 +29,12 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/clk.h>
 #include <linux/debugfs.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/serdev.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -50,6 +55,9 @@
 #define IBS_TX_IDLE_TIMEOUT_MS		2000
 #define BAUDRATE_SETTLE_TIMEOUT_MS	300
 
+/* susclk rate */
+#define SUSCLK_RATE_32KHZ	32768
+
 /* HCI_IBS transmit side sleep protocol states */
 enum tx_ibs_states {
 	HCI_IBS_TX_ASLEEP,
@@ -111,6 +119,12 @@ struct qca_data {
 	u64 votes_off;
 };
 
+struct qca_serdev {
+	struct hci_uart	 serdev_hu;
+	struct gpio_desc *bt_en;
+	struct clk	 *susclk;
+};
+
 static void __serial_clock_on(struct tty_struct *tty)
 {
 	/* TODO: Some chipset requires to enable UART clock on client
@@ -386,6 +400,7 @@ static void hci_ibs_wake_retrans_timeout(struct timer_list *t)
 /* Initialize protocol */
 static int qca_open(struct hci_uart *hu)
 {
+	struct qca_serdev *qcadev;
 	struct qca_data *qca;
 
 	BT_DBG("hu %p qca_open", hu);
@@ -444,6 +459,13 @@ static int qca_open(struct hci_uart *hu)
 	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
 	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
 
+	if (hu->serdev) {
+		serdev_device_open(hu->serdev);
+
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		gpiod_set_value_cansleep(qcadev->bt_en, 1);
+	}
+
 	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
 	       qca->tx_idle_delay, qca->wake_retrans);
 
@@ -512,6 +534,7 @@ static int qca_flush(struct hci_uart *hu)
 /* Close protocol */
 static int qca_close(struct hci_uart *hu)
 {
+	struct qca_serdev *qcadev;
 	struct qca_data *qca = hu->priv;
 
 	BT_DBG("hu %p qca close", hu);
@@ -525,6 +548,13 @@ static int qca_close(struct hci_uart *hu)
 	destroy_workqueue(qca->workqueue);
 	qca->hu = NULL;
 
+	if (hu->serdev) {
+		serdev_device_close(hu->serdev);
+
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		gpiod_set_value_cansleep(qcadev->bt_en, 0);
+	}
+
 	kfree_skb(qca->rx_skb);
 
 	hu->priv = NULL;
@@ -885,6 +915,14 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
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
@@ -905,7 +943,7 @@ static int qca_setup(struct hci_uart *hu)
 		speed = hu->proto->init_speed;
 
 	if (speed)
-		hci_uart_set_baudrate(hu, speed);
+		host_set_baudrate(hu, speed);
 
 	/* Setup user speed if needed */
 	speed = 0;
@@ -924,7 +962,7 @@ static int qca_setup(struct hci_uart *hu)
 				   ret);
 			return ret;
 		}
-		hci_uart_set_baudrate(hu, speed);
+		host_set_baudrate(hu, speed);
 	}
 
 	/* Setup patch / NVM configurations */
@@ -958,12 +996,80 @@ static struct hci_uart_proto qca_proto = {
 	.dequeue	= qca_dequeue,
 };
 
+static int qca_serdev_probe(struct serdev_device *serdev)
+{
+	struct qca_serdev *qcadev;
+	int err;
+
+	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
+	if (!qcadev)
+		return -ENOMEM;
+
+	qcadev->serdev_hu.serdev = serdev;
+	serdev_device_set_drvdata(serdev, qcadev);
+
+	qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
+				       GPIOD_OUT_LOW);
+	if (IS_ERR(qcadev->bt_en)) {
+		dev_err(&serdev->dev, "failed to acquire enable gpio\n");
+		return PTR_ERR(qcadev->bt_en);
+	}
+
+	qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
+	if (IS_ERR(qcadev->susclk)) {
+		dev_err(&serdev->dev, "failed to acquire clk\n");
+		return PTR_ERR(qcadev->susclk);
+	}
+
+	err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
+	if (err)
+		return err;
+
+	err = clk_prepare_enable(qcadev->susclk);
+	if (err)
+		return err;
+
+	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
+	if (err)
+		clk_disable_unprepare(qcadev->susclk);
+
+	return err;
+}
+
+static void qca_serdev_remove(struct serdev_device *serdev)
+{
+	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
+
+	hci_uart_unregister_device(&qcadev->serdev_hu);
+
+	clk_disable_unprepare(qcadev->susclk);
+}
+
+static const struct of_device_id qca_bluetooth_of_match[] = {
+	{ .compatible = "qcom,qca6174-bt" },
+	{ /* sentinel */ }
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

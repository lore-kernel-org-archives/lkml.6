Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbeCTPt6 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:49:58 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51406 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeCTPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:49:56 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v5 3/3] Bluetooth: hci_qca: Add serdev support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180320032331.29865-4-thierry.escande@linaro.org>
Date: Tue, 20 Mar 2018 16:49:53 +0100
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7097660B-DC63-4685-B095-4D5C37ECD89E@holtmann.org>
References: <20180320032331.29865-1-thierry.escande@linaro.org>
 <20180320032331.29865-4-thierry.escande@linaro.org>
To: Thierry Escande <thierry.escande@linaro.org>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

> Add support for Qualcomm serial slave devices. Probe the serial device,
> retrieve its maximum speed and register a new hci uart device.
> 
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> ---
> 
> v5:
> - Use gpio new name 'enable'
> 
> v4:
> - Rename divclk4 as susclk (its name in the bt chip)
> - Use gpiod_set_value_cansleep()
> - Replace #include <linux/of.h> with <linux/mod_devicetable.h>
> - Restore dependency on BT_HCIUART
> 
> v3:
> - Remove redundant call to gpiod_set_value() after devm_gpiod_get()
> - Check returned values for clk_set_rate() and clk_prepare_enable()
> - Use clk_disable_unprepare()
> 
> v2:
> - Fix author email
> 
> drivers/bluetooth/Kconfig   |   1 +
> drivers/bluetooth/hci_qca.c | 109 +++++++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 108 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 07e55cd8f8c8..e0f1a6609b68 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -196,6 +196,7 @@ config BT_HCIUART_BCM
> config BT_HCIUART_QCA
> 	bool "Qualcomm Atheros protocol support"
> 	depends on BT_HCIUART
> +	depends on BT_HCIUART_SERDEV
> 	select BT_HCIUART_H4
> 	select BT_QCA
> 	help
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 05ec530b8a3a..6e6042f77784 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -29,7 +29,11 @@
>  */
> 
> #include <linux/kernel.h>
> +#include <linux/clk.h>
> #include <linux/debugfs.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/serdev.h>
> 
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> @@ -50,6 +54,9 @@
> #define IBS_TX_IDLE_TIMEOUT_MS		2000
> #define BAUDRATE_SETTLE_TIMEOUT_MS	300
> 
> +/* susclk rate */
> +#define SUSCLK_RATE_32KHZ	32768
> +
> /* HCI_IBS transmit side sleep protocol states */
> enum tx_ibs_states {
> 	HCI_IBS_TX_ASLEEP,
> @@ -111,6 +118,12 @@ struct qca_data {
> 	u64 votes_off;
> };
> 
> +struct qca_serdev {
> +	struct hci_uart	 serdev_hu;
> +	struct gpio_desc *bt_en;
> +	struct clk	 *susclk;
> +};
> +
> static void __serial_clock_on(struct tty_struct *tty)
> {
> 	/* TODO: Some chipset requires to enable UART clock on client
> @@ -386,6 +399,7 @@ static void hci_ibs_wake_retrans_timeout(struct timer_list *t)
> /* Initialize protocol */
> static int qca_open(struct hci_uart *hu)
> {
> +	struct qca_serdev *qcadev;
> 	struct qca_data *qca;
> 
> 	BT_DBG("hu %p qca_open", hu);
> @@ -444,6 +458,13 @@ static int qca_open(struct hci_uart *hu)
> 	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
> 	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
> 
> +	if (hu->serdev) {
> +		serdev_device_open(hu->serdev);
> +
> +		qcadev = serdev_device_get_drvdata(hu->serdev);
> +		gpiod_set_value_cansleep(qcadev->bt_en, 1);
> +	}
> +
> 	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
> 	       qca->tx_idle_delay, qca->wake_retrans);
> 
> @@ -512,6 +533,7 @@ static int qca_flush(struct hci_uart *hu)
> /* Close protocol */
> static int qca_close(struct hci_uart *hu)
> {
> +	struct qca_serdev *qcadev;
> 	struct qca_data *qca = hu->priv;
> 
> 	BT_DBG("hu %p qca close", hu);
> @@ -525,6 +547,13 @@ static int qca_close(struct hci_uart *hu)
> 	destroy_workqueue(qca->workqueue);
> 	qca->hu = NULL;
> 
> +	if (hu->serdev) {
> +		serdev_device_close(hu->serdev);
> +
> +		qcadev = serdev_device_get_drvdata(hu->serdev);
> +		gpiod_set_value_cansleep(qcadev->bt_en, 0);
> +	}
> +
> 	kfree_skb(qca->rx_skb);
> 
> 	hu->priv = NULL;
> @@ -885,6 +914,14 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
> 	return 0;
> }
> 
> +static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
> +{
> +	if (hu->serdev)
> +		serdev_device_set_baudrate(hu->serdev, speed);
> +	else
> +		hci_uart_set_baudrate(hu, speed);
> +}
> +
> static int qca_setup(struct hci_uart *hu)
> {
> 	struct hci_dev *hdev = hu->hdev;
> @@ -905,7 +942,7 @@ static int qca_setup(struct hci_uart *hu)
> 		speed = hu->proto->init_speed;
> 
> 	if (speed)
> -		hci_uart_set_baudrate(hu, speed);
> +		host_set_baudrate(hu, speed);
> 
> 	/* Setup user speed if needed */
> 	speed = 0;
> @@ -924,7 +961,7 @@ static int qca_setup(struct hci_uart *hu)
> 				   ret);
> 			return ret;
> 		}
> -		hci_uart_set_baudrate(hu, speed);
> +		host_set_baudrate(hu, speed);
> 	}
> 
> 	/* Setup patch / NVM configurations */
> @@ -958,12 +995,80 @@ static struct hci_uart_proto qca_proto = {
> 	.dequeue	= qca_dequeue,
> };
> 
> +static int qca_serdev_probe(struct serdev_device *serdev)
> +{
> +	struct qca_serdev *qcadev;
> +	int err;
> +
> +	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
> +	if (!qcadev)
> +		return -ENOMEM;
> +
> +	qcadev->serdev_hu.serdev = serdev;
> +	serdev_device_set_drvdata(serdev, qcadev);
> +
> +	qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
> +				       GPIOD_OUT_LOW);
> +	if (IS_ERR(qcadev->bt_en)) {
> +		dev_err(&serdev->dev, "failed to acquire bt-disable-n gpio\n");
> +		return PTR_ERR(qcadev->bt_en);
> +	}
> +
> +	qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
> +	if (IS_ERR(qcadev->susclk)) {
> +		dev_err(&serdev->dev, "failed to acquire clk\n");
> +		return PTR_ERR(qcadev->susclk);
> +	}
> +
> +	err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
> +	if (err)
> +		return err;
> +
> +	err = clk_prepare_enable(qcadev->susclk);
> +	if (err)
> +		return err;
> +
> +	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
> +	if (err)
> +		clk_disable_unprepare(qcadev->susclk);
> +
> +	return err;
> +}

so this a more generic question. Does the clk setup has to be done in serdev probe or can we just do that within qca_open callback. I asked because I really want to move towards btuart.c and integrate the vendor specific pieces there nicely. So what I did was that I posted a v2 that has the vendor abstraction build in and it would be super simple to add qca support to it. However I have no vendor specific handling from within the probe callback. If that is not needed and we can do all the clk and GPIO setup in the vendor open callback, then it should be fairly simple to do (I am ignoring IBS support for now, but I realize it is there).

That all said, the hci_qca.c code has __serial_clock_on() and __serial_clock_off() empty stubs. Is this about the susclk or is that something totally different?

Regards

Marcel

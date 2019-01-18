Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB63C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCB620823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 11:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfARLEu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 06:04:50 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:54631 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfARLEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 06:04:50 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id BDA17CF2C6;
        Fri, 18 Jan 2019 12:12:33 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3 5/5] Bluetooth: btusb: Use the hw_reset method to allow
 resetting the BT chip
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181121235020.29461-5-rajatja@google.com>
Date:   Fri, 18 Jan 2019 12:04:47 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        rajatxjain@gmail.com, dtor@google.com, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <BE2BC4DD-B10C-4ED8-8770-DE042478A152@holtmann.org>
References: <20181117010748.24347-1-rajatja@google.com>
 <20181121235020.29461-1-rajatja@google.com>
 <20181121235020.29461-5-rajatja@google.com>
To:     Rajat Jain <rajatja@google.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

> If the platform provides it, use the reset gpio to reset the BT
> chip (requested by the HCI core if needed). This has been found helpful
> on some of Intel bluetooth controllers where the firmware gets stuck and
> the only way out is a hard reset pin provided by the platform.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v3: Better error handling for gpiod_get_optional()
> v2: Handle the EPROBE_DEFER case.
> 
> drivers/bluetooth/btusb.c | 40 +++++++++++++++++++++++++++++++++++++++
> 1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index e8e148480c91..e7631f770fae 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -29,6 +29,7 @@
> #include <linux/of_device.h>
> #include <linux/of_irq.h>
> #include <linux/suspend.h>
> +#include <linux/gpio/consumer.h>
> #include <asm/unaligned.h>
> 
> #include <net/bluetooth/bluetooth.h>
> @@ -475,6 +476,8 @@ struct btusb_data {
> 	struct usb_endpoint_descriptor *diag_tx_ep;
> 	struct usb_endpoint_descriptor *diag_rx_ep;
> 
> +	struct gpio_desc *reset_gpio;
> +
> 	__u8 cmdreq_type;
> 	__u8 cmdreq;
> 
> @@ -490,6 +493,26 @@ struct btusb_data {
> 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> };
> 
> +
> +static void btusb_hw_reset(struct hci_dev *hdev)
> +{
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +	struct gpio_desc *reset_gpio = data->reset_gpio;
> +
> +	/*
> +	 * Toggle the hard reset line if the platform provides one. The reset
> +	 * is going to yank the device off the USB and then replug. So doing
> +	 * once is enough. The cleanup is handled correctly on the way out
> +	 * (standard USB disconnect), and the new device is detected cleanly
> +	 * and bound to the driver again like it should be.
> +	 */
> +	bt_dev_dbg(hdev, "%s: Initiating HW reset via gpio", __func__);

No __func__ here. That bt_dev_dbg does all of that via dynamic debug already.

> +	clear_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks);
> +	gpiod_set_value(reset_gpio, 1);
> +	mdelay(100);
> +	gpiod_set_value(reset_gpio, 0);
> +}
> +
> static inline void btusb_free_frags(struct btusb_data *data)
> {
> 	unsigned long flags;
> @@ -2917,6 +2940,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		       const struct usb_device_id *id)
> {
> 	struct usb_endpoint_descriptor *ep_desc;
> +	struct gpio_desc *reset_gpio;
> 	struct btusb_data *data;
> 	struct hci_dev *hdev;
> 	unsigned ifnum_base;
> @@ -3030,6 +3054,16 @@ static int btusb_probe(struct usb_interface *intf,
> 
> 	SET_HCIDEV_DEV(hdev, &intf->dev);
> 
> +	reset_gpio = gpiod_get_optional(&data->udev->dev, "reset",
> +					GPIOD_OUT_LOW);
> +	if (IS_ERR(reset_gpio)) {
> +		err = PTR_ERR(reset_gpio);
> +		goto out_free_dev;
> +	} else if (reset_gpio) {
> +		data->reset_gpio = reset_gpio;
> +		hdev->hw_reset = btusb_hw_reset;
> +	}
> +

How do we ensure that this is the right “reset” line. And it also needs to be bound to some hardware unless we can guarantee that this is always the same.

> 	hdev->open   = btusb_open;
> 	hdev->close  = btusb_close;
> 	hdev->flush  = btusb_flush;
> @@ -3085,6 +3119,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
> 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> +		set_bit(HCI_QUIRK_HW_RESET_ON_TIMEOUT, &hdev->quirks);

You are not messing with the quirks here please. Clearing quirks is crazy. Use the data->flags since this should be all btusb.c specific.

> 
> 		if (id->driver_info & BTUSB_INTEL) {
> 			hdev->setup = btusb_setup_intel;
> @@ -3225,6 +3260,8 @@ static int btusb_probe(struct usb_interface *intf,
> 	return 0;
> 
> out_free_dev:
> +	if (data->reset_gpio)
> +		gpiod_put(data->reset_gpio);
> 	hci_free_dev(hdev);
> 	return err;
> }
> @@ -3268,6 +3305,9 @@ static void btusb_disconnect(struct usb_interface *intf)
> 	if (data->oob_wake_irq)
> 		device_init_wakeup(&data->udev->dev, false);
> 
> +	if (data->reset_gpio)
> +		gpiod_put(data->reset_gpio);
> +
> 	hci_free_dev(hdev);
> }

Regards

Marcel


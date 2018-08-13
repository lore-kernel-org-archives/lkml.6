Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAB2C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1170A21834
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 08:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1170A21834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeHMKld convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:41:33 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51928 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeHMKld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:41:33 -0400
Received: from marcel-macpro.fritz.box (p4FEFCC41.dip0.t-ipconnect.de [79.239.204.65])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1ED12CEEB7;
        Mon, 13 Aug 2018 10:07:26 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v1 1/2] Bluetooth: mediatek: Add protocol support for
 MediaTek MT7668U USB devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <d976d455588eb0e3007cee1c3447e0455a06573e.1534062988.git.sean.wang@mediatek.com>
Date:   Mon, 13 Aug 2018 10:00:22 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8425C80B-7F83-45A0-96FB-9E6968F17C7A@holtmann.org>
References: <cover.1534062988.git.sean.wang@mediatek.com>
 <d976d455588eb0e3007cee1c3447e0455a06573e.1534062988.git.sean.wang@mediatek.com>
To:     sean.wang@mediatek.com
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> This adds the support of enabling MT7668U Bluetooth function running
> on the top of btusb driver. The patch also adds a newly created file
> mtkbt.c able to be reused independently from the transport type such
> as UART, USB and SDIO.

Include /sys/kernel/debug/usb/device portion in the commit message.

> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/Kconfig  |  16 +++
> drivers/bluetooth/Makefile |   1 +
> drivers/bluetooth/btmtk.c  | 308 +++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btmtk.h  |  99 +++++++++++++++
> drivers/bluetooth/btusb.c  | 174 +++++++++++++++++++++++++
> 5 files changed, 598 insertions(+)
> create mode 100644 drivers/bluetooth/btmtk.c
> create mode 100644 drivers/bluetooth/btmtk.h
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 07e55cd..2788498 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -11,6 +11,10 @@ config BT_BCM
> 	tristate
> 	select FW_LOADER
> 
> +config BT_MTK
> +	tristate
> +	select FW_LOADER
> +
> config BT_RTL
> 	tristate
> 	select FW_LOADER
> @@ -52,6 +56,18 @@ config BT_HCIBTUSB_BCM
> 
> 	  Say Y here to compile support for Broadcom protocol.
> 
> +config BT_HCIBTUSB_MTK
> +	bool "MediaTek protocol support"
> +	depends on BT_HCIBTUSB
> +	select BT_MTK
> +	default y

This one has to be n since MediaTek hardware was never supported in the first place. The existing y here are only for legacy hardware that was somehow supported in a generic fashion.

> +	help
> +	  The MediaTek protocol support enables firmware download
> +	  support and chip initialization for MediaTek Bluetooth
> +	  USB controllers.
> +
> +	  Say Y here to compile support for MediaTek protocol.
> +
> config BT_HCIBTUSB_RTL
> 	bool "Realtek protocol support"
> 	depends on BT_HCIBTUSB
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index 4e4e44d..bc23724 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
> obj-$(CONFIG_BT_WILINK)		+= btwilink.o
> obj-$(CONFIG_BT_QCOMSMD)	+= btqcomsmd.o
> obj-$(CONFIG_BT_BCM)		+= btbcm.o
> +obj-$(CONFIG_BT_MTK)		+= btmtk.o
> obj-$(CONFIG_BT_RTL)		+= btrtl.o
> obj-$(CONFIG_BT_QCA)		+= btqca.o
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> new file mode 100644
> index 0000000..9e39a0a
> --- /dev/null
> +++ b/drivers/bluetooth/btmtk.c
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 MediaTek Inc.
> +
> +/*
> + * Common operations for MediaTek Bluetooth devices
> + * with the UART, USB and SDIO transport
> + *
> + * Author: Sean Wang <sean.wang at mediatek.com>
> + *
> + */
> +#include <asm/unaligned.h>
> +#include <linux/firmware.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "btmtk.h"
> +
> +#define VERSION "0.1"
> +
> +int
> +btmtk_hci_wmt_sync(struct hci_dev *hdev, struct btmtk_hci_wmt_params *params)
> +{
> +	struct btmtk_hci_wmt_evt_funcc *evt_funcc;
> +	u32 hlen, status = BTMTK_WMT_INVALID;
> +	struct btmtk_wmt_hdr *hdr, *ehdr;
> +	struct btmtk_hci_wmt_cmd wc;
> +	struct sk_buff *skb;
> +	int err = 0;
> +
> +	hlen = sizeof(*hdr) + params->dlen;
> +	if (hlen > 255)
> +		return -EINVAL;
> +
> +	hdr = (struct btmtk_wmt_hdr *)&wc;
> +	hdr->dir = 1;
> +	hdr->op = params->op;
> +	hdr->dlen = cpu_to_le16(params->dlen + 1);
> +	hdr->flag = params->flag;
> +	memcpy(wc.data, params->data, params->dlen);
> +
> +	/* TODO: Add a fixup with __hci_raw_sync_ev that uses the hdev->raw_q
> +	 * instead of the hack with __hci_cmd_sync_ev + atomic_inc on cmd_cnt.
> +	 */
> +	atomic_inc(&hdev->cmd_cnt);
> +
> +	skb =  __hci_cmd_sync_ev(hdev, 0xfc6f, hlen, &wc, HCI_VENDOR_PKT,
> +				 HCI_INIT_TIMEOUT);

So first of all HCI_VENDOR_PKT is for H:4 pkt_type 0xff and not a vendor event. Use HCI_EV_VENDOR instead. Second __hci_cmd_sync_ev is not the right way doing this. Use __hci_cmd_send and handle the vendor event. See how we do it for the Intel firmware loading.

> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +
> +		bt_dev_err(hdev, "Failed to send wmt cmd (%d)\n", err);
> +
> +		print_hex_dump(KERN_ERR, "failed cmd: ",
> +			       DUMP_PREFIX_ADDRESS, 16, 1, &wc,
> +			       hlen > 16 ? 16 : hlen, true);

Scrap this.

> +		return err;
> +	}
> +
> +	ehdr = (struct btmtk_wmt_hdr *)skb->data;
> +	if (ehdr->op != hdr->op) {
> +		bt_dev_err(hdev, "Wrong op received %d expected %d",
> +			   ehdr->op, hdr->op);
> +		err = -EIO;
> +		goto err_free_skb;
> +	}
> +
> +	switch (ehdr->op) {
> +	case BTMTK_WMT_SEMAPHORE:
> +		if (ehdr->flag == 2)
> +			status = BTMTK_WMT_PATCH_UNDONE;
> +		else
> +			status = BTMTK_WMT_PATCH_DONE;
> +		break;
> +	case BTMTK_WMT_FUNC_CTRL:
> +		evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)ehdr;
> +		if (be16_to_cpu(evt_funcc->status) == 4)
> +			status = BTMTK_WMT_ON_DONE;
> +		else if (be16_to_cpu(evt_funcc->status) == 32)
> +			status = BTMTK_WMT_ON_PROGRESS;
> +		else
> +			status = BTMTK_WMT_ON_UNDONE;
> +		break;
> +	};
> +
> +	if (params->status)
> +		*params->status = status;
> +
> +err_free_skb:
> +	kfree_skb(skb);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(btmtk_hci_wmt_sync);
> +
> +static int
> +btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
> +		     int (*cmd_sync)(struct hci_dev *,
> +				     struct btmtk_hci_wmt_params *))
> +{
> +	struct btmtk_hci_wmt_params wmt_params;
> +	const struct firmware *fw;
> +	const u8 *fw_ptr;
> +	size_t fw_size;
> +	int err, dlen;
> +	u8 flag;
> +
> +	if (!cmd_sync)
> +		return -EINVAL;
> +
> +	err = request_firmware(&fw, fwname, &hdev->dev);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to load firmware file (%d)", err);
> +		return err;
> +	}
> +
> +	fw_ptr = fw->data;
> +	fw_size = fw->size;
> +
> +	/* The size of patch header is 30 bytes, should be skip */
> +	if (fw_size < 30)
> +		return -EINVAL;
> +
> +	fw_size -= 30;
> +	fw_ptr += 30;
> +	flag = 1;
> +
> +	wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
> +	wmt_params.status = NULL;
> +
> +	while (fw_size > 0) {
> +		dlen = min_t(int, 250, fw_size);
> +
> +		/* Tell deivice the position in sequence */
> +		if (fw_size - dlen <= 0)
> +			flag = 3;
> +		else if (fw_size < fw->size - 30)
> +			flag = 2;
> +
> +		wmt_params.flag = flag;
> +		wmt_params.dlen = dlen;
> +		wmt_params.data = fw_ptr;
> +
> +		err = cmd_sync(hdev, &wmt_params);
> +		if (err < 0) {
> +			bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
> +				   err);
> +			goto err_release_fw;
> +		}
> +
> +		fw_size -= dlen;
> +		fw_ptr += dlen;
> +	}
> +
> +	wmt_params.op = BTMTK_WMT_RST;
> +	wmt_params.flag = 4;
> +	wmt_params.dlen = 0;
> +	wmt_params.data = NULL;
> +	wmt_params.status = NULL;
> +
> +	/* Activate funciton the firmware providing to */
> +	err = cmd_sync(hdev, &wmt_params);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
> +		return err;
> +	}
> +
> +err_release_fw:
> +	release_firmware(fw);
> +
> +	return err;
> +}
> +
> +static int
> +btmtk_func_query(struct btmtk_func_query *fq)
> +{
> +	struct btmtk_hci_wmt_params wmt_params;
> +	int status, err;
> +	u8 param = 0;
> +
> +	if (!fq || !fq->hdev || !fq->cmd_sync)
> +		return -EINVAL;
> +
> +	/* Query whether the function is enabled */
> +	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
> +	wmt_params.flag = 4;
> +	wmt_params.dlen = sizeof(param);
> +	wmt_params.data = &param;
> +	wmt_params.status = &status;
> +
> +	err = fq->cmd_sync(fq->hdev, &wmt_params);
> +	if (err < 0) {
> +		bt_dev_err(fq->hdev, "Failed to query function status (%d)",
> +			   err);
> +		return err;
> +	}
> +
> +	return status;
> +}
> +
> +int btmtk_enable(struct hci_dev *hdev, const char *fwname,
> +		 int (*cmd_sync)(struct hci_dev *hdev,
> +				 struct btmtk_hci_wmt_params *))
> +{
> +	struct btmtk_hci_wmt_params wmt_params;
> +	struct btmtk_func_query func_query;
> +	int status, err;
> +	u8 param;
> +
> +	if (!cmd_sync)
> +		return -EINVAL;
> +
> +	/* Query whether the firmware is already download */
> +	wmt_params.op = BTMTK_WMT_SEMAPHORE;
> +	wmt_params.flag = 1;
> +	wmt_params.dlen = 0;
> +	wmt_params.data = NULL;
> +	wmt_params.status = &status;
> +
> +	err = cmd_sync(hdev, &wmt_params);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to query firmware status (%d)", err);
> +		return err;
> +	}
> +
> +	if (status == BTMTK_WMT_PATCH_DONE) {
> +		bt_dev_info(hdev, "firmware already downloaded");
> +		goto ignore_setup_fw;
> +	}
> +
> +	/* Setup a firmware which the device definitely requires */
> +	err = btmtk_setup_firmware(hdev, fwname, cmd_sync);
> +	if (err < 0)
> +		return err;
> +
> +ignore_setup_fw:
> +	func_query.hdev = hdev;
> +	func_query.cmd_sync = cmd_sync;
> +	err = readx_poll_timeout(btmtk_func_query, &func_query, status,
> +				 status < 0 || status != BTMTK_WMT_ON_PROGRESS,
> +				 2000, 5000000);
> +	/* -ETIMEDOUT happens */
> +	if (err < 0)
> +		return err;
> +
> +	/* The other errors happen internally inside btmtk_func_query */
> +	if (status < 0)
> +		return status;
> +
> +	if (status == BTMTK_WMT_ON_DONE) {
> +		bt_dev_info(hdev, "function already on");
> +		goto ignore_func_on;
> +	}
> +
> +	/* Enable Bluetooth protocol */
> +	param = 1;
> +	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
> +	wmt_params.flag = 0;
> +	wmt_params.dlen = sizeof(param);
> +	wmt_params.data = &param;
> +	wmt_params.status = NULL;
> +
> +	err = cmd_sync(hdev, &wmt_params);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
> +		return err;
> +	}
> +
> +ignore_func_on:
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btmtk_enable);
> +
> +int btmtk_disable(struct hci_dev *hdev,
> +		  int (*cmd_sync)(struct hci_dev *hdev,
> +				  struct btmtk_hci_wmt_params *))
> +{
> +	struct btmtk_hci_wmt_params wmt_params;
> +	u8 param = 0;
> +	int err;
> +
> +	if (!cmd_sync)
> +		return -EINVAL;
> +
> +	/* Disable the device */
> +	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
> +	wmt_params.flag = 0;
> +	wmt_params.dlen = sizeof(param);
> +	wmt_params.data = &param;
> +	wmt_params.status = NULL;
> +
> +	err = cmd_sync(hdev, &wmt_params);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btmtk_disable);
> +
> +MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek Bluetooth device driver ver " VERSION);
> +MODULE_VERSION(VERSION);
> +MODULE_LICENSE("GPL");
> +MODULE_FIRMWARE(FIRMWARE_MT7668);
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> new file mode 100644
> index 0000000..64fc395
> --- /dev/null
> +++ b/drivers/bluetooth/btmtk.h
> @@ -0,0 +1,99 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + *
> + * Common operations for MediaTek Bluetooth devices
> + * with the UART, USB and SDIO transport
> + *
> + * Author: Sean Wang <sean.wang@mediatek.com>
> + *
> + */
> +
> +#define FIRMWARE_MT7668		"mt7668pr2h.bin"
> +
> +enum {
> +	BTMTK_WMT_PATCH_DWNLD = 0x1,
> +	BTMTK_WMT_FUNC_CTRL = 0x6,
> +	BTMTK_WMT_RST = 0x7,
> +	BTMTK_WMT_SEMAPHORE = 0x17,
> +};
> +
> +enum {
> +	BTMTK_WMT_INVALID,
> +	BTMTK_WMT_PATCH_UNDONE,
> +	BTMTK_WMT_PATCH_DONE,
> +	BTMTK_WMT_ON_UNDONE,
> +	BTMTK_WMT_ON_DONE,
> +	BTMTK_WMT_ON_PROGRESS,
> +};
> +
> +struct btmtk_wmt_hdr {
> +	u8	dir;
> +	u8	op;
> +	__le16	dlen;
> +	u8	flag;
> +} __packed;
> +
> +struct btmtk_hci_wmt_cmd {
> +	struct btmtk_wmt_hdr hdr;
> +	u8 data[256];
> +} __packed;
> +
> +struct btmtk_hci_wmt_evt_funcc {
> +	struct btmtk_wmt_hdr hdr;
> +	__be16 status;
> +} __packed;
> +
> +struct btmtk_hci_wmt_params {
> +	u8 op;
> +	u8 flag;
> +	u16 dlen;
> +	const void *data;
> +	u32 *status;
> +};
> +
> +struct btmtk_func_query {
> +	struct hci_dev *hdev;
> +	int (*cmd_sync)(struct hci_dev *hdev,
> +			struct btmtk_hci_wmt_params *wmt_params);
> +};
> +
> +#if IS_ENABLED(CONFIG_BT_MTK)
> +
> +int
> +btmtk_hci_wmt_sync(struct hci_dev *hdev, struct btmtk_hci_wmt_params *params);
> +
> +int
> +btmtk_enable(struct hci_dev *hdev, const char *fn,
> +	     int (*cmd_sync)(struct hci_dev *,
> +			     struct btmtk_hci_wmt_params *));
> +
> +int
> +btmtk_disable(struct hci_dev *hdev,
> +	      int (*cmd_sync)(struct hci_dev *,
> +			      struct btmtk_hci_wmt_params *));
> +#else
> +
> +static int
> +btmtk_hci_wmt_sync(struct hci_dev *hdev, struct btmtk_hci_wmt_params *params)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int
> +btmtk_enable(struct hci_dev *hdev, const char *fn,
> +	     int (*cmd_sync)(struct hci_dev *,
> +			     struct btmtk_hci_wmt_params *))
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int
> +btmtk_disable(struct hci_dev *hdev,
> +	      int (*cmd_sync)(struct hci_dev *,
> +			      struct btmtk_hci_wmt_params *))
> +{
> +	return -EOPNOTSUPP;
> +}

I dislike this callback parameter to execute. It it convoluted. My suggestion is that first add MediaTek support to btusb.c and then lets try to see how we unify USB transport and UART transport.

> +
> +#endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 60bf04b..773238b 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -26,6 +26,7 @@
> #include <linux/usb.h>
> #include <linux/usb/quirks.h>
> #include <linux/firmware.h>
> +#include <linux/iopoll.h>
> #include <linux/of_device.h>
> #include <linux/of_irq.h>
> #include <linux/suspend.h>
> @@ -36,6 +37,7 @@
> 
> #include "btintel.h"
> #include "btbcm.h"
> +#include "btmtk.h"
> #include "btrtl.h"
> 
> #define VERSION "0.8"
> @@ -69,6 +71,7 @@ static struct usb_driver btusb_driver;
> #define BTUSB_BCM2045		0x40000
> #define BTUSB_IFNUM_2		0x80000
> #define BTUSB_CW6622		0x100000
> +#define BTUSB_MEDIATEK		0x200000
> 
> static const struct usb_device_id btusb_table[] = {
> 	/* Generic Bluetooth USB device */
> @@ -355,6 +358,10 @@ static const struct usb_device_id blacklist_table[] = {
> 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
> 	  .driver_info = BTUSB_REALTEK },
> 
> +	/* MediaTek Bluetooth devices */
> +	{ USB_VENDOR_AND_INTERFACE_INFO(0x0e8d, 0xe0, 0x01, 0x01),
> +	  .driver_info = BTUSB_MEDIATEK },
> +
> 	/* Additional Realtek 8723AE Bluetooth devices */
> 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
> 	{ USB_DEVICE(0x13d3, 0x3394), .driver_info = BTUSB_REALTEK },
> @@ -2347,6 +2354,164 @@ static int btusb_shutdown_intel(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +#ifdef CONFIG_BT_HCIBTUSB_MTK
> +
> +struct btusb_mtk_poll {
> +	struct btusb_data *udata;
> +	void *buf;
> +	size_t len;
> +	size_t actual_len;
> +};
> +
> +struct btusb_mtk_wmt_poll {
> +	struct btusb_data *udata;
> +	struct work_struct work;
> +};
> +
> +static int btusb_mtk_reg_read(struct btusb_data *data, u32 reg, u32 *val)
> +{
> +	int pipe, err, size = sizeof(u32);
> +	void *buf;
> +
> +	buf = kzalloc(size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	pipe = usb_rcvctrlpipe(data->udev, 0);
> +	err = usb_control_msg(data->udev, pipe, 0x63,
> +			      USB_TYPE_VENDOR | USB_DIR_IN,
> +			      reg >> 16, reg & 0xffff,
> +			      buf, size, USB_CTRL_SET_TIMEOUT);
> +	if (err < 0)
> +		goto err_free_buf;
> +
> +	*val = get_unaligned_le32(buf);
> +
> +err_free_buf:
> +	kfree(buf);
> +
> +	return err;
> +}
> +
> +static int btusb_mtk_id_get(struct btusb_data *data, u32 *id)
> +{
> +	return btusb_mtk_reg_read(data, 0x80000008, id);
> +}
> +
> +static int btusb_mtk_wmt_event_poll(struct btusb_mtk_poll *p)
> +{
> +	int pipe, actual_len;
> +
> +	pipe = usb_rcvctrlpipe(p->udata->udev, 0);
> +
> +	actual_len = usb_control_msg(p->udata->udev, pipe, 1,
> +				     USB_TYPE_VENDOR | USB_DIR_IN, 0x30, 0,
> +				     p->buf, p->len, USB_CTRL_SET_TIMEOUT);
> +
> +	p->actual_len = actual_len;
> +
> +	return actual_len;
> +}
> +
> +static void btusb_mtk_wmt_event_polls(struct work_struct *work)
> +{
> +	struct btusb_mtk_wmt_poll *wmt_event_polling;
> +	struct btusb_mtk_poll p;
> +	int polled_dlen, err;
> +	const int len = 64;
> +	void *buf;
> +	char *evt;
> +
> +	wmt_event_polling = container_of(work, typeof(*wmt_event_polling),
> +					 work);
> +	buf = kzalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		return;
> +
> +	p.udata = wmt_event_polling->udata;
> +	p.buf = buf;
> +	p.len = len;
> +	p.actual_len = 0;
> +
> +	/* Polling WMT event via control endpoint until the event returns or
> +	 * the timeout happens.
> +	 */
> +	err = readx_poll_timeout(btusb_mtk_wmt_event_poll, &p, polled_dlen,
> +				 polled_dlen > 0, 200, 1000000);
> +	if (err < 0)
> +		goto err_free_buf;
> +
> +	evt = p.buf;
> +
> +	/* Fix up the vendor event id with 0xff for vendor specific instead
> +	 * of 0xe4 so that event send via monitoring socket can be parsed
> +	 * properly.
> +	 */
> +	if (*evt == 0xe4)
> +		*evt = 0xff;
> +
> +	/* The WMT event is actually a HCI event so that the WMT event should go
> +	 * to the code flow a HCI event should go to.
> +	 */
> +	btusb_recv_intr(p.udata, p.buf, p.actual_len);
> +
> +err_free_buf:
> +	kfree(buf);
> +}

So can we not just submit the URB like we do with all others. Can control endpoint IN URBs return early without any data.

> +
> +static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
> +				  struct btmtk_hci_wmt_params *wmt_params)
> +{
> +	struct btusb_mtk_wmt_poll wmt_event_polling;
> +	int err;
> +
> +	/* MediaTek WMT HCI vendor event is coming through the control endpoint,
> +	 * not through the interrupt endpoint so that we have to schedule a
> +	 * work to poll the event.
> +	 */
> +	INIT_WORK_ONSTACK(&wmt_event_polling.work, btusb_mtk_wmt_event_polls);
> +	wmt_event_polling.udata = hci_get_drvdata(hdev);
> +	schedule_work(&wmt_event_polling.work);
> +
> +	err = btmtk_hci_wmt_sync(hdev, wmt_params);
> +
> +	cancel_work_sync(&wmt_event_polling.work);
> +
> +	return err;
> +}
> +
> +static int btusb_mtk_setup(struct hci_dev *hdev)
> +{
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +	const char *fwname;
> +	int err = 0;
> +	u32 dev_id;
> +
> +	err = btusb_mtk_id_get(data, &dev_id);
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Failed to get device id (%d)", err);
> +		return err;
> +	}
> +
> +	switch (dev_id) {
> +	case 0x7668:
> +		fwname = FIRMWARE_MT7668;
> +		break;
> +	default:
> +		bt_dev_err(hdev, "Unsupported support hardware variant (%08x)",
> +			   dev_id);
> +		return -ENODEV;
> +	}
> +
> +	return btmtk_enable(hdev, fwname, btusb_mtk_hci_wmt_sync);
> +}
> +
> +static int btusb_mtk_shutdown(struct hci_dev *hdev)
> +{
> +	return btmtk_disable(hdev, btusb_mtk_hci_wmt_sync);
> +}
> +#endif
> +
> #ifdef CONFIG_PM
> /* Configure an out-of-band gpio as wake-up pin, if specified in device tree */
> static int marvell_config_oob_wake(struct hci_dev *hdev)
> @@ -3031,6 +3196,15 @@ static int btusb_probe(struct usb_interface *intf,
> 	if (id->driver_info & BTUSB_MARVELL)
> 		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
> 
> +#ifdef CONFIG_BT_HCIBTUSB_MTK
> +	if (id->driver_info & BTUSB_MEDIATEK) {
> +		hdev->setup = btusb_mtk_setup;
> +		hdev->shutdown = btusb_mtk_shutdown;
> +		hdev->manufacturer = 70;
> +		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> +	}
> +#endif
> +
> 	if (id->driver_info & BTUSB_SWAVE) {
> 		set_bit(HCI_QUIRK_FIXUP_INQUIRY_MODE, &hdev->quirks);
> 		set_bit(HCI_QUIRK_BROKEN_LOCAL_COMMANDS, &hdev->quirks);

Regards

Marcel


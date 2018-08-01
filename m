Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9F4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302F120844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302F120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbeHAJhc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:37:32 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:43219 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733177AbeHAJhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:37:32 -0400
Received: from marcel-macpro.fritz.box (p4FEFCC41.dip0.t-ipconnect.de [79.239.204.65])
        by mail.holtmann.org (Postfix) with ESMTPSA id A346CCF355;
        Wed,  1 Aug 2018 10:00:05 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v7 2/3] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <c92ed10cf16f36d9a3b390e864af92e2dfe7b771.1533056925.git.sean.wang@mediatek.com>
Date:   Wed, 1 Aug 2018 09:53:06 +0200
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1707FFA1-A294-4A95-A3BF-0910CE455232@holtmann.org>
References: <cover.1533056925.git.sean.wang@mediatek.com>
 <c92ed10cf16f36d9a3b390e864af92e2dfe7b771.1533056925.git.sean.wang@mediatek.com>
To:     sean.wang@mediatek.com
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> This adds a driver based on serdev driver for the MediaTek serial protocol
> based on running H:4, which can enable the built-in Bluetooth device inside
> MT7622 SoC.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/Kconfig     |  11 +
> drivers/bluetooth/Makefile    |   2 +
> drivers/bluetooth/btmtkuart.c | 591 ++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 604 insertions(+)
> create mode 100644 drivers/bluetooth/btmtkuart.c
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index f3c643a..5ace676 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -74,6 +74,17 @@ config BT_HCIBTSDIO
> 	  Say Y here to compile support for Bluetooth SDIO devices into the
> 	  kernel or say M to compile it as module (btsdio).
> 
> +config BT_MTKUART
> +	tristate "MediaTek HCI UART driver"
> +	depends on SERIAL_DEV_BUS
> +	help
> +	  MediaTek Bluetooth HCI UART driver.
> +	  This driver is required if you want to use MediaTek Bluetooth
> +	  with serial interface.
> +
> +	  Say Y here to compile support for MediaTek Bluetooth UART devices
> +	  into the kernel or say M to compile it as module (btmtkuart).
> +
> config BT_HCIUART
> 	tristate "HCI UART driver"
> 	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index ec16c55..12ad6e9 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -25,6 +25,8 @@ obj-$(CONFIG_BT_BCM)		+= btbcm.o
> obj-$(CONFIG_BT_RTL)		+= btrtl.o
> obj-$(CONFIG_BT_QCA)		+= btqca.o
> 
> +obj-$(CONFIG_BT_MTKUART)	+= btmtkuart.o
> +
> obj-$(CONFIG_BT_HCIUART_NOKIA)	+= hci_nokia.o
> 
> obj-$(CONFIG_BT_HCIRSI)		+= btrsi.o
> diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
> new file mode 100644
> index 0000000..def3d4b
> --- /dev/null
> +++ b/drivers/bluetooth/btmtkuart.c
> @@ -0,0 +1,591 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018 MediaTek Inc.
> +
> +/*
> + * Bluetooth support for MediaTek serial devices
> + *
> + * Author: Sean Wang <sean.wang@mediatek.com>
> + *
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/atomic.h>
> +#include <linux/clk.h>
> +#include <linux/firmware.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/serdev.h>
> +#include <linux/skbuff.h>
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "h4_recv.h"
> +
> +#define VERSION "0.1"
> +
> +#define FIRMWARE_MT7622		"mediatek/mt7622pr2h.bin"
> +
> +#define MTK_STP_TLR_SIZE	2
> +
> +#define BTMTKUART_TX_STATE_ACTIVE	1
> +#define BTMTKUART_TX_STATE_WAKEUP	2
> +
> +enum {
> +	MTK_WMT_PATCH_DWNLD = 0x1,
> +	MTK_WMT_FUNC_CTRL = 0x6,
> +	MTK_WMT_RST = 0x7
> +};
> +
> +struct mtk_stp_hdr {
> +	u8 prefix;
> +	u8 dlen1:4;
> +	u8 type:4;

So this is the hard one. I doubt that this is endian safe. It is also some fun way of packing it. Can you find a better variable name and just pack it into an u16 in the function. And then also label this __le16 or __be16 accordingly.

> +	u8 dlen2;
> +	u8 cs;

Are you checking the checksum on receive?

> +} __packed;
> +
> +struct mtk_wmt_hdr {
> +	u8	dir;
> +	u8	op;
> +	__le16	dlen;
> +	u8	flag;
> +} __packed;
> +
> +struct mtk_hci_wmt_cmd {
> +	struct mtk_wmt_hdr hdr;
> +	u8 data[256];
> +} __packed;
> +
> +struct btmtkuart_dev {
> +	struct hci_dev *hdev;
> +	struct serdev_device *serdev;
> +
> +	struct work_struct tx_work;
> +	unsigned long tx_state;
> +	struct sk_buff_head txq;
> +
> +	struct sk_buff *rx_skb;
> +
> +	struct mtk_stp_splitter *sp;

This should be a leftover and no longer be needed.

> +	struct clk *clk;

Move the struct clk below struct serdev_device.

> +
> +	u8	stp_pad[6];
> +	u8	stp_cursor;
> +	u16	stp_dlen;
> +};
> +
> +static int mtk_hci_wmt_sync(struct hci_dev *hdev, u8 op, u8 flag, u16 plen,
> +			    const void *param)
> +{
> +	struct mtk_hci_wmt_cmd wc;
> +	struct mtk_wmt_hdr *hdr;
> +	struct sk_buff *skb;
> +	u32 hlen;
> +
> +	hlen = sizeof(*hdr) + plen;
> +	if (hlen > 255)
> +		return -EINVAL;
> +
> +	hdr = (struct mtk_wmt_hdr *)&wc;
> +	hdr->dir = 1;
> +	hdr->op = op;
> +	hdr->dlen = cpu_to_le16(plen + 1);
> +	hdr->flag = flag;
> +	memcpy(wc.data, param, plen);
> +
> +	atomic_inc(&hdev->cmd_cnt);

Why are you doing this one. It will need a comment here if really needed. However I doubt that this is needed. You are only using it from hdev->setup and hdev->shutdown callbacks.

> +
> +	skb = __hci_cmd_sync_ev(hdev, 0xfc6f, hlen, &wc, HCI_VENDOR_PKT,
> +				HCI_INIT_TIMEOUT);
> +
> +	if (IS_ERR(skb)) {
> +		int err = PTR_ERR(skb);
> +
> +		bt_dev_err(hdev, "Failed to send wmt cmd (%d)", err);
> +		return err;
> +	}
> +
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +
> +static int mtk_setup_fw(struct hci_dev *hdev)
> +{
> +	const struct firmware *fw;
> +	const char *fwname;
> +	const u8 *fw_ptr;
> +	size_t fw_size;
> +	int err, dlen;
> +	u8 flag;
> +
> +	fwname = FIRMWARE_MT7622;

Scrap the fwname variable and use it directly. If you later want to support newer/older hardware with other firmware names, we deal with it then.

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
> +	/* The size of patch header is 30 bytes, should be skip. */
> +	if (fw_size < 30)
> +		return -EINVAL;
> +
> +	fw_size -= 30;
> +	fw_ptr += 30;
> +	flag = 1;
> +
> +	while (fw_size > 0) {
> +		dlen = min_t(int, 250, fw_size);
> +
> +		/* Tell deivice the position in sequence. */
> +		if (fw_size - dlen <= 0)
> +			flag = 3;
> +		else if (fw_size < fw->size - 30)
> +			flag = 2;
> +
> +		err = mtk_hci_wmt_sync(hdev, MTK_WMT_PATCH_DWNLD, flag, dlen,
> +				       fw_ptr);
> +		if (err < 0)
> +			break;
> +
> +		fw_size -= dlen;
> +		fw_ptr += dlen;
> +	}
> +
> +	release_firmware(fw);
> +
> +	return err;
> +}
> +
> +static int btmtkuart_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct hci_event_hdr *hdr = (void *)skb->data;
> +
> +	/* Fix up the vendor event id with HCI_VENDOR_PKT instead of
> +	 * 0xe4 so that btmon can parse the kind of vendor event properly.
> +	 */
> +	if (hdr->evt == 0xe4)
> +		hdr->evt = HCI_VENDOR_PKT;
> +
> +	/* Each HCI event would go through the core. */

This comment adds really no value here. Just remove it.

> +	return hci_recv_frame(hdev, skb);
> +}
> +
> +static const struct h4_recv_pkt mtk_recv_pkts[] = {
> +	{ H4_RECV_ACL,      .recv = hci_recv_frame },
> +	{ H4_RECV_SCO,      .recv = hci_recv_frame },
> +	{ H4_RECV_EVENT,    .recv = btmtkuart_recv_event },
> +};
> +
> +static const unsigned char *
> +mtk_stp_split(struct btmtkuart_dev *bdev, const unsigned char *data, int count,
> +	      int *sz_h4)
> +{
> +	struct mtk_stp_hdr *shdr;
> +
> +	/* The cursor is reset when all the data of STP is consumed out. */
> +	if (!bdev->stp_dlen && bdev->stp_cursor >= 6)
> +		bdev->stp_cursor = 0;
> +
> +	/* Filling pad until all STP info is obtained. */
> +	while (bdev->stp_cursor < 6 && count > 0) {
> +		bdev->stp_pad[bdev->stp_cursor] = *data;
> +		bdev->stp_cursor++;
> +		data++;
> +		count--;
> +	}
> +
> +	/* Retrieve STP info and have a sanity check. */
> +	if (!bdev->stp_dlen && bdev->stp_cursor >= 6) {
> +		shdr = (struct mtk_stp_hdr *)&bdev->stp_pad[2];
> +		bdev->stp_dlen = shdr->dlen1 << 8 | shdr->dlen2;
> +
> +		/* Resync STP when unexpected data is being read. */
> +		if (shdr->prefix != 0x80 || bdev->stp_dlen > 2048) {
> +			bt_dev_err(bdev->hdev, "stp format unexpect (%d, %d)",
> +				   shdr->prefix, bdev->stp_dlen);
> +			bdev->stp_cursor = 2;
> +			bdev->stp_dlen = 0;
> +		}
> +	}
> +
> +	/* Directly quit when there's no data found for H4 can process. */
> +	if (count <= 0)
> +		return NULL;
> +
> +	/* Tranlate to how much the size of data H4 can handle so far. */
> +	*sz_h4 = min_t(int, count, bdev->stp_dlen);
> +
> +	/* Update the remaining size of STP packet. */
> +	bdev->stp_dlen -= *sz_h4;
> +
> +	/* Data points to STP payload which can be handled by H4. */
> +	return data;
> +}
> +
> +static int btmtkuart_recv(struct hci_dev *hdev, const u8 *data, size_t count)
> +{
> +	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
> +	const unsigned char *p_left = data, *p_h4;
> +	int sz_left = count, sz_h4, adv;
> +	int err;
> +
> +	while (sz_left > 0) {
> +		/*  The serial data received from MT7622 BT controller is
> +		 *  at all time padded around with the STP header and tailer.
> +		 *
> +		 *  A full STP packet is looking like
> +		 *   -----------------------------------
> +		 *  | STP header  |  H:4   | STP tailer |
> +		 *   -----------------------------------
> +		 *  but it doesn't guarantee to contain a full H:4 packet which
> +		 *  means that it's possible for multiple STP packets forms a
> +		 *  full H:4 packet that means extra STP header + length doesn't
> +		 *  indicate a full H:4 frame, things can fragment. Whose length
> +		 *  recorded in STP header just shows up the most length the
> +		 *  H:4 engine can handle currently.
> +		 */
> +
> +		p_h4 = mtk_stp_split(bdev, p_left, sz_left, &sz_h4);
> +		if (!p_h4)
> +			break;
> +
> +		adv = p_h4 - p_left;
> +		sz_left -= adv;
> +		p_left += adv;
> +
> +		bdev->rx_skb = h4_recv_buf(bdev->hdev, bdev->rx_skb, p_h4,
> +					   sz_h4, mtk_recv_pkts,
> +					   sizeof(mtk_recv_pkts));
> +		if (IS_ERR(bdev->rx_skb)) {
> +			err = PTR_ERR(bdev->rx_skb);
> +			bt_dev_err(bdev->hdev,
> +				   "Frame reassembly failed (%d)", err);
> +			bdev->rx_skb = NULL;
> +			return err;
> +		}
> +
> +		sz_left -= sz_h4;
> +		p_left += sz_h4;
> +	}
> +
> +	return 0;
> +}
> +
> +static void btmtkuart_tx_work(struct work_struct *work)
> +{
> +	struct btmtkuart_dev *bdev = container_of(work, struct btmtkuart_dev,
> +						   tx_work);
> +	struct serdev_device *serdev = bdev->serdev;
> +	struct hci_dev *hdev = bdev->hdev;
> +
> +	while (1) {
> +		clear_bit(BTMTKUART_TX_STATE_WAKEUP, &bdev->tx_state);
> +
> +		while (1) {
> +			struct sk_buff *skb = skb_dequeue(&bdev->txq);
> +			int len;
> +
> +			if (!skb)
> +				break;
> +
> +			len = serdev_device_write_buf(serdev, skb->data,
> +						      skb->len);
> +			hdev->stat.byte_tx += len;
> +
> +			skb_pull(skb, len);
> +			if (skb->len > 0) {
> +				skb_queue_head(&bdev->txq, skb);
> +				break;
> +			}
> +
> +			switch (hci_skb_pkt_type(skb)) {
> +			case HCI_COMMAND_PKT:
> +				hdev->stat.cmd_tx++;
> +				break;
> +			case HCI_ACLDATA_PKT:
> +				hdev->stat.acl_tx++;
> +				break;
> +			case HCI_SCODATA_PKT:
> +				hdev->stat.sco_tx++;
> +				break;
> +			}
> +
> +			kfree_skb(skb);
> +		}
> +
> +		if (!test_bit(BTMTKUART_TX_STATE_WAKEUP, &bdev->tx_state))
> +			break;
> +	}
> +
> +	clear_bit(BTMTKUART_TX_STATE_ACTIVE, &bdev->tx_state);
> +}
> +
> +static void btmtkuart_tx_wakeup(struct btmtkuart_dev *bdev)
> +{
> +	if (test_and_set_bit(BTMTKUART_TX_STATE_ACTIVE, &bdev->tx_state))
> +		set_bit(BTMTKUART_TX_STATE_WAKEUP, &bdev->tx_state);
> +
> +	schedule_work(&bdev->tx_work);
> +}
> +

Move btmtkuart_recv and mtk_stp_split above this function to keep them close where they are used.

> +static int btmtkuart_receive_buf(struct serdev_device *serdev, const u8 *data,
> +				 size_t count)
> +{
> +	struct btmtkuart_dev *bdev = serdev_device_get_drvdata(serdev);
> +	int err;
> +
> +	err = btmtkuart_recv(bdev->hdev, data, count);
> +	if (err < 0)
> +		return err;
> +
> +	bdev->hdev->stat.byte_rx += count;
> +
> +	return count;
> +}
> +
> +static void btmtkuart_write_wakeup(struct serdev_device *serdev)
> +{
> +	struct btmtkuart_dev *bdev = serdev_device_get_drvdata(serdev);
> +
> +	btmtkuart_tx_wakeup(bdev);
> +}
> +
> +static const struct serdev_device_ops btmtkuart_client_ops = {
> +	.receive_buf = btmtkuart_receive_buf,
> +	.write_wakeup = btmtkuart_write_wakeup,
> +};
> +
> +static int btmtkuart_open(struct hci_dev *hdev)
> +{
> +	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
> +	struct device *dev;
> +	int err;
> +
> +	err = serdev_device_open(bdev->serdev);
> +	if (err) {
> +		bt_dev_err(hdev, "Unable to open UART device %s",
> +			   dev_name(&bdev->serdev->dev));
> +		goto err_open;
> +	}
> +
> +	dev = &bdev->serdev->dev;
> +
> +	bdev->stp_cursor = 2;
> +	bdev->stp_dlen = 0;
> +
> +	/* Enable the power domain and clock the device requires. */
> +	pm_runtime_enable(dev);
> +	err = pm_runtime_get_sync(dev);
> +	if (err < 0) {
> +		pm_runtime_put_noidle(dev);
> +		goto err_disable_rpm;
> +	}
> +
> +	err = clk_prepare_enable(bdev->clk);
> +	if (err < 0)
> +		goto err_put_rpm;

Add an extra empty line here.

> +	return 0;
> +
> +err_put_rpm:
> +	pm_runtime_put_sync(dev);
> +err_disable_rpm:
> +	pm_runtime_disable(dev);
> +err_open:
> +	return err;
> +}
> +
> +static int btmtkuart_close(struct hci_dev *hdev)
> +{
> +	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
> +	struct device *dev = &bdev->serdev->dev;
> +
> +	/* Shutdown the clock and power domain the device requires. */
> +	clk_disable_unprepare(bdev->clk);
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +
> +	serdev_device_close(bdev->serdev);
> +
> +	return 0;
> +}
> +
> +static int btmtkuart_flush(struct hci_dev *hdev)
> +{
> +	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
> +
> +	/* Flush any pending characters */
> +	serdev_device_write_flush(bdev->serdev);
> +	skb_queue_purge(&bdev->txq);
> +
> +	cancel_work_sync(&bdev->tx_work);
> +
> +	kfree_skb(bdev->rx_skb);
> +	bdev->rx_skb = NULL;

I would assume you want to reset the stp_cursor here as well.

> +
> +	return 0;
> +}
> +
> +static int btmtkuart_setup(struct hci_dev *hdev)
> +{
> +	u8 param = 0x1;
> +	int err = 0;
> +
> +	/* Setup a firmware which the device definitely requires. */
> +	err = mtk_setup_fw(hdev);
> +	if (err < 0)
> +		return err;
> +
> +	/* Activate funciton the firmware providing to. */
> +	err = mtk_hci_wmt_sync(hdev, MTK_WMT_RST, 0x4, 0, 0);
> +	if (err < 0)
> +		return err;
> +
> +	/* Enable Bluetooth protocol. */
> +	err = mtk_hci_wmt_sync(hdev, MTK_WMT_FUNC_CTRL, 0x0, sizeof(param),
> +			       &param);
> +	if (err < 0)
> +		return err;
> +
> +	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);

Since you have your own driver. Just move this after the hdev->manufacturer setting in probe(). There is no need to keep setting this over and over again.

> +
> +	return 0;
> +}
> +
> +static int btmtkuart_shutdown(struct hci_dev *hdev)
> +{
> +	u8 param = 0x0;
> +	int err;
> +
> +	/* Disable the device. */
> +	err = mtk_hci_wmt_sync(hdev, MTK_WMT_FUNC_CTRL, 0x0, sizeof(param),
> +			       &param);
> +
> +	return err;
> +}
> +
> +static int btmtkuart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
> +	struct mtk_stp_hdr *shdr;
> +	struct sk_buff *new_skb;
> +	int dlen;
> +	u8 *p;
> +
> +	/* Prepend skb with frame type */
> +	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
> +	dlen = skb->len;
> +
> +	/* Make sure of STP header at least has 4-bytes free space to fill. */
> +	if (unlikely(skb_headroom(skb) < sizeof(*shdr))) {
> +		new_skb = skb_realloc_headroom(skb, sizeof(*shdr));
> +		kfree_skb(skb);
> +		skb = new_skb;
> +	}
> +
> +	/* Build for STP packet format. */
> +	shdr = skb_push(skb, sizeof(*shdr));
> +	p = (u8 *)shdr;
> +	shdr->prefix = 0x80;
> +	shdr->dlen1 = (dlen & 0xf00) >> 8;
> +	shdr->type = 0;
> +	shdr->dlen2 = dlen & 0xff;
> +	shdr->cs = p[0] + p[1] + p[2];

I would add another comment here that this added the STP trailer. And change the above to mention it adds the STP header.

And you might want to check if there is space for the trailer as well. Otherwise skb_put tends to call BUG() if I remember correctly. I know this is super unlikely since our bt_skb_alloc is pretty large.

> +	skb_put_zero(skb, MTK_STP_TLR_SIZE);

Extra empty line here please.

> +	skb_queue_tail(&bdev->txq, skb);
> +
> +	btmtkuart_tx_wakeup(bdev);
> +	return 0;
> +}
> +
> +static int btmtkuart_probe(struct serdev_device *serdev)
> +{
> +	struct btmtkuart_dev *bdev;
> +	struct hci_dev *hdev;
> +
> +	bdev = devm_kzalloc(&serdev->dev, sizeof(*bdev), GFP_KERNEL);
> +	if (!bdev)
> +		return -ENOMEM;
> +
> +	bdev->clk = devm_clk_get(&serdev->dev, "ref");
> +	if (IS_ERR(bdev->clk))
> +		return PTR_ERR(bdev->clk);
> +
> +	bdev->serdev = serdev;
> +	serdev_device_set_drvdata(serdev, bdev);
> +
> +	serdev_device_set_client_ops(serdev, &btmtkuart_client_ops);
> +
> +	INIT_WORK(&bdev->tx_work, btmtkuart_tx_work);
> +	skb_queue_head_init(&bdev->txq);
> +
> +	/* Initialize and register HCI device */
> +	hdev = hci_alloc_dev();
> +	if (!hdev) {
> +		dev_err(&serdev->dev, "Can't allocate HCI device\n");
> +		return -ENOMEM;
> +	}
> +
> +	bdev->hdev = hdev;
> +
> +	hdev->bus = HCI_UART;
> +	hci_set_drvdata(hdev, bdev);
> +
> +	hdev->open  = btmtkuart_open;
> +	hdev->close = btmtkuart_close;
> +	hdev->flush = btmtkuart_flush;
> +	hdev->setup = btmtkuart_setup;
> +	hdev->shutdown = btmtkuart_shutdown;
> +	hdev->send  = btmtkuart_send_frame;
> +	SET_HCIDEV_DEV(hdev, &serdev->dev);
> +
> +	hdev->manufacturer = 70;
> +
> +	if (hci_register_dev(hdev) < 0) {
> +		dev_err(&serdev->dev, "Can't register HCI device\n");
> +		hci_free_dev(hdev);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static void btmtkuart_remove(struct serdev_device *serdev)
> +{
> +	struct btmtkuart_dev *bdev = serdev_device_get_drvdata(serdev);
> +	struct hci_dev *hdev = bdev->hdev;
> +
> +	hci_unregister_dev(hdev);
> +	hci_free_dev(hdev);
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id mtk_of_match_table[] = {
> +	{ .compatible = "mediatek,mt7622-bluetooth"},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mtk_of_match_table);
> +#endif
> +
> +static struct serdev_device_driver btmtkuart_driver = {
> +	.probe = btmtkuart_probe,
> +	.remove = btmtkuart_remove,
> +	.driver = {
> +		.name = "btmtkuart",
> +		.of_match_table = of_match_ptr(mtk_of_match_table),
> +	},
> +};
> +
> +module_serdev_device_driver(btmtkuart_driver);
> +
> +MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek Bluetooth Serial driver" VERSION);

You are missing a “ ver “ at the end of your string here. Check with modinfo that it looks correct.

> +MODULE_VERSION(VERSION);
> +MODULE_LICENSE("GPL”);

You want to add a MODULE_FIRMWARE here as well.

Regards

Marcel


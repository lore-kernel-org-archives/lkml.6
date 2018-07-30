Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0CC16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B56420890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B56420890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbeG3Rpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:45:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:10171 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726668AbeG3Rph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:45:37 -0400
X-UUID: 1a4232641cdd4dc4b39e0e3d2caabadf-20180731
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1375184479; Tue, 31 Jul 2018 00:09:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 31 Jul 2018 00:09:45 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 31 Jul 2018 00:09:45 +0800
Message-ID: <1532966985.3472.54.camel@mtkswgap22>
Subject: Re: [PATCH v6 3/4] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
From:   Sean Wang <sean.wang@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Jul 2018 00:09:45 +0800
In-Reply-To: <60024004-779E-4E1A-8E1B-799339595A27@holtmann.org>
References: <cover.1532060309.git.sean.wang@mediatek.com>
         <f3a064f86c1da4664a231a40c6cf038cccc758da.1532060309.git.sean.wang@mediatek.com>
         <60024004-779E-4E1A-8E1B-799339595A27@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marcel

All suggestions seem reasonable for me in order to make code style aligned with the other drivers and code better to read,
and it looks like no any big problem, so I'll start to work on the next version immediately.

And I also add a few explanations inline about questions about the diagnostic packet and how hci->shutdown is being made.

On Mon, 2018-07-30 at 15:40 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> > This adds a driver to run on the top of btuart driver for the MediaTek
> > serial protocol based on running H:4, which can enable the built-in
> > Bluetooth device inside MT7622 SoC.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> > drivers/bluetooth/Kconfig     |  11 +
> > drivers/bluetooth/Makefile    |   2 +
> > drivers/bluetooth/btmtkuart.c | 552 ++++++++++++++++++++++++++++++++++++++++++
> > drivers/bluetooth/btmtkuart.h |  83 +++++++
> > 4 files changed, 648 insertions(+)
> > create mode 100644 drivers/bluetooth/btmtkuart.c
> > create mode 100644 drivers/bluetooth/btmtkuart.h
> > 
> > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> > index a164ac4..074737c 100644
> > --- a/drivers/bluetooth/Kconfig
> > +++ b/drivers/bluetooth/Kconfig
> > @@ -74,6 +74,17 @@ config BT_HCIBTSDIO
> > 	  Say Y here to compile support for Bluetooth SDIO devices into the
> > 	  kernel or say M to compile it as module (btsdio).
> > 
> > +config BT_HCIBTUART_MTK
> 
> lets label this BT_MTKUART which is in line with all the others. The HCI prefix is an old leftover for real standard drivers.
> 

okay, I will have BT_MTKUART label for the driver.

> > +	tristate "MediaTek HCI UART driver"
> > +	depends on SERIAL_DEV_BUS
> > +	help
> > +	  MediaTek Bluetooth HCI UART driver.
> > +	  This driver is required if you want to use MediaTek Bluetooth
> > +	  with serial interface.
> > +
> > +	  Say Y here to compile support for MediaTek Bluetooth UART devices
> > +	  into the kernel or say M to compile it as module (btmtkuart).
> > +
> > config BT_HCIUART
> > 	tristate "HCI UART driver"
> > 	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
> > diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> > index 2fb6268..2aea62e 100644
> > --- a/drivers/bluetooth/Makefile
> > +++ b/drivers/bluetooth/Makefile
> > @@ -25,6 +25,8 @@ obj-$(CONFIG_BT_BCM)		+= btbcm.o
> > obj-$(CONFIG_BT_RTL)		+= btrtl.o
> > obj-$(CONFIG_BT_QCA)		+= btqca.o
> > 
> > +obj-$(CONFIG_BT_HCIBTUART_MTK)	+= btmtkuart.o
> > +
> > obj-$(CONFIG_BT_HCIUART_NOKIA)	+= hci_nokia.o
> > 
> > btmrvl-y			:= btmrvl_main.o
> > diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
> > new file mode 100644
> > index 0000000..dd800ac
> > --- /dev/null
> > +++ b/drivers/bluetooth/btmtkuart.c
> > @@ -0,0 +1,552 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2018 MediaTek Inc.
> > +
> > +/*
> > + * Bluetooth support for MediaTek serial devices
> > + *
> > + * Author: Sean Wang <sean.wang@mediatek.com>
> > + *
> > + */
> > +
> > +#include <asm/unaligned.h>
> > +#include <linux/atomic.h>
> > +#include <linux/clk.h>
> > +#include <linux/firmware.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/serdev.h>
> > +#include <linux/skbuff.h>
> > +
> > +#include <net/bluetooth/bluetooth.h>
> > +#include <net/bluetooth/hci_core.h>
> > +
> > +#include "btmtkuart.h"
> > +#include "h4_recv.h"
> > +
> > +static void mtk_stp_reset(struct mtk_stp_splitter *sp)
> > +{
> > +	sp->cursor = 2;
> > +	sp->dlen = 0;
> > +}
> 
> I prefer you make this explicit call out for these. Especially since I think curser and dlen should be just part of bdev struct anyway. I realize you call it twice in your code, but explicit seems clearer to read. Especially if we get rid of the mtk_stp_splitter struct. Just use hdev->stp_cursor and hdev->stp_dlen.
> 

I'll add and use these members directly to and via the bdev struct.

> > +
> > +static const unsigned char *
> > +mtk_stp_split(struct mtk_btuart_dev *bdev, struct mtk_stp_splitter *sp,
> > +	      const unsigned char *data, int count, int *sz_h4)
> > +{
> > +	struct mtk_stp_hdr *shdr;
> > +
> > +	/* The cursor is reset when all the data of STP is consumed out. */
> > +	if (!sp->dlen && sp->cursor >= 6)
> > +		sp->cursor = 0;
> > +
> > +	/* Filling pad until all STP info is obtained. */
> > +	while (sp->cursor < 6 && count > 0) {
> > +		sp->pad[sp->cursor] = *data;
> > +		sp->cursor++;
> > +		data++;
> > +		count--;
> > +	}
> > +
> > +	/* Retrieve STP info and have a sanity check. */
> > +	if (!sp->dlen && sp->cursor >= 6) {
> > +		shdr = (struct mtk_stp_hdr *)&sp->pad[2];
> > +		sp->dlen = shdr->dlen1 << 8 | shdr->dlen2;
> > +
> > +		/* Resync STP when unexpected data is being read. */
> > +		if (shdr->prefix != 0x80 || sp->dlen > 2048) {
> > +			bt_dev_err(bdev->hdev, "stp format unexpect (%d, %d)",
> > +				   shdr->prefix, sp->dlen);
> > +			mtk_stp_reset(sp);
> > +		}
> > +	}
> > +
> > +	/* Directly quit when there's no data found for H4 can process. */
> > +	if (count <= 0)
> > +		return NULL;
> > +
> > +	/* Tranlate to how much the size of data H4 can handle so far. */
> > +	*sz_h4 = min_t(int, count, sp->dlen);
> > +
> > +	/* Update the remaining size of STP packet. */
> > +	sp->dlen -= *sz_h4;
> > +
> > +	/* Data points to STP payload which can be handled by H4. */
> > +	return data;
> > +}
> 
> Can you move this whole function closer to the _recv function that actually uses it. Then we do not have to jump up and down to read the code.
> 

sure, will move the function closer to the _recv function.

> > +
> > +static int mtk_stp_send(struct mtk_btuart_dev *bdev, struct sk_buff *skb)
> > +{
> > +	struct mtk_stp_hdr *shdr;
> > +	struct sk_buff *new_skb;
> > +	int dlen;
> > +
> 
> Add a comment here:
> 
> 	/* Prepend skb with frame type */
> 

sure, will add it.

> > +	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
> > +	dlen = skb->len;
> > +
> > +	/* Make sure of STP header at least has 4-bytes free space to fill. */
> > +	if (unlikely(skb_headroom(skb) < sizeof(*shdr))) {
> > +		new_skb = skb_realloc_headroom(skb, sizeof(*shdr));
> > +		kfree_skb(skb);
> > +		skb = new_skb;
> > +	}
> > +
> > +	/* Build for STP packet format. */
> > +	shdr = skb_push(skb, sizeof(*shdr));
> > +	mtk_make_stp_hdr(shdr, 0, dlen);
> 
> Don’t use a helper function here. You only use it once anyway. Put the code right here. It is not that much and would make the driver simpler to read.
> 

okay, will put the code right here.

> > +	skb_put_zero(skb, MTK_STP_TLR_SIZE);
> > +
> > +	skb_queue_tail(&bdev->txq, skb);
> > +
> > +	return 0;
> > +}
> 
> And actually the while mtk_stp_send function is not needed. Move the logic into btmtkuart_send_frame.
> 

okay, will move the whole code directly into btmtkuart_send_frame.

> > +
> > +static int mtk_hci_wmt_sync(struct hci_dev *hdev, u8 opcode, u8 flag,
> > +			    u16 plen, const void *param)
> > +{
> > +	struct mtk_hci_wmt_cmd wc;
> > +	struct mtk_wmt_hdr *hdr;
> > +	struct sk_buff *skb;
> > +	u32 hlen;
> > +
> > +	hlen = sizeof(*hdr) + plen;
> > +	if (hlen > 255)
> > +		return -EINVAL;
> > +
> > +	hdr = (struct mtk_wmt_hdr *)&wc;
> > +	mtk_make_wmt_hdr(hdr, opcode, plen, flag);
> 
> Same as above. No helper needed.
> 

okay, will put the code right here.

> > +	memcpy(wc.data, param, plen);
> > +
> > +	atomic_inc(&hdev->cmd_cnt);
> > +
> > +	skb = __hci_cmd_sync_ev(hdev, 0xfc6f, hlen, &wc, HCI_VENDOR_PKT,
> > +				HCI_INIT_TIMEOUT);
> > +
> > +	if (IS_ERR(skb)) {
> > +		int err = PTR_ERR(skb);
> > +
> > +		bt_dev_err(hdev, "Failed to send wmt cmd (%d)", err);
> > +		return err;
> > +	}
> > +
> > +	kfree_skb(skb);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_setup_fw(struct hci_dev *hdev)
> > +{
> > +	const struct firmware *fw;
> > +	const char *fwname;
> > +	const u8 *fw_ptr;
> > +	size_t fw_size;
> > +	int err, dlen;
> > +	u8 flag;
> > +
> > +	fwname = FIRMWARE_MT7622;
> > +
> > +	err = request_firmware(&fw, fwname, &hdev->dev);
> > +	if (err < 0) {
> > +		bt_dev_err(hdev, "Failed to load firmware file (%d)", err);
> > +		return err;
> > +	}
> > +
> > +	fw_ptr = fw->data;
> > +	fw_size = fw->size;
> > +
> > +	/* The size of patch header is 30 bytes, should be skip. */
> > +	if (fw_size < 30)
> > +		return -EINVAL;
> > +
> > +	fw_size -= 30;
> > +	fw_ptr += 30;
> > +	flag = 1;
> > +
> > +	while (fw_size > 0) {
> > +		dlen = min_t(int, 250, fw_size);
> > +
> > +		/* Tell deivice the position in sequence. */
> > +		if (fw_size - dlen <= 0)
> > +			flag = 3;
> > +		else if (fw_size < fw->size - 30)
> > +			flag = 2;
> > +
> > +		err = mtk_hci_wmt_sync(hdev, MTK_WMT_PATCH_DWNLD, flag, dlen,
> > +				       fw_ptr);
> > +		if (err < 0)
> > +			break;
> > +
> > +		fw_size -= dlen;
> > +		fw_ptr += dlen;
> > +	}
> > +
> > +	release_firmware(fw);
> > +
> > +	return err;
> > +}
> > +
> > +static int mtk_btuart_hci_frame(struct hci_dev *hdev, struct sk_buff *skb)
> 
> Call this btmtkuart_recv_event then.
> 

okay, it's indeed a better name. I will have a renaming from mtk_btuart_hci_frame to btmtkuart_recv_event

> > +{
> > +	struct hci_event_hdr *hdr = (void *)skb->data;
> > +
> > +	/* Fix up the vendor event id with HCI_VENDOR_PKT instead of
> > +	 * 0xe4 so that btmon can parse the kind of vendor event properly.
> > +	 */
> > +	if (hdr->evt == 0xe4)
> > +		hdr->evt = HCI_VENDOR_PKT;
> 
> Do we want these as HCI vendor events. Or actually as vendor / diagnostic packets. There is a hci_recv_diag.
> 

These are actually Hci vendor events. not for diagnostic purpose. They hdr->evt == 0xe4 are all the part of chip initialization.

> So let me ask this a different way, do you have support for LMP / LL tracing in your chips? If yes, then how is that enabled and how does it work? Or any general debug data that can be switched on. That is what we have a diagnostic channel for that is also fed into btmon.
> 

I'm not really sure about them because I didn't see any diagnostic packets handling in vendor driver.

> > +
> > +	/* Each HCI event would go through the core. */
> > +	return hci_recv_frame(hdev, skb);
> > +}
> > +
> > +static const struct h4_recv_pkt mtk_recv_pkts[] = {
> > +	{ H4_RECV_ACL,      .recv = hci_recv_frame },
> > +	{ H4_RECV_SCO,      .recv = hci_recv_frame },
> > +	{ H4_RECV_EVENT,    .recv = mtk_btuart_hci_frame },
> > +};
> > +
> > +static int mtk_btuart_recv(struct hci_dev *hdev, const u8 *data, size_t count)
> > +{
> 
> Just use btmtkuart_ prefix in this driver to align closer with the driver name.
> 

okay, will use btmtkuart_ prefix.

> > +	struct mtk_btuart_dev *bdev = hci_get_drvdata(hdev);
> > +	const unsigned char *p_left = data, *p_h4;
> > +	int sz_left = count, sz_h4, adv;
> > +	int err;
> > +
> > +	while (sz_left > 0) {
> > +		/*  The serial data received from MT7622 BT controller is
> > +		 *  at all time padded around with the STP header and tailer.
> > +		 *
> > +		 *  A full STP packet is looking like
> > +		 *   -----------------------------------
> > +		 *  | STP header  |  H:4   | STP tailer |
> > +		 *   -----------------------------------
> > +		 *  but it doesn't guarantee to contain a full H:4 packet which
> > +		 *  means that it's possible for multiple STP packets forms a
> > +		 *  full H:4 packet that means extra STP header + length doesn't
> > +		 *  indicate a full H:4 frame, things can fragment. Whose length
> > +		 *  recorded in STP header just shows up the most length the
> > +		 *  H:4 engine can handle currently.
> > +		 */
> > +
> > +		p_h4 = mtk_stp_split(bdev, bdev->sp, p_left, sz_left, &sz_h4);
> > +		if (!p_h4)
> > +			break;
> > +
> > +		adv = p_h4 - p_left;
> > +		sz_left -= adv;
> > +		p_left += adv;
> > +
> > +		bdev->rx_skb = h4_recv_buf(bdev->hdev, bdev->rx_skb, p_h4,
> > +					   sz_h4, mtk_recv_pkts,
> > +					   sizeof(mtk_recv_pkts));
> > +		if (IS_ERR(bdev->rx_skb)) {
> > +			err = PTR_ERR(bdev->rx_skb);
> > +			bt_dev_err(bdev->hdev,
> > +				   "Frame reassembly failed (%d)", err);
> > +			bdev->rx_skb = NULL;
> > +			return err;
> > +		}
> > +
> > +		sz_left -= sz_h4;
> > +		p_left += sz_h4;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void mtk_btuart_tx_work(struct work_struct *work)
> > +{
> > +	struct mtk_btuart_dev *bdev = container_of(work, struct mtk_btuart_dev,
> > +						   tx_work);
> > +	struct serdev_device *serdev = bdev->serdev;
> > +	struct hci_dev *hdev = bdev->hdev;
> > +
> > +	while (1) {
> > +		clear_bit(BTUART_TX_STATE_WAKEUP, &bdev->tx_state);
> 
> You want to name these BTMTKUART_ flags.
> 

okay, will rename these with BTMTKUART_ prefix. 

> > +
> > +		while (1) {
> > +			struct sk_buff *skb = skb_dequeue(&bdev->txq);
> > +			int len;
> > +
> > +			if (!skb)
> > +				break;
> > +
> > +			len = serdev_device_write_buf(serdev, skb->data,
> > +						      skb->len);
> > +			hdev->stat.byte_tx += len;
> > +
> > +			skb_pull(skb, len);
> > +			if (skb->len > 0) {
> > +				skb_queue_head(&bdev->txq, skb);
> > +				break;
> > +			}
> > +
> > +			switch (hci_skb_pkt_type(skb)) {
> > +			case HCI_COMMAND_PKT:
> > +				hdev->stat.cmd_tx++;
> > +				break;
> > +			case HCI_ACLDATA_PKT:
> > +				hdev->stat.acl_tx++;
> > +				break;
> > +			case HCI_SCODATA_PKT:
> > +				hdev->stat.sco_tx++;
> > +				break;
> > +			}
> > +
> > +			kfree_skb(skb);
> > +		}
> > +
> > +		if (!test_bit(BTUART_TX_STATE_WAKEUP, &bdev->tx_state))
> > +			break;
> > +	}
> > +
> > +	clear_bit(BTUART_TX_STATE_ACTIVE, &bdev->tx_state);
> > +}
> > +
> > +static int mtk_btuart_tx_wakeup(struct mtk_btuart_dev *bdev)
> > +{
> > +	if (test_and_set_bit(BTUART_TX_STATE_ACTIVE, &bdev->tx_state)) {
> > +		set_bit(BTUART_TX_STATE_WAKEUP, &bdev->tx_state);
> > +		return 0;
> > +	}
> > +
> > +	schedule_work(&bdev->tx_work);
> > +
> 
> Remove this empty line.
> 

okay, will remove the empty line.

> > +	return 0;
> > +}
> 
> I am not sure why this has a return value. I realize that btuart.c driver has this as well, but I think we should not bother with it.
> 

okay, will drop the return value.

> > +
> > +static int mtk_btuart_receive_buf(struct serdev_device *serdev, const u8 *data,
> > +				  size_t count)
> > +{
> > +	struct mtk_btuart_dev *bdev = serdev_device_get_drvdata(serdev);
> > +	int err;
> > +
> > +	err = mtk_btuart_recv(bdev->hdev, data, count);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	bdev->hdev->stat.byte_rx += count;
> > +
> > +	return count;
> > +}
> > +
> > +static void mtk_btuart_write_wakeup(struct serdev_device *serdev)
> > +{
> > +	struct mtk_btuart_dev *bdev = serdev_device_get_drvdata(serdev);
> > +
> > +	mtk_btuart_tx_wakeup(bdev);
> > +}
> > +
> > +static const struct serdev_device_ops mtk_btuart_client_ops = {
> > +	.receive_buf = mtk_btuart_receive_buf,
> > +	.write_wakeup = mtk_btuart_write_wakeup,
> > +};
> > +
> > +static int mtk_btuart_open(struct hci_dev *hdev)
> > +{
> > +	struct mtk_btuart_dev *bdev = hci_get_drvdata(hdev);
> > +	int err;
> > +
> > +	err = serdev_device_open(bdev->serdev);
> > +	if (err)
> > +		bt_dev_err(hdev, "Unable to open UART device %s",
> > +			   dev_name(&bdev->serdev->dev));
> > +
> > +	return err;
> > +}
> > +
> > +static int mtk_btuart_close(struct hci_dev *hdev)
> > +{
> > +	struct mtk_btuart_dev *bdev = hci_get_drvdata(hdev);
> > +
> > +	serdev_device_close(bdev->serdev);
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_btuart_flush(struct hci_dev *hdev)
> > +{
> > +	struct mtk_btuart_dev *bdev = hci_get_drvdata(hdev);
> > +
> > +	/* Flush any pending characters */
> > +	serdev_device_write_flush(bdev->serdev);
> > +	skb_queue_purge(&bdev->txq);
> > +
> > +	cancel_work_sync(&bdev->tx_work);
> > +
> > +	kfree_skb(bdev->rx_skb);
> > +	bdev->rx_skb = NULL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_btuart_setup(struct hci_dev *hdev)
> > +{
> > +	struct mtk_btuart_dev *bdev = hci_get_drvdata(hdev);
> > +	struct device *dev;
> > +	u8 param = 0x1;
> > +	int err = 0;
> > +
> > +	dev = &bdev->serdev->dev;
> > +
> > +	mtk_stp_reset(bdev->sp);
> > +
> > +	/* Enable the power domain and clock the device requires. */
> > +	pm_runtime_enable(dev);
> > +	err = pm_runtime_get_sync(dev);
> > +	if (err < 0) {
> > +		pm_runtime_put_noidle(dev);
> > +		goto err_disable_rpm;
> > +	}
> > +
> > +	err = clk_prepare_enable(bdev->clk);
> > +	if (err < 0)
> > +		goto err_put_rpm;
> > +
> > +	/* Setup a firmware which the device definitely requires. */
> > +	err = mtk_setup_fw(hdev);
> > +	if (err < 0)
> > +		goto err_clk;
> > +
> > +	/* Activate funciton the firmware providing to. */
> > +	err = mtk_hci_wmt_sync(hdev, MTK_WMT_RST, 0x4, 0, 0);
> > +	if (err < 0)
> > +		goto err_clk;
> > +
> > +	/* Enable Bluetooth protocol. */
> > +	err = mtk_hci_wmt_sync(hdev, MTK_WMT_FUNC_CTRL, 0x0, sizeof(param),
> > +			       &param);
> > +	if (err < 0)
> > +		goto err_clk;
> > +
> > +	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> > +
> > +	return 0;
> > +err_clk:
> > +	clk_disable_unprepare(bdev->clk);
> > +err_put_rpm:
> > +	pm_runtime_put_sync(dev);
> > +err_disable_rpm:
> > +	pm_runtime_disable(dev);
> > +
> > +	return err;
> > +}
> > +
> > +static int mtk_btuart_shutdown(struct hci_dev *hdev)
> > +{
> > +	struct mtk_btuart_dev *bdev = hci_get_drvdata(hdev);
> > +	struct device *dev = &bdev->serdev->dev;
> > +	u8 param = 0x0;
> > +
> > +	/* Disable the device. */
> > +	mtk_hci_wmt_sync(hdev, MTK_WMT_FUNC_CTRL, 0x0, sizeof(param), &param);
> > +
> > +	/* Shutdown the clock and power domain the device requires. */
> > +	clk_disable_unprepare(bdev->clk);
> > +	pm_runtime_put_sync(dev);
> > +	pm_runtime_disable(dev);
> 
> Don’t these belong into ->close method? And the enable ones into ->open? I really think that ->setup and ->shutdown should just do HCI commands and leave the others to ->open and ->close. Since ->open and ->close are suppose to set up and terminate the transport.
> 

Yes, ->open and ->close are already done just for setup and terminate the transport. I've noted the part during earlier version discussion. 

Because mt7622 is a SoC integrating Bluetooth hardware inside, these operations for clk* and pm clk_* and pm_*  you saw here are all for controlling clocks and powers Bluetooth circuits requires on the SoC, not for the transports.

As for clocks for the transport, they're already being taken care of by the serial driver.

> > +
> > +	return 0;
> > +}
> > +
> > +static int mtk_btuart_send(struct hci_dev *hdev, struct sk_buff *skb)
> > +{
> 
> This should be called btmtkuart_send_frame.
> 

okay, will have a rename.

> > +	struct mtk_btuart_dev *bdev = hci_get_drvdata(hdev);
> > +	int err;
> > +
> > +	err = mtk_stp_send(bdev, skb);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	err = mtk_btuart_tx_wakeup(bdev);
> 
> Don’t bother with the return value. Just return 0; here. And skip the extra empty line.
> 

okay, lets dont bother with the return value and skip the extra empty line.

> > +
> > +	return err;
> > +}
> > +
> > +static int mtk_btuart_probe(struct serdev_device *serdev)
> > +{
> > +	struct mtk_btuart_dev *bdev;
> > +	struct hci_dev *hdev;
> > +
> > +	bdev = devm_kzalloc(&serdev->dev, sizeof(*bdev), GFP_KERNEL);
> > +	if (!bdev)
> > +		return -ENOMEM;
> > +
> > +	bdev->sp = devm_kzalloc(&serdev->dev, sizeof(*bdev->sp), GFP_KERNEL);
> > +	if (!bdev->sp)
> > +		return -ENOMEM;
> 
> I do not get this allocation. That makes no sense to me. Just store current cursor and dlen in the data structure.
> 

as above discussion, will keep them directly in bdev struct without extra allocation.

> > +
> > +	bdev->clk = devm_clk_get(&serdev->dev, "ref");
> > +	if (IS_ERR(bdev->clk))
> > +		return PTR_ERR(bdev->clk);
> > +
> > +	bdev->serdev = serdev;
> > +	serdev_device_set_drvdata(serdev, bdev);
> > +
> > +	serdev_device_set_client_ops(serdev, &mtk_btuart_client_ops);
> > +
> > +	INIT_WORK(&bdev->tx_work, mtk_btuart_tx_work);
> > +	skb_queue_head_init(&bdev->txq);
> > +
> > +	/* Initialize and register HCI device */
> > +	hdev = hci_alloc_dev();
> > +	if (!hdev) {
> > +		dev_err(&serdev->dev, "Can't allocate HCI device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	bdev->hdev = hdev;
> > +
> > +	hdev->bus = HCI_UART;
> > +	hdev->manufacturer = 70;
> > +	hci_set_drvdata(hdev, bdev);
> > +
> > +	hdev->open  = mtk_btuart_open;
> > +	hdev->close = mtk_btuart_close;
> > +	hdev->flush = mtk_btuart_flush;
> > +	hdev->setup = mtk_btuart_setup;
> > +	hdev->shutdown = mtk_btuart_shutdown;
> > +	hdev->send  = mtk_btuart_send;
> > +	SET_HCIDEV_DEV(hdev, &serdev->dev);
> 
> Move the hdev->manufacturer = 70; here separated by empty lines.
> 

okay, move setup manufacture code here separated by empty lines.

> > +
> > +	if (hci_register_dev(hdev) < 0) {
> > +		dev_err(&serdev->dev, "Can't register HCI device\n");
> > +		hci_free_dev(hdev);
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void mtk_btuart_remove(struct serdev_device *serdev)
> > +{
> > +	struct mtk_btuart_dev *bdev = serdev_device_get_drvdata(serdev);
> > +	struct hci_dev *hdev = bdev->hdev;
> > +
> > +	hci_unregister_dev(hdev);
> > +	hci_free_dev(hdev);
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id mtk_of_match_table[] = {
> > +	{ .compatible = "mediatek,mt7622-bluetooth"},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mtk_of_match_table);
> > +#endif
> > +
> > +static struct serdev_device_driver mtk_btuart_driver = {
> > +	.probe = mtk_btuart_probe,
> > +	.remove = mtk_btuart_remove,
> > +	.driver = {
> > +		.name = "btmtkuart",
> > +		.of_match_table = of_match_ptr(mtk_of_match_table),
> > +	},
> > +};
> > +
> > +module_serdev_device_driver(mtk_btuart_driver);
> > +
> > +MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
> > +MODULE_DESCRIPTION("MediaTek Bluetooth Serial driver”);
> 
> MODULE_VERSION(VERSION); please like we do with all other drivers.
> 

okay, as do with all other drivers.

> > +MODULE_LICENSE("GPL v2”);
> 
> Can we keep it simple and just use “GPL” here like we do with all the other drivers.
> 

okay, as do with all the other driver.

> > diff --git a/drivers/bluetooth/btmtkuart.h b/drivers/bluetooth/btmtkuart.h
> > new file mode 100644
> > index 0000000..b77d175
> > --- /dev/null
> > +++ b/drivers/bluetooth/btmtkuart.h
> > @@ -0,0 +1,83 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2018 MediaTek Inc.
> > + *
> > + * Bluetooth support for MediaTek serial devices
> > + *
> > + * Author: Sean Wang <sean.wang@mediatek.com>
> > + *
> > + */
> > +
> > +#define FIRMWARE_MT7622		"mediatek/mt7622pr2h.bin"
> > +
> > +#define MTK_STP_TLR_SIZE	2
> > +
> > +#define BTUART_TX_STATE_ACTIVE	1
> > +#define BTUART_TX_STATE_WAKEUP	2
> > +
> > +enum {
> > +	MTK_WMT_PATCH_DWNLD = 0x1,
> > +	MTK_WMT_FUNC_CTRL = 0x6,
> > +	MTK_WMT_RST = 0x7
> > +};
> > +
> > +struct mtk_stp_hdr {
> > +	u8 prefix;
> > +	u8 dlen1:4;
> > +	u8 type:4;
> > +	u8 dlen2;
> > +	u8 cs;
> > +} __packed;
> > +
> > +struct mtk_wmt_hdr {
> > +	u8	dir;
> > +	u8	op;
> > +	__le16	dlen;
> > +	u8	flag;
> > +} __packed;
> > +
> > +struct mtk_hci_wmt_cmd {
> > +	struct mtk_wmt_hdr hdr;
> > +	u8 data[256];
> > +} __packed;
> > +
> > +struct mtk_stp_splitter {
> > +	u8	pad[6];
> > +	u8	cursor;
> > +	u16	dlen;
> > +};
> > +
> > +struct mtk_btuart_dev {
> > +	struct hci_dev *hdev;
> > +	struct serdev_device *serdev;
> > +
> > +	struct work_struct tx_work;
> > +	unsigned long tx_state;
> > +	struct sk_buff_head txq;
> > +
> > +	struct sk_buff *rx_skb;
> > +
> > +	struct mtk_stp_splitter *sp;
> > +	struct clk *clk;
> > +};
> > +
> > +static inline void
> > +mtk_make_stp_hdr(struct mtk_stp_hdr *hdr, u8 type, u32 dlen)
> > +{
> > +	u8 *p = (u8 *)hdr;
> > +
> > +	hdr->prefix = 0x80;
> > +	hdr->dlen1 = (dlen & 0xf00) >> 8;
> > +	hdr->type = type;
> > +	hdr->dlen2 = dlen & 0xff;
> > +	hdr->cs = p[0] + p[1] + p[2];
> > +}
> > +
> > +static inline void
> > +mtk_make_wmt_hdr(struct mtk_wmt_hdr *hdr, u8 op, u16 plen, u8 flag)
> > +{
> > +	hdr->dir = 1;
> > +	hdr->op = op;
> > +	hdr->dlen = cpu_to_le16(plen + 1);
> > +	hdr->flag = flag;
> > +}
> 
> Move all the *.h parts into the *.c file. It is all so simple that there is no need for having this in a header.
> 
> Minor cosmetic changes, but the rest look good to me.
> 

okay, will move whole thing in *.h to *.c and finally I really appreciate your effort on reviewing on these code.

> Regards
> 
> Marcel
> 



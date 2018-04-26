Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754611AbeDZJr7 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 05:47:59 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47161 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753403AbeDZJrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 05:47:55 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v1 6/7] Bluetooth: hci_mediatek: Add protocol support for
 MediaTek serial devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1524728068.12322.125.camel@mtkswgap22>
Date: Thu, 26 Apr 2018 11:47:51 +0200
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0DB4E6C1-28AD-41B7-8623-10046809A686@holtmann.org>
References: <cover.1522736996.git.sean.wang@mediatek.com>
 <f0e0a0b7f1dc3845dc6eafb4ccd60284d1675f8d.1522736996.git.sean.wang@mediatek.com>
 <A7391E5D-2945-415B-8AB1-8DFBF2E65878@holtmann.org>
 <1524728068.12322.125.camel@mtkswgap22>
To: Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

>>> This adds a driver for the MediaTek serial protocol based on H4 protocol,
>>> which can enable the built-in Bluetooth device inside MT7622 SoC.
>>> 
>>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>>> ---
>>> drivers/bluetooth/Kconfig        |  12 +
>>> drivers/bluetooth/Makefile       |   1 +
>>> drivers/bluetooth/hci_mediatek.c | 499 +++++++++++++++++++++++++++++++++++++++
>>> drivers/bluetooth/hci_uart.h     |   3 +-
>>> 4 files changed, 514 insertions(+), 1 deletion(-)
>>> create mode 100644 drivers/bluetooth/hci_mediatek.c
>>> 
>>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>>> index 010f5f5..851f430 100644
>>> --- a/drivers/bluetooth/Kconfig
>>> +++ b/drivers/bluetooth/Kconfig
>>> @@ -104,6 +104,18 @@ config BT_HCIUART_H4
>>> 
>>> 	  Say Y here to compile support for HCI UART (H4) protocol.
>>> 
>>> +config BT_HCIUART_MEDIATEK
>>> +	tristate "MediaTek protocol support"
>>> +	depends on BT_HCIUART_SERDEV
>>> +	select BT_HCIUART_H4
>>> +	help
>>> +	  The MediaTek protocol based on H4 enables patch firmware download and
>>> +	  configuration. This protocol is required for MediaTek Bluetooth
>>> +	  devices with a serial bus such as BTIF, which can be usually found on
>>> +	  various MediaTek SoCs.
>>> +
>>> +	  Say Y here to compile support for MediaTek protocol.
>>> +
>>> config BT_HCIUART_NOKIA
>>> 	tristate "UART Nokia H4+ protocol support"
>>> 	depends on BT_HCIUART
>>> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
>>> index ec16c55..db93c76 100644
>>> --- a/drivers/bluetooth/Makefile
>>> +++ b/drivers/bluetooth/Makefile
>>> @@ -43,5 +43,6 @@ hci_uart-$(CONFIG_BT_HCIUART_INTEL)	+= hci_intel.o
>>> hci_uart-$(CONFIG_BT_HCIUART_BCM)	+= hci_bcm.o
>>> hci_uart-$(CONFIG_BT_HCIUART_QCA)	+= hci_qca.o
>>> hci_uart-$(CONFIG_BT_HCIUART_AG6XX)	+= hci_ag6xx.o
>>> +hci_uart-$(CONFIG_BT_HCIUART_MEDIATEK)  += hci_mediatek.o
>> 
>> we used when available the 3 letter short version of the manufacture. So this would be MTK and hci_mtk.o in this case. Not that I care that much.
>> 
> 
> sure, i can use hci_mtk.o instead of the long one.
> 
>>> hci_uart-$(CONFIG_BT_HCIUART_MRVL)	+= hci_mrvl.o
>>> hci_uart-objs				:= $(hci_uart-y)
>>> diff --git a/drivers/bluetooth/hci_mediatek.c b/drivers/bluetooth/hci_mediatek.c
>>> new file mode 100644
>>> index 0000000..7ac1e7a
>>> --- /dev/null
>>> +++ b/drivers/bluetooth/hci_mediatek.c
>>> @@ -0,0 +1,499 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +// Copyright (c) 2018 MediaTek Inc.
>>> +
>>> +/*
>>> + * Bluetooth HCI Serial driver for MediaTek SoC
>>> + *
>>> + * Author: Sean Wang <sean.wang@mediatek.com>
>>> + *
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/errno.h>
>>> +#include <linux/firmware.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/unaligned/le_struct.h>
>>> +#include <linux/serdev.h>
>>> +#include <linux/skbuff.h>
>>> +#include <linux/types.h>
>>> +#include <net/bluetooth/bluetooth.h>
>>> +#include <net/bluetooth/hci_core.h>
>>> +
>>> +#include "hci_uart.h"
>>> +
>>> +#define FIRMWARE_MT7622		"mediatek/mt7622_patch_firmware.bin”
>> 
>> Has this firmware already been submitted to linux-firmware tree?
>> 
> 
> I didn't submit this firmware yet into linux-firmware. But I will do it
> eventually.
> 
> Currently, it still takes some time to tweak the firmware before make it
> release, so I let driver go first to see if the driver can get any idea
> for becoming better. 
> 
>>> +
>>> +#define MTK_STP_HDR_SIZE	4
>>> +#define MTK_STP_TLR_SIZE	2
>>> +#define MTK_WMT_HDR_SIZE	5
>>> +#define MTK_WMT_CMD_SIZE	(MTK_WMT_HDR_SIZE + MTK_STP_HDR_SIZE + \
>>> +				 MTK_STP_TLR_SIZE + HCI_ACL_HDR_SIZE)
>>> +
>>> +enum {
>>> +	MTK_WMT_PATCH_DWNLD = 0x1,
>>> +	MTK_WMT_FUNC_CTRL = 0x6,
>>> +	MTK_WMT_RST = 0x7
>>> +};
>>> +
>>> +struct mtk_stp_splitter {
>>> +	u8	pad[6];
>>> +	u8	cursor;
>>> +	u16	dlen;
>>> +};
>>> +
>>> +struct mtk_bt_dev {
>>> +	struct hci_uart hu;
>>> +	struct clk *clk;
>>> +	struct sk_buff *rx_skb;
>>> +	struct sk_buff_head txq;
>>> +	struct completion wmt_cmd;
>>> +	struct mtk_stp_splitter *sp;
>>> +};
>>> +
>>> +struct mtk_stp_hdr {
>>> +	__u8 prefix;
>>> +	__u8 dlen1:4;
>>> +	__u8 type:4;
>>> +	__u8 dlen2:8;
>>> +	__u8 cs;
>>> +} __packed;
>>> +
>>> +struct mtk_wmt_hdr {
>>> +	__u8	dir;
>>> +	__u8	op;
>>> +	__le16	dlen;
>>> +	__u8	flag;
>>> +} __packed;
>>> +
>>> +static void mtk_stp_reset(struct mtk_stp_splitter *sp)
>>> +{
>>> +	sp->cursor = 2;
>>> +	sp->dlen = 0;
>>> +}
>>> +
>>> +static const unsigned char *
>>> +mtk_stp_split(struct device *dev, struct mtk_stp_splitter *sp,
>>> +	      const unsigned char *data, int count, int *sz_h4)
>>> +{
>>> +	struct mtk_stp_hdr *shdr;
>>> +
>>> +	/* The cursor is reset when all the data of STP is being consumed. */
>>> +	if (!sp->dlen && sp->cursor >= 6)
>>> +		sp->cursor = 0;
>>> +
>>> +	/* Filling pad until all STP info is obtained. */
>>> +	while (sp->cursor < 6 && count > 0) {
>>> +		sp->pad[sp->cursor] = *data;
>>> +		sp->cursor++;
>>> +		data++;
>>> +		count--;
>>> +	}
>>> +
>>> +	/* Retrieve STP info and have a sanity check. */
>>> +	if (!sp->dlen && sp->cursor >= 6) {
>>> +		shdr = (struct mtk_stp_hdr *)&sp->pad[2];
>>> +		sp->dlen = shdr->dlen1 << 8 | shdr->dlen2;
>>> +
>>> +		/* Resync STP when unexpected data is being read. */
>>> +		if (shdr->prefix != 0x80 || sp->dlen > 2048) {
>>> +			dev_err(dev, "stp format unexpect (%d, %d)",
>>> +				shdr->prefix, sp->dlen);
>>> +			mtk_stp_reset(sp);
>>> +		}
>>> +	}
>>> +
>>> +	/* Directly leave when there's no data found for H4 can process. */
>>> +	if (count <= 0)
>>> +		return NULL;
>>> +
>>> +	/* Tranlate to how much the size of data H4 can handle so far. */
>>> +	*sz_h4 = min_t(int, count, sp->dlen);
>>> +	/* Update remaining the size of STP packet. */
>>> +	sp->dlen -= *sz_h4;
>>> +
>>> +	/* Data points to STP payload which can be handled by H4. */
>>> +	return data;
>>> +}
>>> +
>>> +static void mtk_stp_hdr_build(struct mtk_stp_hdr *shdr, u8 type, u32 dlen)
>>> +{
>>> +	__u8 *p = (__u8 *)shdr;
>>> +
>>> +	shdr->prefix = 0x80;
>>> +	shdr->dlen1 = (dlen & 0xf00) >> 8;
>>> +	shdr->type = type;
>>> +	shdr->dlen2 = dlen & 0xff;
>>> +	shdr->cs = (p[0] + p[1] + p[2]) & 0xff;
>>> +}
>>> +
>>> +static int mtk_enqueue(struct hci_uart *hu, struct sk_buff *skb)
>>> +{
>>> +	struct mtk_bt_dev *btdev = hu->priv;
>>> +	struct mtk_stp_hdr *shdr;
>>> +	struct sk_buff *new_skb;
>>> +	int dlen;
>>> +
>>> +	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
>>> +	dlen = skb->len;
>>> +
>>> +	/* Make sure of STP header at least has 4-bytes free space to fill. */
>>> +	if (unlikely(skb_headroom(skb) < MTK_STP_HDR_SIZE)) {
>>> +		new_skb = skb_realloc_headroom(skb, MTK_STP_HDR_SIZE);
>>> +		kfree_skb(skb);
>>> +		skb = new_skb;
>>> +	}
>>> +
>>> +	/* Build for STP packet format. */
>>> +	shdr = skb_push(skb, MTK_STP_HDR_SIZE);
>>> +	mtk_stp_hdr_build(shdr, 0, dlen);
>>> +	skb_put_zero(skb, MTK_STP_TLR_SIZE);
>>> +
>>> +	skb_queue_tail(&btdev->txq, skb);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int mtk_wmt_cmd_sync(struct hci_uart *hu, u8 opcode, u8 flag, u16 plen,
>>> +			    const void *param)
>>> +{
>>> +	struct mtk_bt_dev *btdev = hu->priv;
>>> +	struct hci_command_hdr *hhdr;
>>> +	struct hci_acl_hdr *ahdr;
>>> +	struct mtk_wmt_hdr *whdr;
>>> +	struct sk_buff *skb;
>>> +	int ret = 0;
>>> +
>>> +	init_completion(&btdev->wmt_cmd);
>>> +
>>> +	skb = bt_skb_alloc(plen + MTK_WMT_CMD_SIZE, GFP_KERNEL);
>>> +	if (!skb)
>>> +		return -ENOMEM;
>>> +
>>> +	/*
>>> +	 * WMT data is carried in either ACL or HCI format with op code as
>>> +	 * 0xfc6f and followed by a WMT header and its actual payload.
>>> +	 */
>> 
>> Please use net subsystem comment style.
>> 
> 
> Sure, I will use net subsystem comment style.
> 
>>> +	switch (opcode) {
>>> +	case MTK_WMT_PATCH_DWNLD:
>>> +		ahdr = skb_put(skb, HCI_ACL_HDR_SIZE);
>>> +		ahdr->handle = cpu_to_le16(0xfc6f);
>>> +		ahdr->dlen   = cpu_to_le16(plen + MTK_WMT_HDR_SIZE);
>>> +		break;
>>> +	default:
>>> +		hhdr = skb_put(skb, HCI_COMMAND_HDR_SIZE);
>>> +		hhdr->opcode = cpu_to_le16(0xfc6f);
>>> +		hhdr->plen = plen + MTK_WMT_HDR_SIZE;
>>> +		break;
>>> +	}
>>> +
>>> +	hci_skb_pkt_type(skb) = opcode == MTK_WMT_PATCH_DWNLD ?
>>> +				HCI_ACLDATA_PKT : HCI_COMMAND_PKT;
>> 
>> Why not move that into the switch statement above.
>> 
> 
> Sure, I will merge it into the switch statement.
> 
>>> +
>>> +	/* Start to build a WMT header and its actual payload. */
>>> +	whdr = skb_put(skb, MTK_WMT_HDR_SIZE);
>>> +	whdr->dir = 1;
>>> +	whdr->op = opcode;
>>> +	whdr->dlen = cpu_to_le16(plen + 1);
>>> +	whdr->flag = flag;
>>> +	skb_put_data(skb, param, plen);
>>> +
>>> +	mtk_enqueue(hu, skb);
>>> +	hci_uart_tx_wakeup(hu);
>>> +
>>> +	/*
>>> +	 * Waiting a WMT event response, while we must take care in case of
>>> +	 * failures for the wait.
>>> +	 */
>>> +	ret = wait_for_completion_interruptible_timeout(&btdev->wmt_cmd, HZ);
>>> +
>>> +	return ret > 0 ? 0 : ret < 0 ? ret : -ETIMEDOUT;
>>> +}
>> 
>> All in all I am not convinced that this is super clean. I get that we need something special for having this in the ACL data packets, but for the standard HCI command I prefer that __hci_cmd_sync is used. I addition, it seems that patch download is the only special case and that happens before at the setup stage. So we could make things special for that. I need to understand this a bit better. Can I get a btmon -w trace.log file from the whole init procedure.
>> 
>> 
> 
> I can try to use __hci_cmd_sync to send those chip-specific hci commands
> which only can be recognized by the chip, but no meaningful to bluez
> core.
> 
> Is btmon able to capture these cmd/evt between driver and device?
> 
> my question's caused by that mtk_wmt_cmd_sync and its events only happen
> between driver and device,  it doesn't go to core.

for Intel, Broadcom, Qualcomm, Realtek etc. we use __hci_cmd_sync() in the ->setup() callback and it will show up in btmon. For at least Intel and Broadcom, btmon will decode them as well. You can hint the manufacturer id out of band it will be told to btmon. And that is also how I want it. If it is using HCI as transport, I want it to go through the Bluetooth core.

>>> +
>>> +static int mtk_setup_fw(struct hci_uart *hu)
>>> +{
>>> +	struct mtk_bt_dev *btdev = hu->priv;
>>> +	const struct firmware *fw;
>>> +	struct device *dev;
>>> +	const char *fwname;
>>> +	const u8 *fw_ptr;
>>> +	size_t fw_size;
>>> +	int err, dlen;
>>> +	u8 flag;
>>> +
>>> +	dev = &hu->serdev->dev;
>>> +	fwname = FIRMWARE_MT7622;
>>> +
>>> +	init_completion(&btdev->wmt_cmd);
>>> +
>>> +	err = request_firmware(&fw, fwname, dev);
>>> +	if (err < 0) {
>>> +		dev_err(dev, "%s: Failed to load firmware file (%d)",
>>> +			hu->hdev->name, err);
>>> +		return err;
>>> +	}
>>> +
>>> +	fw_ptr = fw->data;
>>> +	fw_size = fw->size;
>>> +
>>> +	/* The size of a patch header at least has 30 bytes. */
>>> +	if (fw_size < 30)
>>> +		return -EINVAL;
>>> +
>>> +	while (fw_size > 0) {
>>> +		dlen = min_t(int, 1000, fw_size);
>>> +
>>> +		/* Tell deivice the position in sequence. */
>>> +		flag = (fw_size - dlen <= 0) ? 3 :
>>> +		       (fw_size < fw->size) ? 2 : 1;
>>> +
>>> +		err = mtk_wmt_cmd_sync(hu, MTK_WMT_PATCH_DWNLD, flag,
>>> +				       dlen, fw_ptr);
>>> +		if (err < 0)
>>> +			break;
>>> +
>>> +		fw_size -= dlen;
>>> +		fw_ptr += dlen;
>>> +	}
>>> +
>>> +	release_firmware(fw);
>>> +
>>> +	return err;
>>> +}
>>> +
>>> +static int mtk_open(struct hci_uart *hu)
>>> +{
>>> +	struct mtk_bt_dev *btdev = hu->priv;
>>> +	struct device *dev;
>>> +	int err = 0;
>>> +
>>> +	dev = &hu->serdev->dev;
>>> +
>>> +	serdev_device_open(hu->serdev);
>>> +	skb_queue_head_init(&btdev->txq);
>>> +
>>> +	/* Setup the usage of H4. */
>>> +	hu->alignment = 1;
>>> +	hu->padding = 0;
>>> +	mtk_stp_reset(btdev->sp);
>>> +
>>> +	/* Enable the power domain and clock the device requires */
>>> +	pm_runtime_enable(dev);
>>> +	err = pm_runtime_get_sync(dev);
>>> +	if (err < 0) {
>>> +		pm_runtime_disable(dev);
>>> +		return err;
>>> +	}
>>> +
>>> +	err = clk_prepare_enable(btdev->clk);
>>> +	if (err < 0) {
>>> +		pm_runtime_put_sync(dev);
>>> +		pm_runtime_disable(dev);
>>> +	}
>>> +
>>> +	return err;
>>> +}
>>> +
>>> +static int mtk_close(struct hci_uart *hu)
>>> +{
>>> +	struct mtk_bt_dev *btdev = hu->priv;
>>> +	struct device *dev = &hu->serdev->dev;
>>> +	u8 param = 0x0;
>>> +
>>> +	skb_queue_purge(&btdev->txq);
>>> +	kfree_skb(btdev->rx_skb);
>>> +
>>> +	/* Disable the device. */
>>> +	mtk_wmt_cmd_sync(hu, MTK_WMT_FUNC_CTRL, 0x0, sizeof(param), &param);
>> 
>> Wouldn’t this require a enable device in open callback?
>> 
> 
> It's another story ...
> 
> At initial time I began working on the driver. I indeed made the
> mtk_open and mtk_close be consistent, but it's required a few patches
> for core to solve a problem: 
> 
> The problem is that hci_uart resource CAN'T be used in mtk_open to send
> these specific command taking to the chip since hci_uart_proto->open()
> would be called much earlier in hci_uart_register_device at which
> hci_uart is even not being allocated yet. 
> 
> So, in the first version I want to make thing be simple, instead, I only
> hold mtk_open is doing platform stuff such as clock enablement, and
> power enablement and any other thing about configuring chip all is moved
> to setup handler.

You are also not suppose to be sending HCI commands to close the transport in close(). In close() you are suppose to close the transport. You can use shutdown() if there more commands needed. And setup() if for HCI commands after registration.

Using hci_uart has a bit of legacy in it due to the line discipline. Maybe using btuart.c (which I posted) might be a better starting point since then you hook directly into it as a plain HCI driver.

That all said, I have no issues with extending the core driver framework. I rather do that than having drivers hack around it. That always ends badly.

> 
>>> +
>>> +	/* Shutdown the clock and power domain the device requires. */
>>> +	clk_disable_unprepare(btdev->clk);
>>> +
>>> +	pm_runtime_put_sync(dev);
>>> +	pm_runtime_disable(dev);
>>> +
>>> +	serdev_device_close(hu->serdev);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +int mtk_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
>>> +{
>>> +	struct hci_event_hdr *hdr = (void *)skb->data;
>>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>>> +	struct mtk_bt_dev *btdev = hu->priv;
>>> +
>>> +	if (hci_skb_pkt_type(skb) == HCI_EVENT_PKT &&
>>> +	    hdr->evt == 0xe4) {
>>> +		complete(&btdev->wmt_cmd);
>>> +		kfree_skb(skb);
>>> +		return 0;
>>> +	}
>>> +
>>> +	return hci_recv_frame(hdev, skb);
>>> +}
>> 
>> actually this is overdoing it. You can use hci_recv_frame for ACL and SCO and just a special one for events. However all in all I question the need for the special handling anyway. As I said above, I have the feeling this can be done via __hci_cmd_sync or __hci_cmd_sync_ev. So I really like to see a btmon -w trace.log for these so that I can see how they look.
> 
> in the next version, I would only use a special way for events; ACL and
> SCO can just use a generic way. 
> 
> BTW, add more words for the mtk_recv_frame what it's doing for
> 
> * The special handling with hdr->evt 0xe4 in mtk_recv_frame is
> corresponding to mtk_wmt_cmd_sync.
> 
> * It is expected to not to propagate the chip-specific events to bluez
> core since it's only meaningful data between driver and device.

No, HCI vendor commands and events can happily go through the core. I actually prefer it that way. Mind you that the core HCI handling is rock solid. So trying to hack around it will just lead to bugs. And no other manufacturer is doing that.

>>> +
>>> +static const struct h4_recv_pkt mtk_recv_pkts[] = {
>>> +	{ H4_RECV_ACL,		.recv = mtk_recv_frame },
>>> +	{ H4_RECV_SCO,		.recv = mtk_recv_frame },
>>> +	{ H4_RECV_EVENT,	.recv = mtk_recv_frame },
>>> +};
>>> +
>>> +static int mtk_recv(struct hci_uart *hu, const void *data, int count)
>>> +{
>>> +	const unsigned char *p_left = data, *p_h4;
>>> +	struct mtk_bt_dev *btdev = hu->priv;
>>> +	int sz_left = count, sz_h4, adv;
>>> +	struct device *dev;
>>> +	int err;
>>> +
>>> +	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
>>> +		return -EUNATCH;
>>> +
>>> +	dev = &hu->serdev->dev;
>>> +
>>> +	while (sz_left > 0) {
>>> +		p_h4 = mtk_stp_split(dev, btdev->sp, p_left, sz_left, &sz_h4);
>>> +		if (!p_h4)
>>> +			break;
>> 
>> Now this is troubling me a bit. While there are some H:4 frames somewhere in here, you need to do another set of framing. So what is the framing that comes from the serial part in the first place?
>> 
> 
> the chip always adds a fews bytes before and after the H:4 data, it's
> something like that.
> 
> -------------------------------------  
> | STP header  |  H:4   | STP tailer |  
> -------------------------------------  
> 
> mtk_stp_split no looked into the details of H:4, only is used to find
> where is the start of H:4 part and keep info. from STP header and then
> feed the H:4 part into h4_recv_buf to reuse the extent logic to process
> HCI/ACL/SCO pkts. So, I think it should be unnecessary to create a new
> framing for the current usage.

I would disagree right now. I think taking btuart.c and writing your own driver might be a lot simpler. You have less legacy and you have less things to hack around.

If you have framing around H:4 packets anyway, then why bother trying to use h4_recv_buf anyway (which you could even from a separate driver, see bpa10x.c). The reason behind h4_recv_buf is that we have no framing and need to understand H:4 to find the end of a packet. If you know it, then there is not point in that (see bfusb.c driver).

>> Btw. it is fine if hci_uart is not a good fit. I actually think it is a bad fit and using the btuart driver I send around a few weeks ago is a better starting point. However if the framing itself is more elaborate actually, then even a brand new driver and just re-using h4_recv.h would be good. If however the extra framing already does a real framing job, then even h4_recv.h is useless and we can just pick the frames right out of serial device. For example bfusb.c had such an extra framing on top of H:4.
> 
> 
> 
>>> +
>>> +		adv = p_h4 - p_left;
>>> +		sz_left -= adv;
>>> +		p_left += adv;
>>> +
>>> +		btdev->rx_skb = h4_recv_buf(hu->hdev, btdev->rx_skb,
>>> +					    p_h4, sz_h4, mtk_recv_pkts,
>>> +					    ARRAY_SIZE(mtk_recv_pkts));
>>> +		if (IS_ERR(btdev->rx_skb)) {
>>> +			err = PTR_ERR(btdev->rx_skb);
>>> +			dev_err(dev, "Frame reassembly failed (%d)", err);
>>> +			btdev->rx_skb = NULL;
>>> +			return err;
>>> +		}
>>> +
>>> +		sz_left -= sz_h4;
>>> +		p_left += sz_h4;
>>> +	}
>>> +
>>> +	return count;
>>> +}
>>> +
>>> +static struct sk_buff *mtk_dequeue(struct hci_uart *hu)
>>> +{
>>> +	struct mtk_bt_dev *btdev = hu->priv;
>>> +
>>> +	return skb_dequeue(&btdev->txq);
>>> +}
>>> +
>>> +static int mtk_flush(struct hci_uart *hu)
>>> +{
>>> +	struct mtk_bt_dev *btdev = hu->priv;
>>> +
>>> +	skb_queue_purge(&btdev->txq);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int mtk_setup(struct hci_uart *hu)
>>> +{
>>> +	struct device *dev;
>>> +	u8 param = 0x1;
>>> +	int err;
>>> +
>>> +	dev = &hu->serdev->dev;
>>> +
>>> +	/* Setup a firmware which the device definitely requires. */
>>> +	err = mtk_setup_fw(hu);
>>> +	if (err < 0) {
>>> +		dev_err(dev, "Fail at setup FW (%d): %d", __LINE__, err);
>>> +		return err;
>>> +	}
>>> +
>>> +	/* Activate funciton the firmware provides to. */
>>> +	err = mtk_wmt_cmd_sync(hu, MTK_WMT_RST, 0x4, 0, 0);
>>> +	if (err < 0) {
>>> +		dev_err(dev, "Fail at WMT RST (%d): %d", __LINE__, err);
>>> +		return err;
>>> +	}
>>> +
>>> +	/* Enable Bluetooth protocol. */
>>> +	err = mtk_wmt_cmd_sync(hu, MTK_WMT_FUNC_CTRL, 0x0, sizeof(param),
>>> +			       &param);
>>> +	if (err < 0)
>>> +		dev_err(dev, "Fail at FUNC CTRL (%d): %d", __LINE__, err);
>> 
>> Just as a reminder, setup callback is only called once. You should enable the transport in open callback.
>> 
> 
> If capable, I would like to move all chip initialization stuff to
> mtk_open and de-initialization stuff to mtk_close.

So open/close is for establishing the HCI transport. Sending commands there is something we have not yet encountered.

> In that way, a user power up/down with bluetoothctl or hcitool can
> completely recover the chip from any fatal errors. and even it seem at
> bluez core, there's workqueue in charge of recovery thing.
> 
> But the core seems not supports me to move chip handling in
> mtk_open :-( 

What do you need for your driver. On every power on, you need to execute a HCI command to enable the chip? Do you need to re-load the firmware or does it survive a power down/up cycle?

> 
>>> +
>>> +	return err;
>>> +}
>>> +
>>> +static const struct hci_uart_proto mtk_proto = {
>>> +	.id		= HCI_UART_MTK,
>>> +	.name		= "MediaTek",
>>> +	.open		= mtk_open,
>>> +	.close		= mtk_close,
>>> +	.recv		= mtk_recv,
>>> +	.enqueue	= mtk_enqueue,
>>> +	.dequeue	= mtk_dequeue,
>>> +	.flush		= mtk_flush,
>>> +	.setup		= mtk_setup,
>>> +	.manufacturer	= 1,
>> 
>> Unless you are Nokia, this id is wrong.
>> 
> 
> okay, i will remove it 
> 
>>> +};
>>> +
>>> +static int mtk_bluetooth_serdev_probe(struct serdev_device *serdev)
>>> +{
>>> +	struct device *dev = &serdev->dev;
>>> +	struct mtk_bt_dev *btdev;
>>> +	int err = 0;
>>> +
>>> +	btdev = devm_kzalloc(dev, sizeof(*btdev), GFP_KERNEL);
>>> +	if (!btdev)
>>> +		return -ENOMEM;
>>> +
>>> +	btdev->sp = devm_kzalloc(dev, sizeof(*btdev->sp), GFP_KERNEL);
>>> +	if (!btdev->sp)
>>> +		return -ENOMEM;
>>> +
>>> +	btdev->clk = devm_clk_get(dev, "ref");
>>> +	if (IS_ERR(btdev->clk))
>>> +		return PTR_ERR(btdev->clk);
>>> +
>>> +	btdev->hu.serdev = serdev;
>>> +	btdev->hu.priv = btdev;
>>> +
>>> +	serdev_device_set_drvdata(serdev, btdev);
>>> +
>>> +	err = hci_uart_register_device(&btdev->hu, &mtk_proto);
>>> +	if (err)
>>> +		dev_err(dev, "Could not register bluetooth uart: %d", err);
>>> +
>>> +	return err;
>>> +}
>>> +
>>> +static void mtk_bluetooth_serdev_remove(struct serdev_device *serdev)
>>> +{
>>> +	struct mtk_bt_dev *btdev = serdev_device_get_drvdata(serdev);
>>> +
>>> +	hci_uart_unregister_device(&btdev->hu);
>>> +}
>>> +
>>> +static const struct of_device_id mtk_bluetooth_of_match[] = {
>>> +	{ .compatible = "mediatek,mt7622-bluetooth" },
>>> +	{},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, mtk_bluetooth_of_match);
>>> +
>>> +static struct serdev_device_driver mtk_bluetooth_serdev_driver = {
>>> +	.probe = mtk_bluetooth_serdev_probe,
>>> +	.remove = mtk_bluetooth_serdev_remove,
>>> +	.driver = {
>>> +		.name = "mediatek-bluetooth",
>>> +		.of_match_table = of_match_ptr(mtk_bluetooth_of_match),
>>> +	},
>>> +};
>>> +
>>> +module_serdev_device_driver(mtk_bluetooth_serdev_driver);
>>> +
>>> +MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
>>> +MODULE_DESCRIPTION("Bluetooth HCI Serial driver for MediaTek SoC");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
>>> index 66e8c68..3f0911e 100644
>>> --- a/drivers/bluetooth/hci_uart.h
>>> +++ b/drivers/bluetooth/hci_uart.h
>>> @@ -35,7 +35,7 @@
>>> #define HCIUARTGETFLAGS		_IOR('U', 204, int)
>>> 
>>> /* UART protocols */
>>> -#define HCI_UART_MAX_PROTO	12
>>> +#define HCI_UART_MAX_PROTO	13
>>> 
>>> #define HCI_UART_H4	0
>>> #define HCI_UART_BCSP	1
>>> @@ -49,6 +49,7 @@
>>> #define HCI_UART_AG6XX	9
>>> #define HCI_UART_NOKIA	10
>>> #define HCI_UART_MRVL	11
>>> +#define HCI_UART_MTK	12
>> 
>> I am really trying to avoid new id assignments here and go for serdev only drivers.
>> 
> 
> it seems no necessary for a serdev device. can i remove it from driver?
> but what id should be filled in hci_uart_proto ?
> 
> 430 static const struct hci_uart_proto mtk_proto = {
> 431         .id             = HCI_UART_MTK,
> 432         .name           = "MediaTek",
> 433         .open           = mtk_open,

We can work on something to allow an unassigned id here, but I still feel that you should go for a separate driver in the first place.

If you only have a hammer, then everything looks like a nail. hci_uart being the hammer here. I think you would be better served with starting with btuart.c and then evolve it into your own driver. Try that and see where your problems are.

Regards

Marcel

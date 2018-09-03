Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A984C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA6420862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA6420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeICS3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:29:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12286 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727286AbeICS27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:28:59 -0400
X-UUID: c0e6e669655c4019bae9ce604d50a147-20180903
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1271844864; Mon, 03 Sep 2018 22:08:27 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 3 Sep 2018 22:08:25 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 3 Sep 2018 22:08:25 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v4 1/2] Bluetooth: mediatek: Add protocol support for MediaTek MT7668U USB devices
Date:   Mon, 3 Sep 2018 22:08:23 +0800
Message-ID: <c49bb6dc440e9277ce4a6e94ec2a95d13f7d3023.1535983416.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1535983416.git.sean.wang@mediatek.com>
References: <cover.1535983416.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This adds the support of enabling MT7668U Bluetooth function running
on the top of btusb driver.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below.

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
D:  Ver= 3.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS= 9 #Cfgs=  1
P:  Vendor=0e8d ProdID=7668 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=160mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/Kconfig |  11 +
 drivers/bluetooth/btusb.c | 547 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 558 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 2df11cc..6c34858 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -52,6 +52,17 @@ config BT_HCIBTUSB_BCM
 
 	  Say Y here to compile support for Broadcom protocol.
 
+config BT_HCIBTUSB_MTK
+	bool "MediaTek protocol support"
+	depends on BT_HCIBTUSB
+	default n
+	help
+	  The MediaTek protocol support enables firmware download
+	  support and chip initialization for MediaTek Bluetooth
+	  USB controllers.
+
+	  Say Y here to compile support for MediaTek protocol.
+
 config BT_HCIBTUSB_RTL
 	bool "Realtek protocol support"
 	depends on BT_HCIBTUSB
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index cd2e5cf..c29d12e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -26,6 +26,7 @@
 #include <linux/usb.h>
 #include <linux/usb/quirks.h>
 #include <linux/firmware.h>
+#include <linux/iopoll.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/suspend.h>
@@ -69,6 +70,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_BCM2045		0x40000
 #define BTUSB_IFNUM_2		0x80000
 #define BTUSB_CW6622		0x100000
+#define BTUSB_MEDIATEK		0x200000
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -358,6 +360,10 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
 	  .driver_info = BTUSB_REALTEK },
 
+	/* MediaTek Bluetooth devices */
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x0e8d, 0xe0, 0x01, 0x01),
+	  .driver_info = BTUSB_MEDIATEK },
+
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3394), .driver_info = BTUSB_REALTEK },
@@ -437,6 +443,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_BOOTING		9
 #define BTUSB_DIAG_RUNNING	10
 #define BTUSB_OOB_WAKE_ENABLED	11
+#define BTUSB_TX_WAIT_VND_EVT	12
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -460,6 +467,7 @@ struct btusb_data {
 	struct usb_anchor bulk_anchor;
 	struct usb_anchor isoc_anchor;
 	struct usb_anchor diag_anchor;
+	struct usb_anchor ctrl_anchor;
 	spinlock_t rxlock;
 
 	struct sk_buff *evt_skb;
@@ -1178,6 +1186,7 @@ static void btusb_stop_traffic(struct btusb_data *data)
 	usb_kill_anchored_urbs(&data->bulk_anchor);
 	usb_kill_anchored_urbs(&data->isoc_anchor);
 	usb_kill_anchored_urbs(&data->diag_anchor);
+	usb_kill_anchored_urbs(&data->ctrl_anchor);
 }
 
 static int btusb_close(struct hci_dev *hdev)
@@ -2398,6 +2407,534 @@ static int btusb_shutdown_intel(struct hci_dev *hdev)
 	return 0;
 }
 
+#ifdef CONFIG_BT_HCIBTUSB_MTK
+
+#define FIRMWARE_MT7668		"mt7668pr2h.bin"
+
+#define HCI_WMT_MAX_EVENT_SIZE		64
+
+enum {
+	BTMTK_WMT_PATCH_DWNLD = 0x1,
+	BTMTK_WMT_FUNC_CTRL = 0x6,
+	BTMTK_WMT_RST = 0x7,
+	BTMTK_WMT_SEMAPHORE = 0x17,
+};
+
+enum {
+	BTMTK_WMT_INVALID,
+	BTMTK_WMT_PATCH_UNDONE,
+	BTMTK_WMT_PATCH_DONE,
+	BTMTK_WMT_ON_UNDONE,
+	BTMTK_WMT_ON_DONE,
+	BTMTK_WMT_ON_PROGRESS,
+};
+
+struct btmtk_wmt_hdr {
+	u8	dir;
+	u8	op;
+	__le16	dlen;
+	u8	flag;
+} __packed;
+
+struct btmtk_hci_wmt_cmd {
+	struct btmtk_wmt_hdr hdr;
+	u8 data[256];
+} __packed;
+
+struct btmtk_hci_wmt_evt {
+	struct hci_event_hdr hhdr;
+	struct btmtk_wmt_hdr whdr;
+} __packed;
+
+struct btmtk_hci_wmt_evt_funcc {
+	struct btmtk_hci_wmt_evt hwhdr;
+	__be16 status;
+} __packed;
+
+struct btmtk_hci_wmt_params {
+	u8 op;
+	u8 flag;
+	u16 dlen;
+	const void *data;
+	u32 *status;
+};
+
+static void btusb_mtk_wmt_recv(struct urb *urb)
+{
+	struct hci_dev *hdev = urb->context;
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct hci_event_hdr *hdr;
+	struct sk_buff *skb;
+	int err;
+
+	if (urb->status == 0 && urb->actual_length > 0) {
+		hdev->stat.byte_rx += urb->actual_length;
+
+		/* WMT event shouldn't be fragmented and the size should be
+		 * less than HCI_WMT_MAX_EVENT_SIZE.
+		 */
+		skb = bt_skb_alloc(HCI_WMT_MAX_EVENT_SIZE, GFP_ATOMIC);
+		if (!skb) {
+			hdev->stat.err_rx++;
+			goto err_out;
+		}
+
+		hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
+		skb_put_data(skb, urb->transfer_buffer, urb->actual_length);
+
+		hdr = (void *)skb->data;
+		/* Fix up the vendor event id with 0xff for vendor specific
+		 * instead of 0xe4 so that event send via monitoring socket can
+		 * be parsed properly.
+		 */
+		hdr->evt = 0xff;
+
+		/* When someone waits for the WMT event, the skb is being cloned
+		 * and being processed the events from there then.
+		 */
+		if (test_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags)) {
+			data->evt_skb = skb_clone(skb, GFP_KERNEL);
+			if (!data->evt_skb)
+				goto err_out;
+		}
+
+		err = hci_recv_frame(hdev, skb);
+		if (err < 0)
+			goto err_free_skb;
+
+		if (test_and_clear_bit(BTUSB_TX_WAIT_VND_EVT,
+				       &data->flags)) {
+			/* Barrier to sync with other CPUs */
+			smp_mb__after_atomic();
+			wake_up_bit(&data->flags,
+				    BTUSB_TX_WAIT_VND_EVT);
+		}
+err_out:
+		return;
+err_free_skb:
+		kfree_skb(data->evt_skb);
+		data->evt_skb = NULL;
+		return;
+	} else if (urb->status == -ENOENT) {
+		/* Avoid suspend failed when usb_kill_urb */
+		return;
+	}
+
+	usb_mark_last_busy(data->udev);
+
+	/* The URB complete handler is still called with urb->actual_length = 0
+	 * when the event is not available, so we should keep re-submitting
+	 * URB until WMT event returns, Also, It's necessary to wait some time
+	 * between the two consecutive control URBs to relax the target device
+	 * to generate the event. Otherwise, the WMT event cannot return from
+	 * the device successfully.
+	 */
+	udelay(100);
+
+	usb_anchor_urb(urb, &data->ctrl_anchor);
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err < 0) {
+		/* -EPERM: urb is being killed;
+		 * -ENODEV: device got disconnected
+		 */
+		if (err != -EPERM && err != -ENODEV)
+			bt_dev_err(hdev, "urb %p failed to resubmit (%d)",
+				   urb, -err);
+		usb_unanchor_urb(urb);
+	}
+}
+
+static int btusb_mtk_submit_wmt_recv_urb(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct usb_ctrlrequest *dr;
+	unsigned char *buf;
+	int err, size = 64;
+	unsigned int pipe;
+	struct urb *urb;
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return -ENOMEM;
+
+	dr = kmalloc(sizeof(*dr), GFP_KERNEL);
+	if (!dr) {
+		usb_free_urb(urb);
+		return -ENOMEM;
+	}
+
+	dr->bRequestType = USB_TYPE_VENDOR | USB_DIR_IN;
+	dr->bRequest     = 1;
+	dr->wIndex       = cpu_to_le16(0);
+	dr->wValue       = cpu_to_le16(48);
+	dr->wLength      = cpu_to_le16(size);
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf) {
+		kfree(dr);
+		return -ENOMEM;
+	}
+
+	pipe = usb_rcvctrlpipe(data->udev, 0);
+
+	usb_fill_control_urb(urb, data->udev, pipe, (void *)dr,
+			     buf, size, btusb_mtk_wmt_recv, hdev);
+
+	urb->transfer_flags |= URB_FREE_BUFFER;
+
+	usb_anchor_urb(urb, &data->ctrl_anchor);
+	err = usb_submit_urb(urb, GFP_KERNEL);
+	if (err < 0) {
+		if (err != -EPERM && err != -ENODEV)
+			bt_dev_err(hdev, "urb %p submission failed (%d)",
+				   urb, -err);
+		usb_unanchor_urb(urb);
+	}
+
+	usb_free_urb(urb);
+
+	return err;
+}
+
+static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
+				  struct btmtk_hci_wmt_params *wmt_params)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct btmtk_hci_wmt_evt_funcc *wmt_evt_funcc;
+	u32 hlen, status = BTMTK_WMT_INVALID;
+	struct btmtk_hci_wmt_evt *wmt_evt;
+	struct btmtk_hci_wmt_cmd wc;
+	struct btmtk_wmt_hdr *hdr;
+	int err;
+
+	/* Submit control IN URB on demand to process the WMT event */
+	err = btusb_mtk_submit_wmt_recv_urb(hdev);
+	if (err < 0)
+		return err;
+
+	/* Send the WMT command and wait until the WMT event returns */
+	hlen = sizeof(*hdr) + wmt_params->dlen;
+	if (hlen > 255)
+		return -EINVAL;
+
+	hdr = (struct btmtk_wmt_hdr *)&wc;
+	hdr->dir = 1;
+	hdr->op = wmt_params->op;
+	hdr->dlen = cpu_to_le16(wmt_params->dlen + 1);
+	hdr->flag = wmt_params->flag;
+	memcpy(wc.data, wmt_params->data, wmt_params->dlen);
+
+	set_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
+
+	err = __hci_cmd_send(hdev, 0xfc6f, hlen, &wc);
+
+	if (err < 0) {
+		clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
+		return err;
+	}
+
+	/* The vendor specific WMT commands are all answered by a vendor
+	 * specific event and will have the Command Status or Command
+	 * Complete as with usual HCI command flow control.
+	 *
+	 * After sending the command, wait for BTUSB_TX_WAIT_VND_EVT
+	 * state to be cleared. The driver specific event receive routine
+	 * will clear that state and with that indicate completion of the
+	 * WMT command.
+	 */
+	err = wait_on_bit_timeout(&data->flags, BTUSB_TX_WAIT_VND_EVT,
+				  TASK_INTERRUPTIBLE, HCI_INIT_TIMEOUT);
+	if (err == -EINTR) {
+		bt_dev_err(hdev, "Execution of wmt command interrupted");
+		clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
+		return err;
+	}
+
+	if (err) {
+		bt_dev_err(hdev, "Execution of wmt command timed out");
+		clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
+		return -ETIMEDOUT;
+	}
+
+	/* Parse and handle the return WMT event */
+	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
+	if (wmt_evt->whdr.op != hdr->op) {
+		bt_dev_err(hdev, "Wrong op received %d expected %d",
+			   wmt_evt->whdr.op, hdr->op);
+		err = -EIO;
+		goto err_free_skb;
+	}
+
+	switch (wmt_evt->whdr.op) {
+	case BTMTK_WMT_SEMAPHORE:
+		if (wmt_evt->whdr.flag == 2)
+			status = BTMTK_WMT_PATCH_UNDONE;
+		else
+			status = BTMTK_WMT_PATCH_DONE;
+		break;
+	case BTMTK_WMT_FUNC_CTRL:
+		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
+		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
+			status = BTMTK_WMT_ON_DONE;
+		else if (be16_to_cpu(wmt_evt_funcc->status) == 0x420)
+			status = BTMTK_WMT_ON_PROGRESS;
+		else
+			status = BTMTK_WMT_ON_UNDONE;
+		break;
+	};
+
+	if (wmt_params->status)
+		*wmt_params->status = status;
+
+err_free_skb:
+	kfree_skb(data->evt_skb);
+	data->evt_skb = NULL;
+
+	return err;
+}
+
+static int btusb_mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	size_t fw_size;
+	int err, dlen;
+	u8 flag;
+
+	err = request_firmware(&fw, fwname, &hdev->dev);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to load firmware file (%d)", err);
+		return err;
+	}
+
+	fw_ptr = fw->data;
+	fw_size = fw->size;
+
+	/* The size of patch header is 30 bytes, should be skip */
+	if (fw_size < 30)
+		goto err_release_fw;
+
+	fw_size -= 30;
+	fw_ptr += 30;
+	flag = 1;
+
+	wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
+	wmt_params.status = NULL;
+
+	while (fw_size > 0) {
+		dlen = min_t(int, 250, fw_size);
+
+		/* Tell deivice the position in sequence */
+		if (fw_size - dlen <= 0)
+			flag = 3;
+		else if (fw_size < fw->size - 30)
+			flag = 2;
+
+		wmt_params.flag = flag;
+		wmt_params.dlen = dlen;
+		wmt_params.data = fw_ptr;
+
+		err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
+				   err);
+			goto err_release_fw;
+		}
+
+		fw_size -= dlen;
+		fw_ptr += dlen;
+	}
+
+	wmt_params.op = BTMTK_WMT_RST;
+	wmt_params.flag = 4;
+	wmt_params.dlen = 0;
+	wmt_params.data = NULL;
+	wmt_params.status = NULL;
+
+	/* Activate funciton the firmware providing to */
+	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
+		return err;
+	}
+
+err_release_fw:
+	release_firmware(fw);
+
+	return err;
+}
+
+static int btusb_mtk_func_query(struct hci_dev *hdev)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	int status, err;
+	u8 param = 0;
+
+	/* Query whether the function is enabled */
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 4;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = &status;
+
+	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to query function status (%d)", err);
+		return err;
+	}
+
+	return status;
+}
+
+static int btusb_mtk_reg_read(struct btusb_data *data, u32 reg, u32 *val)
+{
+	int pipe, err, size = sizeof(u32);
+	void *buf;
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pipe = usb_rcvctrlpipe(data->udev, 0);
+	err = usb_control_msg(data->udev, pipe, 0x63,
+			      USB_TYPE_VENDOR | USB_DIR_IN,
+			      reg >> 16, reg & 0xffff,
+			      buf, size, USB_CTRL_SET_TIMEOUT);
+	if (err < 0)
+		goto err_free_buf;
+
+	*val = get_unaligned_le32(buf);
+
+err_free_buf:
+	kfree(buf);
+
+	return err;
+}
+
+static int btusb_mtk_id_get(struct btusb_data *data, u32 *id)
+{
+	return btusb_mtk_reg_read(data, 0x80000008, id);
+}
+
+static int btusb_mtk_setup(struct hci_dev *hdev)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	struct btmtk_hci_wmt_params wmt_params;
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
+	int err, status;
+	const char *fwname;
+	u32 dev_id;
+	u8 param;
+
+	calltime = ktime_get();
+
+	err = btusb_mtk_id_get(data, &dev_id);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to get device id (%d)", err);
+		return err;
+	}
+
+	switch (dev_id) {
+	case 0x7668:
+		fwname = FIRMWARE_MT7668;
+		break;
+	default:
+		bt_dev_err(hdev, "Unsupported support hardware variant (%08x)",
+			   dev_id);
+		return -ENODEV;
+	}
+
+	/* Query whether the firmware is already download */
+	wmt_params.op = BTMTK_WMT_SEMAPHORE;
+	wmt_params.flag = 1;
+	wmt_params.dlen = 0;
+	wmt_params.data = NULL;
+	wmt_params.status = &status;
+
+	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to query firmware status (%d)", err);
+		return err;
+	}
+
+	if (status == BTMTK_WMT_PATCH_DONE) {
+		bt_dev_info(hdev, "firmware already downloaded");
+		goto ignore_setup_fw;
+	}
+
+	/* Setup a firmware which the device definitely requires */
+	err = btusb_mtk_setup_firmware(hdev, fwname);
+	if (err < 0)
+		return err;
+
+ignore_setup_fw:
+	err = readx_poll_timeout(btusb_mtk_func_query, hdev, status,
+				 status < 0 || status != BTMTK_WMT_ON_PROGRESS,
+				 2000, 5000000);
+	/* -ETIMEDOUT happens */
+	if (err < 0)
+		return err;
+
+	/* The other errors happen in btusb_mtk_func_query */
+	if (status < 0)
+		return status;
+
+	if (status == BTMTK_WMT_ON_DONE) {
+		bt_dev_info(hdev, "function already on");
+		goto ignore_func_on;
+	}
+
+	/* Enable Bluetooth protocol */
+	param = 1;
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 0;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = NULL;
+
+	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
+		return err;
+	}
+
+ignore_func_on:
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+
+	bt_dev_info(hdev, "Device setup in %llu usecs", duration);
+
+	return 0;
+}
+
+static int btusb_mtk_shutdown(struct hci_dev *hdev)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	u8 param = 0;
+	int err;
+
+	/* Disable the device */
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 0;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = NULL;
+
+	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
+		return err;
+	}
+
+	return 0;
+}
+
+MODULE_FIRMWARE(FIRMWARE_MT7668);
+#endif
+
 #ifdef CONFIG_PM
 /* Configure an out-of-band gpio as wake-up pin, if specified in device tree */
 static int marvell_config_oob_wake(struct hci_dev *hdev)
@@ -3002,6 +3539,7 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->bulk_anchor);
 	init_usb_anchor(&data->isoc_anchor);
 	init_usb_anchor(&data->diag_anchor);
+	init_usb_anchor(&data->ctrl_anchor);
 	spin_lock_init(&data->rxlock);
 
 	if (id->driver_info & BTUSB_INTEL_NEW) {
@@ -3102,6 +3640,15 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_MARVELL)
 		hdev->set_bdaddr = btusb_set_bdaddr_marvell;
 
+#ifdef CONFIG_BT_HCIBTUSB_MTK
+	if (id->driver_info & BTUSB_MEDIATEK) {
+		hdev->setup = btusb_mtk_setup;
+		hdev->shutdown = btusb_mtk_shutdown;
+		hdev->manufacturer = 70;
+		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+	}
+#endif
+
 	if (id->driver_info & BTUSB_SWAVE) {
 		set_bit(HCI_QUIRK_FIXUP_INQUIRY_MODE, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_LOCAL_COMMANDS, &hdev->quirks);
-- 
2.7.4


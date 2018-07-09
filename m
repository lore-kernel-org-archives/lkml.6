Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E689C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C3920873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VnW3oDi/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mxSZbnJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C3920873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933552AbeGIQRT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:17:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37228 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932806AbeGIQRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:17:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 49F3D606AC; Mon,  9 Jul 2018 16:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531153033;
        bh=K9S/XDjg2fgXVNi33OptutLJiuEveio7LyTw4o1JILk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VnW3oDi/I6KBfPJuONehEIu5G7Znp1Bsnxwl/JDmONk/CZbgoiOAqXDFxic91jSQh
         llNlMcgHry9d4Us3UYbHDY838J744puMTrATIb4JLNw1pa54DK1cemN6UkJfoUc1dW
         OmBD4exVZzXlM3sAKsUZid+wB/+vNqd3YnsMwJAQ=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B2DC60B14;
        Mon,  9 Jul 2018 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531153031;
        bh=K9S/XDjg2fgXVNi33OptutLJiuEveio7LyTw4o1JILk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxSZbnJAdJUMCPbbHCKAHN+PG7LR/hJtWf6BcSVN6T2+5Mf+I/yvV9QLohoHVJCtk
         u5DB+G21XvqpSEKHJS1y4qbODBbLTMiMb9Jdu5QidnguY+1WieqV5wH0mEEHVooihn
         ZZyRdDGHM+crqCBPSTPItn9uzZsBNE4TJaHbQJNE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B2DC60B14
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        c-hbandi@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 1/1] Bluetooth: hci_qca: Sub system restart support for WCN3990
Date:   Mon,  9 Jul 2018 21:46:57 +0530
Message-Id: <20180709161657.26609-2-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709161657.26609-1-bgodavar@codeaurora.org>
References: <20180709161657.26609-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harish Bandi <c-hbandi@codeaurora.org>

This patch enables subsystem restart support(SSR) for Qualcomm
Bluetooth Chip wcn3990. Subsystem restart is used to mitigate
user experience interruption within SoC or fusion targets.
Those interruptions often come from a faulty subsystem with either
SW errors or HWDOG BITE. Without subsystem restart architecture and
solution, it requires system reboot if any faulty system occurs.
However, subsystem restart doesn’t include RPM subsystem which controls
the power state machine. If RRM crashes, the entire system will still reboot.

We will collect the ramdump of BT SoC before rebooting the HCI layer.
System ramdump is a useful feature for helping debug. Before restarting
a subsystem or a process running on a subsystem, it is often required to
request either a subsystem or a process to perform proper cache dump and
software failure reason into a memory buffer which application processor can
retrieve afterwards. SW developers can often provide initial investigation by
looking into that debugging information.

Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/btqca.h   |   8 ++
 drivers/bluetooth/hci_qca.c | 261 ++++++++++++++++++++++++++++++++++++
 2 files changed, 269 insertions(+)

diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 0c01f375fe83..4c9e3ae38961 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -40,6 +40,14 @@
 #define QCA_WCN3990_POWERON_PULSE	0xFC
 #define QCA_WCN3990_POWEROFF_PULSE	0xC0
 
+#define QCA_SSR_SOCCRASH_BYTE        (0xfb)
+#define QCA_BT_CONTROLLER_LOG        (0x01)
+#define QCA_BT_MESSAGE_TYPE_MEM_DUMP (0x08)
+#define QCA_BT_MEM_DUMP_HEADER_SIZE  (4)
+#define QCA_BT_MEM_DUMP_PACKET_SIZE  (256)
+
+
+
 enum qca_bardrate {
 	QCA_BAUDRATE_115200 	= 0,
 	QCA_BAUDRATE_57600,
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index d62c7785a618..2592ff860338 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -40,6 +40,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/serdev.h>
+#include <linux/devcoredump.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -63,6 +64,22 @@
 /* susclk rate */
 #define SUSCLK_RATE_32KHZ	32768
 
+/* soc dump messages */
+#define QCA_LAST_SEQUENCE_NUM      0xFFFF
+#define QCA_DUMP_TIMEOUT_MS          8000
+#define QCA_DUMP_PACKET_SIZE          255
+#define QCA_DUMP_PKT_LENGTH_BYTE	0
+#define QCA_DUMP_PKT_LOG                1
+#define QCA_DUMP_PKT_TYPE_DUMP          2
+#define QCA_DUMP_PKT_SEQNUM1	        3
+#define QCA_DUMP_PKT_SEQNUM2	        4
+#define QCA_DUMP_PKT_DUMPSIZE_BYTE1     6
+#define QCA_DUMP_PKT_DUMPSIZE_BYTE2     7
+#define QCA_DUMP_PKT_DUMPSIZE_BYTE3     8
+#define QCA_DUMP_PKT_DUMPSIZE_BYTE4     9
+#define QCA_DUMP_PKT_DUMPBYTE_LEN	4
+#define QCA_CRASHBYTE_PACKET_LEN	1100
+
 /* HCI_IBS transmit side sleep protocol states */
 enum tx_ibs_states {
 	HCI_IBS_TX_ASLEEP,
@@ -105,6 +122,8 @@ struct qca_data {
 	struct work_struct ws_rx_vote_off;
 	struct work_struct ws_tx_vote_off;
 	unsigned long flags;
+	struct timer_list mem_dump_timer;
+	u32 mem_dump;
 
 	/* For debugging purpose */
 	u64 ibs_sent_wacks;
@@ -122,6 +141,17 @@ struct qca_data {
 	u64 rx_votes_off;
 	u64 votes_on;
 	u64 votes_off;
+	bool mem_dump_status;
+};
+
+struct qca_memdump_data {
+	unsigned int dump_size;
+	unsigned int total_size;
+	unsigned short seq_num;
+	unsigned short seq_num_cnt;
+	char *data_buf;
+	struct file *dump_fd;
+	uint8_t *dump_ptr;
 };
 
 enum qca_speed_type {
@@ -166,8 +196,11 @@ struct qca_serdev {
 	u32 oper_speed;
 };
 
+struct qca_memdump_data *qca_memdump;
 static int qca_power_setup(struct hci_uart *hu, bool on);
 static void qca_power_shutdown(struct hci_uart *hu);
+static void qca_hw_error(struct hci_dev *hdev, u8 code);
+static void qca_soc_dump_timeout(struct timer_list *t);
 
 static void __serial_clock_on(struct tty_struct *tty)
 {
@@ -495,6 +528,7 @@ static int qca_open(struct hci_uart *hu)
 	qca->tx_votes_off = 0;
 	qca->rx_votes_on = 0;
 	qca->rx_votes_off = 0;
+	qca->mem_dump_status = false;
 
 	hu->priv = qca;
 
@@ -524,6 +558,9 @@ static int qca_open(struct hci_uart *hu)
 	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
 	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
 
+	timer_setup(&qca->mem_dump_timer, qca_soc_dump_timeout, 0);
+	qca->mem_dump = QCA_DUMP_TIMEOUT_MS;
+
 	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
 	       qca->tx_idle_delay, qca->wake_retrans);
 
@@ -603,6 +640,7 @@ static int qca_close(struct hci_uart *hu)
 	skb_queue_purge(&qca->txq);
 	del_timer(&qca->tx_idle_timer);
 	del_timer(&qca->wake_retrans_timer);
+	del_timer(&qca->mem_dump_timer);
 	destroy_workqueue(qca->workqueue);
 	qca->hu = NULL;
 
@@ -814,6 +852,183 @@ static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	return 0;
 }
 
+static void qca_soc_dump_timeout(struct timer_list *t)
+{
+	struct qca_data *qca = from_timer(qca, t, mem_dump_timer);
+	struct hci_uart *hu = qca->hu;
+
+	del_timer(&qca->mem_dump_timer);
+
+	if (qca->mem_dump_status)
+		bt_dev_info(hu->hdev, "QCA collected memory dump successful");
+	else
+		bt_dev_info(hu->hdev, "QCA memdump unsuccessful");
+
+	kfree(qca_memdump);
+}
+
+static int qca_savememdump(struct hci_dev *hdev, uint8_t *data,
+			     uint16_t packet_len)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+	static char *memdump_buf, *memdump_ptr;
+	char nullBuff[QCA_DUMP_PACKET_SIZE] = { 0 };
+
+	if (!qca_memdump) {
+		qca_memdump = kzalloc(sizeof(struct qca_memdump_data),
+				      GFP_ATOMIC);
+
+		if (!qca_memdump)
+			return -ENOMEM;
+	}
+
+	/* Read received packet sequence no's from byte 3 and 4 */
+	qca_memdump->seq_num = data[QCA_DUMP_PKT_SEQNUM1] |
+				(data[QCA_DUMP_PKT_SEQNUM2] << 8);
+
+	/* Discard header and reduce the packet length */
+	qca_memdump->dump_ptr = &data[QCA_DUMP_PKT_DUMPSIZE_BYTE1];
+	packet_len -= QCA_DUMP_PKT_DUMPSIZE_BYTE1;
+
+	BT_DBG(" values : (%02x) (%d) (%d) ",
+		qca_memdump->dump_ptr[0], packet_len, qca_memdump->seq_num);
+	BT_DBG(" Data values : (%02x) (%02x) (%02x) (%02x) (%02x) ",
+		data[0], data[1], data[2], data[3], data[4]);
+
+	if (qca_memdump->seq_num == 0x0000 && !memdump_ptr) {
+
+		/* Disable IBS as SoC is in bad state. */
+		clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+		mod_timer(&qca->mem_dump_timer,
+			  (jiffies + msecs_to_jiffies(qca->mem_dump)));
+
+		/* This block is for first sequence of data received.
+		 * In first sequence we will have total dump size in
+		 * 6,7,8 and 9 bytes.
+		 */
+		qca_memdump->dump_size =
+			(unsigned int)(data[QCA_DUMP_PKT_DUMPSIZE_BYTE1] |
+			(data[QCA_DUMP_PKT_DUMPSIZE_BYTE2] << 8) |
+			(data[QCA_DUMP_PKT_DUMPSIZE_BYTE3] << 16) |
+			(data[QCA_DUMP_PKT_DUMPSIZE_BYTE4] << 24));
+
+		/* Discard dump size and reduce the packet length. */
+		qca_memdump->dump_ptr = &data[QCA_DUMP_PKT_DUMPSIZE_BYTE4 + 1];
+		packet_len -= QCA_DUMP_PKT_DUMPBYTE_LEN;
+
+		qca_memdump->total_size = 0;
+		qca_memdump->seq_num_cnt = 0;
+		bt_dev_info(hu->hdev, "Crash Dump Start - dump size: %d ",
+			    qca_memdump->dump_size);
+		/* create an buffer with total dumpo size */
+		memdump_ptr = vmalloc(qca_memdump->dump_size+1);
+		if (!memdump_ptr)
+			return -ENOMEM;
+
+		memdump_buf = memdump_ptr;
+
+	} else if (memdump_ptr &&
+		   (qca_memdump->seq_num > qca_memdump->seq_num_cnt) &&
+		   (qca_memdump->seq_num != QCA_LAST_SEQUENCE_NUM)) {
+		/* if we receive a skip packet, save the dummy data. */
+		BT_DBG("controller missed packet:%d,write null %d into buffer",
+			qca_memdump->seq_num_cnt, packet_len);
+		memcpy(memdump_buf, nullBuff, packet_len);
+		memdump_buf = memdump_buf + packet_len;
+		qca_memdump->total_size += packet_len;
+		qca_memdump->seq_num_cnt++;
+		return 0;
+	} else if (!memdump_ptr) {
+		return -ENOMEM;
+	}
+
+	memcpy(memdump_buf, qca_memdump->dump_ptr, packet_len);
+	memdump_buf = memdump_buf + packet_len;
+	qca_memdump->total_size += packet_len;
+	qca_memdump->seq_num_cnt++;
+
+	if (qca_memdump->seq_num == QCA_LAST_SEQUENCE_NUM) {
+		BT_INFO("Writing crash dump of size %d bytes",
+			qca_memdump->total_size);
+		dev_coredumpv(&hu->serdev->dev, memdump_ptr,
+			      qca_memdump->total_size, GFP_KERNEL);
+
+		qca_memdump->seq_num_cnt = 0;
+		qca->mem_dump_status = true;
+	}
+
+	return 0;
+}
+
+static int qca_bt_memdump_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	int ret;
+
+	ret = qca_savememdump(hdev, skb->data, skb->len);
+	kfree_skb(skb);
+
+	return ret;
+}
+
+static int qca_send_crashbuffer(struct hci_uart *hu)
+{
+	struct qca_data *qca = hu->priv;
+	struct sk_buff *skb;
+	unsigned char buf[QCA_CRASHBYTE_PACKET_LEN];
+
+	bt_dev_dbg(hu->hdev, "sending soc crash buffer to SoC");
+
+	/* sending the crash byte 0xfb as 1100 bytes to SOC
+	 * to crash the SOC, reason for sending 1100 bytes is
+	 * few times data from UART may corrupt and SOC may treat
+	 * this bytes as some data bytes or ACL bytes.
+	 * To make SOC to understand that this is Crash byte, we
+	 * need to send the more than ACL packet length which is
+	 * more than 1024 bytes.
+	 */
+	memset(buf, QCA_SSR_SOCCRASH_BYTE, QCA_CRASHBYTE_PACKET_LEN);
+
+	skb = bt_skb_alloc(QCA_CRASHBYTE_PACKET_LEN, GFP_KERNEL);
+	if (!skb) {
+		bt_dev_err(hu->hdev, "Failed to allocate memory for skb packet");
+		return -ENOMEM;
+	}
+
+	skb_put_data(skb, buf, QCA_CRASHBYTE_PACKET_LEN);
+	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
+
+	skb_queue_tail(&qca->txq, skb);
+	hci_uart_tx_wakeup(hu);
+
+	return 0;
+}
+
+static void qca_hw_error(struct hci_dev *hdev, u8 code)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+	int ret;
+
+	BT_DBG("mem_dump_status: %d", qca->mem_dump_status);
+
+	if (!qca->mem_dump_status) {
+		/* if hardware error event received for other than QCA
+		 * soc memory dump event, then we need to crash the SOC
+		 */
+		qca_send_crashbuffer(hu);
+	} else {
+		/* Hardware error event received after collecting the SoC dump.
+		 * We need to help BT SoC to restart and functional normaly.
+		 * it is kind of restarting HCI driver.
+		 */
+		hci_dev_set_flag(hdev, HCI_SETUP);
+		hci_dev_set_flag(hdev, HCI_AUTO_OFF);
+		qca_close(hu);
+		qca_open(hu);
+	}
+}
+
 static int qca_ibs_sleep_ind(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
@@ -871,6 +1086,13 @@ static int qca_ibs_wake_ack(struct hci_dev *hdev, struct sk_buff *skb)
 	.lsize = 0, \
 	.maxlen = HCI_MAX_IBS_SIZE
 
+#define QCA_BT_MEM_DUMP_EVENT \
+	.type = HCI_VENDOR_PKT, \
+	.hlen = 1, \
+	.loff = 0, \
+	.lsize = 1, \
+	.maxlen = QCA_BT_MEM_DUMP_PACKET_SIZE
+
 static const struct h4_recv_pkt qca_recv_pkts[] = {
 	{ H4_RECV_ACL,             .recv = hci_recv_frame    },
 	{ H4_RECV_SCO,             .recv = hci_recv_frame    },
@@ -878,6 +1100,7 @@ static const struct h4_recv_pkt qca_recv_pkts[] = {
 	{ QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_wake_ind  },
 	{ QCA_IBS_WAKE_ACK_EVENT,  .recv = qca_ibs_wake_ack  },
 	{ QCA_IBS_SLEEP_IND_EVENT, .recv = qca_ibs_sleep_ind },
+	{ QCA_BT_MEM_DUMP_EVENT,   .recv = qca_bt_memdump_event },
 };
 
 static int qca_recv(struct hci_uart *hu, const void *data, int count)
@@ -887,6 +1110,42 @@ static int qca_recv(struct hci_uart *hu, const void *data, int count)
 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
 		return -EUNATCH;
 
+	/* we are parsing the qca memory dump event, here we are
+	 * getting the each recv pack as 512 bytes, but each memory dump
+	 * packet size is 256 bytes so need to split the packet
+	 * as 2 packets and then sent to memory dump event
+	 */
+	if ((count >= QCA_BT_MEM_DUMP_HEADER_SIZE) &&
+	    (*((unsigned char *) data + 0) == HCI_EVENT_PKT) &&
+	    (*((unsigned char *) data + QCA_DUMP_PKT_LOG) ==
+		HCI_VENDOR_PKT) &&
+		(*((unsigned char *) data + QCA_DUMP_PKT_SEQNUM1) ==
+		QCA_BT_CONTROLLER_LOG) && (*((unsigned char *) data +
+		QCA_DUMP_PKT_SEQNUM2) == QCA_BT_MESSAGE_TYPE_MEM_DUMP)) {
+
+		bt_dev_dbg(hu->hdev, "parsing for vendor pkt (%d)", count);
+		data += 1;
+		count -= 1;
+
+		/* Check for second packet in the same buffer */
+		if ((count >= (QCA_BT_MEM_DUMP_PACKET_SIZE +
+		    QCA_BT_MEM_DUMP_HEADER_SIZE)) &&
+		    (*((unsigned char *) data + QCA_DUMP_PACKET_SIZE) ==
+		    HCI_EVENT_PKT) &&
+		    (*((unsigned char *) data + (QCA_DUMP_PACKET_SIZE +
+		    QCA_DUMP_PKT_LOG)) == HCI_VENDOR_PKT) &&
+		    (*((unsigned char *) data + (QCA_DUMP_PACKET_SIZE +
+		    QCA_DUMP_PKT_SEQNUM1)) == QCA_BT_CONTROLLER_LOG) &&
+		    (*((unsigned char *) data + (QCA_DUMP_PACKET_SIZE +
+		    QCA_DUMP_PKT_SEQNUM2)) == QCA_BT_MESSAGE_TYPE_MEM_DUMP)) {
+
+			memcpy((unsigned char *) data + QCA_DUMP_PACKET_SIZE,
+			(unsigned char *) data + QCA_BT_MEM_DUMP_PACKET_SIZE,
+			(count - QCA_BT_MEM_DUMP_PACKET_SIZE));
+			count -= 1;
+		}
+	}
+
 	qca->rx_skb = h4_recv_buf(hu->hdev, qca->rx_skb, data, count,
 				  qca_recv_pkts, ARRAY_SIZE(qca_recv_pkts));
 	if (IS_ERR(qca->rx_skb)) {
@@ -1148,6 +1407,8 @@ static int qca_setup(struct hci_uart *hu)
 			bt_dev_err(hdev, "Failed to get version %d", ret);
 			return ret;
 		}
+		/* Handle hardware error event for BT SSR handling */
+		hu->hdev->hw_error = qca_hw_error;
 	} else {
 		bt_dev_info(hdev, "ROME setup");
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project


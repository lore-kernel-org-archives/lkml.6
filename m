Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A30EC43444
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6A3218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeL2H1Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 02:27:25 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:57262 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbeL2H1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 02:27:19 -0500
Received: from [172.20.12.43] (unknown [213.61.67.157])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6F6EECF358;
        Sat, 29 Dec 2018 08:34:58 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC,v2] Bluetooth: hci_qca: Collect controller memory dump
 during SSR
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181228130411.23007-1-bgodavar@codeaurora.org>
Date:   Sat, 29 Dec 2018 08:27:16 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8B1A4B0A-BFC3-44EC-A75F-D87DBA64625B@holtmann.org>
References: <20181228130411.23007-1-bgodavar@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> We will collect the ramdump of BT controller when hardware error event
> received before rebooting the HCI layer. Before restarting a subsystem
> or a process running on a subsystem, it is often required to request
> either a subsystem or a process to perform proper cache dump and
> software failure reason into a memory buffer which application
> processor can retrieve afterwards. SW developers can often provide
> initial investigation by looking into that debugging information.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> changes v2:
> * entirely an newer approach handling with an work queue.
> 
> ---
> drivers/bluetooth/hci_qca.c | 289 ++++++++++++++++++++++++++++++++++--
> 1 file changed, 278 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f036c8f98ea3..62b768bc32ec 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -32,6 +32,7 @@
> #include <linux/clk.h>
> #include <linux/debugfs.h>
> #include <linux/delay.h>
> +#include <linux/devcoredump.h>
> #include <linux/device.h>
> #include <linux/gpio/consumer.h>
> #include <linux/mod_devicetable.h>

don't we have some crashdump core facility that could be utilized here?

> @@ -57,9 +58,10 @@
> /* Controller states */
> #define STATE_IN_BAND_SLEEP_ENABLED	1
> 
> -#define IBS_WAKE_RETRANS_TIMEOUT_MS	100
> +#define	IBS_WAKE_RETRANS_TIMEOUT_MS	100
> #define IBS_TX_IDLE_TIMEOUT_MS		2000
> -#define BAUDRATE_SETTLE_TIMEOUT_MS	300
> +#define	BAUDRATE_SETTLE_TIMEOUT_MS	300
> +#define MEMDUMP_COLLECTION_TIMEOUT_MS	8000
> 
> /* susclk rate */
> #define SUSCLK_RATE_32KHZ	32768
> @@ -67,6 +69,13 @@
> /* Controller debug log header */
> #define QCA_DEBUG_HANDLE	0x2EDC
> 
> +/* Controller dump header */
> +#define QCA_SSR_DUMP_HANDLE		0x0108
> +#define QCA_DUMP_PACKET_SIZE		255
> +#define QCA_LAST_SEQUENCE_NUM		0xFFFF
> +#define QCA_CRASHBYTE_PACKET_LEN	1100
> +#define QCA_MEMDUMP_BYTE		0xFB
> +
> /* HCI_IBS transmit side sleep protocol states */
> enum tx_ibs_states {
> 	HCI_IBS_TX_ASLEEP,
> @@ -89,12 +98,41 @@ enum hci_ibs_clock_state_vote {
> 	HCI_IBS_RX_VOTE_CLOCK_OFF,
> };
> 
> +/* Controller memory dump states */
> +enum qca_memdump_states {
> +	QCA_MEMDUMP_IDLE,
> +	QCA_MEMDUMP_COLLECTING,
> +	QCA_MEMDUMP_COLLECTED,
> +	QCA_MEMDUMP_TIMEOUT,
> +};
> +
> +struct qca_memdump_data {
> +	char *memdump_buf_head;
> +	char *memdump_buf_tail;
> +	u32 current_seq_no;
> +	u32 received_dump;
> +};
> +
> +struct qca_memdump_event_hdr {
> +	__u8    evt;
> +	__u8    plen;
> +	__u16   opcode;
> +	__u16   seq_no;
> +	__u8    reserved;
> +} __packed;
> +
> +
> +struct qca_dump_size {
> +	u32 dump_size;
> +} __packed;
> +
> struct qca_data {
> 	struct hci_uart *hu;
> 	struct sk_buff *rx_skb;
> 	struct sk_buff_head txq;
> -	struct sk_buff_head tx_wait_q;	/* HCI_IBS wait queue	*/
> -	spinlock_t hci_ibs_lock;	/* HCI_IBS state lock	*/
> +	struct sk_buff_head tx_wait_q;		/* HCI_IBS wait queue	*/
> +	struct sk_buff_head rx_memdump_q;	/* Memdump wait queue	*/
> +	spinlock_t hci_ibs_lock;		/* HCI_IBS state lock	*/
> 	u8 tx_ibs_state;	/* HCI_IBS transmit side power state*/
> 	u8 rx_ibs_state;	/* HCI_IBS receive side power state */
> 	bool tx_vote;		/* Clock must be on for TX */
> @@ -103,12 +141,17 @@ struct qca_data {
> 	u32 tx_idle_delay;
> 	struct timer_list wake_retrans_timer;
> 	u32 wake_retrans;
> +	struct timer_list memdump_timer;
> +	u32 memdump_delay;
> 	struct workqueue_struct *workqueue;
> 	struct work_struct ws_awake_rx;
> 	struct work_struct ws_awake_device;
> 	struct work_struct ws_rx_vote_off;
> 	struct work_struct ws_tx_vote_off;
> +	struct work_struct ctrl_memdump_evt;
> +	struct qca_memdump_data *qca_memdump;
> 	unsigned long flags;
> +	enum qca_memdump_states memdump_state;
> 
> 	/* For debugging purpose */
> 	u64 ibs_sent_wacks;
> @@ -173,6 +216,7 @@ struct qca_serdev {
> static int qca_power_setup(struct hci_uart *hu, bool on);
> static void qca_power_shutdown(struct hci_uart *hu);
> static int qca_power_off(struct hci_dev *hdev);
> +static void qca_controller_memdump(struct work_struct *work);
> 
> static void __serial_clock_on(struct tty_struct *tty)
> {
> @@ -446,6 +490,21 @@ static void hci_ibs_wake_retrans_timeout(struct timer_list *t)
> 		hci_uart_tx_wakeup(hu);
> }
> 
> +static void hci_memdump_timeout(struct timer_list *t)
> +{
> +	struct qca_data *qca = from_timer(qca, t, tx_idle_timer);
> +	struct hci_uart *hu = qca->hu;
> +	struct qca_memdump_data *qca_memdump = qca->qca_memdump;
> +	char *memdump_buf = qca_memdump->memdump_buf_tail;
> +
> +	bt_dev_err(hu->hdev, "clearing allocated memory due to memdump timeout");
> +	kfree(memdump_buf);
> +	kfree(qca_memdump);
> +	qca->memdump_state = QCA_MEMDUMP_TIMEOUT;
> +	del_timer(&qca->memdump_timer);
> +	cancel_work_sync(&qca->ctrl_memdump_evt);
> +}
> +
> /* Initialize protocol */
> static int qca_open(struct hci_uart *hu)
> {
> @@ -461,6 +520,7 @@ static int qca_open(struct hci_uart *hu)
> 
> 	skb_queue_head_init(&qca->txq);
> 	skb_queue_head_init(&qca->tx_wait_q);
> +	skb_queue_head_init(&qca->rx_memdump_q);
> 	spin_lock_init(&qca->hci_ibs_lock);
> 	qca->workqueue = alloc_ordered_workqueue("qca_wq", 0);
> 	if (!qca->workqueue) {
> @@ -473,6 +533,7 @@ static int qca_open(struct hci_uart *hu)
> 	INIT_WORK(&qca->ws_awake_device, qca_wq_awake_device);
> 	INIT_WORK(&qca->ws_rx_vote_off, qca_wq_serial_rx_clock_vote_off);
> 	INIT_WORK(&qca->ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);
> +	INIT_WORK(&qca->ctrl_memdump_evt, qca_controller_memdump);
> 
> 	qca->hu = hu;
> 
> @@ -500,7 +561,7 @@ static int qca_open(struct hci_uart *hu)
> 	qca->tx_votes_off = 0;
> 	qca->rx_votes_on = 0;
> 	qca->rx_votes_off = 0;
> -
> +	qca->memdump_state = QCA_MEMDUMP_IDLE;
> 	hu->priv = qca;
> 
> 	if (hu->serdev) {
> @@ -528,6 +589,9 @@ static int qca_open(struct hci_uart *hu)
> 	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
> 	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
> 
> +	timer_setup(&qca->memdump_timer, hci_memdump_timeout, 0);
> +	qca->memdump_delay = MEMDUMP_COLLECTION_TIMEOUT_MS;
> +
> 	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
> 	       qca->tx_idle_delay, qca->wake_retrans);
> 
> @@ -605,8 +669,10 @@ static int qca_close(struct hci_uart *hu)
> 
> 	skb_queue_purge(&qca->tx_wait_q);
> 	skb_queue_purge(&qca->txq);
> +	skb_queue_purge(&qca->rx_memdump_q);
> 	del_timer(&qca->tx_idle_timer);
> 	del_timer(&qca->wake_retrans_timer);
> +	del_timer(&qca->memdump_timer);
> 	destroy_workqueue(qca->workqueue);
> 	qca->hu = NULL;
> 
> @@ -866,6 +932,141 @@ static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
> 	return hci_recv_frame(hdev, skb);
> }
> 
> +static void qca_controller_memdump(struct work_struct *work)
> +{
> +	struct qca_data *qca = container_of(work, struct qca_data,
> +					    ctrl_memdump_evt);
> +	struct hci_uart *hu = qca->hu;
> +	struct sk_buff *skb;
> +	struct qca_memdump_event_hdr *cmd_hdr;
> +	struct qca_memdump_data *qca_memdump = qca->qca_memdump;
> +	struct qca_dump_size *dump;
> +	char *memdump_buf;
> +	char nullBuff[QCA_DUMP_PACKET_SIZE] = { 0 };
> +	u16 opcode, seq_no;
> +	u32 dump_size;
> +
> +	while ((skb = skb_dequeue(&qca->rx_memdump_q))) {
> +
> +		if (!qca_memdump) {
> +			qca_memdump = kzalloc(sizeof(struct qca_memdump_data),
> +					      GFP_ATOMIC);
> +			if (!qca_memdump)
> +				return;
> +
> +			qca->qca_memdump = qca_memdump;
> +		}
> +
> +		qca->memdump_state = QCA_MEMDUMP_COLLECTING;
> +		cmd_hdr = (void *) skb->data;
> +		opcode = __le16_to_cpu(cmd_hdr->opcode);
> +		seq_no = __le16_to_cpu(cmd_hdr->seq_no);
> +		skb_pull(skb, sizeof(struct qca_memdump_event_hdr));
> +
> +		if (!seq_no) {
> +
> +			/* This is the first frame of memdump packet from
> +			 * the controller, Disable IBS to recevie dump
> +			 * with out any interruption, ideally time required for
> +			 * the controller to send the dump is 8 seconds. let us
> +			 * start timer to handle this asynchronous activity.
> +			 */
> +			clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> +
> +			dump = (void *) skb->data;
> +			dump_size = __le32_to_cpu(dump->dump_size);
> +			if (!(dump_size)) {
> +				bt_dev_err(hu->hdev, "QCA invalid memdump size");
> +				kfree_skb(skb);
> +				return;
> +			}
> +
> +			bt_dev_info(hu->hdev, "QCA: collecting memdump started"
> +				     "of size:%u", dump_size);
> +			mod_timer(&qca->memdump_timer, (jiffies +
> +				  msecs_to_jiffies(qca->memdump_delay)));
> +
> +			skb_pull(skb, sizeof(dump_size));
> +			memdump_buf = vmalloc(dump_size);
> +			qca_memdump->memdump_buf_head = memdump_buf;
> +			qca_memdump->memdump_buf_tail = memdump_buf;
> +		}
> +
> +		memdump_buf = qca_memdump->memdump_buf_tail;
> +
> +		/* If sequence no 0 is missed then there is no point in
> +		 * accepting the other sequences.
> +		 */
> +		if (!memdump_buf) {
> +			bt_dev_err(hu->hdev, "QCA: Discarding other packets");
> +			kfree(qca_memdump);
> +			kfree_skb(skb);
> +			qca->qca_memdump = NULL;
> +			return;
> +		}
> +
> +		/* There could be chance of missing some packets from
> +		 * the controller. In such cases let us store the dummy
> +		 * packets in the buffer.
> +		 */
> +		while ((seq_no > qca_memdump->current_seq_no + 1) &&
> +			seq_no != QCA_LAST_SEQUENCE_NUM) {
> +			bt_dev_err(hu->hdev, "QCA controller missed packet:%d",
> +				   qca_memdump->current_seq_no);
> +			memcpy(memdump_buf, nullBuff, QCA_DUMP_PACKET_SIZE);
> +			memdump_buf = memdump_buf + QCA_DUMP_PACKET_SIZE;
> +			qca_memdump->received_dump += QCA_DUMP_PACKET_SIZE;
> +			qca_memdump->current_seq_no++;
> +		}
> +
> +		memcpy(memdump_buf, (unsigned char *) skb->data, skb->len);
> +		memdump_buf = memdump_buf + skb->len;
> +		qca_memdump->memdump_buf_tail = memdump_buf;
> +		qca_memdump->current_seq_no = seq_no + 1;
> +		qca_memdump->received_dump += skb->len;
> +		qca->qca_memdump = qca_memdump;
> +		kfree_skb(skb);
> +		if (seq_no == QCA_LAST_SEQUENCE_NUM) {
> +			bt_dev_info(hu->hdev, "QCA writing crash dump of size %d bytes",
> +				   qca_memdump->received_dump);
> +			memdump_buf = qca_memdump->memdump_buf_head;
> +			dev_coredumpv(&hu->serdev->dev, memdump_buf,
> +				      qca_memdump->received_dump, GFP_KERNEL);
> +			// Revisit for free(memdump) if needed.
> +			del_timer(&qca->memdump_timer);
> +			kfree(qca->qca_memdump);
> +			qca->qca_memdump = NULL;
> +			qca->memdump_state = QCA_MEMDUMP_COLLECTED;
> +		}
> +	}
> +
> +}
> +
> +int qca_controller_memdump_event(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct qca_data *qca = hu->priv;
> +
> +	skb_queue_tail(&qca->rx_memdump_q, skb);
> +	queue_work(qca->workqueue, &qca->ctrl_memdump_evt);
> +
> +	return 0;
> +}
> +
> +static int qca_recv_event_data(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	/* We receive chip memory dump as an event packet, With a dedicated
> +	 * handler followed by a hardware error event. When this event is
> +	 * received we store dump into a file before closing hci. This
> +	 * dump will help in triaging the issues.
> +	 */
> +	if ((skb->data[0] == HCI_VENDOR_PKT) &&
> +	    (get_unaligned_be16((skb->data) + 2) == QCA_SSR_DUMP_HANDLE))

The (skb->data) is pointless, just do skb->data.

> +		return qca_controller_memdump_event(hdev, skb);
> +
> +	return hci_recv_frame(hdev, skb);
> +}
> +
> #define QCA_IBS_SLEEP_IND_EVENT \
> 	.type = HCI_IBS_SLEEP_IND, \
> 	.hlen = 0, \
> @@ -888,12 +1089,12 @@ static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
> 	.maxlen = HCI_MAX_IBS_SIZE
> 
> static const struct h4_recv_pkt qca_recv_pkts[] = {
> -	{ H4_RECV_ACL,             .recv = qca_recv_acl_data },
> -	{ H4_RECV_SCO,             .recv = hci_recv_frame    },
> -	{ H4_RECV_EVENT,           .recv = hci_recv_frame    },
> -	{ QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_wake_ind  },
> -	{ QCA_IBS_WAKE_ACK_EVENT,  .recv = qca_ibs_wake_ack  },
> -	{ QCA_IBS_SLEEP_IND_EVENT, .recv = qca_ibs_sleep_ind },
> +	{ H4_RECV_ACL,             .recv = qca_recv_acl_data	},
> +	{ H4_RECV_SCO,             .recv = hci_recv_frame	},
> +	{ H4_RECV_EVENT,           .recv = qca_recv_event_data	},

call it qca_recv_event and don't realign the whole table.

> +	{ QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_wake_ind	},
> +	{ QCA_IBS_WAKE_ACK_EVENT,  .recv = qca_ibs_wake_ack	},
> +	{ QCA_IBS_SLEEP_IND_EVENT, .recv = qca_ibs_sleep_ind	},
> };
> 
> static int qca_recv(struct hci_uart *hu, const void *data, int count)
> @@ -1114,6 +1315,68 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
> 	return 0;
> }
> 
> +static int qca_send_crashbuffer(struct hci_uart *hu)
> +{
> +	struct qca_data *qca = hu->priv;
> +	struct sk_buff *skb;
> +	unsigned char buf[QCA_CRASHBYTE_PACKET_LEN];
> +
> +	bt_dev_dbg(hu->hdev, "sending soc crash buffer to controller");
> +
> +	/* We forcefully crash the controller, by sending 0xfb byte for
> +	 * 1024 times. We also might have chance of losing data, To be
> +	 * on safer side we send 1100 bytes to the SoC.
> +	 */
> +	memset(buf, QCA_MEMDUMP_BYTE, QCA_CRASHBYTE_PACKET_LEN);
> +
> +	skb = bt_skb_alloc(QCA_CRASHBYTE_PACKET_LEN, GFP_KERNEL);
> +	if (!skb) {
> +		bt_dev_err(hu->hdev, "Failed to allocate memory for skb packet");
> +		return -ENOMEM;
> +	}
> +
> +	skb_put_data(skb, buf, QCA_CRASHBYTE_PACKET_LEN);
> +	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
> +
> +	skb_queue_tail(&qca->txq, skb);
> +	hci_uart_tx_wakeup(hu);
> +
> +	return 0;
> +}
> +
> +static void qca_hw_error(struct hci_dev *hdev, u8 code)
> +{
> +	struct hci_uart *hu = hci_get_drvdata(hdev);
> +	struct qca_data *qca = hu->priv;
> +
> +	bt_dev_info(hdev, "mem_dump_status: %d", qca->memdump_state);
> +
> +	if (qca->memdump_state == QCA_MEMDUMP_IDLE) {
> +		/* If hardware error event received for other than QCA
> +		 * soc memory dump event, then we need to crash the SOC
> +		 * and wait here for 8 seconds to get the dump packets.
> +		 * This will block main thread to be on hold until we
> +		 * collect dump.
> +		 */
> +		mod_timer(&qca->memdump_timer,
> +			  (jiffies + msecs_to_jiffies(qca->memdump_delay)));

Why a timer that then ends up in interrupt context?

> +		qca_send_crashbuffer(hu);
> +
> +		while (qca->memdump_state != QCA_MEMDUMP_COLLECTED &&
> +			qca->memdump_state != QCA_MEMDUMP_TIMEOUT)
> +			;

What is this? Busy loop? I rather not do that.

> +	} else if (qca->memdump_state == QCA_MEMDUMP_COLLECTING) {
> +		/* Let us wait here until memory dump collected or
> +		 * memory dump timer expired.
> +		 */
> +		bt_dev_info(hdev, "waiting for dump to complete");
> +		while (qca->memdump_state == QCA_MEMDUMP_COLLECTING)
> +			;
> +	}
> +
> +	qca->memdump_state = QCA_MEMDUMP_IDLE;
> +}
> +
> static int qca_wcn3990_init(struct hci_uart *hu)
> {
> 	struct hci_dev *hdev = hu->hdev;
> @@ -1229,6 +1492,10 @@ static int qca_setup(struct hci_uart *hu)
> 	if (!ret) {
> 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
> 		qca_debugfs_init(hdev);
> +		/* We only get controller dump when fw download is
> +		 * successful.
> +		 */
> +		hu->hdev->hw_error = qca_hw_error;

I would set this all the time and handle it with a flag if firmware downloaded has succeeded or not.

> 	} else if (ret == -ENOENT) {
> 		/* No patch/nvm-config found, run with original fw/config */
> 		ret = 0;

Regards

Marcel


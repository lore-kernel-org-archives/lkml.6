Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6050C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB7A20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C/R5zk0S";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d1SOzUDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390246AbfAPOB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:01:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33110 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387726AbfAPOB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:01:59 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0D74A6121D; Wed, 16 Jan 2019 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547647318;
        bh=Ww3Sc84qJxGOYsvxDkDc7OsigJa8uHHAikI5eJfQaFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C/R5zk0S+4LIKxTf0sFDkuf9Gst3XLf2ElqR2AZkWMC4XW0ey5ZiX3NusvI6phGBj
         yyRtqFD4YgLOwSf88rfw3lMfTWtlb6dOV61L988LvuTc2sLsLbTJ3ee2SzX2WUgJ3Z
         QOOP/4Gc8SD3KragVofE22vt5SQXYjY0o95doiFo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B4166611E2;
        Wed, 16 Jan 2019 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547647314;
        bh=Ww3Sc84qJxGOYsvxDkDc7OsigJa8uHHAikI5eJfQaFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d1SOzUDiV/WU9RghTKUMGSgmLjsE5aw/+FGTFxr9kiLWbvHUW8ndiQRhwBVW1Q6vu
         VFTN6ulYiEIfo895POmCnpuKtxGik0ku0QA2M+7xlu0enna/NIBFwELENVrH9+z0xf
         jiSR7GVKTthOpnlUDxVRO2eaz0c9QMBwiE+HBX/s=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Jan 2019 19:31:53 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC,v2] Bluetooth: hci_qca: Collect controller memory dump
 during SSR
In-Reply-To: <7FE05B13-885C-4454-8168-75411AF8F5C2@holtmann.org>
References: <20181228130411.23007-1-bgodavar@codeaurora.org>
 <8B1A4B0A-BFC3-44EC-A75F-D87DBA64625B@holtmann.org>
 <25b5db1596c46f41e883bd9fd971392b@codeaurora.org>
 <7FE05B13-885C-4454-8168-75411AF8F5C2@holtmann.org>
Message-ID: <95e5932be1a189ac2dae78c7b690dd03@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On 2019-01-04 14:41, Marcel Holtmann wrote:
> Hi Balakrishna,
> 
>>>> We will collect the ramdump of BT controller when hardware error 
>>>> event
>>>> received before rebooting the HCI layer. Before restarting a 
>>>> subsystem
>>>> or a process running on a subsystem, it is often required to request
>>>> either a subsystem or a process to perform proper cache dump and
>>>> software failure reason into a memory buffer which application
>>>> processor can retrieve afterwards. SW developers can often provide
>>>> initial investigation by looking into that debugging information.
>>>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>>>> ---
>>>> changes v2:
>>>> * entirely an newer approach handling with an work queue.
>>>> ---
>>>> drivers/bluetooth/hci_qca.c | 289 
>>>> ++++++++++++++++++++++++++++++++++--
>>>> 1 file changed, 278 insertions(+), 11 deletions(-)
>>>> diff --git a/drivers/bluetooth/hci_qca.c 
>>>> b/drivers/bluetooth/hci_qca.c
>>>> index f036c8f98ea3..62b768bc32ec 100644
>>>> --- a/drivers/bluetooth/hci_qca.c
>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>> @@ -32,6 +32,7 @@
>>>> #include <linux/clk.h>
>>>> #include <linux/debugfs.h>
>>>> #include <linux/delay.h>
>>>> +#include <linux/devcoredump.h>
>>>> #include <linux/device.h>
>>>> #include <linux/gpio/consumer.h>
>>>> #include <linux/mod_devicetable.h>
>>> don't we have some crashdump core facility that could be utilized 
>>> here?
>> 
>> [Bala]: no i don't think so. that is reason calling devcoredump.h
> 
> what is wrong with using devcoredump.h?
> 

[Bala]: using the  devcoredump.h

>>>> @@ -57,9 +58,10 @@
>>>> /* Controller states */
>>>> #define STATE_IN_BAND_SLEEP_ENABLED	1
>>>> -#define IBS_WAKE_RETRANS_TIMEOUT_MS	100
>>>> +#define	IBS_WAKE_RETRANS_TIMEOUT_MS	100
>>>> #define IBS_TX_IDLE_TIMEOUT_MS		2000
>>>> -#define BAUDRATE_SETTLE_TIMEOUT_MS	300
>>>> +#define	BAUDRATE_SETTLE_TIMEOUT_MS	300
>>>> +#define MEMDUMP_COLLECTION_TIMEOUT_MS	8000
>>>> /* susclk rate */
>>>> #define SUSCLK_RATE_32KHZ	32768
>>>> @@ -67,6 +69,13 @@
>>>> /* Controller debug log header */
>>>> #define QCA_DEBUG_HANDLE	0x2EDC
>>>> +/* Controller dump header */
>>>> +#define QCA_SSR_DUMP_HANDLE		0x0108
>>>> +#define QCA_DUMP_PACKET_SIZE		255
>>>> +#define QCA_LAST_SEQUENCE_NUM		0xFFFF
>>>> +#define QCA_CRASHBYTE_PACKET_LEN	1100
>>>> +#define QCA_MEMDUMP_BYTE		0xFB
>>>> +
>>>> /* HCI_IBS transmit side sleep protocol states */
>>>> enum tx_ibs_states {
>>>> 	HCI_IBS_TX_ASLEEP,
>>>> @@ -89,12 +98,41 @@ enum hci_ibs_clock_state_vote {
>>>> 	HCI_IBS_RX_VOTE_CLOCK_OFF,
>>>> };
>>>> +/* Controller memory dump states */
>>>> +enum qca_memdump_states {
>>>> +	QCA_MEMDUMP_IDLE,
>>>> +	QCA_MEMDUMP_COLLECTING,
>>>> +	QCA_MEMDUMP_COLLECTED,
>>>> +	QCA_MEMDUMP_TIMEOUT,
>>>> +};
>>>> +
>>>> +struct qca_memdump_data {
>>>> +	char *memdump_buf_head;
>>>> +	char *memdump_buf_tail;
>>>> +	u32 current_seq_no;
>>>> +	u32 received_dump;
>>>> +};
>>>> +
>>>> +struct qca_memdump_event_hdr {
>>>> +	__u8    evt;
>>>> +	__u8    plen;
>>>> +	__u16   opcode;
>>>> +	__u16   seq_no;
>>>> +	__u8    reserved;
>>>> +} __packed;
>>>> +
>>>> +
>>>> +struct qca_dump_size {
>>>> +	u32 dump_size;
>>>> +} __packed;
>>>> +
>>>> struct qca_data {
>>>> 	struct hci_uart *hu;
>>>> 	struct sk_buff *rx_skb;
>>>> 	struct sk_buff_head txq;
>>>> -	struct sk_buff_head tx_wait_q;	/* HCI_IBS wait queue	*/
>>>> -	spinlock_t hci_ibs_lock;	/* HCI_IBS state lock	*/
>>>> +	struct sk_buff_head tx_wait_q;		/* HCI_IBS wait queue	*/
>>>> +	struct sk_buff_head rx_memdump_q;	/* Memdump wait queue	*/
>>>> +	spinlock_t hci_ibs_lock;		/* HCI_IBS state lock	*/
>>>> 	u8 tx_ibs_state;	/* HCI_IBS transmit side power state*/
>>>> 	u8 rx_ibs_state;	/* HCI_IBS receive side power state */
>>>> 	bool tx_vote;		/* Clock must be on for TX */
>>>> @@ -103,12 +141,17 @@ struct qca_data {
>>>> 	u32 tx_idle_delay;
>>>> 	struct timer_list wake_retrans_timer;
>>>> 	u32 wake_retrans;
>>>> +	struct timer_list memdump_timer;
>>>> +	u32 memdump_delay;
>>>> 	struct workqueue_struct *workqueue;
>>>> 	struct work_struct ws_awake_rx;
>>>> 	struct work_struct ws_awake_device;
>>>> 	struct work_struct ws_rx_vote_off;
>>>> 	struct work_struct ws_tx_vote_off;
>>>> +	struct work_struct ctrl_memdump_evt;
>>>> +	struct qca_memdump_data *qca_memdump;
>>>> 	unsigned long flags;
>>>> +	enum qca_memdump_states memdump_state;
>>>> 	/* For debugging purpose */
>>>> 	u64 ibs_sent_wacks;
>>>> @@ -173,6 +216,7 @@ struct qca_serdev {
>>>> static int qca_power_setup(struct hci_uart *hu, bool on);
>>>> static void qca_power_shutdown(struct hci_uart *hu);
>>>> static int qca_power_off(struct hci_dev *hdev);
>>>> +static void qca_controller_memdump(struct work_struct *work);
>>>> static void __serial_clock_on(struct tty_struct *tty)
>>>> {
>>>> @@ -446,6 +490,21 @@ static void hci_ibs_wake_retrans_timeout(struct 
>>>> timer_list *t)
>>>> 		hci_uart_tx_wakeup(hu);
>>>> }
>>>> +static void hci_memdump_timeout(struct timer_list *t)
>>>> +{
>>>> +	struct qca_data *qca = from_timer(qca, t, tx_idle_timer);
>>>> +	struct hci_uart *hu = qca->hu;
>>>> +	struct qca_memdump_data *qca_memdump = qca->qca_memdump;
>>>> +	char *memdump_buf = qca_memdump->memdump_buf_tail;
>>>> +
>>>> +	bt_dev_err(hu->hdev, "clearing allocated memory due to memdump 
>>>> timeout");
>>>> +	kfree(memdump_buf);
>>>> +	kfree(qca_memdump);
>>>> +	qca->memdump_state = QCA_MEMDUMP_TIMEOUT;
>>>> +	del_timer(&qca->memdump_timer);
>>>> +	cancel_work_sync(&qca->ctrl_memdump_evt);
>>>> +}
>>>> +
>>>> /* Initialize protocol */
>>>> static int qca_open(struct hci_uart *hu)
>>>> {
>>>> @@ -461,6 +520,7 @@ static int qca_open(struct hci_uart *hu)
>>>> 	skb_queue_head_init(&qca->txq);
>>>> 	skb_queue_head_init(&qca->tx_wait_q);
>>>> +	skb_queue_head_init(&qca->rx_memdump_q);
>>>> 	spin_lock_init(&qca->hci_ibs_lock);
>>>> 	qca->workqueue = alloc_ordered_workqueue("qca_wq", 0);
>>>> 	if (!qca->workqueue) {
>>>> @@ -473,6 +533,7 @@ static int qca_open(struct hci_uart *hu)
>>>> 	INIT_WORK(&qca->ws_awake_device, qca_wq_awake_device);
>>>> 	INIT_WORK(&qca->ws_rx_vote_off, qca_wq_serial_rx_clock_vote_off);
>>>> 	INIT_WORK(&qca->ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);
>>>> +	INIT_WORK(&qca->ctrl_memdump_evt, qca_controller_memdump);
>>>> 	qca->hu = hu;
>>>> @@ -500,7 +561,7 @@ static int qca_open(struct hci_uart *hu)
>>>> 	qca->tx_votes_off = 0;
>>>> 	qca->rx_votes_on = 0;
>>>> 	qca->rx_votes_off = 0;
>>>> -
>>>> +	qca->memdump_state = QCA_MEMDUMP_IDLE;
>>>> 	hu->priv = qca;
>>>> 	if (hu->serdev) {
>>>> @@ -528,6 +589,9 @@ static int qca_open(struct hci_uart *hu)
>>>> 	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
>>>> 	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
>>>> +	timer_setup(&qca->memdump_timer, hci_memdump_timeout, 0);
>>>> +	qca->memdump_delay = MEMDUMP_COLLECTION_TIMEOUT_MS;
>>>> +
>>>> 	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
>>>> 	       qca->tx_idle_delay, qca->wake_retrans);
>>>> @@ -605,8 +669,10 @@ static int qca_close(struct hci_uart *hu)
>>>> 	skb_queue_purge(&qca->tx_wait_q);
>>>> 	skb_queue_purge(&qca->txq);
>>>> +	skb_queue_purge(&qca->rx_memdump_q);
>>>> 	del_timer(&qca->tx_idle_timer);
>>>> 	del_timer(&qca->wake_retrans_timer);
>>>> +	del_timer(&qca->memdump_timer);
>>>> 	destroy_workqueue(qca->workqueue);
>>>> 	qca->hu = NULL;
>>>> @@ -866,6 +932,141 @@ static int qca_recv_acl_data(struct hci_dev 
>>>> *hdev, struct sk_buff *skb)
>>>> 	return hci_recv_frame(hdev, skb);
>>>> }
>>>> +static void qca_controller_memdump(struct work_struct *work)
>>>> +{
>>>> +	struct qca_data *qca = container_of(work, struct qca_data,
>>>> +					    ctrl_memdump_evt);
>>>> +	struct hci_uart *hu = qca->hu;
>>>> +	struct sk_buff *skb;
>>>> +	struct qca_memdump_event_hdr *cmd_hdr;
>>>> +	struct qca_memdump_data *qca_memdump = qca->qca_memdump;
>>>> +	struct qca_dump_size *dump;
>>>> +	char *memdump_buf;
>>>> +	char nullBuff[QCA_DUMP_PACKET_SIZE] = { 0 };
>>>> +	u16 opcode, seq_no;
>>>> +	u32 dump_size;
>>>> +
>>>> +	while ((skb = skb_dequeue(&qca->rx_memdump_q))) {
>>>> +
>>>> +		if (!qca_memdump) {
>>>> +			qca_memdump = kzalloc(sizeof(struct qca_memdump_data),
>>>> +					      GFP_ATOMIC);
>>>> +			if (!qca_memdump)
>>>> +				return;
>>>> +
>>>> +			qca->qca_memdump = qca_memdump;
>>>> +		}
>>>> +
>>>> +		qca->memdump_state = QCA_MEMDUMP_COLLECTING;
>>>> +		cmd_hdr = (void *) skb->data;
>>>> +		opcode = __le16_to_cpu(cmd_hdr->opcode);
>>>> +		seq_no = __le16_to_cpu(cmd_hdr->seq_no);
>>>> +		skb_pull(skb, sizeof(struct qca_memdump_event_hdr));
>>>> +
>>>> +		if (!seq_no) {
>>>> +
>>>> +			/* This is the first frame of memdump packet from
>>>> +			 * the controller, Disable IBS to recevie dump
>>>> +			 * with out any interruption, ideally time required for
>>>> +			 * the controller to send the dump is 8 seconds. let us
>>>> +			 * start timer to handle this asynchronous activity.
>>>> +			 */
>>>> +			clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>>>> +
>>>> +			dump = (void *) skb->data;
>>>> +			dump_size = __le32_to_cpu(dump->dump_size);
>>>> +			if (!(dump_size)) {
>>>> +				bt_dev_err(hu->hdev, "QCA invalid memdump size");
>>>> +				kfree_skb(skb);
>>>> +				return;
>>>> +			}
>>>> +
>>>> +			bt_dev_info(hu->hdev, "QCA: collecting memdump started"
>>>> +				     "of size:%u", dump_size);
>>>> +			mod_timer(&qca->memdump_timer, (jiffies +
>>>> +				  msecs_to_jiffies(qca->memdump_delay)));
>>>> +
>>>> +			skb_pull(skb, sizeof(dump_size));
>>>> +			memdump_buf = vmalloc(dump_size);
>>>> +			qca_memdump->memdump_buf_head = memdump_buf;
>>>> +			qca_memdump->memdump_buf_tail = memdump_buf;
>>>> +		}
>>>> +
>>>> +		memdump_buf = qca_memdump->memdump_buf_tail;
>>>> +
>>>> +		/* If sequence no 0 is missed then there is no point in
>>>> +		 * accepting the other sequences.
>>>> +		 */
>>>> +		if (!memdump_buf) {
>>>> +			bt_dev_err(hu->hdev, "QCA: Discarding other packets");
>>>> +			kfree(qca_memdump);
>>>> +			kfree_skb(skb);
>>>> +			qca->qca_memdump = NULL;
>>>> +			return;
>>>> +		}
>>>> +
>>>> +		/* There could be chance of missing some packets from
>>>> +		 * the controller. In such cases let us store the dummy
>>>> +		 * packets in the buffer.
>>>> +		 */
>>>> +		while ((seq_no > qca_memdump->current_seq_no + 1) &&
>>>> +			seq_no != QCA_LAST_SEQUENCE_NUM) {
>>>> +			bt_dev_err(hu->hdev, "QCA controller missed packet:%d",
>>>> +				   qca_memdump->current_seq_no);
>>>> +			memcpy(memdump_buf, nullBuff, QCA_DUMP_PACKET_SIZE);
>>>> +			memdump_buf = memdump_buf + QCA_DUMP_PACKET_SIZE;
>>>> +			qca_memdump->received_dump += QCA_DUMP_PACKET_SIZE;
>>>> +			qca_memdump->current_seq_no++;
>>>> +		}
>>>> +
>>>> +		memcpy(memdump_buf, (unsigned char *) skb->data, skb->len);
>>>> +		memdump_buf = memdump_buf + skb->len;
>>>> +		qca_memdump->memdump_buf_tail = memdump_buf;
>>>> +		qca_memdump->current_seq_no = seq_no + 1;
>>>> +		qca_memdump->received_dump += skb->len;
>>>> +		qca->qca_memdump = qca_memdump;
>>>> +		kfree_skb(skb);
>>>> +		if (seq_no == QCA_LAST_SEQUENCE_NUM) {
>>>> +			bt_dev_info(hu->hdev, "QCA writing crash dump of size %d bytes",
>>>> +				   qca_memdump->received_dump);
>>>> +			memdump_buf = qca_memdump->memdump_buf_head;
>>>> +			dev_coredumpv(&hu->serdev->dev, memdump_buf,
>>>> +				      qca_memdump->received_dump, GFP_KERNEL);
>>>> +			// Revisit for free(memdump) if needed.
>>>> +			del_timer(&qca->memdump_timer);
>>>> +			kfree(qca->qca_memdump);
>>>> +			qca->qca_memdump = NULL;
>>>> +			qca->memdump_state = QCA_MEMDUMP_COLLECTED;
>>>> +		}
>>>> +	}
>>>> +
>>>> +}
>>>> +
>>>> +int qca_controller_memdump_event(struct hci_dev *hdev, struct 
>>>> sk_buff *skb)
>>>> +{
>>>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>>>> +	struct qca_data *qca = hu->priv;
>>>> +
>>>> +	skb_queue_tail(&qca->rx_memdump_q, skb);
>>>> +	queue_work(qca->workqueue, &qca->ctrl_memdump_evt);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int qca_recv_event_data(struct hci_dev *hdev, struct sk_buff 
>>>> *skb)
>>>> +{
>>>> +	/* We receive chip memory dump as an event packet, With a 
>>>> dedicated
>>>> +	 * handler followed by a hardware error event. When this event is
>>>> +	 * received we store dump into a file before closing hci. This
>>>> +	 * dump will help in triaging the issues.
>>>> +	 */
>>>> +	if ((skb->data[0] == HCI_VENDOR_PKT) &&
>>>> +	    (get_unaligned_be16((skb->data) + 2) == QCA_SSR_DUMP_HANDLE))
>>> The (skb->data) is pointless, just do skb->data.
>> [Bala]: will update.
>> 
>>>> +		return qca_controller_memdump_event(hdev, skb);
>>>> +
>>>> +	return hci_recv_frame(hdev, skb);
>>>> +}
>>>> +
>>>> #define QCA_IBS_SLEEP_IND_EVENT \
>>>> 	.type = HCI_IBS_SLEEP_IND, \
>>>> 	.hlen = 0, \
>>>> @@ -888,12 +1089,12 @@ static int qca_recv_acl_data(struct hci_dev 
>>>> *hdev, struct sk_buff *skb)
>>>> 	.maxlen = HCI_MAX_IBS_SIZE
>>>> static const struct h4_recv_pkt qca_recv_pkts[] = {
>>>> -	{ H4_RECV_ACL,             .recv = qca_recv_acl_data },
>>>> -	{ H4_RECV_SCO,             .recv = hci_recv_frame    },
>>>> -	{ H4_RECV_EVENT,           .recv = hci_recv_frame    },
>>>> -	{ QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_wake_ind  },
>>>> -	{ QCA_IBS_WAKE_ACK_EVENT,  .recv = qca_ibs_wake_ack  },
>>>> -	{ QCA_IBS_SLEEP_IND_EVENT, .recv = qca_ibs_sleep_ind },
>>>> +	{ H4_RECV_ACL,             .recv = qca_recv_acl_data	},
>>>> +	{ H4_RECV_SCO,             .recv = hci_recv_frame	},
>>>> +	{ H4_RECV_EVENT,           .recv = qca_recv_event_data	},
>>> call it qca_recv_event and don't realign the whole table.
>> [Bala]: will update.
>> 
>>>> +	{ QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_wake_ind	},
>>>> +	{ QCA_IBS_WAKE_ACK_EVENT,  .recv = qca_ibs_wake_ack	},
>>>> +	{ QCA_IBS_SLEEP_IND_EVENT, .recv = qca_ibs_sleep_ind	},
>>>> };
>>>> static int qca_recv(struct hci_uart *hu, const void *data, int 
>>>> count)
>>>> @@ -1114,6 +1315,68 @@ static int qca_set_speed(struct hci_uart *hu, 
>>>> enum qca_speed_type speed_type)
>>>> 	return 0;
>>>> }
>>>> +static int qca_send_crashbuffer(struct hci_uart *hu)
>>>> +{
>>>> +	struct qca_data *qca = hu->priv;
>>>> +	struct sk_buff *skb;
>>>> +	unsigned char buf[QCA_CRASHBYTE_PACKET_LEN];
>>>> +
>>>> +	bt_dev_dbg(hu->hdev, "sending soc crash buffer to controller");
>>>> +
>>>> +	/* We forcefully crash the controller, by sending 0xfb byte for
>>>> +	 * 1024 times. We also might have chance of losing data, To be
>>>> +	 * on safer side we send 1100 bytes to the SoC.
>>>> +	 */
>>>> +	memset(buf, QCA_MEMDUMP_BYTE, QCA_CRASHBYTE_PACKET_LEN);
>>>> +
>>>> +	skb = bt_skb_alloc(QCA_CRASHBYTE_PACKET_LEN, GFP_KERNEL);
>>>> +	if (!skb) {
>>>> +		bt_dev_err(hu->hdev, "Failed to allocate memory for skb packet");
>>>> +		return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	skb_put_data(skb, buf, QCA_CRASHBYTE_PACKET_LEN);
>>>> +	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
>>>> +
>>>> +	skb_queue_tail(&qca->txq, skb);
>>>> +	hci_uart_tx_wakeup(hu);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void qca_hw_error(struct hci_dev *hdev, u8 code)
>>>> +{
>>>> +	struct hci_uart *hu = hci_get_drvdata(hdev);
>>>> +	struct qca_data *qca = hu->priv;
>>>> +
>>>> +	bt_dev_info(hdev, "mem_dump_status: %d", qca->memdump_state);
>>>> +
>>>> +	if (qca->memdump_state == QCA_MEMDUMP_IDLE) {
>>>> +		/* If hardware error event received for other than QCA
>>>> +		 * soc memory dump event, then we need to crash the SOC
>>>> +		 * and wait here for 8 seconds to get the dump packets.
>>>> +		 * This will block main thread to be on hold until we
>>>> +		 * collect dump.
>>>> +		 */
>>>> +		mod_timer(&qca->memdump_timer,
>>>> +			  (jiffies + msecs_to_jiffies(qca->memdump_delay)));
>>> Why a timer that then ends up in interrupt context?
>> [Bala]: some times we only receive hardware error from the chip, so we 
>> are sending an special buffer to request the
>>        chip for memory dump. we are using an timer to check whether 
>> the data memdump is collected. if the timer
>>        over flows we are cleaning up all the assigned memory and 
>> unblock the main thread,
>>        in short this timer is a watch dog timer for the memory dump 
>> collection.
> 
> I saw that you used a bunch of timers actually. My question is why are
> these not delayed_wq instead? I wonder if we really want to keep using
> timers and handling interrupt context locking if we could move
> everything to wq instead.
> 

[Bala]: Let me brief you the requirement.
        This patch is used to collect the memory dump received from the 
chip and store it into a file.
        We receive chip memory dump in two cases
         1. When chip goes into the bad state it sends the dump followed 
by and hardware error event.
         2. Some time when we send some garbage or un recognized command 
to chip.
            it will respond with a hardware error event. So we send an 
0xfb bytes to the chip requesting it to send the memory dump.

In both cases, chip will go into the bad state once it sends the dump. 
so we need to turn OFF and ON chip and perform the init procedure.
So keeping the above cases in the view, we register an handle for 
hardware error event. So that in both the cases hw error routine will 
execute.

As the dump as some specific headers we will queue the received data 
into work queue.
We are blocking the main thread until the total dump is stored into the 
file.
Here is the answer for the question, yes we check the status of the work 
queue but for handling case 2 we require timers.
But let us assume the wq is taking more time than expected. Then we also 
need a timer.
we are using timer so that we will not block the main thread 
indefinitely.
They are some cases where when we request a memory dump, after some 
packet sent by the chip.
it may go into a bad state where it will not pump the remaining dump, so 
we are using a timer to unblock the main thread.
so during timeout, we are restarting the flags to unblock the main 
thread.


>>>> +		qca_send_crashbuffer(hu);
>>>> +
>>>> +		while (qca->memdump_state != QCA_MEMDUMP_COLLECTED &&
>>>> +			qca->memdump_state != QCA_MEMDUMP_TIMEOUT)
>>>> +			;
>>> What is this? Busy loop? I rather not do that.
>> [Bala]: this busy required to collected the dump from the chip before 
>> we close an reopen the hci.
>>        >> +	} else if (qca->memdump_state == QCA_MEMDUMP_COLLECTING) {
> 
> Why not use some wakeup handling here. I am really against any kind of
> busy loops in a driver.
> 
[Bala]: this busy loop is require. pls refer my comments to the above 
query.
         this will help in mainly in case 2, where we will block the main 
thread until we have dump collected.

         let us assume that we received an hardware error event, hw error 
routine we execute which sends an
         special byte to the chip requesting for memory dump. it starts 
sending the dump, but we move forward and turn off the
         chip so we will miss the dump. so here the busy loop is to wait 
until we have dump.
         but the we are not waiting indefinitely we have timer to unblock 
them.

>>>> +		/* Let us wait here until memory dump collected or
>>>> +		 * memory dump timer expired.
>>>> +		 */
>>>> +		bt_dev_info(hdev, "waiting for dump to complete");
>>>> +		while (qca->memdump_state == QCA_MEMDUMP_COLLECTING)
>>>> +			;
>>>> +	}
>>>> +
>>>> +	qca->memdump_state = QCA_MEMDUMP_IDLE;
>>>> +}
>>>> +
>>>> static int qca_wcn3990_init(struct hci_uart *hu)
>>>> {
>>>> 	struct hci_dev *hdev = hu->hdev;
>>>> @@ -1229,6 +1492,10 @@ static int qca_setup(struct hci_uart *hu)
>>>> 	if (!ret) {
>>>> 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
>>>> 		qca_debugfs_init(hdev);
>>>> +		/* We only get controller dump when fw download is
>>>> +		 * successful.
>>>> +		 */
>>>> +		hu->hdev->hw_error = qca_hw_error;
>>> I would set this all the time and handle it with a flag if firmware
>>> downloaded has succeeded or not.
>> [Bala]: ok will update.
>> 
>>>> 	} else if (ret == -ENOENT) {
>>>> 		/* No patch/nvm-config found, run with original fw/config */
>>>> 		ret = 0;
> 
> Regards
> 
> Marcel

-- 
Regards
Balakrishna.

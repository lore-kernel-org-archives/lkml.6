Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8309C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E03214DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5E03214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeHBKiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:38:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25310 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726238AbeHBKiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:38:54 -0400
X-UUID: cf3e8c647ff744d081280c1c7210d9bc-20180802
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1155798886; Thu, 02 Aug 2018 16:48:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 2 Aug 2018 16:48:39 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 2 Aug 2018 16:48:40 +0800
Message-ID: <1533199720.3472.136.camel@mtkswgap22>
Subject: Re: [PATCH v7 2/3] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
From:   Sean Wang <sean.wang@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 2 Aug 2018 16:48:40 +0800
In-Reply-To: <FF45A90A-F9F1-47CB-AB1F-1E92BF587FBE@holtmann.org>
References: <cover.1533056925.git.sean.wang@mediatek.com>
         <c92ed10cf16f36d9a3b390e864af92e2dfe7b771.1533056925.git.sean.wang@mediatek.com>
         <1707FFA1-A294-4A95-A3BF-0910CE455232@holtmann.org>
         <1533192799.3472.122.camel@mtkswgap22>
         <FF45A90A-F9F1-47CB-AB1F-1E92BF587FBE@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 09:38 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 

[ ... ]

> >>> +
> >>> +static int mtk_hci_wmt_sync(struct hci_dev *hdev, u8 op, u8 flag, u16 plen,
> >>> +			    const void *param)
> >>> +{
> >>> +	struct mtk_hci_wmt_cmd wc;
> >>> +	struct mtk_wmt_hdr *hdr;
> >>> +	struct sk_buff *skb;
> >>> +	u32 hlen;
> >>> +
> >>> +	hlen = sizeof(*hdr) + plen;
> >>> +	if (hlen > 255)
> >>> +		return -EINVAL;
> >>> +
> >>> +	hdr = (struct mtk_wmt_hdr *)&wc;
> >>> +	hdr->dir = 1;
> >>> +	hdr->op = op;
> >>> +	hdr->dlen = cpu_to_le16(plen + 1);
> >>> +	hdr->flag = flag;
> >>> +	memcpy(wc.data, param, plen);
> >>> +
> >>> +	atomic_inc(&hdev->cmd_cnt);
> >> 
> >> Why are you doing this one. It will need a comment here if really needed. However I doubt that this is needed. You are only using it from hdev->setup and hdev->shutdown callbacks.
> >> 
> > 
> > An increment on cmd_cnt is really needed because hci_cmd_work would check whether cmd_cnt is positive and then has a decrement on cmd_cnt before a packet is being sent out.
> > 
> > okay will add a comment.
> 
> but you are in ->setup callback this time. So if you need this, then all the other ->setup routines would actually fail as well. Either this is leftover from when you did things in ->probe or ->open or this is some thing we might better fix properly in the core instead of papering over it. Can you recheck if this is really needed.
> 

I added a counter print and the counter increments as below

	/* atomic_inc(&hdev->cmd_cnt); */
        pr_info("cmd_cnt = %d\n" , atomic_read(&hdev->cmd_cnt));

        skb = __hci_cmd_sync_ev(hdev, 0xfc6f, hlen, &wc, HCI_VENDOR_PKT,
                                HCI_INIT_TIMEOUT);

and the log show up that 


[  334.049156] Bluetooth: hci0: command 0xfc6f tx timeout
[  334.054840] cmd_cnt = 0
[  336.065076] Bluetooth: hci0: command 0xfc6f tx timeout
[  336.070795] cmd_cnt = 0
[  338.080997] Bluetooth: hci0: command 0xfc6f tx timeout
[  338.086683] cmd_cnt = 0
[  340.096907] Bluetooth: hci0: command 0xfc6f tx timeout
[  340.102609] cmd_cnt = 0
[  342.112824] Bluetooth: hci0: command 0xfc6f tx timeout
[  342.118520] cmd_cnt = 0
[  344.128747] Bluetooth: hci0: command 0xfc6f tx timeout
[  344.134454] cmd_cnt = 0
[  346.144667] Bluetooth: hci0: command 0xfc6f tx timeout
[  346.150372] cmd_cnt = 0


The packet is dropped by hci_cmd_work at [1], so I also wondered why the
other vendor driver works, it seems the counter needs to be incremented
before every skb is being queued to cmd_q.

4257 static void hci_cmd_work(struct work_struct *work)
4258 {
4259         struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_work);
4260         struct sk_buff *skb;
4261
4262         BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
4263                atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
4264
4265         /* Send queued commands */

[1]
4266         if (atomic_read(&hdev->cmd_cnt)) { /* dropped when cmd_cnt is zero */
4267                 skb = skb_dequeue(&hdev->cmd_q);
4268                 if (!skb)
4269                         return;
4270
4271                 kfree_skb(hdev->sent_cmd);
4272
4273                 hdev->sent_cmd = skb_clone(skb, GFP_KERNEL);
4274                 if (hdev->sent_cmd) {
4275                         atomic_dec(&hdev->cmd_cnt);  /* cmd_cnt-- */
4276                         hci_send_frame(hdev, skb);


> >>> +
> >>> +	skb = __hci_cmd_sync_ev(hdev, 0xfc6f, hlen, &wc, HCI_VENDOR_PKT,
> >>> +				HCI_INIT_TIMEOUT);
> >>> +
> >>> +	if (IS_ERR(skb)) {
> >>> +		int err = PTR_ERR(skb);
> >>> +
> >>> +		bt_dev_err(hdev, "Failed to send wmt cmd (%d)", err);
> >>> +		return err;
> >>> +	}
> >>> +
> >>> +	kfree_skb(skb);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +

[ ... ]

> >>> +	shdr->dlen2 = dlen & 0xff;
> >>> +	shdr->cs = p[0] + p[1] + p[2];
> >> 
> > 
> > as above discussion about shr->cs , it can be filled with zero to have less computing 
> 
> If it has no value, then zero it out and add a comment for it.
> 

okay

> > 
> >> I would add another comment here that this added the STP trailer. And change the above to mention it adds the STP header.
> >> 
> > 
> > sure
> > 
> >> And you might want to check if there is space for the trailer as well. Otherwise skb_put tends to call BUG() if I remember correctly. I know this is super unlikely since our bt_skb_alloc is pretty large.
> >> 
> > 
> > sure, I will add the handling for that. it should be better to make sure all rooms are enough for header and trailer before adding content to them
> > 
> > 

[ ... ]

> >> You want to add a MODULE_FIRMWARE here as well.
> >> 
> > 
> > okay
> 
> Regards
> 
> Marcel
> 



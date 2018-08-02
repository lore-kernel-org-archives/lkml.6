Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F7BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D09B21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D09B21501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbeHBMPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 08:15:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58574 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726313AbeHBMPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 08:15:35 -0400
X-UUID: 3b804e0005604e5da4d3cc2edd90ef29-20180802
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 903017659; Thu, 02 Aug 2018 18:24:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 2 Aug 2018 18:24:55 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 2 Aug 2018 18:24:55 +0800
Message-ID: <1533205495.3472.144.camel@mtkswgap22>
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
Date:   Thu, 2 Aug 2018 18:24:55 +0800
In-Reply-To: <9526E5D9-50BA-4D57-80F5-083DB7D28AFE@holtmann.org>
References: <cover.1533056925.git.sean.wang@mediatek.com>
         <c92ed10cf16f36d9a3b390e864af92e2dfe7b771.1533056925.git.sean.wang@mediatek.com>
         <1707FFA1-A294-4A95-A3BF-0910CE455232@holtmann.org>
         <1533192799.3472.122.camel@mtkswgap22>
         <FF45A90A-F9F1-47CB-AB1F-1E92BF587FBE@holtmann.org>
         <1533199720.3472.136.camel@mtkswgap22>
         <9526E5D9-50BA-4D57-80F5-083DB7D28AFE@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 11:45 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> >>>>> +
> >>>>> +static int mtk_hci_wmt_sync(struct hci_dev *hdev, u8 op, u8 flag, u16 plen,
> >>>>> +			    const void *param)
> >>>>> +{
> >>>>> +	struct mtk_hci_wmt_cmd wc;
> >>>>> +	struct mtk_wmt_hdr *hdr;
> >>>>> +	struct sk_buff *skb;
> >>>>> +	u32 hlen;
> >>>>> +
> >>>>> +	hlen = sizeof(*hdr) + plen;
> >>>>> +	if (hlen > 255)
> >>>>> +		return -EINVAL;
> >>>>> +
> >>>>> +	hdr = (struct mtk_wmt_hdr *)&wc;
> >>>>> +	hdr->dir = 1;
> >>>>> +	hdr->op = op;
> >>>>> +	hdr->dlen = cpu_to_le16(plen + 1);
> >>>>> +	hdr->flag = flag;
> >>>>> +	memcpy(wc.data, param, plen);
> >>>>> +
> >>>>> +	atomic_inc(&hdev->cmd_cnt);
> >>>> 
> >>>> Why are you doing this one. It will need a comment here if really needed. However I doubt that this is needed. You are only using it from hdev->setup and hdev->shutdown callbacks.
> >>>> 
> >>> 
> >>> An increment on cmd_cnt is really needed because hci_cmd_work would check whether cmd_cnt is positive and then has a decrement on cmd_cnt before a packet is being sent out.
> >>> 
> >>> okay will add a comment.
> >> 
> >> but you are in ->setup callback this time. So if you need this, then all the other ->setup routines would actually fail as well. Either this is leftover from when you did things in ->probe or ->open or this is some thing we might better fix properly in the core instead of papering over it. Can you recheck if this is really needed.
> >> 
> > 
> > I added a counter print and the counter increments as below
> > 
> > 	/* atomic_inc(&hdev->cmd_cnt); */
> >        pr_info("cmd_cnt = %d\n" , atomic_read(&hdev->cmd_cnt));
> > 
> >        skb = __hci_cmd_sync_ev(hdev, 0xfc6f, hlen, &wc, HCI_VENDOR_PKT,
> >                                HCI_INIT_TIMEOUT);
> > 
> > and the log show up that 
> > 
> > 
> > [  334.049156] Bluetooth: hci0: command 0xfc6f tx timeout
> > [  334.054840] cmd_cnt = 0
> > [  336.065076] Bluetooth: hci0: command 0xfc6f tx timeout
> > [  336.070795] cmd_cnt = 0
> > [  338.080997] Bluetooth: hci0: command 0xfc6f tx timeout
> > [  338.086683] cmd_cnt = 0
> > [  340.096907] Bluetooth: hci0: command 0xfc6f tx timeout
> > [  340.102609] cmd_cnt = 0
> > [  342.112824] Bluetooth: hci0: command 0xfc6f tx timeout
> > [  342.118520] cmd_cnt = 0
> > [  344.128747] Bluetooth: hci0: command 0xfc6f tx timeout
> > [  344.134454] cmd_cnt = 0
> > [  346.144667] Bluetooth: hci0: command 0xfc6f tx timeout
> > [  346.150372] cmd_cnt = 0
> > 
> > 
> > The packet is dropped by hci_cmd_work at [1], so I also wondered why the
> > other vendor driver works, it seems the counter needs to be incremented
> > before every skb is being queued to cmd_q.
> > 
> > 4257 static void hci_cmd_work(struct work_struct *work)
> > 4258 {
> > 4259         struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_work);
> > 4260         struct sk_buff *skb;
> > 4261
> > 4262         BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
> > 4263                atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
> > 4264
> > 4265         /* Send queued commands */
> > 
> > [1]
> > 4266         if (atomic_read(&hdev->cmd_cnt)) { /* dropped when cmd_cnt is zero */
> > 4267                 skb = skb_dequeue(&hdev->cmd_q);
> > 4268                 if (!skb)
> > 4269                         return;
> > 4270
> > 4271                 kfree_skb(hdev->sent_cmd);
> > 4272
> > 4273                 hdev->sent_cmd = skb_clone(skb, GFP_KERNEL);
> > 4274                 if (hdev->sent_cmd) {
> > 4275                         atomic_dec(&hdev->cmd_cnt);  /* cmd_cnt-- */
> > 4276                         hci_send_frame(hdev, skb);
> 
> actually the command also needs to better go via the raw_q anyway since it doesn’t come back with the cmd status or cmd complete. You have it waiting for a vendor event. Maybe with is something we need to consider with __hci_cmd_sync_ev anyway.
> 
> Johan would know best since he wrote that code. Anyway, we should fix that in the core and not have you hack around it.
> 

yes, my case is that received event is neither cmd status nor cmd complete. It is completely a vendor event.

if it wants to be solved by the core layer, do you permit that I remove the hack and then send it in the next version?

	Sean

> Regards
> 
> Marcel
> 



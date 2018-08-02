Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CB3C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8C721509
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8C721509
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbeHBLf2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:35:28 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49864 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeHBLf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:35:28 -0400
Received: from marcel-macpro.fritz.box (p4FEFCC41.dip0.t-ipconnect.de [79.239.204.65])
        by mail.holtmann.org (Postfix) with ESMTPSA id 349BCCEEAE;
        Thu,  2 Aug 2018 11:52:04 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v7 2/3] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1533199720.3472.136.camel@mtkswgap22>
Date:   Thu, 2 Aug 2018 11:45:04 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9526E5D9-50BA-4D57-80F5-083DB7D28AFE@holtmann.org>
References: <cover.1533056925.git.sean.wang@mediatek.com>
 <c92ed10cf16f36d9a3b390e864af92e2dfe7b771.1533056925.git.sean.wang@mediatek.com>
 <1707FFA1-A294-4A95-A3BF-0910CE455232@holtmann.org>
 <1533192799.3472.122.camel@mtkswgap22>
 <FF45A90A-F9F1-47CB-AB1F-1E92BF587FBE@holtmann.org>
 <1533199720.3472.136.camel@mtkswgap22>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

>>>>> +
>>>>> +static int mtk_hci_wmt_sync(struct hci_dev *hdev, u8 op, u8 flag, u16 plen,
>>>>> +			    const void *param)
>>>>> +{
>>>>> +	struct mtk_hci_wmt_cmd wc;
>>>>> +	struct mtk_wmt_hdr *hdr;
>>>>> +	struct sk_buff *skb;
>>>>> +	u32 hlen;
>>>>> +
>>>>> +	hlen = sizeof(*hdr) + plen;
>>>>> +	if (hlen > 255)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	hdr = (struct mtk_wmt_hdr *)&wc;
>>>>> +	hdr->dir = 1;
>>>>> +	hdr->op = op;
>>>>> +	hdr->dlen = cpu_to_le16(plen + 1);
>>>>> +	hdr->flag = flag;
>>>>> +	memcpy(wc.data, param, plen);
>>>>> +
>>>>> +	atomic_inc(&hdev->cmd_cnt);
>>>> 
>>>> Why are you doing this one. It will need a comment here if really needed. However I doubt that this is needed. You are only using it from hdev->setup and hdev->shutdown callbacks.
>>>> 
>>> 
>>> An increment on cmd_cnt is really needed because hci_cmd_work would check whether cmd_cnt is positive and then has a decrement on cmd_cnt before a packet is being sent out.
>>> 
>>> okay will add a comment.
>> 
>> but you are in ->setup callback this time. So if you need this, then all the other ->setup routines would actually fail as well. Either this is leftover from when you did things in ->probe or ->open or this is some thing we might better fix properly in the core instead of papering over it. Can you recheck if this is really needed.
>> 
> 
> I added a counter print and the counter increments as below
> 
> 	/* atomic_inc(&hdev->cmd_cnt); */
>        pr_info("cmd_cnt = %d\n" , atomic_read(&hdev->cmd_cnt));
> 
>        skb = __hci_cmd_sync_ev(hdev, 0xfc6f, hlen, &wc, HCI_VENDOR_PKT,
>                                HCI_INIT_TIMEOUT);
> 
> and the log show up that 
> 
> 
> [  334.049156] Bluetooth: hci0: command 0xfc6f tx timeout
> [  334.054840] cmd_cnt = 0
> [  336.065076] Bluetooth: hci0: command 0xfc6f tx timeout
> [  336.070795] cmd_cnt = 0
> [  338.080997] Bluetooth: hci0: command 0xfc6f tx timeout
> [  338.086683] cmd_cnt = 0
> [  340.096907] Bluetooth: hci0: command 0xfc6f tx timeout
> [  340.102609] cmd_cnt = 0
> [  342.112824] Bluetooth: hci0: command 0xfc6f tx timeout
> [  342.118520] cmd_cnt = 0
> [  344.128747] Bluetooth: hci0: command 0xfc6f tx timeout
> [  344.134454] cmd_cnt = 0
> [  346.144667] Bluetooth: hci0: command 0xfc6f tx timeout
> [  346.150372] cmd_cnt = 0
> 
> 
> The packet is dropped by hci_cmd_work at [1], so I also wondered why the
> other vendor driver works, it seems the counter needs to be incremented
> before every skb is being queued to cmd_q.
> 
> 4257 static void hci_cmd_work(struct work_struct *work)
> 4258 {
> 4259         struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_work);
> 4260         struct sk_buff *skb;
> 4261
> 4262         BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
> 4263                atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
> 4264
> 4265         /* Send queued commands */
> 
> [1]
> 4266         if (atomic_read(&hdev->cmd_cnt)) { /* dropped when cmd_cnt is zero */
> 4267                 skb = skb_dequeue(&hdev->cmd_q);
> 4268                 if (!skb)
> 4269                         return;
> 4270
> 4271                 kfree_skb(hdev->sent_cmd);
> 4272
> 4273                 hdev->sent_cmd = skb_clone(skb, GFP_KERNEL);
> 4274                 if (hdev->sent_cmd) {
> 4275                         atomic_dec(&hdev->cmd_cnt);  /* cmd_cnt-- */
> 4276                         hci_send_frame(hdev, skb);

actually the command also needs to better go via the raw_q anyway since it doesn’t come back with the cmd status or cmd complete. You have it waiting for a vendor event. Maybe with is something we need to consider with __hci_cmd_sync_ev anyway.

Johan would know best since he wrote that code. Anyway, we should fix that in the core and not have you hack around it.

Regards

Marcel


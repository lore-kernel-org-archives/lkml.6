Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754757AbeEHLSx convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 07:18:53 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48138 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753152AbeEHLSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 07:18:51 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v1 6/7] Bluetooth: hci_mediatek: Add protocol support for
 MediaTek serial devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1525767775.18877.22.camel@mtkswgap22>
Date: Tue, 8 May 2018 13:18:49 +0200
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6033F916-F103-4F07-9912-695B5B49F30F@holtmann.org>
References: <cover.1522736996.git.sean.wang@mediatek.com>
 <f0e0a0b7f1dc3845dc6eafb4ccd60284d1675f8d.1522736996.git.sean.wang@mediatek.com>
 <A7391E5D-2945-415B-8AB1-8DFBF2E65878@holtmann.org>
 <1525762084.14468.20.camel@mtkswgap22>
 <D474053D-6910-4B04-8B98-59B96FEB86BC@holtmann.org>
 <1525767775.18877.22.camel@mtkswgap22>
To: Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

>>>>> +
>>>>> +static int mtk_wmt_cmd_sync(struct hci_uart *hu, u8 opcode, u8 flag, u16 plen,
>>>>> +			    const void *param)
>>>>> +{
>>>>> +	struct mtk_bt_dev *btdev = hu->priv;
>>>>> +	struct hci_command_hdr *hhdr;
>>>>> +	struct hci_acl_hdr *ahdr;
>>>>> +	struct mtk_wmt_hdr *whdr;
>>>>> +	struct sk_buff *skb;
>>>>> +	int ret = 0;
>>>>> +
>>>>> +	init_completion(&btdev->wmt_cmd);
>>>>> +
>>>>> +	skb = bt_skb_alloc(plen + MTK_WMT_CMD_SIZE, GFP_KERNEL);
>>>>> +	if (!skb)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	/*
>>>>> +	 * WMT data is carried in either ACL or HCI format with op code as
>>>>> +	 * 0xfc6f and followed by a WMT header and its actual payload.
>>>>> +	 */
>>>> 
>>>> Please use net subsystem comment style.
>>>> 
>>>>> +	switch (opcode) {
>>>>> +	case MTK_WMT_PATCH_DWNLD:
>>>>> +		ahdr = skb_put(skb, HCI_ACL_HDR_SIZE);
>>>>> +		ahdr->handle = cpu_to_le16(0xfc6f);
>>>>> +		ahdr->dlen   = cpu_to_le16(plen + MTK_WMT_HDR_SIZE);
>>>>> +		break;
>>>>> +	default:
>>>>> +		hhdr = skb_put(skb, HCI_COMMAND_HDR_SIZE);
>>>>> +		hhdr->opcode = cpu_to_le16(0xfc6f);
>>>>> +		hhdr->plen = plen + MTK_WMT_HDR_SIZE;
>>>>> +		break;
>>>>> +	}
>>>>> +
>>>>> +	hci_skb_pkt_type(skb) = opcode == MTK_WMT_PATCH_DWNLD ?
>>>>> +				HCI_ACLDATA_PKT : HCI_COMMAND_PKT;
>>>> 
>>>> Why not move that into the switch statement above.
>>>> 
>>>>> +
>>>>> +	/* Start to build a WMT header and its actual payload. */
>>>>> +	whdr = skb_put(skb, MTK_WMT_HDR_SIZE);
>>>>> +	whdr->dir = 1;
>>>>> +	whdr->op = opcode;
>>>>> +	whdr->dlen = cpu_to_le16(plen + 1);
>>>>> +	whdr->flag = flag;
>>>>> +	skb_put_data(skb, param, plen);
>>>>> +
>>>>> +	mtk_enqueue(hu, skb);
>>>>> +	hci_uart_tx_wakeup(hu);
>>>>> +
>>>>> +	/*
>>>>> +	 * Waiting a WMT event response, while we must take care in case of
>>>>> +	 * failures for the wait.
>>>>> +	 */
>>>>> +	ret = wait_for_completion_interruptible_timeout(&btdev->wmt_cmd, HZ);
>>>>> +
>>>>> +	return ret > 0 ? 0 : ret < 0 ? ret : -ETIMEDOUT;
>>>>> +}
>>>> 
>>>> All in all I am not convinced that this is super clean. I get that we need something special for having this in the ACL data packets, but for the standard HCI command I prefer that __hci_cmd_sync is used. I addition, it seems that patch download is the only special case and that happens before at the setup stage. So we could make things special for that. I need to understand this a bit better. Can I get a btmon -w trace.log file from the whole init procedure.
>>>> 
>>> 
>>> While i was trying to rewrite the driver based on btuart.c. you posted
>>> on RFC, I used __hci_cmd_sync_ev to replace such kinds of SoC specific
>>> hci command sending which I've done previously with mtk_wmt_cmd_sync.
>>> 
>>> However, eventually, I got a cmd_timer timeout whose message printed
>>> on console as "Bluetooth: hci0: command 0xfc6f tx timeout".
>>> 
>>> The mtk soc specific cmd/event I posted below, I dumped directly in
>>> driver, always uses cmd as opcode 0xfc6f, and its event id as 0xe4.
>>> 
>>> It appears to the event id is not standard and thus it cannot cancel the
>>> cmd timer when the special hci event is being handled. This way can we
>>> can still use __hci_cmd_sync api ?
>>> 
>>> [    4.896200] hci tx: 00000000: 01 6f fc 05 01 07 01 00 04    
>>> [    4.904671] hci rx: 00000000: e4 05 02 07 01 00
>>> 00                             
>>> [    4.912859] Bluetooth: hci0 event 0xe4
>>> 
>>> 
>>> buildroot login: [    6.914509] Bluetooth: hci0: command 0xfc6f tx
>>> timeout
>>> [    6.919831] hci tx: 00000000: 01 6f fc 06 01 06 02 00 00
>>> 01                    .o........
>>> [    7.006631] hci rx: 00000000: e4 05 02 06 01 00
>>> 00                             .......
>>> [    7.014821] Bluetooth: hci0 event 0xe4
>> 
>> can you just start btmon before loading the module / driver? It makes it a lot easier since it will actually decode the basics for us. If there is a bug within __hci_cmd_sync_ev, then we are going to fix it.
>> 
> 
> I'm happy to do with btmon. just the environment with buildroot the BT
> running on seems there's a missing support for btmon. I can start to use
> btmon once I change the environment to Debian.
> 
>> So all the MTK vendor commands respond with a vendor event? Or are there some that do the standard command status/complete handling?
>> 
> 
> yes, mtk controller after mt7622 (included), its MTK vendors command
> (opcode 0xfc6f) always respond with a vendor event id 0xe4. And they
> don't do any standard status/complete handling.

then we need to figure out where the __hci_cmd_sync_ev causes a problem. Since normally that should just work for you.

> BTW, mtk controller before mt7622, such as mt7623, its MTK vendor
> command always go with completely specific format, not with hci format.

What does that mean? Do you have an example?

Regards

Marcel

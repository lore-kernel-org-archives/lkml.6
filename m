Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8BCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 06:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFAC2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 06:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PwiVeYBL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Aa7FO7mX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeLaGEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 01:04:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53991 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeLaGEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 01:04:48 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1964F60452; Mon, 31 Dec 2018 06:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546236287;
        bh=zKIJeKlQjf3ssAa3hPI03SLi9ZeSYnVl3wsCPSVy0GQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PwiVeYBLVOFj5CFSiy56mHHjRzkDkHkWiPs9coa24GnWAmOqV4AwijrFOErcs7VKO
         7zNwxLfv1+BL7wDJO0wLob+EzOJl2HjrUIr7jKWM5WoBRL7x/uLTboieT48q50MUgG
         ieeAiuUsK96u8qpsaE4mMpCRP39wOQiE3shq/NwU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0AD1160351;
        Mon, 31 Dec 2018 06:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546236286;
        bh=zKIJeKlQjf3ssAa3hPI03SLi9ZeSYnVl3wsCPSVy0GQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Aa7FO7mX6oouA726enCV1OhpRmvEIvXiB6empaZnR65V2/nWOJkNJwJleXhLUpS1S
         6AvLvUbTXlRYWM8jCKi5QNSptQtyRhFUYLZKuSWv8yndEYKH85R/zrZ2B85L5EY0bF
         zH4Cxoe0Lw3l4riUJ9QIwRCmVoVgzfz5O1Z4xR88=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 31 Dec 2018 11:34:46 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 4/4] Bluetooth: btqca: inject command complete event
 during fw download
In-Reply-To: <1FC4CC11-B070-4ACF-9107-857A4D392876@holtmann.org>
References: <20181228114819.17479-1-bgodavar@codeaurora.org>
 <20181228114819.17479-5-bgodavar@codeaurora.org>
 <2C799DB5-8033-45B5-A790-A16F73641645@holtmann.org>
 <de93a7b7169a0cfb8f28f5d8e5138dc7@codeaurora.org>
 <1FC4CC11-B070-4ACF-9107-857A4D392876@holtmann.org>
Message-ID: <1ec946b46301124c90aa12abffeca176@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On 2018-12-30 13:40, Marcel Holtmann wrote:
> Hi Balakrishna,
> 
>>>> Latest qualcomm chips are not sending an command complete event for
>>>> every firmware packet sent to chip. They only respond with a vendor
>>>> specific event for the last firmware packet. This optimization will
>>>> decrease the BT ON time. Due to this we are seeing a timeout error
>>>> message logs on the console during firmware download. Now we are
>>>> injecting a command complete event once we receive an vendor 
>>>> specific
>>>> event for the last RAM firmware packet.
>>>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>>>> ---
>>>> drivers/bluetooth/btqca.c | 39 
>>>> ++++++++++++++++++++++++++++++++++++++-
>>>> drivers/bluetooth/btqca.h |  3 +++
>>>> 2 files changed, 41 insertions(+), 1 deletion(-)
>>>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>>>> index ec9e03a6b778..0b533f65f652 100644
>>>> --- a/drivers/bluetooth/btqca.c
>>>> +++ b/drivers/bluetooth/btqca.c
>>>> @@ -144,6 +144,7 @@ static void qca_tlv_check_data(struct 
>>>> rome_config *config,
>>>> 		 * In case VSE is skipped, only the last segment is acked.
>>>> 		 */
>>>> 		config->dnld_mode = tlv_patch->download_mode;
>>>> +		config->dnld_type = config->dnld_mode;
>>>> 		BT_DBG("Total Length           : %d bytes",
>>>> 		       le32_to_cpu(tlv_patch->total_size));
>>>> @@ -264,6 +265,31 @@ static int qca_tlv_send_segment(struct hci_dev 
>>>> *hdev, int seg_size,
>>>> 	return err;
>>>> }
>>>> +static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
>>>> +{
>>>> +	struct hci_event_hdr *hdr;
>>>> +	struct hci_ev_cmd_complete *evt;
>>>> +	struct sk_buff *skb;
>>>> +
>>>> +	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
>>>> +	if (!skb)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	hdr = skb_put(skb, sizeof(*hdr));
>>>> +	hdr->evt = HCI_EV_CMD_COMPLETE;
>>>> +	hdr->plen = sizeof(*evt) + 1;
>>>> +
>>>> +	evt = skb_put(skb, sizeof(*evt));
>>>> +	evt->ncmd = 1;
>>>> +	evt->opcode = HCI_OP_NOP;
>>>> +
>>>> +	skb_put_u8(skb, QCA_HCI_CC_SUCCESS);
>>>> +
>>>> +	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
>>>> +
>>>> +	return hci_recv_frame(hdev, skb);
>>>> +}
>>>> +
>>>> static int qca_download_firmware(struct hci_dev *hdev,
>>>> 				  struct rome_config *config)
>>>> {
>>>> @@ -297,11 +323,22 @@ static int qca_download_firmware(struct 
>>>> hci_dev *hdev,
>>>> 		ret = qca_tlv_send_segment(hdev, segsize, segment,
>>>> 					    config->dnld_mode);
>>>> 		if (ret)
>>>> -			break;
>>>> +			goto out;
>>>> 		segment += segsize;
>>>> 	}
>>>> +	/* Latest qualcomm chipsets are not sending a command complete 
>>>> event
>>>> +	 * for every fw packet sent. They only respond with a vendor 
>>>> specific
>>>> +	 * event for the last packet. This optimization in the chip will
>>>> +	 * decrease the BT in initialization time. Here we will inject a 
>>>> command
>>>> +	 * complete event to avoid a command timeout error message.
>>>> +	 */
>>>> +	if ((config->dnld_type == ROME_SKIP_EVT_VSE_CC ||
>>>> +	    config->dnld_type == ROME_SKIP_EVT_VSE))
>>>> +		return qca_inject_cmd_complete_event(hdev);
>>>> +
>>> have you actually considered using __hci_cmd_send in that case. It is
>>> allowed for vendor OGF to use that command. I see you actually do use
>>> it and now I am failing to understand what this is for.
>> [Bala]: thanks for reviewing the change.
>> 
>> __hci_cmd_send() can be used only to send the command to the chip. it 
>> will not wait for the response for the command sent.
>> 
>> as you know that every vendor command sent to chip will respond with 
>> vendor specific event and command complete event.
>> but in our case chip will only respond with vendor specific event 
>> only. so we are injecting command complete event.
> 
> and __hci_cmd_sync_ev is also not working for you? However since you
> are not waiting for the vendor event anyway and just injecting
> cmd_complete, I wonder what’s the difference in just using
> __hci_cmd_send and not bothering to wait or inject at all. I am
> failing to see where this injection makes a difference.
> 
> For me it is a big difference if we are injecting one event like in
> the case of Intel compared to injecting one for every command. It will
> show a wrong picture in btmon and that is a bad idea.
> 
> Regards
> 
> Marcel

[Bala]: here is the use case, when ever we download the fw packets i.e. 
RAM image, for every command sent(i.e. fw packet) from
the host chip will respond with an vendor specific event and command 
complete event.

the above is taking more time to setup the BT device. then we came up 
with solution where we enable flags in fw file (i.e. RAM image header)
whether to wait for event to be received or sent the total packets and 
wait for the events for the last packet.

So currently we are handling both the cases in the code. i.e wait for 
event for all packet or wait for an event for the last packet.

but in the second case i.e. wait for event for the last packet sent, we 
are only receiving an vendor specific event from chip which holds the 
status of fw download.

so as __hci_cmd_sync_ev() requires an command complete event. so we are 
injecting it after the vendor specific event received for the last 
packet.

This helps to overcome 0xfc00 timeout error logging on console.

-- 
Regards
Balakrishna.

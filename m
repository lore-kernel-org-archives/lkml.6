Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDE2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457F62146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PPx9hHO1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jauGLqNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbeL2Hpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 02:45:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33296 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeL2Hpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 02:45:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A11396074E; Sat, 29 Dec 2018 07:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546069550;
        bh=uSb+ztjeX6684vaGRyl+A6Ks5wEiKo+Bq1wCZAqUG0A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PPx9hHO10JJcCX14EIkCFEYWROyfGfLUvRCKohJPIMIM06Y+DyjV0/zRd8rjSuyud
         excqDjs0d69KUWb+1V+hHtJKSv2+aWKRlLIcnMnbOE8xjUAx71xXey9j6W+OpS8nfx
         0HhnU7xdpEmN2v3HHETjQgnkdsQuY+He+J+KTAJI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B5D88604BE;
        Sat, 29 Dec 2018 07:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546069549;
        bh=uSb+ztjeX6684vaGRyl+A6Ks5wEiKo+Bq1wCZAqUG0A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jauGLqNlPQGG07OVzulIji77ErPZyU2ozKcdTmhrg7h1MlLymxf9cKEy353aoa2bl
         nmjGDwywC9VgqLHOX2D6XCW1APHe0xLHZ20cBT11k3JspLbrrRTDn6G39WZ4wWGkBI
         eVUYuqstkH+ffAuWfQ5ROwoXZjYt4cEsZBKAcFVk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 29 Dec 2018 13:15:49 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 4/4] Bluetooth: btqca: inject command complete event
 during fw download
In-Reply-To: <2C799DB5-8033-45B5-A790-A16F73641645@holtmann.org>
References: <20181228114819.17479-1-bgodavar@codeaurora.org>
 <20181228114819.17479-5-bgodavar@codeaurora.org>
 <2C799DB5-8033-45B5-A790-A16F73641645@holtmann.org>
Message-ID: <de93a7b7169a0cfb8f28f5d8e5138dc7@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On 2018-12-29 12:48, Marcel Holtmann wrote:
> Hi Balakrishna,
> 
>> Latest qualcomm chips are not sending an command complete event for
>> every firmware packet sent to chip. They only respond with a vendor
>> specific event for the last firmware packet. This optimization will
>> decrease the BT ON time. Due to this we are seeing a timeout error
>> message logs on the console during firmware download. Now we are
>> injecting a command complete event once we receive an vendor specific
>> event for the last RAM firmware packet.
>> 
>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>> ---
>> drivers/bluetooth/btqca.c | 39 ++++++++++++++++++++++++++++++++++++++-
>> drivers/bluetooth/btqca.h |  3 +++
>> 2 files changed, 41 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index ec9e03a6b778..0b533f65f652 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -144,6 +144,7 @@ static void qca_tlv_check_data(struct rome_config 
>> *config,
>> 		 * In case VSE is skipped, only the last segment is acked.
>> 		 */
>> 		config->dnld_mode = tlv_patch->download_mode;
>> +		config->dnld_type = config->dnld_mode;
>> 
>> 		BT_DBG("Total Length           : %d bytes",
>> 		       le32_to_cpu(tlv_patch->total_size));
>> @@ -264,6 +265,31 @@ static int qca_tlv_send_segment(struct hci_dev 
>> *hdev, int seg_size,
>> 	return err;
>> }
>> 
>> +static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
>> +{
>> +	struct hci_event_hdr *hdr;
>> +	struct hci_ev_cmd_complete *evt;
>> +	struct sk_buff *skb;
>> +
>> +	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
>> +	if (!skb)
>> +		return -ENOMEM;
>> +
>> +	hdr = skb_put(skb, sizeof(*hdr));
>> +	hdr->evt = HCI_EV_CMD_COMPLETE;
>> +	hdr->plen = sizeof(*evt) + 1;
>> +
>> +	evt = skb_put(skb, sizeof(*evt));
>> +	evt->ncmd = 1;
>> +	evt->opcode = HCI_OP_NOP;
>> +
>> +	skb_put_u8(skb, QCA_HCI_CC_SUCCESS);
>> +
>> +	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
>> +
>> +	return hci_recv_frame(hdev, skb);
>> +}
>> +
>> static int qca_download_firmware(struct hci_dev *hdev,
>> 				  struct rome_config *config)
>> {
>> @@ -297,11 +323,22 @@ static int qca_download_firmware(struct hci_dev 
>> *hdev,
>> 		ret = qca_tlv_send_segment(hdev, segsize, segment,
>> 					    config->dnld_mode);
>> 		if (ret)
>> -			break;
>> +			goto out;
>> 
>> 		segment += segsize;
>> 	}
>> 
>> +	/* Latest qualcomm chipsets are not sending a command complete event
>> +	 * for every fw packet sent. They only respond with a vendor 
>> specific
>> +	 * event for the last packet. This optimization in the chip will
>> +	 * decrease the BT in initialization time. Here we will inject a 
>> command
>> +	 * complete event to avoid a command timeout error message.
>> +	 */
>> +	if ((config->dnld_type == ROME_SKIP_EVT_VSE_CC ||
>> +	    config->dnld_type == ROME_SKIP_EVT_VSE))
>> +		return qca_inject_cmd_complete_event(hdev);
>> +
> 
> have you actually considered using __hci_cmd_send in that case. It is
> allowed for vendor OGF to use that command. I see you actually do use
> it and now I am failing to understand what this is for.
> 
[Bala]: thanks for reviewing the change.

  __hci_cmd_send() can be used only to send the command to the chip. it 
will not wait for the response for the command sent.

as you know that every vendor command sent to chip will respond with 
vendor specific event and command complete event.
but in our case chip will only respond with vendor specific event only. 
so we are injecting command complete event.

> Regards
> 
> Marcel

-- 
Regards
Balakrishna.

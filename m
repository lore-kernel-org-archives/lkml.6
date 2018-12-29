Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA29C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD8A2146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeL2HS4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 02:18:56 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:59696 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeL2HS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 02:18:56 -0500
Received: from [172.20.12.43] (unknown [213.61.67.157])
        by mail.holtmann.org (Postfix) with ESMTPSA id C2247CF358;
        Sat, 29 Dec 2018 08:26:35 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v7 4/4] Bluetooth: btqca: inject command complete event
 during fw download
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181228114819.17479-5-bgodavar@codeaurora.org>
Date:   Sat, 29 Dec 2018 08:18:53 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <2C799DB5-8033-45B5-A790-A16F73641645@holtmann.org>
References: <20181228114819.17479-1-bgodavar@codeaurora.org>
 <20181228114819.17479-5-bgodavar@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

> Latest qualcomm chips are not sending an command complete event for
> every firmware packet sent to chip. They only respond with a vendor
> specific event for the last firmware packet. This optimization will
> decrease the BT ON time. Due to this we are seeing a timeout error
> message logs on the console during firmware download. Now we are
> injecting a command complete event once we receive an vendor specific
> event for the last RAM firmware packet.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> drivers/bluetooth/btqca.c | 39 ++++++++++++++++++++++++++++++++++++++-
> drivers/bluetooth/btqca.h |  3 +++
> 2 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index ec9e03a6b778..0b533f65f652 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -144,6 +144,7 @@ static void qca_tlv_check_data(struct rome_config *config,
> 		 * In case VSE is skipped, only the last segment is acked.
> 		 */
> 		config->dnld_mode = tlv_patch->download_mode;
> +		config->dnld_type = config->dnld_mode;
> 
> 		BT_DBG("Total Length           : %d bytes",
> 		       le32_to_cpu(tlv_patch->total_size));
> @@ -264,6 +265,31 @@ static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
> 	return err;
> }
> 
> +static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
> +{
> +	struct hci_event_hdr *hdr;
> +	struct hci_ev_cmd_complete *evt;
> +	struct sk_buff *skb;
> +
> +	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	hdr = skb_put(skb, sizeof(*hdr));
> +	hdr->evt = HCI_EV_CMD_COMPLETE;
> +	hdr->plen = sizeof(*evt) + 1;
> +
> +	evt = skb_put(skb, sizeof(*evt));
> +	evt->ncmd = 1;
> +	evt->opcode = HCI_OP_NOP;
> +
> +	skb_put_u8(skb, QCA_HCI_CC_SUCCESS);
> +
> +	hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
> +
> +	return hci_recv_frame(hdev, skb);
> +}
> +
> static int qca_download_firmware(struct hci_dev *hdev,
> 				  struct rome_config *config)
> {
> @@ -297,11 +323,22 @@ static int qca_download_firmware(struct hci_dev *hdev,
> 		ret = qca_tlv_send_segment(hdev, segsize, segment,
> 					    config->dnld_mode);
> 		if (ret)
> -			break;
> +			goto out;
> 
> 		segment += segsize;
> 	}
> 
> +	/* Latest qualcomm chipsets are not sending a command complete event
> +	 * for every fw packet sent. They only respond with a vendor specific
> +	 * event for the last packet. This optimization in the chip will
> +	 * decrease the BT in initialization time. Here we will inject a command
> +	 * complete event to avoid a command timeout error message.
> +	 */
> +	if ((config->dnld_type == ROME_SKIP_EVT_VSE_CC ||
> +	    config->dnld_type == ROME_SKIP_EVT_VSE))
> +		return qca_inject_cmd_complete_event(hdev);
> +

have you actually considered using __hci_cmd_send in that case. It is allowed for vendor OGF to use that command. I see you actually do use it and now I am failing to understand what this is for.

Regards

Marcel


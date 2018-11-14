Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CA7C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F49223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F49223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbeKNR4o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:56:44 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55797 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbeKNR4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:56:44 -0500
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 08718CEEB0;
        Wed, 14 Nov 2018 09:02:06 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH 1/1] Bluetooth: make the balance of judgement condition to
 fix a false report
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1541656065-111693-1-git-send-email-zumeng.chen@gmail.com>
Date:   Wed, 14 Nov 2018 08:54:35 +0100
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5A23C871-B30F-44C4-898B-C138EFDB4893@holtmann.org>
References: <1541656065-111693-1-git-send-email-zumeng.chen@gmail.com>
To:     Zumeng Chen <zumeng.chen@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zumeng,

> This patch is to balance the condition scope between hci_get_cmd_complete and
> hci_event_packet about orig_skb as follows: 
> 
>        if (req_complete_skb || event == HCI_EV_CMD_STATUS ||
>            event == HCI_EV_CMD_COMPLETE)
>                orig_skb = skb_clone(skb, GFP_KERNEL);
> 
> And hci_get_cmd_complete will bt_dev_err out when HCI_EV_CMD_STATUS, so a lot
> of asymmetric conditions are triggered. Since both of them are the entry into
> hci_get_cmd_complete, we'd better get STATUS into judge the false out there.
> 
> Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> ---
> 
> Hi expert,
> 
> This issue existed whether or not T_DBG had been changed into bt_dev_err, which
> just shows the issue explicitly. I noticed actually that opcode doesn't match
> ev->opcode either at the same time. And there might be some logic issue about
> HCI_EV_CMD_COMPLETE between protocol and drivers. I'm not familar with the whole
> bluetooth protocol, and not gonna to dig more, so all yours guys~
> 
> Cheers,
> Zumeng
> 
> net/bluetooth/hci_event.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 235b5aa..d848663 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5217,7 +5217,8 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
> 		return true;
> 	}
> 
> -	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
> +	if (!((hdr->evt == HCI_EV_CMD_COMPLETE) ||
> +		(hdr->evt == HCI_EV_CMD_STATUS))) {

this indentation is messed up. Also some braces are not needed.

	if (!(hdr->evt == HCI_EV_CMD_COMPLETE ||
	      hdr->evt == HCI_EV_CMD_STATUS)) {

> 		bt_dev_err(hdev, "last event is not cmd complete (0x%2.2x)",
> 			   hdr->evt);
> 		return false;

Regards

Marcel


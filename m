Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCB5C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF422086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF422086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeJPW0Y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:26:24 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46143 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPW0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:26:24 -0400
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 021DFCF36B;
        Tue, 16 Oct 2018 16:42:59 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH v2] Bluetooth: hci_qca: Add support for controller debug
 logs.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <eca6c8832017269881709e51eadcf543@codeaurora.org>
Date:   Tue, 16 Oct 2018 16:35:35 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Harish Bandi <c-hbandi@codeaurora.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <EC27FDED-638A-4055-A861-C4AAD842F124@holtmann.org>
References: <20181003151144.10537-1-bgodavar@codeaurora.org>
 <2206464E-FA01-4A5A-8BC4-5CF70A0B9765@holtmann.org>
 <eca6c8832017269881709e51eadcf543@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

>>> This patch will prevent error messages splashing on console.
>>> [   78.426697] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804
>>> [   78.436682] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804
>>> [   78.446639] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804
>>> [   78.456596] Bluetooth: hci_core.c:hci_acldata_packet() hci0: ACL packet for unknown connection handle 3804
>>> QCA wcn3990 will send the debug logs in the form of ACL packets.
>>> While decoding packet in qca_recv(), marking the received debug log
>>> packet as diagnostic packet.
>>> Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
>>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>>> ---
>>> v2:
>>> * Addressed reviewer comments.
>>> v1:
>>> * initial patch
>>> ---
>>> drivers/bluetooth/hci_qca.c | 20 +++++++++++++++++++-
>>> 1 file changed, 19 insertions(+), 1 deletion(-)
>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>> index d98ed0442201..63ac3c6b4149 100644
>>> --- a/drivers/bluetooth/hci_qca.c
>>> +++ b/drivers/bluetooth/hci_qca.c
>>> @@ -63,6 +63,10 @@
>>> /* susclk rate */
>>> #define SUSCLK_RATE_32KHZ	32768
>>> +/* Controller debug log header */
>>> +#define QCA_DEBUG_HDR_MSB	0xDC
>>> +#define QCA_DEBUG_HDR_LSB	0x2E
>>> +
>> since this is actually the ACL handle, why not call it QCA_DEBUG_HANDLE.
> 
> [Bala]: will update.
> 
>>> /* HCI_IBS transmit side sleep protocol states */
>>> enum tx_ibs_states {
>>> 	HCI_IBS_TX_ASLEEP,
>>> @@ -849,6 +853,20 @@ static int qca_ibs_wake_ack(struct hci_dev *hdev, struct sk_buff *skb)
>>> 	return 0;
>>> }
>>> +static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
>>> +{
>>> +	/* We receive debug logs from chip as an ACL packets.
>>> +	 * Instead of sending the data to ACL to decode the
>>> +	 * received data, we are pushing them to the above layers
>>> +	 * as a diagnostic packet.
>>> +	 */
>>> +	if ((skb->len > 2) && (skb->data[0] == QCA_DEBUG_HDR_MSB) &&
>>> +	    (skb->data[1] == QCA_DEBUG_HDR_LSB))
>> Skip the individual () since they are not needed. Also the skb->len
>> check is not needed since the H4_RECV_ACL already ensures the proper
>> length of the header.
>> And just use get_unaligned_le16(skb->data) here (or be16 if that is
>> the byte order).
> [Bala] : will update condition with _le16()
> 
>>> +		return hci_recv_diag(hdev, skb);
>> Is there any reason to keep the 4 octets hci_acl_hdr with this SKB? Or
>> would it be better to be stripped off. Mainly asking are they any
>> other magic handles that we might want to feed through the diag
>> channel?
> 
> [Bala]: yes we need header in the stack, to  differentiate between actual diagnostic packet and debug packet.

please explain that a bit more. There is just one debug handle or do you have more special handles?

Regards

Marcel


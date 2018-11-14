Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC514C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0F821780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0F821780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbeKNRu1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:50:27 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33531 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbeKNRu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:50:26 -0500
Received: from marcel-macbook.fritz.box (p4FF9F655.dip0.t-ipconnect.de [79.249.246.85])
        by mail.holtmann.org (Postfix) with ESMTPSA id 77954CEEAF;
        Wed, 14 Nov 2018 08:55:50 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH v1 3/4] Bluetooth: hci_qca: clear HCI_QUIRK_RESET_ON_CLOSE
 flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3c9684ec5fcc9f5d99be7e9b2e705514@codeaurora.org>
Date:   Wed, 14 Nov 2018 08:48:19 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <FD7AE55A-D7AF-4C90-9D01-2DC197A97550@holtmann.org>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
 <20181106120528.30342-4-bgodavar@codeaurora.org>
 <462C4F58-E6E2-4B20-B074-72DDFA6D7364@holtmann.org>
 <170e0419929840109d349b5df5e38364@codeaurora.org>
 <0CE81F0B-B122-4793-817F-F0F4738C44E0@holtmann.org>
 <c4ced688b33ad82b61a705908393a0a6@codeaurora.org>
 <3c9684ec5fcc9f5d99be7e9b2e705514@codeaurora.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

>>>>>> During hci down we are sending reset command to chip, which
>>>>>> is not required for wcn3990, as hdev->shutdown() will turn off the
>>>>>> regulators.
>>>>>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>>>>>> ---
>>>>>> drivers/bluetooth/hci_qca.c | 1 +
>>>>>> 1 file changed, 1 insertion(+)
>>>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>>>>> index 8301663f0004..97b57e0f4725 100644
>>>>>> --- a/drivers/bluetooth/hci_qca.c
>>>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>>>> @@ -1190,6 +1190,7 @@ static int qca_setup(struct hci_uart *hu)
>>>>>> 		 */
>>>>>> 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
>>>>>> 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>>>>>> +		clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
>>>>>> 		hu->hdev->shutdown = qca_power_off;
>>>>>> 		ret = qca_wcn3990_init(hu);
>>>>>> 		if (ret)
>>>>> I am pretty certain that you didn’t want this quirk:
>>>>>       /* When this quirk is set, the HCI Reset command is send when
>>>>>        * closing the transport instead of when opening it.
>>>>> This quirk is for Bluetooth 1.0b devices where the HCI_Reset behavior
>>>>> was not clear or for devices that actually misbehave with the initial
>>>>> HCI_Reset.
>>>>> In addition, you commit message is totally misleading. That is not
>>>>> what is happening with this quirk.
>>>>> Regards
>>>>> Marcel
>>>> My intention was reset command is not required when we do an hci down.
>>>> this is because of hdev->shutdown will turn off the regulators.
>>>> It is like turning off the chip. sending reset command after turning off the chip is not required.
>>>> I understand the usage of the quirk, will update the commit text.
>>> you are papering over the issue. Actually
>>> hci_serdev.c:hci_uart_register_device() is the culprit with the legacy
>>> code copied over from hci_ldisc.c:hci_uart_register_dev(). I think
>>> there is no point doing all this legacy line discipline quirk handling
>>> until it is really needed. The serdev drivers are all for recent
>>> hardware.
>>> That said, having moved over to a btuart.c approach and killed the
>>> whole hci_serdev.c thing would have been a lot better here. You will
>>> keep running in weird situations where 18 year old code keeps
>>> surprising you.
>> [Bala]: even i feel the same. they are lot such kind of HACK's we need
>> to do with current arch.
>>        when can we expect btuart.c merged to bt-next. i think having
>> btuart will helps us to have the control of
>>        vendor porto's call's like in btusb.c
>>> Regards
>>> Marcel
> 
> I need some clarification, do you expect some thing like this https://github.com/torvalds/linux/blob/master/drivers/bluetooth/btmtkuart.c for Qualcomm BT chip too.
> it looks it is completely avoided hci_serdev.c interface.

you tell me actually. Are you using the H:4 transport or do you have an extra protocol layer / framing below it. If you do, then use your own driver, but if the transport is H:4 with vendor packets and vendor setup, then btuart.c (which is not yet upstream) should be your target.

For the MTK hardware it was obvious that it was better served as a separate driver. For QCA serial it really depends on how much extra protocol you have to run. So this might be an exercise in trying QCA serial as a separate driver and then go from there.

It is clear that the baggage from hci_ldisc.c etc is in the way for serdev based systems.

Regards

Marcel


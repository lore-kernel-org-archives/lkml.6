Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E802ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3904120652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3904120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbeGROLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:11:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:14322 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726990AbeGROLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:11:33 -0400
X-UUID: c34cae72afa14a1a91fa2ccffa541892-20180718
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2097678855; Wed, 18 Jul 2018 21:33:22 +0800
Received: from MTKMBS06N2.mediatek.inc (172.21.101.130) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 18 Jul 2018 21:33:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 18 Jul 2018 21:33:20 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 18 Jul 2018 21:33:20 +0800
Message-ID: <1531920800.8953.151.camel@mtkswgap22>
Subject: Re: [PATCH v5 4/7] Bluetooth: Add new quirk for non-persistent
 setup settings
From:   Sean Wang <sean.wang@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 18 Jul 2018 21:33:20 +0800
In-Reply-To: <E05CD0A8-B820-4900-970D-57F71E8E5583@holtmann.org>
References: <cover.1531150733.git.sean.wang@mediatek.com>
         <4b188c8a508340598dda233f6d49a16c9ac8784e.1531150733.git.sean.wang@mediatek.com>
         <2825B722-E75C-4A3C-8110-879205E46C0E@holtmann.org>
         <1531638169.3955.5.camel@mtkswgap22>
         <6571C864-B2EC-4806-BC5D-F531792737F6@holtmann.org>
         <1531757114.8953.12.camel@mtkswgap22>
         <E05CD0A8-B820-4900-970D-57F71E8E5583@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 14:14 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> >>>>> Add a new quirk HCI_QUIRK_NON_PERSISTENT_SETUP allowing that a quirk that
> >>>>> runs setup() after every open() and not just after the first open().
> >>>>> 
> >>>>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> >>>>> ---
> >>>>> include/net/bluetooth/hci.h | 9 +++++++++
> >>>>> net/bluetooth/hci_core.c    | 3 ++-
> >>>>> 2 files changed, 11 insertions(+), 1 deletion(-)
> >>>>> 
> >>>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> >>>>> index 73e48be..d3ec5b2a8 100644
> >>>>> --- a/include/net/bluetooth/hci.h
> >>>>> +++ b/include/net/bluetooth/hci.h
> >>>>> @@ -183,6 +183,15 @@ enum {
> >>>>> 	 * during the hdev->setup vendor callback.
> >>>>> 	 */
> >>>>> 	HCI_QUIRK_NON_PERSISTENT_DIAG,
> >>>>> +
> >>>>> +	/* When this quirk is set, setup() would be run after every
> >>>>> +	 * open() and not just after the first open().
> >>>>> +	 *
> >>>>> +	 * This quirk can be set before hci_register_dev is called or
> >>>>> +	 * during the hdev->setup vendor callback.
> >>>>> +	 *
> >>>>> +	 */
> >>>>> +	HCI_QUIRK_NON_PERSISTENT_SETUP,
> >>>>> };
> >>>>> 
> >>>>> /* HCI device flags */
> >>>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >>>>> index f5c21004..0111280 100644
> >>>>> --- a/net/bluetooth/hci_core.c
> >>>>> +++ b/net/bluetooth/hci_core.c
> >>>>> @@ -1396,7 +1396,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
> >>>>> 	atomic_set(&hdev->cmd_cnt, 1);
> >>>>> 	set_bit(HCI_INIT, &hdev->flags);
> >>>>> 
> >>>>> -	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
> >>>>> +	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
> >>>>> +	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> >>>>> 		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
> >>>> 
> >>>> can you include the extract of btmon on how the HCI_DEV_SETUP event shows up in the traces? I remember that I asked about something like that.
> >>>> 
> >>>> Regards
> >>>> 
> >>>> Marcel
> >>>> 
> >>> 
> >>> No, I cannot see any event about HCI_DEV_SETUP in btmon trace, the trace I posted as below is doing some rounds of power off and then on
> >> 
> >> it will result in this:
> >> 
> >>        case HCI_DEV_SETUP:
> >>                if (hdev->manufacturer == 0xffff)
> >>                        return NULL;
> >> 
> >>        case HCI_DEV_UP:
> >>                skb = bt_skb_alloc(HCI_MON_INDEX_INFO_SIZE, GFP_ATOMIC);
> >> 
> >> So we will see extra index info events, but I assume that is just fine this we also see them on DEV_UP. They also do not hurt as long as not magically the manufacturer information changes.
> >> 
> >> I do wonder though if this quirk is set, then hdev->manufacturer needs to be reset and allow hdev->setup() to reset it. This goes with a log of other information as well. Maybe just a look if there are no races here.
> >> 
> >> Regards
> >> 
> >> Marcel
> >> 
> > 
> > I didn't set a value to hdev->manufacture.
> > 
> > Should I set it in hdev->setup() ? MediaTek is 0x46 according to [1].
> 
> it is generally useful so that it gets reported out in btmon and thus it can assign the correct vendor specific decoder. However you better set hdev->manufacturer = 70 in the probe() routine before calling hci_register_dev. You have a dedicated driver and thus will always know it.
> 
> The core tries to figure this out at some point, but then you are missing btmon decoding for the earlier messages. See btusb.c and how other drivers set it early on.
> 

thank for the point up, I will set hdev->manufacturer as 70 in probe
routine before calling hci_register_dev in the next version.

> Regards
> 
> Marcel
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D932ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E6420647
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E6420647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbeGPP53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:57:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:11094 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727403AbeGPP53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:57:29 -0400
X-UUID: a1ea01a4d3064a43bb2ac1674ba09cb4-20180716
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 30478694; Mon, 16 Jul 2018 23:29:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 16 Jul 2018 23:29:25 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 16 Jul 2018 23:29:25 +0800
Message-ID: <1531754965.8953.3.camel@mtkswgap22>
Subject: Re: [PATCH v5 5/7] Bluetooth: Extend btuart driver for join more
 vendor devices
From:   Sean Wang <sean.wang@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 16 Jul 2018 23:29:25 +0800
In-Reply-To: <6476BE78-3FE5-465F-8060-2215387323AA@holtmann.org>
References: <cover.1531150733.git.sean.wang@mediatek.com>
         <85d449cdd34bf47d72935a821915e825c64a2145.1531150733.git.sean.wang@mediatek.com>
         <70616B99-5A2D-417A-8815-246700EEF4E2@holtmann.org>
         <1531641134.3955.19.camel@mtkswgap22>
         <6476BE78-3FE5-465F-8060-2215387323AA@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-16 at 14:59 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> >>> Adding an independent btuart.h header allows these essential definitions
> >>> can be reused in vendor driver. Also, struct btuart_vnd is extended with
> >>> additional callbacks such as .init initializing vendor data, .shtudown,
> >>> .recv and .send supporting SoC specific framing for that btuart can
> >>> simply adapt to various Bluetooth uart-based devices.
> >>> 
> >>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> >>> ---
> >>> drivers/bluetooth/btuart.c | 73 ++++++++++++++++++++++++----------------------
> >>> drivers/bluetooth/btuart.h | 30 +++++++++++++++++++
> >>> 2 files changed, 68 insertions(+), 35 deletions(-)
> >>> create mode 100644 drivers/bluetooth/btuart.h
> >>> 
> >>> diff --git a/drivers/bluetooth/btuart.c b/drivers/bluetooth/btuart.c
> >>> index a900aac..65d0086 100644
> >>> --- a/drivers/bluetooth/btuart.c
> >>> +++ b/drivers/bluetooth/btuart.c
> >>> @@ -33,35 +33,11 @@
> >>> #include <net/bluetooth/hci_core.h>
> >>> 
> >>> #include "h4_recv.h"
> >>> +#include "btuart.h"
> >>> #include "btbcm.h"
> >>> 
> >>> #define VERSION "1.0"
> >>> 
> >>> -struct btuart_vnd {
> >>> -	const struct h4_recv_pkt *recv_pkts;
> >>> -	int recv_pkts_cnt;
> >>> -	unsigned int manufacturer;
> >>> -	int (*open)(struct hci_dev *hdev);
> >>> -	int (*close)(struct hci_dev *hdev);
> >>> -	int (*setup)(struct hci_dev *hdev);
> >>> -};
> >>> -
> >>> -struct btuart_dev {
> >>> -	struct hci_dev *hdev;
> >>> -	struct serdev_device *serdev;
> >>> -
> >>> -	struct work_struct tx_work;
> >>> -	unsigned long tx_state;
> >>> -	struct sk_buff_head txq;
> >>> -
> >>> -	struct sk_buff *rx_skb;
> >>> -
> >>> -	const struct btuart_vnd *vnd;
> >>> -};
> >> 
> >> I really like to avoid this since it is not clean. Frankly I prefer to keep the btuart.c driver for drivers that really just use H:4 as transport protocol. If the protocol is only H:4 alike and has extra headers, then it should be a separate driver.
> >> 
> > 
> > thanks for letting me know your concern. I think I'm a little over in reusing these existing methods and break something generic and its beauty.
> > 
> > I'll make the driver be a separate one based on btuart in the next version.
> > 
> > 
> >> The common H:4 handling is abstracted in h4_recv.h already anyway and we can add more pieces if needed. However I also wonder since you have extra framing that the complex H:4 state keeping might be not needed at all. So it could be simplified.
> >> 
> > 
> > okay, I will get rid of h4_recv.h and consider to use more simplified logic to handle the extra framing and its payload.
> 
> only if it is already framed by your extra header, but I seem to recall that it will frame it. For example the bfusb.c old driver does frame H:4 as well and then no extra state keeping for H:4 is needed. Just pass the frames up into the core via hci_recv_frame (or hci_recv_diag for vendor diagnostic) and move on with it.
> 
> You can of course use h4_recv.h if you need to, but only do that if you are true H:4 stream and have no idea where a frame ends and starts.
> 
> Regards
> 
> Marcel
> 

Thanks for the explanation, I didn't show what the extra header is, that causes some misunderstanding.

The mtk extra header doesn't provide any idea where a frame ends and starts in the bluetooth stream. 

It is just totally a legacy stuff used by mtk combo devices sharing a serial transport, such as BT/GPS/FM running via a shared UART, to
let the host know what type of radio the following bytes is for and how long it's. 

The extra header is really useful for a combo device, splitting flow and fitting in a single serial transport, but for a single device such as
mt7622 Bluetooth I made here, it seems to be useless.

Because the extra header doesn't provide any details about this stream and each radio stack still needs to be in charge of their stream
parsing. That is why I still want to use recv_h4.h instead of coding my own parser.

	Sean



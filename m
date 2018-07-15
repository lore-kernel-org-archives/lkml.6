Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEC6ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 07:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8496208BA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 07:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8496208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeGOIOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 04:14:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9476 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725948AbeGOIOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 04:14:33 -0400
X-UUID: e603597b80c8433d916e790c5275853d-20180715
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1969547162; Sun, 15 Jul 2018 15:52:22 +0800
Received: from MTKMBS06N1.mediatek.inc (172.21.101.129) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sun, 15 Jul 2018 15:52:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sun, 15 Jul 2018 15:52:14 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sun, 15 Jul 2018 15:52:14 +0800
Message-ID: <1531641134.3955.19.camel@mtkswgap22>
Subject: Re: [PATCH v5 5/7] Bluetooth: Extend btuart driver for join more
 vendor devices
From:   Sean Wang <sean.wang@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Sun, 15 Jul 2018 15:52:14 +0800
In-Reply-To: <70616B99-5A2D-417A-8815-246700EEF4E2@holtmann.org>
References: <cover.1531150733.git.sean.wang@mediatek.com>
         <85d449cdd34bf47d72935a821915e825c64a2145.1531150733.git.sean.wang@mediatek.com>
         <70616B99-5A2D-417A-8815-246700EEF4E2@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-07-14 at 18:44 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> > Adding an independent btuart.h header allows these essential definitions
> > can be reused in vendor driver. Also, struct btuart_vnd is extended with
> > additional callbacks such as .init initializing vendor data, .shtudown,
> > .recv and .send supporting SoC specific framing for that btuart can
> > simply adapt to various Bluetooth uart-based devices.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> > drivers/bluetooth/btuart.c | 73 ++++++++++++++++++++++++----------------------
> > drivers/bluetooth/btuart.h | 30 +++++++++++++++++++
> > 2 files changed, 68 insertions(+), 35 deletions(-)
> > create mode 100644 drivers/bluetooth/btuart.h
> > 
> > diff --git a/drivers/bluetooth/btuart.c b/drivers/bluetooth/btuart.c
> > index a900aac..65d0086 100644
> > --- a/drivers/bluetooth/btuart.c
> > +++ b/drivers/bluetooth/btuart.c
> > @@ -33,35 +33,11 @@
> > #include <net/bluetooth/hci_core.h>
> > 
> > #include "h4_recv.h"
> > +#include "btuart.h"
> > #include "btbcm.h"
> > 
> > #define VERSION "1.0"
> > 
> > -struct btuart_vnd {
> > -	const struct h4_recv_pkt *recv_pkts;
> > -	int recv_pkts_cnt;
> > -	unsigned int manufacturer;
> > -	int (*open)(struct hci_dev *hdev);
> > -	int (*close)(struct hci_dev *hdev);
> > -	int (*setup)(struct hci_dev *hdev);
> > -};
> > -
> > -struct btuart_dev {
> > -	struct hci_dev *hdev;
> > -	struct serdev_device *serdev;
> > -
> > -	struct work_struct tx_work;
> > -	unsigned long tx_state;
> > -	struct sk_buff_head txq;
> > -
> > -	struct sk_buff *rx_skb;
> > -
> > -	const struct btuart_vnd *vnd;
> > -};
> 
> I really like to avoid this since it is not clean. Frankly I prefer to keep the btuart.c driver for drivers that really just use H:4 as transport protocol. If the protocol is only H:4 alike and has extra headers, then it should be a separate driver.
> 

thanks for letting me know your concern. I think I'm a little over in reusing these existing methods and break something generic and its beauty.

I'll make the driver be a separate one based on btuart in the next version.


> The common H:4 handling is abstracted in h4_recv.h already anyway and we can add more pieces if needed. However I also wonder since you have extra framing that the complex H:4 state keeping might be not needed at all. So it could be simplified.
> 

okay, I will get rid of h4_recv.h and consider to use more simplified logic to handle the extra framing and its payload.

> Regards
> 
> Marcel


> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek



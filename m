Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6E5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F754208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F754208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbeGPN1V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:27:21 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:32924 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeGPN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:21 -0400
Received: from [192.168.0.117] (188.146.201.191.nat.umts.dynamic.t-mobile.pl [188.146.201.191])
        by mail.holtmann.org (Postfix) with ESMTPSA id E9991CF29E;
        Mon, 16 Jul 2018 15:06:52 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v5 5/7] Bluetooth: Extend btuart driver for join more
 vendor devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1531641134.3955.19.camel@mtkswgap22>
Date:   Mon, 16 Jul 2018 14:59:58 +0200
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6476BE78-3FE5-465F-8060-2215387323AA@holtmann.org>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <85d449cdd34bf47d72935a821915e825c64a2145.1531150733.git.sean.wang@mediatek.com>
 <70616B99-5A2D-417A-8815-246700EEF4E2@holtmann.org>
 <1531641134.3955.19.camel@mtkswgap22>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

>>> Adding an independent btuart.h header allows these essential definitions
>>> can be reused in vendor driver. Also, struct btuart_vnd is extended with
>>> additional callbacks such as .init initializing vendor data, .shtudown,
>>> .recv and .send supporting SoC specific framing for that btuart can
>>> simply adapt to various Bluetooth uart-based devices.
>>> 
>>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>>> ---
>>> drivers/bluetooth/btuart.c | 73 ++++++++++++++++++++++++----------------------
>>> drivers/bluetooth/btuart.h | 30 +++++++++++++++++++
>>> 2 files changed, 68 insertions(+), 35 deletions(-)
>>> create mode 100644 drivers/bluetooth/btuart.h
>>> 
>>> diff --git a/drivers/bluetooth/btuart.c b/drivers/bluetooth/btuart.c
>>> index a900aac..65d0086 100644
>>> --- a/drivers/bluetooth/btuart.c
>>> +++ b/drivers/bluetooth/btuart.c
>>> @@ -33,35 +33,11 @@
>>> #include <net/bluetooth/hci_core.h>
>>> 
>>> #include "h4_recv.h"
>>> +#include "btuart.h"
>>> #include "btbcm.h"
>>> 
>>> #define VERSION "1.0"
>>> 
>>> -struct btuart_vnd {
>>> -	const struct h4_recv_pkt *recv_pkts;
>>> -	int recv_pkts_cnt;
>>> -	unsigned int manufacturer;
>>> -	int (*open)(struct hci_dev *hdev);
>>> -	int (*close)(struct hci_dev *hdev);
>>> -	int (*setup)(struct hci_dev *hdev);
>>> -};
>>> -
>>> -struct btuart_dev {
>>> -	struct hci_dev *hdev;
>>> -	struct serdev_device *serdev;
>>> -
>>> -	struct work_struct tx_work;
>>> -	unsigned long tx_state;
>>> -	struct sk_buff_head txq;
>>> -
>>> -	struct sk_buff *rx_skb;
>>> -
>>> -	const struct btuart_vnd *vnd;
>>> -};
>> 
>> I really like to avoid this since it is not clean. Frankly I prefer to keep the btuart.c driver for drivers that really just use H:4 as transport protocol. If the protocol is only H:4 alike and has extra headers, then it should be a separate driver.
>> 
> 
> thanks for letting me know your concern. I think I'm a little over in reusing these existing methods and break something generic and its beauty.
> 
> I'll make the driver be a separate one based on btuart in the next version.
> 
> 
>> The common H:4 handling is abstracted in h4_recv.h already anyway and we can add more pieces if needed. However I also wonder since you have extra framing that the complex H:4 state keeping might be not needed at all. So it could be simplified.
>> 
> 
> okay, I will get rid of h4_recv.h and consider to use more simplified logic to handle the extra framing and its payload.

only if it is already framed by your extra header, but I seem to recall that it will frame it. For example the bfusb.c old driver does frame H:4 as well and then no extra state keeping for H:4 is needed. Just pass the frames up into the core via hci_recv_frame (or hci_recv_diag for vendor diagnostic) and move on with it.

You can of course use h4_recv.h if you need to, but only do that if you are true H:4 stream and have no idea where a frame ends and starts.

Regards

Marcel


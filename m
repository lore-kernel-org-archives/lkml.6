Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D83ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C4B208CC
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 16:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C4B208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeGNREb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 13:04:31 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48522 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeGNREb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 13:04:31 -0400
Received: from [192.168.0.117] (188.146.224.185.nat.umts.dynamic.t-mobile.pl [188.146.224.185])
        by mail.holtmann.org (Postfix) with ESMTPSA id E83B0CF163;
        Sat, 14 Jul 2018 18:51:43 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v5 5/7] Bluetooth: Extend btuart driver for join more
 vendor devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <85d449cdd34bf47d72935a821915e825c64a2145.1531150733.git.sean.wang@mediatek.com>
Date:   Sat, 14 Jul 2018 18:44:49 +0200
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <70616B99-5A2D-417A-8815-246700EEF4E2@holtmann.org>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <85d449cdd34bf47d72935a821915e825c64a2145.1531150733.git.sean.wang@mediatek.com>
To:     sean.wang@mediatek.com
X-Mailer: Apple Mail (2.3445.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Adding an independent btuart.h header allows these essential definitions
> can be reused in vendor driver. Also, struct btuart_vnd is extended with
> additional callbacks such as .init initializing vendor data, .shtudown,
> .recv and .send supporting SoC specific framing for that btuart can
> simply adapt to various Bluetooth uart-based devices.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btuart.c | 73 ++++++++++++++++++++++++----------------------
> drivers/bluetooth/btuart.h | 30 +++++++++++++++++++
> 2 files changed, 68 insertions(+), 35 deletions(-)
> create mode 100644 drivers/bluetooth/btuart.h
> 
> diff --git a/drivers/bluetooth/btuart.c b/drivers/bluetooth/btuart.c
> index a900aac..65d0086 100644
> --- a/drivers/bluetooth/btuart.c
> +++ b/drivers/bluetooth/btuart.c
> @@ -33,35 +33,11 @@
> #include <net/bluetooth/hci_core.h>
> 
> #include "h4_recv.h"
> +#include "btuart.h"
> #include "btbcm.h"
> 
> #define VERSION "1.0"
> 
> -struct btuart_vnd {
> -	const struct h4_recv_pkt *recv_pkts;
> -	int recv_pkts_cnt;
> -	unsigned int manufacturer;
> -	int (*open)(struct hci_dev *hdev);
> -	int (*close)(struct hci_dev *hdev);
> -	int (*setup)(struct hci_dev *hdev);
> -};
> -
> -struct btuart_dev {
> -	struct hci_dev *hdev;
> -	struct serdev_device *serdev;
> -
> -	struct work_struct tx_work;
> -	unsigned long tx_state;
> -	struct sk_buff_head txq;
> -
> -	struct sk_buff *rx_skb;
> -
> -	const struct btuart_vnd *vnd;
> -};

I really like to avoid this since it is not clean. Frankly I prefer to keep the btuart.c driver for drivers that really just use H:4 as transport protocol. If the protocol is only H:4 alike and has extra headers, then it should be a separate driver.

The common H:4 handling is abstracted in h4_recv.h already anyway and we can add more pieces if needed. However I also wonder since you have extra framing that the complex H:4 state keeping might be not needed at all. So it could be simplified.

Regards

Marcel


Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB9BC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2402082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2402082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbeLEVCd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:02:33 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48500 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbeLEVCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:02:33 -0500
Received: from marcel-macbook.fritz.box (p4FF9F1DE.dip0.t-ipconnect.de [79.249.241.222])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2513CCF35D;
        Wed,  5 Dec 2018 22:10:07 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Handle specific unknown packets after
 firmware loading
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20181205194538.8074-1-pawel.mikolaj.chmiel@gmail.com>
Date:   Wed, 5 Dec 2018 22:02:30 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>
Content-Transfer-Encoding: 8BIT
Message-Id: <BBB949C2-B1CB-478E-9BBF-E39FCA7271EF@holtmann.org>
References: <20181205194538.8074-1-pawel.mikolaj.chmiel@gmail.com>
To:     =?utf-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

> The Broadcom controller on aries S5PV210 boards sends out a couple of
> unknown packets after the firmware is loaded.  This will cause
> logging of errors such as:
> 	Bluetooth: hci0: Frame reassembly failed (-84)
> 
> This is probably also the case with other boards, as there are related
> Android userspace patches for custom ROMs such as
> https://review.lineageos.org/#/c/LineageOS/android_system_bt/+/142721/
> Since this appears to be intended behaviour, treated them as diagnostic
> packets.
> 
> Note that this is another variant of commit 01d5e44ace8a 
> ("Bluetooth: hci_bcm: Handle empty packet after firmware loading")
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> drivers/bluetooth/hci_bcm.c | 32 +++++++++++++++++++++++++++-----
> 1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index ddbd8c6a0ceb..ae271836dc26 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -51,6 +51,12 @@
> #define BCM_LM_DIAG_PKT 0x07
> #define BCM_LM_DIAG_SIZE 63
> 
> +#define BCM_UNKNOWN_PKT 0x31
> +#define BCM_UNKNOWN_SIZE 0
> +
> +#define BCM_UNKNOWN2_PKT 0x34
> +#define BCM_UNKNOWN2_SIZE 0
> +

lets use BCM_TYPE49_ and BCM_TYPE52_

> #define BCM_AUTOSUSPEND_DELAY	5000 /* default autosleep delay */
> 
> /**
> @@ -561,12 +567,28 @@ static int bcm_setup(struct hci_uart *hu)
> 	.lsize = 0, \
> 	.maxlen = BCM_NULL_SIZE
> 
> +#define BCM_RECV_UNKNOWN \
> +	.type = BCM_UNKNOWN_PKT, \
> +	.hlen = BCM_UNKNOWN_SIZE, \
> +	.loff = 0, \
> +	.lsize = 0, \
> +	.maxlen = BCM_UNKNOWN_SIZE
> +
> +#define BCM_RECV_UNKNOWN2 \
> +	.type = BCM_UNKNOWN2_PKT, \
> +	.hlen = BCM_UNKNOWN2_SIZE, \
> +	.loff = 0, \
> +	.lsize = 0, \
> +	.maxlen = BCM_UNKNOWN2_SIZE

Same here, BCM_RECV_TYPE49 and BCM_RECV_TYPE52.

> +
> static const struct h4_recv_pkt bcm_recv_pkts[] = {
> -	{ H4_RECV_ACL,      .recv = hci_recv_frame },
> -	{ H4_RECV_SCO,      .recv = hci_recv_frame },
> -	{ H4_RECV_EVENT,    .recv = hci_recv_frame },
> -	{ BCM_RECV_LM_DIAG, .recv = hci_recv_diag  },
> -	{ BCM_RECV_NULL,    .recv = hci_recv_diag  },
> +	{ H4_RECV_ACL,       .recv = hci_recv_frame },
> +	{ H4_RECV_SCO,       .recv = hci_recv_frame },
> +	{ H4_RECV_EVENT,     .recv = hci_recv_frame },
> +	{ BCM_RECV_LM_DIAG,  .recv = hci_recv_diag  },
> +	{ BCM_RECV_NULL,     .recv = hci_recv_diag  },
> +	{ BCM_RECV_UNKNOWN,  .recv = hci_recv_diag  },
> +	{ BCM_RECV_UNKNOWN2, .recv = hci_recv_diag  },
> };
> 
> static int bcm_recv(struct hci_uart *hu, const void *data, int count)

Regards

Marcel


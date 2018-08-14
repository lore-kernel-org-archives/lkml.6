Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD94C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894EC21716
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894EC21716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbeHNVeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:34:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:26487 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727755AbeHNVeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:34:06 -0400
X-UUID: f692c6cbf4e6438cb9cfdc241a35dade-20180815
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1878632844; Wed, 15 Aug 2018 02:45:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 15 Aug 2018 02:45:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkcas08.mediatek.inc
 (172.21.101.126) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Wed, 15 Aug
 2018 02:45:27 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 15 Aug 2018 02:45:20 +0800
Message-ID: <1534272320.31978.28.camel@mtkswgap22>
Subject: Re: [PATCH] Bluetooth: mediatek: Fix memory leak
From:   Sean Wang <sean.wang@mediatek.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 15 Aug 2018 02:45:20 +0800
In-Reply-To: <20180814151031.GA25096@embeddedor.com>
References: <20180814151031.GA25096@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Gustavo

thanks for the catch up

Acked-by: Sean Wang <sean.wang@mediatek.com>


On Tue, 2018-08-14 at 10:10 -0500, Gustavo A. R. Silva wrote:
> In case memory resources for *fw* were allocated, release them before
> return.
> 
> Addresses-Coverity-ID: 1472611 ("Resource leak")
> Fixes: 7237c4c9ec92 ("Bluetooth: mediatek: Add protocol support for MediaTek serial devices")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/bluetooth/btmtkuart.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
> index ed2a5c7..4593baf 100644
> --- a/drivers/bluetooth/btmtkuart.c
> +++ b/drivers/bluetooth/btmtkuart.c
> @@ -144,8 +144,10 @@ static int mtk_setup_fw(struct hci_dev *hdev)
>  	fw_size = fw->size;
>  
>  	/* The size of patch header is 30 bytes, should be skip */
> -	if (fw_size < 30)
> -		return -EINVAL;
> +	if (fw_size < 30) {
> +		err = -EINVAL;
> +		goto free_fw;
> +	}
>  
>  	fw_size -= 30;
>  	fw_ptr += 30;
> @@ -172,8 +174,8 @@ static int mtk_setup_fw(struct hci_dev *hdev)
>  		fw_ptr += dlen;
>  	}
>  
> +free_fw:
>  	release_firmware(fw);
> -
>  	return err;
>  }
>  



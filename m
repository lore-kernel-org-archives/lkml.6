Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2B0C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B75208DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="SaqlbWDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B75208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbeHBJFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:05:34 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:46840 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeHBJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:05:34 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 664EF5C0D50;
        Thu,  2 Aug 2018 09:15:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1533194145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ndCBKbFi02As1z9cJnhZCPC09j4d43MOIMjbHqr6E/g=;
        b=SaqlbWDNJqms7SePRG390/qPmcYZaIyxaY1x7nc2URdSm8k6SXb9lORyARlCCgOBN6Eu9O
        T/brapl3MeywlwyVeWRkHZ0MqfhV8Vvjvdph9N1bEDWQ0OWUhNxoG8UPw7ZvjCxYZk+CG6
        75hG+sS/QWEs31LKkhzAPXwFaNpzrC4=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Thu, 02 Aug 2018 09:15:45 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     davem@davemloft.net, krzk@kernel.org, robin.murphy@arm.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: fec: check DMA addressing limitations
In-Reply-To: <AM4PR0401MB22608258EB2B045E708A3779FF2C0@AM4PR0401MB2260.eurprd04.prod.outlook.com>
References: <20180801114449.21208-1-stefan@agner.ch>
 <AM4PR0401MB22608258EB2B045E708A3779FF2C0@AM4PR0401MB2260.eurprd04.prod.outlook.com>
Message-ID: <7d692e8aaefcfec15877a8cd340ee646@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.2018 04:00, Andy Duan wrote:
> From: Stefan Agner <stefan@agner.ch> Sent: 2018年8月1日 19:45
>> Check DMA addressing limitations as suggested by the DMA API how-to.
>> This does not fix a particular issue seen but is considered good style.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/net/ethernet/freescale/fec_main.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/freescale/fec_main.c
>> b/drivers/net/ethernet/freescale/fec_main.c
>> index c729665107f5..af0fb200e936 100644
>> --- a/drivers/net/ethernet/freescale/fec_main.c
>> +++ b/drivers/net/ethernet/freescale/fec_main.c
>> @@ -3146,6 +3146,12 @@ static int fec_enet_init(struct net_device
>> *ndev)
>>  	fep->tx_align = 0x3;
>>  #endif
>>
>> +	/* Check mask of the streaming and coherent API */
>> +	if (dma_set_mask_and_coherent(&fep->pdev->dev,
>> DMA_BIT_MASK(32))) {
>> +		dev_warn(&fep->pdev->dev, "No suitable DMA available\n");
>> +		return -ENODEV;
> It is better:
> 
> ret = dma_set_mask_and_coherent(&fep->pdev->dev, DMA_BIT_MASK(32));
> if (ret < 0) {
> 	dev_warn(&fep->pdev->dev, "No suitable DMA available\n");
> 	return ret;
> }

The code comes from the example in Documentation/DMA-API-HOWTO.txt.

I can rearrange if you prefer.

> 
> 
> If the patch aim to "OF: Don't set default coherent DMA mask", I think
> not only this driver need to add the DMA mask limitations,  many other
> drivers also need.

It doesn't exactly address the issue since with that patch DMA mask
wasn't set at all. This code would just make the driver fail with
-ENODEV instead of -ENOMEM.

To force a DMA mask I would have to set the DMA mask using
dma_coerce_mask_and_coherent(). But as discussed with Robin it is safe
to assume that an initial mask is set by the bus code:
http://lkml.kernel.org/r/892f9d14-e6fd-7b1b-d07b-af0be6e623fa@arm.com

Setting the DMA mask on DT buses has been addressed by Robin with
"of/platform: Initialise default DMA masks". So everything should be
fine again.

I agree, other drivers need fixing too.

--
Stefan

> 
> 
>> +	}
>> +
>>  	fec_enet_alloc_queue(ndev);
>>
>>  	bd_size = (fep->total_tx_ring_size + fep->total_rx_ring_size) * dsize;
>> --
>> 2.18.0

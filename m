Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4D4C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAC620684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAC620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJCUYt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:24:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:20755 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbeJCUYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:24:49 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-70-VCdlQgMINlqyQC5ESQclYg-1; Wed, 03 Oct 2018 14:36:20 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 3 Oct 2018 14:36:20 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 3 Oct 2018 14:36:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ben Dooks' <ben.dooks@codethink.co.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "oneukum@suse.com" <oneukum@suse.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel@lists.codethink.co.uk" 
        <linux-kernel@lists.codethink.co.uk>
Subject: RE: [PATCH] usbnet: smsc95xx: simplify tx_fixup code
Thread-Topic: [PATCH] usbnet: smsc95xx: simplify tx_fixup code
Thread-Index: AQHUWx0583bpLHRSvES/p/KDDm+zIA==
Date:   Wed, 3 Oct 2018 13:36:20 +0000
Message-ID: <55e4b55bae6148b18a27a23aab7d7501@AcuMS.aculab.com>
References: <59988ed22559410881addfecf58335eb@AcuMS.aculab.com>
 <20181002165602.21033-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20181002165602.21033-1-ben.dooks@codethink.co.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: VCdlQgMINlqyQC5ESQclYg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks
> Sent: 02 October 2018 17:56
> 
> The smsc95xx_tx_fixup is doing multiple calls to skb_push() to
> put an 8-byte command header onto the packet. It would be easier
> to do one skb_push() and then copy the data in once the push is
> done.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/net/usb/smsc95xx.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
> index cb19aea139d3..813ab93ee2c3 100644
> --- a/drivers/net/usb/smsc95xx.c
> +++ b/drivers/net/usb/smsc95xx.c
> @@ -2006,6 +2006,7 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
>  	bool csum = skb->ip_summed == CHECKSUM_PARTIAL;
>  	int overhead = csum ? SMSC95XX_TX_OVERHEAD_CSUM : SMSC95XX_TX_OVERHEAD;
>  	u32 tx_cmd_a, tx_cmd_b;
> +	void *ptr;

It might be useful to define a structure for the header.
You might need to find the 'store unaligned 32bit word' macro though.
(Actually that will probably be better than the memcpy() which might
end up doing memory-memory copies rather than storing the register.)
Although if/when you add the tx alignment that won't be needed because the
header will be aligned.

>  	/* We do not advertise SG, so skbs should be already linearized */
>  	BUG_ON(skb_shinfo(skb)->nr_frags);
> @@ -2019,6 +2020,9 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
>  		return NULL;
>  	}
> 
> +	tx_cmd_b = (u32)skb->len;
> +	tx_cmd_a = tx_cmd_b | TX_CMD_A_FIRST_SEG_ | TX_CMD_A_LAST_SEG_;
> +
>  	if (csum) {
>  		if (skb->len <= 45) {
>  			/* workaround - hardware tx checksum does not work
> @@ -2035,21 +2039,18 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
>  			skb_push(skb, 4);
>  			cpu_to_le32s(&csum_preamble);

Not related, but csum_preamble = cpu_to_le32(csum_preamble) is likely to
generate better code (at least for some architectures).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FBDC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6135B20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfAWOXC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:23:02 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:50805 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbfAWOXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:23:02 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-96-RPexb6tkNqayX_AY63Fdow-1; Wed, 23 Jan 2019 14:22:56 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 23 Jan 2019 14:23:24 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 23 Jan 2019 14:23:24 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Florian Fainelli' <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>
Subject: RE: [PATCH reset-next 2/2] reset: brcmstb: Fix 32-bit build with
 64-bit resource_size_t
Thread-Topic: [PATCH reset-next 2/2] reset: brcmstb: Fix 32-bit build with
 64-bit resource_size_t
Thread-Index: AQHUsrNq0VoVkQnybEi+NjdGBGm2EKW86Kgw
Date:   Wed, 23 Jan 2019 14:23:24 +0000
Message-ID: <43155ea7637e45d6aad04f5747cbb6bb@AcuMS.aculab.com>
References: <20190123003345.13750-1-f.fainelli@gmail.com>
 <20190123003345.13750-3-f.fainelli@gmail.com>
In-Reply-To: <20190123003345.13750-3-f.fainelli@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: RPexb6tkNqayX_AY63Fdow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli
> Sent: 23 January 2019 00:34
> 
> On 32-bit architectures defining resource_size_t as 64-bit (because of
> PAE), we can run into a linker failure because of the modulo and the
> division against resource_size(), replace the two problematic operations
> with an alignment check on the register resource (instead of modulo),
> and the division with DIV_ROUND_CLOSEST_ULL().
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: c196cdc7659d ("reset: Add Broadcom STB SW_INIT reset controller driver")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/reset/reset-brcmstb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
> index 01ab1f71518b..c4cab8b5052d 100644
> --- a/drivers/reset/reset-brcmstb.c
> +++ b/drivers/reset/reset-brcmstb.c
> @@ -91,7 +91,8 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
>  		return -ENOMEM;
> 
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (resource_size(res) % SW_INIT_BANK_SIZE) {
> +	if (!IS_ALIGNED(res->start, SW_INIT_BANK_SIZE) ||
> +	    !IS_AGLINED(resource_size(res), SW_INIT_BANK_SIZE)) {
>  		dev_err(kdev, "incorrect register range\n");
>  		return -EINVAL;
>  	}
> @@ -103,7 +104,8 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
>  	dev_set_drvdata(kdev, priv);
> 
>  	priv->rcdev.owner = THIS_MODULE;
> -	priv->rcdev.nr_resets = (resource_size(res) / SW_INIT_BANK_SIZE) * 32;
> +	priv->rcdev.nr_resets = DIV_ROUND_CLOSEST_ULL(resource_size(res),
> +						      SW_INIT_BANK_SIZE) * 32;
>  	priv->rcdev.ops = &brcmstb_reset_ops;
>  	priv->rcdev.of_node = kdev->of_node;
>  	/* Use defaults: 1 cell and simple xlate function */

Isn't it enough to assign resource_size(res) to an 'unsigned int' ?
The value is never actually going to be over 4G.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


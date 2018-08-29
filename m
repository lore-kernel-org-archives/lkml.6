Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2848CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D642086A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D642086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeH2Ne4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:34:56 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:30218 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbeH2Nez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:34:55 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-49-SpdzjlCtO3mU66GnXyDhqg-1; Wed, 29 Aug 2018 10:38:50 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 29 Aug 2018 10:40:29 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 29 Aug 2018 10:40:29 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: RE: [PATCH v1 2/7] extcon: Switch to use kasprintf() instead of open
 coded
Thread-Topic: [PATCH v1 2/7] extcon: Switch to use kasprintf() instead of open
 coded
Thread-Index: AQHUPhv49VdlGh3+CkecuxtDWYg/U6TWeizA
Date:   Wed, 29 Aug 2018 09:40:29 +0000
Message-ID: <363194b6053d43a7983e8e364dbcf6a8@AcuMS.aculab.com>
References: <20180827153557.58363-1-andriy.shevchenko@linux.intel.com>
 <20180827153557.58363-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20180827153557.58363-2-andriy.shevchenko@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: SpdzjlCtO3mU66GnXyDhqg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko
> Sent: 27 August 2018 16:36
> 
> Switch to use kasprintf() instead of open coded variant.
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index c21650a92689..5ab0498be652 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1123,7 +1123,6 @@ int extcon_dev_register(struct extcon_dev *edev)
>  			(unsigned long)atomic_inc_return(&edev_no));
> 
>  	if (edev->max_supported) {
> -		char buf[10];
>  		char *str;
>  		struct extcon_cable *cable;
> 
> @@ -1137,9 +1136,7 @@ int extcon_dev_register(struct extcon_dev *edev)
>  		for (index = 0; index < edev->max_supported; index++) {
>  			cable = &edev->cables[index];
> 
> -			snprintf(buf, 10, "cable.%d", index);
> -			str = kzalloc(strlen(buf) + 1,
> -				      GFP_KERNEL);
> +			str = kasprintf(GFP_KERNEL, "cable.%d", index);

Hmmm... Why now just allocate the space for the string in the
'extcon_cable' structure.
(Then work out how to stop gcc complaining there isn't room
for 4G cables ...)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


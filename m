Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10304C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C023B2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C023B2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeJHPw2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:52:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:26323 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726113AbeJHPw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:52:27 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-7-k_-Fo9wQMBuo98nnmOM7IA-1; Mon, 08 Oct 2018 09:41:48 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 8 Oct 2018 09:41:49 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 8 Oct 2018 09:41:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Miller' <davem@davemloft.net>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel@lists.codethink.co.uk" 
        <linux-kernel@lists.codethink.co.uk>
Subject: RE: [PATCH] usbnet: smsc95xx: simplify tx_fixup code
Thread-Topic: [PATCH] usbnet: smsc95xx: simplify tx_fixup code
Thread-Index: AQHUXuLBTZ5BME15OECsJXYLxzUl/g==
Date:   Mon, 8 Oct 2018 08:41:49 +0000
Message-ID: <170d3d23a5c2463fab275d2e871775f3@AcuMS.aculab.com>
References: <59988ed22559410881addfecf58335eb@AcuMS.aculab.com>
        <20181002165602.21033-1-ben.dooks@codethink.co.uk>
 <20181005.142412.601607260441380535.davem@davemloft.net>
In-Reply-To: <20181005.142412.601607260441380535.davem@davemloft.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: k_-Fo9wQMBuo98nnmOM7IA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller
> Sent: 05 October 2018 22:24
> 
> From: Ben Dooks <ben.dooks@codethink.co.uk>
> Date: Tue,  2 Oct 2018 17:56:02 +0100
> 
> > -	memcpy(skb->data, &tx_cmd_a, 4);
> > +	ptr = skb_push(skb, 8);
> > +	tx_cmd_a = cpu_to_le32(tx_cmd_a);
> > +	tx_cmd_b = cpu_to_le32(tx_cmd_b);
> > +	memcpy(ptr, &tx_cmd_a, 4);
> > +	memcpy(ptr+4, &tx_cmd_b, 4);
> 
> Even a memcpy() through a void pointer does not guarantee that gcc will
> not emit word sized loads and stores.

True, but only if gcc can 'see' something that would require the
pointer be aligned.
In this case the void pointer comes from an external function
so is fine.

> You must use the get_unaligned()/put_unaligned() facilities to do this
> properly.
> 
> I also agree that making a proper type and structure instead of using
> a void pointer would be better.

The structure would need to be marked 'packed' - since its alignment
isn't guaranteed.
Then you don't need to use put_unaligned().

If it wasn't 'packed' then gcc would implement
memcpy(&hdr->tx_cmd_a, &tx_cmd_a, 4) using an aligned write.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


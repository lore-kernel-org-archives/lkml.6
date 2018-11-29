Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28310C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83B1205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 12:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83B1205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeK2X3r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:29:47 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:44386 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726955AbeK2X3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 18:29:47 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-198-1Dk7LxSPOC2yNA2kHpdvhw-1; Thu, 29 Nov 2018 12:24:32 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 29 Nov 2018 12:24:41 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 29 Nov 2018 12:24:41 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Grygorii Strashko' <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: RE: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx packet
 size
Thread-Topic: [PATCH] net: ethernet: ti: cpsw: allow to configure min tx
 packet size
Thread-Index: AQHUhRiwPY4w06ZY2U+34hVb39ZHZqVmrw+A
Date:   Thu, 29 Nov 2018 12:24:41 +0000
Message-ID: <59c91a27bb5b473fa5e1139016d3d825@AcuMS.aculab.com>
References: <20181125234315.28313-1-grygorii.strashko@ti.com>
In-Reply-To: <20181125234315.28313-1-grygorii.strashko@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 1Dk7LxSPOC2yNA2kHpdvhw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko
> Sent: 25 November 2018 23:43
> 
> For proper VLAN packets forwarding CPSW driver uses min tx packet size of
> 64bytes (VLAN_ETH_ZLEN, excluding ETH_FCS) which was corrected by
> commit 9421c9015047 ("net: ethernet: ti: cpsw: fix min eth packet size").
> 
> Unfortunately, this breaks some industrial automation protocols, as
> reported by TI customers [1], which can work only with min TX packet size
> from 60 byte (ecluding FCS).

VLAN packets have the same minimal size as normal packets.
So they should (probably must) only be padded to 64 bytes (including the CRC).
Any hardware that strips a VLAN header would then need to add an extra
4 bytes of padding.

You can't assume that padding that makes an ethernet frame be longer
than 64 bytes (inc CRC) will be ignored by the receiving system.

So whatever make you think that 68 bytes was required is itself broken.

While most IP implementations will ignore extra padding this isn't
true of all protocols or implementations.
Unfortunately the fact that it is silently ignored causes the bugs
to be hidden.

We've recently discovered that some configurations of a VM system
cause all ethernet packets be padded to even length.
And yes, it broke things....

One of the very early ethernet chipsets could only transmit even
length packets - but I suspect they are all now in silicon heaven.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


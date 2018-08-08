Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5220AC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101EA219C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101EA219C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeHHQo3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:44:29 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:21483 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727078AbeHHQo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:44:29 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-46-t8xWS1qPMOymlMkb5Reqfg-1; Wed, 08 Aug 2018 15:24:32 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 8 Aug 2018 15:26:11 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 8 Aug 2018 15:26:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mikulas Patocka' <mpatocka@redhat.com>
CC:     'Catalin Marinas' <catalin.marinas@arm.com>,
        Matt Sealey <neko@bakuhatsu.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Jingoo Han" <jingoohan1@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: RE: framebuffer corruption due to overlapping stp instructions on
 arm64
Thread-Topic: framebuffer corruption due to overlapping stp instructions on
 arm64
Thread-Index: AQHULxGqyzS7gP0u+Em6lFS72D3AkaS10FEA///9OACAABjskA==
Date:   Wed, 8 Aug 2018 14:26:11 +0000
Message-ID: <19c70d2a0b224db78f72dd316ad006b8@AcuMS.aculab.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <20180808121641.GB24736@iMac.local>
 <b1de49af14d941979977af07dc81e1c2@AcuMS.aculab.com>
 <alpine.LRH.2.02.1808080939180.3325@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808080939180.3325@file01.intranet.prod.int.rdu2.redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: t8xWS1qPMOymlMkb5Reqfg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka
> Sent: 08 August 2018 14:47
...
> The problem on ARM is that I see data corruption when the overlapping
> unaligned writes are done just by a single core.

Is this a sequence of unaligned writes (that shouldn't modify the
same physical locations) or an aligned write followed by an
unaligned one that updates part of the earlier write.
(Or the opposite order?)

It might be that the unaligned writes are bypassing the write-combining
buffer (without flushing it) - so overtake the aligned write.

Alternatively the unaligned writes go through the write-combining
buffer but the byte-enables aren't handled in the expected way.

It ought to be possible to work out which sequence is actually broken.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


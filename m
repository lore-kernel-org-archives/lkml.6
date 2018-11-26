Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F81C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB99213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB99213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbeKZVLf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:11:35 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:27797 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbeKZVLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:11:34 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-175-kIAkIFYwObWRNAG--sWTnA-1; Mon, 26 Nov 2018 10:17:53 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 26 Nov 2018 10:18:01 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 26 Nov 2018 10:18:01 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vincent Chen' <vincentc@andestech.com>
CC:     "green.hu@gmail.com" <green.hu@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nick Chun-Ming Hu(?????????)" <nickhu@andestech.com>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>
Subject: RE: [PATCH v4 2/5] nds32: Support FP emulation
Thread-Topic: [PATCH v4 2/5] nds32: Support FP emulation
Thread-Index: AQHUghG4/qfbmySOskGwd6CmLmV7sqVdK4IggAQdiQCAAJRa0A==
Date:   Mon, 26 Nov 2018 10:18:01 +0000
Message-ID: <3dcd9764570e4565911b74b08513e2d3@AcuMS.aculab.com>
References: <1542856478-795-1-git-send-email-vincentc@andestech.com>
 <1542856478-795-3-git-send-email-vincentc@andestech.com>
 <f0d20a4682b740659f28184c1278ae7d@AcuMS.aculab.com>
 <20181126012310.GA26621@andestech.com>
In-Reply-To: <20181126012310.GA26621@andestech.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: kIAkIFYwObWRNAG--sWTnA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen
> Sent: 26 November 2018 01:23
> On Fri, Nov 23, 2018 at 06:53:37PM +0800, David Laight wrote:
> > From: Vincent Chen
> > > Sent: 22 November 2018 03:15
> > >
> > > The Andes FPU coprocessor does not support denormalized number handling.
> > > According to the specification, FPU generates a denorm input exception
> > > that requires the kernel to deal with this instrution operation when it
> > > encounters denormalized operands. Hence an nds32 FPU ISA emulator in the
> > > kernel is required to meet requirement.
> >
> > What does the FPU generate for results near zero?
> 
> 1. The calculation result is a denormalized number
> Depending on the state of underflow trap, the FPU will raise an underflow
> exception or flash the result to zero.
> 
> 2. One of the operands is a denormalized number
> Depending on the state of the flash-to-zero mode, the FPU will raise a
> denormalized input exception, which is a specific exception of the nds FPU,
> or directly treats the operand as 0.

You didn't mention (1) in the commit message.

It ought to be possibly for the exception routine to rescale the values,
re-issue the same FP instruction, then scale the result.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


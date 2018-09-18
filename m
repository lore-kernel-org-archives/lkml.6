Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5190BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5648206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5648206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbeIRRQf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:16:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:50038 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727724AbeIRRQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:16:35 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-2-elCDoYxaPj2m9tJnUAc_Jw-1; Tue, 18 Sep 2018 12:44:19 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 18 Sep 2018 12:46:30 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 18 Sep 2018 12:46:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthias Kaehlcke' <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: RE: [PATCH] tty/sysrq: Make local variable 'killer' in
 sysrq_handle_crash() global
Thread-Topic: [PATCH] tty/sysrq: Make local variable 'killer' in
 sysrq_handle_crash() global
Thread-Index: AQHUTs5aPolqspl2kkaBePJ07chyMKT17Idg
Date:   Tue, 18 Sep 2018 11:46:30 +0000
Message-ID: <0d8470c7fdbe4429af82b830d39215f3@AcuMS.aculab.com>
References: <20180917213304.44476-1-mka@chromium.org>
In-Reply-To: <20180917213304.44476-1-mka@chromium.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: elCDoYxaPj2m9tJnUAc_Jw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Kaehlcke
> Sent: 17 September 2018 22:33
> 
> sysrq_handle_crash() dereferences a NULL pointer on purpose to force
> an exception, the local variable 'killer' is assigned to NULL and
> dereferenced later. Clang detects the NULL pointer dereference at compile
> time and emits a BRK instruction (on arm64) instead of the expected NULL
> pointer exception. Change 'killer' to a global variable (and rename it
> to 'sysrq_killer' to avoid possible clashes) to prevent Clang from
> detecting the condition. By default global variables are initialized
> with zero/NULL in C, therefore an explicit initialization is not needed.

You need an explicit initialiser in order to make it global data
rather than a common section.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


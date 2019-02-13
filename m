Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B013C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33851222E5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404284AbfBMPy2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:54:28 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:27580 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404234AbfBMPy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:54:28 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-166-k1oQZLavOXaSAW7rNrgRPg-1; Wed, 13 Feb 2019 15:54:24 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 13 Feb 2019 15:55:07 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 13 Feb 2019 15:55:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Miklos Szeredi" <miklos@szeredi.hu>,
        Daniel Colascione <dancol@google.com>,
        "Dave Chinner" <david@fromorbit.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Marc Zyngier" <marc.zyngier@arm.com>
Subject: RE: [patch V2 1/2] genriq: Avoid summation loops for /proc/stat
Thread-Topic: [patch V2 1/2] genriq: Avoid summation loops for /proc/stat
Thread-Index: AQHUwClvyqUPjiZOrkij6vFj5+YdfaXd56QA
Date:   Wed, 13 Feb 2019 15:55:07 +0000
Message-ID: <3460540b50784dca813a57ddbbd41656@AcuMS.aculab.com>
References: <20190208134802.218483159@linutronix.de>
 <20190208135020.925487496@linutronix.de>
 <20190208143255.9dec696b15f03bf00f4c60c2@linux-foundation.org>
 <c40b7b94-00e3-9b59-fd66-904b54fc69b4@redhat.com>
 <20190208152151.ed4cf0c52e5970fc7a7911f1@linux-foundation.org>
 <20190209034117.GC21860@bombadil.infradead.org>
In-Reply-To: <20190209034117.GC21860@bombadil.infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: k1oQZLavOXaSAW7rNrgRPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox
> Sent: 09 February 2019 03:41
> 
> On Fri, Feb 08, 2019 at 03:21:51PM -0800, Andrew Morton wrote:
> > It sounds like it.  A 10khz interrupt will overflow in 4 days...
> 
> If you've got a 10kHz interrupt, you have a bigger problem.  Anything
> happening 10,000 times a second is going to need interrupt mitigation
> to perform acceptably.

Not necessarily - you may want the immediate interrupt for each
received ethernet packet.

> More importantly, userspace can (and must) cope with wrapping.  This isn't
> anything new from Thomas' patch.  As long as userspace is polling more
> often than once a day, it's going to see a wrapped value before it wraps
> again, so it won't miss 4 billion interrupts.

If userspace is expected to detect wraps, making the sum 64bit is
pointless, confusing and stupid.
The code would have to mask off the high bits before determining
that the value has decreased and then adding in 2^32.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


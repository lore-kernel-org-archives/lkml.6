Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B54C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946112147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfBTPfL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:35:11 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:50108 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbfBTPfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:35:09 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-144-XQf-YB9ZOCCigPj7pZwp3Q-1; Wed, 20 Feb 2019 15:35:04 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 20 Feb 2019 15:35:47 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 20 Feb 2019 15:35:47 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "aubrey.li@intel.com" <aubrey.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v11 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed
 time
Thread-Topic: [PATCH v11 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed
 time
Thread-Index: AQHUxfcRyyHb5ONntEyuRHrlz5Ku+6Xo1XaA
Date:   Wed, 20 Feb 2019 15:35:47 +0000
Message-ID: <5c6ed8168eb34e0e84245fe01ba477ef@AcuMS.aculab.com>
References: <20190213023748.6614-1-aubrey.li@linux.intel.com>
 <20190213023748.6614-2-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1902141212400.1561@nanos.tec.linutronix.de>
 <85b22e16-fffc-7ebe-2ab1-3b6fe7e036ab@linux.intel.com>
 <alpine.DEB.2.21.1902161340320.1683@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1902161340320.1683@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: XQf-YB9ZOCCigPj7pZwp3Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sent: 16 February 2019 12:56
> To: Li, Aubrey
...
> The above experiment just confirms what I said: The numbers are inaccurate
> and potentially misleading to a large extent when the AVX using task is not
> scheduled out for a longer time.

Not only that, they won't detect programs that use AVX-512 but never
context switch with live AVX-512 registers.

Since the registers are all caller-saved they can be zeroed after being
saved (or used) in order to speed up any context switches.

I believe that all system calls are now done through libc 'stub'
functions (I haven't seen inlined system calls for ages).
So by the time the kernel is entered (by a system call) none of the AVX
(or even SSE2?) registers can contain live values.
This should mean it is save for the system call entry code to
zero all the AVX registers - so none will be saved by a context switch.

Of course, is the kernel is entered by a trap or hardware interrupt
the registers are live and do need saving.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


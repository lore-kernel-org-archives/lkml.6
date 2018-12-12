Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840B2C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED972084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED972084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbeLLQzK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:55:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:27171 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727691AbeLLQzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:55:09 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-163-4NpIjPwqOC6IG_9isv_0zg-1; Wed, 12 Dec 2018 16:55:06 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 12 Dec 2018 16:55:17 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 12 Dec 2018 16:55:17 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Aubrey Li' <aubrey.li@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: RE: [PATCH v4 1/2] x86/fpu: track AVX-512 usage of tasks
Thread-Topic: [PATCH v4 1/2] x86/fpu: track AVX-512 usage of tasks
Thread-Index: AQHUkSUo7xJBKZwc2k62yoB0IvRxl6V7UyiQ
Date:   Wed, 12 Dec 2018 16:55:17 +0000
Message-ID: <c87224bd48bc4296a38ae4852bf28071@AcuMS.aculab.com>
References: <20181211002448.3520-1-aubrey.li@intel.com>
In-Reply-To: <20181211002448.3520-1-aubrey.li@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 4NpIjPwqOC6IG_9isv_0zg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aubrey Li
> Sent: 11 December 2018 00:25
> 
> User space tools which do automated task placement need information
> about AVX-512 usage of tasks, because AVX-512 usage could cause core
> turbo frequency drop and impact the running task on the sibling CPU.
> 
> The XSAVE hardware structure has bits that indicate when valid state
> is present in registers unique to AVX-512 use.  Use these bits to
> indicate when AVX-512 has been in use and add per-task AVX-512 state
> tracking to context switch.

Isn't a thread likely to clear the AVX registers at the end of a function
that uses them.
In particular this removes the massive overhead on certain cpus of
switching between two AVX modes.
So it is actually unlikely that XSAVE will need to save them at all?

As I've also said before the registers are caller saved and since
systems calls are normal function calls the application code
would have to save them across a system call.
This allows the kernel to zero the registers on system call entry
again meaning that XSAVE won't normally have to save them.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE67C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2EB223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2EB223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbeKNVMK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:12:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:34486 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726823AbeKNVMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:12:09 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-24-JnPj-GKMNu6VmkcwUuzS9A-1; Wed, 14 Nov 2018 11:09:19 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 14 Nov 2018 11:09:25 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 14 Nov 2018 11:09:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'William Kucharski' <william.kucharski@oracle.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>
CC:     Kees Cook <keescook@chromium.org>,
        "crecklin@redhat.com" <crecklin@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "psodagud@codeaurora.org" <psodagud@codeaurora.org>,
        "tsoni@codeaurora.org" <tsoni@codeaurora.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] mm/usercopy: Use memory range to be accessed for
 wraparound check
Thread-Topic: [PATCH] mm/usercopy: Use memory range to be accessed for
 wraparound check
Thread-Index: AQHUfAXMm0KhA+w52Ui13XJlKrLpAaVPG7lg
Date:   Wed, 14 Nov 2018 11:09:25 +0000
Message-ID: <5dcd06a0f84a4824bb9bab2b437e190d@AcuMS.aculab.com>
References: <1542156686-12253-1-git-send-email-isaacm@codeaurora.org>
 <FFE931C2-DE41-4AD8-866B-FD37C1493590@oracle.com>
In-Reply-To: <FFE931C2-DE41-4AD8-866B-FD37C1493590@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: JnPj-GKMNu6VmkcwUuzS9A-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Kucharski
> Sent: 14 November 2018 10:35
> 
> > On Nov 13, 2018, at 5:51 PM, Isaac J. Manjarres <isaacm@codeaurora.org> wrote:
> >
> > diff --git a/mm/usercopy.c b/mm/usercopy.c
> > index 852eb4e..0293645 100644
> > --- a/mm/usercopy.c
> > +++ b/mm/usercopy.c
> > @@ -151,7 +151,7 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
> > 				       bool to_user)
> > {
> > 	/* Reject if object wraps past end of memory. */
> > -	if (ptr + n < ptr)
> > +	if (ptr + (n - 1) < ptr)
> > 		usercopy_abort("wrapped address", NULL, to_user, 0, ptr + n);
> 
> I'm being paranoid, but is it possible this routine could ever be passed "n" set to zero?
> 
> If so, it will erroneously abort indicating a wrapped address as (n - 1) wraps to ULONG_MAX.
> 
> Easily fixed via:
> 
> 	if ((n != 0) && (ptr + (n - 1) < ptr))

Ugg... you don't want a double test.

I'd guess that a length of zero is likely, but a usercopy that includes
the highest address is going to be invalid because it is a kernel address
(on most archs, and probably illegal on others).
What you really want to do is add 'ptr + len' and check the carry flag.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


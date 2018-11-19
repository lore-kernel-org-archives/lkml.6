Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BA4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C612089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C612089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbeKTAjN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:39:13 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:20423 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728252AbeKTAjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:39:12 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-112-1WagJuYKPWyp2NEK7jIZzg-1; Mon, 19 Nov 2018 14:15:25 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 19 Nov 2018 14:15:31 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 19 Nov 2018 14:15:31 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christian Brauner' <christian@brauner.io>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "serge@hallyn.com" <serge@hallyn.com>,
        "jannh@google.com" <jannh@google.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "dancol@google.com" <dancol@google.com>,
        "timmurray@google.com" <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: RE: [PATCH] proc: allow killing processes via file descriptors
Thread-Topic: [PATCH] proc: allow killing processes via file descriptors
Thread-Index: AQHUfzCMPJnedN49+EaYHywV7sQfyKVXJFlw
Date:   Mon, 19 Nov 2018 14:15:31 +0000
Message-ID: <9a269517770e4881b92756d47f17a5fd@AcuMS.aculab.com>
References: <20181118111751.6142-1-christian@brauner.io>
In-Reply-To: <20181118111751.6142-1-christian@brauner.io>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 1WagJuYKPWyp2NEK7jIZzg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: > Christian Brauner
> Sent: 18 November 2018 11:18
> 
> With this patch an open() call on /proc/<pid> will give userspace a handle
> to struct pid of the process associated with /proc/<pid>. This allows to
> maintain a stable handle on a process.

My 3c...

You need to add a version of fork() that returns an open fd to
/proc/pid to the parent.

Is it possible to overload fcntl() rather than ioctl() ?

More interestingly what about a 'unique pid' (eg the pid extended to
(say) 128 bits with a use count) that can be safely put into a /var/run/pid
file for a daemon and used later in a 'kill' that will only ever
reference the correct process.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D10CC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9A92098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9A92098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeJCUK2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:10:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:26207 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726892AbeJCUK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:10:26 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-120-QlLK1ZM2OOarbzJTma5vXA-1; Wed, 03 Oct 2018 14:22:00 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 3 Oct 2018 14:22:00 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 3 Oct 2018 14:22:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Aleksa Sarai' <cyphar@cyphar.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        "Tycho Andersen" <tycho@tycho.ws>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "dev@opencontainers.org" <dev@opencontainers.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>
Subject: RE: [PATCH 0/3] namei: implement various scoping AT_* flags
Thread-Topic: [PATCH 0/3] namei: implement various scoping AT_* flags
Thread-Index: AQHUV+AfgFSHvxd/OEe4NbXBVB2oHaUKX0QAgAAkL4CAAu0OMA==
Date:   Wed, 3 Oct 2018 13:21:59 +0000
Message-ID: <71b13208253f4b3fa82640ec96bf9301@AcuMS.aculab.com>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <1f1d699b1c8d472495a5b07199c31a6e@AcuMS.aculab.com>
 <20181001161535.3zslyuk6vmnpioy6@ryuk>
In-Reply-To: <20181001161535.3zslyuk6vmnpioy6@ryuk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: QlLK1ZM2OOarbzJTma5vXA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aleksa Sarai
> Sent: 01 October 2018 17:16
> 
> On 2018-10-01, David Laight <David.Laight@ACULAB.COM> wrote:
...
> > >   * Mountpoint crossings are blocked by AT_XDEV.
> >
> > You might want a mountpoint flag that allows crossing into the mounted
> > filesystem (you may need to get out in order to do pwd()).
> 
> Like a mount flag? I'm not sure how I feel about that. The intention is
> to allow for a process to have control over how path lookups are
> handled, and tying it to a mount flag means that it's no longer entirely
> up to the process.

Right, but you may have some mount points that you don't want to cross
and others that it is perfectly fine to cross.
For example you might want to be able to cross into a 'tmp' filesystem.

...
> > If you make the flags a property of the directory vnode (perhaps as
> > well as any syscall flags), and make it inherited by vnode lookup then
> > it can be used to stop library functions (or entire binaries) using
> > blocked paths.
> > You'd then only need to add an fcntl() call to set the flags (but never
> > clear them) to get the restriction applied to every lookup.
> 
> This seems like it might be useful, but it could always be done as a
> follow-up patch by just setting LOOKUP_BLAH if the dirfd has the flag
> set. I'm also a little bit concerned that (because fd flags are set on
> the 'struct file') if you start sharing fds then you can no longer use
> the lookup scoping for security (a racing process could remove the
> flags while the management process resolves through it).

I was thinking that the flags would never be removable.
A management process might have to flip its cwd back and forth
in order to clear the flags (opendir(".") should give a different
struct file).

This all gets tied up with the slight requirement for per-thread cwd.

I had another thought that the crudentials structure used for a file
lookup could also be taken from the cwd (not sure how it would
get there - especially if you need the correct group list).
That would allow a 'management' process to open a file in the context
of the target user process.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


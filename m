Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F67C282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA424218D9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfBHJwZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:52:25 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:57711 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727127AbfBHJwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:52:24 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-97-BZtxAGQ3OTypNMlgcy5_9g-1; Fri, 08 Feb 2019 09:52:21 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 8 Feb 2019 09:53:04 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 8 Feb 2019 09:53:04 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>
CC:     Julien Gomes <julien@arista.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>,
        "vyasevich@gmail.com" <vyasevich@gmail.com>,
        "lucien.xin@gmail.com" <lucien.xin@gmail.com>
Subject: RE: [PATCH net] sctp: make sctp_setsockopt_events() less strict about
 the option length
Thread-Topic: [PATCH net] sctp: make sctp_setsockopt_events() less strict
 about the option length
Thread-Index: AQHUvmASGkCaWibVqE6iK21f5qVrJKXUlzwQgAAGVoCAAQsJ0A==
Date:   Fri, 8 Feb 2019 09:53:03 +0000
Message-ID: <0415888f34e7494e9879a77599c618e0@AcuMS.aculab.com>
References: <20190206201430.18830-1-julien@arista.com>
 <20190206203754.GC13621@localhost.localdomain>
 <c13067c0-f127-50a0-9ae0-4be7f0399c0d@arista.com>
 <20190206210723.GD13621@localhost.localdomain>
 <1257941619984a2a992af8d801855c04@AcuMS.aculab.com>
 <20190207174715.GF13621@localhost.localdomain>
In-Reply-To: <20190207174715.GF13621@localhost.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: BZtxAGQ3OTypNMlgcy5_9g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 'Marcelo Ricardo Leitner'
> Sent: 07 February 2019 17:47
...
> > > Maybe what we want(ed) here then is explicit versioning, to have the 3
> > > definitions available. Then the application is able to use, say struct
> > > sctp_event_subscribe, and be happy with it, while there is struct
> > > sctp_event_subscribe_v2 and struct sctp_event_subscribe_v3 there too.
> > >
> > > But it's too late for that now because that would break applications
> > > already using the new fields in sctp_event_subscribe.
> >
> > It is probably better to break the recompilation of the few programs
> > that use the new fields (and have them not work on old kernels)
> > than to stop recompilations of old programs stop working on old
> > kernels or have requested new options silently ignored.
> 
> I got confused here, not sure what you mean. Seems there is one "stop"
> word too many.

More confusing than I intended...

With the current kernel and headers a 'new program' (one that
needs the new options) will fail to run on an old kernel - which is good.
However a recompilation of an 'old program' (that doesn't use
the new options) will also fail to run on an old kernel - which is bad.

Changing the kernel to ignore extra events flags breaks the 'new'
program.

Versioning the structure now (even though it should have been done
earlier) won't change the behaviour of existing binaries.

However a recompilation of an 'old' program would use the 'old'
structure and work on old kernels.
Attempts to recompile a 'new' program will fail - until the structure
name (or some #define to enable the extra fields) is changed.

Breaking compilations is much better than unexpected run-time
behaviour.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


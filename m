Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbeBEP1o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:27:44 -0500
Received: from smtp-out6.electric.net ([192.162.217.191]:50660 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753137AbeBEP1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:27:39 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Andrew Cooper'" <andrew.cooper3@citrix.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
CC: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Xen-devel] [PATCH] [v2] xen: hypercall: fix out-of-bounds memcpy
Thread-Topic: [Xen-devel] [PATCH] [v2] xen: hypercall: fix out-of-bounds
 memcpy
Thread-Index: AQHTnpTDsMW5KYPYZ0CHi4ZlpEvwv6OV7SDw
Date: Mon, 5 Feb 2018 15:28:23 +0000
Message-ID: <0f6cfd45286247a3b69d46db1bc87fb5@AcuMS.aculab.com>
References: <20180205150340.328921-1-arnd@arndb.de>
 <67d8f0f1-0846-876d-d36a-c8a9f9366243@citrix.com>
In-Reply-To: <67d8f0f1-0846-876d-d36a-c8a9f9366243@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w15FTG1w020646

From: Andrew Cooper
> Sent: 05 February 2018 15:14
> 
> On 05/02/18 15:03, Arnd Bergmann wrote:
> 
> Snipping deleted code to make things clearer:
> 
> > +	if (cmd > ARRAY_SIZE(physdevop_len))
> > +		return -ENOSYS;
> >
> > +	len = physdevop_len[cmd];
> > +	memcpy(&op.u, arg, len);
> 
> You'll want an array_nospec() or whatever its called these days.  This
> code is SP1-leaky.
> 
> Userspace controls cmd and can retrieve len by timing how many adjacent
> cache lines were pulled in my memcpy().

Well, maybe it can read beyond the bounds of physdevop_len[].
I doubt that the memcpy() will pull in many cache lines so you
can probably only determine whether the value is 0..63, 64..127 or 128+
Not likely to be much use.

	David

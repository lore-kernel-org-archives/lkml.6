Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeBIOMf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 09:12:35 -0500
Received: from smtp-out6.electric.net ([192.162.217.184]:56975 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeBIOMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 09:12:32 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Arnd Bergmann'" <arnd@arndb.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: RE: [Xen-devel] [PATCH] [v2] xen: hypercall: fix out-of-bounds memcpy
Thread-Topic: [Xen-devel] [PATCH] [v2] xen: hypercall: fix out-of-bounds
 memcpy
Thread-Index: AQHToaW2hAmOQzi7s0y/ZNGjmF+sSaOcGtMw
Date: Fri, 9 Feb 2018 14:13:14 +0000
Message-ID: <42258ad55dac4191813d258e43a44e0e@AcuMS.aculab.com>
References: <20180205150340.328921-1-arnd@arndb.de>
 <67d8f0f1-0846-876d-d36a-c8a9f9366243@citrix.com>
 <CAK8P3a36O-NbrKkt-DEEZE2A2JQ5Gu9GZ98j0BjoFET4kgTaWw@mail.gmail.com>
In-Reply-To: <CAK8P3a36O-NbrKkt-DEEZE2A2JQ5Gu9GZ98j0BjoFET4kgTaWw@mail.gmail.com>
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
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w19ECfd8031278

From: Arnd Bergmann
> Sent: 09 February 2018 12:58
...
> However, aside from this driver, I wonder if we should be worried about
> Spectre type 1 attacks on similar code, when gcc-8 turns a switch/case
> statement into an array lookup behind our back, e.g. in an ioctl handler.
> Has anybody got this on their radar?

The canonical code for a switch statement is to jump indirect on an array
of code pointers.
ioctl handlers probably use a series of compares because the values are
sparse.

Also remember that gcc-8 will convert dense switch statements that just
load a value into a data array lookup.

I guess both those jump tables are potential attack vectors.
Not quite sure how they might be used to leak info though.

	David

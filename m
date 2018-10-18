Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABFBC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B0C2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B0C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeJRXKE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:10:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:36523 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbeJRXKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:10:04 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-139-J2gqySlWOL6SzHQP0_AXBw-1; Thu, 18 Oct 2018 16:08:32 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 18 Oct 2018 16:08:34 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 18 Oct 2018 16:08:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dan Carpenter' <dan.carpenter@oracle.com>,
        "kys@microsoft.com" <kys@microsoft.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "Michael.H.Kelley@microsoft.com" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH V2 5/5] Tools: hv: kvp: Fix a warning of buffer overflow
 with gcc 8.0.1
Thread-Topic: [PATCH V2 5/5] Tools: hv: kvp: Fix a warning of buffer overflow
 with gcc 8.0.1
Thread-Index: AQHUZqxsXivxKNXkpUiDU89D21DY1aUlGmNg
Date:   Thu, 18 Oct 2018 15:08:34 +0000
Message-ID: <872b63db79e5468f97dded249c4478f9@AcuMS.aculab.com>
References: <20181018050835.27828-1-kys@linuxonhyperv.com>
 <20181018050932.27932-1-kys@linuxonhyperv.com>
 <20181018050932.27932-5-kys@linuxonhyperv.com>
 <20181018063230.v6hp5e3agk62c3s3@mwanda>
In-Reply-To: <20181018063230.v6hp5e3agk62c3s3@mwanda>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: J2gqySlWOL6SzHQP0_AXBw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter
> Sent: 18 October 2018 07:33
> 
> On Thu, Oct 18, 2018 at 05:09:32AM +0000, kys@linuxonhyperv.com wrote:
> > From: Dexuan Cui <decui@microsoft.com>
> >
> > The patch fixes:
> >
> > hv_kvp_daemon.c: In function 'kvp_set_ip_info':
> > hv_kvp_daemon.c:1305:2: note: 'snprintf' output between 41 and 4136 bytes
> > into a destination of size 4096
> >
> > The "(unsigned int)str_len" is to avoid:
> >
> > hv_kvp_daemon.c:1309:30: warning: comparison of integer expressions of
> > different signedness: 'int' and 'long unsigned int' [-Wsign-compare]

I usually use 'str_len + 0u' rather than a cast.

> Ugh...  Any tool with the most basic flow analysis would realize this
> was a false positive.  We use at least three static analyzers which
> catch signedness bugs.  Can we turn off GCC's warning on this until they
> improve it a bit?

Yes, would be nice if it attempted to follow the valid domain of variables.

I recently had to change:
	unsigned char a, b;
	unsigned int c;
	...
	if (a + b < c)
To stop a 'signedness' warning.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


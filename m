Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF94C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14192081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfBDMRE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:17:04 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:52055 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728216AbfBDMRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:17:04 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-186-21gOOKMAOxe51vSNjyFcuQ-1; Mon, 04 Feb 2019 12:17:01 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 4 Feb 2019 12:17:43 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 4 Feb 2019 12:17:43 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jarkko Sakkinen' <jarkko.sakkinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: RE: [PATCH] tpm/tpm_crb: Avoid unaligned reads in crb_recv():
Thread-Topic: [PATCH] tpm/tpm_crb: Avoid unaligned reads in crb_recv():
Thread-Index: AQHUuiIbeXT7VAC4P0CcjbhYywJnDaXPkXWA
Date:   Mon, 4 Feb 2019 12:17:43 +0000
Message-ID: <0446c899270a4b128a6d05e62d63e704@AcuMS.aculab.com>
References: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20190201111949.14881-1-jarkko.sakkinen@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 21gOOKMAOxe51vSNjyFcuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Sakkinen
> Sent: 01 February 2019 11:20
> The current approach to read first 6 bytes from the response and then tail
> of the response, can cause the 2nd memcpy_fromio() to do an unaligned read
> (e.g. read 32-bit word from address aligned to a 16-bits), depending on how
> memcpy_fromio() is implemented. If this happens, the read will fail and the
> memory controller will fill the read with 1's.

To my mind memcpy_to/fromio() should only be used on IO addresses that are
adequately like memory, and should be implemented in a way that that won't
generate invalid bus cycles.
Also memcpy_fromio() should also be allowed to do 'aligned' accesses that
go beyond the ends of the required memory area.

...
> 
> -	memcpy_fromio(buf, priv->rsp, 6);
> +	memcpy_fromio(buf, priv->rsp, 8);
>  	expected = be32_to_cpup((__be32 *) &buf[2]);
> -	if (expected > count || expected < 6)
> +	if (expected > count || expected < 8)
>  		return -EIO;
> 
> -	memcpy_fromio(&buf[6], &priv->rsp[6], expected - 6);
> +	memcpy_fromio(&buf[8], &priv->rsp[8], expected - 8);

Why not just use readl() or readq() ?

Bound to generate better code.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


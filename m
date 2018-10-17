Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B396CECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BEE2150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BEE2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeJQSGr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:06:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:20666 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726904AbeJQSGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:06:47 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-162-tXQJyXWYNJehtBXiAgLmfQ-1; Wed, 17 Oct 2018 11:11:44 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 17 Oct 2018 11:11:47 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 17 Oct 2018 11:11:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Phillip Potter' <phil@philpotter.co.uk>,
        "dushistov@mail.ru" <dushistov@mail.ru>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] fs: ufs: Remove switch statement from ufs_set_de_type
 function
Thread-Topic: [PATCH] fs: ufs: Remove switch statement from ufs_set_de_type
 function
Thread-Index: AQHUZgFURKmy3AiM50iT9d1crP1xJaUjNyFw
Date:   Wed, 17 Oct 2018 10:11:47 +0000
Message-ID: <fc2004614b7e4a35a67eb93a007a60f8@AcuMS.aculab.com>
References: <20181017100809.GA9070@pathfinder>
In-Reply-To: <20181017100809.GA9070@pathfinder>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: tXQJyXWYNJehtBXiAgLmfQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phillip Potter
> Sent: 17 October 2018 11:08
> 
> Remove switch statement from ufs_set_de_type function in fs/ufs/util.h
> header and replace with simple assignment. For each case, S_IFx >> 12
> is equal to DT_x, so in valid cases (mode & S_IFMT) >> 12 should give
> us the correct file type. For invalid cases, upper layer validation
> catches this anyway, so this improves readability and arguably
> performance by assigning (mode & S_IFMT) >> 12 directly.
> 
...
> -	case S_IFIFO:
> -		de->d_u.d_44.d_type = DT_FIFO;
> -		break;
> -	default:
> -		de->d_u.d_44.d_type = DT_UNKNOWN;
> -	}
> +	de->d_u.d_44.d_type = (mode & S_IFMT) >> S_SHIFT;

This requires that the two sets of constants are correctly aligned.
If they aren't defined in terms of each other then you probably
ought to add compile-time asserts that the values match.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


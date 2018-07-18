Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D240ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268D420850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268D420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbeGRPBk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:01:40 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:23775 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730248AbeGRPBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:01:40 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-16-c7RcL3sIPnGGCHd5AMW2yA-1; Wed, 18 Jul 2018 15:23:29 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 18 Jul 2018 15:25:08 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 18 Jul 2018 15:25:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: Enabling the ORC unwinder generates invalid .o files.
Thread-Topic: Enabling the ORC unwinder generates invalid .o files.
Thread-Index: AdQeoyD+6oLY5G0KSNWD6zQHBSPcsw==
Date:   Wed, 18 Jul 2018 14:25:08 +0000
Message-ID: <ec49fdfc7c0b421b8818301cc44de659@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: c7RcL3sIPnGGCHd5AMW2yA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As was discovered last september (https://lkml.org/lkml/2017/9/14/561)
running objtool to generate the orc unwind data will generate invalid
object files on an systems where libelf.so hasn't been patched.

I've just spent a day debugging the same issue - as far as the
corrupted section headers - before managing to get a search tell
me something other than I was running an old distribution.

Since then the orc unwinder has been made the default on x86-64.
So anyone running anything other than the very latest distributions
can't actually build a kernel from sources.
The 'allmodconfig' build goes particularly badly.

It wouldn't be quite as annoying if the build detected the failure
and suggested updating libelf (I found 0.165 to replace 0.153) or
disabling orc.

The kernel build claims to support much older compilers than the
gcc 4.7.3 I'm trying to use, so I'd expect it to compile with
the version of libelf of the same vintage.

Perhaps the solution is to put a copy of (the required parts of)
the libelf sources with the objtool sources so that a known
version is used.
This would also safe the problems that also arise because libelf
isn't installed by default.

	David
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

Please consider the environment and don't print this e-mail unless you really need to


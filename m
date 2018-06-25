Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57B1C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A4825D36
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bjOAnH6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A4825D36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754547AbeFYPpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:45:50 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:57979 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752589AbeFYPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:45:46 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9867524E02F0;
        Mon, 25 Jun 2018 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529941545; bh=/EvjsKBpQJE8zgRTkHQjyauoHH4Db5JOX+Ic6lDVcAA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bjOAnH6zF5Btp11XOTGz7+Zo+2ZF0z9nvOvIIPLDZCXX2Ag2N0WqKe2wrKYwEbQxq
         SqyfN4lRrniUIkUtpY1ojMccFPTmsNWltKh3RMrINrjerjy7GiRufVbfZB/QHliYdA
         ePFwtC5oY393SR1lst+q9UgPV6eZse2GzowT1r1kxUzLPNkiKxxuM/uU3onukMrcnI
         EMH6PLnhsq0AUVaLJ08+xk3PhLI3u14VB1vSdvld/6rW7J078whYn/3p6c9WyuDsH3
         0rSNurkw+LQ8YVOI1l8XZwVOA70FCxO8Pm12cHxPNingBIgAXj9dIBOd/ZDJKfhwKj
         Y1lETXRoWfGZw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 993523461;
        Mon, 25 Jun 2018 08:45:44 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 25 Jun 2018 08:45:44 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 25 Jun 2018 17:45:41 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "hch@lst.de" <hch@lst.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [RFC] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Thread-Topic: [RFC] ARC: allow to use IOC and non-IOC DMA devices
 simultaneously
Thread-Index: AQHUBKiNKzhGZzesPUyAsKt+FXE7PaRmg2uAgAW8xACABMwZAA==
Date:   Mon, 25 Jun 2018 15:45:40 +0000
Message-ID: <456ab2264aa42d575e7ca5d28d34466aea082f14.camel@synopsys.com>
References: <20180615125819.527-1-Eugeniy.Paltsev@synopsys.com>
         <563bd0ab-e40c-f9ad-4e9c-dbf5b13358b5@synopsys.com>
         <1529677805.31605.28.camel@synopsys.com>
In-Reply-To: <1529677805.31605.28.camel@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.9.128.69]
Content-Type: text/plain; charset="utf-8"
Content-ID: <46EF566A114CC7499888C8D82F3672F4@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXVnZW5peSwNCg0KT24gRnJpLCAyMDE4LTA2LTIyIGF0IDE2OjMwICswMjAwLCBFdWdlbml5
IFBhbHRzZXYgd3JvdGU6DQo+IEhpIFZpbmVldCwgQ2hyaXN0b3BoLA0KPiB0aGFua3MgZm9yIHJl
c3BvbmRpbmcuDQoNCltzbmlwXQ0KDQo+ID4gPiAoQlRXOiBjdXJyZW50IEFSQyBkbWFfbm9uY29o
ZXJlbnRfb3BzIGltcGxlbWVudGF0aW9uIGFsc28gaGFzIHNhbWUNCj4gPiA+IHByb2JsZW0gaWYg
SU9DIGFuZCBISUdITUVNIGFyZSBlbmFibGVkLikNCj4gPiANCj4gPiBDYW4gd2UgaGlnaGxpZ2h0
IHRoaXMgZmFjdCwgYWRkIGVycm9yIHByaW50cyBzb21ld2hlcmUgPw0KPiANCj4gVGhlIGVhc2ll
c3Qgc29sdXRpb24gaXMgdG8gcGFuaWMgaWYgYm90aCBJT0MgYW5kIFpPTkVfSElHSE1FTSBlbmFi
bGVkLg0KDQpJIGRvbid0IHRoaW5rIGl0J3MgdGhlIGJlc3QgaWRlYSAtIEkgd291bGQgZXhwZWN0
IHRvIGdldCBQQUU0MCBlbmFibGVkDQpieSBkZWZhdWx0IG9yIGF0IGxlYXN0IHRvIGJlIHVzZWQg
cXVpdGUgb2Z0ZW4gb24gYm90aCBBWFMxMDMgYW5kIEhTREsNCmFuZCBzbyByZXN0cmljdGluZyB1
c2FnZSBvZiBJT0Mgb24gc3VjaCBjb25maWd1cmF0aW9ucyB3aWxsIGJlIHF1aXRlDQpjb25mdXNp
bmcuDQoNClRoYXQgc2FpZCB3ZSBuZWVkIHRvIGZpZ3VyZSBvdXQgaG93IHRvIGdldCBJT0MgKyBI
SUdITUVNL1BBRSB3b3JraW5nDQpyZWxpYWJseSBpZiB0aGF0J3MgcG9zc2libGUgYXQgYWxsLg0K
DQpDaHJpc3RvcGgsIGRvIHlvdSB0aGluayBpZiB0aGlzIGlzIGRvYWJsZT8NClRoZSBtYWluIGNv
bmNlcm4gaGVyZSBpczogc29tZSByYW5kb20gZGF0YSBidWZmZXIgbWlnaHQgYmUgYWxsb2NhdGVk
DQppbiBhbnkgYXZhaWxhYmxlIG1lbW9yeSBbYW5kIGluIEhJR0hNRU0vUEFFIGlmIGl0IGV4aXN0
cyBlc3NlbnRpYWxseV0gYW5kDQp3aGVuIGl0IGNvbWVzIHRvIERNQSBleGNoYW5nZSB0aGF0IGlu
dm9sdmVzIHRoYXQgYnVmZmVyIHdoYXQgc2hvdWxkIHdlIGRvPw0KDQpUaGUgb25seSB0aGluZyBJ
IG1heSB0aGluayBvZiBjb3VsZCBiZSBhIGJvdW5jZS1idWZmZXIgaW4gWk9ORV9OT1JNQUwuDQpJ
cyBpdCB1c2VkIGJ5IGFueWJvZHk/IEFyZSB0aGVyZSBhbnkgYmV0dGVyIGlkZWFzPyANCg0KLUFs
ZXhleQ==

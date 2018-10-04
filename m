Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47290C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB7C206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JOIzcI5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB7C206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeJDXNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:13:21 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:59744 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbeJDXNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:13:21 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 26E9110C0B09;
        Thu,  4 Oct 2018 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1538669963; bh=m9oPieFqBRgxwDYD2l2QYkmohTmRj2gEVKBEW9jiiro=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JOIzcI5LV9I10mM7mW2IyWCJozs5GIq4Y1URvRVbY0iEevP4rKK78xAZigj6KowXD
         LcoytAe0EygdqmMsmdkmN+5ZlZIMSBhBcXAkIJLA5pdT23gVju5+ZXTMdrO3f6tBJV
         GmmZpiTKe+L94ilMMZm5F9y+htlKinaK9nE6ktI84KBXELOtWfaCS9pEzeTUZ7nJHN
         sSB9T++ZYdVaMiCYOSJ5KLDfRRxJtGZ7sMVtXQdpN9y6J68GT0DkIX9vu/2it5v7Hy
         XtRdrCVmenMEJK6j0vitzADG6ohAPfWv2SzcvyH53w3Ag1zG4HX6LdgQvp83AReQCC
         jd5wgnsGqylYA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 513CE33E6;
        Thu,  4 Oct 2018 09:19:20 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 4 Oct 2018 09:19:19 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 4 Oct 2018 18:19:16 +0200
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "greg@kroah.com" <greg@kroah.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Thread-Topic: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Thread-Index: AQHUF4swC8s+UKwhqUSMtDZM6j3qZaSGy6yAgAABBQCAAAZHAIAABHmAgAABKoCAiNLDgA==
Date:   Thu, 4 Oct 2018 16:19:16 +0000
Message-ID: <ad4f865a92828c3226628a0e378ca2fb4054e96a.camel@synopsys.com>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
         <20180709140717.GR2476@hirez.programming.kicks-ass.net>
         <20180709141056.GR2512@hirez.programming.kicks-ass.net>
         <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
         <20180709144925.GU2476@hirez.programming.kicks-ass.net>
         <4f6e9e8bf60f05872afaed4a1d8e516331e95ea7.camel@synopsys.com>
In-Reply-To: <4f6e9e8bf60f05872afaed4a1d8e516331e95ea7.camel@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.42]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8E53F6133B72C4FAA865926D1CDE440@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGV0ZXIsDQoNCk9uIE1vbiwgMjAxOC0wNy0wOSBhdCAxNzo1MyArMDMwMCwgQWxleGV5IEJy
b2RraW4gd3JvdGU6DQo+IEhpIFBldGVyLA0KPiANCj4gT24gTW9uLCAyMDE4LTA3LTA5IGF0IDE2
OjQ5ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gPiBPbiBNb24sIEp1bCAwOSwgMjAx
OCBhdCAwMjozMzoyNlBNICswMDAwLCBBbGV4ZXkgQnJvZGtpbiB3cm90ZToNCj4gPiA+ID4gSW4g
ZmFjdCwgc2luY2UgYWxsb2NfZHIoKSB1c2VzIGttYWxsb2MoKSB0byBhbGxvY2F0ZSB0aGUgZW50
aXJlIHRoaW5nLA0KPiA+ID4gPiBpdCBpcyBpbXBvc3NpYmxlIHRvIGd1YXJhbnRlZSBhIGxhcmdl
ciBhbGlnbm1lbnQgdGhhbiBrbWFsbG9jIGRvZXMuDQo+ID4gPiANCj4gPiA+IFdlbGwgYnV0IDQt
Ynl0ZXMgW3doaWNoIGlzIGNyaXRpY2FsIGZvciBhdG9taWM2NF90XSBzaG91bGQgYmUgbXVjaCBs
ZXNzDQo+ID4gPiB0aGFuIGEgc2FuZSBjYWNoZSBsaW5lIGxlbmd0aCBzbyBhYm92ZSBzaG91bGQg
d29yay4NCj4gPiANCj4gPiBBRkFJQ1QgQVJDSF9LTUFMTE9DX01JTkFMSUdOIGVuZHMgdXAgYmVp
bmcgNCBvbiB4ODZfMzIgKGl0IGRvZXNuJ3QNCj4gPiBkZWZpbmUgQVJDSF9ETUFfTUlOQUxJR04g
YW5kIGRvZXNuJ3Qgc2VlbSB0byBvdGhlcndpc2Ugb3ZlcnJpZGUgdGhlDQo+ID4gdGhpbmcpLg0K
PiA+IA0KPiA+IFNvIHVuY29uZGl0aW9uYWxseSBzZXR0aW5nIHRoZSBhbGlnbm1lbnQgb2YgZGV2
cmVzOjpkYXRhIHRvIDggc2VlbXMNCj4gPiBicm9rZW4uDQo+IA0KPiBXZWxsIGJ1dCB0aGVuIHdo
YXQgb3RoZXIgb3B0aW9ucyBkbyB3ZSBoYXZlIHRvIGZpeCBhIHByb2JsZW0gd2l0aA0KPiBtaXNh
bGlnbmVkIGFjY2VzcyB0byBhdG9taWM2NF90IGluIGRybV9ncHVfc2NoZWR1bGVyPw0KDQpQaW5n
IQ0KDQpTaG91bGQgSSBzZW5kIHY0IHdpdGggQVJDSF9LTUFMTE9DX01JTkFMSUdOIHVzZWQgZm9y
IGFsaWdubWVudA0KaWYgZXhwbGljaXRseSBzZXQgX19hbGlnbmVkX18oOCkgd2lsbCBicmVhayB4
ODZfMzI/DQoNCi1BbGV4ZXkNCg==

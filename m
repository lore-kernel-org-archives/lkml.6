Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42ADC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB1020875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CKXAFbxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB1020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeGIOxo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:53:44 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:51937 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932704AbeGIOxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:53:41 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EAA5110C1ADF;
        Mon,  9 Jul 2018 07:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531148021; bh=aecAG4qod/1Wh7dRZdilaWOAOYbNFp6SFB+5S/ReAfg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=CKXAFbxF7/+4r8pI3QDsnU8vKmcvxbk5tkxbzgj1xdwIBYBOMEykBeL0eej8wUFXJ
         cz2MrhZCqASM1B1+dYUksgSdGCv0Nam53w2Pi3KTVolDdAbK8GSV63Viu+gLZyGwdd
         w4Ooga/18CgtSA2nremBTQItIwGRfercvsgbJkrwwsoNPx8G0b07xhAniA8C8hPe7V
         uMm1w6SJgu2GLgyg3J0TSmdPKsOtGlb7fvbZNpSZCkuDe2f+sRoIQIshmXfHBOzu59
         q0NYFw6mJjqR76zCny8OwukkO8lSx/d9W1tebZ9QZ8/3yVmqJtxxx+8gjR4zXB1xbe
         XaLREsG6Mpysg==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 96A1F3D61;
        Mon,  9 Jul 2018 07:53:40 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 9 Jul 2018 07:53:40 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 9 Jul 2018 16:53:37 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
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
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Thread-Topic: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Thread-Index: AQHUF4swC8s+UKwhqUSMtDZM6j3qZaSGy6yAgAABBQCAAAZHAIAABHmAgAABKoA=
Date:   Mon, 9 Jul 2018 14:53:36 +0000
Message-ID: <4f6e9e8bf60f05872afaed4a1d8e516331e95ea7.camel@synopsys.com>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
         <20180709140717.GR2476@hirez.programming.kicks-ass.net>
         <20180709141056.GR2512@hirez.programming.kicks-ass.net>
         <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
         <20180709144925.GU2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180709144925.GU2476@hirez.programming.kicks-ass.net>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <965FC01BD20DB94FB99BA57AF9B8ADFA@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGV0ZXIsDQoNCk9uIE1vbiwgMjAxOC0wNy0wOSBhdCAxNjo0OSArMDIwMCwgUGV0ZXIgWmlq
bHN0cmEgd3JvdGU6DQo+IE9uIE1vbiwgSnVsIDA5LCAyMDE4IGF0IDAyOjMzOjI2UE0gKzAwMDAs
IEFsZXhleSBCcm9ka2luIHdyb3RlOg0KPiA+ID4gSW4gZmFjdCwgc2luY2UgYWxsb2NfZHIoKSB1
c2VzIGttYWxsb2MoKSB0byBhbGxvY2F0ZSB0aGUgZW50aXJlIHRoaW5nLA0KPiA+ID4gaXQgaXMg
aW1wb3NzaWJsZSB0byBndWFyYW50ZWUgYSBsYXJnZXIgYWxpZ25tZW50IHRoYW4ga21hbGxvYyBk
b2VzLg0KPiA+IA0KPiA+IFdlbGwgYnV0IDQtYnl0ZXMgW3doaWNoIGlzIGNyaXRpY2FsIGZvciBh
dG9taWM2NF90XSBzaG91bGQgYmUgbXVjaCBsZXNzDQo+ID4gdGhhbiBhIHNhbmUgY2FjaGUgbGlu
ZSBsZW5ndGggc28gYWJvdmUgc2hvdWxkIHdvcmsuDQo+IA0KPiBBRkFJQ1QgQVJDSF9LTUFMTE9D
X01JTkFMSUdOIGVuZHMgdXAgYmVpbmcgNCBvbiB4ODZfMzIgKGl0IGRvZXNuJ3QNCj4gZGVmaW5l
IEFSQ0hfRE1BX01JTkFMSUdOIGFuZCBkb2Vzbid0IHNlZW0gdG8gb3RoZXJ3aXNlIG92ZXJyaWRl
IHRoZQ0KPiB0aGluZykuDQo+IA0KPiBTbyB1bmNvbmRpdGlvbmFsbHkgc2V0dGluZyB0aGUgYWxp
Z25tZW50IG9mIGRldnJlczo6ZGF0YSB0byA4IHNlZW1zDQo+IGJyb2tlbi4NCg0KV2VsbCBidXQg
dGhlbiB3aGF0IG90aGVyIG9wdGlvbnMgZG8gd2UgaGF2ZSB0byBmaXggYSBwcm9ibGVtIHdpdGgN
Cm1pc2FsaWduZWQgYWNjZXNzIHRvIGF0b21pYzY0X3QgaW4gZHJtX2dwdV9zY2hlZHVsZXI/DQoN
Ci1BbGV4ZXk=

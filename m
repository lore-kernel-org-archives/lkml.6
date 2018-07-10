Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BD0C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AC4208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OqZd4ne0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="K28f/N+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AC4208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934655AbeGJQri (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:47:38 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24242 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933229AbeGJQrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1531241256; x=1562777256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/3e3fRGpqTanQ9CUQK39oD7OqDSIIilmbCtlppwX1zQ=;
  b=OqZd4ne04LblHPpGxeAcq4Ok9x1JbChvOAsRdJsRn74iySJf/UTpvYz9
   B86pd3ozXEBefbENpl+8Xb91w1o7Gc4oF2sHUkxwn+0rHuBhqj/POpIu6
   s2Qq/E3Qu35LI/3+r3WUTDJPHdfMyqPongGz29soEuBnGzEPIUOuFIi6J
   m3WnWu6ORXLjhEeJayceIopxttAU5dwZQY0AyPHdRh8WuScbhiDG/1nTo
   10eQDwQVYpxsVQTD6Xj1pANe6+h+l4vzre8tOygAe2zPs3JVHiBhnRKej
   fV2L9TxR7bNSc1oEAbEfKupcVJbKNhekuQsgJHU1bNWnMA3ECbXEC6cLe
   w==;
X-IronPort-AV: E=Sophos;i="5.51,335,1526313600"; 
   d="scan'208";a="86664137"
Received: from mail-co1nam04lp0056.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([216.32.181.56])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2018 00:47:35 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3e3fRGpqTanQ9CUQK39oD7OqDSIIilmbCtlppwX1zQ=;
 b=K28f/N+TmFPiZFIJUq4y6yRWOagwNkcUQMooBb/HIOnOBJ1g9UkNBI6xlKLdX9itgaKvYOmQ2ueI9g1X3ZjmQiGnAymQW9WUgRmtGxV6D21ZY8T98Yh1aIVCc3ibRNcZ+IMXaiwGgR3zKm/+ZcfuEh/giGwNb3XOW7W5JdAgJgU=
Received: from MWHPR04MB1198.namprd04.prod.outlook.com (10.173.48.151) by
 MWHPR04MB0305.namprd04.prod.outlook.com (10.169.202.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 10 Jul 2018 16:47:33 +0000
Received: from MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44]) by MWHPR04MB1198.namprd04.prod.outlook.com
 ([fe80::a134:ec95:a6c0:7c44%4]) with mapi id 15.20.0930.022; Tue, 10 Jul 2018
 16:47:33 +0000
From:   Bart Van Assche <Bart.VanAssche@wdc.com>
To:     "mb@lightnvm.io" <mb@lightnvm.io>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "loberman@redhat.com" <loberman@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 0/2] null_blk: zone support
Thread-Topic: [PATCH 0/2] null_blk: zone support
Thread-Index: AQHUFVBFT/qkypCZAUO1k/LTlwEax6SCd5QAgAQSDYCAAJEkAIAAfhCAgAD2KoCAACHDgA==
Date:   Tue, 10 Jul 2018 16:47:32 +0000
Message-ID: <a183979f10fda180176f671702f69efe338f56e7.camel@wdc.com>
References: <20180706173839.28355-1-mb@lightnvm.io>
         <1530899118.31977.1.camel@redhat.com>
         <296d2d14-0bf6-e0a2-84dc-7d6e819625c1@lightnvm.io>
         <4421a151-85d9-52e4-2233-03ed7f17528a@kernel.dk>
         <8d8ae6c620217db92b95b6561345d7bdf7c7cdfa.camel@wdc.com>
         <229911cb-7eb1-1729-46f1-35aba81d98d1@kernel.dk>
In-Reply-To: <229911cb-7eb1-1729-46f1-35aba81d98d1@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com; 
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0305;7:6/Z71hftFtKqOr4QvbFMH4SoQGMWYxbmHDCF/YF7OeuLPlj/aPq2ENksGW58Izm9tYdM6AnUhu6O23R/qE/hHUElISOX63dV5ZMZqEKfuyGw+OkobqeurWc2MecPD5KIsozeae54M4k288eFJV6ou90mHe5tzH+YWa8Dc67/Pyaz2huH4Y24D1hMn5IbB7gbY4seibjV0FJUpOoLybO7J1ZgcJH8RrzJ/9fOmU5t4vIwRZLMtsoEYhHV65bEKaq2;20:QHeZBLrxBjlngY09417yHOdslXC28EV5P50ji33dzpCuZv3guPbv84tO+I5C1S3jk3fMnR8JbkZIgUiNm0ye7Y9Y4Q6k5L9Aowbfw+ykmhkz4I/RM+wbrVRSGDzkDgpfDihzkML6Uzv8kBz5FKcZc1gT9V8mE5MHFnExC7kTe5o=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: d4018a42-c4b4-4770-e817-08d5e684d546
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0305;
x-ms-traffictypediagnostic: MWHPR04MB0305:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0305E33B915EA60FDA07A7BD985B0@MWHPR04MB0305.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0305;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0305;
x-forefront-prvs: 0729050452
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(136003)(39860400002)(189003)(199004)(105586002)(106356001)(93886005)(478600001)(6436002)(2900100001)(6486002)(72206003)(229853002)(6512007)(118296001)(2501003)(5250100002)(97736004)(36756003)(66066001)(3846002)(6116002)(68736007)(8936002)(25786009)(6506007)(5660300001)(2906002)(76176011)(99286004)(11346002)(2616005)(54906003)(446003)(86362001)(486006)(14444005)(2201001)(14454004)(476003)(53546011)(256004)(8676002)(4326008)(81156014)(53936002)(316002)(110136005)(102836004)(7736002)(186003)(26005)(305945005)(81166006)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0305;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: n1Vh7kB74so2+8rNt2/wxwsA1W0UDqysj5oXd9jclCTvjfhJKY9YnromhDw/pn4BskdTuGx9dE9rchEGurWfokbns/wBAMpFVuN2M/fm2ZzfbKrz33nPQxu9KYcsJtyFifU0VaQ9p/JuD7ZCo0tRFgc34Xb3lEQCNyMoD4GBYJIs/5TlCDhwDyxkLtEi0pwCVZg8AspfHLYi21O/CiNJYjlCI0aNGuzdLyLOFJpcFhcF6SnJmD3mok41IuuuRBVekRs6HdDzAZ/2kya18fqh+zAPIw8j1rTnY65oOw/cRuexetEb6jfHraT6cwedw2HLRjpzfliKjzqpYfmi9+KyJaJdD4YAPPo56KGdds4jiN8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE8668679032464B8337C02A8EA8F55B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4018a42-c4b4-4770-e817-08d5e684d546
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2018 16:47:32.8656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0305
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA3LTEwIGF0IDA4OjQ2IC0wNjAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiBP
biA3LzkvMTggNjowNSBQTSwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAx
OC0wNy0wOSBhdCAxMDozNCAtMDYwMCwgSmVucyBBeGJvZSB3cm90ZToNCj4gPiA+IEluIHRoZSBz
cGlyaXQgb2YgbWFraW5nIHNvbWUgcHJvZ3Jlc3Mgb24gdGhpcywgSSBqdXN0IGRvbid0IGxpa2Ug
aG93DQo+ID4gPiBpdCdzIGRvbmUuIEZvciBleGFtcGxlLCBpdCBzaG91bGQgbm90IGJlIG5lY2Vz
c2FyeSB0byBhZGp1c3Qgd2hhdA0KPiA+ID4gY29tZXMgb3V0IG9mIHRoZSBibG9jayBnZW5lcmF0
b3IsIGluc3RlYWQgdGhlIGJsb2NrIGdlbmVyYXRvciBzaG91bGQNCj4gPiA+IGJlIHRvbGQgdG8g
ZG8gd2hhdCB3ZSBuZWVkIG9uIHpiYy4gVGhpcyBpcyBhIGtleSBjb25jZXB0LiBUaGUgd29ya2xv
YWQNCj4gPiA+IHNob3VsZCBiZSBkZWZpbmVkIGFzIHN1Y2ggdGhhdCBpdCB3b3JrcyBmb3Igem9u
ZWQgZGV2aWNlcy4NCj4gPiANCj4gPiBIb3cgd291bGQgeW91IGxpa2UgdG8gc2VlIGJsb2NrIGdl
bmVyYXRpb24gd29yaz8gSSBkb24ndCBzZWUgYW4NCj4gPiBhbHRlcm5hdGl2ZSBmb3IgcmFuZG9t
IEkvTyBvdGhlciBzdGFydGluZyBmcm9tIHRoZSBvdXRwdXQgb2YgYSByYW5kb20NCj4gPiBnZW5l
cmF0b3IgYW5kIHRyYW5zbGF0aW5nIHRoYXQgb3V0cHV0IGludG8gc29tZXRoaW5nIHRoYXQgaXMN
Cj4gPiBhcHByb3ByaWF0ZSBmb3IgYSB6b25lZCBibG9jayBkZXZpY2UuIFJhbmRvbSByZWFkcyBt
dXN0IGhhcHBlbiBiZWxvdw0KPiA+IHRoZSB6b25lIHBvaW50ZXIgaWYgZmlvIGlzIGNvbmZpZ3Vy
ZWQgdG8gcmVhZCBiZWxvdyB0aGUgem9uZSBwb2ludGVyLg0KPiA+IFJhbmRvbSB3cml0ZXMgbXVz
dCBoYXBwZW4gYXQgdGhlIHdyaXRlIHBvaW50ZXIuIFRoZSBvbmx5IHdheSBJIHNlZSB0bw0KPiA+
IGltcGxlbWVudCBzdWNoIGFuIEkvTyBwYXR0ZXJuIGlzIHRvIHN0YXJ0IGZyb20gdGhlIG91dHB1
dCBvZiBhIHJhbmRvbQ0KPiA+IGdlbmVyYXRvciBhbmQgdG8gYWRqdXN0IHRoZSBvdXRwdXQgb2Yg
dGhhdCByYW5kb20gZ2VuZXJhdG9yLiBIb3dldmVyLA0KPiA+IEkgZG9uJ3QgaGF2ZSBhIHN0cm9u
ZyBvcGluaW9uIHdoZXRoZXIgYWRqdXN0aW5nIHRoZSBvdXRwdXQgb2YgYSByYW5kb20NCj4gPiBn
ZW5lcmF0b3Igc2hvdWxkIGhhcHBlbiBieSB0aGUgY2FsbGVyIG9mIGdldF9uZXh0X2J1Zmxlbigp
IG9yIGluc2lkZQ0KPiA+IGdldF9uZXh0X2J1ZmxlbigpLiBPciBpcyB5b3VyIGNvbmNlcm4gcGVy
aGFwcyB0aGF0IHRoZSBjdXJyZW50DQo+ID4gYXBwcm9hY2ggaW50ZXJmZXJlcyB3aXRoIGZpbyBq
b2Igb3B0aW9ucyBsaWtlIGJzX3VuYWxpZ25lZD8NCj4gDQo+IFRoZSBtYWluIGlzc3VlIEkgaGF2
ZSB3aXRoIHRoYXQgYXBwcm9hY2ggaXMgdGhhdCB0aGUgY29yZSBvZiBmaW8gaXMNCj4gZ2VuZXJh
dGluZyB0aGUgSU8gcGF0dGVybnMsIGFuZCB0aGVuIHlvdSBhcmUganVzdCBjaGFuZ2luZyB0aGVt
IGFzIHlvdQ0KPiBzZWUgZml0LiBUaGlzIG1lYW5zIHRoYXQgdGhlIHdvcmtsb2FkIGRlZmluaXRp
b24gYW5kIHRoZSByZXN1bHRpbmcgSU8NCj4gb3BlcmF0aW9ucyBhcmUgbm8gbG9uZ2VyIG1hdGNo
ZWQgdXAsIHNpbmNlIHRoZXkgbm93IGFsc28gZGVwZW5kIG9uIHdoYXQNCj4geW91IGFyZSBydW5u
aW5nIG9uLiBJZiBJIHRha2Ugb25lIHdvcmtsb2FkIGFuZCBydW4gaXQgb24gYSB6b25lZCBkcml2
ZSwNCj4gYW5kIHRoZW4gcnVuIGl0IG9uIGEgbm9uLXpvbmVkIGRyaXZlLCBJIGNhbid0IGNvbXBh
cmUgdGhlIHJlc3VsdHMgYXQNCj4gYWxsLiBUaGlzIGlzIGEgc2hvd3N0b3BwZXIuDQo+IA0KPiBU
aGVyZSBzaG91bGQgYmUgbm8gYWRqdXN0aW5nIG9mIHRoZSBvdXRwdXQsIHJhdGhlciBpdCBzaG91
bGQgYmUgcG9zc2libGUNCj4gdG8gd3JpdGUgem9uZWQgZnJpZW5kbHkgam9iIGRlZmluaXRpb25z
LiBJdCBzaG91bGQgYmUgcG9zc2libGUgdG8gcnVuDQo+IHRoZSBzYW1lIGpvYiBvbiBhIG5vbi16
b25lZCBkcml2ZSwgYW5kIHZpY2UgdmVyc2EsIGFuZCB0aGUgcmVzdWx0aW5nIElPDQo+IHBhdHRl
cm5zIG11c3QgYmUgdGhlIHNhbWUuDQo+IA0KPiBGaW8gYWxyZWFkeSBoYXMgc29tZSBub3Rpb24g
b2Ygem9uZXMuIE1heWJlIHRoYXQgY291bGQgYmUgZXh0ZW5kZWQgdG8NCj4gaGFyZCB6b25lcywg
YW5kIHNvbWUgY29udHJvbCBvZiBvcGVuIHpvbmVzLCBhbmQgcGF0dGVybnMgd2l0aGluIHRob3Nl
DQo+IHpvbmVzPw0KDQpIZWxsbyBKZW5zLA0KDQpIb3cgYWJvdXQgYWRkaW5nIGEgam9iIG9wdGlv
biB0aGF0IG1ha2VzIGl0IHBvc3NpYmxlIHRvIHVzZSB0aGUgem9uZWQNCmJsb2NrIGRldmljZSAo
WkJEKSBJL08gcGF0dGVybiBvbiBub24tWkJEIGRldmljZXMsIHJlcXVpcmluZyB0aGF0IHRoZQ0K
em9uZSBzaXplIGlzIHNldCBleHBsaWNpdGx5IGZvciBub24tWkJEIGRldmljZXMgYW5kIG1haW50
YWluaW5nIGEgd3JpdGUNCnBvaW50ZXIgbm90IG9ubHkgd2hlbiBwZXJmb3JtaW5nIEkvTyB0byBh
IFpCRCBkZXZpY2UgYnV0IGFsc28gaWYgYQ0KWkJELXN0eWxlIEkvTyBwYXR0ZXJuIGlzIGFwcGxp
ZWQgdG8gYSBub24tWkJEIGRpc2s/IFRoaXMgc2hvdWxkIGFsbG93IHRvDQphcHBseSBleGFjdGx5
IHRoZSBzYW1lIHdvcmtsb2FkIHRvIGEgbm9uLVpCRCBkaXNrIGFzIHRvIGEgWkJEIGRpc2suDQoN
CldoYXQgSSBkZXJpdmVkIGZyb20gdGhlIGZpbyBzb3VyY2UgY29kZSBpcyBhcyBmb2xsb3dzIChw
bGVhc2UgY29ycmVjdCBtZQ0KaWYgSSBnb3QgYW55dGhpbmcgd3JvbmcpOg0KKiBUaGUgcHVycG9z
ZSBvZiB0aGUgem9uZXNpemUsIHpvbmVyYW5nZSBhbmQgem9uZXNraXAgam9iIG9wdGlvbnMgaXMg
dG8NCiAgbGltaXQgdGhlIEkvTyByYW5nZSB0byBhIHNpbmdsZSB6b25lIHdpdGggc2l6ZSAiem9u
ZXNpemUiLiBUaGUgSS9PDQogIHBhdHRlcm4gZm9yIHpvbmVkIGJsb2NrIGRldmljZXMgaXMgZGlm
ZmVyZW50OiBJL08gaGFwcGVucyBpbiBtdWx0aXBsZQ0KICB6b25lcyBzaW11bHRhbmVvdXNseS4g
VGhlIG51bWJlciBvZiB6b25lcyB0byB3aGljaCBJL08gaGFwcGVucyBpcw0KICBjYWxsZWQgdGhl
IG51bWJlciBvZiBvcGVuIHpvbmVzLg0KKiBUaGUgcHVycG9zZSBvZiB0aGUgcmFuZG9tX2Rpc3Ry
aWJ1dGlvbj16b25lZHtfYWJzfSBqb2Igb3B0aW9uIGlzIHRvDQogIGFsbG93IHRoZSB1c2VyIHRv
IHNrZXcgYSB1bmlmb3JtIHJhbmRvbSBkaXN0cmlidXRpb24uIFRoaXMgaXMgYW5vdGhlcg0KICB3
b3JrbG9hZCBwYXR0ZXJuIHRoYW4gdGhlIHR5cGljYWwgcGF0dGVybiBmb3IgWkJEIGRyaXZlcy4N
Cg0KVGhhbmtzLA0KDQpCYXJ0Lg0KDQoNCg0KDQoNCg==

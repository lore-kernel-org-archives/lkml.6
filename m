Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28C7C32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BFA20831
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="yMY9a1IL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BFA20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbeKCKBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 06:01:49 -0400
Received: from mail-he1eur01on0058.outbound.protection.outlook.com ([104.47.0.58]:15328
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbeKCKBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 06:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuwsjHWMIBABfCtajKbfTWoHuc42mLF2V+JPCRBH5zA=;
 b=yMY9a1ILJIs+4rIc1b56y5H1OEubupencYHk5VvsQo7yqa2+2Ul3k0PX9Fmq9RS3qRsNBkSo6Z4gaZ9CRXFJeCwEHO+iJ6zYYRPdpPzLaxqIUAvGw4fSbm6ftGDNk2m7/ZnOVWYAobDBuiPbKF7W2A9w/R80JAxfeX+VM0fj3f4=
Received: from DB6PR0502MB2901.eurprd05.prod.outlook.com (10.172.249.140) by
 DB6PR0502MB2901.eurprd05.prod.outlook.com (10.172.249.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Sat, 3 Nov 2018 00:52:12 +0000
Received: from DB6PR0502MB2901.eurprd05.prod.outlook.com
 ([fe80::3c1f:a6d8:45c6:5d5]) by DB6PR0502MB2901.eurprd05.prod.outlook.com
 ([fe80::3c1f:a6d8:45c6:5d5%5]) with mapi id 15.20.1294.027; Sat, 3 Nov 2018
 00:52:12 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "arnd@arndb.de" <arnd@arndb.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moshe Shemesh <moshe@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Boris Pismenny <borisp@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "leon@kernel.org" <leon@kernel.org>,
        Kamal Heib <kamalh@mellanox.com>
Subject: Re: [PATCH] net/mlx5e: fix high stack usage
Thread-Topic: [PATCH] net/mlx5e: fix high stack usage
Thread-Index: AQHUcsFk3o0flMyDYkGmMaSNi/5NYKU8+hsAgAAJXYCAAAeNAIAAAoKAgAAr3IA=
Date:   Sat, 3 Nov 2018 00:52:12 +0000
Message-ID: <7d1bb1476459a16343fa0c0846d9181b667ad002.camel@mellanox.com>
References: <20181102153316.1492515-1-arnd@arndb.de>
         <9f214f12ec89020ceb14c1aec25b3a0d968507aa.camel@mellanox.com>
         <2727f37b-1742-5532-317e-3be8a984266b@gmail.com>
         <4ebfc3aeb5335a1f671602f9a906f948c39a30da.camel@mellanox.com>
         <CAK8P3a0ybuiu_dBfUDfMYUtKZ=yGdB7An0_wx_ZGhnS5rrD3_w@mail.gmail.com>
In-Reply-To: <CAK8P3a0ybuiu_dBfUDfMYUtKZ=yGdB7An0_wx_ZGhnS5rrD3_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [73.15.39.150]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0502MB2901;6:eM/A8iMXdtPMnanA/vMWEtbSf/En51WdpaY5chbJVK3TZR2YoR3+/2+G9yFiLMG21BHOLD2pU5F6nsd6hwxMcpypLvwpT3VxBa5xDKRgCg5dLfUZpxLFt2mdVzhEHVAuu8BLVqtFnDHRMvWnysdh+AZNmdz3uZ7RxS+S+X2aTYwNEVhDaea2e8qG+XPWITdoIAnYbqxZHFYmXBkZJ6Rlov9J6O6UOIYtu1BOsnv8rjfV/8SsxJ53zgym2nsFvoHNPL/ATQDSrocwkQaHQ7S77Pr/6jfsLbnpoiTM5HnvijFGLiXTthBrGpBc69eImk5bgFd6e5IRZdfj+TblEIeKKudYRXqkzdmNaqvkCvRDzY+OBXK2tYTrtih/lX4rrtoNK7w5Av3CgBSthLW/yjgsdtCj+6Qw3zh+Dc6HCKaOKgfmOkrE1z2Ocb9a9zvEyUA/GCxZTu6/kRqLTK3Dv34KAw==;5:JtgsHOxokr3w1RQrM/WfTVACVX1Ay5qeMPeHHyfh/l4sGBQDwc/603r7OWU0H5O7by2KR9xU2+0C2sLqokPo3bGBb7hTaSP9cGP5A7FqnFCIsCMqWKBl849y8Uv8ASMVUYufQKGAO9H2D+10uY/XPPaLYoyDf5++/BM0VqvztMQ=;7:17EsgKgH5PfHqrs2jvfSXPB1ZMvRBRykCWy5K3s/wbpOw7mnz4MVQSl2mmxxnXtBalxXzdgXsid0CUEZ89chK96ixo7+C7DRFL5rU42OlcuKBFA1CZWjIdR4kXDzyd7N2povFiiciN8aIhArWqoSkg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 868c8ecd-145b-4ec5-5bf7-08d641269793
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB6PR0502MB2901;
x-ms-traffictypediagnostic: DB6PR0502MB2901:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-microsoft-antispam-prvs: <DB6PR0502MB2901FBDDCE86FDBA2D270677BEC80@DB6PR0502MB2901.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB6PR0502MB2901;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0502MB2901;
x-forefront-prvs: 08457955C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(366004)(376002)(189003)(199004)(2351001)(6916009)(25786009)(6512007)(39060400002)(4326008)(6436002)(6486002)(5640700003)(2906002)(5660300001)(6246003)(36756003)(107886003)(229853002)(76176011)(7736002)(102836004)(53546011)(26005)(6506007)(105586002)(2900100001)(99286004)(53936002)(54906003)(71190400001)(71200400001)(316002)(106356001)(118296001)(66066001)(93886005)(478600001)(14454004)(8936002)(3846002)(81156014)(6116002)(1730700003)(97736004)(50226002)(68736007)(8676002)(2501003)(81166006)(486006)(186003)(305945005)(86362001)(14444005)(446003)(2616005)(476003)(11346002)(256004)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0502MB2901;H:DB6PR0502MB2901.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qnUmBe8kkv0oA5pI6fXONry5wXvJobMPkTH67xj21KrPT5yETn6MCv2m6bTGVP0UUvTeNZFKDhvSlY5uZBWPBRT8yi8qtfK3ZTK6tgrU4Y2JCA/Hz0bMXIkAjy4SGtuVIeKLNrsu8c4kHWbEoREeQTAPxUA/qFsAiU5jIA4qbuFIOYGog3nODa+BqMCq36pitSdXcjyvCv/qwr6RDJxhwP1h4XDFZFxpwFVhWqO+B/pVWDr8plW+VTGdTeBVaNqpCp3zqNmLHjGTcRzQYGu0veulKrDORjXSfirebsZiD/BASRK+NQR8jK+sE6F2oE/fLQyaUnZHhzjnZk/xnx2knQlQFo0nGy3ojRM5cIUJDiY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BF94FB26767EF4FAE3024555BC0A094@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868c8ecd-145b-4ec5-5bf7-08d641269793
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2018 00:52:12.4811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0502MB2901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTExLTAyIGF0IDIzOjE1ICswMTAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0K
PiBPbiAxMS8yLzE4LCBTYWVlZCBNYWhhbWVlZCA8c2FlZWRtQG1lbGxhbm94LmNvbT4gd3JvdGU6
DQo+ID4gT24gRnJpLCAyMDE4LTExLTAyIGF0IDE0OjM5IC0wNzAwLCBFcmljIER1bWF6ZXQgd3Jv
dGU6DQo+ID4gPiANCj4gPiA+IE9uIDExLzAyLzIwMTggMDI6MDUgUE0sIFNhZWVkIE1haGFtZWVk
IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IHRlbXAgd2lsbCBiZSBtZW0gY29waWVkIHRvIHByaXYt
PnN0YXRzLnN3IGF0IHRoZSBlbmQsDQo+ID4gPiA+IG1lbWNweSgmcHJpdi0+c3RhdHMuc3csICZz
LCBzaXplb2YocykpOw0KPiA+ID4gPiANCj4gPiA+ID4gb25lIG90aGVyIHdheSB0byBzb2x2ZSB0
aGlzIGFzIHN1Z2dlc3RlZCBieSBBbmRyZXcsIGlzIHRvIGdldA0KPiA+ID4gPiByaWQNCj4gPiA+
ID4gb2YNCj4gPiA+ID4gdGhlIHRlbXAgdmFyIGFuZCBtYWtlIGl0IHBvaW50IGRpcmVjdGx5IHRv
IHByaXYtPnN0YXRzLnN3DQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBXaGF0IGFib3V0IGNvbmN1
cnJlbmN5ID8NCj4gPiA+IA0KPiA+ID4gVGhpcyB0ZW1wIHZhcmlhYmxlIGlzIHRoZXJlIHRvIG1h
a2Ugc3VyZSBjb25jdXJyZW50IHJlYWRlcnMgb2YNCj4gPiA+IHN0YXRzDQo+ID4gPiBtaWdodA0K
PiA+ID4gbm90IHNlZSBtYW5nbGUgZGF0YSAoYmVjYXVzZSBhbm90aGVyICdyZWFkZXInIGp1c3Qg
ZGlkIGEgbWVtc2V0KCkNCj4gPiA+IGFuZA0KPiA+ID4gaXMgZG9pbmcgdGhlIGZvbGRpbmcpDQo+
ID4gPiANCj4gPiA+IA0KPiA+ID4gbWx4NWVfZ2V0X3N0YXRzKCkgY2FuIGRlZmluaXRlbHkgYmUg
cnVuIGF0IHRoZSBzYW1lIHRpbWUgYnkNCj4gPiA+IG11bHRpcGxlDQo+ID4gPiB0aHJlYWRzLg0K
PiA+ID4gDQo+ID4gDQo+ID4gaG1tLCB5b3UgYXJlIHJpZ2h0LCBpIHdhcyB0aGlua2luZyB0aGF0
IG1seDVlX2dldF9TdGF0cyB3aWxsDQo+ID4gdHJpZ2dlciBhDQo+ID4gd29yayB0byB1cGRhdGUg
c3RhdHMgYW5kIGdyYWIgdGhlIHN0YXRlX2xvY2ssIGJ1dCBmb3Igc3cgc3RhdHMgdGhpcw0KPiA+
IGlzDQo+ID4gbm90IHRoZSBjYXNlIGl0IGlzIGRvbmUgaW4gcGxhY2UuDQo+ID4gDQo+ID4gQlRX
IG1lbWNweSBpdHNlbGYgaXMgbm90IHRocmVhZCBzYWZlLg0KPiANCj4gQmVmb3JlIGNvbW1pdCA2
YzYzZWZlNGNmYWIgKCJuZXQvbWx4NWU6IFJlbW92ZSByZWR1bmRhbnQNCj4gYWN0aXZlX2NoYW5u
ZWxzDQo+IGluZGljYXRpb24iKSwgdGhlcmUgd2FzIGEgcmVhZF9sb2NrKCkgaW4gdGhlIGZ1bmN0
aW9uIGFwcGFyZW50bHkNCj4gaW50ZW5kZWQgdG8NCj4gbWFkZSBpdCB0aHJlYWQgc2FmZS4gVGhp
cyBnb3QgcmVtb3ZlZCB3aXRoIHRoZSBjb21tZW50DQo+IA0KPiBjb21taXQgNmM2M2VmZTRjZmFi
ZjIzMGE4ZWQ0YjFkODgwMjQ5ODc1ZmZkYWMxMw0KPiBBdXRob3I6IEVyYW4gQmVuIEVsaXNoYSA8
ZXJhbmJlQG1lbGxhbm94LmNvbT4NCj4gRGF0ZTogICBUdWUgTWF5IDI5IDExOjA2OjMxIDIwMTgg
KzAzMDANCj4gDQo+ICAgICBuZXQvbWx4NWU6IFJlbW92ZSByZWR1bmRhbnQgYWN0aXZlX2NoYW5u
ZWxzIGluZGljYXRpb24NCj4gDQo+ICAgICBOb3csIHdoZW4gYWxsIGNoYW5uZWxzIHN0YXRzIGFy
ZSBzYXZlZCByZWdhcmRsZXNzIG9mIHRoZQ0KPiBjaGFubmVsJ3Mgc3RhdGUNCj4gICAgIHtvcGVu
LCBjbG9zZWR9LCB3ZSBjYW4gc2FmZWx5IHJlbW92ZSB0aGlzIGluZGljYXRpb24gYW5kIHRoZQ0K
PiBzdGF0cyBzcGluDQo+ICAgICBsb2NrIHdoaWNoIHByb3RlY3RzIGl0Lg0KPiANCj4gICAgIEZp
eGVzOiA3NmMzODEwYmFkZTMgKCJuZXQvbWx4NWU6IEF2b2lkIHJlc2V0IG5ldGRldiBzdGF0cyBv
bg0KPiBjb25maWd1cmF0aW9uIGNoYW5nZXMiKQ0KPiANCj4gSSBkb24ndCByZWFsbHkgdW5kZXJz
dGFuZCB0aGUgcmVhc29uaW5nLCBidXQgbWF5YmUgd2UgY2FuIHJlbW92ZQ0KPiB0aGUgbWVtY3B5
KCkgaWYgdGhlIGNvZGUgaXMgdGhyZWFkIHNhZmUsIG9yIHdlIG5lZWQgdGhlIGxvY2sgYmFjayBp
Zg0KPiBpdCdzIG5vdC4NCj4gDQoNCnRoaXMgbG9jayB3YXMgbmVlZGVkIGZvciBhIHdob2xlIGRp
ZmZlcmVudCBwdXJwb3NlLCBpdCB3YXNuJ3QgbWVhbnQgdG8NCnN5bmNocm9uaXplIGJldHdlZW4g
dHdvIHJlYWRlciB0aHJlYWRzLCBpdCB3YXMgbWVhbnQgdG8gc3luY2hyb25pemUNCmJldHdlZW4g
ZHJpdmVyIHJlc3RhcnRzIGFuZCB0aGUgcmVhZGVyIGZvciBsb29wIHdoaWNoIHJhbiBvdmVyIHRo
ZSBvcGVuDQpjaGFubmVscywgd2hpbGUgdGhleSBjb3VsZCBiZSBnb2luZyB0aHJvdWdoIGEgZGVz
dHJ1Y3Rpb24gcHJvY2Vzcy4NCg0KSSB0aGluayBhbGwgd2UgbmVlZCBpcyB0byBtYWludGFpbiB0
d28gcHJpdi0+c3RhdHMuc3cgY29waWVzIGFuZCB1c2UNCnRoZW0gYXMgdGVtcCBmb3IgZWFjaCBy
ZWFkZXIgdGhyZWFkLCB3aGVuIGNhbiBvbmx5IGhhdmUgdHdvIGNvbmN1cnJlbnQNCnJlYWRlcnMg
KG1seDVlX2V0aHRvb2xfZ2V0X2V0aHRvb2xfc3RhdHMgYW5kIG5kb19nZXRfc3RhdHM2NCkgLi4g
DQoNCj4gICAgICAgICAgQXJuZA0K

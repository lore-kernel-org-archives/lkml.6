Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F02BC64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDF0206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eiOGI5s+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDF0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeI3JU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:20:28 -0400
Received: from mail-eopbgr40059.outbound.protection.outlook.com ([40.107.4.59]:46981
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727750AbeI3JU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cc3flLZn46W3gUngALCkapLLiyoqsMpPbxO1mZ6zlw=;
 b=eiOGI5s+7LxweuxiLzdTlTOEtuWyryirEjCXAN1+Ey2DtaPK/3BQh4DWXNaJAy0TilrOCv2kNhe10qz549OKz+dijsjnneTGmloEuEUFBlLBM2aYvx6VdUfEZrNRYHku4WMFtb6f4OqOoP+rEQp4ZknK0PeE+jxoD+SieTEsR+8=
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com (52.135.167.33) by
 AM6PR04MB4008.eurprd04.prod.outlook.com (52.135.160.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Sun, 30 Sep 2018 02:49:21 +0000
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe]) by AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe%2]) with mapi id 15.20.1143.022; Sun, 30 Sep 2018
 02:49:21 +0000
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     Esben Haabendal <esben.haabendal@gmail.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>
Subject: RE: [PATCH 2/2] spi: spi-fsl-dspi: Fix support for XSPI transport
 mode
Thread-Topic: [PATCH 2/2] spi: spi-fsl-dspi: Fix support for XSPI transport
 mode
Thread-Index: AQHUUXmWfWxjYgYDCEmBQwAxJp+eHaUHZjpfgADBOyA=
Date:   Sun, 30 Sep 2018 02:49:20 +0000
Message-ID: <AM6PR04MB43575CFD4D00B8EAC1F52BD097EE0@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180921070628.35153-2-chuanhua.han@nxp.com> <87y3bkcpym.fsf@gmail.com>
In-Reply-To: <87y3bkcpym.fsf@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4008;6:tYprTTRZAo7+cxUqdhGnEko8BdpBOp7UzkHMHnKjotWBdB9611sdXvrPiNEQwgmV+YyNYfUBtMkLQlXLPwnCP2FCrLnk/4QbLN6h3ehd13ZGWH2WJoslhUMmLudbEjPdpp9KUhsGsqAwFsswHVqV3ZhlRVzHCvb7gEg9pj6TRlmXUNM+VUVj9P2pNJRiAwHQhnipOrgKX9qbXz/q0QEsx7eIuXOYovzNidVMm4IFoBlUpdRNTriYq3bhJSAm/E81zNFnZv3ZIHZMOm2UdatCNwONChSRrmxZPdaMjnOyR16LPWfqkl0Qz4QnusyRAld0dov8113Oj9XnFMv/j/Sih9aWTMEcOBvNnQVDbLo/hYOJ7UaUVDTyas95PXhuZC2PSq4yvuhuNnE8uveiK7hVbsLSunAaty+yDAZGf4jnwi7hL1Pk/ea+46zt+wcdK97I6I+t7T30+XQ0TusQDKFGVQ==;5:aGljHNGbixyFcEVhoSodQEiUsE9+Ys8dkFiTRoZPgqq8oKGgy2E2Tx2+eZXj1xBQdWT7B84dlATW/DqLax9cfkGgMaNVEXZ5R6cY9RkD5jV4ziA23YLq3ysLlwMXo8xBJe39nI9yxzvIp4gb/TPiX/6a+ODiTtx4Xe1hArVLndY=;7:o3hG3bV+Ubxzkc1mzAgbBM8id3s9JL6RPv1lrA4zQQjhHM1RoWvkM1SUKhgo3ULHNxRbS5COmSeWGo9WDKAtYHKh2WEQ6YH16xZ1Ppyt2s6UmI8uFTJzi84T2lX/OWmbJjxH2ZmNyTEx97FO+gXYayJ7l9bqvPg0jLhkvTa3i9mHEPd4Yv4NYv4KplJMMW7K+jxfm/jbUKkqabQrgY2596V1nqA/7UblS0jW0TU2tvKPVcdWrSjAnQeGFSIjoZKt
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1b684b73-7dc7-47da-16ee-08d6267f52bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4008;
x-ms-traffictypediagnostic: AM6PR04MB4008:
x-microsoft-antispam-prvs: <AM6PR04MB40082ACAA07A3CB8D05917FB97EE0@AM6PR04MB4008.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051);SRVR:AM6PR04MB4008;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4008;
x-forefront-prvs: 08118EFC2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(13464003)(189003)(199004)(68736007)(256004)(6916009)(14444005)(71200400001)(71190400001)(106356001)(2906002)(105586002)(8676002)(81156014)(81166006)(34290500001)(39060400002)(4326008)(14454004)(8936002)(3846002)(97736004)(2900100001)(25786009)(74316002)(86362001)(6246003)(478600001)(5250100002)(5660300001)(6116002)(55016002)(316002)(305945005)(102836004)(54906003)(9686003)(6506007)(11346002)(446003)(7736002)(66066001)(53546011)(186003)(53936002)(26005)(7696005)(229853002)(44832011)(76176011)(345774005)(6436002)(476003)(486006)(99286004)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4008;H:AM6PR04MB4357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: P0mzGEtmqZy6ebYDZFZjHRPfoZsMr63NP4O33RxyBisjp5JnU/HGsZjFEOObuwz3DkKdKX/1R/F2eUMHGt2Cd5JN+yjCjX18e7rQwnBxtS5tURK3OLwVcuBaKW5XXNUc7vvbXzDdv4BDZyD92IjsKxgxEY49VtCn1n5RzqAztqxkqtL/inBZEJCmKa6YPahafJ0UChK2CTcK+IyL3+eQiRomKqp+nrxBjAhUOWV/Y+28c+BK3og7pSoMWc0gZiqPMTDYMr7hSkLycSlORlj+TLrFSNW/3qNhSUf1556pkekRj7mW5TXPiZf4MQkRcVV2EsFKLoV8KcO18SEszgy88/S95BlS302p8NarFacKsb0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b684b73-7dc7-47da-16ee-08d6267f52bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2018 02:49:20.9333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXNiZW4gSGFhYmVuZGFs
IDxlc2JlbmhhYWJlbmRhbEBnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBFc2Jlbg0KPiBIYWFiZW5k
YWwNCj4gU2VudDogMjAxOMTqOdTCMjnI1SAyMjo1Ng0KPiBUbzogQ2h1YW5odWEgSGFuIDxjaHVh
bmh1YS5oYW5AbnhwLmNvbT4NCj4gQ2M6IGJyb29uaWVAa2VybmVsLm9yZzsgbGludXgtc3BpQHZn
ZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgYm9yaXMuYnJl
emlsbG9uQGJvb3RsaW4uY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBzcGk6IHNwaS1m
c2wtZHNwaTogRml4IHN1cHBvcnQgZm9yIFhTUEkgdHJhbnNwb3J0IG1vZGUNCj4gDQo+IENodWFu
aHVhIEhhbiA8Y2h1YW5odWEuaGFuQG54cC5jb20+IHdyaXRlczoNCj4gDQo+ID4gVGhpcyBwYXRj
aCBmaXhlcyB0aGUgcHJvYmxlbSB0aGF0IHRoZSBYU1BJIG1vZGUgb2YgdGhlIGRzcGkgY29udHJv
bGxlcg0KPiA+IGNhbm5vdCB0cmFuc2ZlciBkYXRhIHByb3Blcmx5Lg0KPiA+IEluIFhTUEkgbW9k
ZSwgY21kX2ZpZm8gaXMgd3JpdHRlbiBiZWZvcmUgdHhfZmlmbywgd2hpY2ggdHJhbnNmb3JtcyB0
aGUNCj4gPiBieXRlIG9yZGVyIG9mIHNlbmRpbmcgYW5kIHJlY2VpdmluZyBkYXRhLg0KPiANCj4g
RGlkIHlvdSBmaW5kIGRvY3VtZW50YXRpb24gb24gcHJvcGVyIG9yZGVyaW5nIG9mIHdyaXRlcyB0
byByZWxhdGVkIFRYIEZJRk8NCj4gYW5kIENNRCBGSUZPIGVudHJpZXM/DQo+IA0KPiBJIGhhdmUg
ZmFpbGVkIHRvIGZpbmQgc3VjaCBpbmZvcm1hdGlvbiwgYW5kIHRodXMgb3B0ZWQgZm9yIHdoYXQg
SSBiZWxpZXZlZCB3b3VsZA0KPiBiZSB0aGUgc2FmZSBhcHByb2FjaCwgd3JpdGluZyB0byBUWCBG
SUZPIGZpcnN0LCBzbyB0aGF0IHdoZW4gQ01EIEZJRk8gaXMNCj4gd3JpdHRlbiwgaXQgd2lsbCBh
bHJlYWR5IGhhdmUgZGF0YSBpbiBwbGFjZS4gIEFuZCBpdCBzZWVtcyB0byB3b3JrLg0KPiANCj4g
QnV0LCBJIG5vdyBzZWUgdGhhdCBTUEl4X1NSW1RGSVdGXSBoaW50cyB0aGF0IGl0IHNob3VsZCBi
ZSBkb25lIHRoZSBvdGhlciB3YXkNCj4gYXJvdW5kLg0KPiANCj4gICAgIFRyYW5taXQgRklGTyBJ
bnZhbGlkIFdyaXRlIEZsYWcgLSBJbmRpY2F0ZXMgRGF0YSBXcml0ZSBvbiBUWCBGSUZPDQo+ICAg
ICB3aGlsZSBDTUQgRklGTyBpcyBlbXB0eS4gV2l0aG91dCBhIENvbW1hbmQsIHRoZSBEYXRhIGVu
dHJpZXMgcHJlc2VudA0KPiAgICAgaW4gVFhGSUZPIGFyZSBpbnZhbGlkLg0KPiANCj4gQnV0IEkg
ZmFpbCB0byBzZWUgaG93IHRoYXQgc2hvdWxkIGJlIHJlbGF0ZWQgdG8gYnl0ZSBvcmRlcmluZy4N
Cj4gDQo+IFNvIEkgYmVsaWV2ZSB0aGlzIHBhdGNoIGlzIGRvaW5nIHR3byB0aGluZ3MuDQo+IA0K
PiAxLiBDaGFuZ2luZyB3cml0ZSBvcmRlcmluZyBvZiBUWCBGSUZPIGFuZCBDTUQgRklGTy4NCj4g
Mi4gSGFuZGxpbmcgYnl0ZSBvcmRlcmluZyBiYXNlZCBvbiBTUEl4X0NUQVJuW0xTQkZFXSBmbGFn
Lg0KPiANCj4gSXQgd291bGQgYmUgbmljZSBpZiB3ZSBjb3VsZCBnZXQgY2xhcmlmaWNhdGlvbiBm
cm9tIE5YUCBvbiB3aGF0IGlzIHRoZSByaWdodCB3YXkNCj4gdG8gZG8gdGhlIFRYIEZJRk8gYW5k
IENNRCBGSUZPIHdyaXRlIG9yZGVyaW5nLg0KPiANCj4gQnV0IGFzIGZvciB0aGUgYnl0ZSBvcmRl
cmluZyBjaGFuZ2VzLCBJIGRvbid0IHRoaW5rIGl0IGxvb2tzIHdyaXRlLiAgVGhlIG1lYW5pbmcN
Cj4gb2YgU1BJeF9DVEFSbltMU0JGRV0gaXMgYWNjb3JkaW5nIHRvIHRoZSBkb2N1bWVudGFpdG9u
IHRoZSBiaXQgb3JkZXJpbmcgb24NCj4gdGhlIHdpcmUsIGFuZCBzaG91bGQgbm90IGJlIHJlbGF0
ZWQgdG8gcmVnaXN0ZXIgYnl0ZSBvcmRlcmluZy4NCj4gDQo+IFlvdSBzaG91bGQgcHJvYmFibHkg
c3BsaXQgdGhpcyBwYXRjaCBpbiB0d28sIHNvIHRoZXkgY2FuIGJlIHJldmlld2VkIGFuZA0KPiBt
ZXJnZWQgaW5kZXBlbmRlbnRseS4NCj4gDQo+IC9Fc2Jlbg0KSGksIEVzYmVuDQpGaXJzdCBvZiBh
bGwsIHRoYW5rIHlvdSBmb3IgeW91ciB2YWx1YWJsZSBhZHZpY2UuIEknbSBnb2luZyB0byBkbyB0
d28gdGhpbmdzOg0KMS4gRGl2aWRlIHRoaXMgcGF0Y2ggaW50byBtdWx0aXBsZSBwYXRjaGVzLg0K
Mi4gVmVyaWZ5IChpZiB5b3UgY2FuKSBmcm9tIHRoZSByZWxldmFudCBOWFAgZG9jdW1lbnRhdGlv
bi4NCg0KU2Vjb25kLCBsZXQgbWUgbWVudGlvbiB0aGUgaXNzdWVzIEkgZm91bmQgb24gZml4aW5n
IGZzbF9kc3BpJ3MgWFNQSSBwYXR0ZXJuIG5vdCB3b3JraW5nOg0KMS4gV2hlbiBJIGV4ZWN1dGVk
IFRYIEZJRk8gZmlyc3QgYW5kIHRoZW4gQ01EIEZJRk8gZm9yIFhTUEkgdHJhbnNtaXNzaW9uLCBJ
IGZvdW5kIHRoYXQgU1BJeF9TUltURklXRl09MSAoSW52YWxpZCBEYXRhIHByZXNlbnQgaW4gVFgg
RklGTyBzaW5jZSBDTUQgRklGTyBpcyBlbXB0eSkuDQogVGhpcyBpcyB0aGUgdGltZSB3aGVuIG5v
IERhdGEgY2FuIGJlIHJlYWQgb3Igd3JpdHRlbiAoYWxsIHRoZSBEYXRhIG9idGFpbmVkIGlzIGVx
dWFsIHRvIDApLg0KMi4gV2hlbiBJIHJlYWQgYW5kIHdyaXRlIGRhdGEgd2l0aG91dCBjb252ZXJ0
aW5nIGRhdGEgYnl0ZSBvcmRlciwgYW5kIHJlYWQgYW5kIHdyaXRlIGRhdGEgZGlyZWN0bHksDQog
SSB0ZXN0ZWQgc3BpLWZsYXNoIGNvbm5lY3RlZCBieSBmc2xfZHNwaSBjb250cm9sbGVyLCBhbmQg
Zm91bmQgdGhhdCBkYXRhIGJ5dGUgb3JkZXIgd2FzIHJldmVyc2VkIHdpdGggdGhlIGNvcnJlY3Qg
Ynl0ZSBvcmRlci4gDQpXaGVuIEkgY2hhbmdlZCB0aGUgYnl0ZSBvcmRlciBhY2NvcmRpbmcgdG8g
dGhlIFNQSXhfQ1RBUm5bTFNCRkVdIGZsYWcsIHRoZSBjb3JyZWN0IGRhdGEgd2FzIG9idGFpbmVk
IChub3QgZXhwbGFpbmVkIGluIHRoaXMgZGF0YSBtYW51YWwpLg0KMy4gSW4gdGhlIGRzcGlfcHVz
aF9yeCBmdW5jdGlvbiwgaWYgeW91IGFkZCB5b3VyICJyeGRhdGEgJj0gKDEgPDwgZHNwaS0+Yml0
c19wZXJfd29yZCkgLTEiIHN0YXRlbWVudCwgdGhlIHJ4ZGF0YT0wIGlzIG9idGFpbmVkIHdoZW4g
eHNwaSBpcyB0cmFuc21pdHRlZCwgDQphbmQgdGhlIGNvcnJlY3QgZGF0YSBjYW5ub3QgYmUgdHJh
bnNtaXR0ZWQgYXQgdGhpcyB0aW1lIChJIGRvbid0IHF1aXRlIHVuZGVyc3RhbmQgd2h5IHlvdSBh
ZGRlZCB0aGlzIHN0YXRlbWVudCkuDQpUaGFua3MsDQpDaHVhbmh1YQ0K

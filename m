Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ED4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1425220685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="f2FkKHcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1425220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503282AbeKWVQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:16:21 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:4048 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390639AbeKWVQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:16:21 -0500
X-IronPort-AV: E=Sophos;i="5.56,269,1539673200"; 
   d="scan'208";a="21466470"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 Nov 2018 03:32:37 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 23 Nov 2018 03:32:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxuyYwWCHxYNDTUJCEITDiBe4dlNxRPSgjyr0kdm/rM=;
 b=f2FkKHcmI7YTV8xoPAfRxbhjBfYLu7wJzAjC++xXpjB9ytMCgWz9PYI6vdAPNpmvq0LgtmA1v61fWEAv8ICV0QFL0Mb1wR2z76eWUi5sBhGeE4LmRab4o50GrJmyZc6J/ESeFCv0z+PVV1UuWzqU0Ga0wctoXw/TXc6U7eL3umI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1617.namprd11.prod.outlook.com (10.172.23.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Fri, 23 Nov 2018 10:32:33 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1339.029; Fri, 23 Nov 2018
 10:32:33 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexander.sverdlin@nokia.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <boris.brezillon@bootlin.com>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Topic: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Index: AQHUgmAPRuGauPbUmUaN5hsWx0CViKVdHRGAgAANy4A=
Date:   Fri, 23 Nov 2018 10:32:33 +0000
Message-ID: <65d03690-a475-dc5b-ab9d-14e6216ba0bd@microchip.com>
References: <20181122123552.15756-1-tudor.ambarus@microchip.com>
 <3d8a2b83-282d-7cb2-3c8b-addae3c2af7f@nokia.com>
In-Reply-To: <3d8a2b83-282d-7cb2-3c8b-addae3c2af7f@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0021.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::31) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.253.132]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1617;6:60KDKTkzedWA3iDrYD+km80EelPcqHl3T34jH9mXMscoqjoFaDBs9/wfBJXp0vT7rc+Gv4Pib+hLQfDsJdzfMCAheL8yivy8e/lPKfPnGaVRkdZG95RAzVrbtugl6y7VuJ5wxa0vGimCUj9CBBMyWEJrvOYNLvhbZkIZ530p50J6xgu/qgnFCeNV2T6ossaKmcnZtbrhTXfPmSf5wrFER7sXWwewW4e/8xunCrB4c5R9X12MkTAXkr4FP3Ef7zK6TOt4rAHuvKsifteJKgbZRd5GiTdgbr+t3cTv1u4ZmjoCBNBNXpaMRPatfwtgBTY5lYoaid5185KW5EX+0/MzJxaGx94xu2ANCUmn3cBzTLN6O68z0/JPTxDzoZ1IZ5j66hraQnA8KsOtMYF3q3+s05QJ8FVJ0GW70ZUVAdyKNUd5vn/GyiQDH3/QvDL+yMNNrVC9YP0GU5u6VsVMmtLP3Q==;5:VWas6n3Zq+fpiZnagwTF0jNtngq9W+zrFo46BIMaf9Iwz/9cRgYlQY+Iw1qD5S7UxKK4zyO5z1VETPEqVYErSQyiAQRKRcOQf91q+GOOpiT5PLDBQNLWW3g8JT7MtJ+5+zda0HrGhwPeNmBmSQzdsrauP1uX9uZe6XZ7HhpicC8=;7:jXAcuFzurChvPxCHVHYXBc+qCuZWucVqGOQzbAWym0eZG7pPST6GYgVUWdETGHseP+aQzYucD1R7BS7+LF6ADzvqtcJT3XOWViA0JRmcKJbiZ91Un/xkpo/DpK5jlzmbT/cmrvrjsvogEAaBFmZZaw==
x-ms-office365-filtering-correlation-id: 411b30e4-1e37-41b1-5987-08d6512efa39
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1617;
x-ms-traffictypediagnostic: BN6PR11MB1617:
x-microsoft-antispam-prvs: <BN6PR11MB1617FD65AC7E2786F142F551F0D40@BN6PR11MB1617.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231442)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1617;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1617;
x-forefront-prvs: 086597191B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(256004)(229853002)(14444005)(8936002)(76176011)(8676002)(6486002)(106356001)(99286004)(81166006)(52116002)(81156014)(105586002)(5660300001)(305945005)(7736002)(66066001)(110136005)(54906003)(14454004)(316002)(446003)(6436002)(186003)(478600001)(2616005)(11346002)(476003)(97736004)(53936002)(6512007)(86362001)(72206003)(3846002)(6116002)(2201001)(2501003)(31696002)(68736007)(71200400001)(486006)(2900100001)(4326008)(53546011)(6506007)(31686004)(39060400002)(25786009)(6246003)(71190400001)(26005)(36756003)(386003)(102836004)(2906002)(414714003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1617;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jDb4ud9gDOoBYdRzyCQpQ3/f67mZHXF7y2uJXB6030g7Goq+WFtfu0mYO5sVn1AJN7XGUNfYEJc7pJoiCqPsxXnHOCVXMTDTWW/Rukgg0ExlKRYpSK3e9Dlsb9+GEGLbBZgzL3bkjwKsEJQ0/d5xMwuOxoa4Fe1ah4zCEbbJOeeRbVngsqQhVFGqHWlCd0PzcqfxWDL5UqUhP1s23mnF0fF08hDTrxiKcMoQ4jlZILZUPyKgXXFEp4zklQlfc1MuMnYpZhobGb3Fc72V4jofy4GXCnOK4leQe8rCKe1QJdczVjJEb9z382amGpZg21KbcvWAUQnXf6L4yXAF7ITKcGoW3up/rZhcIjNvyE6Mca4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A734067C53B750428770EEA801C67FF1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 411b30e4-1e37-41b1-5987-08d6512efa39
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2018 10:32:33.4224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1617
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFsZXhhbmRlciwNCg0KT24gMTEvMjMvMjAxOCAxMTo0MiBBTSwgU3ZlcmRsaW4sIEFsZXhh
bmRlciAoTm9raWEgLSBERS9VbG0pIHdyb3RlOg0KPiBIZWxsbyBUdWRvciwNCj4gDQo+IE9uIDIy
LzExLzIwMTggMTM6MzYsIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IEZy
b206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBC
dWcgcmVwb3J0ZWQgZm9yIHRoZSBvdXQtb2YtdHJlZSBTMjVGUzEyOFMgZmxhc2ggbWVtb3J5Lg0K
Pj4NCj4+IEJGUFQgdGFibGUgYWR2ZXJ0aXNlcyBhbGwgdGhlIGVyYXNlIHR5cGVzIHN1cHBvcnRl
ZCBieSBhbGwgdGhlDQo+PiBwb3NzaWJsZSBtYXAgY29uZmlndXJhdGlvbnMuIFVwZGF0ZSB0aGUg
ZXJhc2VfdHlwZSBhcnJheSB0byBpbmRpY2F0ZQ0KPj4gd2hpY2ggZXJhc2UgdHlwZXMgYXJlIGFw
cGxpY2FibGUgdG8gdGhlIGN1cnJlbnQgbWFwIGNvbmZpZ3VyYXRpb24uDQo+Pg0KPj4gQmFja3dh
cmQgY29tcGF0aWJpbGl0eSB0ZXN0IGRvbmUgb24gc3N0MjZ2ZjA2NGIuDQo+Pg0KPj4gRml4ZXM6
IGIwMzhlOGUzYmU3MiAoIm10ZDogc3BpLW5vcjogcGFyc2UgU0ZEUCBTZWN0b3IgTWFwIFBhcmFt
ZXRlciBUYWJsZSIpDQo+PiBSZXBvcnRlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5k
ZXIuc3ZlcmRsaW5Abm9raWEuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8
dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPiANCj4gSSd2ZSB0ZXN0ZWQgdGhpcyBwYXRj
aCBhbmQgaXQgZml4ZXMgdGhlIGVyYXNlc2l6ZSBmb3IgUzI1RlMxMjhTIGFuZA0KPiBvdXIgMTI4
ayBwYXJ0aXRpb25zIGFyZSB3cml0ZWFibGUgYWdhaW4gd2l0aCB0aGlzIHBhdGNoLg0KDQpHb29k
LiBZb3Ugc2FpZCB0aGF0IHRoZSBmbGFzaCBpcyBjb25maWd1cmVkIGluIG5vbi11bmlmb3JtIG1h
cHBpbmcgKGh5YnJpZA0Kc2VjdG9yIG9wdGlvbikuIFRoZXJlIGlzIG5vIHVuaWZvcm0gZXJhc2Ug
dHlwZSB0aGF0IGNhbiBlcmFzZSB0aGUgZW50aXJlDQpmbGFzaCBtZW1vcnkgYnkgaXRzIG93biwg
c28gdGhlIGVyYXNlIHNob3VsZCBiZSBkb25lIHVzaW5nIHRoZSBub24tdW5pZm9ybQ0KZXJhc2Ug
Y29kZSAoc3BpX25vcl9oYXNfdW5pZm9ybV9lcmFzZSgpIHNob3VsZCByZXR1cm4gZmFsc2UpLiBE
b2VzIHRoZQ0Kbm9uLXVuaWZvcm0gZXJhc2Ugd29yayBhcyBleHBlY3RlZD8gDQoNCkZvciBleGFt
cGxlLCBpZiB0aGUgaHlicmlkIHNlY3Rpb24gaXMgYXQgdGhlIHRvcCBvZiB0aGUgYWRkcmVzcyBz
cGFjZSwgd2hlbg0KdXNpbmcgbXRkX3V0aWxzOg0KJCBtdGRfZGVidWcgZXJhc2UgL2Rldi95b3Vy
X210ZCA0MDk2IDEyNjk3Ng0KSSB3b3VsZCBleHBlY3QgdGhlIHVzZSBvZiB0aGUgZm9sbG93aW5n
IGVyYXNlIHR5cGVzOiA3KjRrLCAzMmssIDY0aw0KVGhlbiB3cml0ZSBhbmQgcmVhZCBiYWNrIHRv
IGNoZWNrIGlmIHRoZSBlcmFzZSB3YXMgZG9uZSBjb3JyZWN0bHk6DQokIGRkIGlmPS9kZXYvdXJh
bmRvbSBvZj1pbiBicz00MDk2IGNvdW50PTMxDQokIG10ZF9kZWJ1ZyB3cml0ZSAvZGV2L3lvdXJf
bXRkIDQwOTYgMTI2OTc2IGluDQokIG10ZF9kZWJ1ZyByZWFkIC9kZXYveW91cl9tdGQgNDA5NiAx
MjY5NzYgb3V0DQokIHNoYTFzdW0gaW4gb3V0DQp0aGUgb3V0cHV0IHNob3VsZCBiZSB0aGUgc2Ft
ZS4NCg0KRmVlbCBmcmVlIHRvIGFkZCBzb21lIHByaW50cyBpbiB0aGUgY29kZSB0byBiZSBzdXJl
IHRoYXQgbm9uLXVuaWZvcm0gZXJhc2UgY29kZQ0Kc2VsZWN0cyB0aGUgY29ycmVjdCBlcmFzZSB0
eXBlcy4NCg0KPiANCj4gTmV2ZXJ0aGVsZXNzLCBJIHRoaW5rIHRoaXMgaXMgY29pbmNpZGVuY2Uu
IEkgZG9uJ3QgdGhpbmsgdGhhdCBpdA0KPiBtYWtlcyBzZW5zZSB0byBPUiBhbGwgdGhlIGVyYXNl
IHR5cGVzIGZyb20gYWxsIHJlZ2lvbnMgaW4gb25lDQo+IGJpdG1hc2sgYW5kIGRlcml2ZSBhbnkg
dW5pZm9ybSBlcmFzZXNpemUgb3V0IG9mIGl0Lg0KPiBUaGlzIG1ha2VzIGxpdHRsZSBzZW5zZSBm
b3IgbWUgaW4gY2FzZSBvZiBub24tdW5pZm9ybSBtYXBzLg0KDQpJIGp1c3QgbWFza2VkIG91dCB0
aGUgZXJhc2UgdHlwZXMgdGhhdCBhcmUgbm90IHN1cHBvcnRlZCBieSB0aGUgY3VycmVudA0KY29u
ZmlndXJhdGlvbiBtYXAuIFdlIHNob3VsZCBub3QgdXNlIGFuIGVyYXNlIHR5cGUgdGhhdCBpcyBu
b3Qgc3VwcG9ydGVkDQpieSBhbnkgb2YgdGhlIG1hcCByZWdpb25zLiBTTVBULCBpZiBwcmVzZW50
LCBzaG91bGQgaGF2ZSBwcmVjZWRlbmNlIG92ZXINCkJGUFQgd2hlbiBpbmRpY2F0aW5nIHN1cHBv
cnRlZCBlcmFzZSB0eXBlcy4NCg0KQ2hlZXJzLA0KdGENCg0KPiANCj4gSSBiZWxpZXZlLCB0aGUg
Y3VscHJpdCBoZXJlIGlzIG9uZSBsZXZlbCBoaWdoZXIsIGluIHRoZSBNVEQgcGFydGl0aW9uaW5n
DQo+IGNvZGUgKG10ZHBhcnQuYykgd2hpY2ggaGFzIHRvIGJlIHRhdWdodCBhYm91dCBub24tdW5p
Zm9ybSBtYXBzDQo+IGJ1dCB0aGVyZSBpcyBubyBpbmZyYXN0cnVjdHVyZSBmb3IgdGhpcyBjdXJy
ZW50bHkuDQo+IA0KPiBXaGF0IGlzIHBvc3NpYmxlIHRvIGZpeCBzdGlsbCBpcyB0byBjaG9vc2Ug
c21hbGxlc3QsIG5vdCBiaWdnZXN0DQo+IGVyYXNlc2l6ZSBmb3IgdW5pZm9ybSBjYXNlLiBJIGhh
dmUgc3VjaCBhIHBhdGNoLCBidXQgSSBuZWVkIGhhbmRzDQo+IG9uIG9uIGEgUzI1RlMxMjhTIGNv
bmZpZ3VyZWQgaW4gdW5pZm9ybSBtb2RlLg0KPiANCj4gTm9uIHVuaWZvcm0gY2FzZSByZXF1aXJl
cyBNVEQgbGF5ZXIgcmV3b3JrLiBXZSBqdXN0IGNhbm5vdCBoYW5kbGUNCj4gdGhpcyBoYXJkd2Fy
ZSB3aXRoIGp1c3Qgb25lIGVyYXNlc2l6ZSBpbiBtaW5kLiANCj4gDQo+PiAtLS0NCj4+ICBkcml2
ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KystDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgYi9kcml2
ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPj4gaW5kZXggOTNjOWJjODkzMWZjLi5hNzFhZGNk
NmRkZmEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPj4g
KysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4+IEBAIC0zMDAwLDcgKzMwMDAs
OCBAQCBzdGF0aWMgaW50IHNwaV9ub3JfaW5pdF9ub25fdW5pZm9ybV9lcmFzZV9tYXAoc3RydWN0
IHNwaV9ub3IgKm5vciwNCj4+ICAJdTY0IG9mZnNldDsNCj4+ICAJdTMyIHJlZ2lvbl9jb3VudDsN
Cj4+ICAJaW50IGksIGo7DQo+PiAtCXU4IGVyYXNlX3R5cGUsIHVuaWZvcm1fZXJhc2VfdHlwZTsN
Cj4+ICsJdTggdW5pZm9ybV9lcmFzZV90eXBlLCBzYXZlX3VuaWZvcm1fZXJhc2VfdHlwZTsNCj4+
ICsJdTggZXJhc2VfdHlwZSwgcmVnaW9uc19lcmFzZV90eXBlOw0KPj4gIA0KPj4gIAlyZWdpb25f
Y291bnQgPSBTTVBUX01BUF9SRUdJT05fQ09VTlQoKnNtcHQpOw0KPj4gIAkvKg0KPj4gQEAgLTMw
MTQsNiArMzAxNSw3IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9pbml0X25vbl91bmlmb3JtX2VyYXNl
X21hcChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPj4gIAltYXAtPnJlZ2lvbnMgPSByZWdpb247DQo+
PiAgDQo+PiAgCXVuaWZvcm1fZXJhc2VfdHlwZSA9IDB4ZmY7DQo+PiArCXJlZ2lvbnNfZXJhc2Vf
dHlwZSA9IDA7DQo+PiAgCW9mZnNldCA9IDA7DQo+PiAgCS8qIFBvcHVsYXRlIHJlZ2lvbnMuICov
DQo+PiAgCWZvciAoaSA9IDA7IGkgPCByZWdpb25fY291bnQ7IGkrKykgew0KPj4gQEAgLTMwMzAs
MTMgKzMwMzIsMzggQEAgc3RhdGljIGludCBzcGlfbm9yX2luaXRfbm9uX3VuaWZvcm1fZXJhc2Vf
bWFwKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+PiAgCQkgKi8NCj4+ICAJCXVuaWZvcm1fZXJhc2Vf
dHlwZSAmPSBlcmFzZV90eXBlOw0KPj4gIA0KPj4gKwkJLyoNCj4+ICsJCSAqIHJlZ2lvbnNfZXJh
c2VfdHlwZSBtYXNrIHdpbGwgaW5kaWNhdGUgYWxsIHRoZSBlcmFzZSB0eXBlcw0KPj4gKwkJICog
c3VwcG9ydGVkIGluIHRoaXMgY29uZmlndXJhdGlvbiBtYXAuDQo+PiArCQkgKi8NCj4+ICsJCXJl
Z2lvbnNfZXJhc2VfdHlwZSB8PSBlcmFzZV90eXBlOw0KPj4gKw0KPj4gIAkJb2Zmc2V0ID0gKHJl
Z2lvbltpXS5vZmZzZXQgJiB+U05PUl9FUkFTRV9GTEFHU19NQVNLKSArDQo+PiAgCQkJIHJlZ2lv
bltpXS5zaXplOw0KPj4gIAl9DQo+PiAgDQo+PiArCXNhdmVfdW5pZm9ybV9lcmFzZV90eXBlID0g
bWFwLT51bmlmb3JtX2VyYXNlX3R5cGU7DQo+PiAgCW1hcC0+dW5pZm9ybV9lcmFzZV90eXBlID0g
c3BpX25vcl9zb3J0X2VyYXNlX21hc2sobWFwLA0KPj4gIAkJCQkJCQkgIHVuaWZvcm1fZXJhc2Vf
dHlwZSk7DQo+PiAgDQo+PiArCWlmICghcmVnaW9uc19lcmFzZV90eXBlKSB7DQo+PiArCQkvKg0K
Pj4gKwkJICogUm9sbCBiYWNrIHRvIHRoZSBwcmV2aW91cyB1bmlmb3JtX2VyYXNlX3R5cGUgbWFz
aywgU01QVCBpcw0KPj4gKwkJICogYnJva2VuLg0KPj4gKwkJICovDQo+PiArCQltYXAtPnVuaWZv
cm1fZXJhc2VfdHlwZSA9IHNhdmVfdW5pZm9ybV9lcmFzZV90eXBlOw0KPj4gKwkJcmV0dXJuIC1F
SU5WQUw7DQo+PiArCX0NCj4+ICsNCj4+ICsJLyoNCj4+ICsJICogQkZQVCB0YWJsZSBhZHZlcnRp
c2VzIGFsbCB0aGUgZXJhc2UgdHlwZXMgc3VwcG9ydGVkIGJ5IGFsbCB0aGUNCj4+ICsJICogcG9z
c2libGUgbWFwIGNvbmZpZ3VyYXRpb25zLiBVcGRhdGUgdGhlIGVyYXNlX3R5cGUgYXJyYXkgdG8g
aW5kaWNhdGUNCj4+ICsJICogd2hpY2ggZXJhc2UgdHlwZXMgYXJlIGFwcGxpY2FibGUgdG8gdGhl
IGN1cnJlbnQgbWFwIGNvbmZpZ3VyYXRpb24uDQo+PiArCSAqLw0KPj4gKwlmb3IgKGkgPSAwOyBp
IDwgU05PUl9FUkFTRV9UWVBFX01BWDsgaSsrKQ0KPj4gKwkJaWYgKCEocmVnaW9uc19lcmFzZV90
eXBlICYgQklUKGVyYXNlW2ldLmlkeCkpKQ0KPj4gKwkJCXNwaV9ub3Jfc2V0X2VyYXNlX3R5cGUo
JmVyYXNlW2ldLCAwLCAweEZGKTsNCj4+ICsNCj4+ICAJc3BpX25vcl9yZWdpb25fbWFya19lbmQo
JnJlZ2lvbltpIC0gMV0pOw0KPj4gIA0KPj4gIAlyZXR1cm4gMDsNCj4gDQo=

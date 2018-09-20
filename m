Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15AAC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0A02150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rM2cuNyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0A02150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeITVnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:43:39 -0400
Received: from mail-he1eur01on0040.outbound.protection.outlook.com ([104.47.0.40]:62427
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727162AbeITVnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmyLQFMeC/GX6jSjFmfHzTmH30PgOVsr/IWWAn/17Mo=;
 b=rM2cuNyQDMT4JARAZJTSjYS/HsLWnLmH0eKhz/t6MbQ6OakPmEydvFM8YIMZYJmCJThP8F71veGphUGQF7RQbV3i7Y2LlejojJ9GNWAk5tcMlYbdCovwFScvml3n83F7VyCdfV5OTug2wVRXMK4if2059W9V/wRPvqI6E4SFddw=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4337.eurprd04.prod.outlook.com (52.134.126.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 15:59:13 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::c5f:d09d:bdc1:fe03%2]) with mapi id 15.20.1143.017; Thu, 20 Sep 2018
 15:59:13 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "gustavo@padovan.org" <gustavo@padovan.org>,
        "marex@denx.de" <marex@denx.de>,
        "sean@poorly.run" <sean@poorly.run>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        Robert Chiras <robert.chiras@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [RESEND 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Thread-Topic: [RESEND 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif
 block
Thread-Index: AQHUToxYC5nA0ZROGECLHk7Ehnp4vqT02KYAgABJB4CABDbvAA==
Date:   Thu, 20 Sep 2018 15:59:12 +0000
Message-ID: <74b9b382ea6f9ec47573955d5b64a597b950cb5b.camel@nxp.com>
References: <cover.1537191359.git.leonard.crestez@nxp.com>
         <20180917191602.GP188300@art_vandelay>
         <80da134658da77f0d3f8fda6894ab756@agner.ch>
In-Reply-To: <80da134658da77f0d3f8fda6894ab756@agner.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4337;6:Kr+WlGWz0t7yvbKjqoyJ8KAjcWbyBJUJUzpufFUJ0vKF29SZvdvUOvq0gUgBQyNMTOuxPsYwRfndbAVh4kSnHeMuMmYIxFh742kagi8XFPn3awMVOcEIs7iNUEErJt8RU7qL4rUnfInvOX7PD3Mi00/4R7ffdZkvm6horYbmJlEXf5w9MPyZwNzVnAg1NQj5gdj+vbItbm4TnrZFU5jwr/hQGoKYvJfnISJF5m7Q2PqKGVxY9651vn9MPtBUhK/OTEVWRsQgLit2c3X28tGo2Rd+bdqT0+Frhstmbv8NKRoDP+snKhxzbcEGpynrkVqKN0cOmPcp4ccpQExPeu2nACfia5/51R7tzrRGVuKewmGQxAz44xkhj0aAofvVt/LaYJt1xI90pY/J1gwuhPYhHISkKYElIrEg7usvJ4mZEiup4l/8wr4kOrTKj5aA43rrOlMossUIen9mw4GQuRokbA==;5:+myjeBTmCnPoXi+Z5TxZVfEWzEV03Fa/5JO/HcDuQfEvpP0evEIM01//iJYcdgi7xHVmYVZUGm67L/z/VJNo67r8wYuLubgD3XQJ0Dv14KpW4C5jsVONE9i8z5nxhNOvWYkCSUxA0w6CiMnGTewQuRn1tRPNt6GVu6g8z41Jmz4=;7:aGPkFh1EW+HUVSpJXzPfvpkiPZde8o2AuS7buzHDm8aIJ/iniMQ/IaLnW8FZPTCMaLmDMh2RByqFVP+JbRq4dS/Q0oUytaTTV1r8viJW3Z9m24Nrl+1FNw+LDdZChtH1LimBREaFVJpjKWR+Mq1Ps5jXnapBKNJvT831++bIvbgLcmuXsqot3znARQ2v3sdKh3rjija605oQgEccJzY8MCtvN2HQqu4MoL/ySRolLQyuXiAIZQh9DbU6pmaxJNHk
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fa4a0585-6884-4fca-99e6-08d61f120276
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4337;
x-ms-traffictypediagnostic: AM0PR04MB4337:
x-microsoft-antispam-prvs: <AM0PR04MB4337710B914F235D147C496CEE130@AM0PR04MB4337.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM0PR04MB4337;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4337;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(6512007)(14444005)(7416002)(2906002)(53936002)(26005)(6246003)(5660300001)(76176011)(81166006)(81156014)(66066001)(305945005)(186003)(7736002)(229853002)(102836004)(8676002)(256004)(2900100001)(8936002)(5250100002)(2501003)(478600001)(97736004)(71190400001)(71200400001)(14454004)(3846002)(6116002)(25786009)(99286004)(50226002)(476003)(6436002)(106356001)(105586002)(86362001)(486006)(446003)(2616005)(316002)(2201001)(11346002)(68736007)(36756003)(4326008)(44832011)(53546011)(6506007)(54906003)(110136005)(6486002)(118296001)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4337;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: L1TnhipmuKyOqAca2RJZQNGQT9VWeSCmVujpJghCp82R9prz/hjwWy+SZYL01bB2GOzz4af7N92KBEW9MQqsAxAv+7oS8MY1ttbHhqhaAKHesD9FtynlCrajDH4lDOcd2mpGtwmXxX1e6KdnxsOU45+msm9l5kgLrmg8oYdwvqxMvc95QZj/rU8hMZzMl9RivnZwtk0LGNW4vDYNVr+GqD0d+KFvEIwpCmULiPNzNm9xd3bcSFuDtKLove/DHwiyQj4L+argGrBz0mK8QtJ3o+i1mE8bv5FZweHmVa5Wh9orgnds0Ba/1HcVSoIMpJMjZinSX7iJibT6IAAo2z55aXB4Ag0Icn32cKBXMWcg9rA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F37F256404038C4F8B52202AA55ACCDC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4a0585-6884-4fca-99e6-08d61f120276
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 15:59:12.9092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA5LTE3IGF0IDE2OjM3IC0wNzAwLCBTdGVmYW4gQWduZXIgd3JvdGU6DQo+
IE9uIDE3LjA5LjIwMTggMTI6MTYsIFNlYW4gUGF1bCB3cm90ZToNCj4gPiBPbiBNb24sIFNlcCAx
NywgMjAxOCBhdCAwNDo0MjoxMFBNICswMzAwLCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6DQo+ID4g
PiBBZGRpbmcgbGNkaWYgbm9kZXMgdG8gYSBwb3dlciBkb21haW4gY3VycmVudGx5IGRvZXNuJ3Qg
d29yaywgaXQgcmVzdWx0cw0KPiA+ID4gaW4gYmxhY2svY29ycnVwdGVkIHNjcmVlbnMgb3IgaGFu
Z3MuIFdoaWxlIHRoZSBkcml2ZXIgZG9lcyBlbmFibGUNCj4gPiA+IHJ1bnRpbWUgcG0gaXQgZG9l
cyBub3QgZGVhbCBjb3JyZWN0bHkgd2l0aCB0aGUgYmxvY2sgYmVpbmcgdW5wb3dlcmVkLg0KPiA+
ID4gDQo+ID4gPiBBbGwgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcyBoYXZlIHJldmlldyB0YWdzIGZy
b20gYSB3aGlsZSBhZ28gYW5kIEkNCj4gPiA+IHRlc3RlZCB0aGVtIGFnYWluIG9uIHRvcCBvZiBu
ZXh0LTIwMTgwOTEzLiBObyBjaGFuZ2VzDQo+ID4gPiANCj4gPiA+IFRoaXMgc2VyaWVzIHN0YWxs
ZWQgc28gSSByZWFjaGVkIG91dCB0byBNYXJlayBvbiBJUkMgYW5kIGhlIHdhcw0KPiA+ID4gc3Vy
cHJpc2VkIHRvIGJlIGxpc3RlZCBhcyBtYWludGFpbmVyDQo+ID4gDQo+ID4gSG9wZWZ1bGx5IG5v
dCB0b28gc3VycHJpc2VkIHNpbmNlIE1hcmVrIGFkZGVkIHRoZW1zZWxmIHRvIE1BSU5UQUlORVJT
IHdoZW4NCj4gPiBhZGRpbmcgdGhlIGRyaXZlciA6LSkNCj4gDQo+IFRoZXJlIGhhdmUgYmVlbiBz
b21lIGNvbmZ1c2lvbiBhYm91dCB0aGUgRFJNIGRldmVsb3BtZW50IHByb2Nlc3Nlcw0KPiBhcm91
bmQgdGhlIG14c2ZiIGFscmVhZHkgaW4gdGhlIHBhc3QuDQo+DQo+ID4gSSBzdXBwb3NlIHdlIHNo
b3VsZCBwcm9iYWJseSBtb3ZlIHRoaXMgdG8gZHJtLW1pc2Mgc2luY2UgaXQgcXVhbGlmaWVzIGFz
IGENCj4gPiAic21hbGwgZHJpdmVyIiBhbmQgbmVlZHMgYSBob21lLiBMb29raW5nIHRocm91Z2gg
Z2l0IGhpc3Rvcnkgc2hvd3MgdGhlIGxhc3QNCj4gPiBteHNmYi1zcGVjaWZpYyBjaGFuZ2Ugd2Fz
IGJhY2sgaW4gMDIvMTcuIEV2ZXJ5dGhpbmcgZWxzZSBoYXMgYmVlbiBkcm0td2lkZQ0KPiA+IHJl
ZmFjdG9ycy4gVGhvdWdodHM/DQo+ID4gDQo+ID4gTWFyZWsvTGVvbmFyZDogQ2FyZSB0byBzaWdu
IHVwIHRvIGJlIGxpc3RlZCBhcyBhIHJldmlld2Vycz8NCj4gDQo+IGRybS1taXNjIHNlZW1zIHRv
IG1ha2Ugc2Vuc2UuIEkgdm9sdW50ZWVyIHRvIGJlIGxpc3RlZCBhcyByZXZpZXdlciBvciBjby1t
YWludGFpbmVyLg0KDQpUaGlzIGdldHMgKzEgZnJvbSBtZSwgeW91IHdlcmUgdmVyeSBoZWxwZnVs
IGR1cmluZyByZXZpZXcuDQoNCk5leHQgd291bGQgYmUgZm9yIG9uZSBvZiB0aGUgZHJtLW1pc2Mg
bWFpbnRhaW5lcnMgdG8gcG9zdCBhIGNoYW5nZSBmb3INCnRoZSBNQUlOVEFJTkVSIGZpbGUgYW5k
IGFsc28gbWVyZ2UgbXkgc2VyaWVzPw0KDQotLQ0KUmVnYXJkcywNCkxlb25hcmQ=

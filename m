Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B36FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032AA208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ays3WA5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032AA208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbeK0VWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:22:41 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:64136 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbeK0VWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:22:41 -0500
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="24555372"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Nov 2018 03:25:14 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 27 Nov 2018 03:25:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNyWQiU/2GotS182meiCXfVkTjPoyIvkAfVhKWU8p/Q=;
 b=ays3WA5dQk6V59BAgsqrTqJXjRccvktF0WvkLPhF4Hu0vyipiFX6lv6KZoTkElJbWSW9eiKTv1GhtN35ftddmIdcakRd6F/RNjWFseJuHSDgFYzbX5/0HpC5qZ8cX9tAZWJmSxfJk9MYxmQEKvVZ80SbSLQLmq+RZ5uo6GY+eEo=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0583.namprd11.prod.outlook.com (10.163.159.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Tue, 27 Nov 2018 10:25:11 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1361.019; Tue, 27 Nov 2018
 10:25:11 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <harinik@xilinx.com>, <andrew@lunn.ch>
CC:     <harini.katakam@xilinx.com>, <Nicolas.Ferre@microchip.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>, <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v2 1/4] net: macb: Check MDIO state before read/write and
 use timeouts
Thread-Topic: [PATCH v2 1/4] net: macb: Check MDIO state before read/write and
 use timeouts
Thread-Index: AQHUhZa7v3Zh+jBG9kSdXfX2qosMHKVjG4F7gABQPIA=
Date:   Tue, 27 Nov 2018 10:25:11 +0000
Message-ID: <74937246-dc7d-db1c-df00-5db856192eac@microchip.com>
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
 <1543216072-9623-2-git-send-email-harini.katakam@xilinx.com>
 <5de882e3-65ac-7ff1-bb55-7537666dfc77@microchip.com>
 <20181126145210.GD12116@lunn.ch>
 <CAFcVECK=4e-+1u3X+OuLoAEicUtrkTX3C0wzAugMRcJSP0N-Vg@mail.gmail.com>
In-Reply-To: <CAFcVECK=4e-+1u3X+OuLoAEicUtrkTX3C0wzAugMRcJSP0N-Vg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0079.eurprd04.prod.outlook.com
 (2603:10a6:803:64::14) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0583;6:5tag2KGne/JZ4yx9vfo9QLZSeGAGCsZkGetG5JLXNMH4xKHtSKnxI8CRCts2En9J/+fcY/Jqmfqta19vbp0Yi8bh4KIFh1YvHi5D4VJr2GbmSFb+GJq11FnOpjmDhNe/wyTGyhMlc9AgdGJsaWeGnoEpRq1T96/9S7mEQWUGMMnBsxia0Z4E5Nd67x8fFWlt/uU2gr4hr4ClT6KJhsoVBxO8mvEew69j9HOZAiN2QDBDp2eUh1q52SzR6Kw/bT0mR6EteJVoAV5IVSJckdS0s8gyUCOmWBm1XjOfSUiqRqxCo7Kt6ba7eE6gHExxPqyG+BOyLLR58gKXGSwQXndN9cNHGxUq/3qUsFnGQucMklxT8usCupPG/wWOaCbG5P3SDXwP7GfIrWODy4olqqQ825QoMNYQ9aqLCYCQqQZ3r77VBUGhP8DSyIQ6xY697IKG4k/LaUoHRuknvGFs6BLhU7x9bVFSKUnE1bSAU6odfWY=;5:GA4e4PKyBd8yPaQZ0FM6kH9jkQZJOkHQiYjtHy8ec1ay68HuQUpy1RUI3oCq4kWr9ybTFwGTKquj2t9Hfg07SESkBGDrw005BFNDZjBHZTOy3Ai/4hOs9Gppqcjer2HXwWNJl+hKPO98qZpUjB6/ZVDCpmksv+mRed/kiVNv6PA=;7:E6JTHR5uAjD/Rl3T1CSB8k74eEWDkuK/by39hZHv7Joj9IVPsBbGd6QAYhGdF3SFacD/DobBKTHX3+TfFH0y2l5G11Yy3AI498SY7n7wESYW62jW0MMDvD/qa6PgYpXvZMmlwWOX1LU/YScQlQu8Fw==
x-ms-office365-filtering-correlation-id: 075fbaa7-7ebd-4d79-0445-08d654529cbd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0583;
x-ms-traffictypediagnostic: BY2PR11MB0583:
x-microsoft-antispam-prvs: <BY2PR11MB05835BDDA678F701A5121F1487D00@BY2PR11MB0583.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231443)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0583;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0583;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(366004)(39860400002)(376002)(199004)(189003)(68736007)(7736002)(53936002)(305945005)(14454004)(6512007)(72206003)(478600001)(86362001)(2616005)(106356001)(14444005)(11346002)(446003)(486006)(105586002)(476003)(256004)(6116002)(3846002)(229853002)(5660300001)(31696002)(6246003)(36756003)(71190400001)(4326008)(53546011)(8936002)(52116002)(6506007)(25786009)(97736004)(81166006)(81156014)(102836004)(71200400001)(66066001)(110136005)(386003)(316002)(6436002)(345774005)(6486002)(93886005)(31686004)(99286004)(186003)(26005)(8676002)(54906003)(2906002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0583;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DCHfaVGKk1pc/Jrp98NdqILzPc4gxXB5/sBXpNqmfWwPVFjSnnDaxZa3NBwfDR8Jr2rhLJIDzasbrd72mDZ9NuM7s3y+j+JOifVeFavpK2CvdPlPyRDFDhj6GgT0Osu29fgYZy9pUe+/imn2n0d2OMACww4ZomyRfU0EWvCwmZ5+zGZDoxtYeEc3yu3TFT/yZLJaFoJdMLtvDJHAIMrkYp8rNUxGUVau4abyX46Oq5qcSHX5+vqsxjO4iyFZi1CHFxyaDpXBQChUaWHFbEgmK4It21aXKYOlssp9wV36cmaxUJ4mijXfAQxprKTxmXcx7X1mUzLAntf+QBOxki8oXnhkIph959BoP4Y65TPR6+U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CE469FCBA99A246A76CD1FA37D47216@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 075fbaa7-7ebd-4d79-0445-08d654529cbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 10:25:11.5950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0583
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LCBIYXJpbmksDQoNCk9uIDI3LjExLjIwMTggMDc6MzYsIEhhcmluaSBLYXRha2Ft
IHdyb3RlOg0KPiBIaSBDbGF1ZGl1LA0KPiBPbiBNb24sIE5vdiAyNiwgMjAxOCBhdCA4OjIyIFBN
IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4gd3JvdGU6DQo+Pg0KPj4gT24gTW9uLCBOb3Yg
MjYsIDIwMTggYXQgMDI6NDY6MDFQTSArMDAwMCwgQ2xhdWRpdS5CZXpuZWFAbWljcm9jaGlwLmNv
bSB3cm90ZToNCj4+PiBIaSBIYXJpbmksDQo+Pj4NCj4+PiBPbiAyNi4xMS4yMDE4IDA5OjA3LCBI
YXJpbmkgS2F0YWthbSB3cm90ZToNCj4+Pj4gRnJvbTogSGFyaW5pIEthdGFrYW0gPGhhcmluaWtA
eGlsaW54LmNvbT4NCj4+Pj4NCj4+Pj4gUmVwbGFjZSB0aGUgd2hpbGUgbG9vcCBpbiBNRElPIHJl
YWQvd3JpdGUgZnVuY3Rpb25zIHdpdGggYSB0aW1lb3V0Lg0KPj4+PiBJbiBhZGRpdGlvbiwgYWRk
IGEgY2hlY2sgZm9yIE1ESU8gYnVzIGJ1c3kgYmVmb3JlIGluaXRpYXRpbmcgYSBuZXcNCj4+Pj4g
b3BlcmF0aW9uIGFzIHdlbGwgdG8gbWFrZSBzdXJlIHRoZXJlIGlzIG5vIG9uZ29pbmcgTURJTyBv
cGVyYXRpb24uDQo+Pj4NCj4+PiBJcyB0aGlzIE1ESU8gYnVzIGJ1c3kgY2hlY2sgbmVjZXNzYXJ5
PyBUaGUgY2FsbGVyIG9mDQo+Pj4gbWFjYl9tZGlvX3JlYWQvbWFjYl9tZGlvX3dyaXRlIGxvY2tz
IHRoZSBtZGlvIGJ1cyBtdXRleCBiZWZvcmUgY2FsbGluZyBpdA0KPj4+IChlLmcuIG1kaW9idXNf
cmVhZCkuDQo+Pg0KPj4gSGkgQ2xhdWRpdQ0KPj4NCj4+IEl0IGRlcGVuZHMgb24gdGhlIGltcGxl
bWVudGF0aW9uLiBBIHdyaXRlIG9wZXJhdGlvbiB5b3UgY291bGQganVzdA0KPj4gbGF1bmNoLCBi
dXQgbm90IHdhaXQgZm9yIGl0IHRvIGNvbXBsZXRlLCBhbGxvd2luZyB5b3UgdG8gZG8gb3RoZXIN
Cj4+IHN0dWZmIHdoaWxlIHRoZSBoYXJkd2FyZSBpcyBidXN5LiBGb3IgdGhlIG5leHQgb3BlcmF0
aW9uIHlvdSB0aGVuIGRvDQo+PiBuZWVkIHRvIGNoZWNrIHRoZSBwcmV2aW91cyBvcGVyYXRpb24g
aGFzIGNvbXBsZXRlZC4NCj4+DQo+PiBJJ3ZlIG5vdCBjaGVja2VkIGl0IGlzIGFjdHVhbGx5IGlt
cGxlbWVudGVkIHRoaXMgd2F5Lg0KPiANCj4gWWVzLCBhcyBBbmRyZXcgbWVudGlvbmVkLCBhIHBy
ZXZpb3VzIE1ESU8gYnVzIG9wZXJhdGlvbiBjYW5ub3QNCj4gYmUgYXNzdW1lZCB0byBiZSBjb21w
bGV0ZSBhbHdheXMgLSBmb3IgZXguLCBpbiBjYXNlIG9mIGEgdGltZW91dC4NCj4gVGhlcmUgaXMg
YSBjaGFuY2UgdGhhdCB0aGUgTURJTyBidXMgYml0IGlzIGJ1c3kgd2hlbiBtZGlvX3JlYWQvd3Jp
dGUNCj4gaXMgY2FsbGVkLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVzcG9uc2VzLiBJIHNlZSBp
dCBub3cuDQoNClRoZW4sIGRvIHlvdSB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gaGF2ZSBh
IG5ldyBBUEkgcGFydCBvZiBzdHJ1Y3QNCm1paV9idXMgdGhhdCBkcml2ZXJzIHNob3VsZCByZWdp
c3RlciBzbyB0aGF0LCB0aGUgbWlpIGNvcmUgdG8gY2hlY2sgaWYgdGhlDQpidXMgaXMgaWRsZSBi
ZWZvcmUgbHVuY2hpbmcgYSBuZXcgcmVxdWVzdD8NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpu
ZWENCg0KPiANCj4gUmVnYXJkcywNCj4gSGFyaW5pDQo+IA0K

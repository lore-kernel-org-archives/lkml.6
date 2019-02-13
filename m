Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28A0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E94B20836
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UI88+rXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391502AbfBMOC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:02:59 -0500
Received: from mail-eopbgr40048.outbound.protection.outlook.com ([40.107.4.48]:2688
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbfBMOC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Smgof196MfqTVADsgyU6MFKXGRzNd3d2Je3i8fnkb20=;
 b=UI88+rXNTRLkg+hUy9WnTKXHcit78ahZDFsSIrr9ZgfgzW3fQy6v1+2lU2Fcbn0ChRnMv5xtGuo2Y+kn9c9Jiy8QKnXXAYI4dxh+bTmoh/5wRUqMrQTX08vdsaroZSPYT7cTbBJ6UQgl5RVxH6PzE6lw1qy+VbEIcqAFF1agbCA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3785.eurprd04.prod.outlook.com (52.134.71.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 13 Feb 2019 14:02:54 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 14:02:54 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
Subject: RE: [PATCH V2 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Topic: [PATCH V2 2/2] clk: imx: scu: add cpu frequency scaling support
Thread-Index: AQHUw6CQ13JKnp8jt0O33OXV5gABVKXdv6AAgAABgSA=
Date:   Wed, 13 Feb 2019 14:02:54 +0000
Message-ID: <DB3PR0402MB39161D97A6D2B8DD0DD5D6ACF5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550064410-28417-1-git-send-email-Anson.Huang@nxp.com>
         <1550064410-28417-2-git-send-email-Anson.Huang@nxp.com>
 <59b181b77605f516b0e3a896ddce0224b4504b30.camel@nxp.com>
In-Reply-To: <59b181b77605f516b0e3a896ddce0224b4504b30.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78737682-4991-47ef-24b6-08d691bbf342
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3785;
x-ms-traffictypediagnostic: DB3PR0402MB3785:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM3ODU7MjM6dnFiZ1F3OFdjRDdwSllqSCtvNjlRT3Zu?=
 =?utf-8?B?OEhZWWhOcmw3Z0dTZHh5Y3NQMVVZYlZQbktrQlJUVno4Mm54aTRmaVQwWTZm?=
 =?utf-8?B?a3RFbWJHbXVzUkhWR3plQ0N1cVFndjNNS2dZa1cvLy8vS1p4WXcxVVU5WEp4?=
 =?utf-8?B?TnhrMXhJU3lxLy9pZVpOcmd6TzM2cXZFVWQyak9hSUwyQnJXenBZUVpJek9o?=
 =?utf-8?B?LzFZejRJRVFjc3UxL0ttdzJKbm8wTUlKTmcxd3NDTFhYckJBU1JKeENiM25r?=
 =?utf-8?B?ellhY25SQ0NOVnV0Q2dCd1hRMXQ4d3c3dmsrLzJuQlB5MjdVTWlFbnpRUWc1?=
 =?utf-8?B?L0p6UHYyU3pCb1E5eXQ4N0JVdkVwb2l0MXh3Q2hNNTRJYWRyTCtCeWdVSE1B?=
 =?utf-8?B?OWs3c3dsWC9OT09EYnhyYzY4TWtZSERqU0hsc2ZlbzRpeDlDcW1hZXVZTFJU?=
 =?utf-8?B?YW1zUC90Qis0ejczSER2RXRCUXVTWWV5bVRrTi9WZnI3Q0xYVkRydG5GbHkw?=
 =?utf-8?B?N2RIYXpkZXVscDIxcW9aaEdQdjVmeGhXdHUyM29TTU96YjZTQVllcDdUdktT?=
 =?utf-8?B?eXJ1WmNnbzlYQlVTR0h5cllwU1ArS09YSnY5THBGZWVQZkx0aFdLK3FxNXdH?=
 =?utf-8?B?WGV3R0RNR0Mwd0o1RUpKczhDTDErWDlBOUpzMGEwdG0rbmZPcUNFSTh6VlNL?=
 =?utf-8?B?MWhNRXlrU3BzMDlyL2NGR1BGMGRKWjU0Mk5SOUpIRXRLRFl3RThLMm95bzht?=
 =?utf-8?B?ZVV2blZqT3VyNk5QcEVzMk9XQ3BvbmJyNXFJK3AzdkZWNTlXczdDT2dCTW1M?=
 =?utf-8?B?Z2Y2ZUh0VHBJNjEzRVhBZDZ2NjJyUnRjRnovNkVQa014enkzZ3MvY1hLemU4?=
 =?utf-8?B?MHR0cDd5d1o0UkVEdW00NUxkTjh0M2pTY2lTbHlqdHVyRnlmb3F1VXJVM2VX?=
 =?utf-8?B?WTVUaU1qRytaaGFEYmo3VWR4b3ZSZTc2TGxMVkZEc05oL3NCcFIvWk5IVElq?=
 =?utf-8?B?ODAwdDhkUmFvWG13bFNGMXNLQnJLc1daTk4vdHNBM1k3aWFIWjRVaDBpTU4r?=
 =?utf-8?B?VVp1ejAwbWhZUXFoaU1xandpNzhSRVhjKzVhaDAzWllyWmliMmFxM2hkb0pQ?=
 =?utf-8?B?ZkwwOGhwWERjZGIvVzlGa2JMTDBhUkE0alRWbUVmbHdQaW1jMTZQanZvaExU?=
 =?utf-8?B?VnBCb1h0aXBoS01PNDNNY3Q3UGQreEE2UkNIblB3Z0FTTFFPYTZiUjZwT05p?=
 =?utf-8?B?QUo4V20razVtenJXYXMrUzdmcXFIQUZwVUJMK2t0SmtCMGZDWURVTjdiOE9q?=
 =?utf-8?B?c2swTVhvN21rck5wWm1tajFzODZpc3RQU1R4T3c0MlZXTnVjTlFpWE1tVzdk?=
 =?utf-8?B?UzE2clI2RjcyUDBHd0d2aEFzdlR1RG5KTHlnYWtGNU1YRHQyMkpzc0hEYUsv?=
 =?utf-8?B?YkJEZWJmUXloazQrc0ZuMGkxUHBDcHA3RGpCQmdkSk45VE5hY2JUV3dhZXpq?=
 =?utf-8?B?aXVsY3RvT3RzMkRoOWxLVW9wbkdUaGZHTWNnd0xnVHVPcU05Rk9lN1RROHNy?=
 =?utf-8?B?QU1Yd2RQMGs0amZNR3p4WDVKUWdlYnpTV283bmEwcHlQemZvMG5LTXhkZXE5?=
 =?utf-8?B?WTUyVjZEbWNHVVJKK0xUNFNhYW1TTk1lSHRaTzhoUVJxY0xSbnNSallxUkh4?=
 =?utf-8?B?QXRuRHNpU3ZOUzlPWHE5VGczYkRSQWZxQ2dYNktCRVc0Sllta1pLUklHYTM3?=
 =?utf-8?B?dDRKR0YyVG00M2wyTmF3YzV3PT0=?=
x-microsoft-antispam-prvs: <DB3PR0402MB37853F9AEE53750494EDFD33F5660@DB3PR0402MB3785.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(136003)(346002)(13464003)(199004)(189003)(486006)(55016002)(9686003)(476003)(7696005)(446003)(6436002)(99286004)(316002)(305945005)(6636002)(54906003)(11346002)(81166006)(102836004)(81156014)(6116002)(8676002)(3846002)(8936002)(14454004)(76176011)(53546011)(26005)(6506007)(74316002)(478600001)(4326008)(86362001)(68736007)(25786009)(6862004)(106356001)(44832011)(14444005)(33656002)(71200400001)(105586002)(186003)(7416002)(229853002)(256004)(71190400001)(7736002)(53936002)(66066001)(2906002)(6246003)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3785;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ecEB1E4eiM0k6DHzZd0FrR0i7lL7ZmjZ2u+ZUjGSYwYnTAkcnP+hAnfb+nDyFBAZaFNg2vPDM8IeTaA16Nh97D9Pk+LDf+mr9EY4Gu35raWsJhcdAz6omTHJNtlQqkNOkoMXzBFXDk543KqZIkWBDGxhRIBpTcCkXDTeB1X5r/3mhuwAT5cBJM7eW+uDtUKsGi9Q927rizFn1724mjZAnGdqJkt0Wm59oJ1bsiO8ZGOuOAeMwBe+fdkqxN4iP0EHXkSCzrM3rU90LdRM7jGhdEfPxy6rlgNjR9yHKhsDu0xj60qDIUUaTWgTeO7SqeNwl1hhUMhsmY0C0VgxQNctpIatOrfBns1Tw7o4/qW4CyFuGdePIMitrZUrgItjS+f9i/t3X9K9PyODRifEpTJyNGvnwpqwl/44ohqybMZTVpc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78737682-4991-47ef-24b6-08d691bbf342
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 14:02:54.4182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogTGVvbmFyZCBDcmVzdGV6DQo+IFNlbnQ6IDIwMTnlubQy5pyIMTPml6Ug
MjE6NTMNCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiBDYzogZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gbWFy
ay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBtdHVy
cXVldHRlQGJheWxpYnJlLmNvbTsNCj4gc2JveWRAa2VybmVsLm9yZzsgQWlzaGVuZyBEb25nIDxh
aXNoZW5nLmRvbmdAbnhwLmNvbT47IERhbmllbCBCYWx1dGENCj4gPGRhbmllbC5iYWx1dGFAbnhw
LmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4gY2xrQHZnZXIua2VybmVsLm9yZzsgdmlyZXNoLmt1bWFyQGxpbmFyby5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCBWMiAyLzJdIGNsazogaW14OiBzY3U6IGFkZCBjcHUgZnJlcXVlbmN5IHNj
YWxpbmcgc3VwcG9ydA0KPiANCj4gT24gV2VkLCAyMDE5LTAyLTEzIGF0IDEzOjMyICswMDAwLCBB
bnNvbiBIdWFuZyB3cm90ZToNCj4gPiBPbiBOWFAncyBpLk1YIFNvQ3Mgd2l0aCBzeXN0ZW0gY29u
dHJvbGxlciBpbnNpZGUsIENQVSBmcmVxdWVuY3kNCj4gPiBzY2FsaW5nIGNhbiBPTkxZIGJlIGRv
bmUgYnkgc3lzdGVtIGNvbnRyb2xsZXIgZmlybXdhcmUsIGFuZCBpdCBjYW4NCj4gPiBPTkxZIGJl
IHJlcXVlc3RlZCBmcm9tIHNlY3VyZSBtb2RlLCBzbyBMaW51eCBrZXJuZWwgaGFzIHRvIGNhbGwg
QVJNDQo+ID4gU01DIHRvIHRyYXAgdG8gQVJNLVRydXN0ZWQtRmlybXdhcmUgdG8gcmVxdWVzdCBz
eXN0ZW0gY29udHJvbGxlcg0KPiA+IGZpcm13YXJlIHRvIGRvIENQVSBmcmVxdWVuY3kgc2NhbGlu
Zy4NCj4gDQo+ID4gKyNpZmRlZiBDT05GSUdfQ1BVRlJFUV9EVA0KPiA+ICsjZGVmaW5lIElNWF9T
SVBfQ1BVRlJFUQkJCTB4QzIwMDAwMDENCj4gPiArI2RlZmluZSBJTVhfU0lQX1NFVF9DUFVGUkVR
CQkweDAwDQo+ID4gKw0KPiA+ICBzdGF0aWMgc3RydWN0IGlteF9zY19pcGMgKmNjbV9pcGNfaGFu
ZGxlOw0KPiANCj4gV2l0aG91dCBDT05GSUdfQ1BVRlJFUV9EVCB0aGUgY2NtX2lwY19oYW5kbGUg
d29uJ3QgYmUgZGVmaW5lZCBhbmQNCj4gYnVpbGQgd2lsbCBicmVhay4NCj4gDQo+IEJ1dCBpcyB0
aGVyZSBhIGdvb2QgcmVhc29uIGZvciBpZmRlZj8gSW4gZ2VuZXJhbCBjbG9jayBmdW5jdGlvbiBh
cmUgY29tcGlsZWQNCj4gZXZlbiBpZiBubyBkcml2ZXIgaXMgY2FsbGluZyB0aGVtLg0KDQpPb3Bz
LCB0aGlzIGlzIG15IG1pc3Rha2UgdG8gcHV0IHRoZSBjY21faXBjX2hhbmRsZSBpbnNpZGUgdGhl
IGlmZGVmLiBBZGRpbmcNCklmZGVmIGlzIGp1c3QgdG8gc2F2ZSBzb21lIGNvZGUgaWYgQ1BVRlJF
UV9EVCBpcyBOT1QgZGVmaW5lZCwgYnV0IEkgY2FuIHJlbW92ZQ0KaXQgaW4gbmV4dCB2ZXJzaW9u
Lg0KDQo+IA0KPiA+ICsjaWZkZWYgQ09ORklHX0NQVUZSRVFfRFQNCj4gPiArCS8qIENQVSBjbG9j
ayBjYW4gT05MWSBiZSBkb25lIGJ5IFRGLUEgKi8NCj4gPiArCWlmIChjbGstPmNsa190eXBlID09
IElNWF9TQ19QTV9DTEtfQ1BVKSB7DQo+ID4gKwkJc3RydWN0IGFybV9zbWNjY19yZXMgcmVzOw0K
PiA+ICsJCXVuc2lnbmVkIGludCBjbHVzdGVyX2lkOw0KPiA+ICsJCWludCBpOw0KPiA+ICsNCj4g
PiArCQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShpbXhfc2NfY3B1ZnJlcV9kYXRhKTsgaSsr
KSB7DQo+ID4gKwkJCWlmICghc3RyY21wKGNsa19od19nZXRfbmFtZShodyksDQo+ID4gKwkJCQlp
bXhfc2NfY3B1ZnJlcV9kYXRhW2ldLmNsa19uYW1lKSkgew0KPiA+ICsJCQkJY2x1c3Rlcl9pZCA9
DQo+IGlteF9zY19jcHVmcmVxX2RhdGFbaV0uY2x1c3Rlcl9pZDsNCj4gPiArCQkJCWJyZWFrOw0K
PiA+ICsJCQl9DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIEFzIHNvbWUg
b3RoZXIgY2xvY2sgdHlwZXMgaGF2ZSBzYW1lIHZhbHVlIGFzDQo+ID4gKwkJICogSU1YX1NDX1BN
X0NMS19DUFUsIHNvIHdlIG5lZWQgdG8gZG91YmxlIGNoZWNrDQo+ID4gKwkJICogdGhlIGNsb2Nr
IGJlaW5nIHNjYWxlZCBpcyBpbmRlZWQgQ1BVIGNsb2NrIHdoaWNoDQo+ID4gKwkJICogbWF0Y2hl
cyB0aGUgdGFibGUgd2UgZGVmaW5lLg0KPiA+ICsJCSAqLw0KPiA+ICsJCWlmIChpIDwgQVJSQVlf
U0laRShpbXhfc2NfY3B1ZnJlcV9kYXRhKSkgew0KPiA+ICsJCQlhcm1fc21jY2Nfc21jKElNWF9T
SVBfQ1BVRlJFUSwNCj4gSU1YX1NJUF9TRVRfQ1BVRlJFUSwNCj4gPiArCQkJCWNsdXN0ZXJfaWQs
IHJhdGUsIDAsIDAsIDAsIDAsICZyZXMpOw0KPiA+ICsJCQlyZXR1cm4gMDsNCj4gPiArCQl9DQo+
ID4gKwl9DQo+ID4gKyNlbmRpZg0KPiANCj4gVGhlIGNvZGUgaW5zaWRlIHRoZSBpZmRlZiB3b3Vs
ZCBsb29rIGJldHRlciBpbiBhIHNlcGFyYXRlDQo+IGlteF9jbGtfYXRmX3NldF9yYXRlIGZ1bmN0
aW9uLiBNYXliZSBldmVuIHNlcGFyYXRlIGNsa19vcHM/DQpJIGNhbiBhZGQgYSBzZXBhcmF0ZSBm
dW5jdGlvbiBmb3IgQ1BVIGNsb2NrIHNjYWxpbmcsIGFkZGluZyBuZXcgY2xrX29wcw0KY2hhbmdl
cyB0b28gbXVjaCwgdXNpbmcgYSBzZXBhcmF0ZSBmdW5jdGlvbiBzaG91bGQgYmUgZ29vZCBmb3Ig
bm93Pw0KDQpUaGFua3MuDQpBbnNvbi4gDQo=

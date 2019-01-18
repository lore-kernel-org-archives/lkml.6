Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE2AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403FC2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fIXxANtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfARJyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:54:41 -0500
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:19872
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfARJyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oKgWNtEPhELoecFW3SpQKAlaQ9qDiQdEWxTOf81JoI=;
 b=fIXxANtckmFugBMGHqwyHmbnbx80lVdHCxVmeU28jO5K99/EaAUdHi7J+fGAflFXAwzYlQ8lg+4oekH44o27/QvUFyU07+0XgozkedZ5ynqnl8oXrLKuzN7LuNZEtR1/QOm7h7XwFY5mwOYL5pjN/BCmYlFvFlZCqgfOoPUhExM=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4019.eurprd04.prod.outlook.com (52.134.90.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Fri, 18 Jan 2019 09:54:33 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c4d2:7dfd:4576:bdd5%5]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 09:54:33 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: RE: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts
 support
Thread-Topic: [PATCH 4/4] irq: imx: irqsteer: add multi output interrupts
 support
Thread-Index: AQHUrwL34aHTasx2wUetvBoWoE17FaW0uIqAgAAPyPA=
Date:   Fri, 18 Jan 2019 09:54:32 +0000
Message-ID: <AM0PR04MB42111D634F28492434AA9309809C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
         <1547797668-30342-5-git-send-email-aisheng.dong@nxp.com>
 <1547801609.2626.5.camel@pengutronix.de>
In-Reply-To: <1547801609.2626.5.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4019;6:Ikwsc5Fg4RtvF8TGWOAxElQINZQR+mnoG1c3LSjmvGdSvXu2T1VW3MyDF7+ZCFJCJ+TALt4I5/SrBhCsIaHEyBXz5+0QnFHxTEQUuNyfpEwPk9MrPUCzqTTAAEQ2sOlJiI4Tz3CoHcHAYQQcOVwFr/Phl/GQvnQEYYHfv6FYA39pCtoQdbHu9SgaMDcqP5KuHqKAEzotmplbUfgMiIdKfzML2CMu3KfVYEgQzajkn8bJbF9KaMOyAeYKu4Dv64zZ1QQX+lNk1xw+XbL3wDv3Z/aCrkpTktotcuNMmZBFUdmORDBgap8w7SNzie1RTUsSAdvJjscaFsIOMK61Dy9Fr/WIyQGYKuSyb+NckX6oL/nnrti9BufGCW6MWZjOfbrgt+J5u0vf1IDn7VT5B36vCQsDMp0pRIVOcGCLXmdReZA9fZjDxxYAJcPpd3d2/uzU8rw3rTPF76jxnc4vEXYx5w==;5:57eXwlfeo4FC76Mog9DdY8aB6AyG7uYPVh28gxMAkkPk+Hups52kSneHKBmd6GHphrh1FE5Lc3my/QIZy1JuRUCFmV67abe8R5gaCs68dQ4eLM8xo/YUqkmnpQlUwuKKw6xwOZX3BqaV/bbvb6R5ix3l87gYQ3p0w/5ZAB8P8kEbh8QUqrDGyVzdk6MrYNpeIx6TcMvwv/h1MvpesPGjIQ==;7:TkC85g0xb+G8Tu6Vxq5sQ5vJhtXji8TzMqhYU459gGfahLhcJPd0T5M95+paMrnf+f0+CfbSnQyg4ncR2kn/JJ0gYUUO1GUtk3vjtfs2b+0VuVkgNUb9/nJfFi8D/M8KFyTtvqD3pGdTe8grvX9Crw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2798ba5c-2eb1-48e0-4757-08d67d2af27f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4019;
x-ms-traffictypediagnostic: AM0PR04MB4019:
x-microsoft-antispam-prvs: <AM0PR04MB4019A95FB13B37D961FB57F5809C0@AM0PR04MB4019.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(366004)(376002)(396003)(199004)(189003)(11346002)(76176011)(105586002)(316002)(97736004)(106356001)(2906002)(68736007)(66066001)(5660300001)(476003)(229853002)(54906003)(110136005)(7696005)(99286004)(6436002)(2501003)(8936002)(9686003)(71190400001)(44832011)(86362001)(7736002)(6506007)(6116002)(102836004)(74316002)(478600001)(3846002)(53936002)(55016002)(26005)(33656002)(14454004)(71200400001)(186003)(486006)(8676002)(81166006)(81156014)(25786009)(4326008)(305945005)(446003)(256004)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4019;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GG/uS6k0w15km4j50inwOQZrG90mtXP+se1egramNWzVDIHn2utcVlvAAJOepPGISjzgFn5V594anVryZXNRN4tRqzKDPmX6T6IshVj4oO4EYifTmi/ND4r0zt2/0XS9pIbg2KTU/Zfz266sWugfXYVdVitPaxjP1dIYvAARo//QF9CVuZkS5+YQ5xDFxlz7BjqFZdOSSEvnJXJ3erlB4t/v3p8eiseOrZdMgZRwS97w2xY++5zA/bnpyTNsorhGhuWbQX/ESF1SoyG8A+pz1t8iST2citzusCHzMaCG7BJSz2iTj08cfLAfif1p91dngMb8ClKfpb5tgHkzq3WNNga2Y3DSwpwsqkheZMj0EoyD6b9dp6e/WDD/4wIRAQyDt06fciFyXYzlt3hLZXzMQU6vF2G3A7FVvpQ3bpkZ3a0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2798ba5c-2eb1-48e0-4757-08d67d2af27f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 09:54:32.9369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4019
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdWNhcyBTdGFjaCBbbWFpbHRvOmwuc3RhY2hAcGVuZ3V0cm9uaXguZGVdDQo+IFNl
bnQ6IEZyaWRheSwgSmFudWFyeSAxOCwgMjAxOSA0OjUzIFBNDQo+IEFtIEZyZWl0YWcsIGRlbiAx
OC4wMS4yMDE5LCAwNzo1MyArMDAwMCBzY2hyaWViIEFpc2hlbmcgRG9uZzoNCj4gPiBPbmUgaXJx
c3RlZXIgY2hhbm5lbCBjYW4gc3VwcG9ydCB1cCB0byA4IG91dHB1dCBpbnRlcnJ1cHRzLg0KPiAN
Cj4gVGhpcyBoYXMgYmVlbiBkaXNjdXNzZWQgd2hlbiB1cHN0cmVhbWluZyB0aGUgZHJpdmVyLiBU
aGUgY29udHJvbGxlciBtYXkNCj4gc3VwcG9ydCBtdWx0aXBsZSBvdXRwdXQgSVJRcywgYnV0IG9u
bHkgb25lIHRoZW0gaXMgYWN0dWFsbHkgdXNlZCBkZXBlbmRpbmcgb24NCj4gdGhlIENIQU5DVFJM
IGNvbmZpZy4gVGhlcmUgaXMgbm8gdXNlIGluIGhvb2tpbmcgdXAgYWxsIHRoZSBvdXRwdXQgSVJR
cyBpbiBEVCwgaWYNCj4gb25seSBvbmUgb2YgdGhlbSBpcyBhY3R1YWxseSB1c2VkLiBTb21lIG9m
IHRoZSBvdXRwdXRzIG1heSBub3QgZXZlbiBiZSB2aXNpYmxlDQo+IHRvIHRoZSBMaW51eCBzeXN0
ZW0sIGJ1dCBtYXkgYmVsb25nIHRvIGEgQ29ydGV4IE00IHN1YnN5c3RlbS4gQWxsIG9mIHRob3Nl
DQo+IGNvbmZpZ3VyYXRpb25zIGNhbiBiZSBkZXNjcmliZWQgaW4gRFQgYnkgY2hhbmdpbmcgdGhl
IHVwc3RyZWFtIGludGVycnVwdCBhbmQNCj4gImZzbCxjaGFubmVsIiBpbiBhIGNvaGVyZW50IHdh
eS4NCj4gDQo+IFBsZWFzZSBjb3JyZWN0IG1lIGlmIG15IHVuZGVyc3RhbmRpbmcgaXMgdG90YWxs
eSB3cm9uZy4NCg0KSSdtIGFmcmFpZCB5b3VyIHVuZGVyc3RhbmRpbmcgb2YgQ0hBTiBzZWVtcyB3
cm9uZy4NCihCaW5kaW5nIGRvYyBvZiB0aGF0IHByb3BlcnR5IG5lZWRzIGNoYW5nZSBhcyB3ZWxs
KS4NCg0KT24gUVhQIERDIFNTLCB0aGUgSVJRU1RFRVIgc3VwcG9ydHMgNTEyIGludGVycnVwdHMg
d2l0aCA4IGludGVycnVwdCBvdXRwdXQNCkNvbm50ZWN0ZWQgdG8gR0lDLg0KVGhlIGN1cnJlbnQg
ZHJpdmVyIGRvZXMgbm90IHN1cHBvcnQgaXQgYXMgaXQgYXNzdW1lcyBvbmx5IG9uZSBpbnRlcnJ1
cHQgb3V0cHV0IHVzZWQuDQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0KDQo+IA0KPiBSZWdhcmRz
LA0KPiBMdWNhcw0KPiANCj4gPiBDYzogTWFyYyBaeW5naWVyIDxtYXJjLnp5bmdpZXJAYXJtLmNv
bT4NCj4gPiA+IENjOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gPiA+
IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZHJp
dmVycy9pcnFjaGlwL2lycS1pbXgtaXJxc3RlZXIuYyB8IDM5DQo+ID4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRp
b25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ly
cWNoaXAvaXJxLWlteC1pcnFzdGVlci5jDQo+ID4gYi9kcml2ZXJzL2lycWNoaXAvaXJxLWlteC1p
cnFzdGVlci5jDQo+ID4gaW5kZXggMWJlYmYwYS4uNTQ4MDJmYSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2lycWNoaXAvaXJxLWlteC1pcnFzdGVlci5jDQo+ID4gKysrIGIvZHJpdmVycy9pcnFj
aGlwL2lycS1pbXgtaXJxc3RlZXIuYw0KPiA+IEBAIC0xMCw2ICsxMCw3IEBADQo+ID4gwqAjaW5j
bHVkZSA8bGludXgvaXJxY2hpcC9jaGFpbmVkX2lycS5oPg0KPiA+IMKgI2luY2x1ZGUgPGxpbnV4
L2lycWRvbWFpbi5oPg0KPiA+IMKgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiA+ICsjaW5j
bHVkZSA8bGludXgvb2ZfaXJxLmg+DQo+ID4gwqAjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0u
aD4NCj4gPiDCoCNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPg0KPiA+DQo+ID4gQEAgLTIxLDEw
ICsyMiwxMyBAQA0KPiA+ID4gwqAjZGVmaW5lIENIQU5fTUlOVERJUyh0KQkJKENUUkxfU1RSSURF
X09GRih0LCAzKSArIDB4NCkNCj4gPiA+IMKgI2RlZmluZSBDSEFOX01BU1RSU1RBVCh0KQkoQ1RS
TF9TVFJJREVfT0ZGKHQsIDMpICsgMHg4KQ0KPiA+DQo+ID4gPiArI2RlZmluZSBDSEFOX01BWF9P
VVRQVVRfSU5UCTB4OA0KPiA+ICsNCj4gPiDCoHN0cnVjdCBpcnFzdGVlcl9kYXRhIHsNCj4gPiA+
ID4gwqAJdm9pZCBfX2lvbWVtCQkqcmVnczsNCj4gPiA+ID4gwqAJc3RydWN0IGNsawkJKmlwZ19j
bGs7DQo+ID4gPiA+IC0JaW50CQkJaXJxOw0KPiA+ID4gPiArCWludAkJCWlycVtDSEFOX01BWF9P
VVRQVVRfSU5UXTsNCj4gPiA+ID4gKwlpbnQJCQlpcnFfY291bnQ7DQo+ID4gPiA+IMKgCXJhd19z
cGlubG9ja190CQlsb2NrOw0KPiA+ID4gPiDCoAlpbnQJCQlyZWdfbnVtOw0KPiA+ID4gPiDCoAlp
bnQJCQljaGFubmVsOw0KPiA+IEBAIC0xMTcsNyArMTIxLDcgQEAgc3RhdGljIGludCBpbXhfaXJx
c3RlZXJfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gwqAJ
c3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiA+ID4gwqAJc3Ry
dWN0IGlycXN0ZWVyX2RhdGEgKmRhdGE7DQo+ID4gPiDCoAlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsN
Cj4gPiA+IC0JaW50IHJldDsNCj4gPiA+ICsJaW50IGksIHJldDsNCj4gPg0KPiA+ID4gwqAJZGF0
YSA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKmRhdGEpLCBHRlBfS0VSTkVMKTsN
Cj4gPiA+IMKgCWlmICghZGF0YSkNCj4gPiBAQCAtMTMwLDEyICsxMzQsNiBAQCBzdGF0aWMgaW50
IGlteF9pcnFzdGVlcl9wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ID4gPiDCoAkJcmV0dXJuIFBUUl9FUlIoZGF0YS0+cmVncyk7DQo+ID4gPiDCoAl9DQo+ID4NCj4g
PiA+IC0JZGF0YS0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAwKTsNCj4gPiA+IC0JaWYg
KGRhdGEtPmlycSA8PSAwKSB7DQo+ID4gPiAtCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQg
dG8gZ2V0IGlycVxuIik7DQo+ID4gPiAtCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiA+IC0JfQ0KPiA+
IC0NCj4gPiA+IMKgCWRhdGEtPmlwZ19jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgImlw
ZyIpOw0KPiA+ID4gwqAJaWYgKElTX0VSUihkYXRhLT5pcGdfY2xrKSkgew0KPiA+ID4gwqAJCXJl
dCA9IFBUUl9FUlIoZGF0YS0+aXBnX2Nsayk7DQo+ID4gQEAgLTE3Nyw4ICsxNzUsMjMgQEAgc3Rh
dGljIGludCBpbXhfaXJxc3RlZXJfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiA+ID4gwqAJCXJldHVybiAtRU5PTUVNOw0KPiA+ID4gwqAJfQ0KPiA+DQo+ID4gPiAt
CWlycV9zZXRfY2hhaW5lZF9oYW5kbGVyX2FuZF9kYXRhKGRhdGEtPmlycSwgaW14X2lycXN0ZWVy
X2lycV9oYW5kbGVyLA0KPiA+ID4gLQkJCQkJwqBkYXRhKTsNCj4gPiA+ICsJZGF0YS0+aXJxX2Nv
dW50ID0gb2ZfaXJxX2NvdW50KG5wKTsNCj4gPiA+ICsJaWYgKCFkYXRhLT5pcnFfY291bnQgfHwg
ZGF0YS0+aXJxX2NvdW50ID4gQ0hBTl9NQVhfT1VUUFVUX0lOVCkgew0KPiA+ID4gKwkJY2xrX2Rp
c2FibGVfdW5wcmVwYXJlKGRhdGEtPmlwZ19jbGspOw0KPiA+ID4gKwkJcmV0dXJuIC1FSU5WQUw7
DQo+ID4gPiArCX0NCj4gPiArDQo+ID4gPiArCWZvciAoaSA9IDA7IGkgPCBkYXRhLT5pcnFfY291
bnQ7IGkrKykgew0KPiA+ID4gKwkJZGF0YS0+aXJxW2ldID0gaXJxX29mX3BhcnNlX2FuZF9tYXAo
bnAsIGkpOw0KPiA+ID4gKwkJaWYgKCFkYXRhLT5pcnFbaV0pIHsNCj4gPiA+ICsJCQljbGtfZGlz
YWJsZV91bnByZXBhcmUoZGF0YS0+aXBnX2Nsayk7DQo+ID4gPiArCQkJcmV0dXJuIC1FSU5WQUw7
DQo+ID4gPiArCQl9DQo+ID4gKw0KPiA+ID4gKwkJaXJxX3NldF9jaGFpbmVkX2hhbmRsZXJfYW5k
X2RhdGEoZGF0YS0+aXJxW2ldLA0KPiA+ID4gKwkJCQkJCcKgaW14X2lycXN0ZWVyX2lycV9oYW5k
bGVyLA0KPiA+ID4gKwkJCQkJCcKgZGF0YSk7DQo+ID4gPiArCX0NCj4gPg0KPiA+ID4gwqAJcGxh
dGZvcm1fc2V0X2RydmRhdGEocGRldiwgZGF0YSk7DQo+ID4NCj4gPiBAQCAtMTg4LDggKzIwMSwx
MiBAQCBzdGF0aWMgaW50IGlteF9pcnFzdGVlcl9wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ID4gwqBzdGF0aWMgaW50IGlteF9pcnFzdGVlcl9yZW1vdmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiDCoHsNCj4gPiA+IMKgCXN0cnVjdCBpcnFzdGVl
cl9kYXRhICppcnFzdGVlcl9kYXRhID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ID4g
PiArCWludCBpOw0KPiA+ICsNCj4gPiA+ICsJZm9yIChpID0gMDsgaSA8IGlycXN0ZWVyX2RhdGEt
PmlycV9jb3VudDsgaSsrKQ0KPiA+ID4gKwkJaXJxX3NldF9jaGFpbmVkX2hhbmRsZXJfYW5kX2Rh
dGEoaXJxc3RlZXJfZGF0YS0+aXJxW2ldLA0KPiA+ID4gKwkJCQkJCcKgTlVMTCwgTlVMTCk7DQo+
ID4NCj4gPiA+IC0JaXJxX3NldF9jaGFpbmVkX2hhbmRsZXJfYW5kX2RhdGEoaXJxc3RlZXJfZGF0
YS0+aXJxLCBOVUxMLCBOVUxMKTsNCj4gPiA+IMKgCWlycV9kb21haW5fcmVtb3ZlKGlycXN0ZWVy
X2RhdGEtPmRvbWFpbik7DQo+ID4NCj4gPiA+IMKgCWNsa19kaXNhYmxlX3VucHJlcGFyZShpcnFz
dGVlcl9kYXRhLT5pcGdfY2xrKTsNCg==

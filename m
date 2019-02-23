Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9F7C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CA520652
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 03:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qEv4ZsvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfBWDEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 22:04:21 -0500
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:19680
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfBWDEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 22:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXl1XTnPKmtUIBMfvOd9/lHeMuNZ2L0b/XB8cJiXo54=;
 b=qEv4ZsvZICG6Pq4S0txZr5gIX7WfX91Mrb5GIg8tyB8biZr9jhfl/Q7kEoSRRYfeMhwoAYrWL4UcNk2RfvyyA5x6vvChS4ThWaGPwgNCxuWSaqZCKol92HaqLslTpCezG0x4ZVbOhTuN8Dl/Pmqacd2eDskmjadxRZXvUQJ6AKo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3689.eurprd04.prod.outlook.com (52.134.69.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Sat, 23 Feb 2019 03:04:13 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.016; Sat, 23 Feb 2019
 03:04:13 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] clk: imx8mq: initialize clock tree earlier
Thread-Topic: [PATCH 1/3] clk: imx8mq: initialize clock tree earlier
Thread-Index: AQHUypLopgE4RdwU6k2TGErI1f+TZ6XrpOeAgAEOh3A=
Date:   Sat, 23 Feb 2019 03:04:13 +0000
Message-ID: <DB3PR0402MB39163B39C2E45C86FA4B1FA8F5780@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550828264-9962-1-git-send-email-Anson.Huang@nxp.com>
 <66e1685e5cc3fdcaba6ab55b3d030628c37ef8e2.camel@pengutronix.de>
In-Reply-To: <66e1685e5cc3fdcaba6ab55b3d030628c37ef8e2.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 335e1795-5126-4682-82dd-08d6993b9746
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3689;
x-ms-traffictypediagnostic: DB3PR0402MB3689:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjNQUjA0MDJNQjM2ODk7MjM6MkEydUhiMXE2WTY5M2ZEZ2xKR2FyMHJP?=
 =?utf-8?B?Z1BJU2phZXBTK1UrMDFlV1RGSTFHSjgwOWFUa1F1QUJXeHVWSTV5N3BUQ1Bv?=
 =?utf-8?B?TFFHSlNJc21RQ3M0MlZFbDA1OTNOdGZpWEpzd00rRWZjTk4wOEpwMm5qejZu?=
 =?utf-8?B?LzlRdWpldWk2Yys5U2crSDBRTmpJYlFFVHdJajFzaCtSYkJrSklBaHVkVllq?=
 =?utf-8?B?WlNHdHpjYkpKbE5FUklJQVFZVG5IbnpJempvbFpSWFo2QUUxTWRNaUtRakVx?=
 =?utf-8?B?OHJEcm0zbXlpYUVPTkdONk8xMkdaZzh4dThXYnpia0FUaEFqMTlML211c0d4?=
 =?utf-8?B?TTBGOVg3elNmVGlWQVVhQ09QMDJUY25iUURCM3p1cnNuR1A0Rm1UV0hDN0NV?=
 =?utf-8?B?ZUxFbFZ6b3dyZ1BZbDhUVGZtUjZiWEQxMUp0WE1PRzR2b01seTh2djdqdHZN?=
 =?utf-8?B?LzVYejdiY1JxVGlUV1dOK0wzTThiempJN3ZkVFdJa3RlY2g5Z1Y1SVI2VTh6?=
 =?utf-8?B?ai9rRHg0dW9INkVnZlorWUQ4eGw4SEYzYXNwMU9DSk13djdzWEEycDNpYzNW?=
 =?utf-8?B?aUEvN0pmWCtXdGphV2xIRElEdjc5Mi9GVEtYR21Ub0I0WkJubmo5R0F1YXZJ?=
 =?utf-8?B?RitCZE5VSXJINXhKWDB1NXdvRDhIUlFXY0k1Snhadi9LbExUbW55cTVuZFRQ?=
 =?utf-8?B?YTlWR1hpOVdzaWhhU3pzQVRuNDU3a1pnYXhGUzBudFRMNDhlekpBZEFoZCtP?=
 =?utf-8?B?YVNpdURtV1docW9wYWdSeG40anU2OGFuRjh4cFdJRjZ0blRQdEFuVWJ1aXJU?=
 =?utf-8?B?T3VJeXJGZFh6VndacUNFWm5aQXc2Q2xFQk0yRXhaRkZwL2kwMXdackVXTjZo?=
 =?utf-8?B?bHVSdktjMk5zYjNkTldOVU51UCsyZkZRaUtLbVhwcXMvN1RCVXFXQkR6bXAv?=
 =?utf-8?B?SWZVOE1JS0hIck1rU3ZidDRwdUVsMG5ZTlE2NVgwKzhsb0M5ZEFBQk1XQmEz?=
 =?utf-8?B?Ymh2bkdsMVVmQlBscnhFQ2gwZFU0M3o5NjFUc1VKYlczR1B3WXlPTEVzMHdh?=
 =?utf-8?B?Y2VsckJaaThwQWhzMElVSW5IenVlbTdPQVlXT1pDSFdtM1EwOUYyU0hvVWxH?=
 =?utf-8?B?blRlTkRGWW5FN3lBMTFjMStwMnh5VkQzemhqcTVLVUltOWRrNDU3R29aWnl3?=
 =?utf-8?B?K1NpRUlJOHh0TEM3cE82dUFnbGp5UFlZNEkreXVNN0l4aUtjV1hkNGYvdVpY?=
 =?utf-8?B?VHVobzVsaVYvRnRicTUzUXZqQnhac0RrbjcwdURsUk1tdXc2ZnBzL3lkYmRC?=
 =?utf-8?B?UngxV3h5VHk0R1F3VmFPREpOTWN0dHZkMHZMU0kvUWdXOU1zVTYyb1NQOTZV?=
 =?utf-8?B?ZWFuYWVFMTBYdW9DdXVwRFJxQ3Rweitib3BMUEkwNzlSamtQNVVCVFdaditU?=
 =?utf-8?B?SVY3Z0hlRTdaRDRPRmE5WmQwSTNXUzhpb25PRFdmRzJxMGZQcVNSSDFUY2Nw?=
 =?utf-8?B?MHlob0JrTEMzNE9xOGlEOFZWZExMdXc3bDVaMVRxaFlPeGQxTVJJNURnT2Jw?=
 =?utf-8?B?eXU1ZE1sSzhYRWFsS3RLUEROWUcwTDYzVUJpaWw0NnRYb1Z6MmZOTTlvVS9o?=
 =?utf-8?B?NmlMLzVnN2N2STJxRWdFWUYxdXJOd2JGbFJzUWlHdmdEMURQdUFsMWZEZTNH?=
 =?utf-8?B?RVJjUkNUdklJNllIZjZNbFNiRXM0ZG8vY1NVdmtkamljSmtMcWZtZkoxS3BG?=
 =?utf-8?B?b0k4ZFVRZlp6Yjl1ZWNYekFuY2dodzgrb3NtcjJPcmQzeXIwZlZ0VDJMZ2xu?=
 =?utf-8?B?aHpkWmJTMTIvcUEycHp3Y0U4a0NNc2tDK25Tb05ML1FqNS9tdHpOMU41d1pV?=
 =?utf-8?Q?4phXykCB0JZ30=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3689A76F06087C58C1F0C561F5780@DB3PR0402MB3689.eurprd04.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(396003)(346002)(199004)(189003)(13464003)(8676002)(305945005)(5660300002)(81156014)(81166006)(86362001)(25786009)(478600001)(71200400001)(44832011)(71190400001)(7736002)(486006)(33656002)(6116002)(3846002)(66066001)(2201001)(14454004)(52536013)(8936002)(74316002)(256004)(2501003)(110136005)(68736007)(99286004)(229853002)(446003)(53546011)(6506007)(186003)(76176011)(26005)(11346002)(106356001)(316002)(102836004)(55016002)(2906002)(476003)(53936002)(9686003)(7416002)(105586002)(4326008)(6436002)(97736004)(6246003)(7696005)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3689;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XtSr5KML5JHhBO/f5lbh764WK2JoKI35PorquWraNYmWVFPL9M1FiyRy+8NgZasca8uBDj850ubl5s7r5TRMWYbMAaAFiXPshN7RLqEYRyQV9IwFI3sBhGBfjQORieeESp1Ib3re2ohgojs0By09AKBIKj/nJ0Pu5zVuCtTHcFa9QVoEYvA+knpQHSjtWACRHDxoHREeJEWZ29M8o1dxxCDbvoUJN9hpf7OsYPbf2F89Qr0GJlUwzyy21aj1py4SpqvWX2Di0yJe1rfQmFe7oF3wxrdNKxx3pe54dGnNnxMHBVguRe+XKiw8nYYEoWd/il2H8iyrrpPO5Yu97yrdqFYnEF3O5WrmG+1B1yZkaRu7fs0Ugac6BiDVNkLlTVTjytdwN7kg4XKsw9HVQZRpPcukFeSIlDD0N6xRBO2UmcY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335e1795-5126-4682-82dd-08d6993b9746
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 03:04:13.8433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3689
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEx1Y2FzDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVjYXMgU3RhY2ggW21haWx0bzpsLnN0YWNoQHBlbmd1
dHJvbml4LmRlXQ0KPiBTZW50OiAyMDE55bm0MuaciDIy5pelIDE4OjU1DQo+IFRvOiBBbnNvbiBI
dWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gbWFyay5y
dXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBtdHVycXVl
dHRlQGJheWxpYnJlLmNvbTsNCj4gc2JveWRAa2VybmVsLm9yZzsgQWJlbCBWZXNhIDxhYmVsLnZl
c2FAbnhwLmNvbT47IGNjYWlvbmVAYmF5bGlicmUuY29tOw0KPiBhZ3hAc2lneGNwdS5vcmc7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gY2xrQHZn
ZXIua2VybmVsLm9yZw0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGNsazogaW14OG1xOiBpbml0aWFsaXplIGNsb2NrIHRy
ZWUgZWFybGllcg0KPiANCj4gQW0gRnJlaXRhZywgZGVuIDIyLjAyLjIwMTksIDA5OjQyICswMDAw
IHNjaHJpZWIgQW5zb24gSHVhbmc6DQo+ID4gQ3VycmVudGx5IG9uIGkuTVg4TVEgcGxhdGZvcm0s
IGNsb2NrIGRyaXZlciBpcyBwcm9iZWQgbGF0ZXIgdGhhbiBHUElPDQo+ID4gZHJpdmVyLCBhbmQg
R1BJTyBkcml2ZXIgZG9lcyBOT1QgaGF2ZSBkZWZlciBwcm9iZSBtZWNoYW5pc20gc2luY2UgdGhl
DQo+ID4gR1BJTyBjbG9jayBpcyBvcHRpb25hbCwNCj4gDQo+IFNvIHRoaXMgaXMgd2hhdCBzaG91
bGQgYmUgZml4ZWQuIElmIHRoZXJlIGlzIGEgY2xvY2sgcmVmZXJlbmNlIGluIHRoZSBEVCwgaGF2
aW5nDQo+IHRoZSBjbG9jayBkcml2ZXIgcmVhZHkgaXMgbm90IG9wdGlvbmFsLiBPcHRpb25hbCB0
byB0aGUgR1BJTyBkcml2ZXIganVzdCBtZWFucw0KPiBpdCB3b24ndCBmYWlsIGlmIHRoZXJlIGlz
IG5vIGNsb2NrIHJlZmVyZW5jZSBhdCBhbGwuDQo+IElmIHRoZXJlIGlzIGFuZCB0aGUgY2xvY2sg
cHJvdmlkZXIgaXMgbm90IHlldCB0aGVyZSwgaXQgbmVlZHMgdG8gZG8gYQ0KPiBQUk9CRV9ERUZF
Ui4NCj4gDQo+IFNvIHRoYXQncyBhIE5BQ0sgb24gdGhpcyBwYXRjaC4NCg0KT0ssIEkgc2VlLiBU
aGVuIEkgd2lsbCBkbyBhIHBhdGNoIGZvciBHUElPIGRyaXZlciwgYW5kIEkganVzdCBjaGVjayBv
dGhlciBkcml2ZXJzLCBsb29rcw0KbGlrZSBpbXgyIHdhdGNoZG9nIGRyaXZlciBhbHNvIGhhcyBz
aW1pbGFyIGlzc3VlLCBJIHdpbGwgZG8gYSBwYXRjaCB0b28uDQoNClRoYW5rcywNCkFuc29uLg0K
DQo+IA0KPiBSZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4gPiBzb21lIHBsYXRmb3JtcyBoYXZlIEdQ
SU8gY2xvY2tzIGFuZCBzb21lIGFyZSBOT1QuIFNvIGl0IGlzIGFuIGlzc3VlDQo+ID4gdGhhdCBv
biBpLk1YOE1RIHBsYXRmb3JtLCB0aGVyZSBhcmUgR1BJTyBjbG9ja3MgZGVmaW5lZCwgYnV0IGR1
ZSB0bw0KPiA+IGNsb2NrIHRyZWUgaXMgTk9UIHJlYWR5IGR1cmluZyBHUElPIGRyaXZlciBwcm9i
ZSwgdGhlIEdQSU8gY2xvY2sNCj4gPiBtYW5hZ2VtZW50IHdpbGwgZmFpbCBhbmQgY2F1c2Ugc3lz
dGVtIGhhbmcgaWYgR1BJTyBjbG9ja3MgYXJlIE9GRiBieQ0KPiA+IGRlZmF1bHQuDQo+ID4NCj4g
PiBUaGlzIHBhdGNoIGNoYW5nZXMgdGhlIGkuTVg4TVEgY2xvY2sgdHJlZSBpbml0aWFsaXphdGlv
biB1c2luZw0KPiA+IENMS19PRl9ERUNMQVJFIGluc3RlYWQgb2YgcGxhdGZvcm0gZHJpdmVyIG1v
ZGVsIHRvIG1ha2UgY2xvY2sgdHJlZQ0KPiA+IHJlYWR5IGVhcmxpZXIgdGhhbiBHUElPIGRyaXZl
ci4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcS5jIHwgMzMgKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2xrL2lteC9jbGstaW14OG1xLmMgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLQ0KPiA+IGlteDht
cS5jIGluZGV4IDI2YjU3ZjQuLjJkZjE1NzUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsv
aW14L2Nsay1pbXg4bXEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OG1xLmMN
Cj4gPiBAQCAtMjY5LDEwICsyNjksOSBAQCBzdGF0aWMgY29uc3QgY2hhciAqaW14OG1xX2Nsa28y
X3NlbHNbXSA9DQo+ID4geyJvc2NfMjVtIiwgInN5czJfcGxsXzIwMG0iLCAic3lzMV9wbGxfDQo+
ID4NCj4gPiAgc3RhdGljIHN0cnVjdCBjbGtfb25lY2VsbF9kYXRhIGNsa19kYXRhOw0KPiA+DQo+
ID4gLXN0YXRpYyBpbnQgaW14OG1xX2Nsb2Nrc19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiA+ICtzdGF0aWMgdm9pZCBfX2luaXQgaW14OG1xX2Nsb2Nrc19pbml0KHN0cnVj
dCBkZXZpY2Vfbm9kZSAqbnApDQo+ID4gIHsNCj4gPiAtCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZw
ZGV2LT5kZXY7DQo+ID4gLQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0K
PiA+ICsJc3RydWN0IGRldmljZV9ub2RlICphbmF0b3BfbnA7DQo+ID4gIAl2b2lkIF9faW9tZW0g
KmJhc2U7DQo+ID4gIAlpbnQgZXJyOw0KPiA+ICAJaW50IGk7DQo+ID4gQEAgLTI4NiwxMCArMjg1
LDEwIEBAIHN0YXRpYyBpbnQgaW14OG1xX2Nsb2Nrc19wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ID4gIAljbGtzW0lNWDhNUV9DTEtfRVhUM10gPSBvZl9jbGtfZ2V0
X2J5X25hbWUobnAsICJjbGtfZXh0MyIpOw0KPiA+ICAJY2xrc1tJTVg4TVFfQ0xLX0VYVDRdID0g
b2ZfY2xrX2dldF9ieV9uYW1lKG5wLCAiY2xrX2V4dDQiKTsNCj4gPg0KPiA+IC0JbnAgPSBvZl9m
aW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAiZnNsLGlteDhtcS1hbmF0b3AiKTsNCj4g
PiAtCWJhc2UgPSBvZl9pb21hcChucCwgMCk7DQo+ID4gKwlhbmF0b3BfbnAgPSBvZl9maW5kX2Nv
bXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLCAiZnNsLGlteDhtcS0NCj4gPiBhbmF0b3AiKTsNCj4g
PiArCWJhc2UgPSBvZl9pb21hcChhbmF0b3BfbnAsIDApOw0KPiA+ICAJaWYgKFdBUk5fT04oIWJh
c2UpKQ0KPiA+IC0JCXJldHVybiAtRU5PTUVNOw0KPiA+ICsJCXJldHVybjsNCj4gPg0KPiA+ICAJ
Y2xrc1tJTVg4TVFfQVJNX1BMTF9SRUZfU0VMXSA9IGlteF9jbGtfbXV4KCJhcm1fcGxsX3JlZl9z
ZWwiLA0KPiBiYXNlICsNCj4gPiAweDI4LCAxNiwgMiwgcGxsX3JlZl9zZWxzLCBBUlJBWV9TSVpF
KHBsbF9yZWZfc2VscykpOw0KPiA+ICAJY2xrc1tJTVg4TVFfR1BVX1BMTF9SRUZfU0VMXSA9IGlt
eF9jbGtfbXV4KCJncHVfcGxsX3JlZl9zZWwiLA0KPiBiYXNlICsNCj4gPiAweDE4LCAxNiwgMiwg
cGxsX3JlZl9zZWxzLCBBUlJBWV9TSVpFKHBsbF9yZWZfc2VscykpOyBAQCAtMzg5LDEwDQo+ID4g
KzM4OCw5IEBAIHN0YXRpYyBpbnQgaW14OG1xX2Nsb2Nrc19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiA+ICAJY2xrc1tJTVg4TVFfU1lTMl9QTExfNTAwTV0gPQ0KPiA+IGlt
eF9jbGtfZml4ZWRfZmFjdG9yKCJzeXMyX3BsbF81MDBtIiwgInN5czJfcGxsX291dCIsIDEsIDIp
Ow0KPiA+ICAJY2xrc1tJTVg4TVFfU1lTMl9QTExfMTAwME1dID0NCj4gPiBpbXhfY2xrX2ZpeGVk
X2ZhY3Rvcigic3lzMl9wbGxfMTAwMG0iLCAic3lzMl9wbGxfb3V0IiwgMSwgMSk7DQo+ID4NCj4g
PiAtCW5wID0gZGV2LT5vZl9ub2RlOw0KPiA+ICAJYmFzZSA9IG9mX2lvbWFwKG5wLCAwKTsNCj4g
PiAgCWlmIChXQVJOX09OKCFiYXNlKSkNCj4gPiAtCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArCQly
ZXR1cm47DQo+ID4NCj4gPiAgCS8qIENPUkUgKi8NCj4gPiAgCWNsa3NbSU1YOE1RX0NMS19BNTNf
U1JDXSA9IGlteF9jbGtfbXV4MigiYXJtX2E1M19zcmMiLCBiYXNlICsNCj4gPiAweDgwMDAsIDI0
LCAzLCBpbXg4bXFfYTUzX3NlbHMsIEFSUkFZX1NJWkUoaW14OG1xX2E1M19zZWxzKSk7IEBADQo+
ID4gLTU2OCwyMiArNTY2LDUgQEAgc3RhdGljIGludCBpbXg4bXFfY2xvY2tzX3Byb2JlKHN0cnVj
dA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPg0KPiA+ICAJZXJyID0gb2ZfY2xrX2Fk
ZF9wcm92aWRlcihucCwgb2ZfY2xrX3NyY19vbmVjZWxsX2dldCwgJmNsa19kYXRhKTsNCj4gPiAg
CVdBUk5fT04oZXJyKTsNCj4gPiAtDQo+ID4gLQlyZXR1cm4gZXJyOw0KPiA+ICB9DQo+ID4gLQ0K
PiA+IC1zdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBpbXg4bXFfY2xrX29mX21hdGNo
W10gPSB7DQo+ID4gLQl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4bXEtY2NtIiB9LA0KPiA+IC0J
eyAvKiBTZW50aW5lbCAqLyB9LA0KPiA+IC19Ow0KPiA+IC1NT0RVTEVfREVWSUNFX1RBQkxFKG9m
LCBpbXg4bXFfY2xrX29mX21hdGNoKTsNCj4gPiAtDQo+ID4gLQ0KPiA+IC1zdGF0aWMgc3RydWN0
IHBsYXRmb3JtX2RyaXZlciBpbXg4bXFfY2xrX2RyaXZlciA9IHsNCj4gPiAtCS5wcm9iZSA9IGlt
eDhtcV9jbG9ja3NfcHJvYmUsDQo+ID4gLQkuZHJpdmVyID0gew0KPiA+IC0JCS5uYW1lID0gImlt
eDhtcS1jY20iLA0KPiA+IC0JCS5vZl9tYXRjaF90YWJsZSA9IG9mX21hdGNoX3B0cihpbXg4bXFf
Y2xrX29mX21hdGNoKSwNCj4gPiAtCX0sDQo+ID4gLX07DQo+ID4gLW1vZHVsZV9wbGF0Zm9ybV9k
cml2ZXIoaW14OG1xX2Nsa19kcml2ZXIpOw0KPiA+ICtDTEtfT0ZfREVDTEFSRShpbXg4bXEsICJm
c2wsaW14OG1xLWNjbSIsIGlteDhtcV9jbG9ja3NfaW5pdCk7DQoNCg==

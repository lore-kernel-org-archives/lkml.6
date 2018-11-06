Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E507C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E727120827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UKea98Q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E727120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbeKFSg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:36:56 -0500
Received: from mail-eopbgr40077.outbound.protection.outlook.com ([40.107.4.77]:60236
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729160AbeKFSg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnAoO/CR5CIopiFYVxopZhkJSkiRPuEO5IfFF1Tjto8=;
 b=UKea98Q0q8KY2ABpGiJjScmGjH4cZAgAAC5c3jpSY9ynSC5Ddj2aV45M/p0ulxLX90dkCJ8+ViwXPvlyyZYUXBnjwkxjwfjg+CexZThUYiX5ZhhObndT/cNtHxr1lssRJej/IbD3IlCZmFbivpVR3O/ESIh+Wqm2LnQXKAd2TYY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3691.eurprd04.prod.outlook.com (52.134.66.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.24; Tue, 6 Nov 2018 09:12:37 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 09:12:37 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/2] clocksource: imx-gpt: add necessary kfree to avoid
 resource leak
Thread-Topic: [PATCH V2 2/2] clocksource: imx-gpt: add necessary kfree to
 avoid resource leak
Thread-Index: AQHUdKRXRzpml7CMi0WCytiW4+vPCaVBL1QAgADJ7TCAAH1ZgIAAACKA
Date:   Tue, 6 Nov 2018 09:12:37 +0000
Message-ID: <DB3PR0402MB3916F404D1225F1A00808197F5CB0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1541379930-14538-1-git-send-email-Anson.Huang@nxp.com>
 <1541379930-14538-2-git-send-email-Anson.Huang@nxp.com>
 <dea51d27-0957-f762-773f-e0e0e001045c@linaro.org>
 <DB3PR0402MB39161E47E47937FDB8046B6EF5CB0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <d811ef14-ec53-3422-b747-7df0c1ce360d@linaro.org>
In-Reply-To: <d811ef14-ec53-3422-b747-7df0c1ce360d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3691;6:PHWH4KWuISbKNySWDu4PTdwBfBEOUI4KgAkVY4NZBISMUPBr4fKX/ezcin0yZGdNZw5WnQfNy9OxZxPvp30ckmJg0G00PgUONII7A6te7F8P4wldtcc/b7U5+2YDL7G3hYllYpckDJsHeSF2aBfbzcDG3Vf+nx5vzkmN/g7I9RUTxjC4aNItxCK/zvdXcWyV9O+x8bQLWRBvYaG5SEgA9cwGPe5DshN+A2x8BNbNNOQyDTY+gQITAWv2zySRHh0QZi80Bxcx7oCZomW7b6R+tCd9i+26+EwZEpF0xfibF/v/69nMVBGKM/D1i7JCLZ48LKLEJEiIzLFCPFxXQtIUEPZ/u8PUeX/FBn0FBeKUDWB+VnDwnpLpr4D3BlfkDDjiYx6TdIoqF7MWEg7Yf4rgycpVe/95AS+xBL71a9eWXZPnegUSOEcv5Z1kPOuimWpPnlY6hDICp/l4icCQY2uNQQ==;5:mPVeIr5x0Sw1h1GmMfKVfpt3mGBxwkat6etTBjwbk59Ch1WTrGiYFtp+S3qpuE+B835YiV3QYY6GUsbB26O5AN8M3K+SVyUIJCnG093oYaPwHe4CVrRHnC2CEOw6VaC1Tfp47yqp+2XmlTjjkAjUxNDXgXwzM1pPVg63eYcQfh4=;7:Zc0PawIwG0eJB8hXo7P95OiNLK99/P45+/rfh2Iz7g73vWDd35iRUKLJKjmKSks5WxoC7MluP8gAtgUAgXETHqiOhJwRcQ8H6gjw9gVU2ya/XS1rcpxZ6lXC4w1rf4TYYNA0yerUOivsFTre+ToJtg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 115af706-c21e-4dee-6e46-08d643c7fed0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3691;
x-ms-traffictypediagnostic: DB3PR0402MB3691:
x-microsoft-antispam-prvs: <DB3PR0402MB36917D44FFD77B75ADE3EA27F5CB0@DB3PR0402MB3691.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(64217206974132)(185117386973197)(81227570615382)(148322886591682)(45079756050767)(189930954265078);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3691;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3691;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(366004)(136003)(13464003)(199004)(189003)(66066001)(55016002)(110136005)(2900100001)(106356001)(446003)(186003)(2501003)(316002)(4326008)(478600001)(53936002)(6306002)(7736002)(68736007)(99286004)(5660300001)(97736004)(305945005)(6246003)(74316002)(71190400001)(476003)(11346002)(105586002)(26005)(2906002)(229853002)(8676002)(3846002)(8936002)(6116002)(14454004)(71200400001)(9686003)(44832011)(33656002)(7696005)(102836004)(575784001)(2201001)(76176011)(256004)(14444005)(86362001)(6436002)(6506007)(53546011)(81156014)(25786009)(93886005)(81166006)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3691;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: r/cj5Uk9z71XY/IGi/X4t1L3dVVGQcVUFmvo1xo+3VD5Ul1XAXrbM0ywo39uwMmj6nfmz/hAN2aELQnnrTT41MI8qIWrdMIdgFIWGwFzQgxheWO43jEAfQwwqFvZ9nfZc+7wmmnOe8+cOZJwH2Rb61Y0ppnPqWgdn0lUfTjtW5+6xc6WBqRqxkkvFsUggsavsESjZAvU8VBulfmWzHC1/l89ksZddwqBUfBZusUodJpQLJck0+fwCJyeNcHRIERQPyHKbx4M7rOgDJwCR/kmiptC3+olWQSpPLawbhS+ipHiyICR8K4jpTSPewxHvZrIaXLsJxIBzoTJE6fJrrE1iHudBv1E23Tv6ojiJeRNMIo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115af706-c21e-4dee-6e46-08d643c7fed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 09:12:37.1191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3691
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbA0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmllbCBMZXpjYW5vIFttYWlsdG86ZGFuaWVsLmxl
emNhbm9AbGluYXJvLm9yZ10NCj4gU2VudDogMjAxOOW5tDEx5pyINuaXpSAxNzowNg0KPiBUbzog
QW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgt
aW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjIgMi8yXSBjbG9ja3NvdXJjZTog
aW14LWdwdDogYWRkIG5lY2Vzc2FyeSBrZnJlZSB0byBhdm9pZA0KPiByZXNvdXJjZSBsZWFrDQo+
IA0KPiANCj4gSGkgQW5zb24sDQo+IA0KPiBPbiAwNi8xMS8yMDE4IDAyOjM4LCBBbnNvbiBIdWFu
ZyB3cm90ZToNCj4gPiBIaSwgRGFuaWVsDQo+ID4NCj4gPiBCZXN0IFJlZ2FyZHMhDQo+ID4gQW5z
b24gSHVhbmcNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9t
OiBEYW5pZWwgTGV6Y2FubyBbbWFpbHRvOmRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmddDQo+ID4+
IFNlbnQ6IDIwMTjlubQxMeaciDXml6UgMjE6MzUNCj4gPj4gVG86IEFuc29uIEh1YW5nIDxhbnNv
bi5odWFuZ0BueHAuY29tPjsgdGdseEBsaW51dHJvbml4LmRlOw0KPiA+PiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+ID4+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29t
Pg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDIvMl0gY2xvY2tzb3VyY2U6IGlteC1ncHQ6
IGFkZCBuZWNlc3Nhcnkga2ZyZWUNCj4gPj4gdG8gYXZvaWQgcmVzb3VyY2UgbGVhaw0KPiA+Pg0K
PiA+PiBIaSBBbnNvbiwNCj4gPj4NCj4gPj4gT24gMDUvMTEvMjAxOCAwMjoxMCwgQW5zb24gSHVh
bmcgd3JvdGU6DQo+ID4+PiBrZnJlZSBzaG91bGQgYmUgY2FsbGVkIHRvIGZyZWUgcmVzb3VyY2Ug
aW4gZXJyb3IgcGF0aCBiZWZvcmUgcmV0dXJuLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6
IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgZHJp
dmVycy9jbG9ja3NvdXJjZS90aW1lci1pbXgtZ3B0LmMgfCA4ICsrKysrKy0tDQo+ID4+PiAgMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1pbXgtZ3B0LmMNCj4gPj4+
IGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1pbXgtZ3B0LmMNCj4gPj4+IGluZGV4IGEzZDZj
Y2IuLjBmNzhiMzAgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3RpbWVy
LWlteC1ncHQuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1pbXgtZ3B0
LmMNCj4gPj4+IEBAIC00NzcsMTIgKzQ3NywxNiBAQCBzdGF0aWMgaW50IF9faW5pdCBteGNfdGlt
ZXJfaW5pdF9kdChzdHJ1Y3QNCj4gPj4gZGV2aWNlX25vZGUgKm5wLCAgZW51bSBpbXhfZ3B0X3R5
cGUgdA0KPiA+Pj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ID4+Pg0KPiA+Pj4gIAlpbXh0bS0+YmFz
ZSA9IG9mX2lvbWFwKG5wLCAwKTsNCj4gPj4+IC0JaWYgKCFpbXh0bS0+YmFzZSkNCj4gPj4+ICsJ
aWYgKCFpbXh0bS0+YmFzZSkgew0KPiA+Pj4gKwkJa2ZyZWUoaW14dG0pOw0KPiA+Pj4gIAkJcmV0
dXJuIC1FTlhJTzsNCj4gPj4+ICsJfQ0KPiA+Pj4NCj4gPj4+ICAJaW14dG0tPmlycSA9IGlycV9v
Zl9wYXJzZV9hbmRfbWFwKG5wLCAwKTsNCj4gPj4+IC0JaWYgKGlteHRtLT5pcnEgPD0gMCkNCj4g
Pj4+ICsJaWYgKGlteHRtLT5pcnEgPD0gMCkgew0KPiA+Pj4gKwkJa2ZyZWUoaW14dG0pOw0KPiA+
Pj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4+PiArCX0NCj4gPj4+DQo+ID4+PiAgCWlteHRtLT5j
bGtfaXBnID0gb2ZfY2xrX2dldF9ieV9uYW1lKG5wLCAiaXBnIik7DQo+ID4+DQo+ID4+IFBsZWFz
ZSBjb252ZXJ0IHRvIHRpbWVyLW9mIEFQSS4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggbWFpbmx5IHRv
IGZpeCB0aGUgcG90ZW50aWFsIHJlc291cmNlIGxlYWsgaXNzdWUsIGZvcg0KPiA+IGNvbnZlcnRp
bmcgdG8gdGltZXItb2YgQVBJLCBzaG91bGQgSSBhZGQgYW5vdGhlciBwYXRjaCBmb3IgaXQ/IFNp
bmNlDQo+ID4gaXQgaXMgYSBkaWZmZXJlbnQgc3ViamVjdC4NCj4gDQo+IEFjdHVhbGx5IEkgd2Fz
IHVuY2xlYXIuIFRoZSBwYXRjaCBpcyBkdXBsaWNhdGluZyB0aGUga2ZyZWUgaW4gdGhlIGVycm9y
IHBhdGgsDQo+IHVzdWFsbHkgYSByb2xsYmFjayByb3V0aW5lIHNob3VsZCBiZSBwcm92aWRlZC4N
Cj4gDQo+IFNvIGluc3RlYWQgb2YgY3JlYXRpbmcgdGhpcyByb2xsYmFjayBwYXRoLCB5b3UgY2Fu
IGRpcmVjdGx5IHVzZSB0aGUgdGltZXItb2YNCj4gd2hpY2ggY29udGFpbnMgdGhlIGVycm9yIGNo
ZWNrIGFuZCByb2xsYmFjay4NCg0KSSB1bmRlcnN0YW5kIHRoZSB0aW1lci1vZiBjYW4gc2F2ZSBz
b21lIGNvZGUgaW4gdGltZXIgZHJpdmVyLCBidXQgY3VycmVudCBHUFQNCmRyaXZlciBpcyBraW5k
IG9mIGNvbXBsaWNhdGVkIGluIG9yZGVyIHRvIHN1cHBvcnQgc28gbWFueSBpLk1YIHBsYXRmb3Jt
cyB3aXRoDQpkaWZmZXJlbnQgR1BUIGRlc2lnbiwgY2hhbmdlIGl0IHRvIHRpbWVyLW9mIHdpbGwg
bmVlZCBzb21lIGVmZm9ydCBhbmQgSSB0aGluayB3ZQ0KY2FuIGRvIGl0IGxhdGVyLiBJZiB0aGUg
ZHVwbGljYXRpbmcga2ZyZWUgaW4gZXJyb3IgcGF0aCBjb25mdXNlcyB5b3UsIEkgY2FuIGNoYW5n
ZQ0KaXQgdG8gcm9sbGJhY2sgcGF0aCB5b3Ugc2FpZC4gQmVsb3cgYXJlIDIgb3B0aW9ucyBpbiBt
eSBtaW5kOg0KDQoxLiBhZGQga2ZyZWUgdG8gcm9sbGJhY2sgcGF0aDsNCjIuIHNraXAgdGhpcyBw
YXRjaCwganVzdCBhcHBseSAxLzIgcGF0Y2gsIGFuZCBsZXQgbWUgZmluZCBzb21lIHRpbWUgdG8g
Y2hhbmdlIEdQVA0KZHJpdmVyIHVzaW5nIHRpbWVyLW9mLiANCg0KV2hpY2ggb25lIGRvIHlvdSBw
cmVmZXI/IFRoYW5rcy4NCg0KQW5zb24uDQoNCj4gDQo+IA0KPiANCj4gLS0NCj4gDQo+IDxodHRw
czovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAlM0El
MkYlMkZ3d3cNCj4gLmxpbmFyby5vcmclMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q2Fuc29uLmh1YW5n
JTQwbnhwLmNvbSU3Q2M2NzViYg0KPiBiMjA2M2I0M2MzYmUxNTA4ZDY0M2M3MTVmMyU3QzY4NmVh
MWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTcNCj4gQzAlN0MwJTdDNjM2NzcwOTE5NjkyNDc1
NDA4JmFtcDtzZGF0YT1wSGFOJTJCQmd1UW8ybG1WSnpMWVhCSg0KPiAxMmw2RHdYJTJCeFNYbzlC
aWw5U3dZeHMlM0QmYW1wO3Jlc2VydmVkPTA+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlDQo+
IHNvZnR3YXJlIGZvciBBUk0gU29Dcw0KPiANCj4gRm9sbG93IExpbmFybzoNCj4gPGh0dHBzOi8v
ZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUy
Rnd3dw0KPiAuZmFjZWJvb2suY29tJTJGcGFnZXMlMkZMaW5hcm8mYW1wO2RhdGE9MDIlN0MwMSU3
Q2Fuc29uLmh1YW5nJTQwDQo+IG54cC5jb20lN0NjNjc1YmJiMjA2M2I0M2MzYmUxNTA4ZDY0M2M3
MTVmMyU3QzY4NmVhMWQzYmMyYjRjNmZhOQ0KPiAyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2
NzcwOTE5NjkyNDc1NDA4JmFtcDtzZGF0YT1FZ3lhZE5VDQo+IEExWExuY041cDkwbGtJSWlpTWdR
MENJTzQwNWJpTHBLc3p2RSUzRCZhbXA7cmVzZXJ2ZWQ9MD4gRmFjZWJvb2sgfA0KPiA8aHR0cHM6
Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJG
JTJGdHdpdHQNCj4gZXIuY29tJTJGJTIzISUyRmxpbmFyb29yZyZhbXA7ZGF0YT0wMiU3QzAxJTdD
YW5zb24uaHVhbmclNDBueHAuYw0KPiBvbSU3Q2M2NzViYmIyMDYzYjQzYzNiZTE1MDhkNjQzYzcx
NWYzJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOQ0KPiA5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY3
NzA5MTk2OTI0NzU0MDgmYW1wO3NkYXRhPU5JZ1FoQVBaQmg5DQo+IGpLY3J2TnJFWTAwNXBacExa
UDhwV0lWbEtYc2xRJTJCNVUlM0QmYW1wO3Jlc2VydmVkPTA+IFR3aXR0ZXIgfA0KPiA8aHR0cHM6
Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJG
JTJGd3d3DQo+IC5saW5hcm8ub3JnJTJGbGluYXJvLWJsb2clMkYmYW1wO2RhdGE9MDIlN0MwMSU3
Q2Fuc29uLmh1YW5nJTQwbnhwLmMNCj4gb20lN0NjNjc1YmJiMjA2M2I0M2MzYmUxNTA4ZDY0M2M3
MTVmMyU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDkNCj4gOWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2
NzcwOTE5NjkyNDc1NDA4JmFtcDtzZGF0YT1NQ0JoOWRKYmpODQo+IEd0SzZWcHNqM0VmckY3T0dC
UkFhd0EzamtDbVpwZ20wSSUzRCZhbXA7cmVzZXJ2ZWQ9MD4gQmxvZw0KDQo=

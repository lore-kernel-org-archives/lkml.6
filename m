Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDB1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 05:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C5F20840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 05:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f0r+IGfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C5F20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbeKIOkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 09:40:08 -0500
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]:47744
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727474AbeKIOkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 09:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyW/iggt1+pg9LW+vprDXJkyb9GIJks1vhkWAWYk2MU=;
 b=f0r+IGfE/OCTv0kdK3RC/tOpTqAtaQJ1Gqk1MgrMWO4ZRexToAnL49XCDbVIEVxeLOfFBIcpAMmD3Ctk6KBI2FgcorcoFF63MkQvkhFF1Dy37waf34imEqlLM2RD8T5VSrluaQsfxund0fCDcwDwHjNicC+u7CoJXSSvAg0flD4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3772.eurprd04.prod.outlook.com (52.134.71.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 05:01:12 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 05:01:12 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] gpio: mxc: skip GPIO_IMR restore in noirq resume
Thread-Topic: [PATCH] gpio: mxc: skip GPIO_IMR restore in noirq resume
Thread-Index: AQHUd1FN9Aj/AynheEG8YjCH4WLcU6VG4rmQ
Date:   Fri, 9 Nov 2018 05:01:12 +0000
Message-ID: <DB3PR0402MB39160977196DBEA775A4AFCEF5C60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1541674114-843-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1541674114-843-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3772;6:iJoos9ieSJpf9p3JHWmFVmaFyQuG/BLde0sElkL2Gtwf2/F2Azlk/I54PrWHnf4Q5rRjD8TgI1cKgt1MFHZ7Sp0Ffqq6S9CoTOkZddVDBolN+5Wv34m9DkVbh/5P3016/uuIJUflytq3FeYCal/GTqmt9YeKpp9SB6kZtxVdrqHegu7fOzwOm6w+ySrnItIxSy7pZs1vteaXNlWkQwoDvcdyFLHiskayLgg2vojnvZVfN4QhaifZ4N6uwSTW/lfrtyNb5zDJWxgOz1D4VKbnpvdgSpZiLLI+NBYpHtRwNodZPiWX2vCO2euDzBFOsWol9cUq3V1tqvqzVk4bQ0sGEph9WklSOQQCiRrgiOSswCVjXzh3Pd3NP1hfy4VfbwdlehIy3LTNtJAohD9TROa2zC3zg0DpiNIJ5EQm41ufYGQBVs56T3NGbOjvLCr1d7s9lM2kcgEx6eaWkNBfd2wcuw==;5:XiYPztA/17xaAR0T0bRxn45yB1Emuo18rG1kUq3XIxrqkfFrAdfoj+5VUCqnzBEZFr51jWSJOe+LEg3YpuewS0UWalQF5XdCpo71JYOxDQz0j9dDXL3Sj6xJWRi3k1Bwza4XKlKlk1P0yQIuCFVRwqQ3oTIXxdOpZwDCZGmvB8g=;7:S0xlnu541w+2LQ2YJdssI4QHI0ZBzKewtvNoBHcDUGjCUSP5lLsErO5ec1YFl5QEFDR+JTgjNRI2fPgoTOOw7ERZkQPTCDJZDRC+UA91Az30sO3tPnO8EV3rmG4lX2idvk3HH6bpoznXnUmYvsXPhA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d0d9e99a-926a-4d72-d59b-08d646005ed6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3772;
x-ms-traffictypediagnostic: DB3PR0402MB3772:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB3772CFD9BF7B48BB5AB20927F5C60@DB3PR0402MB3772.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(105169848403564)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231382)(944501410)(52105095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3772;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3772;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(366004)(39860400002)(13464003)(199004)(189003)(81166006)(53546011)(7736002)(9686003)(446003)(486006)(11346002)(305945005)(6436002)(4326008)(476003)(33656002)(25786009)(186003)(74316002)(55016002)(99286004)(6246003)(102836004)(14454004)(44832011)(5660300001)(76176011)(53936002)(26005)(2501003)(6506007)(7696005)(66066001)(14444005)(256004)(8936002)(229853002)(2906002)(71190400001)(71200400001)(106356001)(97736004)(105586002)(478600001)(110136005)(8676002)(2201001)(68736007)(2900100001)(81156014)(316002)(86362001)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3772;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FrE5/M1BgZPhk5j7lms/Bvp2GdPfcva2IX/lVNC6NT5SME2MYUleXzpuP/08jHV0sku9jkEz0yHP4lAV2PFjtGjyqzfj1CryqdtoHkpmMZ38OkuALFOdSvmnFVXUonHRJfIexm2EIhcdqNU2hrNdT2TOUB2wOnn2wEV6DNU8T03hDq6P4tu30E9sHpazsKXvuyNRt9vRIC5OUH+gxIJ2iK9fdYkSiocdCCJ0D9EF9hsOLCEEwtBk05vfcvtiVk868KDhprYZUyzAcddTP9laTn1UbHRTsQDO0BHCJMacRpN3C73AElNLkIyn/b2Pu0vMWMbhFz/nqRIzu0hydC5VgQmT7YyOvO4u6T41shmL6Gw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d9e99a-926a-4d72-d59b-08d646005ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 05:01:12.3804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoLCBhcyBpdCBjYW4gTk9UIGNvbXBsZXRlbHkgZml4IHRo
ZSBpc3N1ZSBvZiB0aGUgY2FzZSB3aGVuIEdQSU8gSVJRIGNvbWluZyBkdXJpbmcgdGhlIG5vaXJx
IHN1c3BlbmQvcmVzdW1lIHBoYXNlLCB0aGUgY29ycmVjdCBzb2x1dGlvbiBzaG91bGQgYmUgdG8g
c2F2ZS9yZXN0b3JlIHRoZSBHUElPIHJlZ2lzdGVycyB3aGVuIGxvY2FsIGlycSBpcyBvZmYsIHNv
IG1vdmUgdGhlIEdQSU8gbm9pcnEgc3VzcGVuZC9yZXN1bWUgdG8gc3lzY29yZSBwaGFzZSwgSSBo
YXZlIHNlbmQgb3V0IGFub3RoZXIgcGF0Y2ggIltQQVRDSF0gZ3BpbzogbXhjOiBtb3ZlIGdwaW8g
bm9pcnEgc3VzcGVuZC9yZXN1bWUgdG8gc3lzY29yZSBwaGFzZSIsIHBsZWFzZSByZXZpZXcgdGhp
cyBwYXRjaCwgdGhhbmtzIQ0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuc29uIEh1YW5nDQo+IFNlbnQ6IDIwMTjE
6jEx1MI4yNUgMTg6NTQNCj4gVG86IGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZzsgYmdvbGFzemV3
c2tpQGJheWxpYnJlLmNvbTsNCj4gbGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZ3BpbzogbXhjOiBza2lwIEdQSU9fSU1SIHJlc3RvcmUg
aW4gbm9pcnEgcmVzdW1lDQo+IA0KPiBEdXJpbmcgdGhlIHRpbWUgd2luZG93IG9mIG5vaXJxIHN1
c3BlbmQgYW5kIG5vaXJxIHJlc3VtZSwgaWYgYSBHUElPIHBpbiBpcw0KPiBlbmFibGVkIGFzIHN5
c3RlbSB3YWtldXAgc291cmNlLCB0aGUgY29ycmVzcG9uZGluZyBHUElPIGxpbmUncyBJUlEgd2ls
bCBiZQ0KPiB1bm1hc2tlZCwgYW5kIEdQSU8gYmFuayB3aWxsIE5PVCBsb3N0IHBvd2VyLCB3aGVu
IEdQSU8gaXJxIGFycml2ZXMsIGdlbmVyaWMNCj4gaXJxIGhhbmRsZXIgd2lsbCBtYXNrIGl0IHVu
dGlsIEdQSU8gZHJpdmVyIGlzIHJlYWR5IHRvIGhhbmRsZSBpdCwgYnV0IGluIEdQSU8gbm9pcnEN
Cj4gcmVzdW1lIGNhbGxiYWNrLCBjdXJyZW50IGltcGxlbWVudGF0aW9uIHdpbGwgcmVzdG9yZSB0
aGUgSU1SIHJlZ2lzdGVyIHVzaW5nDQo+IHRoZSB2YWx1ZSBzYXZlZCBpbiBwcmV2aW91cyBub2ly
cSBzdXNwZW5kIGNhbGxiYWNrIHdoaWNoIGlzIHVubWFza2VkLCBzbyB0aGlzDQo+IEdQSU8gbGlu
ZSB3aXRoIElSUSBwZW5kaW5nIHdpbGwgYmUgdW5tYXNrZWQgYWdhaW4gYWZ0ZXIgR1BJTyBJTVIg
cmVnaXRzdGVyIGlzDQo+IHJlc3RvcmVkLCBBUk0gd2lsbCBiZSB0cmlnZ2VyZWQgdG8gaGFuZGxl
IHRoaXMgSVJRIGFnYWluLCBiZWNhdXNlIG9mIHRoZSBjaGFuZ2UNCj4gb2YgY29tbWl0IGJmMjJm
ZjQ1YmVkNiAoImdlbmlycTogQXZvaWQgdW5uZWNlc3NhcnkgbG93IGxldmVsIGlycSBmdW5jdGlv
bg0KPiBjYWxscyIpLCB0aGUgbWFza19pcnEgZnVuY3Rpb24gd2lsbCBjaGVjayB0aGUgc3RhdHVz
IG9mIGlycV9kYXRhIHRvIGRlY2lkZQ0KPiB3aGV0aGVyIHRvIG1hc2sgdGhlIGlycSwgaW4gdGhp
cyBzY2VuYXJpbywgc2luY2UgdGhlIEdQSU8gSVJRIGlzIGJlaW5nIG1hc2tlZA0KPiBiZWZvcmUg
R1BJTyBub2lycSByZXN1bWUsIElSUURfSVJRX01BU0tFRCBmbGFnIGlzIHNldCwgc28gdGhlIHNl
Y29uZCB0aW1lDQo+IEdQSU8gSVJRIHRyaWdnZXJlZCBieSByZXN0b3JpbmcgR1BJTyBJTVIgcmVn
aXN0ZXIsIHRoZSBpcnFfbWFzayBjYWxsYmFjayB3aWxsDQo+IGJlIHNraXBwZWQgYW5kIGNhdXNl
IEFSTSBidXN5IGhhbmRsaW5nIHRoZSBHUElPIElSUSBjb21lIGFsbCB0aGUgd2F5IGFuZA0KPiBu
byByZXNwb25zZSB0byB1c2VyIGFueW1vcmUuDQo+IA0KPiBUbyBtYWtlIHRoZSBzY2VuYXJpbyBl
YXN5IHRvIHVuZGVyc3RhbmQsIEkgdGFrZSBHUElPMV8wIGZvciBleGFtcGxlIHdoZW4gaXQNCj4g
aXMgdXNlZCBhcyB3YWtlIHVwIHNvdXJjZToNCj4gDQo+IDEuIEdQSU8xXzAgaXMgZW5hYmxlZCBh
cyB3YWtldXAgc291cmNlLCBpdCB3aWxsIGJlIHVubWFza2VkOyAyLiBJbiBub2lycQ0KPiBzdXNw
ZW5kLCBHUElPIGRyaXZlciBzYXZlcyBHUElPMV8wJ3MgbWFzayBzdGF0ZSBpbg0KPiAgICBJTVIg
cmVnaXN0ZXIgYXMgInVubWFza2VkIjsNCj4gMy4gU3lzdGVtIGdvIGludG8gc3VzcGVuZDsNCj4g
NC4gR1BJTzFfMCBJUlEgYXJyaXZlcywgc3lzdGVtIHdha2VzIHVwOyA1LiBCZWZvcmUgbm9pcnEg
cmVzdW1lIHBoYXNlLCBBUk0NCj4gaGFuZGxlcyB0aGUgR1BJTzFfMCBJUlEsIHNldA0KPiAgICBJ
UlFEX0lSUV9NQVNLRUQgZmxhZyBhbmQgY2FsbCBHUElPIGlycV9tYXNrIGNhbGxiYWNrIHRvIG1h
c2sNCj4gICAgaXQsIGFzIEdQSU8gZHJpdmVyIGlzIE5PVCByZWFkeSB0byBoYW5kbGUgaXQsIG5v
dyBHUElPMV8wDQo+ICAgIElSUSBpcyBtYXNrZWQ7DQo+IDYuIEluIEdQSU8gbm9pcnEgcmVzdW1l
LCBHUElPIGRyaXZlciByZXN0b3JlcyBHUElPIHJlZ2lzdGVycywNCj4gICAgR1BJTzFfMCBJUlEg
d2lsbCBiZSByZXN0b3JlZCB0byB1bm1hc2sgc3RhdGUgYWdhaW4gYW5kIHN5c3RlbQ0KPiAgICBJ
UlEgdHJpZ2dlcmVkOw0KPiA3LiBBUk0gaGFuZGxlcyBHUElPMV8wIElSUSBhZ2FpbiwgdGhpcyB0
aW1lIHRoZSBHUElPMV8wIHdpbGwgTk9UIGJlDQo+ICAgIG1hc2tlZCBzaW5jZSBpdHMgaXJxX2Rh
dGEgYWxyZWFkeSBoYXMgSVJRRF9JUlFfTUFTS0VEIGZsYWcgc2V0OyA4Lg0KPiBHUElPMV8wIElS
USBrZWVwcyBjb21pbmcsIEFSTSB3aWxsIGJlIGJ1c3kgaGFuZGxpbmcgaXQgYnV0IGFsd2F5cw0K
PiAgICBza2lwIHRoZSBpcnFfbWFzayBvcGVyYXRpb24sIHN5c3RlbSBubyByZXNwb25zZS4NCj4g
DQo+IEFsdGhvdWdoIHRoaXMgaXNzdWUgaXMgZXhwb3NlZCBieSBjb21taXQgYmYyMmZmNDViZWQ2
ICgiZ2VuaXJxOiBBdm9pZA0KPiB1bm5lY2Vzc2FyeSBsb3cgbGV2ZWwgaXJxIGZ1bmN0aW9uIGNh
bGxzIiksIGJ1dCBhY3R1YWxseSB3ZSBzaG91bGQgc2tpcCB0aGUgR1BJTw0KPiBJTVIgcmVnaXN0
ZXIgcmVzdG9yZSwgYXMgdGhlIElNUiByZWdpc3RlciBpcyBOT1QgYXRvbWljIGR1cmluZyB0aGUg
dGltZSB3aW5kb3cNCj4gb2YgR1BJTyBub2lycSBzdXNwZW5kIGFuZCBub2lycSByZXN1bWUsIGl0
IGNvdWxkIGJlIGNoYW5nZWQgYnkgQVJNIGlmIHRoZXJlDQo+IGlzIEdQSU8gSVJRIHBlbmRpbmcg
YXQgdGhpcyB3aW5kb3cuDQo+IA0KPiBGb3IgdGhlIHNjZW5hcmlvIG9mIEdQSU8gYmFuayBsb3N0
IHBvd2VyLCB0aGF0IG1lYW5zIG5vIEdQSU8gcGluIGlzIGVuYWJsZWQNCj4gYXMgd2FrZXVwIHNv
dXJjZSwgYWxsIEdQSU8gSVJRcyB3aWxsIGJlIG1hc2tlZCBhbmQgaXQgaXMgc2FtZSBhcyB0aGUg
cmVzZXQNCj4gdmFsdWUgd2hlbiBHUElPIGJhbmsgcG93ZXIgT04sIHNvIG5vIGlzc3VlIGZvciB0
aGlzIGNhc2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdA
bnhwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwaW8vZ3Bpby1teGMuYyB8IDIgLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3Bpby9ncGlvLW14Yy5jIGIvZHJpdmVycy9ncGlvL2dwaW8tbXhjLmMgaW5kZXgNCj4gNWM2OTUx
Ni4uM2Q3NGFkNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncGlvL2dwaW8tbXhjLmMNCj4gKysr
IGIvZHJpdmVycy9ncGlvL2dwaW8tbXhjLmMNCj4gQEAgLTUzMSw3ICs1MzEsNiBAQCBzdGF0aWMg
dm9pZCBteGNfZ3Bpb19zYXZlX3JlZ3Moc3RydWN0IG14Y19ncGlvX3BvcnQNCj4gKnBvcnQpDQo+
IA0KPiAgCXBvcnQtPmdwaW9fc2F2ZWRfcmVnLmljcjEgPSByZWFkbChwb3J0LT5iYXNlICsgR1BJ
T19JQ1IxKTsNCj4gIAlwb3J0LT5ncGlvX3NhdmVkX3JlZy5pY3IyID0gcmVhZGwocG9ydC0+YmFz
ZSArIEdQSU9fSUNSMik7DQo+IC0JcG9ydC0+Z3Bpb19zYXZlZF9yZWcuaW1yID0gcmVhZGwocG9y
dC0+YmFzZSArIEdQSU9fSU1SKTsNCj4gIAlwb3J0LT5ncGlvX3NhdmVkX3JlZy5nZGlyID0gcmVh
ZGwocG9ydC0+YmFzZSArIEdQSU9fR0RJUik7DQo+ICAJcG9ydC0+Z3Bpb19zYXZlZF9yZWcuZWRn
ZV9zZWwgPSByZWFkbChwb3J0LT5iYXNlICsgR1BJT19FREdFX1NFTCk7DQo+ICAJcG9ydC0+Z3Bp
b19zYXZlZF9yZWcuZHIgPSByZWFkbChwb3J0LT5iYXNlICsgR1BJT19EUik7IEBAIC01NDQsNw0K
PiArNTQzLDYgQEAgc3RhdGljIHZvaWQgbXhjX2dwaW9fcmVzdG9yZV9yZWdzKHN0cnVjdCBteGNf
Z3Bpb19wb3J0ICpwb3J0KQ0KPiANCj4gIAl3cml0ZWwocG9ydC0+Z3Bpb19zYXZlZF9yZWcuaWNy
MSwgcG9ydC0+YmFzZSArIEdQSU9fSUNSMSk7DQo+ICAJd3JpdGVsKHBvcnQtPmdwaW9fc2F2ZWRf
cmVnLmljcjIsIHBvcnQtPmJhc2UgKyBHUElPX0lDUjIpOw0KPiAtCXdyaXRlbChwb3J0LT5ncGlv
X3NhdmVkX3JlZy5pbXIsIHBvcnQtPmJhc2UgKyBHUElPX0lNUik7DQo+ICAJd3JpdGVsKHBvcnQt
PmdwaW9fc2F2ZWRfcmVnLmdkaXIsIHBvcnQtPmJhc2UgKyBHUElPX0dESVIpOw0KPiAgCXdyaXRl
bChwb3J0LT5ncGlvX3NhdmVkX3JlZy5lZGdlX3NlbCwgcG9ydC0+YmFzZSArIEdQSU9fRURHRV9T
RUwpOw0KPiAgCXdyaXRlbChwb3J0LT5ncGlvX3NhdmVkX3JlZy5kciwgcG9ydC0+YmFzZSArIEdQ
SU9fRFIpOw0KPiAtLQ0KPiAyLjcuNA0KDQo=

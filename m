Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF01FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1F92087E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c+oqFSjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1F92087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeKUQB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:01:27 -0500
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:49779
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbeKUQB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh2SYgUvECsjTUuK6GPdR6dzUUozd64zrAbCCgk9zMY=;
 b=c+oqFSjjDgrrfh6EHfZOI9FYAA7LHH/uyJWD2RdhNsp8R+mWyw/heUlwvjfBhbFv1Ugk4hHbXlGtRP28uJjL2+RAW5RmMRyHtW7sRUuwiEiCnBEZG1bEZ+EVO+xM/mrycDFEIcKG/bL/FrzBGOz+Tm3cCwjn3ckjnhJy417bz08=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Wed, 21 Nov 2018 05:28:26 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.048; Wed, 21 Nov 2018
 05:28:26 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4] thermal: imx: fix for dependency on cpu-freq
Thread-Topic: [PATCH V4] thermal: imx: fix for dependency on cpu-freq
Thread-Index: AQHUgVgvfgSaUi1sF0WIYUcUodkMEqVZsUGAgAABqSA=
Date:   Wed, 21 Nov 2018 05:28:26 +0000
Message-ID: <DB3PR0402MB3916E94B9CF644707801AE74F5DA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1542776563-6716-1-git-send-email-Anson.Huang@nxp.com>
 <20181121052053.hcc3xgfx4dgkydd2@vireshk-i7>
In-Reply-To: <20181121052053.hcc3xgfx4dgkydd2@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3724;6:HPDPl4a2TQr7Ek6FIkrjglNILOrhv5fDSFlPa06FG2djsqM1EmMaMTvE7Zr7NRTPLuR3P7suNm9C7ugnqTUx9iphQkkBPiVagGR9vSZiqrmKfD9WqTVPdAsx0CVh+bN71Jc0LbP3pDWVQM5Kq3md5MrS4b70f0KMjlQHifCHgFM0kY2jjCQxuVMYacKCXWApN1did6jF2xRGUPHDKk2Qjr3Hih+GGiDBU4LYGjJ8kf6IyK89C347rJPdDK/yRj/HO1Pw1add9IuNWaOhuJMKVLyOEln8z+HIVuxOH57MHV2CfBVIKuarsK1XeRhRP7yBXSi6umZqy2fWVrtZ5iwo4IC3iBgXoA8jRg4T+IPyk+lxrrFwlFfkQftX5eyfFLR8NVpsxRReyxGhN3zhM/MXf+njEAVjA3xmAfxL0+xBZtBdEdsCyU/vZ8JOxIPSThoa8zkEqkkwkj4NEEVS4lkhHA==;5:lMVi1IGvxu9xDbuhbWbm9mSoNIQeo5S1YbQ7aqVkz0UhJEROuhJf2G3tkUELu0ndJNeAo/mfGPkCwjfSoLcfvLirfGuJ5uljEy8Acr781Ib+OkYlJBExooO+E5SK097UE8VXAfxg+nsq7dxG9iGq6vBAva3wY7gCWsofP633uNM=;7:YuMW8ELNcDU6vL2HVxnLQppnt8AtoxxDNPVsYcgveiK38LkiXhBlSIAu50pkj8j7oqlqNIbuu+D2doAtLpG/iLhZ2tFqO1G8N7u6p916UrXL7kNmI5Q2pxLJD24Vh6h19a+uD6IxAx8ci3tHTkOhuw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ac13ebc5-8f68-4095-2cb8-08d64f7229ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-microsoft-antispam-prvs: <DB3PR0402MB37246424DCC40EAFC3C912DAF5DA0@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3724;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3724;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(366004)(39860400002)(199004)(13464003)(189003)(25786009)(5660300001)(478600001)(66066001)(68736007)(14454004)(316002)(6916009)(229853002)(106356001)(97736004)(6436002)(105586002)(7696005)(99286004)(33656002)(76176011)(71200400001)(71190400001)(6116002)(3846002)(81156014)(86362001)(446003)(476003)(486006)(81166006)(39060400002)(2900100001)(74316002)(7736002)(53936002)(6246003)(26005)(53546011)(44832011)(8936002)(256004)(6506007)(55016002)(54906003)(102836004)(305945005)(4326008)(9686003)(186003)(8676002)(11346002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Qtw2UNb+Ygh7iD2R4ToY+Gzjd30gdmzRsqKOwEqUOnE0kv4vO4my0kHoeCD9E3NMjlZpKiernRoJZjO1JOpmYQ1QHbHnArPqyGvB97G2dMRwBE4OQDbT+EYA0NC1xLZ1zPi69nsoRs1FtaGUuGZgKDDAd76VGqbKIRITmUWT/DvY4lI9llhi12WvQwSBkHjk/qUV3eXtVvXdAB4eZZy/JTSHz76D2OFKEaBWQm3iasg07hUVGeavAW0M0cYOpyRtvVJSb6xtTt5eAMg00ArGtxw+1chNd2aDiOgGNDU6su+04CR4hm0uiqm4sPFzgkHr3+W8VzS6LwFKE2qscZ0CUktC46hNBVtYhrx6eelozrs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac13ebc5-8f68-4095-2cb8-08d64f7229ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 05:28:26.2338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogVmlyZXNoIEt1bWFyIFttYWlsdG86dmlyZXNoLmt1bWFyQGxpbmFyby5v
cmddDQo+IFNlbnQ6IDIwMTjE6jEx1MIyMcjVIDEzOjIxDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5z
b24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IHJ1aS56aGFuZ0BpbnRlbC5jb207IGVkdWJlenZhbEBn
bWFpbC5jb207IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc7DQo+IGxpbnV4LXBtQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbC5zdGFjaEBwZW5ndXRy
b25peC5kZTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCBWNF0gdGhlcm1hbDogaW14OiBmaXggZm9yIGRlcGVuZGVuY3kgb24gY3B1LWZyZXEN
Cj4gDQo+IE9uIDIxLTExLTE4LCAwNTowOCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gVGhlIHRo
ZXJtYWwgZHJpdmVyIGlzIGEgc3RhbmRhbG9uZSBkcml2ZXIgZm9yIG1vbml0b3JpbmcgU29DDQo+
ID4gdGVtcGVyYXR1cmUgYnkgZW5hYmxpbmcgdGhlcm1hbCBzZW5zb3IsIHNvIGl0IGNhbiBiZSBl
bmFibGVkIGV2ZW4gd2hlbg0KPiA+IENPTkZJR19DUFVfRlJFUSBpcyBOT1Qgc2V0LiBTbyByZW1v
dmUgdGhlIGRlcGVuZGVuY3kgd2l0aA0KPiBDUFVfVEhFUk1BTC4NCj4gPg0KPiA+IEludHJvZHVj
ZSBkdW1teSBmdW5jdGlvbiBvZiBsZWdhY3kgY29vbGluZyByZWdpc3Rlci91bnJlZ2lzdGVyIHRv
IG1ha2UNCj4gPiB0aGVybWFsIGRyaXZlciBwcm9iZSBzdWNjZXNzZnVsbHkgd2hlbiBDT05GSUdf
Q1BVX0ZSRVEgaXMgTk9UIHNldC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5n
IDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IGNoYW5nZXMgc2luY2UgVjM6DQo+
ID4gCXJlbmFtZSB0aGUgbGFiZWwgb2YgImNwdWZyZXFfcHV0IiB3aXRoICJsZWdhY3lfY2xlYW51
cCIuDQo+ID4gIGRyaXZlcnMvdGhlcm1hbC9LY29uZmlnICAgICAgIHwgIDIgKy0NCj4gPiAgZHJp
dmVycy90aGVybWFsL2lteF90aGVybWFsLmMgfCA0NA0KPiA+ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRp
b25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Ro
ZXJtYWwvS2NvbmZpZyBiL2RyaXZlcnMvdGhlcm1hbC9LY29uZmlnIGluZGV4DQo+ID4gNTQyMjUy
My4uOTNiZDNiYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZw0KPiA+
ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9LY29uZmlnDQo+ID4gQEAgLTIxMiw3ICsyMTIsNyBAQCBj
b25maWcgSElTSV9USEVSTUFMDQo+ID4NCj4gPiAgY29uZmlnIElNWF9USEVSTUFMDQo+ID4gIAl0
cmlzdGF0ZSAiVGVtcGVyYXR1cmUgc2Vuc29yIGRyaXZlciBmb3IgRnJlZXNjYWxlIGkuTVggU29D
cyINCj4gPiAtCWRlcGVuZHMgb24gKEFSQ0hfTVhDICYmIENQVV9USEVSTUFMKSB8fCBDT01QSUxF
X1RFU1QNCj4gPiArCWRlcGVuZHMgb24gQVJDSF9NWEMgfHwgQ09NUElMRV9URVNUDQo+ID4gIAlk
ZXBlbmRzIG9uIE5WTUVNIHx8ICFOVk1FTQ0KPiA+ICAJZGVwZW5kcyBvbiBNRkRfU1lTQ09ODQo+
ID4gIAlkZXBlbmRzIG9uIE9GDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9pbXhf
dGhlcm1hbC5jDQo+ID4gYi9kcml2ZXJzL3RoZXJtYWwvaW14X3RoZXJtYWwuYyBpbmRleCAxNTY2
MTU0Li4zMjhlZTA1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9pbXhfdGhlcm1h
bC5jDQo+ID4gKysrIGIvZHJpdmVycy90aGVybWFsL2lteF90aGVybWFsLmMNCj4gPiBAQCAtNjQ4
LDE1ICs2NDgsMjQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQNCj4gPiBvZl9p
bXhfdGhlcm1hbF9tYXRjaFtdID0geyAgfTsgIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsDQo+ID4g
b2ZfaW14X3RoZXJtYWxfbWF0Y2gpOw0KPiA+DQo+ID4gKyNpZmRlZiBDT05GSUdfQ1BVX0ZSRVEN
Cj4gPiAgLyoNCj4gPiAgICogQ3JlYXRlIGNvb2xpbmcgZGV2aWNlIGluIGNhc2Ugbm8gI2Nvb2xp
bmctY2VsbHMgcHJvcGVydHkgaXMgYXZhaWxhYmxlIGluDQo+ID4gICAqIENQVSBub2RlDQo+ID4g
ICAqLw0KPiA+ICBzdGF0aWMgaW50IGlteF90aGVybWFsX3JlZ2lzdGVyX2xlZ2FjeV9jb29saW5n
KHN0cnVjdA0KPiA+IGlteF90aGVybWFsX2RhdGEgKmRhdGEpICB7DQo+ID4gLQlzdHJ1Y3QgZGV2
aWNlX25vZGUgKm5wID0gb2ZfZ2V0X2NwdV9ub2RlKGRhdGEtPnBvbGljeS0+Y3B1LCBOVUxMKTsN
Cj4gPiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+DQo+ID4g
KwlkYXRhLT5wb2xpY3kgPSBjcHVmcmVxX2NwdV9nZXQoMCk7DQo+ID4gKwlpZiAoIWRhdGEtPnBv
bGljeSkgew0KPiA+ICsJCXByX2RlYnVnKCIlczogQ1BVRnJlcSBwb2xpY3kgbm90IGZvdW5kXG4i
LCBfX2Z1bmNfXyk7DQo+ID4gKwkJcmV0dXJuIC1FUFJPQkVfREVGRVI7DQo+ID4gKwl9DQo+ID4g
Kw0KPiA+ICsJbnAgPSBvZl9nZXRfY3B1X25vZGUoZGF0YS0+cG9saWN5LT5jcHUsIE5VTEwpOw0K
PiA+ICsNCj4gPiAgCWlmICghbnAgfHwgIW9mX2ZpbmRfcHJvcGVydHkobnAsICIjY29vbGluZy1j
ZWxscyIsIE5VTEwpKSB7DQo+ID4gIAkJZGF0YS0+Y2RldiA9IGNwdWZyZXFfY29vbGluZ19yZWdp
c3RlcihkYXRhLT5wb2xpY3kpOw0KPiA+ICAJCWlmIChJU19FUlIoZGF0YS0+Y2RldikpIHsNCj4g
PiBAQCAtNjY5LDYgKzY3OCwyMiBAQCBzdGF0aWMgaW50DQo+IGlteF90aGVybWFsX3JlZ2lzdGVy
X2xlZ2FjeV9jb29saW5nKHN0cnVjdCBpbXhfdGhlcm1hbF9kYXRhICpkYXRhKQ0KPiA+ICAJcmV0
dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBpbXhfdGhlcm1hbF91bnJlZ2lz
dGVyX2xlZ2FjeV9jb29saW5nKHN0cnVjdA0KPiA+ICtpbXhfdGhlcm1hbF9kYXRhICpkYXRhKSB7
DQo+ID4gKwljcHVmcmVxX2Nvb2xpbmdfdW5yZWdpc3RlcihkYXRhLT5jZGV2KTsNCj4gPiArCWNw
dWZyZXFfY3B1X3B1dChkYXRhLT5wb2xpY3kpOw0KPiA+ICt9DQo+ID4gKyNlbHNlDQo+ID4gK3N0
YXRpYyBpbmxpbmUgaW50IGlteF90aGVybWFsX3JlZ2lzdGVyX2xlZ2FjeV9jb29saW5nKHN0cnVj
dA0KPiA+ICtpbXhfdGhlcm1hbF9kYXRhICpkYXRhKSB7DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiArc3RhdGljIGlubGluZSB2b2lkIGlteF90aGVybWFsX3VucmVnaXN0ZXJf
bGVnYWN5X2Nvb2xpbmcoc3RydWN0DQo+ID4gK2lteF90aGVybWFsX2RhdGEgKmRhdGEpIHsgfSAj
ZW5kaWYNCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgaW14X3RoZXJtYWxfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikgIHsNCj4gPiAgCXN0cnVjdCBpbXhfdGhlcm1hbF9kYXRhICpk
YXRhOw0KPiA+IEBAIC03NDMsMTMgKzc2OCw5IEBAIHN0YXRpYyBpbnQgaW14X3RoZXJtYWxfcHJv
YmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCXJlZ21hcF93cml0ZSht
YXAsIGRhdGEtPnNvY2RhdGEtPnNlbnNvcl9jdHJsICsgUkVHX1NFVCwNCj4gPiAgCQkgICAgIGRh
dGEtPnNvY2RhdGEtPnBvd2VyX2Rvd25fbWFzayk7DQo+ID4NCj4gPiAtCWRhdGEtPnBvbGljeSA9
IGNwdWZyZXFfY3B1X2dldCgwKTsNCj4gPiAtCWlmICghZGF0YS0+cG9saWN5KSB7DQo+ID4gLQkJ
cHJfZGVidWcoIiVzOiBDUFVGcmVxIHBvbGljeSBub3QgZm91bmRcbiIsIF9fZnVuY19fKTsNCj4g
PiAtCQlyZXR1cm4gLUVQUk9CRV9ERUZFUjsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gIAlyZXQgPSBp
bXhfdGhlcm1hbF9yZWdpc3Rlcl9sZWdhY3lfY29vbGluZyhkYXRhKTsNCj4gPiArCWlmIChyZXQg
PT0gLUVQUk9CRV9ERUZFUikNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICAJaWYgKHJldCkgew0K
PiANCj4gU29ycnkgZm9yIG5vdCBub3RpY2luZyBlYXJsaWVyLCBidXQgd291bGRuJ3QgaXQgYmUg
YmV0dGVyIHRvIG1vdmUgdGhlDQo+IEVQUk9CRV9ERUZFUiBjaGVjayBpbnNpZGUgb2YgdGhpcyBp
ZiBibG9jayA/IE90aGVyd2lzZSB3ZSB3aWxsIGhhdmUgdHdvDQo+IGNvbmRpdGlvbmFsIGJsb2Nr
cyBpbiB0aGUgc3VjY2VzcyAobm9ybWFsKSBjYXNlLg0KDQpTaW5jZSB0aGVyZSBpcyBzaW1pbGFy
IGNhc2Ugb2YgREVGRVIgUFJPQkUgZm9yIHRoZSBjYXNlIG9mIGlteF9pbml0X2Zyb21fbnZtZW1f
Y2VsbHMNCmNoZWNrLCBzaG91bGQgSSBjcmVhdGUgYW5vdGhlciBwYXRjaCBvZiBzYW1lIGZpeCBm
b3IgaXQgaW4gVjUgcGF0Y2ggc2V0Pw0KDQpBbnNvbi4NCg0KPiANCj4gU29tZXRoaW5nIGxpa2Ug
dGhpczoNCj4gDQo+IGlmIChyZXQpIHsNCj4gICAgICAgICBpZiAocmV0ID09IC1FUFJPQkVfREVG
RVIpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiANCj4gICAgICAgICBkZXZfZXJy
KC4uKTsNCj4gICAgICAgICAuLi4NCj4gfQ0KPiANCj4gPiAgCQlkZXZfZXJyKCZwZGV2LT5kZXYs
DQo+ID4gIAkJCSJmYWlsZWQgdG8gcmVnaXN0ZXIgY3B1ZnJlcSBjb29saW5nIGRldmljZTogJWRc
biIsIHJldCk7IEBADQo+IC03NjIsNw0KPiA+ICs3ODMsNyBAQCBzdGF0aWMgaW50IGlteF90aGVy
bWFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAkJaWYgKHJldCAh
PSAtRVBST0JFX0RFRkVSKQ0KPiA+ICAJCQlkZXZfZXJyKCZwZGV2LT5kZXYsDQo+ID4gIAkJCQki
ZmFpbGVkIHRvIGdldCB0aGVybWFsIGNsazogJWRcbiIsIHJldCk7DQo+ID4gLQkJZ290byBjcHVm
cmVxX3B1dDsNCj4gPiArCQlnb3RvIGxlZ2FjeV9jbGVhbnVwOw0KPiA+ICAJfQ0KPiA+DQo+ID4g
IAkvKg0KPiA+IEBAIC03NzUsNyArNzk2LDcgQEAgc3RhdGljIGludCBpbXhfdGhlcm1hbF9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAJcmV0ID0gY2xrX3ByZXBh
cmVfZW5hYmxlKGRhdGEtPnRoZXJtYWxfY2xrKTsNCj4gPiAgCWlmIChyZXQpIHsNCj4gPiAgCQlk
ZXZfZXJyKCZwZGV2LT5kZXYsICJmYWlsZWQgdG8gZW5hYmxlIHRoZXJtYWwgY2xrOiAlZFxuIiwg
cmV0KTsNCj4gPiAtCQlnb3RvIGNwdWZyZXFfcHV0Ow0KPiA+ICsJCWdvdG8gbGVnYWN5X2NsZWFu
dXA7DQo+ID4gIAl9DQo+ID4NCj4gPiAgCWRhdGEtPnR6ID0gdGhlcm1hbF96b25lX2RldmljZV9y
ZWdpc3RlcigiaW14X3RoZXJtYWxfem9uZSIsDQo+ID4gQEAgLTgyOSw5ICs4NTAsOCBAQCBzdGF0
aWMgaW50IGlteF90aGVybWFsX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYp
DQo+ID4gIAl0aGVybWFsX3pvbmVfZGV2aWNlX3VucmVnaXN0ZXIoZGF0YS0+dHopOw0KPiA+ICBj
bGtfZGlzYWJsZToNCj4gPiAgCWNsa19kaXNhYmxlX3VucHJlcGFyZShkYXRhLT50aGVybWFsX2Ns
ayk7DQo+ID4gLWNwdWZyZXFfcHV0Og0KPiA+IC0JY3B1ZnJlcV9jb29saW5nX3VucmVnaXN0ZXIo
ZGF0YS0+Y2Rldik7DQo+ID4gLQljcHVmcmVxX2NwdV9wdXQoZGF0YS0+cG9saWN5KTsNCj4gPiAr
bGVnYWN5X2NsZWFudXA6DQo+ID4gKwlpbXhfdGhlcm1hbF91bnJlZ2lzdGVyX2xlZ2FjeV9jb29s
aW5nKGRhdGEpOw0KPiA+DQo+ID4gIAlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gLS0NCj4gPiAy
LjcuNA0KPiANCj4gLS0NCj4gdmlyZXNoDQo=

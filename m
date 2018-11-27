Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB13C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB1A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="3A9gdWlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB1A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbeK1Eou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:44:50 -0500
Received: from mail-eopbgr790103.outbound.protection.outlook.com ([40.107.79.103]:58462
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731658AbeK1Eou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXuvdcNn+l2r4o76GM/SxxeZuSpmpqY8q6T2Tckoj5k=;
 b=3A9gdWlmoD1kHoiPO4QYnSs2XqKd0OW/PWz17BKEsFgY3gKpYWD1aF+KdMVmApe9JIcOFQnkZkhSrAbF6JyGp62lNLXgKMaTR5qg5oHv1HcEINNdNDrjIwhQxMBbyACmmVXLcB+NSQn6HSEngNqCBiAiezUVox80tw1cepSJjUY=
Received: from DM6PR11MB3131.namprd11.prod.outlook.com (20.177.219.96) by
 DM6PR11MB3338.namprd11.prod.outlook.com (20.176.122.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.20; Tue, 27 Nov 2018 17:46:04 +0000
Received: from DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1]) by DM6PR11MB3131.namprd11.prod.outlook.com
 ([fe80::2dfb:d623:d7cb:cbe1%3]) with mapi id 15.20.1361.018; Tue, 27 Nov 2018
 17:46:04 +0000
From:   Ryan Lee <RyanS.Lee@maximintegrated.com>
To:     Grant Grundler <grundler@chromium.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Benson Leung <bleung@chromium.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: max98373: Added max98373_reset for stable amp reset
Thread-Topic: [PATCH] ASoC: max98373: Added max98373_reset for stable amp
 reset
Thread-Index: AQHUhbhJ96XSCK8z8UOo2bPiHw7S7qVi5UkAgAAAzwCAAQAc0A==
Date:   Tue, 27 Nov 2018 17:46:04 +0000
Message-ID: <DM6PR11MB31311574FD0664D5BE387BEAE7D00@DM6PR11MB3131.namprd11.prod.outlook.com>
References: <20181126183942.2631-1-ryans.lee@maximintegrated.com>
 <CANEJEGu30oPGRjeK2Sp1dUj4CuFjZeZ9+-2DRwhvmMLNex3p7A@mail.gmail.com>
 <CANEJEGs+ou+YyB503fyX9sqSzbp-EpykGo7OXgCNV0cW7RA0vA@mail.gmail.com>
In-Reply-To: <CANEJEGs+ou+YyB503fyX9sqSzbp-EpykGo7OXgCNV0cW7RA0vA@mail.gmail.com>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
x-originating-ip: [204.17.143.20]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR11MB3338;6:uA57SbMeEQeyujdnNrOPFGdTrhRQX68i0OkTOQCvK7VtUudmnRkqTrGdmn4d60AtpDlZto9FIzzNdpPqedMk28Io+zjtXU0pQXl7af2e9dKdkE7bvXrLJHMmEAeQ3nbLZYpQKfzKltU6DXLq2d14L6z4KRIzcghvBBg2jxPa4mwEZczfNemAfKgIRuN+nDjYu4LyQjGR5kaLqV/PsXaZjCNgRId7wCbXb+VFNHHhL+kv6uiP587c23HrwuSBt4BZFSK3grtfC+LQLSYgNtIbXk7evu0pH/Lr7tsekmkGzyIIlT6NUvoUKlSC+YUkJGH4cC5humEqTcLY1JRAzAyrhjK3Ke08Nkp1BMnfcmU3UO+Ic2jvu7fphKmJhuipGlLOlOU/9ixkPkeQRznkPWw+wNKRmRhfw3JjKFs4samkEWcOPsoqwBTyYsxDw/E8RsO8Jdffd+voRMv2bpkt+Odi1A==;5:vl+AeXbmcxSfPt9I2MqTtBdfw+lC3ejukK0SDxmvAgLSIQZyWpbcRGg0VrYlvZ1kXfH/lYAO2Qru3pG5siKgvJHbCsTcdW7YWaK2RIaWg5NI4gR+9FZzNdmgpnP+FkwaGsZnSBthH5/djYDWj0gEtmmXoiIQX4t3UyNCkh8Cr8g=;7:mWTqoq/eKr36m2TgFbVto6Z65+LinJbFP6ejOVKqR03Gf8zlHdT053Thaxzel7HB9lF//Br/kBuO6RDH0u4F23qDP3Q7zO0bnGURSuq40cKCxR7IuYNpoj0Xu4J/J8svcDGFJRBGWi2g9PzjJlRurA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: aa62b41f-780e-4cbb-0fe2-08d654903401
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR11MB3338;
x-ms-traffictypediagnostic: DM6PR11MB3338:
x-microsoft-antispam-prvs: <DM6PR11MB3338FC5BE024CEB25A1C4A72E7D00@DM6PR11MB3338.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231443)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR11MB3338;BCL:0;PCL:0;RULEID:;SRVR:DM6PR11MB3338;
x-forefront-prvs: 086943A159
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(346002)(366004)(39860400002)(51914003)(13464003)(189003)(199004)(6436002)(316002)(54906003)(305945005)(7736002)(33656002)(2906002)(6116002)(3846002)(14454004)(5660300001)(8676002)(81156014)(8936002)(81166006)(74316002)(55016002)(72206003)(478600001)(53936002)(4326008)(25786009)(6246003)(97736004)(6916009)(68736007)(229853002)(105586002)(106356001)(39060400002)(76176011)(14444005)(99286004)(256004)(53546011)(102836004)(7696005)(6506007)(486006)(26005)(446003)(86362001)(476003)(71200400001)(11346002)(66066001)(71190400001)(186003)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3338;H:DM6PR11MB3131.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: kc9dQS9PV/+hO5Q8FCA+m8Q2kS2Z5jY3PMmoXRG7WOSCAN51TsjbHfh/ppFRVjPnalaIrlmz09cZag0WjBuQZWEqNeFTx8FkIvbCwexxWyQ8HuV4N94O6v2GJKnVsWu2MfVW6mwbpnhHZ1L72H1wYD+AVNgITg2EVVzRXkoG3PAhusayXHmmjfraH4ZpmVuBaqVs8IhIK/l7Q9+rBe3qNfdUFFUV/RUTeUrBdHHBFA2DBbQyMQjLRDwQVtoiYVqcWUfb6a7+ZHvg9P/Qcs9T5bNpFTU04QvSx0YcGN6GLbEgTtEV899VZ2DD/jH4WjkA0YeCfu5DvfPqJjfNlPLTkMdB0li+xicWc2yzlzX+28Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa62b41f-780e-4cbb-0fe2-08d654903401
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2018 17:46:04.2918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogR3JhbnQgR3J1bmRsZXIgPGdydW5k
bGVyQGNocm9taXVtLm9yZz4NCj5TZW50OiBNb25kYXksIE5vdmVtYmVyIDI2LCAyMDE4IDY6Mjgg
UE0NCj5UbzogR3JhbnQgR3J1bmRsZXIgPGdydW5kbGVyQGNocm9taXVtLm9yZz4NCj5DYzogUnlh
biBMZWUgPFJ5YW5TLkxlZUBtYXhpbWludGVncmF0ZWQuY29tPjsgTGlhbSBHaXJkd29vZA0KPjxs
Z2lyZHdvb2RAZ21haWwuY29tPjsgYnJvb25pZUBrZXJuZWwub3JnOyBwZXJleEBwZXJleC5jejsN
Cj50aXdhaUBzdXNlLmNvbTsgS3VuaW5vcmkgTW9yaW1vdG8gPGt1bmlub3JpLm1vcmltb3RvLmd4
QHJlbmVzYXMuY29tPjsNCj5CZW5zb24gTGV1bmcgPGJsZXVuZ0BjaHJvbWl1bS5vcmc+OyBhbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmc7IExLTUwNCj48bGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZz4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSBBU29DOiBtYXg5ODM3MzogQWRkZWQgbWF4OTgz
NzNfcmVzZXQgZm9yIHN0YWJsZSBhbXANCj5yZXNldA0KPg0KPkVYVEVSTkFMIEVNQUlMDQo+DQo+
DQo+DQo+SSBqdXN0IHJlYWxpemVkIEkgaGFkIG9uZSBtb3JlIHF1ZXN0aW9uLi4uDQo+DQo+T24g
TW9uLCBOb3YgMjYsIDIwMTggYXQgNjoyNCBQTSBHcmFudCBHcnVuZGxlciA8Z3J1bmRsZXJAY2hy
b21pdW0ub3JnPg0KPndyb3RlOg0KPj4NCj4+IEhpIFJ5YW4hDQo+Pg0KPj4gSnVzdCBzb21lIHF1
ZXN0aW9ucyBpbmxpbmUgLSBpbiBnZW5lcmFsIEkgbGlrZSB0aGUgcmVzZXQgZnVuY3Rpb24uDQo+
Pg0KPj4gT24gTW9uLCBOb3YgMjYsIDIwMTggYXQgMTA6NDYgQU0gUnlhbiBMZWUNCj48UnlhblMu
TGVlQG1heGltaW50ZWdyYXRlZC5jb20+IHdyb3RlOg0KPj4gPg0KPj4gPiBTaWduZWQtb2ZmLWJ5
OiBSeWFuIExlZSA8cnlhbnMubGVlQG1heGltaW50ZWdyYXRlZC5jb20+DQo+PiA+IC0tLQ0KPj4g
PiAgQ2hhbmdlcyA6IENyZWF0ZWQgbWF4OTgzNzNfcmVzZXQgZnVuY3Rpb24gdG8gbWluaW1pemUg
Y29kZSBkdXBsaWNhdGlvbi4NCj4+ID4gICAgICAgICAgICBDaGFuZ2VkIHJlZ21hcF93cml0ZSB0
byByZWdtYXBfdXBkYXRlX2JpdHMuIE90aGVyIGJpdHMgZXhjZXB0DQo+TFNCIG5lZWQgdG8gYmUg
bWFza2VkLg0KPj4gPiAgICAgICAgICAgIEFkZGVkIHJlc2V0IHZlcmlmaWNhdGlvbiBzdGVwIHRv
IG1ha2Ugc3VyZSBzb2Z0d2FyZSByZXNldCBpcw0KPmNvbXBsZXRlZCB3ZWxsLiBTb2Z0d2FyZSBy
ZXNldCBpcyBkb25lIGluIDEwbXMgaW4gbm9ybWFsIGNhc2UuDQo+PiA+ICAgICAgICAgICAgUmV2
aXNpb24gSUQgaXMgYXZhaWxhYmxlIHdoZW4gdGhlIGFtcCBpcyBpbiB0aGUgaWRsZSBzdGF0ZSB3
aGljaCBtZWFucw0KPnNvZnR3YXJlIHJlc2V0IGlzIGNvbXBsZXRlZC4NCj4NCj5XaHkgbm90IHBv
bGwgdGhlIFJldklEIHJlZ2lzdGVyIGEgZmV3IHRpbWVzIHVudGlsIGl0IGdpdmVzIGEgdmFsdWU/
DQo+DQo+VGhlbiBzdHJ1Y3R1cmUgdGhlIGNvZGUgdG8gdHJ5IHJlc2V0IHR3aWNlIChtYXliZSB0
aHJlZSB0aW1lcykuDQo+VGhpcyB3b3VsZCBhdm9pZCB0aGUgdW51c3VhbCAic2xlZXAgdGltZSBh
ZnRlciByZXNldCBpcyBpbmNyZWFzZWQiIGNvZGUuDQpMZXQgbWUgZml4IHVudXN1YWwgdGhpbmdz
IGhlcmUuIFRoYW5rcyBmb3IgdGhlIGNvbW1lbnQuDQoNCj4NCj5jaGVlcnMsDQo+Z3JhbnQNCj4N
Cj4+ID4gICAgICAgICAgICBTb2Z0d2FyZSByZXNldCB3aWxsIGJlIHBlcmZvcm1lZCBtYXhpbXVt
IDMgdGltZXMgdG8gYXZvaWQgYW1wDQo+cmVzZXQgZmFpbHVyZS4gR2VuZXJhbGx5IGl0IGlzIGRv
bmUgaW4gdGhlIGZpcnN0IHRyaWFsLg0KPj4gPiAgICAgICAgICAgIHNsZWVwIHRpbWUgYWZ0ZXIg
c29mdHdhcmUgcmVzZXQgaXMgaW5jcmVhc2VkICsgMzBtcyBmb3IgZXZlcnkgcmV0cmlhbC4NCj5N
YXhpbXVtIHBvc3NpYmxlIG1zbGVlcCB0aW1lIGlzIDEwMCBtcyAoaW5pdGlhbCAxMCBtcyArIDMw
IG1zICogMyB0aW1lcykuDQo+Pg0KPj4gV2h5IGlzIHRoZSBzbGVlcCB0aW1lIGluY3JlYXNlZCBh
ZnRlciBlYWNoIFNXIHJlc2V0Pw0KPj4gV2hhdCBpcyB0aGUgZmFpbHVyZSBjYXNlIHRoYXQgeW91
J3ZlIHNlZW4gd2hpY2ggd291bGQgYmVuZWZpdCBmcm9tIHRoaXM/DQo+Pg0KPj4gPg0KPj4gPiAg
c291bmQvc29jL2NvZGVjcy9tYXg5ODM3My5jIHwgNDENCj4+ID4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0NCj4+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRp
b25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPj4gPg0KPj4gPiBkaWZmIC0tZ2l0IGEvc291bmQvc29j
L2NvZGVjcy9tYXg5ODM3My5jDQo+PiA+IGIvc291bmQvc29jL2NvZGVjcy9tYXg5ODM3My5jIGlu
ZGV4IGEwOWQwMTMuLjU1YWY3ZjAyIDEwMDY0NA0KPj4gPiAtLS0gYS9zb3VuZC9zb2MvY29kZWNz
L21heDk4MzczLmMNCj4+ID4gKysrIGIvc291bmQvc29jL2NvZGVjcy9tYXg5ODM3My5jDQo+PiA+
IEBAIC03MjQsMTQgKzcyNCw0NSBAQCBzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGFpX2RyaXZlciBt
YXg5ODM3M19kYWlbXQ0KPj0gew0KPj4gPiAgICAgICAgIH0NCj4+ID4gIH07DQo+PiA+DQo+PiA+
ICtzdGF0aWMgdm9pZCBtYXg5ODM3M19yZXNldChzdHJ1Y3QgbWF4OTgzNzNfcHJpdiAqbWF4OTgz
NzMsIHN0cnVjdA0KPj4gPiArZGV2aWNlICpkZXYpIHsNCj4+ID4gKyAgICAgICBpbnQgcmV0LCBy
ZWcsIGNvdW50LCBkZWxheTsNCj4+ID4gKw0KPj4gPiArICAgICAgIGNvdW50ID0gMDsNCj4+ID4g
KyAgICAgICB3aGlsZSAodHJ1ZSkgew0KPj4gPiArICAgICAgICAgICAgICAgLyogU29mdHdhcmUg
UmVzZXQgKi8NCj4+ID4gKyAgICAgICAgICAgICAgIHJldCA9IHJlZ21hcF91cGRhdGVfYml0cyht
YXg5ODM3My0+cmVnbWFwLA0KPj4gPiArICAgICAgICAgICAgICAgICAgICAgICBNQVg5ODM3M19S
MjAwMF9TV19SRVNFVCwNCj4+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTUFYOTgzNzNfU09G
VF9SRVNFVCwNCj4+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTUFYOTgzNzNfU09GVF9SRVNF
VCk7DQo+PiA+ICsgICAgICAgICAgICAgICBpZiAocmV0KQ0KPj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBkZXZfZXJyKGRldiwgIlJlc2V0IGNvbW1hbmQgZmFpbGVkLg0KPj4gPiArIChyZXQ6
JWQpXG4iLCByZXQpOw0KPj4gPiArDQo+PiA+ICsgICAgICAgICAgICAgICBkZWxheSA9IDEwMDAw
ICsgKGNvdW50ICogMzAwMDApOw0KPj4gPiArICAgICAgICAgICAgICAgdXNsZWVwX3JhbmdlKGRl
bGF5LCBkZWxheSArIDEwMDApOw0KPj4gPiArDQo+PiA+ICsgICAgICAgICAgICAgICAvKiBTb2Z0
d2FyZSBSZXNldCBWZXJpZmljYXRpb24gKi8NCj4+ID4gKyAgICAgICAgICAgICAgIHJldCA9IHJl
Z21hcF9yZWFkKG1heDk4MzczLT5yZWdtYXAsDQo+PiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IE1BWDk4MzczX1IyMUZGX1JFVl9JRCwgJnJlZyk7DQo+PiA+ICsgICAgICAgICAgICAgICBpZiAo
IXJldCkgew0KPj4gPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfaW5mbyhkZXYsICJSZXNl
dCBjb21wbGV0ZWQgKHJldHJ5OiVkKVxuIiwgY291bnQpOw0KPj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4+DQo+PiBJbnN0ZWFkIG9mIGJyZWFrLCBjYW4gdGhlIGNvZGUgcmV0
dXJuIGhlcmU/DQo+PiAiYnJlYWsiIGltcGxpZXMgc29tZXRoaW5nIGVsc2Ugd2lsbCBoYXBwZW4g
YWZ0ZXIgdGhlIHdoaWxlIGxvb3AgZXhpdHMNCj4+IC0gdGhlcmUgaXNuJ3QuDQo+Pg0KPj4gPiAr
ICAgICAgICAgICAgICAgfQ0KPj4gPiArDQo+PiA+ICsgICAgICAgICAgICAgICBpZiAoKytjb3Vu
dCA+IDMpICAgICAgICB7DQo+PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2
LCAiUmVzZXQgZmFpbGVkLiAocmV0OiVkKVxuIiwgcmV0KTsNCj4+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgYnJlYWs7DQo+PiA+ICsgICAgICAgICAgICAgICB9DQo+PiA+ICsgICAgICAgICAg
ICAgICB1c2xlZXBfcmFuZ2UoMTAwMDAsIDExMDAwKTsNCj4+DQo+PiBXaHkgaXMgdGhlcmUgYSBz
ZWNvbmQgZGVsYXkgYWZ0ZXIgcmVhZGluZyBNQVg5ODM3M19SMjFGRl9SRVZfSUQ/DQo+PiBJcyB0
aGlzIHJlYWxseSBuZWNlc3Nhcnk/DQo+Pg0KPj4gSWYgdGhlIHNlY29uZCB1c2xlZXBfcmFuZ2Uo
KSBpc24ndCBuZWVkZWQsIGl0IHdvdWxkIGJlIGJldHRlci9jbGVhcmVyDQo+PiB0byBtYWtlIGNv
ZGUgbG9vcCBvbiAid2hpbGUgKGNvdW50IDwgNCkiLiAgIEFuZCB0aGVuIG91dHNpZGUgdGhlIHdo
aWxlDQo+PiBsb29wLCB1c2UgZGV2X2VycigpIHRvIHNoYXJlIHdoYXQgdGhlIGZhaWx1cmUgd2Fz
Lg0KPj4NCj4+ID4gKyAgICAgICB9DQo+PiA+ICt9DQo+PiA+ICsNCj4+ID4gIHN0YXRpYyBpbnQg
bWF4OTgzNzNfcHJvYmUoc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjb21wb25lbnQpICB7DQo+
PiA+ICAgICAgICAgc3RydWN0IG1heDk4MzczX3ByaXYgKm1heDk4MzczID0NCj4+ID4gc25kX3Nv
Y19jb21wb25lbnRfZ2V0X2RydmRhdGEoY29tcG9uZW50KTsNCj4+ID4NCj4+ID4gICAgICAgICAv
KiBTb2Z0d2FyZSBSZXNldCAqLw0KPj4gPiAtICAgICAgIHJlZ21hcF93cml0ZShtYXg5ODM3My0+
cmVnbWFwLA0KPj4gPiAtICAgICAgICAgICAgICAgTUFYOTgzNzNfUjIwMDBfU1dfUkVTRVQsIE1B
WDk4MzczX1NPRlRfUkVTRVQpOw0KPj4gPiAtICAgICAgIHVzbGVlcF9yYW5nZSgxMDAwMCwgMTEw
MDApOw0KPj4gPiArICAgICAgIG1heDk4MzczX3Jlc2V0KG1heDk4MzczLCBjb21wb25lbnQtPmRl
dik7DQo+PiA+DQo+PiA+ICAgICAgICAgLyogSVYgZGVmYXVsdCBzbG90IGNvbmZpZ3VyYXRpb24g
Ki8NCj4+ID4gICAgICAgICByZWdtYXBfd3JpdGUobWF4OTgzNzMtPnJlZ21hcCwgQEAgLTgxOCw5
ICs4NDksNyBAQCBzdGF0aWMNCj4+ID4gaW50IG1heDk4MzczX3Jlc3VtZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpICB7DQo+PiA+ICAgICAgICAgc3RydWN0IG1heDk4MzczX3ByaXYgKm1heDk4MzczID0g
ZGV2X2dldF9kcnZkYXRhKGRldik7DQo+PiA+DQo+PiA+IC0gICAgICAgcmVnbWFwX3dyaXRlKG1h
eDk4MzczLT5yZWdtYXAsDQo+PiA+IC0gICAgICAgICAgICAgICBNQVg5ODM3M19SMjAwMF9TV19S
RVNFVCwgTUFYOTgzNzNfU09GVF9SRVNFVCk7DQo+PiA+IC0gICAgICAgdXNsZWVwX3JhbmdlKDEw
MDAwLCAxMTAwMCk7DQo+PiA+ICsgICAgICAgbWF4OTgzNzNfcmVzZXQobWF4OTgzNzMsIGRldik7
DQo+PiA+ICAgICAgICAgcmVnY2FjaGVfY2FjaGVfb25seShtYXg5ODM3My0+cmVnbWFwLCBmYWxz
ZSk7DQo+PiA+ICAgICAgICAgcmVnY2FjaGVfc3luYyhtYXg5ODM3My0+cmVnbWFwKTsNCj4+ID4g
ICAgICAgICByZXR1cm4gMDsNCj4+ID4gLS0NCj4+ID4gMi43LjQNCj4+ID4NCj4+DQo+PiBjaGVl
cnMsDQo+PiBncmFudA0K

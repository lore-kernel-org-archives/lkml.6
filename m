Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A08AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1B720866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ea3Vw7jg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfAPSaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:30:07 -0500
Received: from mail-eopbgr140048.outbound.protection.outlook.com ([40.107.14.48]:29824
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728489AbfAPSaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdut22e0eEqgbV9pYHrJQO7bQarqNjcHk5IoK4M6L0g=;
 b=Ea3Vw7jg6tgcP2I2Cf/r9iibbSKVEh2LMfU6MIpS8l9sdujMHmpqeNid8IUa89E8Gj+4g4K7E/2ftH6q698v7iVLGe65X5EbhaSN9cHKeBZshvZmgO0PIGSO79d1fnqi5ocDZa+2R/YGWI5HK2W6Gswj+0sU5LNueGDrp7FIzYw=
Received: from VI1PR08MB4110.eurprd08.prod.outlook.com (20.178.127.212) by
 VI1PR08MB3005.eurprd08.prod.outlook.com (52.133.14.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 18:30:00 +0000
Received: from VI1PR08MB4110.eurprd08.prod.outlook.com
 ([fe80::145a:b30b:415d:d985]) by VI1PR08MB4110.eurprd08.prod.outlook.com
 ([fe80::145a:b30b:415d:d985%4]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 18:30:00 +0000
From:   Marc Zyngier <Marc.Zyngier@arm.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC PATCH v4 08/13] genirq/msi: Add support for allocating
 single MSI for a device
Thread-Topic: [RFC PATCH v4 08/13] genirq/msi: Add support for allocating
 single MSI for a device
Thread-Index: AQHUnatcHXmsWWwn7UqNgnfxfE5J9KWyV5+A
Date:   Wed, 16 Jan 2019 18:30:00 +0000
Message-ID: <5be38277-3348-a6d9-4b67-3ead308c009a@arm.com>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
 <20181227061313.5451-8-lokeshvutla@ti.com>
In-Reply-To: <20181227061313.5451-8-lokeshvutla@ti.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0081.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::21) To VI1PR08MB4110.eurprd08.prod.outlook.com
 (2603:10a6:803:e7::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Marc.Zyngier@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB3005;6:xtJtj5Ki0UC0b6pM4U4s0TnnmDpeDRPEN7yryJkqgLqcI7N6BUZwiwJSwslsasG5oqVA3hTTPeoGT78D5eSKW5+izI78XFLgJccPpi/q7JEVTQ+4AUkh8gQCdtYYPEj9eLPiSx1PCDCz4SUDDuMTH7eaGLu9XtZ71EfchSCiXxsXrGFY2nQMkHW2x0bDeheVj1cp6uQElWXZvmbnVro0muzI/7b6COgbsddcCHa1NVe7FkXj+EqY0Q76hc95d/JRe0oA8trwzsjtTUnsTqfaLiq49y9eCFIvUh0/oklf+Vi5IK4xWw929hBL2GVHXY5Pe/Yyaw+gKdBOFMwvQGpqGI9xdCSIvnLG746WqoEyDml8RR9WcnVXtu4bKpEPyz+pRmn479P6x656+GAqEGYx1/qK3tV7TbEkm1oRAwUPbcONGp/fqCnZv48kHMfA5LDIRWIA1u5xtGm52yD/+egM9w==;5:ObbECwnofxf8DQfC2nfbTqKYJp73KZX6VSB+TF9+1oclu/ZiBwe+2hZisONlMZGmUH2jRerOWkjZNC+osJJwkvObdKu6x1yJAVevamBrjKnTJyPK/3YvSxZyA9Xj8llz8uOQ2//lhtierS9ENcOrKuU2CQEOUAYhvklIawIx7AYcHZ16v3DKSgf8Xfd7Ba7+PhAniU7A249Fv5TEPopilQ==;7:GS5Yf90q5gUoj+jmxDCCUX4U3ZI+3WT89FNTyk0noizjdhV5ofdHoQRHctdFDjH2oH/yKjXRQyyOIeSFL9pajMtDfxIHV0s6LMUADWQyJNeAixI1FqULNek/UahqNDtHw5fKwYh1xcdr/bPbXIGCxg==
x-ms-office365-filtering-correlation-id: 6dc37863-2896-4b27-55bb-08d67be09f50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3005;
x-ms-traffictypediagnostic: VI1PR08MB3005:
x-microsoft-antispam-prvs: <VI1PR08MB3005AC43984899A6C1466CA08C820@VI1PR08MB3005.eurprd08.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(366004)(40434004)(189003)(199004)(110136005)(14454004)(54906003)(2501003)(71190400001)(58126008)(7416002)(65806001)(2906002)(478600001)(5660300001)(65826007)(316002)(8676002)(81166006)(81156014)(71200400001)(7736002)(99286004)(65956001)(66066001)(6486002)(6436002)(229853002)(8936002)(305945005)(105586002)(106356001)(11346002)(2616005)(446003)(5024004)(14444005)(486006)(256004)(53936002)(4326008)(31686004)(68736007)(6512007)(476003)(64126003)(102836004)(52116002)(36756003)(76176011)(217873002)(31696002)(86362001)(3846002)(6246003)(97736004)(72206003)(6116002)(44832011)(186003)(6506007)(25786009)(386003)(26005)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3005;H:VI1PR08MB4110.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bIkREMUvgKEwN0TC1utglPQkCXPfwV0acZHWytnCAOmeBtGwbmvI/N8B/VHIxT5khRVK598iehMVggkN+Rp2L07md1Y0x1+xHst/aqKdzx0l8ywp03BJJQsBgOeal7au5soKctdqQyWI8/WVWYoYKI1i4dKw0DB7+praYgqEDJ8XCHsCB3uXcP5AqbJO6cFJ9LZBjENz090UY+5PNlJYq12wtPqMRrEeT2T/DdOmoqSFlZXC1D3zGNWS0Wnu/1xcTjwwkduWryc+QIyVJ4c3yyBmULRCyGVgdFoWgixnoGbYOU0EOBSxtttad6oHyv80Sre4BxwEZA0vHjZI+8EL44RqaGrPyaHg5VQjVdCODfW8dmyepvdcesK1oxTHAesPqO5swvn5F3BnCebfLrj2D2dZX966EcUE87TVMz5gZ4A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B546F36F8956E44E96B785BFE1F9DDC5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc37863-2896-4b27-55bb-08d67be09f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 18:29:58.7111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcvMTIvMjAxOCAwNjoxMywgTG9rZXNoIFZ1dGxhIHdyb3RlOg0KPiBQcmV2aW91c2x5IGFs
bCBtc2kgZm9yIGEgZGV2aWNlIGFyZSBhbGxvY2F0ZWQgaW4gb25lIGdvDQo+IGJ5IGNhbGxpbmcg
bXNpX2RvbWFpbl9hbGxvY19pcnEoKSBmcm9tIGEgYnVzIGxheWVyLiBUaGlzIG1pZ2h0DQo+IG5v
dCBiZSB0aGUgY2FzZSB3aGVuIGEgZGV2aWNlIGlzIHRyeWluZyB0byBhbGxvY2F0ZSBpbnRlcnJ1
cHRzDQo+IGR5bmFtaWNhbGx5IGJhc2VkIG9uIGEgcmVxdWVzdCB0byBpdC4NCj4NCj4gU28gaW50
cm9kdWNlIG1zaV9kb21haW5fYWxsb2MvZnJlZV9pcnEoKSBhcGlzIHRvIGFsbG9jYXRlIGEgc2lu
Z2xlDQo+IG1zaS4gcHJlcGFyZSBhbmQgYWN0aXZhdGUgb3BlcmF0aW9ucyB0byBiZSBoYW5kbGVk
IGJ5IGJ1cyBsYXllcg0KPiBjYWxsaW5nIG1zaV9kb21haW5fYWxsb2MvZnJlZV9pcnEoKSBhcGlz
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBMb2tlc2ggVnV0bGEgPGxva2VzaHZ1dGxhQHRpLmNvbT4N
Cj4gLS0tDQo+ICBpbmNsdWRlL2xpbnV4L21zaS5oIHwgIDMgKysrDQo+ICBrZXJuZWwvaXJxL21z
aS5jICAgIHwgNjIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tc2kuaCBiL2luY2x1ZGUvbGludXgvbXNp
LmgNCj4gaW5kZXggNzg0ZmI1MmI5OTAwLi40NzQ0OTA4MjZmOGMgMTAwNjQ0DQo+IC0tLSBhL2lu
Y2x1ZGUvbGludXgvbXNpLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9tc2kuaA0KPiBAQCAtMzAx
LDggKzMwMSwxMSBAQCBpbnQgbXNpX2RvbWFpbl9zZXRfYWZmaW5pdHkoc3RydWN0IGlycV9kYXRh
ICpkYXRhLCBjb25zdCBzdHJ1Y3QgY3B1bWFzayAqbWFzaywNCj4gIHN0cnVjdCBpcnFfZG9tYWlu
ICptc2lfY3JlYXRlX2lycV9kb21haW4oc3RydWN0IGZ3bm9kZV9oYW5kbGUgKmZ3bm9kZSwNCj4g
ICBzdHJ1Y3QgbXNpX2RvbWFpbl9pbmZvICppbmZvLA0KPiAgIHN0cnVjdCBpcnFfZG9tYWluICpw
YXJlbnQpOw0KPiAraW50IG1zaV9kb21haW5fYWxsb2NfaXJxKHN0cnVjdCBpcnFfZG9tYWluICpk
b21haW4sIHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gKyBzdHJ1Y3QgbXNpX2Rlc2MgKmRlc2MsICBt
c2lfYWxsb2NfaW5mb190ICphcmcpOw0KPiAgaW50IG1zaV9kb21haW5fYWxsb2NfaXJxcyhzdHJ1
Y3QgaXJxX2RvbWFpbiAqZG9tYWluLCBzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAgIGludCBudmVj
KTsNCj4gK3ZvaWQgbXNpX2RvbWFpbl9mcmVlX2lycShzdHJ1Y3QgbXNpX2Rlc2MgKmRlc2MpOw0K
PiAgdm9pZCBtc2lfZG9tYWluX2ZyZWVfaXJxcyhzdHJ1Y3QgaXJxX2RvbWFpbiAqZG9tYWluLCBz
dHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgc3RydWN0IG1zaV9kb21haW5faW5mbyAqbXNpX2dldF9k
b21haW5faW5mbyhzdHJ1Y3QgaXJxX2RvbWFpbiAqZG9tYWluKTsNCj4NCj4gZGlmZiAtLWdpdCBh
L2tlcm5lbC9pcnEvbXNpLmMgYi9rZXJuZWwvaXJxL21zaS5jDQo+IGluZGV4IGFkMjZmYmNmYmZj
OC4uZWI3NDU5MzI0MTEzIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvaXJxL21zaS5jDQo+ICsrKyBi
L2tlcm5lbC9pcnEvbXNpLmMNCj4gQEAgLTM4Nyw2ICszODcsMzUgQEAgc3RhdGljIGJvb2wgbXNp
X2NoZWNrX3Jlc2VydmF0aW9uX21vZGUoc3RydWN0IGlycV9kb21haW4gKmRvbWFpbiwNCj4gIHJl
dHVybiBkZXNjLT5tc2lfYXR0cmliLmlzX21zaXggfHwgZGVzYy0+bXNpX2F0dHJpYi5tYXNrYml0
Ow0KPiAgfQ0KPg0KPiAraW50IG1zaV9kb21haW5fYWxsb2NfaXJxKHN0cnVjdCBpcnFfZG9tYWlu
ICpkb21haW4sIHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gKyBzdHJ1Y3QgbXNpX2Rlc2MgKmRlc2Ms
ICBtc2lfYWxsb2NfaW5mb190ICphcmcpDQo+ICt7DQo+ICtzdHJ1Y3QgbXNpX2RvbWFpbl9pbmZv
ICppbmZvID0gZG9tYWluLT5ob3N0X2RhdGE7DQo+ICtzdHJ1Y3QgbXNpX2RvbWFpbl9vcHMgKm9w
cyA9IGluZm8tPm9wczsNCj4gK2ludCBpLCByZXQsIHZpcnE7DQo+ICsNCj4gK29wcy0+c2V0X2Rl
c2MoYXJnLCBkZXNjKTsNCj4gKw0KPiArdmlycSA9IF9faXJxX2RvbWFpbl9hbGxvY19pcnFzKGRv
bWFpbiwgLTEsIGRlc2MtPm52ZWNfdXNlZCwNCj4gKyAgICAgICBkZXZfdG9fbm9kZShkZXYpLCBh
cmcsIGZhbHNlLA0KPiArICAgICAgIGRlc2MtPmFmZmluaXR5KTsNCj4gK2lmICh2aXJxIDwgMCkg
ew0KPiArcmV0ID0gLUVOT1NQQzsNCj4gK2lmIChvcHMtPmhhbmRsZV9lcnJvcikNCj4gK3JldCA9
IG9wcy0+aGFuZGxlX2Vycm9yKGRvbWFpbiwgZGVzYywgcmV0KTsNCj4gK2lmIChvcHMtPm1zaV9m
aW5pc2gpDQo+ICtvcHMtPm1zaV9maW5pc2goYXJnLCByZXQpOw0KPiArcmV0dXJuIHJldDsNCj4g
K30NCj4gKw0KPiArZm9yIChpID0gMDsgaSA8IGRlc2MtPm52ZWNfdXNlZDsgaSsrKSB7DQo+ICtp
cnFfc2V0X21zaV9kZXNjX29mZih2aXJxLCBpLCBkZXNjKTsNCj4gK2lycV9kZWJ1Z2ZzX2NvcHlf
ZGV2bmFtZSh2aXJxICsgaSwgZGV2KTsNCj4gK30NCj4gKw0KPiArcmV0dXJuIDA7DQo+ICt9DQo+
ICsNCj4gIC8qKg0KPiAgICogbXNpX2RvbWFpbl9hbGxvY19pcnFzIC0gQWxsb2NhdGUgaW50ZXJy
dXB0cyBmcm9tIGEgTVNJIGludGVycnVwdCBkb21haW4NCj4gICAqIEBkb21haW46VGhlIGRvbWFp
biB0byBhbGxvY2F0ZSBmcm9tDQo+IEBAIC00MDQsNyArNDMzLDcgQEAgaW50IG1zaV9kb21haW5f
YWxsb2NfaXJxcyhzdHJ1Y3QgaXJxX2RvbWFpbiAqZG9tYWluLCBzdHJ1Y3QgZGV2aWNlICpkZXYs
DQo+ICBzdHJ1Y3QgaXJxX2RhdGEgKmlycV9kYXRhOw0KPiAgc3RydWN0IG1zaV9kZXNjICpkZXNj
Ow0KPiAgbXNpX2FsbG9jX2luZm9fdCBhcmc7DQo+IC1pbnQgaSwgcmV0LCB2aXJxOw0KPiAraW50
IHJldCwgdmlycTsNCj4gIGJvb2wgY2FuX3Jlc2VydmU7DQo+DQo+ICByZXQgPSBtc2lfZG9tYWlu
X3ByZXBhcmVfaXJxcyhkb21haW4sIGRldiwgbnZlYywgJmFyZyk7DQo+IEBAIC00MTIsMjQgKzQ0
MSw5IEBAIGludCBtc2lfZG9tYWluX2FsbG9jX2lycXMoc3RydWN0IGlycV9kb21haW4gKmRvbWFp
biwgc3RydWN0IGRldmljZSAqZGV2LA0KPiAgcmV0dXJuIHJldDsNCj4NCj4gIGZvcl9lYWNoX21z
aV9lbnRyeShkZXNjLCBkZXYpIHsNCj4gLW9wcy0+c2V0X2Rlc2MoJmFyZywgZGVzYyk7DQo+IC0N
Cj4gLXZpcnEgPSBfX2lycV9kb21haW5fYWxsb2NfaXJxcyhkb21haW4sIC0xLCBkZXNjLT5udmVj
X3VzZWQsDQo+IC0gICAgICAgZGV2X3RvX25vZGUoZGV2KSwgJmFyZywgZmFsc2UsDQo+IC0gICAg
ICAgZGVzYy0+YWZmaW5pdHkpOw0KPiAtaWYgKHZpcnEgPCAwKSB7DQo+IC1yZXQgPSAtRU5PU1BD
Ow0KPiAtaWYgKG9wcy0+aGFuZGxlX2Vycm9yKQ0KPiAtcmV0ID0gb3BzLT5oYW5kbGVfZXJyb3Io
ZG9tYWluLCBkZXNjLCByZXQpOw0KPiAtaWYgKG9wcy0+bXNpX2ZpbmlzaCkNCj4gLW9wcy0+bXNp
X2ZpbmlzaCgmYXJnLCByZXQpOw0KPiArcmV0ID0gbXNpX2RvbWFpbl9hbGxvY19pcnEoZG9tYWlu
LCBkZXYsIGRlc2MsICZhcmcpOw0KPiAraWYgKHJldCkNCj4gIHJldHVybiByZXQ7DQo+IC19DQo+
IC0NCj4gLWZvciAoaSA9IDA7IGkgPCBkZXNjLT5udmVjX3VzZWQ7IGkrKykgew0KPiAtaXJxX3Nl
dF9tc2lfZGVzY19vZmYodmlycSwgaSwgZGVzYyk7DQo+IC1pcnFfZGVidWdmc19jb3B5X2Rldm5h
bWUodmlycSArIGksIGRldik7DQo+IC19DQo+ICB9DQo+DQo+ICBpZiAob3BzLT5tc2lfZmluaXNo
KQ0KPiBAQCAtNDg3LDYgKzUwMSwxMiBAQCBpbnQgbXNpX2RvbWFpbl9hbGxvY19pcnFzKHN0cnVj
dCBpcnFfZG9tYWluICpkb21haW4sIHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gIHJldHVybiByZXQ7
DQo+ICB9DQo+DQo+ICt2b2lkIG1zaV9kb21haW5fZnJlZV9pcnEoc3RydWN0IG1zaV9kZXNjICpk
ZXNjKQ0KPiArew0KPiAraXJxX2RvbWFpbl9mcmVlX2lycXMoZGVzYy0+aXJxLCBkZXNjLT5udmVj
X3VzZWQpOw0KPiArZGVzYy0+aXJxID0gMDsNCj4gK30NCj4gKw0KPiAgLyoqDQo+ICAgKiBtc2lf
ZG9tYWluX2ZyZWVfaXJxcyAtIEZyZWUgaW50ZXJydXB0cyBmcm9tIGEgTVNJIGludGVycnVwdCBA
ZG9tYWluIGFzc29jaWF0ZWQgdHAgQGRldg0KPiAgICogQGRvbWFpbjpUaGUgZG9tYWluIHRvIG1h
bmFnaW5nIHRoZSBpbnRlcnJ1cHRzDQo+IEBAIC01MDMsMTAgKzUyMyw4IEBAIHZvaWQgbXNpX2Rv
bWFpbl9mcmVlX2lycXMoc3RydWN0IGlycV9kb21haW4gKmRvbWFpbiwgc3RydWN0IGRldmljZSAq
ZGV2KQ0KPiAgICogZW5vdWdoIHRoYXQgdGhlcmUgaXMgbm8gSVJRIGFzc29jaWF0ZWQgdG8gdGhp
cw0KPiAgICogZW50cnkuIElmIHRoYXQncyB0aGUgY2FzZSwgZG9uJ3QgZG8gYW55dGhpbmcuDQo+
ICAgKi8NCj4gLWlmIChkZXNjLT5pcnEpIHsNCj4gLWlycV9kb21haW5fZnJlZV9pcnFzKGRlc2Mt
PmlycSwgZGVzYy0+bnZlY191c2VkKTsNCj4gLWRlc2MtPmlycSA9IDA7DQo+IC19DQo+ICtpZiAo
ZGVzYy0+aXJxKQ0KPiArbXNpX2RvbWFpbl9mcmVlX2lycShkZXNjKTsNCj4gIH0NCj4gIH0NCj4N
Cj4NCg0KSSBjYW4gc2VlIHNvbWUgaW50ZXJlc3RpbmcgaXNzdWVzIHdpdGggdGhpcyBBUEkuDQoN
CkF0IHRoZSBtb21lbnQsIE1TSXMgYXJlIGFsbG9jYXRlZCB1cGZyb250LCBhbmQgdGhhdCdzIHVz
dWFsbHkgZG9uZQ0KYmVmb3JlIHRoZSBkcml2ZXIgY2FuIGRvIGFueXRoaW5nIGVsc2UuIFdpdGgg
d2hhdCB5b3UncmUgc3VnZ2VzdGluZw0KaGVyZSwgTVNJcyBjYW4gbm93IGJlIGFsbG9jYXRlZCBh
dCBhbnkgdGltZSwgd2hpY2ggc291bmRzIGdyZWF0LiBCdXQgaG93DQpkb2VzIGl0IHdvcmsgd2hl
biBNU0lzIGdldCBhZGRlZC9mcmVlZCBpbiBwYXJhbGxlbD8gSSBjYW4ndCBzZWUgYW55DQpsb2Nr
aW5nIGhlcmUuLi4NCg0KSXQgaXMgYWxzbyBwcmV0dHkgbmFzdHkgdGhhdCB0aGUgdXNlciBvZiB0
aGlzIEFQSSBoYXMgdG8ga25vdyBhYm91dCB0aGUNCk1TSSBkZXNjcmlwdG9yLiBSZWFsbHksIG5v
Ym9keSBzaG91bGQgaGF2ZSB0byBkZWFsIHdpdGggdGhpcyBvdXRzaWRlIG9mDQp0aGUgTVNJIGxh
eWVyLg0KDQpUaGUgcmVhbCBxdWVzdGlvbiBpcyB3aHkgeW91IG5lZWQgdG8gbmVlZCB0byBhbGxv
Y2F0ZSBNU0lzIG9uIGRlbWFuZCBmb3INCmEgZ2l2ZW4gZGV2aWNlLiBVc3VhbGx5LCB5b3UgYWxs
b2NhdGUgdGhlbSBiZWNhdXNlIHRoaXMgaXMgYSBwZXItQ1BVDQpyZXNvdXJjZSwgb3Igc29tZXRo
aW5nIHNpbWlsYXIuIFdoYXQgbWFrZXMgaXQgc28gdmFyaWFibGUgdGhhdCB5b3UgbmVlZA0KdG8g
cmVzb3J0IHRvIGZpbmUgZ3JhaW5lZCBNU0kgYWxsb2NhdGlvbj8NCg0KVGhhbmtzLA0KDQpNLg0K
LS0NCkphenogaXMgbm90IGRlYWQuIEl0IGp1c3Qgc21lbGxzIGZ1bm55Li4uDQpJTVBPUlRBTlQg
Tk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFy
ZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlh
dGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29u
LCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlv
biBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=

Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271DFC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D261C2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="ewNRjBWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfA2Ug6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:36:58 -0500
Received: from mail-eopbgr20090.outbound.protection.outlook.com ([40.107.2.90]:6162
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727010AbfA2Ug6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmPKW/f8mVgOaJstWU/7pcC+SEeNr/VaPw1VmyPoEfE=;
 b=ewNRjBWcFHbZQNicpplHJlmOSIq/xNvRAbjeA5VBJ+VcCNLhONP93V0U+6gHMuKqUtYsIceT3G944LTwv6K8xQKNzPbIJ4Kzt9dY9YjEH4/a5BEh0eEg6sfxhhorADzeVpIjHxaxumeVKMamnvmjasLcTDeSzt0p8oSc/dYXnlI=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2350.EURPRD10.PROD.OUTLOOK.COM (20.177.62.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 20:35:13 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b%5]) with mapi id 15.20.1558.025; Tue, 29 Jan 2019
 20:35:13 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Esben Haabendal <esben@haabendal.dk>,
        "martin@hundeboll.net" <martin@hundeboll.net>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: Re: [PATCH v9 1/3] watchdog: introduce watchdog.open_timeout
 commandline parameter
Thread-Topic: [PATCH v9 1/3] watchdog: introduce watchdog.open_timeout
 commandline parameter
Thread-Index: AQHUscpEwvUxada9K0KrXhhGLz87qKW7jIGAgAs0LAA=
Date:   Tue, 29 Jan 2019 20:35:13 +0000
Message-ID: <de4bd94c-d2f7-66c2-6386-8b1cec57af03@prevas.dk>
References: <20190116121432.26732-1-rasmus.villemoes@prevas.dk>
 <20190121204527.5548-1-rasmus.villemoes@prevas.dk>
 <20190121204527.5548-2-rasmus.villemoes@prevas.dk>
 <20190122172935.GA4964@roeck-us.net>
In-Reply-To: <20190122172935.GA4964@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0016.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::29)
 To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [5.186.119.68]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR10MB2350;6:L4IJXUvSGKhWDOUzL9bVxOF90bfAZDQzoK5e6WycsAugkph6/T+Jei9RTabkO9oEW0+bSdJc8vt5yjUwfZrw39KvsMzjao/pjVJWWipPwcNRZVXmNMR0wARus6UoSEV09ogLFYywEyMG0TCAjVB61vBiBIIdUhTNxWjBi2D1nE9UiZxxShjBvTxuoovUb+FASW7r1GPKtk1w08TzSNhzwYca/N7wu4lQ/lyEvNeYozQVX6MckdBgZNqKbEzxIgXqnpe1P1+wnus6Iy44SF1zEFDjbYFvQfIhYIpfYZnCfVKOBbZlsBML/ltlc+IE24Sn1hAgJRHy0wCzkyuFoBHkKs3uvxGLEeZLkKygp2acFj57knEFiVVRer2NkUqjbY+l7TiciAN/5S469KAE2FQjh42jQiFyfR/Ttrxy5KXSqFjzUZc3E4gt5danfmW5AWLjF22JqvqNjYMUoQVkACiUlg==;5:6OIT0Q91rw/9YQOjx4AJQmyJ0duSzgivnV+6DOY6vTM1bQnO1+Qo18AxCO4Oy7UiBhsT7138+haJ55J+8FSSskP0ZXqPpl3yb0YfI7B3zatMtYD3J9AnPg5NV5P0yhEaD+hoURRrXm8+17CgwmYXUDSvXl4YXKyldY7tBQOTNVLBWJ0NFAKDagAdKIGy2Xm4OAnyH/f4So6B8EAKQs6LzQ==;7:HTnPVdT1uWeFmHDgLOnBWfhFkZod66DE/IH4jDl00VapNY2gv6lZJZcOkvMPzEdwQrS2HAvUZaTSSta23+Hp6WZmE6sk/6HDeWiyWy4q0BSjFXQ9BfsMrk9noSxbdS/4Mloxza6pXtjlYH4Mc6Q15A==
x-ms-office365-filtering-correlation-id: ec925ede-1abd-4e52-e704-08d6862944fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2350;
x-ms-traffictypediagnostic: VI1PR10MB2350:
x-microsoft-antispam-prvs: <VI1PR10MB23500BABD8CE09AE373C33158A970@VI1PR10MB2350.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39850400004)(346002)(376002)(136003)(189003)(199004)(43544003)(31696002)(446003)(107886003)(7736002)(2616005)(486006)(386003)(11346002)(66066001)(26005)(305945005)(476003)(68736007)(8936002)(44832011)(42882007)(6246003)(6916009)(71190400001)(102836004)(6506007)(71446004)(71200400001)(8976002)(53936002)(81156014)(8676002)(229853002)(3846002)(74482002)(6116002)(81166006)(186003)(99286004)(14454004)(6436002)(6512007)(316002)(6486002)(31686004)(105586002)(256004)(25786009)(54906003)(93886005)(97736004)(36756003)(14444005)(52116002)(76176011)(72206003)(106356001)(478600001)(4326008)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2350;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6aKIUGaa8hf8lcraw+dSTMWg2CtxLDDsWt56nuk5Ty42G9nVWS1kgHgiNumoPvpa0KADtVrUVv+wCCyXe3LQaln0u0y6L9t+FSXXLGGucpyRO6pBpC/5oDFlcAiWtcd5U4mtOXvu3aIcQXF3+cQZ60YBSyFawQj1IkGaJo0R8aKlhQsN879fHHBm3ZMjHMKQDiuRPsyd66fsCZcDgUj2Kzj66PxXCYbztBPT6Jm6fvY0tOJAR18QLk5FzCxdKwR2BXgXIt0l4LqHgaGRaFXQraNWwlezexxL2040hGOkC+zTmflyXtPfUTrwoVCFFZE5hZih15zkMDCLYLledTA/O3cLBNb+yLaL0j0v9Z8CkJNThMfoMng4/K448ygEnY72JY4+O24s8D5lrFydQAjBlW4AvBLjUgqEHVkfZfnvw+U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22C123DE27BDC840854FFC2A0806D422@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ec925ede-1abd-4e52-e704-08d6862944fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 20:35:12.1391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2350
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIvMDEvMjAxOSAxOC4yOSwgR3VlbnRlciBSb2VjayB3cm90ZToNCj4gT24gTW9uLCBKYW4g
MjEsIDIwMTkgYXQgMDg6NDU6MzlQTSArMDAwMCwgUmFzbXVzIFZpbGxlbW9lcyB3cm90ZToNCj4+
IFRoZSB3YXRjaGRvZyBmcmFtZXdvcmsgdGFrZXMgY2FyZSBvZiBmZWVkaW5nIGEgaGFyZHdhcmUg
d2F0Y2hkb2cgdW50aWwNCj4+IHVzZXJzcGFjZSBvcGVucyAvZGV2L3dhdGNoZG9nTi4gSWYgdGhh
dCBuZXZlciBoYXBwZW5zIGZvciBzb21lIHJlYXNvbg0KPj4gKGJ1Z2d5IGluaXQgc2NyaXB0LCBj
b3JydXB0IHJvb3QgZmlsZXN5c3RlbSBvciB3aGF0bm90KSBidXQgdGhlIGtlcm5lbA0KPj4gaXRz
ZWxmIGlzIGZpbmUsIHRoZSBtYWNoaW5lIHN0YXlzIHVwIGluZGVmaW5pdGVseS4gVGhpcyBwYXRj
aCBhbGxvd3MNCj4+IHNldHRpbmcgYW4gdXBwZXIgbGltaXQgZm9yIGhvdyBsb25nIHRoZSBrZXJu
ZWwgd2lsbCB0YWtlIGNhcmUgb2YgdGhlDQo+PiB3YXRjaGRvZywgdGh1cyBlbnN1cmluZyB0aGF0
IHRoZSB3YXRjaGRvZyB3aWxsIGV2ZW50dWFsbHkgcmVzZXQgdGhlDQo+PiBtYWNoaW5lLg0KPj4N
Cj4+IEEgdmFsdWUgb2YgMCAodGhlIGRlZmF1bHQpIG1lYW5zIGluZmluaXRlIHRpbWVvdXQsIHBy
ZXNlcnZpbmcgdGhlDQo+PiBjdXJyZW50IGJlaGF2aW91ci4NCj4+DQo+PiBUaGlzIGlzIHBhcnRp
Y3VsYXJseSB1c2VmdWwgZm9yIGVtYmVkZGVkIGRldmljZXMgd2hlcmUgc29tZSBmYWxsYmFjaw0K
Pj4gbG9naWMgaXMgaW1wbGVtZW50ZWQgaW4gdGhlIGJvb3Rsb2FkZXIgKGUuZy4sIHVzZSBhIGRp
ZmZlcmVudCByb290DQo+PiBwYXJ0aXRpb24sIGJvb3QgZnJvbSBuZXR3b3JrLCAuLi4pLg0KPj4N
Cj4+IFRoZXJlIGlzIGFscmVhZHkgaGFuZGxlX2Jvb3RfZW5hYmxlZCBzZXJ2aW5nIGEgc2ltaWxh
ciBwdXJwb3NlLiBIb3dldmVyLA0KPj4gc3VjaCBhIGJpbmFyeSBjaG9pY2UgaXMgdW5zdWl0YWJs
ZSBpZiB0aGUgaGFyZHdhcmUgd2F0Y2hkb2cgY2Fubm90IGJlDQo+PiBwcm9ncmFtbWVkIGJ5IHRo
ZSBib290bG9hZGVyIHRvIHByb3ZpZGUgYSB0aW1lb3V0IGxvbmcgZW5vdWdoIGZvcg0KPj4gdXNl
cnNwYWNlIHRvIGdldCB1cCBhbmQgcnVubmluZy4gTWFueSBvZiB0aGUgZW1iZWRkZWQgZGV2aWNl
cyB3ZSBzZWUgdXNlDQo+PiBleHRlcm5hbCAoZ3Bpby10cmlnZ2VyZWQpIHdhdGNoZG9ncyB3aXRo
IGEgZml4ZWQgdGltZW91dCBvZiB0aGUgb3JkZXIgb2YNCj4+IDEtMiBzZWNvbmRzLg0KPj4NCj4+
IFRoZSBvcGVuIHRpbWVvdXQgaXMgYWxzbyB1c2VkIGFzIGEgbWF4aW11bSB0aW1lIGZvciBhbiBh
cHBsaWNhdGlvbiB0bw0KPj4gcmUtb3BlbiAvZGV2L3dhdGNoZG9nTiBhZnRlciBjbG9zaW5nIGl0
LiBBZ2Fpbiwgd2hpbGUgdGhlIGtlcm5lbCBhbHJlYWR5DQo+PiBoYXMgYSBub3dheW91dCBtZWNo
YW5pc20sIHVzaW5nIHRoYXQgbWVhbnMgdXNlcnNwYWNlIGlzIGF0IHRoZSBtZXJjeSBvZg0KPj4g
d2hhdGV2ZXIgdGltZW91dCB0aGUgaGFyZHdhcmUgaGFzLg0KPj4NCj4+IEJlaW5nIGEgbW9kdWxl
IHBhcmFtZXRlciwgb25lIGNhbiByZXZlcnQgdG8gdGhlIG9yZGluYXJ5IGJlaGF2aW91ciBvZg0K
Pj4gaGF2aW5nIHRoZSBrZXJuZWwgbWFpbnRhaW4gdGhlIHdhdGNoZG9nIGluZGVmaW5pdGVseSBi
eSBzaW1wbHkgd3JpdGluZyAwDQo+PiB0byAvc3lzLy4uLiBhZnRlciBpbml0aWFsbHkgb3Blbmlu
ZyAvZGV2L3dhdGNoZG9nOyBjb252ZXJzZWx5LCBvbmUgY2FuDQo+PiBvZiBjb3Vyc2UgYWxzbyBo
YXZlIHRoZSBjdXJyZW50IGJlaGF2aW91ciBvZiBhbGxvd2luZyBpbmRlZmluaXRlIHRpbWUNCj4+
IHVudGlsIHRoZSBmaXJzdCBvcGVuLCBhbmQgdGhlbiBzZXQgdGhhdCBtb2R1bGUgcGFyYW1ldGVy
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFJhc211cyBWaWxsZW1vZXMgPHJhc211cy52aWxsZW1v
ZXNAcHJldmFzLmRrPg0KPj4gLS0tDQo+PiAgLi4uL3dhdGNoZG9nL3dhdGNoZG9nLXBhcmFtZXRl
cnMudHh0ICAgICAgICAgIHwgIDggKysrKysNCj4+ICBkcml2ZXJzL3dhdGNoZG9nL3dhdGNoZG9n
X2Rldi5jICAgICAgICAgICAgICAgfCAzMCArKysrKysrKysrKysrKysrKy0tDQo+PiAgMiBmaWxl
cyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL3dhdGNoZG9nL3dhdGNoZG9nLXBhcmFtZXRlcnMudHh0IGIv
RG9jdW1lbnRhdGlvbi93YXRjaGRvZy93YXRjaGRvZy1wYXJhbWV0ZXJzLnR4dA0KPj4gaW5kZXgg
MGI4OGUzMzNmOWUxLi45MDdjNGJiMTM4MTAgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9u
L3dhdGNoZG9nL3dhdGNoZG9nLXBhcmFtZXRlcnMudHh0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9u
L3dhdGNoZG9nL3dhdGNoZG9nLXBhcmFtZXRlcnMudHh0DQo+PiBAQCAtOCw2ICs4LDE0IEBAIFNl
ZSBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnJzdCBmb3IgaW5m
b3JtYXRpb24gb24NCj4+ICBwcm92aWRpbmcga2VybmVsIHBhcmFtZXRlcnMgZm9yIGJ1aWx0aW4g
ZHJpdmVycyB2ZXJzdXMgbG9hZGFibGUNCj4+ICBtb2R1bGVzLg0KPj4gIA0KPj4gK1RoZSB3YXRj
aGRvZyBjb3JlIHBhcmFtZXRlciB3YXRjaGRvZy5vcGVuX3RpbWVvdXQgaXMgdGhlIG1heGltdW0g
dGltZSwNCj4+ICtpbiBzZWNvbmRzLCBmb3Igd2hpY2ggdGhlIHdhdGNoZG9nIGZyYW1ld29yayB3
aWxsIHRha2UgY2FyZSBvZiBwaW5naW5nDQo+PiArYSBoYXJkd2FyZSB3YXRjaGRvZyB1bnRpbCB1
c2Vyc3BhY2Ugb3BlbnMgdGhlIGNvcnJlc3BvbmRpbmcNCj4+ICsvZGV2L3dhdGNoZG9nTiBkZXZp
Y2UuIEEgdmFsdWUgb2YgMCAodGhlIGRlZmF1bHQpIG1lYW5zIGFuIGluZmluaXRlDQo+PiArdGlt
ZW91dC4gU2V0dGluZyB0aGlzIHRvIGEgbm9uLXplcm8gdmFsdWUgY2FuIGJlIHVzZWZ1bCB0byBl
bnN1cmUgdGhhdA0KPj4gK2VpdGhlciB1c2Vyc3BhY2UgY29tZXMgdXAgcHJvcGVybHksIG9yIHRo
ZSBib2FyZCBnZXRzIHJlc2V0IGFuZCBhbGxvd3MNCj4+ICtmYWxsYmFjayBsb2dpYyBpbiB0aGUg
Ym9vdGxvYWRlciB0byB0cnkgc29tZXRoaW5nIGVsc2UuDQo+PiArDQo+IA0KPiBUaGlzIGlzIG1p
c2xlYWRpbmcuIFVubGVzcyBJIGFtIG1pc3Npbmcgc29tZXRoaW5nLCB0aGUgYWJvdmUgb25seSBh
cHBsaWVzDQo+IGlmIHRoZSB3YXRjaGRvZyBpcyBhbHJlYWR5IHJ1bm5uaW5nIGF0IGJvb3QsDQoN
CndlbGwsIHllcywgaWYgaXQncyBub3QgcnVubmluZyBhdCBib290LCB0aGVyZSdzIG5vdGhpbmcg
Zm9yIHRoZSBrZXJuZWwNCnRvIHRha2UgY2FyZSBvZi4gSSBjYW4gZG8gcy9hIGhhcmR3YXJlIHdh
dGNoZG9nL2EgcnVubmluZyBoYXJkd2FyZQ0Kd2F0Y2hkb2cvIGlmIHRoYXQgbWFrZXMgaXQgY2xl
YXJlci4NCg0KIGFuZCBhZnRlciBpdCBoYXMgYmVlbiBvcGVuZWQNCj4gYW5kIGNsb3NlZCBvbmNl
Lg0KPiANCj4gRldJVywgSSBmaW5kIHRoaXMgb3BlcmF0aW9uIHF1aXRlIGNvbmZ1c2luZy4gV2hh
dCBpcyB0aGUgcmF0aW9uYWxlIGZvciBub3QNCj4gc3RhcnRpbmcgdGhlIHdhdGNoZG9nIGF0IGJv
b3QgdGltZSBpZiBpdCBpcyBub3QgcnVubmluZyBhbmQgb3Blbl90aW1lb3V0DQo+IGlzIHNldCwg
YnV0IHRoZW4gcmVmdXNpbmcgdG8gc3RvcCBpdCBhZnRlciBpdCBoYXMgYmVlbiBzdGFydGVkIG9u
Y2UgPw0KDQpJIGd1ZXNzIHlvdSBoYXZlIGEgcG9pbnQgdGhhdCB0aGVyZSdzIGEgY2VydGFpbiBh
c3ltbWV0cnkgdGhlcmUuIEluDQpwcmFjdGljZSwgdGhlIGNhc2VzIHdoZXJlIG9uZSB3YW50cyB0
aGlzIGtpbmQgb2Ygcm9idXN0bmVzcyBndWFyYW50ZWUgZG8NCm5vdCByZWx5IG9uIGEgd2F0Y2hk
b2cgdGhhdCBjYW4vbXVzdCBiZSBzdGFydGVkIGFuZCBzdG9wcGVkIGJ5IHNvZnR3YXJlLg0KDQo+
PiAgDQo+PiAgc3RhdGljIHZvaWQgd2F0Y2hkb2dfcGluZ193b3JrKHN0cnVjdCBrdGhyZWFkX3dv
cmsgKndvcmspDQo+PiBAQCAtMjk3LDcgKzMxNyw3IEBAIHN0YXRpYyBpbnQgd2F0Y2hkb2dfc3Rv
cChzdHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNlICp3ZGQpDQo+PiAgCQlyZXR1cm4gLUVCVVNZOw0KPj4g
IAl9DQo+PiAgDQo+PiAtCWlmICh3ZGQtPm9wcy0+c3RvcCkgew0KPj4gKwlpZiAod2RkLT5vcHMt
PnN0b3AgJiYgIW9wZW5fdGltZW91dCkgew0KPiANCj4gVGhpcyBjaGFuZ2VzIHRoZSBzZW1hbnRp
Y3Mgb2YgV0RJT0NfU0VUT1BUSU9OUyAvIFdESU9TX0RJU0FCTEVDQVJELg0KPiAiVHVybiBvZmYg
dGhlIHdhdGNoZG9nIHRpbWVyIiBpcyB3ZWxsIGRlZmluZWQgYW5kIGRvZXNuJ3QgbGVhdmUNCj4g
dGhlIG9wdGlvbiBvZiBzZXR0aW5nIGEgdGltZW91dCBvbiBpdC4NCg0KSSBjYW4gZHJvcCB0aGlz
IGh1bmssIHNpbmNlIGl0J3MgbW9zdGx5IGlycmVsZXZhbnQgdG8gdGhlIGFjdHVhbCB1c2UNCmNh
c2VzIEkgaGF2ZSBpbiBtaW5kLiBJdCBtYWtlcyB0ZXN0aW5nIHRoZSBmZWF0dXJlIG9uIHJlZmVy
ZW5jZSBib2FyZHMgYQ0KbGl0dGxlIG1vcmUgYXdrd2FyZCwgYnV0IEkgY2FuIGxpdmUgd2l0aCB0
aGF0Lg0KDQo+PiArDQo+PiArbW9kdWxlX3BhcmFtKG9wZW5fdGltZW91dCwgdWludCwgMDY0NCk7
DQo+PiArTU9EVUxFX1BBUk1fREVTQyhvcGVuX3RpbWVvdXQsDQo+PiArCSJNYXhpbXVtIHRpbWUg
KGluIHNlY29uZHMsIDAgbWVhbnMgaW5maW5pdHkpIGZvciB1c2Vyc3BhY2UgdG8gdGFrZSBvdmVy
IGEgcnVubmluZyB3YXRjaGRvZyAoZGVmYXVsdD0wKSIpOw0KPiANCj4gVGhlIGRlc2NyaXB0aW9u
IGlzIG1pc2xlYWRpbmcuIEFmdGVyIHRoZSBpbml0aWFsIG9wZW4sIGEgc3Vic2VxdWVudCBjbG9z
ZSBubw0KPiBsb25nZXIgcmVhbGx5IHN0b3BzIHRoZSB3YXRjaGRvZy4NCg0KSWYgSSBkcm9wIHRo
ZSAiJiYgIW9wZW5fdGltZW91dCIgYWJvdmUsIHRoaXMgd291bGQgYmUgYWNjdXJhdGUsIG5vPw0K
DQpSYXNtdXMNCg==

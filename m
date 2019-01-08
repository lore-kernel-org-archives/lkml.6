Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDE4C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8334206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="RnAYvGm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfAHS0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:26:19 -0500
Received: from mail-eopbgr730058.outbound.protection.outlook.com ([40.107.73.58]:64416
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729418AbfAHS0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0yN0SSucHUxBXje0h65Kb/KricxyIJ/HswJajPf3MI=;
 b=RnAYvGm8jMM15mBUYvRqeQn2KBMx4xI+DFPoY0+WuUOEWtTZcH5+ao0ugL0ffvecAk08tdjTVReWkGE58GIViBXSyyTP3aGjHi/Bn2A/czvUDKRtfSugnRLM1tHBk7bgIt+fM4VHcT+fCIddR3MY8mYBPmmT/ZGQOp6os8X/QTs=
Received: from BYAPR05MB5592.namprd05.prod.outlook.com (20.177.186.153) by
 BYAPR05MB5191.namprd05.prod.outlook.com (20.177.231.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.2; Tue, 8 Jan 2019 18:25:33 +0000
Received: from BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::4a1:2561:2487:5919]) by BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::4a1:2561:2487:5919%4]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 18:25:33 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: fix DMA ops layering violations in vmwgfx
Thread-Topic: fix DMA ops layering violations in vmwgfx
Thread-Index: AQHUpMzZVFIPYaGKbE2WJhk3NBDIkqWlJeuAgAA4FoCAAFd4gA==
Date:   Tue, 8 Jan 2019 18:25:32 +0000
Message-ID: <842d92f893669381578a2d5fd31603195a2cb19f.camel@vmware.com>
References: <20190105080108.14837-1-hch@lst.de>
         <99091bb861e21d5bb4182f08dedbc494c637cc0f.camel@vmware.com>
         <20190108131227.GB6003@lst.de>
In-Reply-To: <20190108131227.GB6003@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5191;20:IT86VPAk1u+lCGeQPnIXZYDi1InpU8pJVaT3Iw2od8PWt/Bxu9ZAA58ehMZDqkUw1xZ1OnlQjz/5gW2S+CuRCm+NJkBlIhuO4v6+jTquQD+/Krt2KkOQ2r4Qrxp3WvtiSHW4ToXJLrrXJSQiufudMrBMpsMmMcK/wi53GpUO77w=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8d6de68c-b8d9-46ab-5555-08d67596ad4b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5191;
x-ms-traffictypediagnostic: BYAPR05MB5191:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB5191AC84D6E5549E4D4373E6A18A0@BYAPR05MB5191.namprd05.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(6916009)(66066001)(2906002)(229853002)(99286004)(102836004)(14454004)(6506007)(71190400001)(71200400001)(26005)(68736007)(118296001)(36756003)(2501003)(6116002)(3846002)(478600001)(5660300001)(25786009)(2351001)(6512007)(4326008)(105586002)(1730700003)(81156014)(81166006)(8676002)(86362001)(256004)(14444005)(186003)(54906003)(53936002)(6246003)(305945005)(7736002)(316002)(2616005)(446003)(6436002)(97736004)(6486002)(106356001)(5640700003)(11346002)(476003)(8936002)(486006)(76176011)(17423001)(156123004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5191;H:BYAPR05MB5592.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xOclOtaJMIgIMjr2cHTAokpAaE71j6RzN7O8k9wfRqm2aGziAWDBkJvVi4SI0UzuwsM8/Az/0TArgvimy8EsQpXgK5BQzGH3he+kkjN93u9A8H6QnIqyAzMthxtTMUuqZ20PdIYTMinOgRDGZzprRCMYAOqlGPzPPNWIq7yQn1cmJ0TnA1nlWYHpj0UAxFnQDTbElC2ZX4dhv6et8T/RrOEpvpNJ/apJVmEfLPot/G+m3gt7Grk9OIjtnUB6WZjG57IV7hazHGmm2gRl2e6b/PY30BlvrBRY6e0D8BAl/CBAzsmmxk1BaPAWcyLVnR3H
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E1EE877606E5F4190E59AE021DE7242@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6de68c-b8d9-46ab-5555-08d67596ad4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 18:25:33.0712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAxLTA4IGF0IDE0OjEyICswMTAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBP
biBUdWUsIEphbiAwOCwgMjAxOSBhdCAwOTo1MTo0NUFNICswMDAwLCBUaG9tYXMgSGVsbHN0cm9t
IHdyb3RlOg0KPiA+IEhpLCBDaHJpc3RvcGgsDQo+ID4gDQo+ID4gT24gU2F0LCAyMDE5LTAxLTA1
IGF0IDA5OjAxICswMTAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gPiA+IEhpIFRob21h
cywNCj4gPiA+IA0KPiA+ID4gdm13Z2Z4IGhhcyBiZWVuIGRvaW5nIHNvbWUgb2RkIGNoZWNrcyBi
YXNlZCBvbiBETUEgb3BzIHdoaWNoIHJlbHkNCj4gPiA+IG9uIGRlZXAgRE1BIG1hcHBpbmcgbGF5
ZXIgaW50ZXJuYWxzLCBhbmQgSSB0aGluayB0aGUgY2hhbmdlcyBpbg0KPiA+ID4gTGludXggNC4y
MSBmaW5hbGx5IGJyb2tlIG1vc3Qgb2YgdGhlc2UgaW1wbGljaXQgYXNzdW1wdGlvbnMuDQo+ID4g
DQo+ID4gVGhhbmtzLiANCj4gPiBXaGF0IHdlJ3JlIHJlYWxseSB0cnlpbmcgdG8gZG8gaGVyZSBp
cyB0byB0cnkgdG8gZGV0ZWN0IHRoZQ0KPiA+IHNpdHVhdGlvbg0KPiA+IHdoZXJlIERNQSByZW1h
cHBpbmcgdXNpbmcgaGFyZHdhcmUgSU9NTVVzIGlzIGdvaW5nIG9uIGJ1dCBtZW1vcnkgaXMNCj4g
PiBzdGlsbCBjb2hlcmVudCwgc2luY2UgdGhlIGRyaXZlciBjYW4gY3VycmVudGx5IG9ubHkgd29y
ayB3aXRoDQo+ID4gY29oZXJlbnQNCj4gPiBtZW1vcnlbMV0uIEN1cnJlbnRseSB3ZSB1c2UgaW50
ZWxfaW9tbXVfZW5hYmxlZCB0byBkZXRlY3QgdGhpcw0KPiA+IHNpdHVhdGlvbiwgYnV0IGl0IHdv
dWxkIGJlIHJlYWxseSBoZWxwZnVsIGlmIHRoZXJlIHdlcmUgYSBnZW5lcmljDQo+ID4gYm9vbA0K
PiA+IHRoYXQgYWR2ZXJ0aXplcyB0aGlzIHNpdHVhdGlvbiBzaW5jZSB3ZSBuZWVkIHRvIGRlYWwg
d2l0aCBvdGhlcg0KPiA+IElPTU1Vcw0KPiA+IGFzIHdlbGwgZ29pbmcgZm9yd2FyZC4gQW55IHN1
Z2dlc3Rpb24/DQo+IA0KPiBJJ20gbWlzc2luZyB0aGUgbGluayBvZiB0aGUgWzFdIHJlZmVyZW5j
ZSBhYm92ZS4gDQoNClNvcnJ5LiBJIG1lYW50IHRvIHJlbW92ZSB0aGUgcmVmZXJlbmNlIHNpbmNl
IHRoZSBleHBsYW5hdGlvbiB3b3VsZCBiZQ0KcmF0aGVyIGxlbmd0aHkuDQoNCj4gQnV0IGlmIHlv
dSBuZWVkDQo+IGNvaGVyZW50IG1lbW9yeSB5b3Ugc2hvdWxkIHNpbXBseSBhbHdheXMgdXNlIGRt
YV9hbGxvY19jb2hlcmVudCwgdGhhdA0KPiBpcyB0aGUgb25seSBndXJhbnRlZSB5b3UgZ2V0LiAg
SWYgeW91IHVzZSBhbnkgb3RoZXIgZG1hIG1hcHBpbmcNCj4gbWV0aG9kcw0KPiB5b3Ugd2lsbCBv
dGhlcndpc2UgbmVlZCB0byBleHBsaWNpdGx5IHRyYW5zZmVyIG93bmVyc2hpcCBieSBtYXBwaW5n
Lw0KPiB1bm1hcHBpbmcgb3IgdXNpbmcgZG1hX3N5bmMqIGJlZm9yZSBhbmQgYWZ0ZXIgZXZlcnkg
ZGV2aWNlIGFjY2Vzcy4NCg0KVGhlIHByb2JsZW0gaXMgdGhhdCBncmFwaGljcyBhcHBsaWNhdGlv
bnMgdHlwaWNhbGx5IGFsbG9jYXRlIGh1Z2UNCmFtb3VudHMgb2YgRE1BIG1lbW9yeS4gVGhlIEdQ
VSBtYXkgd2FudCB0byBtYXAgaGFsZiBvZiBhdmFpbGFibGUgc3lzdGVtDQptZW1vcnkgb3IgbW9y
ZS4gTW9yZW92ZXIgdGhpcyBtZW1vcnkgbWlnaHQgbmVlZCB0byBiZSBtYXBwYWJsZSBieQ0KbXVs
dGlwbGUgZGV2aWNlcywgd2hpY2ggd291bGQgcnVsZSBvdXQgZG1hX2FsbG9jX2NvaGVyZW50KCkg
aW4gbWFueQ0Kc2l0dWF0aW9ucy4NCg0KVXNpbmcgU1dJT1RMQiB3aXRoIGJvdW5jZS1idWZmZXJz
IGlzIGFsc28gdHlwaWNhbGx5IG91dCBvZiB0aGUgcXVlc3Rpb24NCmZvciBwZXJmb3JtYW5jZS0g
YW5kIG1lbW9yeSB1c2FnZSByZWFzb25zLiBNb3Jlb3ZlciB0aGUgc3luYyBvcGVyYXRpb25zDQp3
b3VsZCBvZnRlbiBhZmZlY3Qgc3ViLXJlZ2lvbnMgb2YgMkQgYW5kIDNEIHRleHR1cmVzLCB3aGlj
aCBtYWtlcyB0aGUNCmRtYV9zeW5jIEFQSSBpbmVmZmljaWVudCBldmVuIGlmIGl0IG1hcHMgdG8g
bm8tb3BzLiB2bXdnZnggd291bGQgcmF0aGVyDQpub3QgbG9hZCBpbiB0aGVzZSBzaXR1YXRpb25z
Lg0KDQpGaW5hbGx5IGdyYXBoaWNzIGFwcGxpY2F0aW9ucywgZG8gbm90IGFsd2F5cyBwcm92aWRl
IGNvbnNlcnZhdGl2ZSBzeW5jDQpyZWdpb25zLg0KDQo+IA0KPiBBbmQgdGhlIHdob2xlIERNQSBB
UEkgYnlwYXNzIHVzaW5nIHRoZSBwaHlzIG1vZGUgaXMgc29tZXRoaW5nIHRoYXQNCj4gSSdkIHJl
YWxseSBwcmVmZXIgbm90IHRvIHNlZSBpbiBhbnkgZHJpdmVyIGFzIGl0IHRlbmRzIHRvIGNhdXNl
DQo+IG1ham9yIHByb2JsZW1zIHNvb25lciBvciBsYXRlci4NCg0KSSBmdWxseSB1bmRlcnN0YW5k
IHRoaXMuIEhvd2V2ZXIsIGdpdmVuIHRoZSBhYm92ZSwgdGhlIERNQSBBUEkgaXMgcXVpdGUNCmF3
a3dhcmQgZm9yIGdyYXBoaWNzIG9wZXJhdGlvbi4gSXQgd291bGQgYmUgZWFzaWVyIHRvIG1vdGl2
YXRlIGEgZnVsbA0KcmVtb3ZhbCBvZiB0aGUgcGh5cyBtb2RlIGlmIHdlIGNvdWxkIHF1ZXJ5IHRo
ZSBETUEgQVBJIHdoZXRoZXIgdGhlDQpkbWFfc3luYyBvcGVyYXRpb25zIGFyZSBuby1vcHMgb3Ig
bm90Lg0KDQovVGhvbWFzDQoNCg0KDQoNCg==

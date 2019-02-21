Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7A6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B83206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="c95Tj1g8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfBUUqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:46:39 -0500
Received: from mail-eopbgr130052.outbound.protection.outlook.com ([40.107.13.52]:26786
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbfBUUqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSMcSztNlofE3POjuyUdc8hpZ4K+7IA9Thez/3ZoQZ4=;
 b=c95Tj1g8/ca0dMZ5qsMQ+3QBn3R/ZSvfVmLOUFG5S2bw2yuzRG9lCZLeZ5RTtgDqwg+8VtwrU8pMGUJybBXrWG1jJLzb11uBgt68KaBiD1bf04BBuM1yFcYfAc/cZqgDGfp5nfwJDHNHkITucgNSKx3h6i9uYd+bNWky+glw/7M=
Received: from VI1PR08MB2862.eurprd08.prod.outlook.com (10.170.239.138) by
 VI1PR08MB3151.eurprd08.prod.outlook.com (52.133.15.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 20:46:31 +0000
Received: from VI1PR08MB2862.eurprd08.prod.outlook.com
 ([fe80::f0d9:64f0:bde3:8c4b]) by VI1PR08MB2862.eurprd08.prod.outlook.com
 ([fe80::f0d9:64f0:bde3:8c4b%4]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 20:46:31 +0000
From:   Julien Grall <Julien.Grall@arm.com>
To:     =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        Julien Grall <julien.grall@gmail.com>
CC:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Jan Beulich <JBeulich@suse.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>
Subject: Re: [Xen-devel] xen/evtchn and forced threaded irq
Thread-Topic: [Xen-devel] xen/evtchn and forced threaded irq
Thread-Index: AQHUyHjqQ66WxRXB/Uyll7tNFo7Q+qXnzhoAgADuSACAADAtAIAAEDAAgAAhZICAAAulgIAAEMAAgAAE4ICAAKi7AIAACJqAgAAKBYCAAMFVAA==
Date:   Thu, 21 Feb 2019 20:46:31 +0000
Message-ID: <e25aaeea-f6bf-1217-f416-726c4e3588f2@arm.com>
References: <20190220000209.GA4091@localhost.localdomain>
 <a872d480-9f1b-6cd7-e507-ac4fcdf705af@arm.com>
 <21214d47-9c68-e6bf-007a-4047cc2b02f9@oracle.com>
 <8f7445d7-fa50-f3e9-44f5-cc2aebd020f4@arm.com>
 <15bc52cb-82d8-4d2c-e5a8-c6ae8de90276@oracle.com>
 <5df8888a-4a29-fccd-bac2-a9c170244029@arm.com>
 <1574a7fe-a5ac-4bc2-d3f0-967d8d01e5f1@oracle.com>
 <1100e6b1-6fa8-06f0-8ecc-b0699a2ce5f4@arm.com>
 <20190221080752.zy2qlzb4vi7tbu3p@Air-de-Roger>
 <CAF3u54Ct7nBjoLw9Vzb=aZVu=N5Ccp5_k6GxLo_ZSA=YCsco6A@mail.gmail.com>
 <20190221091431.vqi53op37mvhi25z@Air-de-Roger>
In-Reply-To: <20190221091431.vqi53op37mvhi25z@Air-de-Roger>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::23) To VI1PR08MB2862.eurprd08.prod.outlook.com
 (2603:10a6:802:1f::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.96.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e778bc35-9b3c-410f-b2d2-08d6983da8d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3151;
x-ms-traffictypediagnostic: VI1PR08MB3151:
x-microsoft-exchange-diagnostics: 1;VI1PR08MB3151;20:1tQyDMkYKYGl2vBj+TlR683n6gsSmchUT6cTJoY2CYWAkXHqfORmDrkOqrGhJ07+NVT7azt7/nOXohL/ZRLbRLa7icu5jf3gtKscIXntdB5jTp+GNdI/CCW5U9uGWHXdqo7gCVyIsaHd57DxDsu0R94x6ooIFuQox8hehtF7vdQ=
x-microsoft-antispam-prvs: <VI1PR08MB315139134024B8B2F16175C6807E0@VI1PR08MB3151.eurprd08.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(366004)(396003)(346002)(39860400002)(136003)(40434004)(199004)(189003)(52116002)(8676002)(3846002)(81166006)(81156014)(305945005)(6486002)(54906003)(93886005)(6116002)(44832011)(486006)(446003)(99286004)(7736002)(229853002)(2906002)(66066001)(8936002)(76176011)(476003)(2616005)(71200400001)(86362001)(26005)(6512007)(36756003)(110136005)(478600001)(25786009)(6246003)(6346003)(4326008)(31686004)(6436002)(106356001)(11346002)(14454004)(71190400001)(53936002)(31696002)(386003)(105586002)(72206003)(6506007)(14444005)(256004)(53546011)(5024004)(186003)(97736004)(102836004)(316002)(68736007)(5660300002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3151;H:VI1PR08MB2862.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Julien.Grall@arm.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VMFfF/xqDu9hhZkPDcpSBaCkPjEjuwYElgUdFQ6KJ2dmWxO7ewPQNO8VQrZn0uSMZkoMM8e4Cq3OMe2n5WFdUbjSHJCT/gDX8SZN9GyuG53YodKfoU/AOAxroNe6iMjQa30rrEk0ZFBQfGVC97ZljQQFGtqGYNoM2l4fTWvTDJoxfczy77tuwuJFpN1IAtpZT762My3UCnTj3drweG/pXZEhtbarBdVW0z55UuQwF5Yc0PuLC17i0FxscKu6j9+kEIylal1axDWb56QAS5g7IyHLCXCb1CfFTESZzqKYt2axDG5UBGNJrB3QR/IqyNzYgTlJdwrNP4WCegYOQ8+0cdZgQa8ypZuHBLmrbRlHaLpB/eJ36eGgjUEfbQepYXbnIOcFbBSu3Nla7KYu53OSuYjBdSJi1IsiGpIhheIYy3s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB6A25D40E910140BC550E04476C2094@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e778bc35-9b3c-410f-b2d2-08d6983da8d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 20:46:30.4740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9nZXIsDQoNCk9uIDIxLzAyLzIwMTkgMDk6MTQsIFJvZ2VyIFBhdSBNb25uw6kgd3JvdGU6
DQo+IE9uIFRodSwgRmViIDIxLCAyMDE5IGF0IDA4OjM4OjM5QU0gKzAwMDAsIEp1bGllbiBHcmFs
bCB3cm90ZToNCj4+IEhpIFJvZ2VyLA0KPj4NCj4+IE9uIFRodSwgMjEgRmViIDIwMTksIDA4OjA4
IFJvZ2VyIFBhdSBNb25uw6ksIDxyb2dlci5wYXVAY2l0cml4LmNvbT4gd3JvdGU6DQo+Pg0KPj4+
IEZXSVcsIHlvdSBjYW4gYWxzbyBtYXNrIHRoZSBpbnRlcnJ1cHQgd2hpbGUgd2FpdGluZyBmb3Ig
dGhlIHRocmVhZCB0bw0KPj4+IGV4ZWN1dGUgdGhlIGludGVycnVwdCBoYW5kbGVyLiBJZToNCj4+
Pg0KPj4NCj4+IFRoYW5rIHlvdSBmb3IgcHJvdmlkaW5nIHN0ZXBzLCBob3dldmVyIHdoZXJlIHdv
dWxkIHRoZSBtYXNraW5nIGJlIGRvbmU/IEJ5DQo+PiB0aGUgaXJxY2hpcCBvciBhIGN1c3RvbSBz
b2x1dGlvbj8NCj4NCj4gSSdtIG5vdCBmYW1pbGlhciB3aXRoIHRoZSBpcnFjaGlwIGluZnJhc3Ry
dWN0dXJlIGluIExpbnV4LCB3aGF0IEkNCj4gcHJvcG9zZWQgYmVsb3cgaXMgd2hhdCBGcmVlQlNE
IGRvZXMgd2hlbiBydW5uaW5nIGludGVycnVwdCBoYW5kbGVycyBpbg0KPiBkZWZlcnJlZCB0aHJl
YWRzIElJUkMuDQo+DQo+IElmIGlycWNoaXAgaGFzIGEgc3BlY2lmaWMgaGFuZGxlciB0byBkaXNw
YXRjaCB0byBhIHRocmVhZCwgdGhlbiB0aGF0J3MNCj4gdGhlIHBsYWNlIHdoZXJlIHRoZSBtYXNr
aW5nIHNob3VsZCBoYXBwZW4uIExpa2VseSwgdGhlIHVubWFza2luZw0KPiBzaG91bGQgYmUgZG9u
ZSBieSB0aGUgaXJxIGhhbmRsaW5nIGluZnJhc3RydWN0dXJlIGFmdGVyIHRoZSB0aHJlYWQNCj4g
ZXhlY3V0aW5nIHRoZSBpbnRlcnJ1cHQgaGFuZGxlciBoYXMgZmluaXNoZWQuDQo+DQo+IElzbid0
IHRoZXJlIGEgc2ltaWxhciB3YXkgdG8gaGFuZGxlIGludGVycnVwdHMgaW4gdGhyZWFkcyBmb3Ig
TGludXg/DQoNCkxpbnV4IGhhcyBhIGZsYWcgKElSUUZfT05FU0hPVCkgdG8gbWFzayBpbnRlcnJ1
cHQgdW50aWwgdGhlIGludGVycnVwdA0KaGFuZGxlciBoYXMgYmVlbiBydW4uIEl0IGlzIHNldCBm
b3IgYWxsIGludGVycnVwdHMgaGFuZGxlciB0aGF0IGhhdmUNCmJlZW4gZm9yY2VkIHRvIGJlIHRo
cmVhZGVkLg0KDQpIb3dldmVyLCBpdCBsb29rcyBsaWtlIHRoZSBmbGFnIGlzIGJlZW4gaWdub3Jl
ZCBieSB0aGUgaXJxY2hpcCBoYW5kbGVyDQp3ZSB1c2UgKGhhbmRsZV9lZGdlX2lycSkuIERvaW5n
IGEgYml0IG9mIGRpZ2dpbmcsIElSUUZfT05FU0hPVCB1c2UgdG8gYmUNCmhhbmRsZWQgaW4gaGFu
ZGxlX2VkZ2VfaXJxIHVudGlsIHRoZSBmb2xsb3dpbmcgY29tbWl0IGZyb20gMjAwOToNCg0KY29t
bWl0IDRkYmM5Y2EyMTliMGYyOTQzMzJlNzM0NTI4ZjdiODIyMTE3MDAxNzANCkF1dGhvcjogVGhv
bWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQpEYXRlOiAgIFRodSBBdWcgMjcgMDk6
Mzg6NDkgMjAwOSArMDIwMA0KDQogICAgIGdlbmlycTogRG8gbm90IG1hc2sgb25lc2hvdCBlZGdl
IHR5cGUgaW50ZXJydXB0cw0KDQogICAgIE1hc2tpbmcgb25lc2hvdCBlZGdlIHR5cGUgaW50ZXJy
dXB0cyBpcyB3cm9uZyBhcyB3ZSBtaWdodCBsb3NlIGFuDQogICAgIGludGVycnVwdCB3aGljaCBp
cyBpc3N1ZWQgd2hlbiB0aGUgdGhyZWFkZWQgaGFuZGxlciBpcyBoYW5kbGluZyB0aGUNCiAgICAg
ZGV2aWNlLiBXZSBjYW4ga2VlcCB0aGUgaXJxIHVubWFza2VkIHNhZmVseSBhcyB3aXRoIGVkZ2Ug
dHlwZQ0KICAgICBpbnRlcnJ1cHRzIHRoZXJlIGlzIG5vIGRhbmdlciBvZiBpbnRlcnJ1cHQgZmxv
b2RzLiBJZiB0aGUgdGhyZWFkZWQNCiAgICAgaGFuZGxlciBoYXMgbm90IHlldCBmaW5pc2hlZCB0
aGVuIElSUVRGX1JVTlRIUkVBRCBpcyBzZXQgd2hpY2ggd2lsbA0KICAgICBrZWVwIHRoZSBoYW5k
bGVyIHRocmVhZCBhY3RpdmUuDQoNCiAgICAgRGVidWdnZWQgYW5kIHZlcmlmaWVkIGluIHByZWVt
cHQtcnQuDQoNCiAgICAgU2lnbmVkLW9mZi1ieTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0
cm9uaXguZGU+DQoNCkZ1cnRoZXJtb3JlLCBpdCBpcyBwcmV0dHkgY2xlYXIgZnJvbSB0aGUgY29t
bWVudCBvbiB0b3Agb2YNCmhhbmRsZV9lZGdlX2lycSB0aGF0IHRoZSBzYW1lIGludGVycnVwdCBj
YW4gY29tZS11cCBiZWZvcmUgdGhlIGZpcnN0IG9uZQ0KaXMgb25lIGlzIGhhbmRsZWQgYnkgdGhl
IGFzc29jaWF0ZWQgZXZlbnQgaGFuZGxlci4NCg0KSSBhbSBzdGlsbCB0cnlpbmcgdG8gZmlndXJl
IG91dCB3aGV0aGVyIHRoZSBpc3N1ZSBsaWVzIGluIHRoZSBldnRjaG4NCmRyaXZlciBvciB0aGUg
WGVuIGlycWNoaXAgKGV2ZW50c19iYXNlLmMpLiBJIHdpbGwgaGF2ZSBhIGNsb3NlciBsb29rIGFu
ZA0KY29tZSBiYWNrIHdpdGggdXBkYXRlcyBoZXJlLg0KDQpDaGVlcnMsDQoNCi0tDQpKdWxpZW4g
R3JhbGwNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBh
bnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdl
ZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0
aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRv
IGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNv
cHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==

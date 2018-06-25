Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7DDC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E04426145
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Wb92Nhya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E04426145
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755016AbeFYVHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:07:10 -0400
Received: from mail-co1nam03on0097.outbound.protection.outlook.com ([104.47.40.97]:3755
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751347AbeFYVHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70jwJrA+mrO8hFuR+Vqb/ACyKYjCd5py1bxysZs15aM=;
 b=Wb92Nhyaqbg5bJnM/AM4B9LKjlYbscDJVC3TcIJhN+mOYlwmZiuTkIUt06nX6DIs5Y9WiSIscmzjGldMYY0oebpDyK/ulvu443SU2G+42rJ6pGwMBuRt6SdHBjwSUg5HcXVs5aOnkGuE82sQfS8SgTJOva30pDv+Eljh5Ac5Aao=
Received: from CY4PR2101MB0722.namprd21.prod.outlook.com (52.132.100.10) by
 CY4PR2101MB0723.namprd21.prod.outlook.com (52.132.100.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.2; Mon, 25 Jun 2018 21:07:06 +0000
Received: from CY4PR2101MB0722.namprd21.prod.outlook.com
 ([fe80::a849:9c0c:337b:2ee7]) by CY4PR2101MB0722.namprd21.prod.outlook.com
 ([fe80::a849:9c0c:337b:2ee7%5]) with mapi id 15.20.0930.005; Mon, 25 Jun 2018
 21:07:06 +0000
From:   Long Li <longli@microsoft.com>
To:     Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Patch v2 05/15] CIFS: Calculate the correct request length based
 on page offset and tail size
Thread-Topic: [Patch v2 05/15] CIFS: Calculate the correct request length
 based on page offset and tail size
Thread-Index: AQHT+E9jeEQDtVP8M022UNp2x/D3XqRuz38AgALHrQA=
Date:   Mon, 25 Jun 2018 21:07:05 +0000
Message-ID: <CY4PR2101MB0722248C0F31E5CDA4CCAEFECE4A0@CY4PR2101MB0722.namprd21.prod.outlook.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-6-longli@linuxonhyperv.com>
 <183b5cd5-b12b-de08-7867-c2addf29c974@talpey.com>
In-Reply-To: <183b5cd5-b12b-de08-7867-c2addf29c974@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:a:fdde:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2101MB0723;7:NzNIx4hrcercH2c6VO2ai46gcvBKV5cjcRCMkaKVNf0ivxrI2pEP23aB3Ddy6drEtza42rG9Qs7Mm4uZkMjMpM1cr4cwxDUJmtocBTFtoOlF2YXgl/u135MKuRVTzc5ke2tpzM1rHD3U8N/BSk8WyE5+eBhknKt82/geA9If5/2ZWDUvlS5yqLMoBzF2eZVLBV2TDAfIORie5Yek+cnuU+cxPIttaQjiFXzSxmxkV+X8P9ek/bR2ysB22v+mGKD8
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9155f722-b60a-4e91-e3ee-08d5dadf9b5c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:CY4PR2101MB0723;
x-ms-traffictypediagnostic: CY4PR2101MB0723:
x-microsoft-antispam-prvs: <CY4PR2101MB0723AD3A8901430A2F472CD4CE4A0@CY4PR2101MB0723.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR2101MB0723;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2101MB0723;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(8676002)(81166006)(81156014)(99286004)(2501003)(8936002)(105586002)(33656002)(6346003)(6116002)(7696005)(53546011)(76176011)(478600001)(256004)(106356001)(14444005)(5250100002)(10290500003)(25786009)(6506007)(10090500001)(46003)(102836004)(14454004)(68736007)(486006)(186003)(305945005)(11346002)(55016002)(8990500004)(446003)(476003)(53936002)(74316002)(2900100001)(9686003)(110136005)(86362001)(6246003)(97736004)(86612001)(7736002)(6436002)(229853002)(2201001)(2906002)(22452003)(316002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2101MB0723;H:CY4PR2101MB0722.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-message-info: 38xeBeJJwbsQvi5nV71aN9ufPz85jF2cLI0qqKI3tjazOplBidIX90aYjNB4efNxg/LQfD9kVD0UWabwUIpI7+c8GzanZ1Wx3JBAIDRWwqiB1UjJZEuWBb1HGrhH2t5JG0dRZ6C/CBVVBqUSDowNTG7PGfB6FCd9YGKgHBBEqJrKff8L6HseT4x13TQqrwlTYBvjc3eccUeD+RvUXEqDtlpaVDZ2HXpib3rCBE4CrHJ/UUAGzy3yGLRtmsbFrXyBVKDJndfcPGV5vzD4BDYzIiXJT/fOBzf+EOxKZdASBW6UdHhyVCHkdcYsq70wDVuaVGutas2bD73syDsDqtNltkK7fHFVjILRe0B29CVQ2/c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9155f722-b60a-4e91-e3ee-08d5dadf9b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 21:07:06.0661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2101MB0723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYyIDA1LzE1XSBDSUZTOiBDYWxjdWxhdGUgdGhlIGNvcnJl
Y3QgcmVxdWVzdCBsZW5ndGggYmFzZWQNCj4gb24gcGFnZSBvZmZzZXQgYW5kIHRhaWwgc2l6ZQ0K
PiANCj4gT24gNS8zMC8yMDE4IDM6NDcgUE0sIExvbmcgTGkgd3JvdGU6DQo+ID4gRnJvbTogTG9u
ZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4NCj4gPiBJdCdzIHBvc3NpYmxlIHRoYXQg
dGhlIHBhZ2Ugb2Zmc2V0IGlzIG5vbi16ZXJvIGluIHRoZSBwYWdlcyBpbiBhDQo+ID4gcmVxdWVz
dCwgY2hhbmdlIHRoZSBmdW5jdGlvbiB0byBjYWxjdWxhdGUgdGhlIGNvcnJlY3QgZGF0YSBidWZm
ZXIgbGVuZ3RoLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jv
c29mdC5jb20+DQo+ID4gLS0tDQo+ID4gICBmcy9jaWZzL3RyYW5zcG9ydC5jIHwgMjAgKysrKysr
KysrKysrKysrKystLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL2NpZnMvdHJhbnNwb3J0LmMg
Yi9mcy9jaWZzL3RyYW5zcG9ydC5jIGluZGV4DQo+ID4gOTI3MjI2YS4uZDZiNTUyMyAxMDA2NDQN
Cj4gPiAtLS0gYS9mcy9jaWZzL3RyYW5zcG9ydC5jDQo+ID4gKysrIGIvZnMvY2lmcy90cmFuc3Bv
cnQuYw0KPiA+IEBAIC0yMTIsMTAgKzIxMiwyNCBAQCBycXN0X2xlbihzdHJ1Y3Qgc21iX3Jxc3Qg
KnJxc3QpDQo+ID4gICAJZm9yIChpID0gMDsgaSA8IHJxc3QtPnJxX252ZWM7IGkrKykNCj4gPiAg
IAkJYnVmbGVuICs9IGlvdltpXS5pb3ZfbGVuOw0KPiA+DQo+ID4gLQkvKiBhZGQgaW4gdGhlIHBh
Z2UgYXJyYXkgaWYgdGhlcmUgaXMgb25lICovDQo+ID4gKwkvKg0KPiA+ICsJICogQWRkIGluIHRo
ZSBwYWdlIGFycmF5IGlmIHRoZXJlIGlzIG9uZS4gVGhlIGNhbGxlciBuZWVkcyB0byBtYWtlDQo+
ID4gKwkgKiBzdXJlIHJxX29mZnNldCBhbmQgcnFfdGFpbHN6IGFyZSBzZXQgY29ycmVjdGx5LiBJ
ZiBhIGJ1ZmZlciBvZg0KPiA+ICsJICogbXVsdGlwbGUgcGFnZXMgZW5kcyBhdCBwYWdlIGJvdW5k
YXJ5LCBycV90YWlsc3ogbmVlZHMgdG8gYmUgc2V0IHRvDQo+ID4gKwkgKiBQQUdFX1NJWkUuDQo+
ID4gKwkgKi8NCj4gPiAgIAlpZiAocnFzdC0+cnFfbnBhZ2VzKSB7DQo+ID4gLQkJYnVmbGVuICs9
IHJxc3QtPnJxX3BhZ2VzeiAqIChycXN0LT5ycV9ucGFnZXMgLSAxKTsNCj4gPiAtCQlidWZsZW4g
Kz0gcnFzdC0+cnFfdGFpbHN6Ow0KPiA+ICsJCWlmIChycXN0LT5ycV9ucGFnZXMgPT0gMSkNCj4g
PiArCQkJYnVmbGVuICs9IHJxc3QtPnJxX3RhaWxzejsNCj4gPiArCQllbHNlIHsNCj4gPiArCQkJ
LyoNCj4gPiArCQkJICogSWYgdGhlcmUgaXMgbW9yZSB0aGFuIG9uZSBwYWdlLCBjYWxjdWxhdGUg
dGhlDQo+ID4gKwkJCSAqIGJ1ZmZlciBsZW5ndGggYmFzZWQgb24gcnFfb2Zmc2V0IGFuZCBycV90
YWlsc3oNCj4gPiArCQkJICovDQo+ID4gKwkJCWJ1ZmxlbiArPSBycXN0LT5ycV9wYWdlc3ogKiAo
cnFzdC0+cnFfbnBhZ2VzIC0gMSkgLQ0KPiA+ICsJCQkJCXJxc3QtPnJxX29mZnNldDsNCj4gPiAr
CQkJYnVmbGVuICs9IHJxc3QtPnJxX3RhaWxzejsNCj4gPiArCQl9DQo+IA0KPiBXb3VsZG4ndCBp
dCBiZSBzaW1wbGVyIHRvIGtlZXAgdGhlIG9yaWdpbmFsIGNvZGUsIGJ1dCB0aGVuIGp1c3Qgc3Vi
dHJhY3QgdGhlDQo+IHJxX29mZnNldD8NCj4gDQo+IAlidWZsZW4gKz0gcnFzdC0+cnFfcGFnZXN6
ICogKHJxc3QtPnJxX25wYWdlcyAtIDEpOw0KPiAJYnVmbGVuICs9IHJxc3QtPnJxX3RhaWxzejsN
Cj4gCWJ1ZmxlbiAtPSBycXN0LT5ycV9vZmZzZXQ7DQo+IA0KPiBJdCdzIGtpbmQgb2YgY29uZnVz
aW5nIGFzIHdyaXR0ZW4uIEFsc28sIHdoYXQgaWYgaXQncyBqdXN0IG9uZSBwYWdlLCBidXQgaGFz
IGENCj4gbm9uLXplcm8gb2Zmc2V0PyBJcyB0aGF0IHNvbWVob3cgbm90IHBvc3NpYmxlPyBNeSBz
dWdnZXN0ZWQgY29kZSB3b3VsZA0KPiB0YWtlIHRoYXQgaW50byBhY2NvdW50LCB5b3VycyBkb2Vz
bid0Lg0KDQpJIHRoaW5rIEl0IGNhbiBiZSBjaGFuZ2VkIHRvIHRoaXM6DQoNCglidWZsZW4gKz0g
cnFzdC0+cnFfcGFnZXN6ICogKHJxc3QtPnJxX25wYWdlcyAtIDEpOw0KIAlidWZsZW4gKz0gcnFz
dC0+cnFfdGFpbHN6Ow0KCWlmIChycXN0LT5ycV9ucGFnZXMgPiAxKQ0KIAkJYnVmbGVuIC09IHJx
c3QtPnJxX29mZnNldDsNCg0KVGhpcyBsb29rcyBjbGVhbmVyIHRoYW4gYmVmb3JlLg0KDQpXaGVu
IHRoZXJlIGlzIG9ubHkgb25lIHBhZ2Ugd2l0aCBhIG5vbi16ZXJvIG9mZnNldCwgcnFfdGFpbHN6
IGlzIHRoZSBhY3R1YWwgZGF0YSBsZW5ndGguDQoNCj4gDQo+IFRvbS4NCj4gDQo+ID4gICAJfQ0K
PiA+DQo+ID4gICAJcmV0dXJuIGJ1ZmxlbjsNCj4gPg0K

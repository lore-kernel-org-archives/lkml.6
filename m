Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C41AC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D9626461
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FX7cSmak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D9626461
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeF0DV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 23:21:59 -0400
Received: from mail-eopbgr720111.outbound.protection.outlook.com ([40.107.72.111]:8739
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752449AbeF0DV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 23:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJW1zXRVP9ST9RS3b/DMt93vjWykoQZ5cRPIB18YaPI=;
 b=FX7cSmak9xfm53YDUfOfrhbFF8W2GEMkiJooLJXA6u6hu9RRLe0lVh07BgGVW/a583FkiO2ItLplvdbOFXqwrR19RYHP2UykExXqgrhlYVQiMqlAr2aNgTNw3DDnMDdZyLfTVuoGkgMwY281x7m23qaN4E5p2n111/mixdQiyfI=
Received: from SN4PR2101MB0733.namprd21.prod.outlook.com (10.167.150.161) by
 SN4PR2101MB0880.namprd21.prod.outlook.com (10.167.151.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.4; Wed, 27 Jun 2018 03:21:53 +0000
Received: from SN4PR2101MB0733.namprd21.prod.outlook.com
 ([fe80::2543:cba3:2e1:a322]) by SN4PR2101MB0733.namprd21.prod.outlook.com
 ([fe80::2543:cba3:2e1:a322%5]) with mapi id 15.20.0930.005; Wed, 27 Jun 2018
 03:21:53 +0000
From:   Long Li <longli@microsoft.com>
To:     Tom Talpey <tom@talpey.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Patch v2 02/15] CIFS: Add support for direct pages in rdata
Thread-Topic: [Patch v2 02/15] CIFS: Add support for direct pages in rdata
Thread-Index: AQHT+E9dvsQOBWcv606hJ7KjQvSo1KRuyssAgALT+QCAATErAIAAyupA
Date:   Wed, 27 Jun 2018 03:21:53 +0000
Message-ID: <SN4PR2101MB0733CBF80C83C1FA1A4B61E8CE480@SN4PR2101MB0733.namprd21.prod.outlook.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-3-longli@linuxonhyperv.com>
 <67b8afe7-f5e0-b36a-fcc1-87f1ae08eaa4@talpey.com>
 <20180625210132.GB5381@ziepe.ca>
 <f940d126-237c-963f-f64e-e1eb1e8c6c85@talpey.com>
In-Reply-To: <f940d126-237c-963f-f64e-e1eb1e8c6c85@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:1:fde7:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN4PR2101MB0880;7:f4Im1NYEDva3ZcavUELla+i4eO9zO6xMLJzrCGaVcQtNUMY7zRk3JF5CBp6QheyqXAxzHqJwudcRfcGMyczlcUrbSiej9gjoQoDgMXxcUz4eIwIg/ThkCQKE6V+HUaFOmmwKqHI7YeZ9Gf3tKAT6phS11IMt4R6MzWx72I2jBl0AyPczD3fKmkyruU4KdYMgTDETU5hzker5PmialkZgHiDPJfkwwEF/uY1cOBOOA+P/9oeclTmYqK3Rwaa/rKK5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fdda2376-bfb0-4386-5de3-08d5dbdd216b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:SN4PR2101MB0880;
x-ms-traffictypediagnostic: SN4PR2101MB0880:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-prvs: <SN4PR2101MB08803FD9F29E9D052E7B26CBCE480@SN4PR2101MB0880.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN4PR2101MB0880;BCL:0;PCL:0;RULEID:;SRVR:SN4PR2101MB0880;
x-forefront-prvs: 0716E70AB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(346002)(396003)(39860400002)(199004)(189003)(11346002)(55016002)(446003)(2906002)(97736004)(476003)(486006)(102836004)(10290500003)(478600001)(256004)(6116002)(46003)(86612001)(6506007)(53546011)(7696005)(186003)(14454004)(76176011)(86362001)(93886005)(305945005)(74316002)(33656002)(316002)(22452003)(106356001)(8936002)(68736007)(105586002)(99286004)(7736002)(54906003)(110136005)(5660300001)(229853002)(2900100001)(81166006)(9686003)(4326008)(8990500004)(10090500001)(6246003)(81156014)(5250100002)(8676002)(25786009)(53936002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0880;H:SN4PR2101MB0733.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 41mbQoTo//VIBKdPU0+4ZrzipEgzNeMPJm+rCZRiQdq7vWgrarr7iQp6LVeMdkpXv5G7IkOGIx2TkMN5CG+Ev3KSitcZ2D5pAqQx/QSEJuQ141HpHKR/GujbuBVsdPOBSOOK71IKQu9f6AQ3tABCwI1G6uQe8XoYdpnk4h/UHGDQ57wnPDiyTnah/q7RRqtnqJcYXxfts8tNyVq1JrLxH3HUoDDYBQGgCcx8xj2Js2xGnqM4QSlNIX8ko+aUe0p+vta7Ghkssi3jOPNxP3tN9N4v9P3krHXrnK4TbPd2AdzVD6ZPcFbWXElvSKxEdqbVIgOa2QQco3UuetIPQf7UaS780xmG5J9pAoV6nmCxbsg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdda2376-bfb0-4386-5de3-08d5dbdd216b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2018 03:21:53.6902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0880
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYyIDAyLzE1XSBDSUZTOiBBZGQgc3VwcG9ydCBmb3IgZGly
ZWN0IHBhZ2VzIGluIHJkYXRhDQo+IA0KPiBPbiA2LzI1LzIwMTggNTowMSBQTSwgSmFzb24gR3Vu
dGhvcnBlIHdyb3RlOg0KPiA+IE9uIFNhdCwgSnVuIDIzLCAyMDE4IGF0IDA5OjUwOjIwUE0gLTA0
MDAsIFRvbSBUYWxwZXkgd3JvdGU6DQo+ID4+IE9uIDUvMzAvMjAxOCAzOjQ3IFBNLCBMb25nIExp
IHdyb3RlOg0KPiA+Pj4gRnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4+
Pg0KPiA+Pj4gQWRkIGEgZnVuY3Rpb24gdG8gYWxsb2NhdGUgcmRhdGEgd2l0aG91dCBhbGxvY2F0
aW5nIHBhZ2VzIGZvciBkYXRhDQo+ID4+PiB0cmFuc2Zlci4gVGhpcyBnaXZlcyB0aGUgY2FsbGVy
IGFuIG9wdGlvbiB0byBwYXNzIGEgbnVtYmVyIG9mIHBhZ2VzDQo+ID4+PiB0aGF0IHBvaW50IHRv
IHRoZSBkYXRhIGJ1ZmZlci4NCj4gPj4+DQo+ID4+PiByZGF0YSBpcyBzdGlsbCByZXBvbnNpYmxl
IGZvciBmcmVlIHRob3NlIHBhZ2VzIGFmdGVyIGl0J3MgZG9uZS4NCj4gPj4NCj4gPj4gIkNhbGxl
ciIgaXMgc3RpbGwgcmVzcG9uc2libGU/IE9yIGlzIHRoZSByZGF0YSBzb21laG93IGZyZWVpbmcg
aXRzZWxmDQo+ID4+IHZpYSBhbm90aGVyIG1lY2hhbmlzbT8NCj4gPj4NCj4gPj4+DQo+ID4+PiBT
aWduZWQtb2ZmLWJ5OiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gPj4+ICAgZnMv
Y2lmcy9jaWZzZ2xvYi5oIHwgIDIgKy0NCj4gPj4+ICAgZnMvY2lmcy9maWxlLmMgICAgIHwgMjMg
KysrKysrKysrKysrKysrKysrKystLS0NCj4gPj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9mcy9j
aWZzL2NpZnNnbG9iLmggYi9mcy9jaWZzL2NpZnNnbG9iLmggaW5kZXgNCj4gPj4+IDhkMTZjM2Uu
LjU2ODY0YTg3IDEwMDY0NA0KPiA+Pj4gKysrIGIvZnMvY2lmcy9jaWZzZ2xvYi5oDQo+ID4+PiBA
QCAtMTE3OSw3ICsxMTc5LDcgQEAgc3RydWN0IGNpZnNfcmVhZGRhdGEgew0KPiA+Pj4gICAJdW5z
aWduZWQgaW50CQkJdGFpbHN6Ow0KPiA+Pj4gICAJdW5zaWduZWQgaW50CQkJY3JlZGl0czsNCj4g
Pj4+ICAgCXVuc2lnbmVkIGludAkJCW5yX3BhZ2VzOw0KPiA+Pj4gLQlzdHJ1Y3QgcGFnZQkJCSpw
YWdlc1tdOw0KPiA+Pj4gKwlzdHJ1Y3QgcGFnZQkJCSoqcGFnZXM7DQo+ID4+DQo+ID4+IFRlY2hu
aWNhbGx5IHNwZWFraW5nLCB0aGVzZSBhcmUgc3ludGFjdGljYWxseSBlcXVpdmFsZW50LiBJdCBt
YXkgbm90DQo+ID4+IGJlIHdvcnRoIGNoYW5naW5nIHRoaXMgaGlzdG9yaWMgZGVmaW5pdGlvbi4N
Cj4gPg0KPiA+IFtdIGlzIGEgQzk5ICdmbGV4IGFycmF5JywgaXQgaGFzIGEgZGlmZmVyZW50IGFs
bG9jYXRpb24gYmVoYXZpb3IgdGhhbg0KPiA+ICoqIGFuZCBpcyBub3QgaW50ZXJjaGFuZ2VhYmxl
Li4NCj4gDQo+IEluIHRoYXQgY2FzZSwgaXQncyBhbiBldmVuIGJldHRlciByZWFzb24gdG8gbm90
IGNoYW5nZSB0aGUgZGVjbGFyYXRpb24uDQoNCk5vLCBpdCBuZWVkcyB0byBiZSBkZWNsYXJlZCBz
ZXBhcmF0ZWx5Lg0KDQpXaXRoIERpcmVjdCBJL08sICoqcGFnZXMgYXJlIGFsbG9jYXRlZCBhbmQg
cmV0dXJuZWQgZnJvbSBpb3ZfaXRlcl9nZXRfcGFnZXNfYWxsb2MoKSB3aGVuIGxvY2tpbmcgdGhv
c2UgdXNlciBwYWdlcy4gVGhleSBjYW4ndCBiZSBhbGxvY2F0ZWQgYXMgcGFydCBvZiBzdHJ1Y3Qg
Y2lmc19yZWFkZGF0YS4NCg0K

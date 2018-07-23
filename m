Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EEAECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D29720854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="tpDi9zG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D29720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388787AbeGWRXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:23:30 -0400
Received: from mail-eopbgr50043.outbound.protection.outlook.com ([40.107.5.43]:19456
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388240AbeGWRX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3H55zs/Uq+BBMIkWlNmTAG2hXshWhdtE6JdSs+mWUps=;
 b=tpDi9zG6+tsUUmBETNMpGZ4OrXhL8ihUNL0ldBzj6Bw9MPoVyuWdoI4TDed6sDdhs+o7KqNzp88rsSsYo5S8L3kibjy6DD8+hERWtqmn3eRI3mh+SWYYa6yHgv/fMVM90tSoPfL82lOD0mdMYug6v2WyKUCgv+9I+wQjrzAQSAg=
Received: from VI1PR0502MB3008.eurprd05.prod.outlook.com (10.175.21.22) by
 VI1PR0502MB2879.eurprd05.prod.outlook.com (10.175.24.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Mon, 23 Jul 2018 16:21:28 +0000
Received: from VI1PR0502MB3008.eurprd05.prod.outlook.com
 ([fe80::743f:c0ff:da0c:8786]) by VI1PR0502MB3008.eurprd05.prod.outlook.com
 ([fe80::743f:c0ff:da0c:8786%7]) with mapi id 15.20.0973.022; Mon, 23 Jul 2018
 16:21:28 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Qing Huang <qing.huang@oracle.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Or Gerlitz <gerlitz.or@gmail.com>
CC:     Linux Kernel <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "gerald.gibson@oracle.com" <gerald.gibson@oracle.com>
Subject: RE: [PATCH] IB/mlx5: avoid binding a new mpi unit to the same devices
 repeatedly
Thread-Topic: [PATCH] IB/mlx5: avoid binding a new mpi unit to the same
 devices repeatedly
Thread-Index: AQHUGwRdgAz4I8cutEmQOuBwZo5RwKSO4JGAgAHTEwCADEwWgIAADIOA
Date:   Mon, 23 Jul 2018 16:21:28 +0000
Message-ID: <VI1PR0502MB30082FAAD0D3EB6ACA9C6DF1D1560@VI1PR0502MB3008.eurprd05.prod.outlook.com>
References: <20180713235021.18141-1-qing.huang@oracle.com>
 <CAJ3xEMi5zF83aA_SWfYT+JtWGGhqRhLyTKe-qYwevSBLuiK=cA@mail.gmail.com>
 <dc4d502c-bc3c-46e3-a984-41271951a5f7@mellanox.com>
 <556984ea-c35f-197d-0e45-16272da3f604@oracle.com>
In-Reply-To: <556984ea-c35f-197d-0e45-16272da3f604@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0502MB2879;6:rT1D1STYE/hOjwXQZbdqbPVc/R+GAortngJnetYWPQCXpXe7i+84Vir3SSfJSZGxfiqmh88XJ781AtEQHZGrT3/wvoDjUD6bUj7szy7hTZrJMMv/EIIgzgRjcsUCvnpZhWnyfMv+Rlt1g8UGPdYp0zQ3bjp5OmoDOQTNqDLe5+cZjEgrdxTMxaVLnN+aiYqkth88ljhEmvJqoPD0bpCjhsuiu5sFiRco8hiDrpZa4yDiYclMBf5vGA46Z++TgaT1jQJ6qgXBiVRp/U25AWKEVcxKpjJEo/odfce14RyFBs9sO+W4cE/t6HBMONr7mIwCG9mdpE/0hLfVP8RPg2lzMgvMFQri5lrAEzZpN4QwRTfJonKt7kRmbinETzQfde4tr0vMLTxyuDVHfYyjPMQXfblZda+dnKg5mE4w42iynAk0SJEoBrXxEMVyrqszedcUkIwLACYhXczjQ7zs7VFOFQ==;5:v7heAWat8LvyI4adsGYOnjqnEwMfZDLKwDpRFk763k0vXEyxmDlaR0YWDTT5GPFFWahqbm3a0lMcwuSE9nTdxueNhhoy8VpizNapzIs/LvvJgVeW6Hu2tt78Sk1K9DO6LZffEwlHwGz/x7X+aauogZky9f+zVUpxSJTS7SweKrk=;7:nJ86rVGCzJIOthmFlz0AIUqzpsTAAuevG+yr4njYSBX4uJg8AklnOJXQQsLunhX4oa1CVMrYPM06lNQsVofjIkbOfiIHk2GEGVnxxlzdMBox2ZB5N2pz/k5qBSKdfb1R91US11RZmMWR8rTRALVeB+pG243cLVYe+ncVYaE0lMqfu8qaJWVnP9jOwaiq3LQG7OgR1i5UbF6u4VjW7nHH1cENioVTqCYacigQJZjo4xbZGECWKMBc5k+0rwuwdVRT
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: aa384841-32eb-4ad8-89ff-08d5f0b85800
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB2879;
x-ms-traffictypediagnostic: VI1PR0502MB2879:
x-microsoft-antispam-prvs: <VI1PR0502MB28792C12F16D417890054F3AD1560@VI1PR0502MB2879.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0502MB2879;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB2879;
x-forefront-prvs: 0742443479
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(136003)(39860400002)(199004)(13464003)(189003)(14454004)(105586002)(256004)(229853002)(106356001)(66066001)(7696005)(486006)(55016002)(53546011)(9686003)(102836004)(6506007)(186003)(478600001)(476003)(53936002)(11346002)(446003)(76176011)(39060400002)(26005)(25786009)(4326008)(5250100002)(6246003)(99286004)(97736004)(6436002)(5660300001)(81166006)(8936002)(68736007)(81156014)(8676002)(86362001)(316002)(110136005)(54906003)(93886005)(7736002)(305945005)(33656002)(74316002)(2900100001)(2906002)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB2879;H:VI1PR0502MB3008.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: I3FNnUERrfuChYccNbYOPZ1D44FLVTdnAyPOpMYOmpctxOg1ABsQbrwDOLn4il5VpF0RpeCxL6LWWn8WgLyZ9KVRGLKyFl4kd/CmAIJ13FgIWA1/07EsWDAP3HxTC190KefOvPGxc1ZhlvhDRbFwbAbtm1vLUJxkjOCY+IiqVdrgD9zqTpGmjOQ7KoiJC2TxMZF7eKzIF60ybBfkGHwAgNAx1yE4++THkfcpIux8UvXuCuXv8FL26Bbix/HDl8N9lsjZ4ByZjHWNALuWTHqc21jieh8WK2OPW+fz+5SsY17HDwPufROZhGxAC09oweZrDa8NTLDx1IydpTAQxZjuK9Cq2ug7ryyHEpps7HzsvPo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa384841-32eb-4ad8-89ff-08d5f0b85800
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2018 16:21:28.2466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUWluZywNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFFpbmcg
SHVhbmcgW21haWx0bzpxaW5nLmh1YW5nQG9yYWNsZS5jb21dDQo+IFNlbnQ6IE1vbmRheSwgSnVs
eSAyMywgMjAxOCAxMDozNiBBTQ0KPiBUbzogRGFuaWVsIEp1cmdlbnMgPGRhbmllbGpAbWVsbGFu
b3guY29tPjsgT3IgR2VybGl0eg0KPiA8Z2VybGl0ei5vckBnbWFpbC5jb20+OyBQYXJhdiBQYW5k
aXQgPHBhcmF2QG1lbGxhbm94LmNvbT4NCj4gQ2M6IExpbnV4IEtlcm5lbCA8bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZz47IFJETUEgbWFpbGluZyBsaXN0IDxsaW51eC0NCj4gcmRtYUB2Z2Vy
Lmtlcm5lbC5vcmc+OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT47IERvdWcgTGVkZm9y
ZA0KPiA8ZGxlZGZvcmRAcmVkaGF0LmNvbT47IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwu
b3JnPjsNCj4gZ2VyYWxkLmdpYnNvbkBvcmFjbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IElCL21seDU6IGF2b2lkIGJpbmRpbmcgYSBuZXcgbXBpIHVuaXQgdG8gdGhlIHNhbWUNCj4gZGV2
aWNlcyByZXBlYXRlZGx5DQo+IA0KPiANCj4gDQo+IE9uIDcvMTUvMjAxOCAxMjo0OCBQTSwgRGFu
aWVsIEp1cmdlbnMgd3JvdGU6DQo+ID4gT24gNy8xNC8yMDE4IDEwOjU3IEFNLCBPciBHZXJsaXR6
IHdyb3RlOg0KPiA+PiBPbiBTYXQsIEp1bCAxNCwgMjAxOCBhdCAyOjUwIEFNLCBRaW5nIEh1YW5n
IDxxaW5nLmh1YW5nQG9yYWNsZS5jb20+DQo+IHdyb3RlOg0KPiA+Pj4gV2hlbiBhIENYNSBkZXZp
Y2UgaXMgY29uZmlndXJlZCBpbiBkdWFsLXBvcnQgUm9DRSBtb2RlLCBhZnRlcg0KPiA+Pj4gY3Jl
YXRpbmcgbWFueSBWRnMgYWdhaW5zdCBwb3J0IDEsIGNyZWF0aW5nIHRoZSBzYW1lIG51bWJlciBv
ZiBWRnMNCj4gPj4+IGFnYWluc3QgcG9ydCAyIHdpbGwgZmxvb2Qga2VybmVsL3N5c2xvZyB3aXRo
IHNvbWV0aGluZyBsaWtlDQo+ID4+PiAibWx4NV8qOm1seDVfaWJfYmluZF9zbGF2ZV9wb3J0OjQy
NjY6KHBpZCA1MjY5KTogcG9ydCAyIGFscmVhZHkNCj4gPj4+IGFmZmlsaWF0ZWQuIg0KPiA+Pj4N
Cj4gPj4+IFNvIGJhc2ljYWxseSwgd2hlbiB0cmF2ZXJzaW5nIG1seDVfaWJfZGV2X2xpc3QsDQo+
ID4+PiBtbHg1X2liX2FkZF9zbGF2ZV9wb3J0KCkgc2hvdWxkbid0IHJlcGVhdGVkbHkgYXR0ZW1w
dCB0byBiaW5kIHRoZQ0KPiA+Pj4gbmV3IG1waSBkYXRhIHVuaXQgdG8gZXZlcnkgZGV2aWNlIG9u
IHRoZSBsaXN0IHVudGlsIGl0IGZpbmRzIGFuIHVuYm91bmQNCj4gZGV2aWNlLg0KPiA+PiBEYW5p
ZWwsDQo+ID4+DQo+ID4+IFdoYXQgaXMgbXBpIGRhdGEgdW5pdD8NCj4gPiBJdCdzIGEgc3RydWN0
dXJlIHRvIGtlZXAgdHJhY2sgYWZmaWxpYXRlZCBwb3J0IGluZm8gaW4gZHVhbCBwb3J0IFJvQ0Ug
bW9kZSwNCj4gbXBpIG1lYW5pbmcgbXVsdGktcG9ydCBpbmZvLiBQYXJhdiBjYW4gcmV2aWV3IHRo
aXMgaXQgbXkgYWJzZW5jZSwgb3RoZXJ3aXNlIEkNCj4gY2FuIHRha2UgYSBjbG9zZXIgbG9vayB3
aGVuIEkgcmV0dXJuIHRvIHRoZSBvZmZpY2UuDQo+IEhpIERhbmllbC9QYXJhdiwNCj4gDQo+IEhh
dmUgeW91IGdvdCBhIGNoYW5jZSB0byByZXZpZXcgdGhpcyBwYXRjaD8gVGhhbmtzIQ0KRGlkbid0
IGhhdmUgY2hhbmNlIHlldC4NCldpbGwgZG8gdGhpcyB3ZWVrLiANCg==

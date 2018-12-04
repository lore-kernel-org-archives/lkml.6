Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67F6C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE3C20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5uzf9Ouy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE3C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeLDHZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:25:20 -0500
Received: from mail-eopbgr800043.outbound.protection.outlook.com ([40.107.80.43]:20480
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbeLDHZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyQUMPV9wKWiQN01s9kU9ydcRCLzxYlIww1OpU2r7kk=;
 b=5uzf9OuyuyvJ+8EpKMEeVeQ2ojvGMeNKR0KbLz7oqBmdePq+xZAPdm/qj7WCGY8JhWedkMyou7JEpWfhliICQS8gCf0ZdkYkR+aNk803InyUPpWYcY2iFKLHpJckXs2o64sDFyUbis9lkZxYPE21hkVLlt4X67FwTONAyrFSDyY=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1426.namprd12.prod.outlook.com (10.168.228.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 07:25:14 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::f8a7:157:6224:34ee]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::f8a7:157:6224:34ee%2]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 07:25:14 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Eric Anholt <eric@anholt.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sched: Fix a use-after-free when tracing the
 scheduler.
Thread-Topic: [PATCH] drm/sched: Fix a use-after-free when tracing the
 scheduler.
Thread-Index: AQHUi0TcQWV1dqzGOEGXQBqiy8bezKVuLm+A
Date:   Tue, 4 Dec 2018 07:25:14 +0000
Message-ID: <5cc28f6d-15ab-3043-6f16-a293cd912807@amd.com>
References: <20181203201453.25773-1-eric@anholt.net>
In-Reply-To: <20181203201453.25773-1-eric@anholt.net>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:125b:9a00:a142:2be6:b7be:5a3a]
x-clientproxiedby: AM6PR0102CA0011.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::24) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1426;20:t7sFxZuSo4Acf8IT/gBvciGfLjG0L3Hy8ZMm2SkXjEgxgO6O+fHoDZz9BcQ/62RPIG8Irzac6Ld8sncpT+es2IdhhejNHqcnIj+6KCN8H4+WZSVqYzAXYSSId1qJRQoCldUhlctK7usLCPpthp4FQzo+RMY6d1s5so5STjzlM1cEdbyWEFOg3cryX/udVX+5Cfxum7IzKAW9WoQwzZPLRHweFut3h+PVUTzjMP0RPlJLBW8X9NIwUC4e5JCPpKgf
x-ms-office365-filtering-correlation-id: 95e995c7-8756-4b4e-379d-08d659b9a1e8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1426;
x-ms-traffictypediagnostic: BN6PR12MB1426:
x-microsoft-antispam-prvs: <BN6PR12MB1426DC1590F771ACEA58CB0883AF0@BN6PR12MB1426.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1426;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1426;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(39860400002)(346002)(189003)(199004)(229853002)(8936002)(68736007)(6246003)(14444005)(81166006)(53936002)(36756003)(81156014)(8676002)(4326008)(6116002)(31686004)(256004)(11346002)(2616005)(2906002)(476003)(446003)(97736004)(25786009)(46003)(305945005)(186003)(7736002)(65806001)(386003)(6506007)(6486002)(478600001)(65826007)(6512007)(2501003)(45080400002)(72206003)(86362001)(102836004)(65956001)(6436002)(106356001)(486006)(105586002)(64126003)(76176011)(5660300001)(71190400001)(52116002)(71200400001)(99286004)(110136005)(58126008)(316002)(2201001)(31696002)(575784001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1426;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5n774WGPbgrWmC2TpnWzQw+QN/EyXBsvK0lG9/rei+ig5B4Cf2DXmnb8ZVbrARLhTGYbHPIeQA6fRzX09Z+JyRdVRStrov+DpPchydkt/fAWkeucDNR1QzhpN2bMV5R5lWpLF2n3Hq5QxjxCl+qPER9iy0WLE6qQ4w8FsOBJ414dxQHQhQ5o2YlMTTVQAejk3R2SfR8q1zHyDGu7bf6/1Jp0HEBxlzVabbli2kiADdN+gAEyOjJdfkiUccmheoI+AXOC7tvau9guS3f7PdTSQhPRMM7SDkEIf7NsLJ9bPDVz92fTmmnR2WMF42JfBlPT7I0csWfmQL9v9TBlkwL7QhPMMzou5cRdDqBI8FCSnps=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <89550CD2DE3E9740946409F2294B41FA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e995c7-8756-4b4e-379d-08d659b9a1e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 07:25:14.3088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1426
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDMuMTIuMTggdW0gMjE6MTQgc2NocmllYiBFcmljIEFuaG9sdDoNCj4gV2l0aCBERUJVR19T
TEFCIChwb2lzb25pbmcgb24gZnJlZSkgZW5hYmxlZCwgSSBjb3VsZCBxdWlja2x5IHByb2R1Y2UN
Cj4gYW4gb29wcyB3aGVuIHRyYWNpbmcgVjNELg0KDQpHb29kIGNhdGNoLCBidXQgdGhlIHNvbHV0
aW9uIGlzIGEgY2xlYXIgTkFLLg0KDQpkcm1fc2NoZWRfZW50aXR5X2FkZF9kZXBlbmRlbmN5X2Ni
KCkgY2FuIHJlc3VsdCBpbiBzZXR0aW5nIA0KZW50aXR5LT5kZXBlbmRlbmN5IHRvIE5VTEwuIFRo
YXQgaW4gdHVybiBjYW4gbGVhZCB0byBhIG1lbW9yeSBsZWFrIA0KYmVjYXVzZSB3ZSBjYWxsIHRo
ZSBfcHV0IHdpdGggYSBOVUxMIGZlbmNlLg0KDQpJbnN0ZWFkIHdlIHNob3VsZCByYXRoZXIgY2Fs
bCB0cmFjZV9kcm1fc2NoZWRfam9iX3dhaXRfZGVwKCkgYmVmb3JlIGV2ZW4gDQpjYWxsaW5nIGRy
bV9zY2hlZF9lbnRpdHlfYWRkX2RlcGVuZGVuY3lfY2IoKS4gVGhpcyBpcyBhbHNvIGNsZWFuZXIg
DQpiZWNhdXNlIHdlIHdhbnQgdG8gdHJhY2Ugd2hpY2ggZGVwZW5kZW5jaWVzIHRoZSBkcml2ZXIg
Z2F2ZSB0byB0aGUgDQpzY2hlZHVsZXIgYW5kIG5vdCB3aGljaCB3ZSBhY3R1YWxseSBuZWVkZWQg
dG8gYWRkIGEgY2FsbGJhY2sgdG8uDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gU2ln
bmVkLW9mZi1ieTogRXJpYyBBbmhvbHQgPGVyaWNAYW5ob2x0Lm5ldD4NCj4gLS0tDQo+DQo+IEkg
dGhpbmsgdGhpcyBwYXRjaCBpcyBjb3JyZWN0ICh0aG91Z2ggbWF5YmUgYSBiaWdnZXIgcmVmYWN0
b3IgY291bGQNCj4gYXZvaWQgdGhlIGV4dHJhIGdldC9wdXQ/KSwgYnV0IEkndmUgc3RpbGwgZ290
IHRoaXMgd2l0aCAidmJsYW5rX21vZGU9MA0KPiBwZXJmIHJlY29yZCAtYSAtZSB2M2Q6LlwqIC1l
IGdwdV9zY2hlZHVsZXI6LlwqIGdseGdlYXJzIi4gIEFueSBpZGVhcz8NCj4NCj4gWyAgMTM5Ljg0
MjE5MV0gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0
IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAyMA0KPiBbICAxMzkuODUwNDEzXSBwZ2QgPSBlYWI3YmI1
Nw0KPiBbICAxMzkuODU0NDI0XSBbMDAwMDAwMjBdICpwZ2Q9ODAwMDAwNDAwMDQwMDMsICpwbWQ9
MDAwMDAwMDANCj4gWyAgMTM5Ljg2MDUyM10gSW50ZXJuYWwgZXJyb3I6IE9vcHM6IDIwNiBbIzFd
IFNNUCBBUk0NCj4gWyAgMTM5Ljg2NTM0MF0gTW9kdWxlcyBsaW5rZWQgaW46DQo+IFsgIDEzOS44
Njg0MDRdIENQVTogMCBQSUQ6IDExNjEgQ29tbTogdjNkX3JlbmRlciBOb3QgdGFpbnRlZCA0LjIw
LjAtcmM0KyAjNTUyDQo+IFsgIDEzOS44NzUyODddIEhhcmR3YXJlIG5hbWU6IEJyb2FkY29tIFNU
QiAoRmxhdHRlbmVkIERldmljZSBUcmVlKQ0KPiBbICAxMzkuODgxMjI4XSBQQyBpcyBhdCBwZXJm
X3RyYWNlX2RybV9zY2hlZF9qb2Jfd2FpdF9kZXArMHhhOC8weGY0DQo+IFsgIDEzOS44ODcyNDNd
IExSIGlzIGF0IDB4ZTk3OTAyNzQNCj4gWyAgMTM5Ljg5MDM4OF0gcGMgOiBbPGMwNmU3MTVjPl0g
ICAgbHIgOiBbPGU5NzkwMjc0Pl0gICAgcHNyOiBhMDA1MDAxMw0KPiBbICAxMzkuODk2NjYyXSBz
cCA6IGVkMjFkZWMwICBpcCA6IGVkMjFkZWMwICBmcCA6IGVkMjFkZjA0DQo+IFsgIDEzOS45MDE4
OTNdIHIxMDogZWQyNjc0NzggIHI5IDogMDAwMDAwMDAgIHI4IDogZmY3YmRlMDQNCj4gWyAgMTM5
LjkwNzEyM10gcjcgOiAwMDAwMDAwMCAgcjYgOiAwMDAwMDA2MyAgcjUgOiAwMDAwMDAwMCAgcjQg
OiBjMTIwODQ0OA0KPiBbICAxMzkuOTEzNjU5XSByMyA6IGMxMjY1NjkwICByMiA6IGZmN2JmNjYw
ICByMSA6IDAwMDAwMDM0ICByMCA6IGZmN2JmNjYwDQo+IFsgIDEzOS45MjAxOTZdIEZsYWdzOiBO
ekN2ICBJUlFzIG9uICBGSVFzIG9uICBNb2RlIFNWQ18zMiAgSVNBIEFSTSAgU2VnbWVudCB1c2Vy
DQo+IFsgIDEzOS45MjczMzldIENvbnRyb2w6IDMwYzUzODNkICBUYWJsZTogNjhmYTNiNDAgIERB
QzogZmZmZmZmZmQNCj4gWyAgMTM5LjkzMzA5NV0gUHJvY2VzcyB2M2RfcmVuZGVyIChwaWQ6IDEx
NjEsIHN0YWNrIGxpbWl0ID0gMHhiM2M4NGIxYikNCj4gWyAgMTM5LjkzOTQ1N10gU3RhY2s6ICgw
eGVkMjFkZWMwIHRvIDB4ZWQyMWUwMDApDQo+IFsgIDEzOS45NDM4MjFdIGRlYzA6IDIwMDUwMDEz
IGZmZmZmZmZmIGViOTcwMGNjIDAwMDAwMDAwIGVjMGU4ZTgwIDAwMDAwMDAwIGViOTcwMGNjIGU5
NzkwMjc0DQo+IFsgIDEzOS45NTIwMDldIGRlZTA6IDAwMDAwMDAwIGUyZjU5MzQ1IGViOTcwMDc4
IGViYThmNjgwIGMxMmFlMDBjIGMxMjA4NDc4IDAwMDAwMDAwIGU4YzJiMDQ4DQo+IFsgIDEzOS45
NjAxOTddIGRmMDA6IGViOTcwMGNjIGMwNmU5MmU0IGMwNmU4ZjA0IDAwMDAwMDAwIDgwMDUwMDEz
IGVkMjY3NDc4IGViOTcwMDc4IDAwMDAwMDAwDQo+IFsgIDEzOS45NjgzODVdIGRmMjA6IGVkMjY3
NTc4IGMwZTQ1YWUwIGU5MDkzMDgwIGMwNmU4MzFjIGVkMjY3NjMwIGMwNmU4MTIwIGMwNmU3N2Q0
IGMxMjA4NDQ4DQo+IFsgIDEzOS45NzY1NzNdIGRmNDA6IGVlMmU4YWNjIDAwMDAwMDAxIDAwMDAw
MDAwIGVlMmU4NjQwIGMwMjcyYWI0IGVkMjFkZjU0IGVkMjFkZjU0IGUyZjU5MzQ1DQo+IFsgIDEz
OS45ODQ3NjJdIGRmNjA6IGVkMjFjMDAwIGVkMWI0ODAwIGVkMmQ3ODQwIDAwMDAwMDAwIGVkMjFj
MDAwIGVkMjY3NDc4IGMwNmU4MDg0IGVlOTM1Y2IwDQo+IFsgIDEzOS45OTI5NTBdIGRmODA6IGVk
MWI0ODM4IGMwMjQ5YjQ0IGVkMjFjMDAwIGVkMmQ3ODQwIGMwMjQ5OWU0IDAwMDAwMDAwIDAwMDAw
MDAwIDAwMDAwMDAwDQo+IFsgIDE0MC4wMDExMzhdIGRmYTA6IDAwMDAwMDAwIDAwMDAwMDAwIDAw
MDAwMDAwIGMwMjAxMGFjIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwDQo+IFsg
IDE0MC4wMDkzMjZdIGRmYzA6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAw
MDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwDQo+IFsgIDE0MC4wMTc1MTRdIGRmZTA6
IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDEzIDAwMDAwMDAwIDAw
MDAwMDAwIDAwMDAwMDAwDQo+IFsgIDE0MC4wMjU3MDddIFs8YzA2ZTcxNWM+XSAocGVyZl90cmFj
ZV9kcm1fc2NoZWRfam9iX3dhaXRfZGVwKSBmcm9tIFs8YzA2ZTkyZTQ+XSAoZHJtX3NjaGVkX2Vu
dGl0eV9wb3Bfam9iKzB4Mzk0LzB4NDM4KQ0KPiBbICAxNDAuMDM2MzMyXSBbPGMwNmU5MmU0Pl0g
KGRybV9zY2hlZF9lbnRpdHlfcG9wX2pvYikgZnJvbSBbPGMwNmU4MTIwPl0gKGRybV9zY2hlZF9t
YWluKzB4OWMvMHgyOTgpDQo+IFsgIDE0MC4wNDUyMjFdIFs8YzA2ZTgxMjA+XSAoZHJtX3NjaGVk
X21haW4pIGZyb20gWzxjMDI0OWI0ND5dIChrdGhyZWFkKzB4MTYwLzB4MTY4KQ0KPiBbICAxNDAu
MDUyNzE2XSBbPGMwMjQ5YjQ0Pl0gKGt0aHJlYWQpIGZyb20gWzxjMDIwMTBhYz5dIChyZXRfZnJv
bV9mb3JrKzB4MTQvMHgyOCkNCj4NCj4gICBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVk
X2VudGl0eS5jIHwgNCArKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxl
ci9zY2hlZF9lbnRpdHkuYyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5
LmMNCj4gaW5kZXggNDQ2M2QzODI2ZWNiLi4wZDRmYzg2MDg5Y2IgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYw0KPiBAQCAtNDQwLDEzICs0NDAsMTUgQEAg
c3RydWN0IGRybV9zY2hlZF9qb2IgKmRybV9zY2hlZF9lbnRpdHlfcG9wX2pvYihzdHJ1Y3QgZHJt
X3NjaGVkX2VudGl0eSAqZW50aXR5KQ0KPiAgIA0KPiAgIAl3aGlsZSAoKGVudGl0eS0+ZGVwZW5k
ZW5jeSA9DQo+ICAgCQkJc2NoZWQtPm9wcy0+ZGVwZW5kZW5jeShzY2hlZF9qb2IsIGVudGl0eSkp
KSB7DQo+IC0NCj4gKwkJZG1hX2ZlbmNlX2dldChlbnRpdHktPmRlcGVuZGVuY3kpOw0KPiAgIAkJ
aWYgKGRybV9zY2hlZF9lbnRpdHlfYWRkX2RlcGVuZGVuY3lfY2IoZW50aXR5KSkgew0KPiAgIA0K
PiAgIAkJCXRyYWNlX2RybV9zY2hlZF9qb2Jfd2FpdF9kZXAoc2NoZWRfam9iLA0KPiAgIAkJCQkJ
CSAgICAgZW50aXR5LT5kZXBlbmRlbmN5KTsNCj4gKwkJCWRtYV9mZW5jZV9wdXQoZW50aXR5LT5k
ZXBlbmRlbmN5KTsNCj4gICAJCQlyZXR1cm4gTlVMTDsNCj4gICAJCX0NCj4gKwkJZG1hX2ZlbmNl
X3B1dChlbnRpdHktPmRlcGVuZGVuY3kpOw0KPiAgIAl9DQo+ICAgDQo+ICAgCS8qIHNraXAgam9i
cyBmcm9tIGVudGl0eSB0aGF0IG1hcmtlZCBndWlsdHkgKi8NCg0K

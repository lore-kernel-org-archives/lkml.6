Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6654BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F7720849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="a+FM5opc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F7720849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbeLKJOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:14:16 -0500
Received: from mail-eopbgr50043.outbound.protection.outlook.com ([40.107.5.43]:48256
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbeLKJOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXGv1V917NkDoMD9lzAXKnaaK4wxvKEW2K/gJvLAo2k=;
 b=a+FM5opcOJj9739UU6WG1O8LXA2lNrtrYiDq6mw0+5/2/9pXwPeeJX6qb0xzY48ScdrrgyWBSQB3+DaTEfI2GIHZwNJcPO99dvxhF0lto4+ARMkSyUhZIpDSonA5v/mu0mCzGjZGUcGHUkjAUGN59jGCztVJuwwRrWKCow03pho=
Received: from AM0PR05MB5777.eurprd05.prod.outlook.com (20.178.112.204) by
 AM0PR05MB6596.eurprd05.prod.outlook.com (20.178.117.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Tue, 11 Dec 2018 09:14:11 +0000
Received: from AM0PR05MB5777.eurprd05.prod.outlook.com
 ([fe80::5c13:8155:8f43:d597]) by AM0PR05MB5777.eurprd05.prod.outlook.com
 ([fe80::5c13:8155:8f43:d597%5]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 09:14:11 +0000
From:   Nitzan Carmi <nitzanc@mellanox.com>
To:     Jaesoo Lee <jalee@purestorage.com>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Roland Dreier <roland@purestorage.com>,
        Prabhath Sajeepa <psajeepa@purestorage.com>,
        Ashish Karkare <ashishk@purestorage.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-rdma: complete requests from ->timeout
Thread-Topic: [PATCH] nvme-rdma: complete requests from ->timeout
Thread-Index: AQHUiExYQRHTo0l5Ok2Ib0rLwH8o1qV2hJ2AgAIuMgCAAKBTAA==
Date:   Tue, 11 Dec 2018 09:14:10 +0000
Message-ID: <773bb91f-40a4-a525-f7b8-db821b402821@mellanox.com>
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
 <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>
 <b7b26a7a-70be-d805-ee64-67fba0b4efa8@mellanox.com>
 <CAJX3Cti_ZJF5E+NRuRzSeEUgaXsbA2U9C+Rh5OdYd4EMwXC1gw@mail.gmail.com>
In-Reply-To: <CAJX3Cti_ZJF5E+NRuRzSeEUgaXsbA2U9C+Rh5OdYd4EMwXC1gw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0102CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::25) To AM0PR05MB5777.eurprd05.prod.outlook.com
 (2603:10a6:208:112::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nitzanc@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR05MB6596;6:cbkkPCa/aYxE1ehEVXRz5pudWe5e0afPBHwN3vXp1Cd4foQKOQ4SLJl7H8UdgJksUESveqZj+G1qgJT+0YtjzymMgBcIvax8DOQe1zNYhlRXmGhNH3F8v8wzget1aaTezegHost8EAT3gIqjsXlAxkhGJeBcZ1PoOTG8wuSQCitRghFKCx5bcrcWQRqu7HkzNFDAMBs9FuyVOmS2h3+kU8+3XSW9YXarLUmCmlGaoh6GR4CEH5ISNXhQ5G+DPa1auiift/4kiYUSk7GVi30fMQBIsGOGoq+l6lnbKRJDHOrKVFa8+5VkFUq2z7OV7j/S0bRXoWY7fio0QwZmuMT9LGJXtP1VGZObGv1sVKD2HfMJS1WWP/ISvLHVaeYqfzGUkmxOVZkx2HRQ8AUeIvGK3N1ZWZufVyYs6wIR5WEvg7wEzxtTFgWCra8W9wxBt2Gb1kyzRpcQ/nA7Y+zvOKqfIw==;5:WJ4sNVn5bxru2i5KlRbKQrdeox/owdlHRu4uq56kaHvq8NEQy6gkQyioJnhR/CgLcHC5guWu5yYQ8n9YGSwpMpKfdQqngYrf4LhorkjWTC9IkjqWnGwOmkt00h1hlW5eOlcS93yhRpWIu/D7qd/twgnibrZYVf2/hWdE7mppT2I=;7:3r0T7cs95LTVn2YqNQVxz0biZpF2PN3Nb+GLl7q+ERzVyf4WX69yAGD48QewjP6GHmPn/SPYAeSeDRVz47zr6zsrM5cchNeoNbx4UQsR4KGdWMqD6J/sLEnlgXljCGaxNW70ycGFhUsSLhnjNcg0Fw==
x-ms-office365-filtering-correlation-id: 6e2bcf19-4722-4c5f-0b77-08d65f4902e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB6596;
x-ms-traffictypediagnostic: AM0PR05MB6596:
x-microsoft-antispam-prvs: <AM0PR05MB6596CEBCBD882F6A0C18F948C0A60@AM0PR05MB6596.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(4982022)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR05MB6596;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB6596;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(39860400002)(376002)(396003)(51444003)(189003)(199004)(52116002)(97736004)(6512007)(6306002)(99286004)(6486002)(36756003)(86362001)(6116002)(31696002)(66066001)(53936002)(14444005)(256004)(6246003)(76176011)(6436002)(7416002)(4326008)(5660300001)(486006)(25786009)(93886005)(6916009)(305945005)(8676002)(31686004)(2906002)(54906003)(6506007)(102836004)(386003)(8936002)(229853002)(53546011)(11346002)(476003)(14454004)(106356001)(105586002)(81156014)(68736007)(446003)(81166006)(966005)(2616005)(26005)(3846002)(7736002)(186003)(316002)(478600001)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB6596;H:AM0PR05MB5777.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qDVTu+fWb1MXk1PFj1oFOHklew8DtYmY0SELsICSqZD6FPDkprjB4j+85friTQ7kJPBXKYaSMLW1oE60qQqg/KVE4Wu4JIMZijo5RoFbtsgg5T5PgTHt9zIHrWe8tU/8C6m6fbtxiz8XS/P9Vlm5B/Fs6ZLssO3S4wEBr2VltFJ+/vOvDMeGCVcY2nhlwtzET2TpCGBfl1G2if05/FG2eAuFf38BGQSYR0E9XcLHcGsq2TLwh9BeKh/Nf9bo2VBwhelrg3gbcaE4VLtWBGBav8WXtRTjsaIPHqVOXfkZQi6dbyJezFlXh3Y46i5AD3GN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <49D963C57932E849BBFD8CD703D6D7CD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2bcf19-4722-4c5f-0b77-08d65f4902e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 09:14:10.9924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6596
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSB3YXMganVzdCBpbiB0aGUgbWlkZGxlIG9mIHNlbmRpbmcgdGhpcyB0byB1cHN0cmVhbSB3aGVu
IEkgc2F3IHlvdXIgDQptYWlsLCBhbmQgdGhvdWdodCB0b28gdGhhdCBpdCBhZGRyZXNzZXMgdGhl
IHNhbWUgYnVnLCBhbHRob3VnaCBJIHNlZSBhIA0KbGl0dGxlIGRpZmZlcmVudCBjYWxsIHRyYWNl
IHRoYW4geW91cnMuDQoNCkkgd291bGQgYmUgaGFwcHkgaWYgeW91IGNhbiB2ZXJpZnkgdGhhdCB0
aGlzIHBhdGNoIHdvcmtzIGZvciB5b3UgdG9vLA0KYW5kIHdlIGNhbiBwdXNoIGl0IHRvIHVwc3Ry
ZWFtLg0KDQpPbiAxMS8xMi8yMDE4IDAxOjQwLCBKYWVzb28gTGVlIHdyb3RlOg0KPiBJdCBzZWVt
cyB0aGF0IHlvdXIgcGF0Y2ggaXMgYWRkcmVzc2luZyB0aGUgc2FtZSBidWcuIEkgd2lsbCBzZWUg
aWYNCj4gdGhhdCB3b3JrcyBmb3Igb3VyIGZhaWx1cmUgc2NlbmFyaW9zLg0KPiANCj4gV2h5IGRv
bid0IHlvdSBtYWtlIGl0IHVwc3RyZWFtPw0KPiANCj4gT24gU3VuLCBEZWMgOSwgMjAxOCBhdCA2
OjIyIEFNIE5pdHphbiBDYXJtaSA8bml0emFuY0BtZWxsYW5veC5jb20+IHdyb3RlOg0KPj4NCj4+
IEhpLA0KPj4gV2UgZW5jb3VudGVyZWQgc2ltaWxhciBpc3N1ZS4NCj4+IEkgdGhpbmsgdGhhdCB0
aGUgcHJvYmxlbSBpcyB0aGF0IGVycm9yX3JlY292ZXJ5IG1pZ2h0IG5vdCBldmVuIGJlDQo+PiBx
dWV1ZWQsIGluIGNhc2Ugd2UncmUgaW4gREVMRVRJTkcgc3RhdGUgKG9yIENPTk5FQ1RJTkcgc3Rh
dGUsIGZvciB0aGF0DQo+PiBtYXR0ZXIpLCBiZWNhdXNlIHdlIGNhbm5vdCBtb3ZlIGZyb20gdGhv
c2Ugc3RhdGVzIHRvIFJFU0VUVElORy4NCj4+DQo+PiBXZSBwcmVwYXJlZCBzb21lIHBhdGNoZXMg
d2hpY2ggaGFuZGxlIGNvbXBsZXRpb25zIGluIGNhc2Ugc3VjaCBzY2VuYXJpbw0KPj4gaGFwcGVu
cyAod2hpY2gsIGluIGZhY3QsIG1pZ2h0IGhhcHBlbiBpbiBudW1lcm91cyBlcnJvciBmbG93cyku
DQo+Pg0KPj4gRG9lcyBpdCBzb2x2ZSB5b3VyIHByb2JsZW0/DQo+PiBOaXR6YW4uDQo+Pg0KPj4N
Cj4+IE9uIDMwLzExLzIwMTggMDM6MzAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+Pj4NCj4+Pj4g
VGhpcyBkb2VzIG5vdCBob2xkIGF0IGxlYXN0IGZvciBOVk1lIFJETUEgaG9zdCBkcml2ZXIuIEFu
IGV4YW1wbGUNCj4+Pj4gc2NlbmFyaW8NCj4+Pj4gaXMgd2hlbiB0aGUgUkRNQSBjb25uZWN0aW9u
IGlzIGdvbmUgd2hpbGUgdGhlIGNvbnRyb2xsZXIgaXMgYmVpbmcNCj4+Pj4gZGVsZXRlZC4NCj4+
Pj4gSW4gdGhpcyBjYXNlLCB0aGUgbnZtZl9yZWdfd3JpdGUzMigpIGZvciBzZW5kaW5nIHNodXRk
b3duIGFkbWluDQo+Pj4+IGNvbW1hbmQgYnkNCj4+Pj4gdGhlIGRlbGV0ZV93b3JrIGNvdWxkIGJl
IGh1bmcgZm9yZXZlciBpZiB0aGUgY29tbWFuZCBpcyBub3QgY29tcGxldGVkIGJ5DQo+Pj4+IHRo
ZSB0aW1lb3V0IGhhbmRsZXIuDQo+Pj4NCj4+PiBJZiB0aGUgcXVldWUgaXMgZ29uZSwgdGhpcyBt
ZWFucyB0aGF0IHRoZSBxdWV1ZSBoYXMgYWxyZWFkeSBmbHVzaGVkIGFuZA0KPj4+IGFueSBjb21t
YW5kcyB0aGF0IHdlcmUgaW5mbGlnaHQgaGFzIGNvbXBsZXRlZCB3aXRoIGEgZmx1c2ggZXJyb3IN
Cj4+PiBjb21wbGV0aW9uLi4uDQo+Pj4NCj4+PiBDYW4geW91IGRlc2NyaWJlIHRoZSBzY2VuYXJp
byB0aGF0IGNhdXNlZCB0aGlzIGhhbmc/IFdoZW4gaGFzIHRoZQ0KPj4+IHF1ZXVlIGJlY2FtZSAi
Z29uZSIgYW5kIHdoZW4gZGlkIHRoZSBzaHV0ZG93biBjb21tYW5kIGV4ZWN1dGU/DQo+Pj4NCj4+
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPj4+IExp
bnV4LW52bWUgbWFpbGluZyBsaXN0DQo+Pj4gTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
DQo+Pj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lDQo=

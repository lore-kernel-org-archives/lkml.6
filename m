Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CC2C282D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13ADE2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 06:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="Arr7Z+ow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfBDGzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 01:55:47 -0500
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:19587
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbfBDGzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 01:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrRCBvGwGQOQrISjxnHdPUikQv648T3buvvSQ7kW9H4=;
 b=Arr7Z+owelD2g1YL3/L1dxPKAPdKVGnSwu4xpJ15Pvkh8gwj5/7VPcx4Z5e1wiZvgwjIEm7MO24eMNU4dndR4MhxTjAf9R/sbgohFxxrsD9QofzpeixoqswkPxHg2G1y/+uYQoso7X8YlwY9cVFIX6fPcZSdCz0HzyTPQZJwIzg=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB4294.eurprd03.prod.outlook.com (20.177.32.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Mon, 4 Feb 2019 06:55:42 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7%2]) with mapi id 15.20.1580.019; Mon, 4 Feb 2019
 06:55:42 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     Julien Grall <julien.grall@arm.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [Xen-devel][PATCH] drm/xen-front: Fix mmap attributes for display
 buffers
Thread-Topic: [Xen-devel][PATCH] drm/xen-front: Fix mmap attributes for
 display buffers
Thread-Index: AQHUt+PwOT/atadd5E6cEP5jJm29BKXGnAiAgAiheIA=
Date:   Mon, 4 Feb 2019 06:55:41 +0000
Message-ID: <fd0a3e68-a190-51ee-2b25-6de790f8b845@epam.com>
References: <20190129150422.19867-1-andr2000@gmail.com>
 <bf8cf8d9-7092-d956-44d2-e55233f495d2@arm.com>
In-Reply-To: <bf8cf8d9-7092-d956-44d2-e55233f495d2@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB4294;6:mZ/pnswrnir/eImp3TOuaB9jWJ4Wq5vvuKdsHyBr46iWQtXx0sUipyhz1RKTVHQRE3cI7mq33lqWfocrjAi7VVQ+wjlqPz29fuxH27mooSG3CfIXYUFcTVT8c2i2zK3LYEOX0hzMo+S0qIzya6zTu2i0L35ZeXnSplsvSuBhKmiKe0UkOusYt+Ozbc90QMNUbsK2fZVNj+p8SaJXZLRwr8evAQjy6HCNNy6DJGRZnJITGN/+XkWProrTlThms0TnapZztNmYDaM1OTKTjyMUCB+lsPIpn15pIzvsDqrh9ZBeQphaHAEo+a8gHgv7/YztkwS3hr9mc4AEkQDbExmBhICtaCc2k1tPLsBvGrxEU14l31/UsQ7szH5/3yum25RwTw3EkG9Ynl5HtNykZIQxqOfj7dXzq9g/Ys+MwyTNJS7kUkkjmwUsgO+Fmrk7LY5STkkFv0UG/TE4rqziPyfgvg==;5:7ym6Y+ap2GbZa2kGOC2E7f8Jf0Z86Aol66zqkXKYZULZDOn4kqt4V/8pHbeVE3+dP1x4R1wzz2kUy9Gtz4bvd+xnfYf+M3cFcNBxeCTzn2h14nmprbCdpT1y4p7Sq8feY+IAtRd7hVwddxJrx+wGx2NmmYEPgnZyIzucQR7AUbKdg62miGdl/KtoNjU/bKZAaSrkEWuAXjPshZU4gpWiCQ==;7:983jGlJbHnxWQI84H+Hm08tlkFKzLyjnpf5Gr/s+VbzS0mQ4lPNE+mjQv649QGhJ0xjQNBTIphOMxv9Grv8y0JyqNu7U7n4CcoNyWRR2k3ARGjZVl3B7VYh69uhNq5c/SeE6nUlpV8OimBezT8A18Q==
x-ms-office365-filtering-correlation-id: 29dbea05-97b0-4938-4d6a-08d68a6dc77a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB4294;
x-ms-traffictypediagnostic: AM6PR03MB4294:
x-microsoft-antispam-prvs: <AM6PR03MB42949E856DCEF1CB08818817E76D0@AM6PR03MB4294.eurprd03.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(136003)(396003)(189003)(199004)(105586002)(305945005)(6246003)(80792005)(106356001)(256004)(2501003)(316002)(11346002)(2616005)(97736004)(110136005)(71190400001)(71200400001)(39060400002)(68736007)(6486002)(446003)(6512007)(2906002)(2201001)(31686004)(81166006)(81156014)(26005)(36756003)(7416002)(6436002)(229853002)(31696002)(8936002)(55236004)(86362001)(76176011)(486006)(7736002)(25786009)(6116002)(72206003)(66066001)(14454004)(478600001)(476003)(186003)(99286004)(6506007)(53546011)(53936002)(8676002)(3846002)(14444005)(102836004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB4294;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PX9d2iWXS3v8BwFQdwMAh2ZY53+05x51+PD17QEU0ImtFrFIkAsAxQ23J8/eF1SuYelFBtL6Kjnq2J5w5oz4AqWaDxyk0FDgRy3SlcC9yCl8QqVClmoHH1m40pL0MqWB4NLR5E/jdoKNSMCCQM+ewolpF5/DlNuKY4CzvJcZQApgZQi9817WoxSRMSQfymk72qv+j1wy9ius4MszDDEkTM3Eq0DvBs2Jv2aQJnbL+l60qgHL42Fq3OdwuCwK5Dbd/2T8RXLj5I9WvHIcrc5uaQjYZu1oEwSxZtlDss751l7ejBBXDUdTTLaFPuUqW/o285X1lkTlYGPzFkujM5IH48o9DxJ74UAmQCb7QPrB3IMDmlX/oUN+i2nZ+G18Yxe8BoS/mGrqWOKAGC+EcoQZs3KHxdaDrIl5pJfT2lNRQ8o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC8547AECF180D44AE93EA8E3212C597@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29dbea05-97b0-4938-4d6a-08d68a6dc77a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 06:55:42.1422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yOS8xOSA5OjA3IFBNLCBKdWxpZW4gR3JhbGwgd3JvdGU6DQo+IEhpIE9sZWtzYW5kciwN
Cj4NCj4gT24gMS8yOS8xOSAzOjA0IFBNLCBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyB3cm90ZToN
Cj4+IEZyb206IE9sZWtzYW5kciBBbmRydXNoY2hlbmtvIDxvbGVrc2FuZHJfYW5kcnVzaGNoZW5r
b0BlcGFtLmNvbT4NCj4+DQo+PiBXaGVuIEdFTSBiYWNraW5nIHN0b3JhZ2UgaXMgYWxsb2NhdGVk
IHRob3NlIGFyZSBub3JtYWwgcGFnZXMsDQo+PiBzbyB0aGVyZSBpcyBubyBwb2ludCB1c2luZyBw
Z3Byb3Rfd3JpdGVjb21iaW5lIHdoaWxlIG1tYXBpbmcuDQo+PiBUaGlzIGZpeGVzIG1pc21hdGNo
IG9mIGJ1ZmZlciBwYWdlcycgbWVtb3J5IGF0dHJpYnV0ZXMgYmV0d2Vlbg0KPj4gdGhlIGZyb250
ZW5kIGFuZCBiYWNrZW5kIHdoaWNoIG1heSBjYXVzZSBzY3JlZW4gYXJ0aWZhY3RzLg0KPj4NCj4+
IEZpeGVzOiBjNTc1YjdlZWI4OWYgKCJkcm0veGVuLWZyb250OiBBZGQgc3VwcG9ydCBmb3IgWGVu
IFBWIGRpc3BsYXkgDQo+PiBmcm9udGVuZCIpDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogT2xla3Nh
bmRyIEFuZHJ1c2hjaGVua28gDQo+PiA8b2xla3NhbmRyX2FuZHJ1c2hjaGVua29AZXBhbS5jb20+
DQo+PiBTdWdnZXN0ZWQtYnk6IEp1bGllbiBHcmFsbCA8anVsaWVuLmdyYWxsQGFybS5jb20+DQo+
PiAtLS0NCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS94ZW4veGVuX2RybV9mcm9udF9nZW0uYyB8IDUg
KystLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS94ZW4veGVuX2RybV9mcm9u
dF9nZW0uYyANCj4+IGIvZHJpdmVycy9ncHUvZHJtL3hlbi94ZW5fZHJtX2Zyb250X2dlbS5jDQo+
PiBpbmRleCBkMzAzYTJlMTdmNWUuLjlkNWMwM2Q3NjY4ZCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS94ZW4veGVuX2RybV9mcm9udF9nZW0uYw0KPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3hlbi94ZW5fZHJtX2Zyb250X2dlbS5jDQo+PiBAQCAtMjM1LDggKzIzNSw3IEBAIHN0YXRp
YyBpbnQgZ2VtX21tYXBfb2JqKHN0cnVjdCB4ZW5fZ2VtX29iamVjdCANCj4+ICp4ZW5fb2JqLA0K
Pj4gwqDCoMKgwqDCoCB2bWEtPnZtX2ZsYWdzICY9IH5WTV9QRk5NQVA7DQo+PiDCoMKgwqDCoMKg
IHZtYS0+dm1fZmxhZ3MgfD0gVk1fTUlYRURNQVA7DQo+PiDCoMKgwqDCoMKgIHZtYS0+dm1fcGdv
ZmYgPSAwOw0KPj4gLcKgwqDCoCB2bWEtPnZtX3BhZ2VfcHJvdCA9DQo+PiAtIHBncHJvdF93cml0
ZWNvbWJpbmUodm1fZ2V0X3BhZ2VfcHJvdCh2bWEtPnZtX2ZsYWdzKSk7DQo+PiArwqDCoMKgIHZt
YS0+dm1fcGFnZV9wcm90ID0gdm1fZ2V0X3BhZ2VfcHJvdCh2bWEtPnZtX2ZsYWdzKTsNCj4NCj4g
VGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuIEl0IHdvdWxkIGJlIHdvcnRoIGV4cGFuZGluZyB0
aGUgY29tbWVudCBhIA0KPiBiaXQgYmVmb3JlIHRvIGV4cGxhaW4gdGhhdCB3ZSBvdmVyd3JpdGUg
dm1fcGFnZV9wcm90IHRvIHVzZSBjYWNoZWFibGUgDQo+IGF0dHJpYnV0ZSBhcyByZXF1aXJlZCBi
eSB0aGUgWGVuIEFCSS4NCj4NCj4gV2l0aCB0aGUgY29tbWVudCB1cGRhdGVkOg0KPg0KPiBBY2tl
ZC1ieTogSnVsaWVuIEdyYWxsIDxqdWxpZW4uZ3JhbGxAYXJtLmNvbT4NCj4NCj4gQ2hlZXJzLA0K
Pg0KQXBwbGllZCB0byBkcm0tbWlzYy1uZXh0

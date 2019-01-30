Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9250C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531942184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="LsHZQElu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfA3IjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:39:23 -0500
Received: from mail-eopbgr30067.outbound.protection.outlook.com ([40.107.3.67]:22208
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbfA3IjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3FwDWymzsCKIugUXsFE2Q+03HJtI71s95tDxduJ7HY=;
 b=LsHZQEluseEvVHtbgbMs36XIuB2Srq+HBRBm5+ay9A6dYSE8OMYsF9/IaCzIIas1bTfWgyGSPVwz2tPmcAbXiwedWKTXsL+yoci8eecfqPN86v8k7Iszy7bfbndacU89uY9mOsm8r1tYNnW0EPIfhw+EaeypCxuav9llzquYhxU=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB4326.eurprd03.prod.outlook.com (20.177.33.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Wed, 30 Jan 2019 08:39:13 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7%2]) with mapi id 15.20.1558.023; Wed, 30 Jan 2019
 08:39:13 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     Julien Grall <julien.grall@arm.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "jgross@suse.com" <jgross@suse.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [Xen-devel] [PATCH v2] drm/xen-front: Make shmem backed display
 buffer coherent
Thread-Topic: [Xen-devel] [PATCH v2] drm/xen-front: Make shmem backed display
 buffer coherent
Thread-Index: AQHUrNs7IxVSN/1nuUaI+Ik1wHznAaWxcBsAgAAB0ICAAAHygIABvZOAgAGYZ4CAACKFAIAEx8GAgABKW4CAASIegIAAFYGAgANT5QCAAAfggIAJAvoA
Date:   Wed, 30 Jan 2019 08:39:13 +0000
Message-ID: <e13c2daf-cacd-2753-ac52-42d2668b88cc@epam.com>
References: <20190115140420.4652-1-andr2000@gmail.com>
 <20190116063002.jq3aas6ofhaogmyk@sirius.home.kraxel.org>
 <20190116063631.GA10881@infradead.org>
 <042fe794-dec6-6d9d-5b68-6f142790f5c7@epam.com>
 <20190117091815.GA7090@infradead.org>
 <1cfc5cb4-e481-5d71-29df-958db76fb681@epam.com>
 <2ed681b9-c8d4-ea27-6b8b-e399ed034bda@arm.com>
 <b5ee0d1c-7888-28c4-c5ae-7984c5e54c8e@epam.com>
 <9e0130ee-0418-f68c-94cf-31a5566d929a@arm.com>
 <79ac0743-68bc-c2b7-d843-cf152c40d583@epam.com>
 <34a31bc8-96c6-2801-689c-3c4498b68ee8@arm.com>
 <b0cfe533-5b0b-e20f-eeab-2ce743914c98@epam.com>
 <e5193e96-a80e-23fd-c833-447d6a2a1574@arm.com>
In-Reply-To: <e5193e96-a80e-23fd-c833-447d6a2a1574@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB4326;6:vGlmJ8IOuqhgQ2hiEKzrywgeqHHDvjYyYI2dzQqkZYZ8bwUCnPBzcDPgu4QSUCqCHhS/WKK9zDgGrggvF6N5yaqr5iv+rQ1fxydiOaNTqDEsP7P4yAH/y14XTUOBWsdqxoLvoMyYh+uvHEUEb24l+u6cq0nlRxmPeUzYyvaKNjXgha+w03GFdOTZqC4p3wzLpHbwOreIJKS6cWbEh9J9YIDQG6HIpseurd1e+nwwYbxasdF/MRPJvJWl5CNkMSlH+9BUBw5gjTAkhJb2UpFOn+VkYtdGFvZT+ehWPbBw65kvmmjvULybCktswJL894tTkWq21h4E+3UkYmiIug8PlvUXPTNR1Ko9aAl2dZvrZq5BKQLlKyYE0OUx2U/PLB2a34hGILyR4B16k+1WqkYsjygXsHpNflqCYMqvyMJdoGcPlxExwG3Ey8yIyRkzC9j5xc7tZgdLel+ftxBcrhfvBA==;5:WkNxvosP9jM4U30TrSaGjlAwrSYPEpOkSGgxQs96NXvedxH0W10ezo+COPsBm/mby4c/Y7GjokzJOoRSp3g+IemuU4ZNkJpeTKLuB5n7vqLvEcTTxGByVGwjD5kPTe+2Mc6MU85ib0bRlsG36I4/fG3qApG/Su+n8Ji1p2fc71fmFBXj5F1jOC7Y5rGU9PXXSscQi2J99gjfHTcY8Szm1A==;7:tpafrm1iRvPSal+0Ajrz+oADGoJis4kiTw/JrbfR6ZljPyaGyQ+MuVRTU5AM+lrCJA2xtXH1prd2dkuXERtolsAPJxLCLmylk4Mvy959cFAl+ZdkbfZgI+oHqUsWSKCNofdMGe/UKIUsz9cz/Ufl2w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7f24eaa3-1b3b-4653-d329-08d6868e69b0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB4326;
x-ms-traffictypediagnostic: AM6PR03MB4326:
x-microsoft-antispam-prvs: <AM6PR03MB43266DD3E25EC6503C98E8B8E7900@AM6PR03MB4326.eurprd03.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(366004)(52314003)(189003)(199004)(106356001)(110136005)(186003)(6246003)(54906003)(26005)(80792005)(76176011)(316002)(229853002)(14454004)(53936002)(39060400002)(6436002)(68736007)(53546011)(55236004)(72206003)(2906002)(6506007)(105586002)(66066001)(6486002)(6512007)(478600001)(6306002)(99286004)(7416002)(31686004)(36756003)(4326008)(71200400001)(966005)(7736002)(8676002)(486006)(97736004)(102836004)(71190400001)(305945005)(93886005)(14444005)(8936002)(86362001)(6116002)(25786009)(81166006)(81156014)(476003)(31696002)(3846002)(11346002)(2616005)(446003)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB4326;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xcre+AQgokKI8gk8boR8Fr0+cityxxCHkhqX7osdao502s+ZUfcGPMxXMX68QP2t+PIdWCME5fsD/tH7fnmuuP+vKwp/rcI8OcTb1Kf9zsboHrd36zKNVHW8gmNsr9aoZRudSlJa+H1cBuWXi4pb7cEFUT+zm06uLVTko2NJQVheAfTVbj7bLZLES5G2TGQoemHPTXftmvXo7aItMOAlMJMwMZxZkt9QuttD7ODu231ZaX0VzZOK8Mle5vEouPVSkoJZu9Qwl7BdA4Neep+RvUu0eb08lmyXT6SJqiIMPZ8byD9WCFtLMCS2d4hdBVHL5Ll82gpRsocsgiJhd4gewtHOhPK4FOh7cYOX1d8c6V2eNrmuq5RF6DkCnkp8U8NXUfzlVT5Qf1weeHfISJSSE77Dq+fVv2QOi0zfMdfRrO4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5550ADE4A6FF8C48B8BD790F46C2CAD3@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f24eaa3-1b3b-4653-d329-08d6868e69b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 08:39:13.4927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4326
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RHJvcHBlZCBpbiBmYXZvciBvZiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS8xLzI5LzkxMA0K
DQpPbiAxLzI0LzE5IDU6MDIgUE0sIEp1bGllbiBHcmFsbCB3cm90ZToNCj4NCj4NCj4gT24gMjQv
MDEvMjAxOSAxNDozNCwgT2xla3NhbmRyIEFuZHJ1c2hjaGVua28gd3JvdGU6DQo+PiBIZWxsbywg
SnVsaWVuIQ0KPg0KPiBIaSwNCj4NCj4+IE9uIDEvMjIvMTkgMTo0NCBQTSwgSnVsaWVuIEdyYWxs
IHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBPbiAxLzIyLzE5IDEwOjI4IEFNLCBPbGVrc2FuZHIgQW5k
cnVzaGNoZW5rbyB3cm90ZToNCj4+Pj4gSGVsbG8sIEp1bGllbiENCj4+Pg0KPj4+IEhpLA0KPj4+
DQo+Pj4+IE9uIDEvMjEvMTkgNzowOSBQTSwgSnVsaWVuIEdyYWxsIHdyb3RlOg0KPj4+PiBXZWxs
LCBJIGRpZG4ndCBnZXQgdGhlIGF0dHJpYnV0ZXMgb2YgcGFnZXMgYXQgdGhlIGJhY2tlbmQgc2lk
ZSwgYnV0IA0KPj4+PiBJTU8NCj4+Pj4gdGhvc2UNCj4+Pj4gZG8gbm90IG1hdHRlciBpbiBteSB1
c2UtY2FzZSAoZm9yIHNpbXBsaWNpdHkgSSBhbSBub3QgdXNpbmcNCj4+Pj4gemVyby1jb3B5aW5n
IGF0DQo+Pj4+IGJhY2tlbmQgc2lkZSk6DQo+Pj4NCj4+PiBUaGV5IGFyZSBhY3R1YWxseSBpbXBv
cnRhbnQgbm8gbWF0dGVyIHdoYXQgaXMgeW91ciB1c2UgY2FzZS4gSWYgeW91DQo+Pj4gYWNjZXNz
IHRoZSBzYW1lIHBoeXNpY2FsIHBhZ2Ugd2l0aCBkaWZmZXJlbnQgYXR0cmlidXRlcywgdGhlbiB5
b3UgYXJlDQo+Pj4gYXNraW5nIGZvciB0cm91YmxlLg0KPj4gU28sIHdlIGhhdmU6DQo+Pg0KPj4g
RG9tVTogZnJvbnRlbmQgc2lkZQ0KPj4gPT09PT09PT09PT09PT09PT09PT0NCj4+ICFQVEVfUkRP
TkxZICsgUFRFX1BYTiArIFBURV9TSEFSRUQgKyBQVEVfQUYgKyBQVEVfVVhOICsNCj4+IFBURV9B
VFRSSU5EWChNVF9OT1JNQUwpDQo+DQo+IEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFuZCBob3cgeW91
IGNhbWUgdXAgd2l0aCBNVF9OT1JNQUwgd2hlbiB5b3Ugc2VlbSANCj4gdG8gY29uZmlybS4uLg0K
Pg0KPj4NCj4+IERvbUQ6IGJhY2tlbmQgc2lkZQ0KPj4gPT09PT09PT09PT09PT09PT09PT0NCj4+
IFBURV9VU0VSICsgIVBURV9SRE9OTFkgKyBQVEVfUFhOICsgUFRFX05HICsgUFRFX0NPTlQgKyBQ
VEVfVEFCTEVfQklUICsNCj4+IFBURV9VWE4gKyBQVEVfQVRUUklORFgoTVRfTk9STUFMKQ0KPj4N
Cj4+IMKgIEZyb20gdGhlIGFib3ZlIGl0IHNlZW1zIHRoYXQgSSBkb24ndCB2aW9sYXRlIGNhY2hl
ZC9ub24tY2FjaGVkDQo+PiBhZ3JlZW1lbnQgaGVyZQ0KPj4+DQo+Pj4gVGhpcyBpcyB3aHkgWGVu
IGltcG9zZXMgYWxsIHRoZSBwYWdlcyBzaGFyZWQgdG8gaGF2ZSB0aGVpciBtZW1vcnkNCj4+PiBh
dHRyaWJ1dGVzIGZvbGxvd2luZyBzb21lIHJ1bGVzLiBBY3R1YWxseSwgc3BlYWtpbmcgd2l0aCBN
YXJrIFIuLCB3ZQ0KPj4+IG1heSB3YW50IHRvIHRpZ2h0IGEgYml0IG1vcmUgdGhlIGF0dHJpYnV0
ZXMuDQo+Pj4NCj4+Pj4NCj4+Pj4gMS4gRnJvbnRlbmQgZGV2aWNlIGFsbG9jYXRlcyBkaXNwbGF5
IGJ1ZmZlciBwYWdlcyB3aGljaCBjb21lIGZyb20gDQo+Pj4+IHNobWVtDQo+Pj4+IGFuZCBoYXZl
IHRoZXNlIGF0dHJpYnV0ZXM6DQo+Pj4+ICFQVEVfUkRPTkxZICsgUFRFX1BYTiArIFBURV9TSEFS
RUQgKyBQVEVfQUYgKyBQVEVfVVhOICsNCj4+Pj4gUFRFX0FUVFJJTkRYKE1UX05PUk1BTCkNCj4+
Pg0KPj4+IE15IGtub3dsZWRnZSBvZiBYZW4gRFJNIGlzIGluZXhpc3RlbnQuIEhvd2V2ZXIsIGxv
b2tpbmcgYXQgdGhlIGNvZGUgaW4NCj4+PiA1LjAtcmMyLCBJIGRvbid0IHNlZW0gdG8gZmluZCB0
aGUgc2FtZSBhdHRyaWJ1dGVzLiBGb3IgaW5zdGFuY2UNCj4+PiB4ZW5fZHJtX2Zyb250X2dlbV9w
cmltZV92bWFwIGFuZCBnZW1fbW1hcF9vYmogYXJlIHVzaW5nDQo+Pj4gcGdwcm90X3dyaXRlY29t
YmluZS4gU28gaXQgbG9va3MgbGlrZSwgdGhlIG1hcHBpbmcgd2lsbCBiZQ0KPj4+IG5vbi1jYWNo
ZWFibGUgb24gQXJtNjQuDQo+Pj4NCj4+PiBDYW4geW91IGV4cGxhaW4gaG93IHlvdSBjYW1lIHVw
IHRvIHRoZXNlIGF0dHJpYnV0ZXM/DQo+PiBwZ3Byb3Rfd3JpdGVjb21iaW5lIGlzIFBURV9BVFRS
SU5EWChNVF9OT1JNQUxfTkMpLCBzbyBpdCBzZWVtcyB0byBiZQ0KPj4gYXBwbGljYWJsZSBoZXJl
PyBbMV0NCj4NCj4gLi4uIHRoYXQgTVRfTk9STUFMX05DIGlzIHVzZWQgZm9yIHRoZSBmcm9udGVu
ZCBwYWdlcy4NCj4NCj4gTVRfTk9STUFMX05DIGlzIGRpZmZlcmVudCBmcm9tIE1UX05PUk1BTC4g
VGhlIHVzZSBvZiB0aGUgZm9ybWVyIHdpbGwgDQo+IHJlc3VsdCB0byBub24tY2FjaGVhYmxlIG1l
bW9yeSB3aGlsZSB0aGUgbGF0dGVyIHdpbGwgcmVzdWx0IHRvIA0KPiBjYWNoZWFibGUgbWVtb3J5
Lg0KPg0KPiBUbyBtZSwgdGhpcyBsb29rcyBsaWtlIHRoZSBleGFjdCByZWFzb24gd2h5IHlvdSBz
ZWUgYXJ0aWZhY3Qgb24gdGhlIA0KPiBkaXNwbGF5IGJ1ZmZlci4gQXMgdGhlIGF1dGhvciBvZiB0
aGlzIGNvZGUsIGNhbiB5b3UgZXhwbGFpbiB3aHkgeW91IA0KPiBkZWNpZGVkIHRvIHVzZSBwZ3By
b3Rfd3JpdGVjb21iaW5lIGhlcmUgaW5zdGVhZCBvZiByZWx5aW5nIG9uIHRoZSANCj4gZGVmYXVs
dCBWTUEgcHJvdD8NCj4NCj4gWy4uLl0NCj4NCj4+PiBXZSBhY3R1YWxseSBuZXZlciByZXF1aXJl
ZCB0byB1c2UgY2FjaGUgZmx1c2ggaW4gb3RoZXIgUFYgcHJvdG9jb2wsIHNvDQo+Pj4gSSBzdGls
bCBkb24ndCB1bmRlcnN0YW5kIHdoeSB0aGUgUFYgRFJNIHNob3VsZCBiZSBkaWZmZXJlbnQgaGVy
ZS4NCj4+IFdlbGwsIHlvdSBhcmUgcmlnaHQuIEJ1dCBhdCB0aGUgc2FtZSB0aW1lIG5vdCBmbHVz
aGluZyB0aGUgYnVmZmVyIG1ha2VzDQo+PiB0cm91YmxlcywNCj4+IHNvIHRoaXMgaXMgd2h5IEkg
YW0gdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgd2hhdCBpcyB3cm9uZyBoZXJlLg0KPg0KPiBUaGUgY2Fj
aGUgZmx1c2ggaXMgbGlrZWx5IGhpZGluZyB0aGUgcmVhbCBwcm9ibGVtIHJhdGhlciB0aGFuIHNv
bHZpbmcgaXQuDQo+DQo+Pj4NCj4+PiBUbyBtZSwgaXQgbG9va3MgbGlrZSB0aGF0IHlvdSBhcmUg
ZWl0aGVyIG1pc3Npbmcgc29tZSBiYXJyaWVycw0KPj4gQmFycmllcnMgZm9yIHRoZSBidWZmZXI/
IE5vdCBzdXJlIHdoYXQgeW91IG1lYW4gaGVyZS4NCj4NCj4gSWYgeW91IHNoYXJlIGluZm9ybWF0
aW9uIGJldHdlZW4gdHdvIGVudGl0aWVzLCB5b3UgbWF5IG5lZWQgc29tZSANCj4gb3JkZXJpbmcg
c28gdGhlIGluZm9ybWF0aW9uIGFyZSBzZWVuIGNvbnNpc3RlbnRseSBieSB0aGUgY29uc3VtZXIg
DQo+IHNpZGUuIFRoaXMgY2FuIGJlIGFjaGlldmVkIGJ5IHVzaW5nIGJhcnJpZXJzLg0KPg0KPj4g
RXZlbiBtb3JlLCB3ZSBoYXZlDQo+PiBhIHVzZSBjYXNlDQo+PiB3aGVuIHRoZSBidWZmZXIgaXMg
bm90IHRvdWNoZWQgYnkgQ1BVIGluIERvbUQgYW5kIGlzIHNvbGVseSBvd25lZCBieSANCj4+IHRo
ZSBIVy4NCj4NCj4gTWVtb3J5IG9yZGVyaW5nIGlzc3VlcyBhcmUgc3VidGxlLiBUaGUgZmFjdCB0
aGF0IG9uZSBvZiB5b3VyIHVzZS1jYXNlIA0KPiB3b3JrcyBkb2VzIG5vdCBpbXBseSB0aGF0IGJh
cnJpZXJzIGFyZSBub3QgbmVjZXNzYXJ5LiBJIGFtIG5vdCBzYXlpbmcgDQo+IHRoZXJlIGFyZSBh
IG1pc3NpbmcgYmFycmllcnMsIEkgYW0gb25seSBwb2ludGVkIG91dCBwb3RlbnRpYWwgcmVhc29u
cy4NCj4NCj4gQW55d2F5LCBJIGRvbid0IHRoaW5rIHlvdXIgcHJvYmxlbSBpcyBhIG1pc3Npbmcg
YmFycmllcnMgaGVyZS4gSXQgaXMgDQo+IG1vcmUgbGlrZWx5IGJlY2F1c2Ugb2YgbWlzbWF0Y2gg
bWVtb3J5IGF0dHJpYnV0ZXMgKHNlZSBhYm92ZSkuDQo+DQo+IENoZWVycywNCj4NCg==

Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4636C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CFC20844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="U0Ac99hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBAI4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:56:41 -0500
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:63002
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbfBAI4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0HgXi60gRJucFBcujIiKUDSDp6gQIFcm/FlBcHN3EM=;
 b=U0Ac99hvT8O3dxHCwac5mZWDd/X9pQS8El9DdyTqOWQUDFDdDfAslkS0GOTWVr1uEmobcIb6ABFGKmnkVu5bon6pQOvbIGIZgMR8+sM190zYYn6Iudk9H8eg3Nn9qYTuqIdMGFufa5+1S+iSYrzEonQVZ49Sdi2v7FIpUlgfdjc=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB5000.eurprd03.prod.outlook.com (20.178.90.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Fri, 1 Feb 2019 08:56:37 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7%2]) with mapi id 15.20.1558.026; Fri, 1 Feb 2019
 08:56:37 +0000
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
Thread-Index: AQHUt+PwOT/atadd5E6cEP5jJm29BKXGnAiAgADrJwCAAyEdgA==
Date:   Fri, 1 Feb 2019 08:56:37 +0000
Message-ID: <0d8b65b0-7919-8f15-0c97-e35eacd21fa1@epam.com>
References: <20190129150422.19867-1-andr2000@gmail.com>
 <bf8cf8d9-7092-d956-44d2-e55233f495d2@arm.com>
 <c6e05462-2580-10a6-db8c-c6d5f5617105@epam.com>
In-Reply-To: <c6e05462-2580-10a6-db8c-c6d5f5617105@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB5000;6:kFNpu4qK90VCzsV3ApQtGoa+cMJhtXaWDtdZFyr8YKgfO2hxIKDudzsmj/+YpVIRlbvFtbeQ/N1vLcRi2hWvZtBg2T+hjdg37Zk8Uhm4/MduLC38TrIUplKkR4xYF1I/dFEBy8YlBcSA2gkBJ6r3D8S6V8B/mHnjj/tIfU9LsjeQ17qpPyrgHWpmPn/SO8XLHoi/VLvcXhKsq0Z8oMqnTZ4fDAvRba3MDPAQe1kOOhnUioRnTzuUvnX1j0zFHBY4xXKooJa8Lnbe0D5vrr9i49QxK6CRHhwkFXAVSJDKTaeBolqerIzXPPAUOy3Y4afDwovNKv/B3dWcJ8Wt7sAAddhyTEZGdETxZZMql/oj0jwiO6XpZpWfm1ARePWiFYLTOu5LcLQfo9VMmWErkg8rpfYKYBgqvPU/t+UC6NUxmBo5yI0LuLvmGtMdNLsE5YuIiR/ukKRgYWqsoVWXxtzE/A==;5:Zs5/MQwqHltWI+v8uYN6HtDNLMqtQlivbTLtb5vefnDAe0FeXnnbrbk9NAsTyAKs6ln+yBOGHLT/R4U0XNRIC0VkbpkXjo0IqXHUpbW3ob03PAmNXqjqv+siD2khEoHgQKi49YCyVjaCUvCMf2AeWGvxleQHJ/3cD2onEzJiG1DX7x1elcBvrt6Ui4bCyM55NOwPCLy1WBGdxqOgzjzI/g==;7:tvyWEqZWC4cp1EgMWObhtLJF+TQYnlzRp07Y9XR86w3WY8fnB7NfBqXJrK4+IKtLXQ9gAFI61tlEqCFpZRWBtgPgMoD6M25qlFeJQqlNQueFMKBIEnHcuIzANKwazIOduFghVz7TCpksym78LcMM7w==
x-ms-office365-filtering-correlation-id: dad4d51f-2ade-498d-5768-08d688232cda
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB5000;
x-ms-traffictypediagnostic: AM6PR03MB5000:
x-microsoft-antispam-prvs: <AM6PR03MB5000F135337A5892B275FE52E7920@AM6PR03MB5000.eurprd03.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(71200400001)(71190400001)(72206003)(11346002)(97736004)(446003)(476003)(105586002)(81156014)(81166006)(14454004)(2616005)(8676002)(14444005)(256004)(229853002)(7736002)(106356001)(8936002)(305945005)(486006)(39060400002)(53936002)(6116002)(6506007)(3846002)(53546011)(68736007)(31686004)(7416002)(55236004)(110136005)(25786009)(36756003)(6512007)(316002)(2201001)(2906002)(186003)(26005)(99286004)(6486002)(86362001)(31696002)(6246003)(478600001)(66066001)(80792005)(102836004)(2501003)(76176011)(6436002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB5000;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J9atEptx3XEvMvZE3jCuf9iUwR8OKKz+Yk9XC0gOyLvci4OWUzAQ3TrHIMceFvkBw8u5AJtB4XasxMDIDNDe7v/ZHzjDN62FV5QokImDvvd6HWV+4FlMfJLlZOkSSLF2YvNT9zXIC3ntOA+FnElW4nlOTUbNSQB8NTHgdiK0SboTO+4zD1lQV7b/L7jH0R2aLYy8/fZp6FTLEsQjjV1SeI++fDDYroQnmtjXIFDpeTFIwTn10LQ12M3OhMpuawKJHGv4UE8UeqxvM0xjZAo1X/oWP4Agm6j5rbPvkqSU08FW5MH0Nm5wHFDj4DOv3xWjN0oPQjs3oCiagAWgLleacpK3eZvt/H/J0oYC+z+SgoTF9wsQpX2rVb6D8Fs0vgZdijd0BUjRICSjR5TD8dXk/at2j/wk202klW/GO2zI0io=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27A51023CD0ACE41B31516D216FBD0EE@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad4d51f-2ade-498d-5768-08d688232cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 08:56:37.6618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8zMC8xOSAxMTowOSBBTSwgT2xla3NhbmRyIEFuZHJ1c2hjaGVua28gd3JvdGU6DQo+IE9u
IDEvMjkvMTkgOTowNyBQTSwgSnVsaWVuIEdyYWxsIHdyb3RlOg0KPj4gSGkgT2xla3NhbmRyLA0K
Pj4NCj4+IE9uIDEvMjkvMTkgMzowNCBQTSwgT2xla3NhbmRyIEFuZHJ1c2hjaGVua28gd3JvdGU6
DQo+Pj4gRnJvbTogT2xla3NhbmRyIEFuZHJ1c2hjaGVua28gPG9sZWtzYW5kcl9hbmRydXNoY2hl
bmtvQGVwYW0uY29tPg0KPj4+DQo+Pj4gV2hlbiBHRU0gYmFja2luZyBzdG9yYWdlIGlzIGFsbG9j
YXRlZCB0aG9zZSBhcmUgbm9ybWFsIHBhZ2VzLA0KPj4+IHNvIHRoZXJlIGlzIG5vIHBvaW50IHVz
aW5nIHBncHJvdF93cml0ZWNvbWJpbmUgd2hpbGUgbW1hcGluZy4NCj4+PiBUaGlzIGZpeGVzIG1p
c21hdGNoIG9mIGJ1ZmZlciBwYWdlcycgbWVtb3J5IGF0dHJpYnV0ZXMgYmV0d2Vlbg0KPj4+IHRo
ZSBmcm9udGVuZCBhbmQgYmFja2VuZCB3aGljaCBtYXkgY2F1c2Ugc2NyZWVuIGFydGlmYWN0cy4N
Cj4+Pg0KPj4+IEZpeGVzOiBjNTc1YjdlZWI4OWYgKCJkcm0veGVuLWZyb250OiBBZGQgc3VwcG9y
dCBmb3IgWGVuIFBWIGRpc3BsYXkgDQo+Pj4gZnJvbnRlbmQiKQ0KPj4+DQo+Pj4gU2lnbmVkLW9m
Zi1ieTogT2xla3NhbmRyIEFuZHJ1c2hjaGVua28gDQo+Pj4gPG9sZWtzYW5kcl9hbmRydXNoY2hl
bmtvQGVwYW0uY29tPg0KPj4+IFN1Z2dlc3RlZC1ieTogSnVsaWVuIEdyYWxsIDxqdWxpZW4uZ3Jh
bGxAYXJtLmNvbT4NCj4+PiAtLS0NCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0veGVuL3hlbl9kcm1f
ZnJvbnRfZ2VtLmMgfCA1ICsrLS0tDQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0veGVuL3hlbl9kcm1fZnJvbnRfZ2VtLmMgDQo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0veGVuL3hl
bl9kcm1fZnJvbnRfZ2VtLmMNCj4+PiBpbmRleCBkMzAzYTJlMTdmNWUuLjlkNWMwM2Q3NjY4ZCAx
MDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0veGVuL3hlbl9kcm1fZnJvbnRfZ2VtLmMN
Cj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0veGVuL3hlbl9kcm1fZnJvbnRfZ2VtLmMNCj4+PiBA
QCAtMjM1LDggKzIzNSw3IEBAIHN0YXRpYyBpbnQgZ2VtX21tYXBfb2JqKHN0cnVjdCB4ZW5fZ2Vt
X29iamVjdCANCj4+PiAqeGVuX29iaiwNCj4+PiDCoMKgwqDCoMKgIHZtYS0+dm1fZmxhZ3MgJj0g
flZNX1BGTk1BUDsNCj4+PiDCoMKgwqDCoMKgIHZtYS0+dm1fZmxhZ3MgfD0gVk1fTUlYRURNQVA7
DQo+Pj4gwqDCoMKgwqDCoCB2bWEtPnZtX3Bnb2ZmID0gMDsNCj4+PiAtwqDCoMKgIHZtYS0+dm1f
cGFnZV9wcm90ID0NCj4+PiAtIHBncHJvdF93cml0ZWNvbWJpbmUodm1fZ2V0X3BhZ2VfcHJvdCh2
bWEtPnZtX2ZsYWdzKSk7DQo+Pj4gK8KgwqDCoCB2bWEtPnZtX3BhZ2VfcHJvdCA9IHZtX2dldF9w
YWdlX3Byb3Qodm1hLT52bV9mbGFncyk7DQo+Pg0KPj4gVGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8g
bWUuIEl0IHdvdWxkIGJlIHdvcnRoIGV4cGFuZGluZyB0aGUgY29tbWVudCBhIA0KPj4gYml0IGJl
Zm9yZSB0byBleHBsYWluIHRoYXQgd2Ugb3ZlcndyaXRlIHZtX3BhZ2VfcHJvdCB0byB1c2UgY2Fj
aGVhYmxlIA0KPj4gYXR0cmlidXRlIGFzIHJlcXVpcmVkIGJ5IHRoZSBYZW4gQUJJLg0KPj4NCj4g
T2ssIHRoZW4gSSdsbCBwdXQ6DQo+DQo+ICvCoMKgwqDCoMKgwqAgLyoNCj4gK8KgwqDCoMKgwqDC
oMKgICogQWNjb3JkaW5nIHRvIFhlbiBvbiBBUk0gQUJJICh4ZW4vaW5jbHVkZS9wdWJsaWMvYXJj
aC1hcm0uaCk6DQo+ICvCoMKgwqDCoMKgwqDCoCAqIGFsbCBtZW1vcnkgd2hpY2ggaXMgc2hhcmVk
IHdpdGggb3RoZXIgZW50aXRpZXMgaW4gdGhlIHN5c3RlbQ0KPiArwqDCoMKgwqDCoMKgwqAgKiAo
aW5jbHVkaW5nIHRoZSBoeXBlcnZpc29yIGFuZCBvdGhlciBndWVzdHMpIG11c3QgcmVzaWRlIGlu
IA0KPiBtZW1vcnkNCj4gK8KgwqDCoMKgwqDCoMKgICogd2hpY2ggaXMgbWFwcGVkIGFzIE5vcm1h
bCBJbm5lciBXcml0ZS1CYWNrIE91dGVyIFdyaXRlLUJhY2sNCj4gK8KgwqDCoMKgwqDCoMKgICog
SW5uZXItU2hhcmVhYmxlLg0KPiArwqDCoMKgwqDCoMKgwqAgKi8NCj4gwqDCoMKgwqDCoMKgwqAg
dm1hLT52bV9wYWdlX3Byb3QgPSB2bV9nZXRfcGFnZV9wcm90KHZtYS0+dm1fZmxhZ3MpOw0KPiBQ
bGVhc2UgbGV0IG1lIGtub3cgaWYgdGhpcyBpcyBub3Qgd2hhdCB5b3Ugd2FudA0KPj4gV2l0aCB0
aGUgY29tbWVudCB1cGRhdGVkOg0KPj4NCj4+IEFja2VkLWJ5OiBKdWxpZW4gR3JhbGwgPGp1bGll
bi5ncmFsbEBhcm0uY29tPg0KPj4NCklmIG5vYm9keSBvYmplY3RzIEknbGwgYXBwbHkgdGhpcyB0
byBkcm0tbWlzYy1maXhlcyBuZXh0IE1vbmRheQ0KPj4gQ2hlZXJzLA0KPj4NCj4gVGhhbmsgeW91
LA0KPiBPbGVrc2FuZHINCg==

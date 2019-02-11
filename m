Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0367C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EB1222B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=oneplus.com header.i=@oneplus.com header.b="K37Akkwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfBKN7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:59:42 -0500
Received: from mail-eopbgr1290101.outbound.protection.outlook.com ([40.107.129.101]:24287
        "EHLO KOR01-SL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728256AbfBKN73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oneplus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plqnq+mHjOEE737ALXRa4tmLV3eyhKjFtL2auSVXIPk=;
 b=K37Akkwh8COFc7+GIlHcBEP/fg/qQu8WHVF4qEalRqTWxoYGYoTsG1GPqyaJuoZQVL/bXA9p5ag+h4JjcrEBckUo0rcudprcAUbetnea0KHSZP1u8lQbf8R9SRKJ1FQX8au/8+nwODqsI54ss4iwjr4aBqBWDKnIbmyIEqQ7WJ4=
Received: from SL2PR04MB3436.apcprd04.prod.outlook.com (20.177.176.85) by
 SL2PR04MB3049.apcprd04.prod.outlook.com (20.177.176.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Mon, 11 Feb 2019 13:59:25 +0000
Received: from SL2PR04MB3436.apcprd04.prod.outlook.com
 ([fe80::3437:6e26:53e1:ce17]) by SL2PR04MB3436.apcprd04.prod.outlook.com
 ([fe80::3437:6e26:53e1:ce17%3]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 13:59:25 +0000
From:   Linux Upstream <linux.upstream@oneplus.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Chintan Pandya <chintan.pandya@oneplus.com>
CC:     "hughd@google.com" <hughd@google.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "mawilcox@microsoft.com" <mawilcox@microsoft.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC 1/2] page-flags: Make page lock operation atomic
Thread-Topic: [RFC 1/2] page-flags: Make page lock operation atomic
Thread-Index: AQHUwgjYvQYyD7epEke+PT1qeXbKpaXanDWAgAADsoA=
Date:   Mon, 11 Feb 2019 13:59:24 +0000
Message-ID: <364c7595-14f5-7160-d076-35a14c90375a@oneplus.com>
References: <20190211125337.16099-1-chintan.pandya@oneplus.com>
 <20190211125337.16099-2-chintan.pandya@oneplus.com>
 <20190211134607.GA32511@hirez.programming.kicks-ass.net>
In-Reply-To: <20190211134607.GA32511@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR06CA0165.apcprd06.prod.outlook.com
 (2603:1096:1:1e::19) To SL2PR04MB3436.apcprd04.prod.outlook.com
 (2603:1096:100:39::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=linux.upstream@oneplus.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.173.238]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SL2PR04MB3049;6:1qN0WnjHrEkriMVMKZD5rWG5LpGmr5pM2VXoOMZZrCoiLP4RdM+fU9L/YYJjTdhwH9EUzbrf+6V+5TMoROi2HWwRCIPr2CqeDcVVAElKNZorceuuiJDyyx4yQQthkvljo/SPRtsCXbmMQZR3HZVv7wXMJvB4wx8/pQytGKnXFbG0i+m7ZpsgBNToo0DEMyNekr3ox21FVNEaJwgH2Pvx3EiShsVY9NG7rR/sjlKPBgXAc8uSkMALVE4QLBbIQlRTT4txoA0K1rwh3OI/zoGht698bA8mRpG4SLeLWKnCId4nBFlHqjW+iJOqbiY30OmbbhtAfy5nTDHexWz+MwOIfWJp8znqaHxUrHtSZmR0WaG5O/QBYMKl0gvkK4S69u5A1LJR0Z0pUXcI2jmT6rk1M6n27130FA7taYQJp+ZI4qx/C2hu5pZ85FeNt6rzgOJl1C155D5Lb8IyxOIowz0lMA==;5:Z6IquvK0efxoUnjTEHNMmG2K4yGtgFDMhHQEg4EImKiCPWwTvgq3oLLIbobBzyKtJNkaNLJbzv9DdN3omQn23ZjZE2CE0SY1ztAA2fwib7gK7mn4qF23ExXngUW12KMrnDTU5Y+/0s0toC0ZcaVoDzkZkgo6m8VBhgc7cvUtQ2T90rLiZ8Y/+cObuQjKh0NeNi/9JTuvkgMP4Ca3Njt44Q==;7:YIna7rbQPYMOxnWQDiN85qEUOx5mLub0BCAEdJ+ID2wfuFjXZvszQglGhGpMIgeeYAAlgxZgw6a7Db6Cz/zZ5hPj7blDQIcLiUjYHCNmGFg2xFjKcqGkY+PL6Kr73/tAaHXMsGlc/Ruw3A5ir2V0Cg==
x-ms-office365-filtering-correlation-id: bc23af1e-e403-4f98-9baa-08d69029215d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:SL2PR04MB3049;
x-ms-traffictypediagnostic: SL2PR04MB3049:
x-ld-processed: 0423909d-296c-463e-ab5c-e5853a518df8,ExtAddr
x-microsoft-antispam-prvs: <SL2PR04MB30496C8790011B071C2CFDD59A640@SL2PR04MB3049.apcprd04.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39860400002)(396003)(199004)(189003)(316002)(476003)(6636002)(486006)(110136005)(2616005)(54906003)(6246003)(25786009)(478600001)(66066001)(81166006)(81156014)(11346002)(446003)(6512007)(55236004)(44832011)(53546011)(6506007)(386003)(229853002)(6436002)(102836004)(31686004)(6486002)(68736007)(36756003)(2906002)(14454004)(106356001)(186003)(26005)(105586002)(3846002)(256004)(6116002)(99286004)(86362001)(78486014)(14444005)(8676002)(8936002)(53936002)(31696002)(305945005)(71190400001)(4326008)(52116002)(71200400001)(76176011)(97736004)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:SL2PR04MB3049;H:SL2PR04MB3436.apcprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: oneplus.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Fdoer0tFCz8sFUix+SCLGwpIuMl7QTFasOK6kYCzrGMWfP3u2iw29zqM+zc1Vc2z/Q6HAF1fM5aW6bviXab13uvzXaZj16YFOrVuoURUEJFScjzTteic99b4kOtPb0IF3OIw8HAaHceci5r4SffxbMxiDk6mhAuBGUn1vsJCb2OI6B5Ng7KWGRmrxWRaSAp1I7po57CH7VuvdU74ZcuIytuiu1y6EVISHkpjrh8NDasi9Nla/3XKUK97mRkL6okkox5AazDiknBjNPWXsv14fZ+SnD2C9UwtTovcL4EElYw70zr9BH5S3/Q8z65J1iPQtxnU2AgwBxnZv0c/WSv0wQ+zC1ZEfume+Kk+7hAcCCOv6tFlnwrQRfEbgkeUiRKfyWOX+C7DBorB6Qa+ormOYdejoP/Dy7plNg13Rxh4T7M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62786EC907B80248AA58520F45FA8FE1@apcprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oneplus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc23af1e-e403-4f98-9baa-08d69029215d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 13:59:23.4656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 0423909d-296c-463e-ab5c-e5853a518df8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR04MB3049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzAyLzE5IDc6MTYgUE0sIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPiBPbiBNb24s
IEZlYiAxMSwgMjAxOSBhdCAxMjo1Mzo1M1BNICswMDAwLCBDaGludGFuIFBhbmR5YSB3cm90ZToN
Cj4+IEN1cnJlbnRseSwgcGFnZSBsb2NrIG9wZXJhdGlvbiBpcyBub24tYXRvbWljLiBUaGlzIGlz
IG9wZW5pbmcNCj4+IHNvbWUgc2NvcGUgZm9yIHJhY2UgY29uZGl0aW9uLiBGb3IgZXgsIGlmIDIg
dGhyZWFkcyBhcmUgYWNjZXNzaW5nDQo+PiBzYW1lIHBhZ2UgZmxhZ3MsIGl0IG1heSBoYXBwZW4g
dGhhdCBvdXIgZGVzaXJlZCB0aHJlYWQncyBwYWdlDQo+PiBsb2NrIGJpdCAoUEdfbG9ja2VkKSBt
aWdodCBnZXQgb3ZlcndyaXR0ZW4gYnkgb3RoZXIgdGhyZWFkDQo+PiBsZWF2aW5nIHBhZ2UgdW5s
b2NrZWQuIFRoaXMgY2FuIGNhdXNlIGlzc3VlcyBsYXRlciB3aGVuIHNvbWUNCj4+IGNvZGUgZXhw
ZWN0cyBwYWdlIHRvIGJlIGxvY2tlZCBidXQgaXQgaXMgbm90Lg0KPj4NCj4+IE1ha2UgcGFnZSBs
b2NrL3VubG9jayBvcGVyYXRpb24gdXNlIHRoZSBhdG9taWMgdmVyc2lvbiBvZg0KPj4gc2V0X2Jp
dCBBUEkuIFRoZXJlIGFyZSBvdGhlciBmbGFnIHNldCBvcGVyYXRpb25zIHdoaWNoIHN0aWxsDQo+
PiB1c2VzIG5vbi1hdG9taWMgdmVyc2lvbiBvZiBzZXRfYml0IEFQSS4gQml0LCB0aGF0IG1pZ2h0
IGJlDQo+PiB0aGUgY2hhbmdlIGZvciB0aGUgZnV0dXJlLg0KPj4NCj4+IENoYW5nZS1JZDogSTEz
YmRiZWRjMmIxOThhZjAxNGQ4ODVlMTkyNWM5M2I4M2VkNjY2MGUNCj4gDQo+IFRoYXQgZG9lc24n
dCBiZWxvbmcgaW4gcGF0Y2hlcy4NCg0KU3VyZS4gVGhhdCdzIGEgbWlzcy4gV2lsbCBmaXggdGhp
cy4NCg0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IENoaW50YW4gUGFuZHlhIDxjaGludGFuLnBhbmR5
YUBvbmVwbHVzLmNvbT4NCj4gDQo+IE5BSy4NCj4gDQo+IFRoaXMgaXMgYm91bmQgdG8gcmVncmVz
cyBzb21lIHN0dWZmLiBOb3cgYWdyZWVkIHRoYXQgdXNpbmcgbm9uLWF0b21pYw0KPiBvcHMgaXMg
dHJpY2t5LCBidXQgbWFueSBhcmUgaW4gcGxhY2VzIHdoZXJlIHdlICdrbm93JyB0aGVyZSBjYW4n
dCBiZQ0KPiBjb25jdXJyZW5jeS4NCj4gDQo+IElmIHlvdSBjYW4gc2hvdyBhbnkgc2luZ2xlIG9u
ZSBpcyB3cm9uZywgd2UgY2FuIGZpeCB0aGF0IG9uZSwgYnV0IHdlJ3JlDQo+IG5vdCBnb2luZyB0
byBibGFua2V0IHJlbW92ZSBhbGwgdGhpcyBqdXN0IGJlY2F1c2UuDQoNCk5vdCBxdWl0ZSBmYW1p
bGlhciB3aXRoIGJlbG93IHN0YWNrIGJ1dCBmcm9tIGNyYXNoIGR1bXAsIGZvdW5kIHRoYXQgdGhp
cw0Kd2FzIGFub3RoZXIgc3RhY2sgcnVubmluZyBvbiBzb21lIG90aGVyIENQVSBhdCB0aGUgc2Ft
ZSB0aW1lIHdoaWNoIGFsc28NCnVwZGF0ZXMgcGFnZSBjYWNoZSBscnUgYW5kIG1hbmlwdWxhdGUg
bG9ja3MuDQoNCls4NDQxNS4zNDQ1NzddIFsyMDE5MDEyM18yMToyNzo1MC43ODYyNjRdQDEgcHJl
ZW1wdF9jb3VudF9hZGQrMHhkYy8weDE4NA0KWzg0NDE1LjM0NDU4OF0gWzIwMTkwMTIzXzIxOjI3
OjUwLjc4NjI3Nl1AMSB3b3JraW5nc2V0X3JlZmF1bHQrMHhkYy8weDI2OA0KWzg0NDE1LjM0NDYw
MF0gWzIwMTkwMTIzXzIxOjI3OjUwLjc4NjI4OF1AMSBhZGRfdG9fcGFnZV9jYWNoZV9scnUrMHg4
NC8weDExYw0KWzg0NDE1LjM0NDYxMl0gWzIwMTkwMTIzXzIxOjI3OjUwLjc4NjMwMV1AMSBleHQ0
X21wYWdlX3JlYWRwYWdlcysweDE3OC8weDcxNA0KWzg0NDE1LjM0NDYyNV0gWzIwMTkwMTIzXzIx
OjI3OjUwLjc4NjMxM11AMSBleHQ0X3JlYWRwYWdlcysweDUwLzB4NjANCls4NDQxNS4zNDQ2MzZd
IFsyMDE5MDEyM18yMToyNzo1MC43ODYzMjRdQDEgDQpfX2RvX3BhZ2VfY2FjaGVfcmVhZGFoZWFk
KzB4MTZjLzB4MjgwDQpbODQ0MTUuMzQ0NjQ2XSBbMjAxOTAxMjNfMjE6Mjc6NTAuNzg2MzM0XUAx
IGZpbGVtYXBfZmF1bHQrMHg0MWMvMHg1ODgNCls4NDQxNS4zNDQ2NTVdIFsyMDE5MDEyM18yMToy
Nzo1MC43ODYzNDNdQDEgZXh0NF9maWxlbWFwX2ZhdWx0KzB4MzQvMHg1MA0KWzg0NDE1LjM0NDY2
NF0gWzIwMTkwMTIzXzIxOjI3OjUwLjc4NjM1M11AMSBfX2RvX2ZhdWx0KzB4MjgvMHg4OA0KDQpO
b3QgZW50aXJlbHkgc3VyZSBpZiBpdCdzIHJhY2luZyB3aXRoIHRoZSBjcmFzaGluZyBzdGFjayBv
ciBpdCdzIHNpbXBseQ0Kb3ZlcnJpZGVzIHRoZSB0aGUgYml0IHNldCBieSBjYXNlIDIgKG1lbnRp
b25lZCBpbiAwLzIpLg0KPiANCg==

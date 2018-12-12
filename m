Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63180C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8502084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5WoB2I40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8502084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbeLLOQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:16:05 -0500
Received: from mail-eopbgr790044.outbound.protection.outlook.com ([40.107.79.44]:41088
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbeLLOQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dQ6SbA85HiNOoN/8697lvK0imi6CuksGomu6By76k4=;
 b=5WoB2I40jD49vyLx+j/BC27B63HDQdaMR2BZdLcOEDXA0d/MnCG07I/dGXjoZQKDA1f/SRgc7roZN5XcizvcRg9uGfLMbPfYblZYpq+DI/C/YFB7DxN36M9HwbuVztVyhJK/ZCkKOtqDy2fXowFV37udC+SVEA0RS4Yjs/skN9A=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0301.namprd12.prod.outlook.com (10.162.4.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.24; Wed, 12 Dec 2018 14:15:58 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 14:15:58 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Thread-Topic: [RFC PATCH 4/4] x86/TSC: Use RDTSCP
Thread-Index: AQHUkaAqfD7bV8pvnUyLofBVRH7Ye6V6JxMA//+fHICAAGvzgIAALk0AgADGtQA=
Date:   Wed, 12 Dec 2018 14:15:58 +0000
Message-ID: <4ddd7ecf-6f90-a25b-e8b7-1459cc312dba@amd.com>
References: <20181211222326.14581-1-bp@alien8.de>
 <20181211222326.14581-5-bp@alien8.de>
 <CALCETrVArfAAbQKJ-g_5pOy6dMVgx-FC_mjdC9xzL1jU9T07jw@mail.gmail.com>
 <59aad362-4a5b-dd8b-642f-0dc3f83cf7ee@amd.com>
 <20181211233901.GV27375@zn.tnic>
 <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com>
In-Reply-To: <CALCETrXvZ4avdUh2bTLVTTz3Jxogo3zK5akWTsJ=rkJpf1XiDg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:805:ca::15) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0301;20:G5dySRGQ3JXDmEhoMBwK6CM8JesEiUhc1wzDOFrU6W9dePdyX1QHX9iQVpBD66T7prupom8Bmh9wFc6iu5vD2ELPe03WmYYy3QIGWHUEtqdfjKrGSQCikeaIGo6HGgF/mGaTcUW+x26YEM14PXLk0f9ghY5IY6/9WnIqT+Ob5VTQPtljbXoE3KX1q/xzdDgtlOk0SfDRUq9rJS/TrWElJ8TTO9Y7XP6Jtr0Or5ldqaLur7ZmDB58m+2GC/awXJNv
x-ms-office365-filtering-correlation-id: 4029544e-48bb-42cd-f165-08d6603c561c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0301;
x-ms-traffictypediagnostic: SN1PR12MB0301:
x-microsoft-antispam-prvs: <SN1PR12MB03018DC5E33DCADE9FC465E3ECA70@SN1PR12MB0301.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0301;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0301;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(189003)(199004)(66066001)(14454004)(3846002)(25786009)(6246003)(53936002)(105586002)(6436002)(6486002)(229853002)(5660300001)(186003)(53546011)(316002)(6306002)(26005)(6116002)(31686004)(110136005)(54906003)(6506007)(106356001)(305945005)(102836004)(2616005)(386003)(8936002)(36756003)(8676002)(81156014)(81166006)(966005)(76176011)(99286004)(72206003)(478600001)(52116002)(256004)(7736002)(4326008)(6512007)(2906002)(97736004)(71200400001)(93886005)(68736007)(71190400001)(486006)(11346002)(446003)(86362001)(31696002)(217873002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0301;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: emjFy3iiMbkGVBqIFVlLpeK72NZq6yZkwlwS9AnIzCUvbHZnLdyf/o7r4EEGgdG0nI8hkbpqWpQkERPnrOWGkfCxcY5BQjmbTl6kt3a7Q98KFpXJYj6qlqybMwO9hIcQ+jeIMERCVgw8mNVzLMPvA835e/+5rzHGcdTwgneLAdRR6KaHISvy0Gac9E8g6nonMA1iJoesEityt0hdawlJFm3vWPlOwBnN6PYfBNTRGQhMpMTTzcPSBzQgtgMgpigDsj4Z8GO4KZ1dZQWafz6I8AiLfvfP8P28IjTdkfa+goDjIDxBKPI/OXdOMHu/C9nm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A693655BFA588D4095E16A43DD92C18C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4029544e-48bb-42cd-f165-08d6603c561c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 14:15:58.2918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTEvMjAxOCAwODoyNCBQTSwgQW5keSBMdXRvbWlyc2tpIHdyb3RlOg0KPj4gT24gRGVj
IDExLCAyMDE4LCBhdCAzOjM5IFBNLCBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4gd3Jv
dGU6DQo+Pg0KPj4+IE9uIFR1ZSwgRGVjIDExLCAyMDE4IGF0IDExOjEyOjQxUE0gKzAwMDAsIExl
bmRhY2t5LCBUaG9tYXMgd3JvdGU6DQo+Pj4gSXQgZG9lcyBzZWVtIG92ZXJsb2FkZWQgaW4gdGhh
dCBzZW5zZSwgYnV0IHRoZSBmZWF0dXJlIG1lYW5zIHRoYXQgTEZFTkNFDQo+Pj4gaXMgc2VyaWFs
aXppbmcgYW5kIHNvIGNhbiBiZSB1c2VkIGluIHJkdHNjX29yZGVyZWQuIEluIHRoZSBzYW1lIHNl
bnNlLA0KPj4+IGJhcnJpZXJfbm9zcGVjIGlzIGxvb2tpbmcgZm9yIHdoZXRoZXIgTEZFTkNFIGlz
IHNlcmlhbGl6aW5nIGFuZCBwcmVmZXJyaW5nDQo+Pj4gdGhhdCBvdmVyIE1GRU5DRSBzaW5jZSBp
dCBpcyBsaWdodGVyIHdlaWdodC4NCj4+Pg0KPj4+IEluIGxpZ2h0IG9mIGhvdyB0aGV5J3JlIGJl
aW5nIHVzZWQgbm93LCB0aGV5IGNvdWxkIHByb2JhYmx5IHN0YW5kIHRvIGJlDQo+Pj4gcmVuYW1l
ZCBpbiBzb21lIHdheS4NCj4+DQo+PiBBY3R1YWxseSwgY29tZSB0byB0aGluayBvZiBpdCwgd2hh
dCByZWFsbHkgbWF0dGVycyBoZXJlIGlzIHdoZXRoZXINCj4+IExGRU5DRSBpcyBzZXJpYWxpemlu
ZyBvciBub3QuIEJlY2F1c2UgaWYgc28sIHlvdSB3YW5uYSByZXBsYWNlIHdpdGggTEZFTkNFDQo+
PiBhcyBpdCBpcyBsaWdodGVyLiBBbmQgaW4gdGhhdCBjYXNlIGEgc2luZ2xlIGFsdGVybmF0aXZl
KCkgLSBub3QgXzIoKSAtDQo+PiBzaG91bGQgc3VmZmljZS4NCj4+DQo+PiBCVVQoISksIHRoYXQg
c3RpbGwgaXMgbm90IGdvb2QgZW5vdWdoIGlmIHlvdSBkbyBzb21lIHFlbXUgQ1BVIG1vZGVscw0K
Pj4gbGlrZSBwZW50aXVtIG9yIHNvIHdoaWNoIGRvbid0IGV2ZW4gaGF2ZSBNRkVOQ0UgYW5kIGNh
dXNlIHN0dWZmIGxpa2UNCj4+IHRoaXM6DQo+Pg0KPj4gaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcv
ci8yMDE4MTEyMzIwMDMwNy5HQTYyMjNAcm9lY2stdXMubmV0DQo+Pg0KPj4gV2hpY2ggbWVhbnMs
IHRoYXQgeW91ICpkbyogaGF2ZSB0byBhbHRlcm5hdGUgYmV0d2Vlbg0KPj4NCj4+ICogbm8gaW5z
biBhdCBhbGwNCj4+ICogTUZFTkNFDQo+PiAqIExGRU5DRSwgaWYgaXQgaXMgc2VyaWFsaXppbmcN
Cj4+DQo+PiBzbyBiYXJyaWVyX25vc3BlYygpIGRvZXMgdGhlIHJpZ2h0IHRoaW5nLCBBRkFJQ1Mu
IEFuZCB0aGlzIGlzIHdoeSB3ZQ0KPj4gbmVlZCBhbiBBTFRFUk5BVElWRV8zKCkgdG8gYWRkIFJE
VFNDUCBpbnRvIHRoZSBtaXggdG9vLg0KPj4NCj4+IFdSVCByZW5hbWluZywgSSBndWVzcyB3ZSBj
YW4gZG8gc29tZXRoaW5nIGxpa2U6DQo+Pg0KPj4gKiBYODZfRkVBVFVSRV9NRkVOQ0VfUkRUU0Mg
LT4gWDg2X0ZFQVRVUkVfTUZFTkNFIC0gdG8gbWVhbiB0aGF0IENQVSBoYXMNCj4+IE1GRU5DRSBz
dXBwb3J0Lg0KPj4NCj4+IGFuZA0KPj4NCj4+ICogWDg2X0ZFQVRVUkVfTEZFTkNFX1JEVFNDIC0+
IFg4Nl9GRUFUVVJFX0xGRU5DRV9TRVJJQUxJWklORw0KPj4NCj4+IE9yIHNvbWV0aGluZyB0byB0
aGF0IGVmZmVjdC4NCj4gDQo+IFRoaXMgbWFrZXMgbWUgbmVydm91cywgc2luY2Ugbm8gb25lIGtu
b3dzIHdoYXQg4oCcc2VyaWFsaXppbmfigJ0gbWVhbnMuDQo+IElJUkMgQU1EIHNwZWNpZmljYWxs
eSBkb2N1bWVudHMgdGhhdCBNRkVOQ0UgaXMgcmVxdWlyZWQgYmVmb3JlIFJEVFNDDQo+IHRvIGdl
dCBzZW5zaWJsZSBvcmRlcmluZy4gIFNvIGl04oCZcyBlbnRpcmVseSBwbGF1c2libGUgdG8gbWUg
dGhhdA0KPiBMRkVOQ0UgaXMgb2theSBmb3IgU3BlY3RyZSBtaXRpZ2F0aW9uIGJ1dCBNRkVOQ0Ug
aXMgbmVlZGVkIGZvciBSRFRTQw0KPiBvbiBzb21lIENQVS4NCg0KQXMgbG9uZyBhcyBNU1IgMHhj
MDAxMTAyOVsxXSBpcyBzZXQgKE1TUl9GMTBIX0RFQ0ZHX0xGRU5DRV9TRVJJQUxJWkVfQklUKSwN
CnRoZW4gTEZFTkNFIGlzIGEgcHJvcGVyLCBsaWdodGVyIHdlaWdodCBzb2x1dGlvbiBmb3Igb3Jk
ZXJpbmcgUkRUU0MuIFNvDQp3ZSdyZSBnb29kIHRoZXJlLg0KDQpUaGFua3MsDQpUb20NCg0KPiAN
Cg==

Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65DBC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA9C20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D5wi52AE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA9C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeLLOEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:04:07 -0500
Received: from mail-eopbgr800083.outbound.protection.outlook.com ([40.107.80.83]:39280
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbeLLOEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAgLHqRi5vhWQMVcknnGIFV5yzsegTEN+Ar9MHyH82c=;
 b=D5wi52AEPbXlviTQ+FAcAibZwt1UvllYxkeg1E21X2rzR5OhKZ+8Cd5/Q6PnpSABdkppOSK9YtpNGGEJRhIMz+KzbgbcQBMZe/BT7yOLsfkrjL5FMAhlui0QukY+tP008bzM4mU/RK0zcEiwcrl0absbp8LTAqwrB7GlW0ySiRE=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0189.namprd12.prod.outlook.com (10.162.3.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Wed, 12 Dec 2018 14:03:57 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 14:03:57 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2] x86/speculation: Add support for STIBP always-on
 preferred mode
Thread-Topic: [PATCH v2] x86/speculation: Add support for STIBP always-on
 preferred mode
Thread-Index: AQHUkaNTNctPywnCTEqVxIZjhKo+laV6OXQAgAA7RQCAAK8IAA==
Date:   Wed, 12 Dec 2018 14:03:56 +0000
Message-ID: <38aca18b-4312-5e03-fdd9-86e47c332e44@amd.com>
References: <20181211224615.5373.65736.stgit@tlendack-t1.amdoffice.net>
 <20181212000518.GX27375@zn.tnic>
 <alpine.DEB.2.21.1812111910520.22893@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1812111910520.22893@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:805:66::26) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0189;20:HIXwjmVpD6OJjpeIhrTDq0esAcw+FGJCIPcHx3ImdB9p6uXsuX7GJTG0MVUh6lQXaJuR1lJsP3AUOUzl9ugcQRDQEWu4BrRrWq6bXjfOkcG632mXAUEmFdEukOXmfnXg4JGOsz5OwOF8DPNrutIlDEij0BVH96YvojOFdSZVFAD44pwFwDdFd/oHTah0KxO1GPVH5ptZ7VQwJPwL18TYINDVbZZ/iKxefbCm4kkaN6bvOWVD8v5yAxcyF6KSrok/
x-ms-office365-filtering-correlation-id: 5b79965c-7e8e-47b7-4966-08d6603aa82d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0189;
x-ms-traffictypediagnostic: SN1PR12MB0189:
x-microsoft-antispam-prvs: <SN1PR12MB0189448B6B676F7141CE6315ECA70@SN1PR12MB0189.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231472)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0189;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0189;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(136003)(396003)(199004)(189003)(52314003)(71190400001)(99286004)(71200400001)(6306002)(86362001)(66066001)(36756003)(68736007)(3846002)(6116002)(4326008)(53936002)(6512007)(31696002)(6246003)(229853002)(256004)(8936002)(81166006)(8676002)(81156014)(6436002)(486006)(476003)(2616005)(11346002)(446003)(97736004)(14444005)(6486002)(105586002)(106356001)(186003)(31686004)(72206003)(386003)(2906002)(53546011)(6506007)(26005)(102836004)(76176011)(52116002)(5660300001)(54906003)(25786009)(110136005)(966005)(7736002)(305945005)(7416002)(478600001)(316002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0189;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JsU0Lf/PfAWwZzbUBznCu9e1lsD+Ix3XHESlDFV2IKiyZUPN0g6umyX428CUUewMPRioDx4rM1gpagWiudrxBHJkXG4b8p6xla8082h/dXxwsPae76wgMLEsSZHCvmGXFCZyFqmAQpxYNvOX+DhP06eYY/VhUipYdL18obvfVI9OewExhdUNzsKYCZsvQ/7JhBxiXWwQOHWh5oiIN86DEqjzL/at5MPdnoU1pvDj+Ud2+nrxEYNg7kHZSACCjCUHZR0Ynlwz9zLaW6a8mSnis8SDgIhyLxhnunmATw5H3S27Jiso7HIIFmXNSaj+VhAy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <854E731FFC90754682CA6A451684C867@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b79965c-7e8e-47b7-4966-08d6603aa82d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 14:03:57.1278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTEvMjAxOCAwOTozNyBQTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiBPbiBXZWQs
IDEyIERlYyAyMDE4LCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+PiBPbiBUdWUsIERlYyAxMSwg
MjAxOCBhdCAxMDo0NjoxNlBNICswMDAwLCBMZW5kYWNreSwgVGhvbWFzIHdyb3RlOg0KPj4+ICsJ
LyoNCj4+PiArCSAqIEF0IHRoaXMgcG9pbnQsIGFuIFNUSUJQIG1vZGUgb3RoZXIgdGhhbiAib2Zm
IiBoYXMgYmVlbiBzZXQuDQo+Pj4gKwkgKiBJZiBTVElCUCBzdXBwb3J0IGlzIG5vdCBiZWluZyBm
b3JjZWQsIGNoZWNrIGlmIFNUSUJQIGFsd2F5cy1vbg0KPj4+ICsJICogaXMgcHJlZmVycmVkLg0K
Pj4+ICsJICovDQo+Pj4gKwlpZiAobW9kZSAhPSBTUEVDVFJFX1YyX1VTRVJfU1RSSUNUICYmDQo+
Pj4gKwkgICAgYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0FNRF9TVElCUF9BTFdBWVNfT04pKSB7
DQo+Pj4gKwkJc3RpYnBfYWx3YXlzX29uID0gdHJ1ZTsNCj4+PiArCQltb2RlID0gU1BFQ1RSRV9W
Ml9VU0VSX1NUUklDVDsNCj4+PiArCQlwcl9pbmZvKCJtaXRpZ2F0aW9uOiBTVElCUCBhbHdheXMt
b24gaXMgcHJlZmVycmVkXG4iKTsNCj4+PiArCX0NCj4+PiArDQo+Pj4gIAkvKiBJbml0aWFsaXpl
IEluZGlyZWN0IEJyYW5jaCBQcmVkaWN0aW9uIEJhcnJpZXIgKi8NCj4+PiAgCWlmIChib290X2Nw
dV9oYXMoWDg2X0ZFQVRVUkVfSUJQQikpIHsNCj4+PiAgCQlzZXR1cF9mb3JjZV9jcHVfY2FwKFg4
Nl9GRUFUVVJFX1VTRV9JQlBCKTsNCj4+PiBAQCAtMTA4OCw3ICsxMTAyLDggQEAgc3RhdGljIGNo
YXIgKnN0aWJwX3N0YXRlKHZvaWQpDQo+Pj4gIAljYXNlIFNQRUNUUkVfVjJfVVNFUl9OT05FOg0K
Pj4+ICAJCXJldHVybiAiLCBTVElCUDogZGlzYWJsZWQiOw0KPj4+ICAJY2FzZSBTUEVDVFJFX1Yy
X1VTRVJfU1RSSUNUOg0KPj4+IC0JCXJldHVybiAiLCBTVElCUDogZm9yY2VkIjsNCj4+PiArCQly
ZXR1cm4gc3RpYnBfYWx3YXlzX29uID8gIiwgU1RJQlA6IGFsd2F5cy1vbiINCj4+PiArCQkJCSAg
ICAgICA6ICIsIFNUSUJQOiBmb3JjZWQiOw0KPj4NCj4+IEkgc3RpbGwgZG9uJ3QgbGlrZSB0aGF0
IHNlcGFyYXRlIHN0aWJwX2Fsd2F5c19vbiB2YXJpYWJsZSB3aGVuIHdlIGNhbiBkbw0KPj4gYWxs
IHRoZSBxdWVyeWluZyBqdXN0IGJ5IHVzaW5nIG1vZGUgYW5kIFg4Nl9GRUFUVVJFX0FNRF9TVElC
UF9BTFdBWVNfT04uDQo+IA0KPiBIbW1tLiBJJ3ZlIG5vdCBzZWVuIHRoZSBWMSBvZiB0aGlzIChp
dCdzIG5vdCBpbiBteSBpbmJveCkgYnV0IHRoZSB2MS0+djINCj4gY2hhbmdlcyBjb250YWluOg0K
DQpUaGF0J3Mgc3RyYW5nZSwgeW91IHdlcmUgb24gdGhlIGNjOiBsaXN0LiBBbnl3YXksIGhlcmUn
cyBhIGxpbmsgdG8gdGhlDQpmaXJzdCB2ZXJzaW9uOiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAx
OC8xMi8xMS8xMjQ4DQoNCj4gDQo+Pj4gLSBSZW1vdmVkIGV4cGxpY2l0IFNQRUNUUkVfVjJfVVNF
Ul9TVFJJQ1RfUFJFRkVSUkVEIG1vZGUNCj4gDQo+IE5vdyBJIHJlYWxseSBoYXZlIHRvIGFzayB3
aHk/DQo+IA0KPiBOZWl0aGVyIHRoZSBleHRyYSB2YXJpYWJsZSBub3IgdGhlIGNwdSBmZWF0dXJl
IGNoZWNrIGFyZSBwcmV0dHkuIEFuDQo+IGV4cGxpY2l0IG1vZGUgaXMgd2F5IGJldHRlciBpbiB0
ZXJtcyBvZiBjb2RlIGNsYXJpdHkgYW5kIHlvdSBnZXQgdGhlIHByb3Blcg0KPiBwcmludG91dCB2
aWEgc3BlY3RyZV92Ml91c2VyX3N0cmluZ3MuDQo+IA0KPiBIbW0/DQoNClRoYXQgaXMgd2hhdCB0
aGUgZmlyc3QgdmVyc2lvbiBkaWQuIFNlZSBpZiB0aGF0J3MgaW4tbGluZSB3aXRoIHdoYXQNCnlv
dSdyZSB0aGlua2luZy4NCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo+IAl0Z2x4DQo+IA0K

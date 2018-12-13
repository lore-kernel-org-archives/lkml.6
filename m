Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF36EC67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F41020870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="jI90+GCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F41020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbeLMRZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:25:18 -0500
Received: from mail-eopbgr800080.outbound.protection.outlook.com ([40.107.80.80]:9680
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728123AbeLMRZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:25:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy7dk4Ci33dsQMZmfe9GmrGmqU0oas8j4+wBEDAswfk=;
 b=jI90+GCIkOu7x3VV2nxmKAAnM5+PFRYcjIHwWkUpYUkgQMLAm/sEfD9c2wvR0mQTf3SteY1pCkglYTTnH0PJtp6nMGIC0Yg5Nh4tW05CvmksNONTsJLjKVURvECKgrPf3YB08H2jhulAbbmwjFP/dpakdHvHxqTU3OF8Vmqh288=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4504.namprd05.prod.outlook.com (52.135.203.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.9; Thu, 13 Dec 2018 17:25:12 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%4]) with mapi id 15.20.1446.006; Thu, 13 Dec 2018
 17:25:12 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Jessica Yu <jeyu@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH v7 13/14] module: Do not set nx for module memory before
 freeing
Thread-Topic: [PATCH v7 13/14] module: Do not set nx for module memory before
 freeing
Thread-Index: AQHUjHgCm5HQo9wG+kmVhMEM5+sZ86V8wjGAgAA2eYA=
Date:   Thu, 13 Dec 2018 17:25:12 +0000
Message-ID: <634A88B1-B41C-466C-A98A-DB85065A4BA9@vmware.com>
References: <20181205013408.47725-1-namit@vmware.com>
 <20181205013408.47725-14-namit@vmware.com>
 <20181213141013.GA16819@linux-8ccs>
In-Reply-To: <20181213141013.GA16819@linux-8ccs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4504;20:kDlNL5E3bOrL9R8FFlgmQcz+fJt5M6B/O91Da5w7N0mPkbgOzoCi1hv2FfDgI4mer+4EqmZG6tXQe+OiCvi1EYRfpieIEFjXv3sifkvi4+fWwjqM4hfpdLzUU9m0JSSW97gA2Sjr4aEnJmsxk2SstI5A63Q5z/yxYgLJcafrJjA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 597c4f57-c881-4815-c722-08d6611ff09c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4504;
x-ms-traffictypediagnostic: BYAPR05MB4504:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB450426D4199C9064B25FA582D0A00@BYAPR05MB4504.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4504;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4504;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(136003)(396003)(376002)(54534003)(189003)(199004)(14454004)(25786009)(6506007)(966005)(76176011)(36756003)(102836004)(68736007)(5660300001)(99286004)(105586002)(106356001)(478600001)(33656002)(3846002)(4326008)(6116002)(53546011)(66066001)(39060400002)(6486002)(81156014)(81166006)(8676002)(229853002)(6436002)(305945005)(8936002)(7736002)(54906003)(7416002)(316002)(2906002)(6246003)(6916009)(53936002)(6512007)(6306002)(476003)(83716004)(11346002)(446003)(86362001)(186003)(2616005)(71190400001)(71200400001)(486006)(97736004)(26005)(82746002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4504;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0XrPyQsp+MmgJwLJEl4aIuImjgq8TAcpH2JID2OfagC80BXvUGxnwXs/owY9YnPlfiXRnbUFqDPJPI5rhz5GIqCif1chxuV3K36igLGrEK6JfueUF9eU5eHgvWNaBOjfXq0T7kqzRD3ubbGDqYE3NZetkIEK3SVQKLRRw9qQqPRy3kMzth1dXbIHZeb7WgUJKNJdD/n1UgrWxh7o3ROEjxcIT/jftXXQJltN+1ii4L3tMa7+B/b32CyU+DW6BsPf7pfQdBhzRMx4jDN73EivYWFmXZmJvi8vYrWVfdbF5hmgDd9xxoV4UwZcUD09Mrrs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <24DC15464DCDEC438142E80136836914@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597c4f57-c881-4815-c722-08d6611ff09c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 17:25:12.6299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgMTMsIDIwMTgsIGF0IDY6MTAgQU0sIEplc3NpY2EgWXUgPGpleXVAa2VybmVsLm9y
Zz4gd3JvdGU6DQo+IA0KPiArKysgTmFkYXYgQW1pdCBbMDQvMTIvMTggMTc6MzQgLTA4MDBdOg0K
Pj4gV2hlbiBtb2R1bGUgbWVtb3J5IGlzIGFib3V0IHRvIGJlIGZyZWVkLCB0aGVyZSBpcyBubyBh
cHBhcmVudCByZWFzb24gdG8NCj4+IG1ha2UgaXQgKGFuZCBpdHMgZGF0YSkgZXhlY3V0YWJsZSwg
YnV0IHRoYXQncyBleGFjdGx5IHdoYXQgaXMgZG9uZQ0KPj4gdG9kYXkuIFRoaXMgaXMgbm90IGVm
ZmljaWVudCBhbmQgbm90IHNlY3VyZS4NCj4+IA0KPj4gVGhlcmUgYXJlIHZhcmlvdXMgdGhlb3Jp
ZXMgd2h5IGl0IHdhcyBkb25lLCBidXQgbm9uZSBvZiB0aGVtIHNlZW0gYXMNCj4+IHNvbWV0aGlu
ZyB0aGF0IHJlYWxseSByZXF1aXJlIGl0IHRvZGF5LiBuaW9zMiB1c2VzIGttYWxsb2MgZm9yIG1v
ZHVsZQ0KPj4gbWVtb3J5LCBidXQgYW55aG93IGl0IGRvZXMgbm90IGNoYW5nZSB0aGUgUFRFcyBv
ZiB0aGUgbW9kdWxlIG1lbW9yeS4gIEluDQo+PiB4ODYsIGNoYW5naW5nIHZtYWxsb2MnZCBtZW1v
cnkgbWFwcGluZ3MgYWxzbyBtb2RpZmllcyB0aGUgZGlyZWN0IG1hcHBpbmcNCj4+IGFsaWFzLCBi
dXQgdGhlIE5YLWJpdCBpcyBub3QgbW9kaWZpZWQgaW4gc3VjaCB3YXkuDQo+PiANCj4+IFNvIGxl
dCdzIHJlbW92ZSBpdC4gQW5keSBzdWdnZXN0ZWQgdGhhdCB0aGUgY2hhbmdlcyBvZiB0aGUgUFRF
cyBjYW4gYmUNCj4+IGF2b2lkZWQgKGV4Y2x1ZGluZyB0aGUgZGlyZWN0LW1hcHBpbmcgYWxpYXMp
LCB3aGljaCBpcyB0cnVlLiBIb3dldmVyLA0KPj4gaW4geDg2IGl0IHJlcXVpcmVzIHNvbWUgY2xl
YW51cCBvZiB0aGUgY29udGlndW91cyBwYWdlIGFsbG9jYXRvciwgd2hpY2gNCj4+IGlzIG91dHNp
ZGUgb2YgdGhlIHNjb3BlIG9mIHRoaXMgcGF0Y2gtc2V0Lg0KPj4gDQo+PiBDYzogUmljayBQIEVk
Z2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+PiBDYzogV2lsbCBEZWFjb24g
PHdpbGwuZGVhY29uQGFybS5jb20+DQo+PiBDYzogQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5l
bC5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0K
PiANCj4gWyBUaGFua3MgQW5kcmVhIFBhcnJpIGZvciB0aGUgY2MgXQ0KPiANCj4gUmVnYXJkaW5n
IHRoZSBwYXRjaCBzdWJqZWN0LCBkb24ndCB5b3UgbWVhbiAiRG8gbm90IG1ha2UgbW9kdWxlDQo+
IG1lbW9yeSBleGVjdXRhYmxlIiBvciAiRG8gbm90IHVuc2V0IG54IiBpbnN0ZWFkIG9mICJEbyBu
b3Qgc2V0IG54Ij8NCj4gSG0sIHRoZXNlIGRvdWJsZSBuZWdhdGl2ZXMgYXJlIGNvbmZ1c2luZyA6
LSkNCg0KSSBndWVzcyBpdCBpcyBqdXN0IHBsYWluIHdyb25nIGluIHRoaXMgY2FzZeKApiA7LSkN
Cg0KPiANCj4gSSB0aGluayB0aGlzIGFsc28gbmVlZHMgdG8gYmUgZG9uZSBpbiB0aGUgbG9hZF9t
b2R1bGUoKSBlcnJvciBwYXRoLg0KPiBTZWUgdGhlIGJ1Z19jbGVhbnVwIGxhYmVsLiBUaGVyZSwg
bW9kdWxlX2Rpc2FibGVfe3JvLG54fSgpIGFyZSBjYWxsZWQNCj4gYmVmb3JlIG1vZHVsZSBkZWFs
bG9jYXRpb24uDQoNClllcywgSSBtaXNzZWQgdGhpcyBvbmUuIEkgdGhpbmsgUmljayBFZGdlY29t
YmUgaGFzIGEgYmV0dGVyIHZlcnNpb24gb2YgdGhpcw0KcGF0Y2ggdGhhdCBhbHNvIHRha2VzIGNh
cmUgb2YgdGhpcyBjYXNlIChzZWUNCmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzEyLzExLzE1
NzMgKS4gSSB0aGluayBoZSB3aWxsIG1lcmdlIHRoZSByZXN0IG9mDQp0aGlzIHNlcmllcyAoYWx0
aG91Z2ggSeKAmW0gc3RpbGwgd2FpdGluZyBmb3IgVGhvbWFzL0luZ28gdG8gdGVsbCBtZSB3aGF0
4oCZcyBpdA0KZ29pbmcgdG8gYmUgd2l0aCB0aGUgZmlyc3QgcGF0Y2hlcykuDQoNCj4gSSBhbSBu
b3Qgc3VyZSB3aHkgYWxsIHRoaXMgd2FzIG1hZGUgZXhlY3V0YWJsZSBiZWZvcmUgZnJlZWluZyBp
biB0aGUNCj4gZmlyc3QgcGxhY2UuICBUcmllZCB0byBkaWcgdGhyb3VnaCB0aGUgY29tbWl0IGhp
c3RvcnkgYW5kIHRoZSBmaXJzdA0KPiBjb21taXQgdGhhdCBpbnRyb2R1Y2VkIHRoaXMgYmVoYXZp
b3Igd2FzIDQ0ODY5NGExZDUwICgibW9kdWxlOiB1bmRvDQo+IG1vZHVsZSBST05YIHByb3RlY3Rp
b24gY29ycmVjdGx5IikuIFRoZXJlLCB0aGUgYmVoYXZpb3Igd2FzIGNoYW5nZWQNCj4gZnJvbSBX
K05YIHRvIFcrWCBiZWZvcmUgcmVsZWFzaW5nIHRoZSBtb2R1bGUuIEJ1dCBBRkFJSyBmcm9tIHRo
ZQ0KPiBjaGFuZ2Vsb2csIHRoZXJlIHdhcyBubyByZWFsIHRlY2huaWNhbCByZWFzb24gYmVoaW5k
IGl0LCBpdCBzdGVtbWVkDQo+IG91dCBvZiB0aGUgY29tcGxhaW50IG9mIGNvZGUgYXN5bW1ldHJ5
IDotLw0KDQpUaGFua3MgZm9yIGxvb2tpbmcgaW50byBpdC4gSSBnYXZlIHVwIGFmdGVyIEkgc2F3
IGl0IHNob3VsZCBoYXZlIG5vDQphcmNoaXRlY3R1cmFsIHJlYXNvbiAob24geDg2KSBhbmQgY291
bGQgbm90IHRoaW5rIGFib3V0IHN1Y2ggb25lIChvbiBhbnkNCmFyY2guLCBjZXJ0YWlubHkgZm9y
IHRoZSBkYXRhKS4gQW55aG93LCB0aGF04oCZcyB3aGF0IGF1dG9tYXRpYyB0ZXN0aW5nIGFyZQ0K
Zm9yLiBJZiB0aGlzIGlzIHdyb25nLCB0aGluZ3Mgc2hvdWxkIGNyYXNoIGFuZCBidXJuIHZlcnkg
ZmFzdC4NCg0KDQo=

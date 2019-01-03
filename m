Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228D1C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E6C20815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 18:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="do6KZsDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbfACSaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 13:30:15 -0500
Received: from mail-eopbgr740045.outbound.protection.outlook.com ([40.107.74.45]:19632
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725871AbfACSaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 13:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bgmYQhfHchPSPmzSSzOUEI/e07Kxw7B4zoFmxkfrCU=;
 b=do6KZsDycrAM00b3prmdL8C+dw6szKBB9eaCIUBRkj4Yxj4VQ+FukgZm3E8e0wjwNLsojhzO1MtuUK0ul5FewCD8qXmaelIc/wbLDQEa7q0/jSkj/dN+/RR3cIZqjNUtmxwX3gDxIIVOTIVylfOzi3N0cQW9vVxafx6ULBgWF90=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4632.namprd05.prod.outlook.com (52.135.233.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.2; Thu, 3 Jan 2019 18:30:08 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1516.000; Thu, 3 Jan 2019
 18:30:08 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC v2 0/6] x86: dynamic indirect branch promotion
Thread-Topic: [RFC v2 0/6] x86: dynamic indirect branch promotion
Thread-Index: AQHUoNlgtfPp2hP9NUWIeKr+GY9EtKWZQqAAgAAAkgCABJp0gIAABVuA
Date:   Thu, 3 Jan 2019 18:30:08 +0000
Message-ID: <7FA580EA-9DEA-4813-8832-F1BE034A857C@vmware.com>
References: <20181231072112.21051-1-namit@vmware.com>
 <CALCETrW_52zEv1kHa7AdhF4PUGvyX4VyHqig1bFAJM_3VAXn=A@mail.gmail.com>
 <A7D88101-837A-4FD2-B397-019D1845A418@vmware.com>
 <20190103181057.lflra4lkoaeg2btv@treble>
In-Reply-To: <20190103181057.lflra4lkoaeg2btv@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4632;20:Cm08MI3Qmo+9yOrba4bq52Anl5zlifHSfQcKZ6ao0V9OxEM+RBHv8Ye92ca0pwbfZAja2Pjkl8e2Gua9pF63HaIzRkrLny8JSk+z5id1PvUfmovuUgyuqRcdKDT/oeYM4775IVigEY64m10K9UxZdVeI37iIQ7ZDJAwX9r56LVQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ceea96ca-e84c-4e20-1057-08d671a97d59
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4632;
x-ms-traffictypediagnostic: BYAPR05MB4632:
x-microsoft-antispam-prvs: <BYAPR05MB463251CB99AEADA08C386373D08D0@BYAPR05MB4632.namprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231475)(944501520)(52105112)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4632;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4632;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(136003)(39860400002)(54534003)(189003)(199004)(7736002)(66066001)(6512007)(5660300001)(53936002)(305945005)(25786009)(6246003)(6486002)(6436002)(8936002)(229853002)(8676002)(81166006)(81156014)(36756003)(6916009)(14454004)(7416002)(99286004)(93886005)(82746002)(54906003)(316002)(3846002)(86362001)(478600001)(6116002)(2906002)(68736007)(105586002)(106356001)(76176011)(486006)(6506007)(476003)(2616005)(26005)(186003)(53546011)(4326008)(33656002)(71200400001)(446003)(11346002)(71190400001)(97736004)(83716004)(102836004)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4632;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ahyv8iNqKRsJqArJZQ1ctt7wiqXwMoS13EJt3i5pQjZkQudFlIwfMBvLugWpVsPghWo+YIso/CgHxsUyVyT9m8YykBjArtriyNi2O057f1rJGFH7HcGsJHPqELwyLOAF17pxVw8CYbPaAgoIeOnd8SOozq/bNZMniEwVfj5LhBcDY1NQszDYL6gkMZEVv6TMvqZb9IdiQHvmhrU6Nl6vVy8iAvsoubSc2iQeFMolXGoMrUQT/YSbIi9VEY/bo6PnD7NvPsJwiMGrT9HluZ0sU08PBGV1inI0GPryDgdjz/OhaBmMqcIllW7zESUwPxx9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A0AE5837725E64F947BBB9247499997@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceea96ca-e84c-4e20-1057-08d671a97d59
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 18:30:08.4498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4632
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMywgMjAxOSwgYXQgMTA6MTAgQU0sIEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBy
ZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgRGVjIDMxLCAyMDE4IGF0IDA3OjUzOjA2
UE0gKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+Pj4gT24gRGVjIDMxLCAyMDE4LCBhdCAxMTo1
MSBBTSwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+
IE9uIFN1biwgRGVjIDMwLCAyMDE4IGF0IDExOjIwIFBNIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2Fy
ZS5jb20+IHdyb3RlOg0KPj4+PiBUaGlzIGlzIGEgcmV2aXNlZCB2ZXJzaW9uIG9mIG9wdHBvbGlu
ZXMgKGZvcm1lcmx5IG5hbWVkIHJldHBvbGluZXMpIGZvcg0KPj4+PiBkeW5hbWljIGluZGlyZWN0
IGJyYW5jaCBwcm9tb3Rpb24gaW4gb3JkZXIgdG8gcmVkdWNlIHJldHBvbGluZSBvdmVyaGVhZHMN
Cj4+Pj4gWzFdLg0KPj4+IA0KPj4+IFNvbWUgb2YgeW91ciBjaGFuZ2Vsb2dzIHN0aWxsIGNhbGwg
dGhlbSAicmVscG9saW5lcyIuDQo+Pj4gDQo+Pj4gSSBoYXZlIGEgY3Jhenkgc3VnZ2VzdGlvbjog
bWF5YmUgZG9uJ3QgZ2l2ZSB0aGVtIGEgY3V0ZSBuYW1lIGF0IGFsbD8NCj4+PiBXaGVyZSBpdCdz
IGFjdHVhbGx5IG5lY2Vzc2FyeSB0byBuYW1lIHRoZW0gKGxpa2UgaW4gYSBjb25maWcgb3B0aW9u
KSwNCj4+PiB1c2UgYSBkZXNjcmlwdGlvbiBsaWtlIENPTkZJR19EWU5BTUlDX0RFVklSVFVBTEla
QVRJT04gb3INCj4+PiBDT05GSUdfUEFUQ0hfSU5ESVJFQ1RfQ0FMTFMgb3Igc29tZXRoaW5nLg0K
PiANCj4gQ3V0ZSBvciBub3QsIG5hbWluZyBpcyBpbXBvcnRhbnQuDQo+IA0KPiBJZiB5b3Ugd2Fu
dCBhIGRlc2NyaXB0aW9uIGluc3RlYWQgb2YgYSBuYW1lLCBpdCB3aWxsIGJlIGEgY2hhbGxlbmdl
IHRvDQo+IGRlc2NyaWJlIGl0IGluIDItMyB3b3Jkcy4NCj4gDQo+IEkgaGF2ZSBubyBpZGVhIHdo
YXQgImR5bmFtaWMgZGV2aXJ0dWFsaXphdGlvbiIgbWVhbnMuDQo+IA0KPiAiUGF0Y2ggaW5kaXJl
Y3QgY2FsbHMiIGRvZXNuJ3QgZnVsbHkgZGVzY3JpYmUgaXQgZWl0aGVyIChhbmQgY291bGQgYmUN
Cj4gZWFzaWx5IGNvbmZ1c2VkIHdpdGggc3RhdGljIGNhbGxzIGFuZCBzb21lIG90aGVyIGFwcHJv
YWNoZXMpLg0KPiANCj4+IEnigJltIHRvdGFsbHkgZmluZSB3aXRoIHRoYXQgKGRvbuKAmXQgdHVy
biBtZSBpbnRvIGEgIm1hcmtldGluZ+KAnSBndXkpLiBJdCB3YXMNCj4+IGp1c3QgYSB3YXkgdG8g
cmVmZXIgdG8gdGhlIG1lY2hhbmlzbS4gSSBuZWVkIG1vcmUgZmVlZGJhY2sgYWJvdXQgdGhlIG1v
cmUNCj4+IGZ1bmRhbWVudGFsIGlzc3VlcyB0byBnbyBvbi4NCj4gDQo+IE5hbWluZyBpc24ndCBt
YXJrZXRpbmcuICBJdCdzIGEgcmVhbCBpc3N1ZTogaXQgYWZmZWN0cyBib3RoIHVzYWJpbGl0eQ0K
PiBhbmQgY29kZSByZWFkYWJpbGl0eS4NCg0KV2VsbCwgYWxsb3cgbWUgdG8gYmUgb24gdGhlIGZl
bmNlIG5vdCB0aGlzIG9uZS4NCg0KSSBsb29rIGZvciB0aGUgcGF0aCBvZiBsZWFzdCByZXNpc3Rh
bmNlLiBJIHRoaW5rIGl0IHdvdWxkIGJlIGVhc2llc3QgaWYgSQ0KZmlyc3QgbWFuYWdlIHRvIG1h
a2UgSm9zaOKAmXMgc3RhdGljIGNhbGxzIHRvIGJlIGxlc3MgaW50cnVzaXZlLiBGb3IgdGhhdCwg
SQ0KdHJ5IHRvIGFkZCBpbiB0aGUgR0NDIHBsdWdpbiBhbiBhdHRyaWJ1dGUgdG8gYW5ub3RhdGUg
dGhlIGZ1bmN0aW9uIHBvaW50ZXJzDQp3aG9zZSBjYWxscyBzaG91bGQgYmUgcHJvbW90ZWQuIEhv
d2V2ZXIsIEkgZG9u4oCZdCBtYW5hZ2UgdG8gZ2V0IHRoZQ0KZGVjbGFyYXRpb24gZnJvbSB0aGUg
Y2FsbCBpbnN0cnVjdGlvbidzIHJ0eC4gSWYgYW55b25lIGhhcyBhIHBvaW50ZXIgb24gaG93DQpp
dCBjYW4gYmUgZG9uZSwgdGhhdOKAmXMgd291bGQgYmUgdmVyeSBoZWxwZnVsLg0KDQo=

Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608DAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B87E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="hxwlpGg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfAKBrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 20:47:09 -0500
Received: from mail-eopbgr790043.outbound.protection.outlook.com ([40.107.79.43]:41792
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727750AbfAKBrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 20:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZj86WisJ3+UnwGkV9x39VXHCUUWcgwqY4aq171KBx8=;
 b=hxwlpGg/ubsoIz22dSjD4XhdbkjRzpb+oJ0W65THSGOoVuNsCfqKh1JrE0kTT0jcQ523kb67oFPiqcowc4JLebS/stNuPpbo2Qt0WG9XjaB9AG1ajCBJ5GyamjJepnlzkdcf3xEf4NeM0trknldJ7QfCyOI6OfWhP/Au3pfUog8=
Received: from BL0PR05MB4772.namprd05.prod.outlook.com (20.177.145.81) by
 BL0PR05MB5636.namprd05.prod.outlook.com (10.167.240.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.10; Fri, 11 Jan 2019 01:47:02 +0000
Received: from BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::4cb4:35db:ba27:ad10]) by BL0PR05MB4772.namprd05.prod.outlook.com
 ([fe80::4cb4:35db:ba27:ad10%4]) with mapi id 15.20.1516.010; Fri, 11 Jan 2019
 01:47:02 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Thread-Topic: [PATCH v3 0/6] Static calls
Thread-Index: AQHUqG8IuMNefdUVHE69woqiOXvtzqWo9cGAgAAGKQCAACROAIAAH8IAgAAOP4A=
Date:   Fri, 11 Jan 2019 01:47:01 +0000
Message-ID: <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <20190110203023.GL2861@worktop.programming.kicks-ass.net>
 <20190110205226.iburt6mrddsxnjpk@treble>
 <CAHk-=whR7LzKcuB9Z2km1T25DUkJcbE9rNhCzApAPADbDqMhmQ@mail.gmail.com>
 <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
In-Reply-To: <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR05MB5636;20:U/ejD0VMXgzfXLOwy1PG2TOrU7Zbxqw/PdkV/4qCWFmoAoH+eyPBT+Gp7na8bP4dX9+qapjphyOMRGCIOhZ/qP/9c2Pqv5jL9srbf+04VNIpQSBHZsGlRMACMKUbvyUOSQPW2lj/7gVTdUDv6VCAatcoTkuWX/OjEDZyaoatRJ0=
x-ms-office365-filtering-correlation-id: 3ec4f483-7eae-45b6-0aaf-08d67766aebb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BL0PR05MB5636;
x-ms-traffictypediagnostic: BL0PR05MB5636:
x-microsoft-antispam-prvs: <BL0PR05MB563645AB7DD0C50A0155680FD0850@BL0PR05MB5636.namprd05.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(189003)(71200400001)(256004)(71190400001)(68736007)(2906002)(82746002)(229853002)(53546011)(106356001)(105586002)(6506007)(2616005)(476003)(4326008)(25786009)(86362001)(83716004)(97736004)(6916009)(36756003)(6436002)(5660300001)(446003)(53936002)(6246003)(11346002)(478600001)(93886005)(14454004)(99286004)(8936002)(33656002)(6486002)(7416002)(6512007)(6116002)(316002)(81156014)(8676002)(3846002)(102836004)(81166006)(26005)(486006)(7736002)(76176011)(305945005)(186003)(54906003)(66066001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB5636;H:BL0PR05MB4772.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3/B+kbDdTzJH03EleR+MSvykRPTlNIKwWBPA8QZOPG0lEoxKZpsE43+V4rPexe/kYjoLFC/+hEcP/gHtA3nn293cUs5QM6XYTzauXOriRRbSTYZzP18Zlenl6nS2D/A1jBnYr9eH5eSkQhGrbE28XTSG6K6qMsTf51pm0uet2DqfiyYQscSek7VyGexyDGEDylfPBFuoJIA4FAztA9zi2VAbL5qkaFtJjIqRHuhF9RQ6ZlscpNSX7iQI0u96EYxckYiopUt4ta85DS19D4Q/3aM96a0ZHRrR+PcbKAp4aiokU79sHyYrVa7D51naptblm47EJG70rgZZ5xpRg3NS3kz0A3EfwVAQ0yLJGR4iUAh6t7cB9MmRK2UfNiCueb9DYVqW4cRtF30+UpgZE69gJ8bbJZgg2SC++A/5wHpeHCw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA1428EDB99FA34DA0955E88DA1910BE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec4f483-7eae-45b6-0aaf-08d67766aebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 01:47:01.9535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMTAsIDIwMTksIGF0IDQ6NTYgUE0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSmFuIDEwLCAyMDE5IGF0IDM6MDIgUE0gTGlu
dXMgVG9ydmFsZHMNCj4gPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4+
IE9uIFRodSwgSmFuIDEwLCAyMDE5IGF0IDEyOjUyIFBNIEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJv
ZUByZWRoYXQuY29tPiB3cm90ZToNCj4+PiBSaWdodCwgZW11bGF0aW5nIGEgY2FsbCBpbnN0cnVj
dGlvbiBmcm9tIHRoZSAjQlAgaGFuZGxlciBpcyB1Z2x5LA0KPj4+IGJlY2F1c2UgeW91IGhhdmUg
dG8gc29tZWhvdyBncm93IHRoZSBzdGFjayB0byBtYWtlIHJvb20gZm9yIHRoZSByZXR1cm4NCj4+
PiBhZGRyZXNzLiAgUGVyc29uYWxseSBJIGxpa2VkIHRoZSBpZGVhIG9mIHNoaWZ0aW5nIHRoZSBp
cmV0IGZyYW1lIGJ5IDE2DQo+Pj4gYnl0ZXMgaW4gdGhlICNEQiBlbnRyeSBjb2RlLCBidXQgb3Ro
ZXJzIGhhdGVkIGl0Lg0KPj4gDQo+PiBZZWFoLCBJIGhhdGVkIGl0Lg0KPj4gDQo+PiBCdXQgSSdt
IHN0YXJ0aW5nIHRvIHRoaW5rIGl0J3MgdGhlIHNpbXBsZXN0IHNvbHV0aW9uLg0KPj4gDQo+PiBT
byBzdGlsbCBub3QgbG92aW5nIGl0LCBidXQgYWxsIHRoZSBvdGhlciBtb2RlbHMgaGF2ZSBoYWQg
aHVnZSBpc3N1ZXMgdG9vLg0KPiANCj4gUHV0dGluZyBteSBtYWludGFpbmVyIGhhdCBvbjoNCj4g
DQo+IEknbSBva2F5LWlzaCB3aXRoIHNoaWZ0aW5nIHRoZSBzdGFjayBieSAxNiBieXRlcy4gIElm
IHRoaXMgaXMgZG9uZSwgSQ0KPiB3YW50IGFuIGFzc2VydGlvbiBpbiBkb19pbnQzKCkgb3Igd2hl
cmV2ZXIgdGhlIGZpeHVwIGhhcHBlbnMgdGhhdCB0aGUNCj4gd3JpdGUgaXNuJ3Qgb3ZlcmxhcHBp
bmcgcHRfcmVncyAod2hpY2ggaXMgZWFzeSB0byBpbXBsZW1lbnQgYmVjYXVzZQ0KPiB0aGF0IGNv
ZGUgaGFzIHRoZSByZWxldmFudCBwdF9yZWdzIHBvaW50ZXIpLiAgQW5kIEkgd2FudCBzb21lIGNv
ZGUNCj4gdGhhdCBleHBsaWNpdGx5IHRyaWdnZXJzIHRoZSBmaXh1cCB3aGVuIGEgQ09ORklHX0RF
QlVHX0VOVFJZPXkgb3INCj4gc2ltaWxhciBrZXJuZWwgaXMgYnVpbHQgc28gdGhhdCB0aGlzIHdo
b2xlIG1lc3MgYWN0dWFsbHkgZ2V0cw0KPiBleGVyY2lzZWQuICBCZWNhdXNlIHRoZSBmaXh1cCBv
bmx5IGhhcHBlbnMgd2hlbiBhDQo+IHJlYWxseS1xdWl0ZS1pbXByb2JhYmxlIHJhY2UgZ2V0cyBo
aXQsIGFuZCB0aGUgaXNzdWVzIGRlcGVuZCBvbiBzdGFjaw0KPiBhbGlnbm1lbnQsIHdoaWNoIGlz
IHByZXN1bWFibHkgd2h5IEpvc2ggd2FzIGFibGUgdG8gc3VibWl0IGEgYnVnZ3kNCj4gc2VyaWVz
IHdpdGhvdXQgbm90aWNpbmcuDQo+IA0KPiBCVVQ6IHRoaXMgaXMgZ29pbmcgdG8gYmUgdXR0ZXJs
eSBncm9zcyB3aGVuZXZlciBhbnlvbmUgdHJpZXMgdG8NCj4gaW1wbGVtZW50IHNoYWRvdyBzdGFj
a3MgZm9yIHRoZSBrZXJuZWwsIGFuZCB3ZSBtaWdodCBuZWVkIHRvIHN3aXRjaCB0bw0KPiBhIGxv
bmdqbXAtbGlrZSBhcHByb2FjaCBpZiB0aGF0IGhhcHBlbnMuDQoNCkhlcmUgaXMgYW4gYWx0ZXJu
YXRpdmUgaWRlYSAoYWx0aG91Z2ggc2ltaWxhciB0byBTdGV2ZW7igJlzIGFuZCBteSBjb2RlKS4N
Cg0KQXNzdW1lIHRoYXQgd2UgYWx3YXlzIGNsb2JiZXIgUjEwLCBSMTEgb24gc3RhdGljLWNhbGxz
IGV4cGxpY2l0bHksIGFzIGFueWhvdw0Kc2hvdWxkIGJlIGRvbmUgYnkgdGhlIGNhbGxpbmcgY29u
dmVudGlvbiAoYW5kIGdjYyBwbHVnaW4gc2hvdWxkIGFsbG93IHVzIHRvDQplbmZvcmNlKS4gQWxz
byBhc3N1bWUgdGhhdCB3ZSBob2xkIGEgdGFibGUgd2l0aCBhbGwgc291cmNlIFJJUCBhbmQgdGhl
DQptYXRjaGluZyB0YXJnZXQuDQoNCk5vdywgaW4gdGhlIGludDMgaGFuZGxlciBjYW4geW91IHRh
a2UgdGhlIGZhdWx0aW5nIFJJUCBhbmQgc2VhcmNoIGZvciBpdCBpbg0KdGhlIOKAnHN0YXRpYy1j
YWxsc+KAnSB0YWJsZSwgd3JpdGluZyB0aGUgUklQKzUgKG9mZnNldCkgaW50byBSMTAgKHJldHVy
bg0KYWRkcmVzcykgYW5kIHRoZSB0YXJnZXQgaW50byBSMTEuIFlvdSBtYWtlIHRoZSBpbnQzIGhh
bmRsZXIgdG8gZGl2ZXJ0IHRoZQ0KY29kZSBleGVjdXRpb24gYnkgY2hhbmdpbmcgcHRfcmVncy0+
cmlwIHRvIHBvaW50IHRvIGEgbmV3IGZ1bmN0aW9uIHRoYXQgZG9lczoNCg0KCXB1c2ggUjEwDQoJ
am1wIF9feDg2X2luZGlyZWN0X3RodW5rX3IxMQ0KDQpBbmQgdGhlbiB5b3UgYXJlIGRvbmUuIE5v
Pw0KDQo=

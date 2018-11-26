Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA279C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BB420873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DCQ7Y3a0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62BB420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeK0Isg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:48:36 -0500
Received: from mail-eopbgr710076.outbound.protection.outlook.com ([40.107.71.76]:23470
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726363AbeK0Ise (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qklrShJhNT64bX8EM7YXadptI6mbwp5MbgBqqv9gI44=;
 b=DCQ7Y3a0V0Hej/tDoxm7g8qhYzr4BDy+28BhV79TzhT7Xaz31S3mrLeVAI8YloNXJ2kVUYksnzrGmf7Mo/xnN7M832GTJua1IXXV/NX082Xy7hEQl51xl/BoFL3jn+GFM/kSD77oxlakBLt/s/FVc2cTbp9kxX6AgbOUnOUZdbM=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0416.namprd12.prod.outlook.com (10.162.104.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.16; Mon, 26 Nov 2018 21:52:20 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 21:52:20 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrea Arcangeli <aarcange@redhat.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>,
        "jcm@redhat.com" <jcm@redhat.com>,
        "longman9394@gmail.com" <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "david.c.stewart@intel.com" <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 27/28] x86/speculation: Add seccomp Spectre v2 user
 space protection mode
Thread-Topic: [patch V2 27/28] x86/speculation: Add seccomp Spectre v2 user
 space protection mode
Thread-Index: AQHUhPDD+P1VLWAUI0CKUyuSsPOtHqVg9EAAgAAeY4CAAXZQAIAAArmAgAAPCQA=
Date:   Mon, 26 Nov 2018 21:52:19 +0000
Message-ID: <81e4aeef-8a6e-b831-3e8f-eb21bc7bd4a2@amd.com>
References: <20181125183328.318175777@linutronix.de>
 <20181125185006.051663132@linutronix.de>
 <CAHk-=whtiX45YPjFPMFuktZ3WB23zqBZR-rL6RewrTyvrFj2Fw@mail.gmail.com>
 <alpine.DEB.2.21.1811252321300.1684@nanos.tec.linutronix.de>
 <20181126204842.GC16136@redhat.com>
 <alpine.DEB.2.21.1811262156480.1682@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811262156480.1682@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0017.prod.exchangelabs.com (2603:10b6:804:2::27)
 To SN1PR12MB0175.namprd12.prod.outlook.com (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0416;20:4zgdGlxFnlITb/hul6IAnVkfK7khKhBKf2oW2VueVlU8TVlWw4mj1gGsrcYF6L37oeSz0S7R2Q7Edkd7dRR+A7FWdXruyLxYwi/vzT44Ex7i8FfIglFvc7L9Na6uyQyT6APCSoAu6aqtZXgHimNoSUk4wRxOyvDg1Srq1P50LXM0O5khExG6I7YVtQyv1SimfUMeXLrn96CZRIMWB9KjLwy5fqs4olKfKMX5iRTJrsD86H7vHJCKt2OUWYEsixkz
x-ms-office365-filtering-correlation-id: ff4ab02f-9059-4259-e650-08d653e97008
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0416;
x-ms-traffictypediagnostic: SN1PR12MB0416:
x-microsoft-antispam-prvs: <SN1PR12MB0416C0D57D1A1FCC858B2608ECD70@SN1PR12MB0416.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231443)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0416;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0416;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(72206003)(66066001)(86362001)(4326008)(3846002)(53936002)(6512007)(6306002)(5660300001)(6116002)(229853002)(476003)(81156014)(31686004)(305945005)(7736002)(39060400002)(81166006)(6246003)(8936002)(8676002)(256004)(14444005)(54906003)(6486002)(71190400001)(97736004)(93886005)(71200400001)(2906002)(36756003)(31696002)(316002)(25786009)(110136005)(106356001)(14454004)(386003)(102836004)(186003)(26005)(6506007)(53546011)(105586002)(6436002)(76176011)(99286004)(52116002)(11346002)(2616005)(7416002)(486006)(966005)(68736007)(446003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0416;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Jaa3HM/RkrtwRYsBjLJShjDnm8/TAk2RtTFw5dEtUEow2txmUbfAzww8GE5HwDOmsp97DIEdkegA4oFd1eVmP6huZJDrLixaBMbgHmujUda6wciGG64FpF2zVcV1J92KFVdSTn1m5z3sVJcDiM1deZTTOwudDuvzNvaCNzCvurbA5ocz3rurrLujLjosR1dNRFZbAtZGCw2fPd8F/9mih+A2iYYFLevngRc81Dv1ezos6Jf81Cgr37tz65ZG7mxSr3NCN4Be8afm4Z/Cb3/c15pr4jDg3F92NdrMIBwod9sw/q6ONISAUb2Mowi2ZNTjIG8fEGRjJEabBeGe+Li4DXdNTNrNjWSoz7oB49B1Rak=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9832419C64A06A40A5D925908C0577D3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4ab02f-9059-4259-e650-08d653e97008
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 21:52:19.8964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0416
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjYvMjAxOCAwMjo1OCBQTSwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiBPbiBNb24s
IDI2IE5vdiAyMDE4LCBBbmRyZWEgQXJjYW5nZWxpIHdyb3RlOg0KPiANCj4+IEhlbGxvLA0KPj4N
Cj4+IE9uIFN1biwgTm92IDI1LCAyMDE4IGF0IDExOjI4OjU5UE0gKzAxMDAsIFRob21hcyBHbGVp
eG5lciB3cm90ZToNCj4+PiBJbmRlZWQuIEp1c3QgY2hlY2tlZCB0aGUgZG9jdW1lbnRhdGlvbiBh
Z2FpbiwgaXQncyBhbHNvIG5vdCBjbGVhciB3aGV0aGVyDQo+Pj4gSUJQQiBpcyByZXF1aXJlZCBp
ZiBTVElQQiBpcyBpbiB1c2UuDQo+Pg0KPj4gSSB0cmllZCB0byBhc2sgdGhpcyBxdWVzdGlvbiB0
b28gZWFybGllcjoNCj4+DQo+PiBodHRwczovL2xrbWwua2VybmVsLm9yZy9yLzIwMTgxMTE5MjM0
NTI4LkdKMjkyNThAcmVkaGF0LmNvbQ0KPj4NCj4+IElmIHRoZSBCVEIgbWlzdHJhaW5pbmcgaW4g
U0VDQ09NUCBjb250ZXh0IHdpdGggU1RJQlAgc2V0IGluIFNQRUNfQ1RSTCwNCj4+IGNhbiBzdGls
bCBpbmZsdWVuY2UgdGhlIGh5cGVydGhyZWFkaW5nIHNpYmxpbmcgYWZ0ZXIgU1RJQlAgaXMgY2xl
YXJlZCwNCj4+IElCUEIgaXMgbmVlZGVkIGJlZm9yZSBjbGVhcmluZyBTVElCUC4gT3RoZXJ3aXNl
IGl0J3Mgbm90LiBVbmxlc3MgdG9sZA0KPj4gb3RoZXJ3aXNlLCBpdCdkIGJlIHNhZmUgdG8gYXNz
dW1lIElCUEIgaXMgbmVlZGVkIGluIHN1Y2ggY2FzZS4NCj4gDQo+IElCUEIgaXMgc3RpbGwgaXNz
dWVkLiBJIHdvbid0IGNoYW5nZSB0aGF0IGJlZm9yZSB3ZSBoYXZlIGNsYXJpZmljYXRpb24uDQoN
CkZyb20gYW4gQU1EIHN0YW5kcG9pbnQsIHdlIHJlY29tbWVuZCBzdGlsbCBpc3N1aW5nIHRoZSBJ
QlBCLg0KDQo+IA0KPiBCdXQgSSBkb3VidCBpdCdzIG5lY2Vzc2FyeS4gU1RJQlAgc2VlbXMgdG8g
YmUgYSByYXRoZXIgYmlnIGhhbW1lci4NCg0KRm9yIEFNRCBwYXJ0cyB0aGF0IHN1cHBvcnQgU1RJ
QlAsIHlvdSB3aWxsIHNlZSBsaWtlbHkgZGlmZmVyaW5nIGxldmVscw0Kb2YgcGVyZm9ybWFuY2Ug
aW1wYWN0LiAgQU1EIGFsc28gaGFzIGEgQ1BVSUQgYml0ICgweDgwMDBfMDAwOF9FQlhbMTddKQ0K
dGhhdCBpbmRpY2F0ZXMgU1RJQlAgYWx3YXlzIG9uIG1vZGUgaXMgcHJlZmVycmVkIFsxXSB0byB0
b2dnbGluZyB0aGUNCk1TUi4NCg0KSSB3YXMgcGxhbm5pbmcgdG8gZG8gYSBmb2xsb3cgb24gcGF0
Y2ggc2V0IGZvciB0aGF0IHN1cHBvcnQgYWZ0ZXIgdGhpcw0Kc2VyaWVzIGlzIGFjY2VwdGVkIHJh
dGhlciB0aGFuIGFzayB0aGF0IGl0IGJlIGFkZGVkIHRvIHRoaXMgc2VyaWVzIGF0DQp0aGlzIHRp
bWUgKHVubGVzcyBmb2xrcyB3b3VsZCBwcmVmZXIgdGhhdCBpdCBiZSBkb25lIG5vdz8pLg0KDQpU
aGFua3MsDQpUb20NCg0KWzFdIGh0dHBzOi8vZGV2ZWxvcGVyLmFtZC5jb20vd3AtY29udGVudC9y
ZXNvdXJjZXMvQXJjaGl0ZWN0dXJlX0d1aWRlbGluZXNfVXBkYXRlX0luZGlyZWN0X0JyYW5jaF9D
b250cm9sLnBkZg0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAJdGdseA0KPiANCg==

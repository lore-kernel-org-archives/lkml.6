Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE65C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA862184A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 00:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="jY+94VHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfBAAZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 19:25:47 -0500
Received: from mail-eopbgr800080.outbound.protection.outlook.com ([40.107.80.80]:48339
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbfBAAZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 19:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eoesr+avZHybWqYak19mzfk9DSZQ/hxKNgKYvR+XcKI=;
 b=jY+94VHz679uGbEghPRaqWHsdKes5YOgpzHpe7w0HZVu0FBHRrl1RlivJBR93TWIcjlAMo4+pF/W+7rUQvvA73q7Im1SOsAE8SyPqKUDTs3c/aWuVtnPXzWURU9lvF48PEdsqHsTdfOwHuz5nLsIxg1UiNSwQavusvdCVyr+HAM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6087.namprd05.prod.outlook.com (20.178.54.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10; Fri, 1 Feb 2019 00:25:43 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::99ab:18fb:f393:df31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::99ab:18fb:f393:df31%3]) with mapi id 15.20.1601.011; Fri, 1 Feb 2019
 00:25:43 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2 03/20] x86/mm: temporary mm struct
Thread-Topic: [PATCH v2 03/20] x86/mm: temporary mm struct
Thread-Index: AQHUt2sRwAS+mFb6qECsCs685/9Pk6XJQbUAgAC1oACAAB5FAIAABOQA
Date:   Fri, 1 Feb 2019 00:25:43 +0000
Message-ID: <D0AE47D2-F4B7-4938-A002-BBEEA3A5AB49@vmware.com>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-4-rick.p.edgecombe@intel.com>
 <20190131112948.GE6749@zn.tnic>
 <C481E605-E19A-4EA6-AB9A-6FF4229789E0@vmware.com>
 <20190201000812.GP6749@zn.tnic>
In-Reply-To: <20190201000812.GP6749@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6087;20:czt+c0sCKtRZufioavLX9l3Oj7F5inRxRK/ASyBzM2VTQ+Y/TOfoDmKMRzSGSE54lLUlL4cRW8XQWXpp9Ap2DfwCjzM4KgTuR+oxwFiu+vl8yHX8gXzAuX9rJK77WxoNeLXj8SsUMWcrvkeC8Lgy7l1RrIXxa7X6aFZUuotZONA=
x-ms-office365-filtering-correlation-id: ffef8a9a-4892-4e44-9dd8-08d687dbcdae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6087;
x-ms-traffictypediagnostic: BYAPR05MB6087:
x-microsoft-antispam-prvs: <BYAPR05MB608706B4F78AF80641F2C998D0920@BYAPR05MB6087.namprd05.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(366004)(136003)(376002)(199004)(189003)(36756003)(106356001)(53546011)(11346002)(446003)(81156014)(8676002)(316002)(66066001)(81166006)(82746002)(6512007)(53936002)(4326008)(478600001)(6916009)(54906003)(102836004)(2616005)(14454004)(25786009)(33656002)(39060400002)(105586002)(476003)(26005)(6506007)(186003)(6246003)(76176011)(256004)(99286004)(71200400001)(7416002)(2906002)(7736002)(97736004)(486006)(8936002)(6116002)(6436002)(6486002)(3846002)(305945005)(229853002)(83716004)(68736007)(86362001)(93886005)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6087;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YStyBkvhgtyMGntAbK+aaaMc3Cd5fwBEbQqTfx6lNynrwAJ2svHEMzB5CPATVeVKf7K18X+f6XQW5BsfAecVkt2ZVVrTP58SjqLIBhok6/xWzb0gS4q9V3V+WRPh8NcFzadWVfOMJ4Va326lA6/QzfzxzY5Pb3c3l6ltBKCVvcgjDnwRP88frp1TD1eyl7aT5k7reLvQFjMoh+GsYp9H9TwVfUOsDdtxJnbzTQUVD0AuB2sy4wekc/zWbW2Ijml/DjPYrbQRNzAkxghxnY66zPJIevNa2aqKwKoJ+zcyq6nE6h15eQtiyeOlxxvoPbNiTdms5b9vmp7SIaxBEQCrx+rODTf3Ca1c3Wk023jLYB3UquE7dT7HP0YwnfFRq9RYD6M0uaKgJt3VSrlNiHctNdLJuO46oh2LyJduAJraShA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A873F991F428B14CAEEB63AA4CB8EBCD@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffef8a9a-4892-4e44-9dd8-08d687dbcdae
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 00:25:43.5652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMzEsIDIwMTksIGF0IDQ6MDggUE0sIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44
LmRlPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSmFuIDMxLCAyMDE5IGF0IDEwOjE5OjU0UE0gKzAw
MDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+PiBNZXRhLXF1ZXN0aW9uOiBjb3VsZCB5b3UgcGxlYXNl
IHJldmlldyB0aGUgZW50aXJlIHBhdGNoLXNldD8gVGhpcyBpcw0KPj4gYWN0dWFsbHkgdjkgb2Yg
dGhpcyBwYXJ0aWN1bGFyIHBhdGNoIC0gaXQgd2FzIHBhcnQgb2YgYSBzZXBhcmF0ZSBwYXRjaC1z
ZXQNCj4+IGJlZm9yZS4gSSBkb27igJl0IHRoaW5rIHRoYXQgdGhlIHBhdGNoIGhhcyBjaGFuZ2Vk
IHNpbmNlICh0aGUgcmVhbCkgdjEuDQo+PiANCj4+IFRoZXNlIHNwb3JhZGljIGNvbW1lbnRzIGFm
dGVyIGVhY2ggdmVyc2lvbiByZWFsbHkgbWFrZXMgaXQgaGFyZCB0byBnZXQgdGhpcw0KPj4gd29y
ayBjb21wbGV0ZWQuDQo+IA0KPiBTb3JyeSBidXQgd2hlcmUgSSBhbSB0aGUgZGF5IGhhcyBvbmx5
IDI0IGhvdXJzIGFuZCB0aGlzIHBhdGNoc2V0IGlzIG5vdA0KPiB0aGUgb25seSBvbmUgaW4gbXkg
b3ZlcmZsb3dpbmcgbWJveC4gSWYgbXkgc3BvcmFkaWMgY29tbWVudHMgYXJlIG1ha2luZw0KPiBp
dCBoYXJkIHRvIGZpbmlzaCB5b3VyIHdvcmssIEkgYmV0dGVyIG5vdCBpbnRlcmZlcmUgdGhlbi4N
Cg0KSSBjZXJ0YWlubHkgZGlkIG5vdCBpbnRlbmQgZm9yIGl0IHRvIHNvdW5kIHRoaXMgd2F5LCBh
bmQgeW91ciBmZWVkYmFjayBpcw0Kb2J2aW91c2x5IHZhbHVhYmxlLg0KDQpKdXN0IGxldCBtZSBr
bm93IHdoZW4geW91IGFyZSBkb25lIHJldmlld2luZyB0aGUgcGF0Y2gtc2V0LCBzbyBJIHdpbGwg
bm90DQpvdmVyZmxvdyB5b3VyIG1haWxib3ggd2l0aCBldmVuIHVubmVjZXNzYXJ5IHZlcnNpb25z
IG9mIHRoZXNlIHBhdGNoZXMuIDopDQoNCg==

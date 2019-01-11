Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D84EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58127218A4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="lSt5cQD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfAKWAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:00:02 -0500
Received: from mail-eopbgr750082.outbound.protection.outlook.com ([40.107.75.82]:18880
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbfAKWAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NT2QLKbxGGoO0pWKwLBPO/7v908t2af9DGGzwraDO+k=;
 b=lSt5cQD61vajSRD2VG/AmCx5jSg4NTXuVcSVGfrW96SjzHujhi05eR44NJDwFRRZWCUHjOFzhMci0c05EpCTPtVEabSllTr8I8rt23Cv8QixovXTP1xXsmaQR9K+Im5IOMLiX3LZ56SKB2J9eGZ36s7i3R/H7fQJZnSrpCK43Qw=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5288.namprd05.prod.outlook.com (20.177.126.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.6; Fri, 11 Jan 2019 21:59:49 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1537.013; Fri, 11 Jan 2019
 21:59:49 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Thread-Index: AQHUqG8IuMNefdUVHE69woqiOXvtzqWo9cGAgAAGKQCAACROAIAAH8IAgAAOP4CAAOHdgIAAP7oAgAAQ/wCAAAJIAIAABVWAgAAENoCAAAnsAIAABCIAgAABOwCAAAP5gIAAASyA
Date:   Fri, 11 Jan 2019 21:59:48 +0000
Message-ID: <E97C5B54-1F2D-4489-8FDE-AE95805D5F4C@vmware.com>
References: <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
 <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <20190111200420.qtyffayxceysoarf@treble>
 <CAHk-=whLu9kG3dqgXUkCrNrTp0NVtdOOWxvonXTfhtq-krXo+Q@mail.gmail.com>
 <20190111203135.5clurevf34bkiy3o@treble>
 <CAHk-=whKabsg3N4uHHFkHXXf_mi6=T2OvkC-OUNG8Lt-bsCjFg@mail.gmail.com>
 <20190111212210.veyfn5vvjswcwacm@treble>
 <6B0B7437-0577-4FE7-A0BC-EFB5D94B8C21@vmware.com>
 <20190111214122.dzye2mg32aksuyo3@treble>
 <20190111165535.467c59a3@gandalf.local.home>
In-Reply-To: <20190111165535.467c59a3@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5288;20:BVUdMXh6Z1vN21qQtbiJtChMfms4727AwVWdXTEtYWpMZjycUOR+qqobAv4FzeySDiAy0S7wa07mVQBPMnwS4M/jxA6/Q56JP/fH2WUsFNKHnNCRklH+ssoGJeIeLr3z05NBsDQssiBkZRVRPLcFxAvIFpnjCtZnFz3fuECOBRg=
x-ms-office365-filtering-correlation-id: 7bc8d105-ca3a-4eaf-0fae-08d678101b3b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5288;
x-ms-traffictypediagnostic: BYAPR05MB5288:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB528813D4D0E4FA96473DBA16D0850@BYAPR05MB5288.namprd05.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(136003)(376002)(39860400002)(189003)(199004)(2906002)(2616005)(6916009)(316002)(6512007)(14454004)(229853002)(3846002)(6116002)(105586002)(6486002)(53936002)(86362001)(478600001)(93886005)(8936002)(6436002)(99286004)(6246003)(106356001)(68736007)(102836004)(81156014)(82746002)(53546011)(8676002)(76176011)(97736004)(81166006)(6506007)(186003)(4326008)(7416002)(446003)(33656002)(486006)(54906003)(66066001)(71190400001)(83716004)(71200400001)(36756003)(11346002)(26005)(305945005)(476003)(256004)(25786009)(5660300001)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5288;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FKYMzH0mndAyICXpgAfpkBqUtdy5DtiH1PQT0QC0fz7ioaNsVh7QF8USy4GS3DhV2zd2CYPwHGTqLtF6YUAaKPCofyT1CdrVThD7KVFk+e/N65anlxxClLGNZ0XVKod+uxsjxJSfD9eFq93YOtJ/bOIjDqHWzW1xMTmTF0+vS6pB1M7Lfd/g/T+Li0FqalAOt2y9lSUPdlap634pM/q56xHv4kmMfNUD7TXwvL1pTHCmRc+s7ZvX3NujDwf35zswM8Td5hmL1o2rx0KweiutaGleajnTLy6ghDPgqZsQok9+fUiLrd4Dc60SeM4yngukgG+ywdkGgVPbmEi+SY+1EoTd5ZV/FE+4xpxScArshbUwmpLpP6XUAiByZ8UwpqB/sL75QHBVVHyn5WPHHhiwK2RvceuLn0rmmHoBnCqbPCA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E50954C51712164FA051DE8AA10D27BF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc8d105-ca3a-4eaf-0fae-08d678101b3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 21:59:48.8026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5288
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMTEsIDIwMTksIGF0IDE6NTUgUE0sIFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0QGdv
b2RtaXMub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgMTEgSmFuIDIwMTkgMTU6NDE6MjIgLTA2
MDANCj4gSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4+
PiBJIGRvbuKAmXQgc2VlIFJDVS1zY2hlZCBzb2x2ZXMgdGhlIHByb2JsZW0gaWYgeW91IGRvbuKA
mXQgZGlzYWJsZSBwcmVlbXB0aW9uLiBPbg0KPj4+IGEgZnVsbHkgcHJlZW1wdGFibGUga2VybmVs
LCB5b3UgY2FuIGdldCBwcmVlbXB0ZWQgYmV0d2VlbiB0aGUgcHVzaCBhbmQgdGhlDQo+Pj4gY2Fs
bCAoam1wKSBvciBiZWZvcmUgdGhlIHB1c2guIFJDVS1zY2hlZCBjYW4gdGhlbiBmaW5pc2gsIGFu
ZCB0aGUgcHJlZW1wdGVkDQo+Pj4gdGFzayBtYXkgbGF0ZXIganVtcCB0byBhIHdyb25nIHBhdGNo
ZWQtZGVzdC4gIA0KPj4gDQo+PiBBcmdoLCBJIG1pc3Nwb2tlIGFib3V0IFJDVS1zY2hlZC4gIFdv
cmRzIGFyZSBoYXJkLg0KPj4gDQo+PiBJIG1lYW50IHN5bmNocm9uaXplX3JjdV90YXNrcygpLCB3
aGljaCBpcyBhIGNvbXBsZXRlbHkgZGlmZmVyZW50IGFuaW1hbC4NCj4+IE15IHVuZGVyc3RhbmRp
bmcgaXMgdGhhdCBpdCB3YWl0cyB1bnRpbCBhbGwgcnVubmFibGUgdGFza3MgKGluY2x1ZGluZw0K
Pj4gcHJlZW1wdGVkIHRhc2tzKSBoYXZlIGdvdHRlbiBhIGNoYW5jZSB0byBydW4uDQo+IA0KPiBO
b3QgcXVpdGUsIGJ1dCBkb2VzIHRoZSBzYW1lIHRoaW5nLiBJdCB3YWl0cyBmb3IgYWxsIHRhc2tz
IHRvIGVpdGhlcg0KPiBzY2hlZHVsZSB2b2x1bnRhcmlseSAobm90IHByZWVtcHRlZCksIG9yIGJl
IC8gZ28gaW50byBpZGxlLCBvciBiZSAvZ28NCj4gaW50byB1c2Vyc3BhY2UuIEluIGFueSBjYXNl
LCBpdCBtYWtlcyBzdXJlIGNvZGUgaXMgb2ZmIG9mIHRyYW1wb2xpbmVzLg0KPiBJIHVzZSB0aGlz
IGJlZm9yZSBmcmVlaW5nIHRyYW1wb2xpbmVzIHVzZWQgYnkgZnRyYWNlLg0KDQpJbnRlcmVzdGlu
Zy4gU28gbXkgbGFzdCBlbWFpbCBpcyBjb21wbGV0ZWx5IHdyb25nLg0KIA==

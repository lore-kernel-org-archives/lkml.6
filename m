Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B694C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC7F20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="JmyxMcEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfAQSHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:07:09 -0500
Received: from mail-eopbgr750071.outbound.protection.outlook.com ([40.107.75.71]:62783
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726883AbfAQSHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkClpqSs7sYqRYRfvqlxznFCl+jGUQf5gmjOEUwWw4w=;
 b=JmyxMcEetW0qLuYESq6lM/XqC4i1UNV9kftXV4XgD59g1Ur2K9WRH02Wt5yzLXvKlCHkAxVvy5S2Uvu/1san3W3qYIFlcP53WyAz1eV5QhWrlfi3VP6ah0rzBHm/VHV4TsjdGR9HjpH0dh1tGeOh0hUxMSxB2DwkXnm7eS2zJyc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5925.namprd05.prod.outlook.com (20.178.50.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.18; Thu, 17 Jan 2019 18:07:04 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 18:07:04 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "deneen.t.dock@intel.com" <deneen.t.dock@intel.com>
Subject: Re: [PATCH 17/17] module: Prevent module removal racing with
 text_poke()
Thread-Topic: [PATCH 17/17] module: Prevent module removal racing with
 text_poke()
Thread-Index: AQHUrfxSkijPxOK+LEe5sodLHxfUCqWzF74AgACrLoA=
Date:   Thu, 17 Jan 2019 18:07:03 +0000
Message-ID: <B48C6E93-AD57-4FF8-BBE8-887A5E965793@vmware.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
 <20190117003259.23141-18-rick.p.edgecombe@intel.com>
 <20190117165422.d33d1af83db8716e24960a3c@kernel.org>
In-Reply-To: <20190117165422.d33d1af83db8716e24960a3c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5925;20:Vi/apmxjJ23QUDmVs3FnsGIZfpkP0XBdKEnQveUodPjdDrBHn2DDzAbOJctfUvOcKcU6xctxtlc0siIM6CKixwIxIdXT6Jy22CbleTpK9wwCgpsfigCP5wYk2OkeOesS/6QpsTxWU/I07CKjpgyYUj6A0j+EBfEa6mbqa3DZHsY=
x-ms-office365-filtering-correlation-id: 2d8f60d2-62fa-41b9-2867-08d67ca6960c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5925;
x-ms-traffictypediagnostic: BYAPR05MB5925:
x-microsoft-antispam-prvs: <BYAPR05MB59250A2DEF879F1A6F67D6B7D0830@BYAPR05MB5925.namprd05.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(366004)(199004)(189003)(105586002)(106356001)(68736007)(8676002)(478600001)(86362001)(83716004)(486006)(97736004)(14454004)(81156014)(71200400001)(7736002)(256004)(2906002)(71190400001)(14444005)(25786009)(39060400002)(99286004)(36756003)(4326008)(229853002)(305945005)(81166006)(7416002)(66066001)(3846002)(6116002)(8936002)(6246003)(6436002)(6916009)(33656002)(54906003)(82746002)(102836004)(6486002)(53546011)(5660300001)(53936002)(6506007)(76176011)(6512007)(446003)(476003)(2616005)(11346002)(316002)(186003)(6346003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5925;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UQEcAIhoevlTIiGu20nBIAcd1WAMT+k2PIofR7sRF6aWiLo8vI9aNnfgTx9125m06Ysn3zhU06TnorLtCNTJGr2fkJ/G8pTBHHhGnGc9/l81Y6GHy4lCdHJx1Wh97TU9H4fwTWSTwlRDyzWdE/VymaB2oQvbTEiQ0V0dL30wn2lWvYePvVhm1A/7v2if900GTSF68GEmJM8Ai0764y6RziRZ4CgwW/YhCvtTTMLMi9okpBBqah+H2ZUZNpXLhuOl94X/FWW2wDkARvfbPBTpcNupJLDzfCvteuwK31/oARQ39OWRfkGyIx0SdBJ69z2sVFpVhe3bGLKbPc72GUhPsTR3GrOp7InKgOqk5tVCFkIm9k4HQc/vdUBULHHkZyYWBQ0UfJQuuWjEhDWZaBX2KmOulTs/MVMIgaXxtW03Kqo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <697B667B5CAE78419D006F479D0BF3CB@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8f60d2-62fa-41b9-2867-08d67ca6960c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 18:07:04.0126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMTYsIDIwMTksIGF0IDExOjU0IFBNLCBNYXNhbWkgSGlyYW1hdHN1IDxtaGlyYW1h
dEBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgMTYgSmFuIDIwMTkgMTY6MzI6NTkg
LTA4MDANCj4gUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiB3cm90
ZToNCj4gDQo+PiBGcm9tOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPj4gDQo+PiBJ
dCBzZWVtcyBkYW5nZXJvdXMgdG8gYWxsb3cgY29kZSBtb2RpZmljYXRpb25zIHRvIHRha2UgcGxh
Y2UNCj4+IGNvbmN1cnJlbnRseSB3aXRoIG1vZHVsZSB1bmxvYWRpbmcuIFNvIHRha2UgdGhlIHRl
eHRfbXV0ZXggd2hpbGUgdGhlDQo+PiBtZW1vcnkgb2YgdGhlIG1vZHVsZSBpcyBmcmVlZC4NCj4g
DQo+IEF0IHRoYXQgcG9pbnQsIHNpbmNlIHRoZSBtb2R1bGUgaXRzZWxmIGlzIHJlbW92ZWQgZnJv
bSBtb2R1bGUgbGlzdCwNCj4gaXQgc2VlbXMgbm8gYWN0dWFsIGhhcm0uIE9yIHdvdWxkIHlvdSBo
YXZlIGFueSBjb25jZXJuPw0KDQpTbyBpdCBhcHBlYXJzIHRoYXQgeW91IGFyZSByaWdodCBhbmQg
YWxsIHRoZSB1c2VycyBvZiB0ZXh0X3Bva2UoKSBhbmQNCnRleHRfcG9rZV9icCgpIGRvIGluc3Rh
bGwgbW9kdWxlIG5vdGlmaWVycywgYW5kIHJlbW92ZSB0aGUgbW9kdWxlIGZyb20gdGhlaXINCmlu
dGVybmFsIGRhdGEgc3RydWN0dXJlIHdoZW4gdGhleSBhcmUgZG9uZSAoKikuIEFzIGxvbmcgYXMg
dGhleSBwcmV2ZW50DQp0ZXh0X3Bva2UqKCkgdG8gYmUgY2FsbGVkIGNvbmN1cnJlbnRseSAoZS5n
LiwgdXNpbmcganVtcF9sYWJlbF9sb2NrKCkpLA0KZXZlcnl0aGluZyBpcyBmaW5lLg0KDQpIYXZp
bmcgc2FpZCB0aGF0LCB0aGUgcXVlc3Rpb24gaXMgd2hldGhlciB5b3Ug4oCcdHJ1c3TigJ0gdGV4
dF9wb2tlKigpIHVzZXJzIHRvDQpkbyBzby4gdGV4dF9wb2tlKCkgZGVzY3JpcHRpb24gZG9lcyBu
b3QgZGF5IGV4cGxpY2l0bHkgdGhhdCB5b3UgbmVlZCB0bw0KcHJldmVudCBtb2R1bGVzIGZyb20g
YmVpbmcgcmVtb3ZlZC4NCg0KV2hhdCBkbyB5b3Ugc2F5Pw0KDQoNCigqKSBJIGFtIG5vdCBzdXJl
IGFib3V0IGtnZGIsIGJ1dCBpdCBwcm9iYWJseSBkb2VzIG5vdCBtYXR0ZXIgbXVjaA==

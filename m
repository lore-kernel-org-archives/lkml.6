Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1158C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669BE21470
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="TTig34IY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669BE21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJJXyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:54:43 -0400
Received: from mail-bl2nam02on0079.outbound.protection.outlook.com ([104.47.38.79]:61918
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726479AbeJJXym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMpRMr8nYee65Ta1S04tfNzAQLUvDdRTXz6eQO6kpdk=;
 b=TTig34IYFlrcoXV4j1azj9vphb9fTpM9h0JyRaRO+z1XR1SQCEOUnJj4NEVA4CYDOrXfUv5A8fr0T/gLq8s4LrURxOc2P2ar69Q6A1AHV0thv5la1xrerzs2H8jlchPUTp2HULUy0M9XFZFFQTVsQUQVOtULntMHI/FbVfedkno=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB3973.namprd05.prod.outlook.com (52.135.196.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Wed, 10 Oct 2018 16:31:41 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1228.020; Wed, 10 Oct 2018
 16:31:41 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Richard Biener <rguenther@suse.de>
CC:     Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>,
        "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Thread-Topic: PROPOSAL: Extend inline asm syntax with size spec
Thread-Index: AQHUXh6xHKcwa4kgSkWbM7cjy/hJdqUTxVgAgAAqLgCAAQYWAIAAGugAgAHy7QCAAa3AAA==
Date:   Wed, 10 Oct 2018 16:31:41 +0000
Message-ID: <5ACDEDEA-0E42-45F2-BC80-B96EC2ABC01D@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org>
 <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
 <20181008073128.GL29268@gate.crashing.org>
 <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org>
In-Reply-To: <20181009145330.GT29268@gate.crashing.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [70.164.121.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB3973;20:TUqtpKa+qkeoheeW2XYZJAGe+OzmhgLWUUWEBtBDQGJCLB6wL7m+5gbSlQUgHG/s0Vfq/2AQVlkeuJU7xAgfStzGPAeyQPaYBvstek+VjLldorVqawTdKF55fVwzB72/2iB327md/m1aR62FRKsHUeidiz/Es0kDbefD4kX5v70=
x-ms-office365-filtering-correlation-id: ff78a6b0-1b47-4c63-c4ff-08d62ecddc31
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB3973;
x-ms-traffictypediagnostic: BYAPR05MB3973:
x-microsoft-antispam-prvs: <BYAPR05MB3973D0A1AA3DE8CED9031923D0E00@BYAPR05MB3973.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR05MB3973;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB3973;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(6246003)(33656002)(86362001)(71190400001)(11346002)(486006)(4326008)(2616005)(446003)(26005)(6512007)(476003)(2906002)(39060400002)(106356001)(478600001)(14454004)(105586002)(102836004)(83716004)(71200400001)(82746002)(53936002)(68736007)(2900100001)(6486002)(7736002)(54906003)(110136005)(97736004)(99286004)(305945005)(316002)(36756003)(8676002)(3846002)(81156014)(256004)(81166006)(76176011)(229853002)(5660300001)(6506007)(7416002)(6436002)(66066001)(5250100002)(93886005)(186003)(8936002)(6116002)(25786009)(200143003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB3973;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XJlcQCVrRV1PSrAv+/3WCQMxvGGY9jPcqOjkNWWTnM8eKzlE+2iXR/dbBwtzL6HyIw5ZBxEWibIHlFFXzx2E3FNovfYGmvNF+U+KxCvUTSnP0xAigNTK4c2F1LEoJj0FDFCkFXOGFYFLV1I8fJMH66rRSEnia+53FYM+U1iIESg2F4G0yXhRaz+1taEDmdUJ7N+wZ+BTa10ml14/aWXL9A13TsCtnnfx6ePyafJIx02gttfp2XiBaNOWXcXp1D1mAbZe9Nm3GXQZvT9EBvNlOZOmPaIcfSL8Rs6AUoMEHuFF0tNJTMM5RuBSdx3mLhDeg58IKb3iHxEvPKYpqw2XlbGI1txNEsOEGTK/EU3BmYg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A119F1B1E5059458EBD0D02CC174E28@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff78a6b0-1b47-4c63-c4ff-08d62ecddc31
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 16:31:41.3373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3973
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgNzo1MyBBTSwgU2VnaGVyIEJvZXNzZW5rb29sIDxzZWdoZXJAa2VybmVsLmNyYXNoaW5nLm9y
Zz4gd3JvdGU6DQoNCj4gT24gTW9uLCBPY3QgMDgsIDIwMTggYXQgMTE6MDc6NDZBTSArMDIwMCwg
UmljaGFyZCBCaWVuZXIgd3JvdGU6DQo+PiBPbiBNb24sIDggT2N0IDIwMTgsIFNlZ2hlciBCb2Vz
c2Vua29vbCB3cm90ZToNCj4+PiBPbiBTdW4sIE9jdCAwNywgMjAxOCBhdCAwMzo1MzoyNlBNICsw
MDAwLCBNaWNoYWVsIE1hdHogd3JvdGU6DQo+Pj4+IE9uIFN1biwgNyBPY3QgMjAxOCwgU2VnaGVy
IEJvZXNzZW5rb29sIHdyb3RlOg0KPj4+Pj4gT24gU3VuLCBPY3QgMDcsIDIwMTggYXQgMTE6MTg6
MDZBTSArMDIwMCwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPj4+Pj4+IE5vdywgUmljaGFyZCBz
dWdnZXN0ZWQgZG9pbmcgc29tZXRoaW5nIGxpa2U6DQo+Pj4+Pj4gDQo+Pj4+Pj4gMSkgaW5saW5l
IGFzbSAoIi4uLiIpDQo+Pj4+PiANCj4+Pj4+IFdoYXQgd291bGQgdGhlIHNlbWFudGljcyBvZiB0
aGlzIGJlPw0KPj4+PiANCj4+Pj4gVGhlIHNpemUgb2YgdGhlIGlubGluZSBhc20gd291bGRuJ3Qg
YmUgY291bnRlZCB0b3dhcmRzIHRoZSBpbmxpbmVyIHNpemUgDQo+Pj4+IGxpbWl0cyAob3IgYmUg
Y291bnRlZCBhcyAiMSIpLg0KPj4+IA0KPj4+IFRoYXQgc291bmRzIGxpa2UgYSBnb29kIG9wdGlv
bi4NCj4+IA0KPj4gWWVzLCBJIGFsc28gbGlrZSBpdCBmb3Igc2ltcGxpY2l0eS4gIEl0IGFsc28g
YXZvaWRzIHRoZSByZXF1aXJlbWVudA0KPj4gb2YgdHJhbnNsYXRpbmcgdGhlIG51bWJlciAoaW4g
Ynl0ZXM/KSBnaXZlbiBieSB0aGUgdXNlciB0bw0KPj4gIm51bWJlciBvZiBHSU1QTEUgaW5zdHJ1
Y3Rpb25zIiBhcyBuZWVkZWQgYnkgdGhlIGlubGluZXIuDQo+IA0KPiBUaGlzIHBhdGNoIGltcGxl
bWVudHMgdGhpcywgZm9yIEMgb25seSBzbyBmYXIuICBBbmQgdGhlIHN5bnRheCBpcw0KPiAiYXNt
IGlubGluZSIsIHdoaWNoIGlzIG1vcmUgaW4gbGluZSB3aXRoIG90aGVyIHN5bnRheC4NCj4gDQo+
IEhvdyBkb2VzIHRoaXMgbG9vaz8NCg0KSXQgbG9va3MgZ29vZCB0byBtZSBpbiBnZW5lcmFsLiBJ
IGhhdmUgYSBjb3VwbGUgb2YgcmVzZXJ2YXRpb25zLCBidXQgSQ0Kc3VzcGVjdCB5b3Ugd2lsbCBu
b3Qgd2FudCB0byBhZGRyZXNzIHRoZW06DQoNCjEuIEl0IGlzIG5vdCBiYWNrd2FyZCBjb21wYXRp
YmxlLCByZXF1aXJpbmcgYSBDIG1hY3JvIHRvIHdyYXAgaXQsIGFzIHRoZSANCmtlcm5lbCBtaWdo
dCBiZSBidWlsdCB3aXRoIGRpZmZlcmVudCBjb21waWxlcnMuDQoNCjIuIEl0IGlzIHNwZWNpZmlj
IHRvIGFzbS4gSSBkbyBub3QgaGF2ZSBpbiBtaW5kIGFub3RoZXIgdXNlIGNhc2UgKGV4Y2x1ZGlu
Zw0KdGhlIF9fYnVpbHRpbl9jb25zdGFudF9wKSwgYnV0IGl0IHdvdWxkIGJlIG5pY2VyIElNSE8g
dG8gaGF2ZSBhIGJ1aWx0aW4NCnNheWluZyDigJxpZ25vcmUgdGhlIGNvc3Qgb2YgdGhpcyBzdGF0
ZW1lbnTigJ0gZm9yIHRoZSBtYXR0ZXIgb2Ygb3B0aW1pemF0aW9ucy4NCg0KUmVnYXJkcywNCk5h
ZGF2

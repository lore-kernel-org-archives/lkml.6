Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC687C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C85E2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="NL7mnTGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C85E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbeKFGxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:53:09 -0500
Received: from mail-eopbgr820085.outbound.protection.outlook.com ([40.107.82.85]:59312
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387441AbeKFGxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg93Ex0+DB+bNIV3MC0is1Vywpm51FQnHZgYfohQYMs=;
 b=NL7mnTGuHh+DXKI8XWlwcXRTBQ+ryFBm2xQFz2GIWQ3Ar+pGtcmm/RldVB2bkOE2IqgjQX0KQF+zJTcWgvkXRLtoSr0Brs8LssADxAotgflssdxrSIOOUNXWGRLbkfMaadErS6YMe23JWmL02HpjwtyHBV8GBEC2eAWhKFr2aTo=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5543.namprd05.prod.outlook.com (20.177.186.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.18; Mon, 5 Nov 2018 21:31:25 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 21:31:25 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during
 early_init
Thread-Topic: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during
 early_init
Thread-Index: AQHUcwQ37jX8+phTpkyCnxi097WrnaVBPEeAgAA19QCAAAeVAIAAFLiAgAAGBwCAAAtVgIAABkuAgAARkAA=
Date:   Mon, 5 Nov 2018 21:31:25 +0000
Message-ID: <5308A7F7-1C69-495D-A20B-C8B0A2470F8D@vmware.com>
References: <20181102232946.98461-1-namit@vmware.com>
 <20181102232946.98461-3-namit@vmware.com>
 <20181105140925.GD22467@hirez.programming.kicks-ass.net>
 <BB6FC627-C152-4C4C-A6D4-FA7F42F2610D@amacapital.net>
 <4D260352-A9FF-47F2-B3B2-0A87DF16CB70@vmware.com>
 <D67F7C19-DF59-4405-A5A3-B56C0E491B41@amacapital.net>
 <8DF7BED8-F1B2-4102-9452-46437D3E4FC6@vmware.com>
 <CALCETrXwci8L=53UTq8=LEs+5yPgdHnidFf6iz3wZ0SkZwd1Eg@mail.gmail.com>
 <alpine.DEB.2.21.1811052126310.1659@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1811052126310.1659@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5543;20:kJJWOJ+aHM3hKNSH62wzhaP3RjkCCmMKrb1y5cnj7LpMxJytYS29pZ7BLA9U5H813IUEfktqRXI/7zAvTgH9CGuWEvnVxi3epeTeVQB/E2zD79FY7F0rU+Wqf6YD5LA087cE1bBsftmFwU+WmNTHE2y3mhrZwrm17eOktEmD4tQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6caf4b45-03af-4ddb-38a6-08d6436609fb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5543;
x-ms-traffictypediagnostic: BYAPR05MB5543:
x-microsoft-antispam-prvs: <BYAPR05MB5543DE9BA0D962FE44418B29D0CA0@BYAPR05MB5543.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(9452136761055)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5543;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5543;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(189003)(199004)(229853002)(256004)(14444005)(8676002)(71200400001)(71190400001)(26005)(83716004)(81156014)(102836004)(81166006)(4326008)(2900100001)(53546011)(316002)(6436002)(8936002)(305945005)(6506007)(86362001)(6486002)(53936002)(97736004)(66066001)(6512007)(25786009)(76176011)(7416002)(6116002)(3846002)(68736007)(478600001)(14454004)(486006)(476003)(11346002)(2616005)(33656002)(99286004)(93886005)(5660300001)(6246003)(105586002)(446003)(186003)(36756003)(110136005)(54906003)(2906002)(7736002)(106356001)(82746002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5543;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Tqg/LRCd8vxqdamYRKf/w/B8G9LIjTv/JQ6EtwLPsA8F0cVMmzsiBeHTNZL/92UEA9jZSIp6jWafaMO/dldUcKiCj6yCy2+t/Pmb+JhEr0cW1rQJxSbxkwmUTKdZCja+4SFnGDynYT1YOZoWjH/zVUifRnfkya9w57koT0M/5MWUtPp0slh02ScHHGq1ezus01okh2fAhOrCLf3N+6werl2oLoYWpWRdjufBZbu8QF3/jKHXELv25Fvt5RDXAajg+7Z+ioCilvWfEkzqgDqhsDJPDT4S0YaDVnnM+ToTlBPs06xi08kfF634ghNERnh6zwTUGI8+OJ5gvcVBSDlKsO0b2JiW0BpbUNi9lVzch7w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCDAF80D58198B46B2686760BD9FBDD0@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6caf4b45-03af-4ddb-38a6-08d6436609fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 21:31:25.1707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5543
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGhvbWFzIEdsZWl4bmVyDQpTZW50OiBOb3ZlbWJlciA1LCAyMDE4IGF0IDg6Mjg6Mjkg
UE0gR01UDQo+IFRvOiBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1hY2FwaXRhbC5uZXQ+DQo+IENj
OiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiwgTGludXMgVG9ydmFsZHMgPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPiwgSC4gUGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+LCBQ
ZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+LCBJbmdvIE1vbG5hciA8bWluZ29A
cmVkaGF0LmNvbT4sIExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+LCBYODYgTUwg
PHg4NkBrZXJuZWwub3JnPiwgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+LCBEYXZlIEhh
bnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPiwgQW5kcmV3IEx1dG9taXJza2kgPGx1
dG9Aa2VybmVsLm9yZz4sIEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPiwgRGF2ZSBI
YW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT4sIE1hc2FtaSBIaXJhbWF0c3UgPG1oaXJhbWF0
QGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi83XSB4ODYvanVtcF9sYWJl
bDogVXNlIHRleHRfcG9rZV9lYXJseSgpIGR1cmluZyBlYXJseV9pbml0DQo+IA0KPiANCj4gT24g
TW9uLCA1IE5vdiAyMDE4LCBBbmR5IEx1dG9taXJza2kgd3JvdGU6DQo+PiBPbiBNb24sIE5vdiA1
LCAyMDE4IGF0IDExOjI1IEFNIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0K
Pj4gTGludXMsIGhwYSwgb3IgRGF2ZSwgYSBxdWVzdGlvbiBmb3IgeW91OiBzdXBwb3NlIEkgbWFw
IHNvbWUgcGFnZQ0KPj4gd3JpdGFibHksIHdyaXRlIHRvIGl0LCB0aGVuIHVwZ3JhZGUgcGVybWlz
c2lvbnMgdG8gYWxsb3cgZXhlY3V0ZS4NCj4+IE11c3QgSSBmb3JjZSBhbGwgQ1BVcyB0aGF0IG1p
Z2h0IGV4ZWN1dGUgZnJvbSBpdCB3aXRob3V0IGZpcnN0DQo+PiBzZXJpYWxpemluZyB0byBzZXJp
YWxpemU/ICBJIHN1c3BlY3QgdGhpcyBkb2Vzbid0IHJlYWxseSBhZmZlY3QgdXNlcg0KPj4gY29k
ZSwgYnV0IGl0IG1heSBhZmZlY3QgdGhlIG1vZHVsZSBsb2FkZXIuDQo+PiANCj4+IFRvIGJlIHNh
ZmUsIHNob3VsZG4ndCB0aGUgbW9kdWxlIGxvYWRlciBicm9hZGNhc3QgYW4gSVBJIHRvDQo+PiBz
eW5jX2NvcmUoKSBldmVyeXdoZXJlIGFmdGVyIGxvYWRpbmcgYSBtb2R1bGUgYW5kIGJlZm9yZSBt
YWtpbmcgaXQNCj4+IHJ1bm5hYmxlLCByZWdhcmRsZXNzIG9mIGFsdGVybmF0aXZlIHBhdGNoaW5n
Pw0KPj4gDQo+PiBJT1csIHRoZSByaWdodCBzZXF1ZW5jZSBvZiBldmVudHMgcHJvYmFibHkgb3Vn
aHQgdG8gbWU6DQo+PiANCj4+IDEuIEFsbG9jYXRlIHRoZSBtZW1vcnkgYW5kIG1hcCBpdC4NCj4+
IDIuIENvcHkgaW4gdGhlIHRleHQuDQo+PiAzLiBQYXRjaCBhbHRlcm5hdGl2ZXMsIGV0Yy4gIFRo
aXMgaXMgbG9naWNhbGx5IGp1c3QgbGlrZSAoMikgZnJvbSBhbg0KPj4gYXJjaGl0ZWN0dXJhbCBw
ZXJzcGVjdGl2ZSAtLSB3ZSdyZSBqdXN0IHdyaXRpbmcgdG8gbWVtb3J5IHRoYXQgd29uJ3QNCj4+
IGJlIGV4ZWN1dGVkLg0KPj4gNC4gU2VyaWFsaXplIGV2ZXJ5dGhpbmcuDQo+PiA1LiBSdW4gaXQh
DQo+IA0KPiBJJ2QgbWFrZSB0aGF0Og0KPiANCj4gMS4gQWxsb2NhdGUgdGhlIG1lbW9yeSBhbmQg
bWFwIGl0IFJXDQo+IDIuIENvcHkgaW4gdGhlIHRleHQuDQo+IDMuIFBhdGNoIGFsdGVybmF0aXZl
cywgZXRjLiAgVGhpcyBpcyBsb2dpY2FsbHkganVzdCBsaWtlICgyKSBmcm9tIGFuDQo+ICAgYXJj
aGl0ZWN0dXJhbCBwZXJzcGVjdGl2ZSAtLSB3ZSdyZSBqdXN0IHdyaXRpbmcgdG8gbWVtb3J5IHRo
YXQgd29uJ3QNCj4gICBiZSBleGVjdXRlZC4NCj4gNC4gTWFwIGl0IFJYDQo+IDUuIFNlcmlhbGl6
ZSBldmVyeXRoaW5nLg0KPiA2LiBSdW4gaXQhDQoNClRoYW5rcy4gSSB3aWxsIGRvIHNvbWV0aGlu
ZyBhbG9uZyB0aGVzZSBsaW5lcy4gVGhpcyBjYW4gaW1wcm92ZSBtb2R1bGUNCmxvYWRpbmcgdGlt
ZSAoc2F2aW5nIElSUSBzYXZlL3Jlc3RvcmUgdGltZSksIGJ1dCBpdCB3aWxsIG5vdCBtYWtlIHRo
aW5ncw0KbXVjaCBwcmV0dGllciwgc2luY2UgdHdvIGNvZGUtcGF0aHMgZm9yIOKAnGVhcmx5IGlu
aXQga2VybmVs4oCdIGFuZCDigJxlYXJseSBpbml0DQptb2R1bGXigJ0gd291bGQgYmUgbmVlZGVk
Lg0KDQo=

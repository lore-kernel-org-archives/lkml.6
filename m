Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187D5C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E9B2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 22:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="GVC34rZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfAaWT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 17:19:59 -0500
Received: from mail-eopbgr800078.outbound.protection.outlook.com ([40.107.80.78]:8963
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727017AbfAaWT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 17:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xhcPDEm9XH11JFoqpScCaZIpGIBgQlesNZ/FpLq3xc=;
 b=GVC34rZQQok7GYdSV1xF9CNAVa1Zp+vPhC/Pn/vsWG3m5394qKg+OvZ548UM/O1EHDe7jxnLcIRevZ8kcSfznA/QAdEEaQNYb+cBt8E845/u4hv6qb7Ny9uhsMDtt4WmJ/I27fWvB2bcg2ncedzw6dGTJM4k25TSsjrKwxkhC8E=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5607.namprd05.prod.outlook.com (20.177.186.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.11; Thu, 31 Jan 2019 22:19:54 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::99ab:18fb:f393:df31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::99ab:18fb:f393:df31%3]) with mapi id 15.20.1601.011; Thu, 31 Jan 2019
 22:19:54 +0000
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
Thread-Index: AQHUt2sRwAS+mFb6qECsCs685/9Pk6XJQbUAgAC1oAA=
Date:   Thu, 31 Jan 2019 22:19:54 +0000
Message-ID: <C481E605-E19A-4EA6-AB9A-6FF4229789E0@vmware.com>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
 <20190129003422.9328-4-rick.p.edgecombe@intel.com>
 <20190131112948.GE6749@zn.tnic>
In-Reply-To: <20190131112948.GE6749@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5607;20:swNDR/B2qvvRnmarNZPo+dmy9guaUeKVd6BVRJGTkAGjXBuhKCeF/IBO+2svj3i7djwXLsWa6JKy+Icf8lV88l/3vWGSTJKLo6tl8AxFYejTlzpSHhApmJL2pC2LLqlAhTGAoTMW34e8Y6qIupuPQfPzVBEDxb4vvqtCSRvvZ2s=
x-ms-office365-filtering-correlation-id: 7a0ffed3-a076-43d3-9c9c-08d687ca39f8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5607;
x-ms-traffictypediagnostic: BYAPR05MB5607:
x-microsoft-antispam-prvs: <BYAPR05MB5607390E1CD94F36C5A9B3C5D0910@BYAPR05MB5607.namprd05.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(136003)(376002)(199004)(189003)(2906002)(6506007)(305945005)(14444005)(186003)(106356001)(7736002)(68736007)(86362001)(6486002)(26005)(6436002)(81156014)(81166006)(76176011)(3846002)(6116002)(105586002)(83716004)(8936002)(71200400001)(256004)(33656002)(71190400001)(8676002)(66066001)(476003)(2616005)(36756003)(7416002)(4326008)(446003)(53546011)(316002)(97736004)(25786009)(14454004)(486006)(229853002)(11346002)(6512007)(6246003)(99286004)(478600001)(53936002)(54906003)(82746002)(102836004)(6916009)(39060400002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5607;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FsYYe0WQx9UYLNBYqsAeZMsTb/0a6+eeXdMx3NCMdxdkLC1qZp8QFZhvY/hDKPXXHPDxAt7MquKQLWulRSW7Raws1mCoA8HQewwdXHXPgyrk4S5hm0+lhaizi8QNl/G+Qqlv1BTr7jnn3K0QMCKHJusSJDEEBz97Y5NzKMoVRAAKmIzlI8CN2u6HH9SwxL6Oa3AunhVmed4KWOLMgmqxuq4j8SE+U9UTZjWbUyY9ZdjbYUSZBLG/7a7aoVZc2QhGEStGlQ3mbR3Yj+0JqQFY/reWQfmnCCOOkNpadQ8Ng8E5PkYpCsLICIMkSTAffdBAol6C0vSL6N2A9QkHtNtpiMTcUhFfE+NvQgH86MasIJyzzO/YD7aT0JofJxV/Q8/JHCnND/csAJbEz310M9bcgn3Pc8dGYdmQtM538F9/Nug=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E36E561B8F45B4D9E79C3CB31566DB3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0ffed3-a076-43d3-9c9c-08d687ca39f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 22:19:54.1999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5607
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gMzEsIDIwMTksIGF0IDM6MjkgQU0sIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44
LmRlPiB3cm90ZToNCj4gDQo+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAzLzIwXSB4ODYvbW06
IHRlbXBvcmFyeSBtbSBzdHJ1Y3QNCj4gDQo+IFN1YmplY3QgbmVlZHMgYSB2ZXJiOiAiQWRkIGEg
dGVtcG9yYXJ5Li4uICINCj4gDQo+IE9uIE1vbiwgSmFuIDI4LCAyMDE5IGF0IDA0OjM0OjA1UE0g
LTA4MDAsIFJpY2sgRWRnZWNvbWJlIHdyb3RlOg0KPj4gRnJvbTogQW5keSBMdXRvbWlyc2tpIDxs
dXRvQGtlcm5lbC5vcmc+DQo+PiANCj4+IFNvbWV0aW1lcyB3ZSB3YW50IHRvIHNldCBhIHRlbXBv
cmFyeSBwYWdlLXRhYmxlIGVudHJpZXMgKFBURXMpIGluIG9uZSBvZg0KPiANCj4gcy9hIC8vDQo+
IA0KPiBBbHNvLCBkcm9wIHRoZSAid2UiIGFuZCBtYWtlIGl0IGltcGFydGlhbCBhbmQgcGFzc2l2
ZToNCj4gDQo+ICJEZXNjcmliZSB5b3VyIGNoYW5nZXMgaW4gaW1wZXJhdGl2ZSBtb29kLCBlLmcu
ICJtYWtlIHh5enp5IGRvIGZyb3R6Ig0KPiAgaW5zdGVhZCBvZiAiW1RoaXMgcGF0Y2hdIG1ha2Vz
IHh5enp5IGRvIGZyb3R6IiBvciAiW0ldIGNoYW5nZWQgeHl6enkNCj4gIHRvIGRvIGZyb3R6Iiwg
YXMgaWYgeW91IGFyZSBnaXZpbmcgb3JkZXJzIHRvIHRoZSBjb2RlYmFzZSB0byBjaGFuZ2UNCj4g
IGl0cyBiZWhhdmlvdXIuIg0KPiANCj4+IHRoZSBjb3Jlcywgd2l0aG91dCBhbGxvd2luZyBvdGhl
ciBjb3JlcyB0byB1c2UgLSBldmVuIHNwZWN1bGF0aXZlbHkgLQ0KPj4gdGhlc2UgbWFwcGluZ3Mu
IFRoZXJlIGFyZSB0d28gYmVuZWZpdHMgZm9yIGRvaW5nIHNvOg0KPj4gDQo+PiAoMSkgU2VjdXJp
dHk6IGlmIHNlbnNpdGl2ZSBQVEVzIGFyZSBzZXQsIHRlbXBvcmFyeSBtbSBwcmV2ZW50cyB0aGVp
ciB1c2UNCj4+IGluIG90aGVyIGNvcmVzLiBUaGlzIGhhcmRlbnMgdGhlIHNlY3VyaXR5IGFzIGl0
IHByZXZlbnRzIGV4cGxvZGluZyBhDQo+IA0KPiBleHBsb2Rpbmcgb3IgZXhwbG9pdGluZz8gT3Ig
ZXhwb3Npbmc/IDopDQo+IA0KPj4gZGFuZ2xpbmcgcG9pbnRlciB0byBvdmVyd3JpdGUgc2Vuc2l0
aXZlIGRhdGEgdXNpbmcgdGhlIHNlbnNpdGl2ZSBQVEUuDQo+PiANCj4+ICgyKSBBdm9pZGluZyBU
TEIgc2hvb3Rkb3duczogdGhlIFBURXMgZG8gbm90IG5lZWQgdG8gYmUgZmx1c2hlZCBpbg0KPj4g
cmVtb3RlIHBhZ2UtdGFibGVzLg0KPiANCj4gVGhvc2UgYmVsb25nIGluIHRoZSBjb2RlIGNvbW1l
bnRzIGJlbG93LCBleHBsYWluaW5nIHdoYXQgaXQgaXMgZ29pbmcgdG8NCj4gYmUgdXNlZCBmb3Iu
DQoNCkkgd2lsbCBhZGQgaXQgdG8gdGhlIGNvZGUgYXMgd2VsbC4NCg0KPiANCj4+IFRvIGRvIHNv
IGEgdGVtcG9yYXJ5IG1tX3N0cnVjdCBjYW4gYmUgdXNlZC4gTWFwcGluZ3Mgd2hpY2ggYXJlIHBy
aXZhdGUNCj4+IGZvciB0aGlzIG1tIGNhbiBiZSBzZXQgaW4gdGhlIHVzZXJzcGFjZSBwYXJ0IG9m
IHRoZSBhZGRyZXNzLXNwYWNlLg0KPj4gRHVyaW5nIHRoZSB3aG9sZSB0aW1lIGluIHdoaWNoIHRo
ZSB0ZW1wb3JhcnkgbW0gaXMgbG9hZGVkLCBpbnRlcnJ1cHRzDQo+PiBtdXN0IGJlIGRpc2FibGVk
Lg0KPj4gDQo+PiBUaGUgZmlyc3QgdXNlLWNhc2UgZm9yIHRlbXBvcmFyeSBQVEVzLCB3aGljaCB3
aWxsIGZvbGxvdywgaXMgZm9yIHBva2luZw0KPj4gdGhlIGtlcm5lbCB0ZXh0Lg0KPj4gDQo+PiBb
IENvbW1pdCBtZXNzYWdlIHdhcyB3cml0dGVuIGJ5IE5hZGF2IF0NCj4+IA0KPj4gQ2M6IEtlZXMg
Q29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPj4gQ2M6IERhdmUgSGFuc2VuIDxkYXZlLmhh
bnNlbkBpbnRlbC5jb20+DQo+PiBBY2tlZC1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0
ZXJ6QGluZnJhZGVhZC5vcmc+DQo+PiBSZXZpZXdlZC1ieTogTWFzYW1pIEhpcmFtYXRzdSA8bWhp
cmFtYXRAa2VybmVsLm9yZz4NCj4+IFRlc3RlZC1ieTogTWFzYW1pIEhpcmFtYXRzdSA8bWhpcmFt
YXRAa2VybmVsLm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IEFuZHkgTHV0b21pcnNraSA8bHV0b0Br
ZXJuZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNv
bT4NCj4+IFNpZ25lZC1vZmYtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGlu
dGVsLmNvbT4NCj4+IC0tLQ0KPj4gYXJjaC94ODYvaW5jbHVkZS9hc20vbW11X2NvbnRleHQuaCB8
IDMyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gMSBmaWxlIGNoYW5nZWQsIDMy
IGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNt
L21tdV9jb250ZXh0LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tbXVfY29udGV4dC5oDQo+PiBp
bmRleCAxOWQxOGZhZTZlYzYuLmNkMGMyOWU0OTRhNiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL21tdV9jb250ZXh0LmgNCj4+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNt
L21tdV9jb250ZXh0LmgNCj4+IEBAIC0zNTYsNCArMzU2LDM2IEBAIHN0YXRpYyBpbmxpbmUgdW5z
aWduZWQgbG9uZyBfX2dldF9jdXJyZW50X2NyM19mYXN0KHZvaWQpDQo+PiAJcmV0dXJuIGNyMzsN
Cj4+IH0NCj4+IA0KPj4gK3R5cGVkZWYgc3RydWN0IHsNCj4gDQo+IFdoeSBkb2VzIGl0IGhhdmUg
dG8gYmUgYSB0eXBlZGVmPw0KDQpIYXZpbmcgYSBkaWZmZXJlbnQgc3RydWN0IGNhbiBwcmV2ZW50
IHRoZSBtaXN1c2Ugb2YgdXNpbmcgbW1fc3RydWN0cyBpbg0KdW51c2VfdGVtcG9yYXJ5X21tKCkg
dGhhdCB3ZXJlIG5vdCDigJx1c2Vk4oCdIHVzaW5nIHVzZV90ZW1wb3JhcnlfbW0uIFRoZQ0KdHlw
ZWRlZiwgSSBwcmVzdW1lLCBjYW4gZGV0ZXIgdXNlcnMgZnJvbSBzdGFydGluZyB0byBwbGF5IHdp
dGggdGhlIGludGVybmFsDQrigJxwcml2YXRl4oCdIGZpZWxkcy4NCg0KPiBUaGF0IHByZXYucHJl
diBiZWxvdyBsb29rcyB1bm5lY2Vzc2FyeSwgaW5zdGVhZCBvZiBqdXN0IHVzaW5nIHByZXYuDQo+
IA0KPj4gKwlzdHJ1Y3QgbW1fc3RydWN0ICpwcmV2Ow0KPiANCj4gV2h5ICJwcmV24oCdPw0KDQpU
aGlzIGlzIG9idmlvdXNseSB0aGUgcHJldmlvdXMgYWN0aXZlIG1tLiBGZWVsIGZyZWUgdG8gc3Vn
Z2VzdCBhbg0KYWx0ZXJuYXRpdmUgbmFtZS4NCg0KPj4gK30gdGVtcG9yYXJ5X21tX3N0YXRlX3Q7
DQo+IA0KPiBUaGF0J3Mga2luZGEgbG9uZyAtIGl0IGlzIGxvbmdlciB0aGFuIHRoZSBmdW5jdGlv
biBuYW1lIGJlbG93Lg0KPiB0ZW1wX21tX3N0YXRlX3Qgbm90IGVub3VnaD8NCg0KSSB3aWxsIGNo
YW5nZSBpdC4NCg0KPiANCj4+ICsNCj4+ICsvKg0KPj4gKyAqIFVzaW5nIGEgdGVtcG9yYXJ5IG1t
IGFsbG93cyB0byBzZXQgdGVtcG9yYXJ5IG1hcHBpbmdzIHRoYXQgYXJlIG5vdCBhY2Nlc3NpYmxl
DQo+PiArICogYnkgb3RoZXIgY29yZXMuIFN1Y2ggbWFwcGluZ3MgYXJlIG5lZWRlZCB0byBwZXJm
b3JtIHNlbnNpdGl2ZSBtZW1vcnkgd3JpdGVzDQo+PiArICogdGhhdCBvdmVycmlkZSB0aGUga2Vy
bmVsIG1lbW9yeSBwcm90ZWN0aW9ucyAoZS5nLiwgV15YKSwgd2l0aG91dCBleHBvc2luZyB0aGUN
Cj4+ICsgKiB0ZW1wb3JhcnkgcGFnZS10YWJsZSBtYXBwaW5ncyB0aGF0IGFyZSByZXF1aXJlZCBm
b3IgdGhlc2Ugd3JpdGUgb3BlcmF0aW9ucyB0bw0KPj4gKyAqIG90aGVyIGNvcmVzLg0KPj4gKyAq
DQo+PiArICogQ29udGV4dDogVGhlIHRlbXBvcmFyeSBtbSBuZWVkcyB0byBiZSB1c2VkIGV4Y2x1
c2l2ZWx5IGJ5IGEgc2luZ2xlIGNvcmUuIFRvDQo+PiArICogICAgICAgICAgaGFyZGVuIHNlY3Vy
aXR5IElSUXMgbXVzdCBiZSBkaXNhYmxlZCB3aGlsZSB0aGUgdGVtcG9yYXJ5IG1tIGlzDQo+IAkJ
CSAgICAgIF4NCj4gCQkJICAgICAgLA0KPiANCj4+ICsgKiAgICAgICAgICBsb2FkZWQsIHRoZXJl
YnkgcHJldmVudGluZyBpbnRlcnJ1cHQgaGFuZGxlciBidWdzIGZyb20gb3ZlcnJpZGUgdGhlDQo+
IA0KPiBzL292ZXJyaWRlL292ZXJyaWRpbmcvDQoNCkkgd2lsbCBmaXggYWxsIG9mIHRoZXNlIHR5
cG9zLCBjb21tZW50LiBUaGFuayB5b3UuDQoNCk1ldGEtcXVlc3Rpb246IGNvdWxkIHlvdSBwbGVh
c2UgcmV2aWV3IHRoZSBlbnRpcmUgcGF0Y2gtc2V0PyBUaGlzIGlzDQphY3R1YWxseSB2OSBvZiB0
aGlzIHBhcnRpY3VsYXIgcGF0Y2ggLSBpdCB3YXMgcGFydCBvZiBhIHNlcGFyYXRlIHBhdGNoLXNl
dA0KYmVmb3JlLiBJIGRvbuKAmXQgdGhpbmsgdGhhdCB0aGUgcGF0Y2ggaGFzIGNoYW5nZWQgc2lu
Y2UgKHRoZSByZWFsKSB2MS4NCg0KVGhlc2Ugc3BvcmFkaWMgY29tbWVudHMgYWZ0ZXIgZWFjaCB2
ZXJzaW9uIHJlYWxseSBtYWtlcyBpdCBoYXJkIHRvIGdldCB0aGlzDQp3b3JrIGNvbXBsZXRlZC4N
Cg0K

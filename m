Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB04C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E60205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="oFTsDbHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E60205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeK2GCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:02:14 -0500
Received: from mail-eopbgr690081.outbound.protection.outlook.com ([40.107.69.81]:6500
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbeK2GCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGBiUkUYKCjbbYp+TbXGs6eYYyfjFELiywZN38Eq42M=;
 b=oFTsDbHb7RKxmI74jCysc1fzwx5rSuKdqSLD7UHEJ6XICVqq+ltcrCwR0Agxvanweju6MtTUDbhjgRpOcpu6J/PRL6tnMJ0FEc5TZwTOeJU+ZMMN60kxAsYh/ExS/mHWuQeEQIo0ab6Dn4hnIH/OvIv1dEvXN9MvxRdhnTDwo1E=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4551.namprd05.prod.outlook.com (52.135.203.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.6; Wed, 28 Nov 2018 18:59:30 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1404.008; Wed, 28 Nov 2018
 18:59:30 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v6 08/10] x86: avoid W^X being broken during modules
 loading
Thread-Topic: [PATCH v6 08/10] x86: avoid W^X being broken during modules
 loading
Thread-Index: AQHUgU3Jak0nJrvZ8UiI0kq+gfoHPaVllFEA
Date:   Wed, 28 Nov 2018 18:59:30 +0000
Message-ID: <5E938E6F-6BE6-4F86-AC9E-5C389B492682@vmware.com>
References: <20181120203545.34928-1-namit@vmware.com>
 <20181120203545.34928-9-namit@vmware.com>
In-Reply-To: <20181120203545.34928-9-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4551;20:KhWcZ+4k5c9HH2DBYL9f0vrvlXHoeZ7KkcxN1mSA+JP2Ws/WMlVvvzlfWx9+5RiiYqoliXr03dYOVJYmmQBjXXGAVumQvDrusHsf2Mvmh96xe67kOULkgboecTReWsD49Lr2eALiaJ0Pzg1priu8CtZmyLfXGAP104/7P/iZ2Bc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 53d88a48-dd5d-42de-37e2-08d65563a0a6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4551;
x-ms-traffictypediagnostic: BYAPR05MB4551:
x-microsoft-antispam-prvs: <BYAPR05MB45519C6B0ABB1D3C7F10A288D0D10@BYAPR05MB4551.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231443)(999002)(944501410)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4551;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4551;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(39860400002)(396003)(189003)(199004)(68736007)(36756003)(102836004)(186003)(39060400002)(4326008)(53936002)(6246003)(229853002)(6436002)(6486002)(7416002)(105586002)(106356001)(256004)(5660300001)(14444005)(3846002)(305945005)(66066001)(7736002)(2906002)(6116002)(83716004)(486006)(2616005)(446003)(6512007)(11346002)(82746002)(71200400001)(8936002)(76176011)(54906003)(6506007)(53546011)(110136005)(81156014)(81166006)(478600001)(26005)(476003)(33656002)(8676002)(86362001)(316002)(97736004)(99286004)(25786009)(14454004)(71190400001)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4551;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FwRox0dUp9eInxxSzSuKe3yfGGLCmKzOorsSi27ujMyUr0rRdrGjESPsj+qEXNn6Pix6uh0WNJNptQ4H+MMs6uRtE/kTn/CtYd2RjPOsJOhV4aD1yK257jVo70BwhdE1rO4bLS5cax1QWY3bTQ5058oVIBIZBsWLmrZ44lrJSmAby6ovC0W41ZAA3ojVo4WLPiOoJYvJdqGPDYGs857c8f04E2632PcIf7WSYQtIEhHTSzI7o7LHepX2SvWXcuQ5q6qrbDy7BD4nXKMwk4eWaubXwj54P9YofGBU7tt9ZucDhRFnxeLCSkDg6oj73Z0JlIfzb2dEBtB8nqrDZl9leI0YAQa6KOhV2t+lxeFSqa8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DA3641194AD9C4F94454E6E00EA055C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d88a48-dd5d-42de-37e2-08d65563a0a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 18:59:30.3604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBOb3YgMjAsIDIwMTgsIGF0IDEyOjM1IFBNLCBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUu
Y29tPiB3cm90ZToNCj4gDQo+IFdoZW4gbW9kdWxlcyBhbmQgQlBGIGZpbHRlcnMgYXJlIGxvYWRl
ZCwgdGhlcmUgaXMgYSB0aW1lIHdpbmRvdyBpbg0KPiB3aGljaCBzb21lIG1lbW9yeSBpcyBib3Ro
IHdyaXRhYmxlIGFuZCBleGVjdXRhYmxlLiBBbiBhdHRhY2tlciB0aGF0IGhhcw0KPiBhbHJlYWR5
IGZvdW5kIGFub3RoZXIgdnVsbmVyYWJpbGl0eSAoZS5nLiwgYSBkYW5nbGluZyBwb2ludGVyKSBt
aWdodCBiZQ0KPiBhYmxlIHRvIGV4cGxvaXQgdGhpcyBiZWhhdmlvciB0byBvdmVyd3JpdGUga2Vy
bmVsIGNvZGUuIFRoaXMgcGF0Y2gNCj4gcHJldmVudHMgaGF2aW5nIHdyaXRhYmxlIGV4ZWN1dGFi
bGUgUFRFcyBpbiB0aGlzIHN0YWdlLg0KPiANCj4gSW4gYWRkaXRpb24sIGF2b2lkaW5nIGhhdmlu
ZyBSK1ggbWFwcGluZ3MgY2FuIGFsc28gc2xpZ2h0bHkgc2ltcGxpZnkgdGhlDQo+IHBhdGNoaW5n
IG9mIG1vZHVsZXMgY29kZSBvbiBpbml0aWFsaXphdGlvbiAoZS5nLiwgYnkgYWx0ZXJuYXRpdmVz
IGFuZA0KPiBzdGF0aWMta2V5KSwgYXMgd291bGQgYmUgZG9uZSBpbiB0aGUgbmV4dCBwYXRjaC4N
Cj4gDQo+IFRvIGF2b2lkIGhhdmluZyBXK1ggbWFwcGluZ3MsIHNldCB0aGVtIGluaXRpYWxseSBh
cyBSVyAoTlgpIGFuZCBhZnRlcg0KPiB0aGV5IGFyZSBzZXQgYXMgUk8gc2V0IHRoZW0gYXMgWCBh
cyB3ZWxsLiBTZXR0aW5nIHRoZW0gYXMgZXhlY3V0YWJsZSBpcw0KPiBkb25lIGFzIGEgc2VwYXJh
dGUgc3RlcCB0byBhdm9pZCBvbmUgY29yZSBpbiB3aGljaCB0aGUgb2xkIFBURSBpcyBjYWNoZWQN
Cj4gKGhlbmNlIHdyaXRhYmxlKSwgYW5kIGFub3RoZXIgd2hpY2ggc2VlcyB0aGUgdXBkYXRlZCBQ
VEUgKGV4ZWN1dGFibGUpLA0KPiB3aGljaCB3b3VsZCBicmVhayB0aGUgV15YIHByb3RlY3Rpb24u
DQo+IA0KPiBDYzogQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+DQo+IENjOiBLZWVz
IENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4NCj4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRl
cnpAaW5mcmFkZWFkLm9yZz4NCj4gQ2M6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5j
b20+DQo+IENjOiBNYXNhbWkgSGlyYW1hdHN1IDxtaGlyYW1hdEBrZXJuZWwub3JnPg0KPiBTdWdn
ZXN0ZWQtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiBTdWdnZXN0
ZWQtYnk6IEFuZHkgTHV0b21pcnNraSA8bHV0b0BhbWFjYXBpdGFsLm5ldD4NCj4gU2lnbmVkLW9m
Zi1ieTogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4NCj4gLS0tDQo+IGFyY2gveDg2L2tl
cm5lbC9hbHRlcm5hdGl2ZS5jIHwgMjggKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiBh
cmNoL3g4Ni9rZXJuZWwvbW9kdWxlLmMgICAgICB8ICAyICstDQo+IGluY2x1ZGUvbGludXgvZmls
dGVyLmggICAgICAgIHwgIDYgKysrKysrDQo+IGtlcm5lbC9tb2R1bGUuYyAgICAgICAgICAgICAg
IHwgMTAgKysrKysrKysrKw0KPiA0IGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2FsdGVybmF0
aXZlLmMgYi9hcmNoL3g4Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYw0KPiBpbmRleCA4ZmM0Njg1ZjMx
MTcuLjE4NDE1ZTNiNjAwMCAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2FsdGVybmF0
aXZlLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMNCj4gQEAgLTY2Nywx
NSArNjY3LDI5IEBAIHZvaWQgX19pbml0IGFsdGVybmF0aXZlX2luc3RydWN0aW9ucyh2b2lkKQ0K
PiAgKiBoYW5kbGVycyBzZWVpbmcgYW4gaW5jb25zaXN0ZW50IGluc3RydWN0aW9uIHdoaWxlIHlv
dSBwYXRjaC4NCj4gICovDQo+IHZvaWQgKl9faW5pdF9vcl9tb2R1bGUgdGV4dF9wb2tlX2Vhcmx5
KHZvaWQgKmFkZHIsIGNvbnN0IHZvaWQgKm9wY29kZSwNCj4gLQkJCQkJICAgICAgc2l6ZV90IGxl
bikNCj4gKwkJCQkgICAgICAgc2l6ZV90IGxlbikNCj4gew0KPiAJdW5zaWduZWQgbG9uZyBmbGFn
czsNCj4gLQlsb2NhbF9pcnFfc2F2ZShmbGFncyk7DQo+IC0JbWVtY3B5KGFkZHIsIG9wY29kZSwg
bGVuKTsNCj4gLQlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7DQo+IC0Jc3luY19jb3JlKCk7DQo+
IC0JLyogQ291bGQgYWxzbyBkbyBhIENMRkxVU0ggaGVyZSB0byBzcGVlZCB1cCBDUFUgcmVjb3Zl
cnk7IGJ1dA0KPiAtCSAgIHRoYXQgY2F1c2VzIGhhbmdzIG9uIHNvbWUgVklBIENQVXMuICovDQo+
ICsNCj4gKwlpZiAoc3RhdGljX2NwdV9oYXMoWDg2X0ZFQVRVUkVfTlgpICYmDQo+ICsJICAgIGlz
X21vZHVsZV90ZXh0X2FkZHJlc3MoKHVuc2lnbmVkIGxvbmcpYWRkcikpIHsNCj4gKwkJLyoNCj4g
KwkJICogTW9kdWxlcyB0ZXh0IGlzIG1hcmtlZCBpbml0aWFsbHkgYXMgbm9uLWV4ZWN1dGFibGUs
IHNvIHRoZQ0KPiArCQkgKiBjb2RlIGNhbm5vdCBiZSBydW5uaW5nIGFuZCBzcGVjdWxhdGl2ZSBj
b2RlLWZldGNoZXMgYXJlDQo+ICsJCSAqIHByZXZlbnRlZC4gV2UgY2FuIGp1c3QgY2hhbmdlIHRo
ZSBjb2RlLg0KPiArCQkgKi8NCj4gKwkJbWVtY3B5KGFkZHIsIG9wY29kZSwgbGVuKTsNCj4gKwl9
IGVsc2Ugew0KPiArCQlsb2NhbF9pcnFfc2F2ZShmbGFncyk7DQo+ICsJCW1lbWNweShhZGRyLCBv
cGNvZGUsIGxlbik7DQo+ICsJCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCj4gKwkJc3luY19j
b3JlKCk7DQo+ICsNCj4gKwkJLyoNCj4gKwkJICogQ291bGQgYWxzbyBkbyBhIENMRkxVU0ggaGVy
ZSB0byBzcGVlZCB1cCBDUFUgcmVjb3Zlcnk7IGJ1dA0KPiArCQkgKiB0aGF0IGNhdXNlcyBoYW5n
cyBvbiBzb21lIFZJQSBDUFVzLg0KPiArCQkgKi8NCj4gKwl9DQo+IAlyZXR1cm4gYWRkcjsNCj4g
fQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9tb2R1bGUuYyBiL2FyY2gveDg2
L2tlcm5lbC9tb2R1bGUuYw0KPiBpbmRleCBiMDUyZTg4M2RkOGMuLmNmYTMxMDZmYWVlNCAxMDA2
NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL21vZHVsZS5jDQo+ICsrKyBiL2FyY2gveDg2L2tl
cm5lbC9tb2R1bGUuYw0KPiBAQCAtODcsNyArODcsNyBAQCB2b2lkICptb2R1bGVfYWxsb2ModW5z
aWduZWQgbG9uZyBzaXplKQ0KPiAJcCA9IF9fdm1hbGxvY19ub2RlX3JhbmdlKHNpemUsIE1PRFVM
RV9BTElHTiwNCj4gCQkJCSAgICBNT0RVTEVTX1ZBRERSICsgZ2V0X21vZHVsZV9sb2FkX29mZnNl
dCgpLA0KPiAJCQkJICAgIE1PRFVMRVNfRU5ELCBHRlBfS0VSTkVMLA0KPiAtCQkJCSAgICBQQUdF
X0tFUk5FTF9FWEVDLCAwLCBOVU1BX05PX05PREUsDQo+ICsJCQkJICAgIFBBR0VfS0VSTkVMLCAw
LCBOVU1BX05PX05PREUsDQo+IAkJCQkgICAgX19idWlsdGluX3JldHVybl9hZGRyZXNzKDApKTsN
Cj4gCWlmIChwICYmIChrYXNhbl9tb2R1bGVfYWxsb2MocCwgc2l6ZSkgPCAwKSkgew0KPiAJCXZm
cmVlKHApOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9maWx0ZXIuaCBiL2luY2x1ZGUv
bGludXgvZmlsdGVyLmgNCj4gaW5kZXggZGU2MjliNzA2ZDFkLi5lZTlhZTAzYzVmNTYgMTAwNjQ0
DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvZmlsdGVyLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9m
aWx0ZXIuaA0KPiBAQCAtNzA0LDcgKzcwNCwxMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYnBmX3By
b2dfdW5sb2NrX3JvKHN0cnVjdCBicGZfcHJvZyAqZnApDQo+IA0KPiBzdGF0aWMgaW5saW5lIHZv
aWQgYnBmX2ppdF9iaW5hcnlfbG9ja19ybyhzdHJ1Y3QgYnBmX2JpbmFyeV9oZWFkZXIgKmhkcikN
Cj4gew0KPiArCS8qDQo+ICsJICogUGVyZm9ybSBtYXBwaW5nIGNoYW5nZXMgaW4gdHdvIHN0YWdl
cyB0byBhdm9pZCBvcGVuaW5nIGEgdGltZS13aW5kb3cNCj4gKwkgKiBpbiB3aGljaCBhIFBURSBp
cyBjYWNoZWQgaW4gYW55IFRMQiBhcyB3cml0YWJsZSwgYnV0IG1hcmtlZCBhcw0KPiArCSAqIGV4
ZWN1dGFibGUgaW4gdGhlIG1lbW9yeS1yZXNpZGVudCBtYXBwaW5ncyAoZS5nLiwgcGFnZS10YWJs
ZXMpLg0KPiArCSAqLw0KPiAJc2V0X21lbW9yeV9ybygodW5zaWduZWQgbG9uZyloZHIsIGhkci0+
cGFnZXMpOw0KPiArCXNldF9tZW1vcnlfeCgodW5zaWduZWQgbG9uZyloZHIsIGhkci0+cGFnZXMp
Ow0KPiB9DQo+IA0KPiBzdGF0aWMgaW5saW5lIHZvaWQgYnBmX2ppdF9iaW5hcnlfdW5sb2NrX3Jv
KHN0cnVjdCBicGZfYmluYXJ5X2hlYWRlciAqaGRyKQ0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL21v
ZHVsZS5jIGIva2VybmVsL21vZHVsZS5jDQo+IGluZGV4IDQ5YTQwNTg5MTU4Ny4uN2NiMjA3MjQ5
NDM3IDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvbW9kdWxlLmMNCj4gKysrIGIva2VybmVsL21vZHVs
ZS5jDQo+IEBAIC0xOTQ2LDkgKzE5NDYsMTkgQEAgdm9pZCBtb2R1bGVfZW5hYmxlX3JvKGNvbnN0
IHN0cnVjdCBtb2R1bGUgKm1vZCwgYm9vbCBhZnRlcl9pbml0KQ0KPiAJaWYgKCFyb2RhdGFfZW5h
YmxlZCkNCj4gCQlyZXR1cm47DQo+IA0KPiArCS8qDQo+ICsJICogUGVyZm9ybSBtYXBwaW5nIGNo
YW5nZXMgaW4gdHdvIHN0YWdlcyB0byBhdm9pZCBvcGVuaW5nIGEgdGltZS13aW5kb3cNCj4gKwkg
KiBpbiB3aGljaCBhIFBURSBpcyBjYWNoZWQgaW4gYW55IFRMQiBhcyB3cml0YWJsZSwgYnV0IG1h
cmtlZCBhcw0KPiArCSAqIGV4ZWN1dGFibGUgaW4gdGhlIG1lbW9yeS1yZXNpZGVudCBtYXBwaW5n
cyAoZS5nLiwgcGFnZS10YWJsZXMpLg0KPiArCSAqLw0KPiAJZnJvYl90ZXh0KCZtb2QtPmNvcmVf
bGF5b3V0LCBzZXRfbWVtb3J5X3JvKTsNCj4gKwlmcm9iX3RleHQoJm1vZC0+Y29yZV9sYXlvdXQs
IHNldF9tZW1vcnlfeCk7DQo+ICsNCj4gCWZyb2Jfcm9kYXRhKCZtb2QtPmNvcmVfbGF5b3V0LCBz
ZXRfbWVtb3J5X3JvKTsNCj4gKw0KPiAJZnJvYl90ZXh0KCZtb2QtPmluaXRfbGF5b3V0LCBzZXRf
bWVtb3J5X3JvKTsNCj4gKwlmcm9iX3RleHQoJm1vZC0+aW5pdF9sYXlvdXQsIHNldF9tZW1vcnlf
eCk7DQo+ICsNCj4gCWZyb2Jfcm9kYXRhKCZtb2QtPmluaXRfbGF5b3V0LCBzZXRfbWVtb3J5X3Jv
KTsNCj4gDQo+IAlpZiAoYWZ0ZXJfaW5pdCkNCj4gLS0gDQo+IDIuMTcuMQ0KDQpSaWNrIHBvaW50
ZWQgb3V0IHRoYXQgSSBzY3Jld2VkIHVwIGZ0cmFjZSBhbmQga3Byb2Jlcy4NCg0KRm9yIGtwcm9i
ZXMsIEkgdGhpbmsgSSBuZWVkIHRvIGFkZCBzZXRfbWVtb3J5X3goKSB0byBhbGxvY19pbnNuX3Bh
Z2UoKSBhbmQNCmNoYW5nZSBhcmNoX2Z0cmFjZV91cGRhdGVfdHJhbXBvbGluZSgpLg0KDQpGb3Ig
YXJjaF9mdHJhY2VfdXBkYXRlX3RyYW1wb2xpbmUoKSwgSSB0aGluayBJIHNob3VsZCByZW1vdmUg
bm90IHVzZQ0Kc2V0X21lbW9yeV9ydygpIHdoZW4gcGF0Y2hpbmcgaW4gX19wcm9iZV9rZXJuZWxf
d3JpdGUoKSBzaG91bGQgYmUgZG9uZQ0KdGhyb3VnaCB0ZXh0X3Bva2UoKS4NCg0KSeKAmWxsIGdp
dmUgaXQgYW5vdGhlciBsb29rIGFuZCBzZW5kIGFub3RoZXIgdmVyc2lvbiBsYXRlci4NCg0KUmVn
YXJkcywNCk5hZGF2DQoNCg0K

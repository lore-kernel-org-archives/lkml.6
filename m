Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E0FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743E520869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="o4f3QQZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743E520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbeKLG2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:28:31 -0500
Received: from mail-eopbgr680058.outbound.protection.outlook.com ([40.107.68.58]:18560
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730168AbeKLG2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:28:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaB1LE71ABbiwgbXdrf2YL+QkMXUtQsk4N0XVwxtItQ=;
 b=o4f3QQZAlo+/ORhcFkfloD8MUK3OUa34DU/n7jni6UU/2GPk3jE36nxDgdoZ1h7RC/6TOAZ9DyUdC2VkkBwciJVF5ScLq4Xl5OscMmj9xEF+yTwmyz4mWdONFRa0TpjN5FeQxpwSJJh7IUrJFpSNpTWKkc+YSwMhHkOg/o+Sl/I=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4968.namprd05.prod.outlook.com (20.177.229.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.12; Sun, 11 Nov 2018 20:38:53 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.018; Sun, 11 Nov 2018
 20:38:53 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/10] x86/alternative: initializing temporary mm for
 patching
Thread-Topic: [PATCH v4 05/10] x86/alternative: initializing temporary mm for
 patching
Thread-Index: AQHUeYjEpAFjgaUHf0yH80LOcug/yqVKpr6AgABjTIA=
Date:   Sun, 11 Nov 2018 20:38:53 +0000
Message-ID: <0A01B5B5-C771-45AC-81B3-92EE9611D8B2@vmware.com>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-6-namit@vmware.com>
 <20181111144327.GG12766@worktop.psav.com>
In-Reply-To: <20181111144327.GG12766@worktop.psav.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4968;20:Z1gfxTIiplORukTDaySA6ZjfGVzs47HLsDz61Zuh8xGLTTIl4l2rMD/bYHd2+o9vQuA+sVjpdaqd/bd9MCOghYzkTZ4LG1Yow+KTiR+EXdlLbUupDWggzSE7IG+X/33us0CdN+rGdHb3PdoLeQ0ZabAKKKg78LqRo9w2+mdDvUk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: de1e1079-18aa-454f-69db-08d64815b1b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4968;
x-ms-traffictypediagnostic: BYAPR05MB4968:
x-microsoft-antispam-prvs: <BYAPR05MB496850ADA55F3F6A6DEEAB4DD0C00@BYAPR05MB4968.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231382)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4968;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4968;
x-forefront-prvs: 08534B37A7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(366004)(396003)(199004)(189003)(36756003)(25786009)(99286004)(6512007)(305945005)(7736002)(2900100001)(6486002)(6436002)(186003)(7416002)(97736004)(81156014)(54906003)(81166006)(229853002)(33656002)(2906002)(11346002)(446003)(486006)(2616005)(256004)(86362001)(14444005)(476003)(3846002)(26005)(102836004)(6116002)(71200400001)(71190400001)(8936002)(6916009)(83716004)(76176011)(4326008)(53936002)(82746002)(106356001)(6506007)(66066001)(105586002)(14454004)(5660300001)(68736007)(53546011)(8676002)(316002)(6246003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4968;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /bENlyY1fKb4yxTWPSDjeeUK/BWdUPXMCbD8+gCkrJmROMXW4J4fSOCfd6/gBaS+qVpHNJE8fFrSA40xzrPQxQvQ/fP2HEYXM22WrnlF4g64cicnax05x0k7VniE5sFvrY10mp84KfVIvj0/q7GsfxaWgdxUc3EHZG/5XqOy0gCeLYqPJn0nMqJj4l88y5jB2VCSVx2H1K7lp4hVCnJtGJZc0V3dfHagsaL/EMIPyYPp/D3R7mRm+UH5PGOD/w4F9wYJGfhD36oOFnsXemzKCuFX/hjA5F0tY/CNnr2WWpl/E/6ZhTruPGTknCedNSWh7sovEck0BfCQu1bXGBstpaEk2oFExAs5cAhX4lCWTws=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A8054B98C39434383A01151706090DD@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1e1079-18aa-454f-69db-08d64815b1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2018 20:38:53.0951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4968
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGV0ZXIgWmlqbHN0cmENClNlbnQ6IE5vdmVtYmVyIDExLCAyMDE4IGF0IDI6NDM6Mjcg
UE0gR01UDQo+IFRvOiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPg0KPiBDYzogSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+LCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCB4
ODZAa2VybmVsLm9yZywgSC4gUGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+LCBUaG9tYXMgR2xl
aXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4sIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRl
PiwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4sIEtlZXMgQ29vayA8
a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPiwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwNS8xMF0geDg2L2FsdGVybmF0aXZlOiBpbml0
aWFsaXppbmcgdGVtcG9yYXJ5IG1tIGZvciBwYXRjaGluZw0KPiANCj4gDQo+IA0KPiBJIGRvbid0
IHNlZW0gdG8gaGF2ZSBnb3R0ZW4gcGF0Y2hlcyAwLTIsNyBmb3Igc29tZSByZWFzb247IEknbGwg
dHJ5IGFuZA0KPiBkaWcgdGhlbSBvdXQgb2YgdGhlIExLTUwgZm9sZGVyLg0KPiANCj4gT24gU2F0
LCBOb3YgMTAsIDIwMTggYXQgMDM6MTc6MjdQTSAtMDgwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+
ICt2b2lkIF9faW5pdCBwb2tpbmdfaW5pdCh2b2lkKQ0KPj4gK3sNCj4+ICsJc3BpbmxvY2tfdCAq
cHRsOw0KPj4gKwlwdGVfdCAqcHRlcDsNCj4+ICsNCj4+ICsJcG9raW5nX21tID0gY29weV9pbml0
X21tKCk7DQo+PiArCWlmICghcG9raW5nX21tKSB7DQo+PiArCQlwcl9lcnIoIng4Ni9tbTogZXJy
b3Igc2V0dGluZyBhIHNlcGFyYXRlIHBva2luZyBhZGRyZXNzIHNwYWNlIik7DQo+PiArCQlyZXR1
cm47DQo+PiArCX0NCj4+ICsNCj4+ICsJLyoNCj4+ICsJICogUmFuZG9taXplIHRoZSBwb2tpbmcg
YWRkcmVzcywgYnV0IG1ha2Ugc3VyZSB0aGF0IHRoZSBmb2xsb3dpbmcgcGFnZQ0KPj4gKwkgKiB3
aWxsIGJlIG1hcHBlZCBhdCB0aGUgc2FtZSBQTUQuIFdlIG5lZWQgMiBwYWdlcywgc28gZmluZCBz
cGFjZSBmb3IgMywNCj4+ICsJICogYW5kIGFkanVzdCB0aGUgYWRkcmVzcyBpZiB0aGUgUE1EIGVu
ZHMgYWZ0ZXIgdGhlIGZpcnN0IG9uZS4NCj4+ICsJICovDQo+PiArCXBva2luZ19hZGRyID0gVEFT
S19VTk1BUFBFRF9CQVNFICsNCj4+ICsJCShrYXNscl9nZXRfcmFuZG9tX2xvbmcoIlBva2luZyIp
ICYgUEFHRV9NQVNLKSAlDQo+PiArCQkoVEFTS19TSVpFIC0gVEFTS19VTk1BUFBFRF9CQVNFIC0g
MyAqIFBBR0VfU0laRSk7DQo+PiArDQo+PiArCWlmICgoKHBva2luZ19hZGRyICsgUEFHRV9TSVpF
KSAmIH5QTURfTUFTSykgPT0gMCkNCj4+ICsJCXBva2luZ19hZGRyICs9IFBBR0VfU0laRTsNCj4+
ICsNCj4+ICsJLyoNCj4+ICsJICogV2UgbmVlZCB0byB0cmlnZ2VyIHRoZSBhbGxvY2F0aW9uIG9m
IHRoZSBwYWdlLXRhYmxlcyB0aGF0IHdpbGwgYmUNCj4+ICsJICogbmVlZGVkIGZvciBwb2tpbmcg
bm93LiBMYXRlciwgcG9raW5nIG1heSBiZSBwZXJmb3JtZWQgaW4gYW4gYXRvbWljDQo+PiArCSAq
IHNlY3Rpb24sIHdoaWNoIG1pZ2h0IGNhdXNlIGFsbG9jYXRpb24gdG8gZmFpbC4NCj4+ICsJICov
DQo+PiArCXB0ZXAgPSBnZXRfbG9ja2VkX3B0ZShwb2tpbmdfbW0sIHBva2luZ19hZGRyLCAmcHRs
KTsNCj4+ICsJaWYgKCFXQVJOX09OKCFwdGVwKSkNCj4+ICsJCXB0ZV91bm1hcF91bmxvY2socHRl
cCwgcHRsKTsNCj4+ICt9DQo+IA0KPiBUaGUgZGlmZmVyZW5jZSBpbiBob3cgd2UgZGVhbCB3aXRo
IC1FTk9NRU0gaGVyZSBpcyB3ZWlyZC4gSSB0aGluayB3ZQ0KPiBoYXZlIGEgX2xvdF8gb2YgY29k
ZSB0aGF0IHNpbXBseSBoYXJkIGFzc3VtZXMgd2UgZG9uJ3QgZmFpbCBtZW1vcnkgYWxsb2MNCj4g
b24gaW5pdC4NCj4gDQo+IEkgZm9yIGluc3RhbmNlIHdvdWxkIG5vdCBtaW5kIHRvIHNpbXBseSBy
ZW1vdmUgYm90aCBicmFuY2hlcyBhbmQgbGV0IHRoZQ0KPiBrZXJuZWwgY3Jhc2ggYW5kIGJ1cm4g
aWYgd2UgZXZlciBmYWlsIGhlcmUuDQoNCkFjdHVhbGx5LCBub3cgdGhhdCB3ZSByZW1vdmVkIHRo
ZSBmYWxsYmFjayBvZiBwYXRjaGluZyB3aXRob3V0IHBva2luZ19tbSwgYQ0KZmFpbHVyZSB0byBh
bGxvY2F0ZSBwb2tpbmdfbW0gc2hvdWxkIGhhdmUgaGFkIGEgQlVHX09OKCkuDQoNCkZvciB0aGUg
c2Vjb25kIGNhc2UsIEkgdGhpbmsgd2Ugc3RpbGwgbmVlZCBlaXRoZXIgV0FSTl9PTigpIG9yIEJV
R19PTigpLCBhdA0KbGVhc3QgYXMgc29tZSBzb3J0IG9mIGFuIGluLWNvZGUgY29tbWVudC4gSeKA
mWxsIGNoYW5nZSBpdCB0byBCVUdfT04oKSBpZiB5b3UNCnByZWZlci4NCg0K

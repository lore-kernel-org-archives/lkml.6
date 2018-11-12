Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6890AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D91224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="SzD7dWMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D91224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbeKMGIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:08:13 -0500
Received: from mail-eopbgr700081.outbound.protection.outlook.com ([40.107.70.81]:62208
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbeKMGIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euU/pR/Wv+DbT5ZltnjlqZCMRAxNCENFJNq7HRF1nq0=;
 b=SzD7dWMDSChr9BDqVbPXk7dxB9V/zyWf/eOS/OUjE+2eQle7PdNW0C6/csiH+gTdzX9ToD5QzMWMkz8htEdimXWf0eQdIIMTIXGxPsea2+ng0A8IXLJREhr4/3e1qUSknYM6soBQ5bZJTCMvDZWuE+sa2GjxyCR/fJEPaXW7C/I=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5448.namprd05.prod.outlook.com (20.177.185.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.13; Mon, 12 Nov 2018 20:12:42 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.019; Mon, 12 Nov 2018
 20:12:42 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v4 02/10] x86/jump_label: Use text_poke_early() during
 early init
Thread-Topic: [PATCH v4 02/10] x86/jump_label: Use text_poke_early() during
 early init
Thread-Index: AQHUeYjErLQBC6fwG0CJ7lgrBoVJLaVMlQIA
Date:   Mon, 12 Nov 2018 20:12:42 +0000
Message-ID: <052E33FA-6EB8-4012-ADDA-0D770E307461@vmware.com>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-3-namit@vmware.com>
In-Reply-To: <20181110231732.15060-3-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5448;20:aZG1t7PD8TaBQjriYXoHERtSqKtKxbUGlrscvPJRVxwhNK8fNMNTe5J7Il6i6BJb6DAqhYRoWO+WFz0stASi5qhzF9UBiyMnxDmKLDkQP0ulVkeh07oXlJ0TObLRYp20gw/Jq/+rvlJ6bDwEuUBPzJYfwJi4lF5x6C/9aCYIjY4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f29140b0-843f-4b81-c394-08d648db33d9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5448;
x-ms-traffictypediagnostic: BYAPR05MB5448:
x-microsoft-antispam-prvs: <BYAPR05MB54484EE52451934FDD901717D0C10@BYAPR05MB5448.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5448;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5448;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(189003)(199004)(229853002)(6512007)(26005)(25786009)(66066001)(2906002)(53936002)(4326008)(6436002)(14454004)(83716004)(71200400001)(316002)(102836004)(186003)(106356001)(33656002)(71190400001)(105586002)(3846002)(6116002)(54906003)(305945005)(6916009)(53546011)(7736002)(478600001)(6506007)(2900100001)(36756003)(97736004)(7416002)(5660300001)(476003)(2616005)(446003)(486006)(11346002)(8936002)(76176011)(68736007)(6486002)(256004)(14444005)(6246003)(81166006)(82746002)(8676002)(86362001)(81156014)(99286004)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5448;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2JUq+IKAWihUEXoZFjl+x7VWERboiV4TbSOju+5JAmB5eH0yEt5afCZPsWkhPU0LaY1XKtjF9s3jL1xqV7+bFRhsgDqtIZ4gSY6GdAOqLVUCFb15JttXZH8kedjFbBxF5KZSR8VVkSK2Mru+6fZg2gDK48fJo+8z3cFsMt3hkNguHdXHwgwyLg+iQ9rNdmM5jFrh4+8xgtoq1kh+bDqjTQ2LU4410+fImhyha5CYhJcuYww68AoiYbYxDQLBO6ndzgNQWZ2wCF6MGjseG8P2lpS4dwuIBUmHWBMLBmLqf0LEL8sPVhtY5Vupt13r0ezrRUIAg6rz47GI5fOy65+KrwgKl8k/2EoG88UbKXdyZgI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6C4CB72E13F8C4CA3BE5D1E8952F281@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29140b0-843f-4b81-c394-08d648db33d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 20:12:42.3200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5448
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGV0ZXIsDQoNCkkgaGF2ZSBwdXQgeW91IGFzIGEg4oCcQ28tRGV2ZWxvcGVkLWJ54oCdLCBzaW5j
ZSB0aGUgcGF0Y2ggZW5kZWQgdXAgYXMgYmVpbmcgdGhlDQpzaW5nbGUgbGluZSB0aGF0IHlvdSB3
cm90ZSBpbiB0aGUgY29ycmVzcG9uZGVuY2Ugb2YgdGhlIHByZXZpb3VzIHZlcnNpb24uDQoNCkkg
d291bGQgdGhlcmVmb3JlIG5lZWQgdG8gYXNrIGZvciB5b3VyIHNpZ25lZC1vZmYtYnkuDQoNClJl
Z2FyZHMsDQpOYWRhdg0KDQpGcm9tOiBOYWRhdiBBbWl0DQpTZW50OiBOb3ZlbWJlciAxMCwgMjAx
OCBhdCAxMToxNzoyNCBQTSBHTVQNCj4gVG86IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29t
Pg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4sIHg4NkBrZXJuZWwub3JnPiwg
SC4gUGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+LCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGlu
dXRyb25peC5kZT4sIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPiwgRGF2ZSBIYW5zZW4g
PGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5j
b20+LCBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4sIEtlZXMgQ29vayA8a2Vlc2Nv
b2tAY2hyb21pdW0ub3JnPiwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT4sIE1h
c2FtaSBIaXJhbWF0c3UgPG1oaXJhbWF0QGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFtQQVRDSCB2
NCAwMi8xMF0geDg2L2p1bXBfbGFiZWw6IFVzZSB0ZXh0X3Bva2VfZWFybHkoKSBkdXJpbmcgZWFy
bHkgaW5pdA0KPiANCj4gDQo+IFRoZXJlIGlzIG5vIGFwcGFyZW50IHJlYXNvbiBub3QgdG8gdXNl
IHRleHRfcG9rZV9lYXJseSgpIHdoaWxlIHdlIGFyZQ0KPiBkdXJpbmcgZWFybHktaW5pdCBhbmQg
d2UgZG8gbm90IHBhdGNoIGNvZGUgdGhhdCBtaWdodCBiZSBvbiB0aGUgc3RhY2sNCj4gKGkuZS4s
IHdlJ2xsIHJldHVybiB0byB0aGUgbWlkZGxlIG9mIHRoZSBwYXRjaGVkIGNvZGUpLiBUaGlzIGFw
cGVhcnMgdG8NCj4gYmUgdGhlIGNhc2Ugb2YganVtcC1sYWJlbHMsIHNvIGRvIHNvLg0KPiANCj4g
VGhpcyBpcyByZXF1aXJlZCBmb3IgdGhlIG5leHQgcGF0Y2hlcyB0aGF0IHdvdWxkIHNldCBhIHRl
bXBvcmFyeSBtbSBmb3INCj4gcGF0Y2hpbmcsIHdoaWNoIGlzIGluaXRpYWxpemVkIGFmdGVyIHNv
bWUgc3RhdGljLWtleXMgYXJlDQo+IGVuYWJsZWQvZGlzYWJsZWQuDQo+IA0KPiBDYzogQW5keSBM
dXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+DQo+IENjOiBLZWVzIENvb2sgPGtlZXNjb29rQGNo
cm9taXVtLm9yZz4NCj4gQ2M6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+DQo+
IENjOiBNYXNhbWkgSGlyYW1hdHN1IDxtaGlyYW1hdEBrZXJuZWwub3JnPg0KPiBDby1EZXZlbG9w
ZWQtYnk6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj4gU2lnbmVkLW9m
Zi1ieTogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4NCj4gLS0tDQo+IGFyY2gveDg2L2tl
cm5lbC9qdW1wX2xhYmVsLmMgfCA3ICsrKysrKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5l
bC9qdW1wX2xhYmVsLmMgYi9hcmNoL3g4Ni9rZXJuZWwvanVtcF9sYWJlbC5jDQo+IGluZGV4IGFh
YzBjMWY3ZTM1NC4uZWQ1ZmUyNzRhN2Q4IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwv
anVtcF9sYWJlbC5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9qdW1wX2xhYmVsLmMNCj4gQEAg
LTUyLDcgKzUyLDEyIEBAIHN0YXRpYyB2b2lkIF9fcmVmIF9fanVtcF9sYWJlbF90cmFuc2Zvcm0o
c3RydWN0IGp1bXBfZW50cnkgKmVudHJ5LA0KPiAJam1wLm9mZnNldCA9IGp1bXBfZW50cnlfdGFy
Z2V0KGVudHJ5KSAtDQo+IAkJICAgICAoanVtcF9lbnRyeV9jb2RlKGVudHJ5KSArIEpVTVBfTEFC
RUxfTk9QX1NJWkUpOw0KPiANCj4gLQlpZiAoZWFybHlfYm9vdF9pcnFzX2Rpc2FibGVkKQ0KPiAr
CS8qDQo+ICsJICogQXMgbG9uZyBhcyB3ZSdyZSBVUCBhbmQgbm90IHlldCBtYXJrZWQgUk8sIHdl
IGNhbiB1c2UNCj4gKwkgKiB0ZXh0X3Bva2VfZWFybHk7IFNZU1RFTV9CT09USU5HIGd1YXJhbnRl
ZXMgYm90aCwgYXMgd2Ugc3dpdGNoIHRvDQo+ICsJICogU1lTVEVNX1NDSEVEVUxJTkcgYmVmb3Jl
IGdvaW5nIGVpdGhlci4NCj4gKwkgKi8NCj4gKwlpZiAoc3lzdGVtX3N0YXRlID09IFNZU1RFTV9C
T09USU5HKQ0KPiAJCXBva2VyID0gdGV4dF9wb2tlX2Vhcmx5Ow0KPiANCj4gCWlmICh0eXBlID09
IEpVTVBfTEFCRUxfSk1QKSB7DQo+IC0tIA0KPiAyLjE3LjENCg0KDQo=

Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDB2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5747F20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="p7vt0kXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5747F20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeH3Czi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:55:38 -0400
Received: from mail-eopbgr730073.outbound.protection.outlook.com ([40.107.73.73]:24359
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727432AbeH3Czi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bafxYz3rxJ+PE4CWLbp5Wv+RInhw4TRiHSqsoXi4Q4A=;
 b=p7vt0kXTtHXEKP/ObiNaM2O8t9agRysjXhx6ejXdoiGHtcsi8XnRJNqilZ6izF/ZhK572w3NxvQz7HqInz5hkV0NqmpHJcFyuxlddw65kvsgOjL+vEx8wwj4ZC/HmYlaZLX6b7/AWUdmhwRwHcNQl7LBjwqpo5IuMkSYvYPEoVE=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4808.namprd05.prod.outlook.com (52.135.235.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.11; Wed, 29 Aug 2018 22:56:24 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3%3]) with mapi id 15.20.1101.007; Wed, 29 Aug 2018
 22:56:24 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 1/6] x86/alternative: assert text_mutex is taken
Thread-Topic: [RFC PATCH 1/6] x86/alternative: assert text_mutex is taken
Thread-Index: AQHUP3AveUOJQxVhiEqJKH9IYmSgsaTWblgAgACJiICAAChdgIAACkwAgAAI04CAAARKAIAAIHwA
Date:   Wed, 29 Aug 2018 22:56:23 +0000
Message-ID: <DFC5DCBA-A572-4603-82C8-77A6C1303630@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-2-namit@vmware.com>
 <20180829175936.fb27b3bf13da819a9a971f07@kernel.org>
 <1F547CEE-B5D9-42A0-8093-2C5555BACE26@vmware.com>
 <2694AE6F-2212-46C6-A570-6BAF265364FB@vmware.com>
 <20180829201309.GA7142@linux.intel.com>
 <58345C1F-8FF3-4F49-AF2F-B4789DF50CC7@vmware.com>
 <20180829210006.GA7166@linux.intel.com>
In-Reply-To: <20180829210006.GA7166@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4808;20:gK6g0XfzzR0DYe5Y39TKYUNEU8/DA/XcKEnoGWQfIqq5SNAAEIeWprP3RRnhWjSIDR2qnOxhPhO2Lxwhq4pM323c5qeNds1Q/9X3wx58o77QbVud8EHMvfPV4UiFKa6n8Ns6buAvglsqN3Sj2T4oZ4Va9CUcD0kePcIsnAWRhlY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ee04bc11-d9f9-4b72-e869-08d60e02a50f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4808;
x-ms-traffictypediagnostic: BYAPR05MB4808:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB4808F049ABCA9C437F43341FD0090@BYAPR05MB4808.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:BYAPR05MB4808;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4808;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(366004)(39860400002)(189003)(199004)(2900100001)(11346002)(446003)(105586002)(6116002)(486006)(476003)(68736007)(2616005)(3846002)(93886005)(6436002)(76176011)(8676002)(14444005)(36756003)(256004)(6486002)(102836004)(26005)(25786009)(82746002)(106356001)(6506007)(6512007)(186003)(4326008)(33656002)(81156014)(81166006)(86362001)(99286004)(14454004)(83716003)(217873002)(53936002)(97736004)(6246003)(7416002)(8936002)(66066001)(316002)(5250100002)(54906003)(2906002)(7736002)(229853002)(478600001)(305945005)(5660300001)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4808;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1I20qYzRyRTUxTPGAjONqiHW+s7FK4gG2LBrcZTe94emzKylRGJ8G2ri8bJ/iPGhbvjLsiUnoE6DnO9iBpm3xd4RkWbcpkCzuHqua9X/SYKIRgIUqwxQ7NSManbWJ0R+Uu2YNG//PHuo63VTHv6ehaQq0rpV3dAYWj8ljyUUGWNk5aZaM1r3a0uPj0J53vb5FojGEEs4ETETc9fzilf23clsy9Ah++gCaRCGUFFzpYnEPBMEJlDDJNqNlCZnhiYMINI7RIyfx/wxHossZYbRqAO/DSgsBHPnEwsIPxhaPe1m7EM/vLTA0H8b4AMcW/VIn0flX8UOg4wAL+bP1Dh/QMcPtkca4mMezD0KMVIxyyI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC2DDA7049F1294F8FCFA8632F950D27@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee04bc11-d9f9-4b72-e869-08d60e02a50f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 22:56:24.0729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMjowMCBQTSwgU2VhbiBDaHJpc3RvcGhlcnNvbiA8c2Vhbi5qLmNocmlzdG9waGVyc29uQGlu
dGVsLmNvbT4gd3JvdGU6DQoNCj4gT24gV2VkLCBBdWcgMjksIDIwMTggYXQgMDg6NDQ6NDdQTSAr
MDAwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+IGF0IDE6MTMgUE0sIFNlYW4gQ2hyaXN0b3BoZXJz
b24gPHNlYW4uai5jaHJpc3RvcGhlcnNvbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4gDQo+Pj4gT24g
V2VkLCBBdWcgMjksIDIwMTggYXQgMDc6MzY6MjJQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90ZToN
Cj4+Pj4gYXQgMTA6MTEgQU0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0K
Pj4+PiANCj4+Pj4+IGF0IDE6NTkgQU0sIE1hc2FtaSBIaXJhbWF0c3UgPG1oaXJhbWF0QGtlcm5l
bC5vcmc+IHdyb3RlOg0KPj4+Pj4gDQo+Pj4+Pj4gT24gV2VkLCAyOSBBdWcgMjAxOCAwMToxMTo0
MiAtMDcwMA0KPj4+Pj4+IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4+
Pj4+IA0KPj4+Pj4+PiBVc2UgbG9ja2RlcCB0byBlbnN1cmUgdGhhdCB0ZXh0X211dGV4IGlzIHRh
a2VuIHdoZW4gdGV4dF9wb2tlKCkgaXMNCj4+Pj4+Pj4gY2FsbGVkLg0KPj4+Pj4+PiANCj4+Pj4+
Pj4gQWN0dWFsbHkgaXQgaXMgbm90IGFsd2F5cyB0YWtlbiwgc3BlY2lmaWNhbGx5IHdoZW4gaXQg
aXMgY2FsbGVkIGJ5IGtnZGIsDQo+Pj4+Pj4+IHNvIHRha2UgdGhlIGxvY2sgaW4gdGhlc2UgY2Fz
ZXMuDQo+Pj4+Pj4gDQo+Pj4+Pj4gQ2FuIHdlIHJlYWxseSB0YWtlIGEgbXV0ZXggaW4ga2dkYiBj
b250ZXh0Pw0KPj4+Pj4+IA0KPj4+Pj4+IGtnZGJfYXJjaF9yZW1vdmVfYnJlYWtwb2ludA0KPj4+
Pj4+IDwtIGRiZ19kZWFjdGl2YXRlX3N3X2JyZWFrcG9pbnRzDQo+Pj4+Pj4gPC0ga2dkYl9yZWVu
dGVyX2NoZWNrDQo+Pj4+Pj4gICAgPC0ga2dkYl9oYW5kbGVfZXhjZXB0aW9uDQo+Pj4+Pj4gICAg
ICAgPC0gX19rZ2RiX25vdGlmeQ0KPj4+Pj4+ICAgICAgICAgPC0ga2dkYl9sbF90cmFwDQo+Pj4+
Pj4gICAgICAgICAgIDwtIGRvX2ludDMNCj4+Pj4+PiAgICAgICAgIDwtIGtnZGJfbm90aWZ5DQo+
Pj4+Pj4gICAgICAgICAgIDwtIGRpZSBub3RpZmllcg0KPj4+Pj4+IA0KPj4+Pj4+IGtnZGJfYXJj
aF9zZXRfYnJlYWtwb2ludA0KPj4+Pj4+IDwtIGRiZ19hY3RpdmF0ZV9zd19icmVha3BvaW50cw0K
Pj4+Pj4+IDwtIGtnZGJfcmVlbnRlcl9jaGVjaw0KPj4+Pj4+ICAgIDwtIGtnZGJfaGFuZGxlX2V4
Y2VwdGlvbg0KPj4+Pj4+ICAgICAgICAuLi4NCj4+Pj4+PiANCj4+Pj4+PiBCb3RoIHNlZW1zIGNh
bGxlZCBpbiBleGNlcHRpb24gY29udGV4dCwgc28gd2UgY2FuIG5vdCB0YWtlIGEgbXV0ZXggbG9j
ay4NCj4+Pj4+PiBJIHRoaW5rIGtnZGIgbmVlZHMgYSBzcGVjaWFsIHBhdGguDQo+Pj4+PiANCj4+
Pj4+IFlvdSBhcmUgY29ycmVjdCwgYnV0IEkgZG9u4oCZdCB3YW50IGEgc3BlY2lhbCBwYXRoLiBQ
cmVzdW1hYmx5IHRleHRfbXV0ZXggaXMNCj4+Pj4+IGd1YXJhbnRlZWQgbm90IHRvIGJlIHRha2Vu
IGFjY29yZGluZyB0byB0aGUgY29kZS4NCj4+Pj4+IA0KPj4+Pj4gU28gSSBndWVzcyB0aGUgb25s
eSBjb25jZXJuIGlzIGxvY2tkZXAuIERvIHlvdSBzZWUgYW55IHByb2JsZW0gaWYgSSBjaGFuZ2UN
Cj4+Pj4+IG11dGV4X2xvY2soKSBpbnRvIG11dGV4X3RyeWxvY2soKT8gSXQgc2hvdWxkIGFsd2F5
cyBzdWNjZWVkLCBhbmQgSSBjYW4gYWRkIGENCj4+Pj4+IHdhcm5pbmcgYW5kIGEgZmFpbHVyZSBw
YXRoIGlmIGl0IGZhaWxzIGZvciBzb21lIHJlYXNvbi4NCj4+Pj4gDQo+Pj4+IEVyci4uIFRoaXMg
d2lsbCBub3Qgd29yay4gSSB0aGluayBJIHdpbGwgZHJvcCB0aGlzIHBhdGNoLCBzaW5jZSBJIGNh
bm5vdA0KPj4+PiBmaW5kIGEgcHJvcGVyIHlldCBzaW1wbGUgYXNzZXJ0aW9uLiBDcmVhdGluZyBz
cGVjaWFsIHBhdGgganVzdCBmb3IgdGhlDQo+Pj4+IGFzc2VydGlvbiBzZWVtcyB3cm9uZy4NCj4+
PiANCj4+PiBJdCdzIHByb2JhYmx5IHdvcnRoIGV4cGFuZGluZyB0aGUgY29tbWVudCBmb3IgdGV4
dF9wb2tlKCkgdG8gY2FsbCBvdXQNCj4+PiB0aGUga2dkYiBjYXNlIGFuZCByZWZlcmVuY2Uga2dk
Yl9hcmNoX3tzZXQscmVtb3ZlfV9icmVha3BvaW50KCksIHdob3NlDQo+Pj4gY29kZSBhbmQgY29t
bWVudHMgbWFrZSBpdCBleHBsaWNpdGx5IGNsZWFyIHdoeSBpdHMgc2FmZSBmb3IgdGhlbSB0bw0K
Pj4+IGNhbGwgdGV4dF9wb2tlKCkgd2l0aG91dCBhY3F1aXJpbmcgdGhlIGxvY2suICBNaWdodCBw
cmV2ZW50IHNvbWVvbmUNCj4+PiBmcm9tIGdvaW5nIGRvd24gdGhpcyBwYXRoIGFnYWluIGluIHRo
ZSBmdXR1cmUuDQo+PiANCj4+IEkgdGhvdWdodCB0aGF0IHRoZSB3aG9sZSBwb2ludCBvZiB0aGUg
cGF0Y2ggd2FzIHRvIGF2b2lkIGNvbW1lbnRzLCBhbmQNCj4+IGluc3RlYWQgZW5mb3JjZSB0aGUg
cmlnaHQgYmVoYXZpb3IuIEkgZG9u4oCZdCB1bmRlcnN0YW5kIHdlbGwgZW5vdWdoIGtnZGINCj4+
IGNvZGUsIHNvIEkgY2Fubm90IGF0dGVzdCBpdCBkb2VzIHRoZSByaWdodCB0aGluZy4gV2hhdCBo
YXBwZW5zIGlmDQo+PiBrZ2RiX2RvX3JvdW5kdXA9PTA/DQo+IA0KPiBBcyBpcywgdGhlIGNvbW1l
bnQgaXMgd3JvbmcgYmVjYXVzZSB0aGVyZSBhcmUgb2J2aW91c2x5IGNhc2VzIHdoZXJlDQo+IHRl
eHRfcG9rZSgpIGlzIGNhbGxlZCB3aXRob3V0IHRleHRfbXV0ZXggYmVpbmcgaGVsZC4gIEkgY2Fu
J3QgYXR0ZXN0DQo+IHRvIHRoZSBrZ2RiIGNvZGUgZWl0aGVyLiAgTXkgdGhvdWdodCB3YXMgdG8g
ZG9jdW1lbnQgdGhlIGV4Y2VwdGlvbiBzbw0KPiB0aGF0IGlmIHNvbWVvbmUgZG9lcyB3YW50IHRv
IHRyeSBhbmQgZW5mb3JjZSB0aGUgcmlnaHQgYmVoYXZpb3IgdGhleQ0KPiBjYW4gZGl2ZSByaWdo
dCBpbnRvIHRoZSBwcm9ibGVtIGluc3RlYWQgb2YgaGF2aW5nIHRvIGxlYXJuIG9mIHRoZSBrZ2Ri
DQo+IGdvdGNoYSB0aGUgaGFyZCB3YXkuICBNYXliZSBhIEZJWE1FIGlzIHRoZSByaWdodCBhcHBy
b2FjaD8NCg0KT2suIEnigJlsbCBhZGQgYSBGSVhNRSBjb21tZW50IGFzIHlvdSBwcm9wb3NlLCBi
dXQgdGhpcyBkb2VzIG5vdCBkZXNlcnZlIGENCnNlcGFyYXRlIHBhdGNoLiBJ4oCZbGwgc3F1YXNo
IGl0IGludG8gcGF0Y2ggNS4NCg0K

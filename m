Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DE3C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9682A20834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="BcBhoF0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9682A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeLASEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 13:04:43 -0500
Received: from mail-eopbgr720060.outbound.protection.outlook.com ([40.107.72.60]:53376
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbeLASEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 13:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAGhAiV6Nd7yG54tLH7KAVe/BHPAE9ST/nmVlV/8SV8=;
 b=BcBhoF0suOR0Vel7NPmMmC8hWf0qGLzh0PSic8z8+vaDtwekSFtS1KmIcG5GntdB0ABwj5VGc7Dn3BvoDGAH26RIkDurhd5E5uKJNIuL6O51lI8u7Stn0Ulwlcfpyfqd8FxuLuw/L0Oi9OTjF1G+9DXE6VXFI9i2UsVIOSmq3zQ=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5480.namprd05.prod.outlook.com (20.177.185.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.7; Sat, 1 Dec 2018 06:52:46 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1404.011; Sat, 1 Dec 2018
 06:52:45 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 0/5] x86: dynamic indirect call promotion
Thread-Topic: [RFC PATCH 0/5] x86: dynamic indirect call promotion
Thread-Index: AQHUZn1la/DbvW2wT0Gh22Ko/9s6YqVlnFCAgAA5kgCAAFTegIAAEToAgAAHNQCAABXQAIAALXcAgACaSwCAApcugA==
Date:   Sat, 1 Dec 2018 06:52:45 +0000
Message-ID: <EEB5784B-A85E-47E9-8CB5-1560E58E87C6@vmware.com>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181128160849.epmoto4o5jaxxxol@treble>
 <9EACED43-EC21-41FB-BFAC-4E98C3842FD9@vmware.com>
 <20181129003837.6lgxsnhoyipkebmz@treble>
 <CALCETrUfC37TxuYLgqbN3_pZ1RzfpV03byKMpSt87o+JHtk6FQ@mail.gmail.com>
 <0E75C656-18BF-4967-98A3-35E0BD83D603@vmware.com>
 <4CD1975E-3B15-4B9C-B2A9-2E5F72E1D95F@amacapital.net>
 <CALCETrWN5QenBqNpLZ3EWEF2XFje3HGubzck4AEFePCspM6mGQ@mail.gmail.com>
 <20181129151906.owxeef2e3cm4nn2y@treble>
In-Reply-To: <20181129151906.owxeef2e3cm4nn2y@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4580:b719:7176:5f0b:7fa8:674c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5480;20:pkkSuzIVlJbB+wKoMlk8CKgAiVqrsevme/b/5ssxwv6JrRoEzKG9h/Ui8zTcSCJOs/nzuJRVJnSO36wC5t7kY3sxHSK+788fSBsZTUnzasiALnm2oQxyIfMt5sCUFG9eE//cEfvSXBf2MQZs072Y0IcdYxhpd6lWnyyim4ZdG8w=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 149dd686-83a8-4a88-98b7-08d657599981
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5480;
x-ms-traffictypediagnostic: BYAPR05MB5480:
x-microsoft-antispam-prvs: <BYAPR05MB5480ECA9835343BC02AAF174D0AC0@BYAPR05MB5480.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231454)(999002)(944501410)(52105112)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5480;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5480;
x-forefront-prvs: 087396016C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(189003)(199004)(86362001)(76176011)(6506007)(71200400001)(229853002)(93886005)(2906002)(476003)(71190400001)(186003)(2616005)(7416002)(7736002)(6486002)(6436002)(305945005)(36756003)(82746002)(46003)(99286004)(6116002)(83716004)(478600001)(8936002)(8676002)(81156014)(81166006)(53936002)(14454004)(316002)(97736004)(33656002)(110136005)(217873002)(25786009)(54906003)(5660300001)(6512007)(53546011)(11346002)(68736007)(486006)(102836004)(6246003)(14444005)(4326008)(256004)(105586002)(106356001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5480;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4wRESCfWwKbMZKaxYmoBdbgWWEXtcMIEzLBD2I1Hkn/JZSjjb8RXXztxLiRTgFhLuX5dLmAQX/DMqvoYgYCuKHyLhBXXlCHrKmRDf7CzSoQWoN3MaKM39bl1BryKED03ukpw2uhtzn4kSY0wQW3WwoIbOCm0sqlRPzrpHYW1KfDQUwPiQgZSQKk0hbuqCH75LJTSiM6dMPBT2IwEFmTvHBOMtgSzMnC/wttDz27jxfxKkvf+HfMgTWQCuVHo7OqpLb/q2TEqhYx4bo1jhh/wVrvmPrvCIc2+LpzlDqCt+SBW0IUA7wmIkv0XMZi54saQ8wGbALMi1mBo6q6iA09kdrfIUieUVdYSlHQeaWq/pXg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <886A6728AB19694DBB3E0D77897193C3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149dd686-83a8-4a88-98b7-08d657599981
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2018 06:52:45.5284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5480
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBOb3YgMjksIDIwMTgsIGF0IDc6MTkgQU0sIEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBy
ZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgTm92IDI4LCAyMDE4IGF0IDEwOjA2OjUy
UE0gLTA4MDAsIEFuZHkgTHV0b21pcnNraSB3cm90ZToNCj4+IE9uIFdlZCwgTm92IDI4LCAyMDE4
IGF0IDc6MjQgUE0gQW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNhcGl0YWwubmV0PiB3cm90ZToN
Cj4+PiBPbiBOb3YgMjgsIDIwMTgsIGF0IDY6MDYgUE0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2Fy
ZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+Pj4gT24gTm92IDI4LCAyMDE4LCBhdCA1OjQwIFBNLCBB
bmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+PiBP
biBXZWQsIE5vdiAyOCwgMjAxOCBhdCA0OjM4IFBNIEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBy
ZWRoYXQuY29tPiB3cm90ZToNCj4+Pj4+PiBPbiBXZWQsIE5vdiAyOCwgMjAxOCBhdCAwNzozNDo1
MlBNICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+Pj4+Pj4gT24gTm92IDI4LCAyMDE4LCBh
dCA4OjA4IEFNLCBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+
Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBPbiBXZWQsIE9jdCAxNywgMjAxOCBhdCAwNTo1NDoxNVBNIC0w
NzAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+Pj4+Pj4+IFRoaXMgUkZDIGludHJvZHVjZXMgaW5k
aXJlY3QgY2FsbCBwcm9tb3Rpb24gaW4gcnVudGltZSwgd2hpY2ggZm9yIHRoZQ0KPj4+Pj4+Pj4+
IG1hdHRlciBvZiBzaW1wbGlmaWNhdGlvbiAoYW5kIGJyYW5kaW5nKSB3aWxsIGJlIGNhbGxlZCBo
ZXJlICJyZWxwb2xpbmVzIg0KPj4+Pj4+Pj4+IChyZWxhdGl2ZSBjYWxsICsgdHJhbXBvbGluZSku
IFJlbHBvbGluZXMgYXJlIG1haW5seSBpbnRlbmRlZCBhcyBhIHdheQ0KPj4+Pj4+Pj4+IG9mIHJl
ZHVjaW5nIHJldHBvbGluZSBvdmVyaGVhZHMgZHVlIHRvIFNwZWN0cmUgdjIuDQo+Pj4+Pj4+Pj4g
DQo+Pj4+Pj4+Pj4gVW5saWtlIGluZGlyZWN0IGNhbGwgcHJvbW90aW9uIHRocm91Z2ggcHJvZmls
ZSBndWlkZWQgb3B0aW1pemF0aW9uLCB0aGUNCj4+Pj4+Pj4+PiBwcm9wb3NlZCBhcHByb2FjaCBk
b2VzIG5vdCByZXF1aXJlIGEgcHJvZmlsaW5nIHN0YWdlLCB3b3JrcyB3ZWxsIHdpdGgNCj4+Pj4+
Pj4+PiBtb2R1bGVzIHdob3NlIGFkZHJlc3MgaXMgdW5rbm93biBhbmQgY2FuIGFkYXB0IHRvIGNo
YW5naW5nIHdvcmtsb2Fkcy4NCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBUaGUgbWFpbiBpZGVhIGlz
IHNpbXBsZTogZm9yIGV2ZXJ5IGluZGlyZWN0IGNhbGwsIHdlIGluamVjdCBhIHBpZWNlIG9mDQo+
Pj4+Pj4+Pj4gY29kZSB3aXRoIGZhc3QtIGFuZCBzbG93LXBhdGggY2FsbHMuIFRoZSBmYXN0IHBh
dGggaXMgdXNlZCBpZiB0aGUgdGFyZ2V0DQo+Pj4+Pj4+Pj4gbWF0Y2hlcyB0aGUgZXhwZWN0ZWQg
KGhvdCkgdGFyZ2V0LiBUaGUgc2xvdy1wYXRoIHVzZXMgYSByZXRwb2xpbmUuDQo+Pj4+Pj4+Pj4g
RHVyaW5nIHRyYWluaW5nLCB0aGUgc2xvdy1wYXRoIGlzIHNldCB0byBjYWxsIGEgZnVuY3Rpb24g
dGhhdCBzYXZlcyB0aGUNCj4+Pj4+Pj4+PiBjYWxsIHNvdXJjZSBhbmQgdGFyZ2V0IGluIGEgaGFz
aC10YWJsZSBhbmQga2VlcCBjb3VudCBmb3IgY2FsbA0KPj4+Pj4+Pj4+IGZyZXF1ZW5jeS4gVGhl
IG1vc3QgY29tbW9uIHRhcmdldCBpcyB0aGVuIHBhdGNoZWQgaW50byB0aGUgaG90IHBhdGguDQo+
Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gVGhlIHBhdGNoaW5nIGlzIGRvbmUgb24tdGhlLWZseSBieSBw
YXRjaGluZyB0aGUgY29uZGl0aW9uYWwgYnJhbmNoDQo+Pj4+Pj4+Pj4gKG9wY29kZSBhbmQgb2Zm
c2V0KSB0aGF0IGlzIHVzZWQgdG8gY29tcGFyZSB0aGUgdGFyZ2V0IHRvIHRoZSBob3QNCj4+Pj4+
Pj4+PiB0YXJnZXQuIFRoaXMgYWxsb3dzIHRvIGRpcmVjdCBhbGwgY29yZXMgdG8gdGhlIGZhc3Qt
cGF0aCwgd2hpbGUgcGF0Y2hpbmcNCj4+Pj4+Pj4+PiB0aGUgc2xvdy1wYXRoIGFuZCB2aWNlLXZl
cnNhLiBQYXRjaGluZyBmb2xsb3dzIDIgbW9yZSBydWxlczogKDEpIE9ubHkNCj4+Pj4+Pj4+PiBw
YXRjaCBhIHNpbmdsZSBieXRlIHdoZW4gdGhlIGNvZGUgbWlnaHQgYmUgZXhlY3V0ZWQgYnkgYW55
IGNvcmUuICgyKQ0KPj4+Pj4+Pj4+IFdoZW4gcGF0Y2hpbmcgbW9yZSB0aGFuIG9uZSBieXRlLCBl
bnN1cmUgdGhhdCBhbGwgY29yZXMgZG8gbm90IHJ1biB0aGUNCj4+Pj4+Pj4+PiB0by1iZS1wYXRj
aGVkLWNvZGUgYnkgcHJldmVudGluZyB0aGlzIGNvZGUgZnJvbSBiZWluZyBwcmVlbXB0ZWQsIGFu
ZA0KPj4+Pj4+Pj4+IHVzaW5nIHN5bmNocm9uaXplX3NjaGVkKCkgYWZ0ZXIgcGF0Y2hpbmcgdGhl
IGJyYW5jaCB0aGF0IGp1bXBzIG92ZXIgdGhpcw0KPj4+Pj4+Pj4+IGNvZGUuDQo+Pj4+Pj4+Pj4g
DQo+Pj4+Pj4+Pj4gQ2hhbmdpbmcgYWxsIHRoZSBpbmRpcmVjdCBjYWxscyB0byB1c2UgcmVscG9s
aW5lcyBpcyBkb25lIHVzaW5nIGFzc2VtYmx5DQo+Pj4+Pj4+Pj4gbWFjcm8gbWFnaWMuIFRoZXJl
IGFyZSBhbHRlcm5hdGl2ZSBzb2x1dGlvbnMsIGJ1dCB0aGlzIG9uZSBpcw0KPj4+Pj4+Pj4+IHJl
bGF0aXZlbHkgc2ltcGxlIGFuZCB0cmFuc3BhcmVudC4gVGhlcmUgaXMgYWxzbyBsb2dpYyB0byBy
ZXRyYWluIHRoZQ0KPj4+Pj4+Pj4+IHNvZnR3YXJlIHByZWRpY3RvciwgYnV0IHRoZSBwb2xpY3kg
aXQgdXNlcyBtYXkgbmVlZCB0byBiZSByZWZpbmVkLg0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IEV2
ZW50dWFsbHkgdGhlIHJlc3VsdHMgYXJlIG5vdCBiYWQgKDIgVkNQVSBWTSwgdGhyb3VnaHB1dCBy
ZXBvcnRlZCk6DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gICAgICAgICBiYXNlICAgICAgICAgICAg
cmVscG9saW5lDQo+Pj4+Pj4+Pj4gICAgICAgICAtLS0tICAgICAgICAgICAgLS0tLS0tLS0tDQo+
Pj4+Pj4+Pj4gbmdpbnggICAgICAyMjg5OCAgICAgICAgICAgMjUxNzggKCsxMCUpDQo+Pj4+Pj4+
Pj4gcmVkaXMteWNzYiAyNDUyMyAgICAgICAgICAgMjU0ODYgKCs0JSkNCj4+Pj4+Pj4+PiBkYmVu
Y2ggICAgIDIxNDQgICAgICAgICAgICAyMTAzICgrMiUpDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4g
V2hlbiByZXRwb2xpbmVzIGFyZSBkaXNhYmxlZCwgYW5kIGlmIHJldHJhaW5pbmcgaXMgb2ZmLCBw
ZXJmb3JtYW5jZQ0KPj4+Pj4+Pj4+IGJlbmVmaXRzIGFyZSB1cCB0byAyJSAobmdpbngpLCBidXQg
YXJlIG11Y2ggbGVzcyBpbXByZXNzaXZlLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBIaSBOYWRhdiwN
Cj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gUGV0ZXIgcG9pbnRlZCBtZSB0byB0aGVzZSBwYXRjaGVzIGR1
cmluZyBhIGRpc2N1c3Npb24gYWJvdXQgcmV0cG9saW5lDQo+Pj4+Pj4+PiBwcm9maWxpbmcuICBQ
ZXJzb25hbGx5LCBJIHRoaW5rIHRoaXMgaXMgYnJpbGxpYW50LiAgVGhpcyBjb3VsZCBoZWxwDQo+
Pj4+Pj4+PiBuZXR3b3JraW5nIGFuZCBmaWxlc3lzdGVtIGludGVuc2l2ZSB3b3JrbG9hZHMgYSBs
b3QuDQo+Pj4+Pj4+IA0KPj4+Pj4+PiBUaGFua3MhIEkgd2FzIGEgYml0IGhlbGQtYmFjayBieSB0
aGUgcmVsYXRpdmVseSBsaW1pdGVkIG51bWJlciBvZiByZXNwb25zZXMuDQo+Pj4+Pj4gDQo+Pj4+
Pj4gSXQgaXMgYSByYXRoZXIsIGVybSwgYW1iaXRpb3VzIGlkZWEsIG1heWJlIHRoZXkgd2VyZSBz
cGVlY2hsZXNzIDotKQ0KPj4+Pj4+IA0KPj4+Pj4+PiBJIGZpbmlzaGVkIGFub3RoZXIgdmVyc2lv
biB0d28gd2Vla3MgYWdvLCBhbmQgZXZlcnkgZGF5IEkgdGhpbms6ICJzaG91bGQgaXQNCj4+Pj4+
Pj4gYmUgUkZDdjIgb3IgdjHigJ0sIGVuZGluZyB1cCBub3Qgc2VuZGluZyBpdOKApg0KPj4+Pj4+
PiANCj4+Pj4+Pj4gVGhlcmUgaXMgb25lIGlzc3VlIHRoYXQgSSByZWFsaXplZCB3aGlsZSB3b3Jr
aW5nIG9uIHRoZSBuZXcgdmVyc2lvbjogSeKAmW0gbm90DQo+Pj4+Pj4+IHN1cmUgaXQgaXMgd2Vs
bC1kZWZpbmVkIHdoYXQgYW4gb3V0bGluZSByZXRwb2xpbmUgaXMgYWxsb3dlZCB0byBkby4gVGhl
DQo+Pj4+Pj4+IGluZGlyZWN0IGJyYW5jaCBwcm9tb3Rpb24gY29kZSBjYW4gY2hhbmdlIHJmbGFn
cywgd2hpY2ggbWlnaHQgY2F1c2UNCj4+Pj4+Pj4gY29ycmVjdGlvbiBpc3N1ZXMuIEluIHByYWN0
aWNlLCB1c2luZyBnY2MsIGl0IGlzIG5vdCBhIHByb2JsZW0uDQo+Pj4+Pj4gDQo+Pj4+Pj4gQ2Fs
bGVlcyBjYW4gY2xvYmJlciBmbGFncywgc28gaXQgc2VlbXMgZmluZSB0byBtZS4NCj4+Pj4+IA0K
Pj4+Pj4gSnVzdCB0byBjaGVjayBJIHVuZGVyc3RhbmQgeW91ciBhcHByb2FjaCByaWdodDogeW91
IG1hZGUgYSBtYWNybw0KPj4+Pj4gY2FsbGVkICJjYWxsIiwgYW5kIHlvdSdyZSB0aGVyZWZvcmUg
Y2F1c2luZyBhbGwgaW5zdGFuY2VzIG9mICJjYWxsIiB0bw0KPj4+Pj4gYmVjb21lIG1hZ2ljPyAg
VGhpcyBpcy4uLiB0ZXJyaWZ5aW5nLiAgSXQncyBldmVuIHBsYXVzaWJseSB3b3JzZSB0aGFuDQo+
Pj4+PiAiI2RlZmluZSBpZiIgOikgIFRoZSBzY2FyaWVzdCBiaXQgaXMgdGhhdCBpdCB3aWxsIGlt
cGFjdCBpbmxpbmUgYXNtIGFzDQo+Pj4+PiB3ZWxsLiAgTWF5YmUgYSBnY2MgcGx1Z2luIHdvdWxk
IGJlIGxlc3MgYWxhcm1pbmc/DQo+Pj4+IA0KPj4+PiBJdCBpcyBsaWtlbHkgdG8gbG9vayBsZXNz
IGFsYXJtaW5nLiBXaGVuIEkgbG9va2VkIGF0IHRoZSBpbmxpbmUgcmV0cG9saW5lDQo+Pj4+IGlt
cGxlbWVudGF0aW9uIG9mIGdjYywgaXQgZGlkbuKAmXQgbG9vayBtdWNoIGJldHRlciB0aGFuIHdo
YXQgSSBkaWQgLSBpdA0KPj4+PiBiYXNpY2FsbHkganVzdCBlbWl0cyBhc3NlbWJseSBpbnN0cnVj
dGlvbnMuDQo+Pj4gDQo+Pj4gVG8gYmUgY2xlYXIsIHRoYXQgd2FzbuKAmXQgYSBOQUsuICBJdCB3
YXMgbWVyZWx5IGEg4oCcdGhpcyBpcyBhbGFybWluZy7igJ0NCj4+IA0KPj4gQWx0aG91Z2guLi4g
aG93IGRvIHlvdSBhdm9pZCBtYXRjaGluZyBvbiB0aGluZ3MgdGhhdCByZWFsbHkgZG9uJ3Qgd2Fu
dA0KPj4gdGhpcyB0cmVhdG1lbnQ/ICBwYXJhdmlydCBvcHMgY29tZSB0byBtaW5kLg0KPiANCj4g
UGFyYXZpcnQgb3BzIGRvbid0IHVzZSByZXRwb2xpbmVzIGJlY2F1c2UgdGhleSdyZSBwYXRjaGVk
IGludG8gZGlyZWN0DQo+IGNhbGxzIGR1cmluZyBib290LiAgU28gTmFkYXYncyBwYXRjaGVzIHdv
bid0IHRvdWNoIHRoZW0uDQoNCkFjdHVhbGx5LCB0aGUgd2F5IGl04oCZcyBoYW5kbGVkIGlzIHNs
aWdodGx5IG1vcmUgY29tcGxpY2F0ZWQgLSB5ZXMsIHRoZSBDQUxMDQptYWNybyBzaG91bGQgbm90
IGJlIGFwcGxpZWQsIGFzIEpvc2ggc2FpZCwgYnV0IHRoZSBxdWVzdGlvbiBpcyBob3cgaXQgaXMN
CmFjaGlldmVkLg0KDQpUaGUgYmFzaWMgaWRlYSBpcyB0aGF0IHRoZSBDQUxMIG1hY3JvIHNob3Vs
ZCBvbmx5IGJlIGFwcGxpZWQgdG8gQw0Kc291cmNlLWZpbGVzIGFuZCBub3QgdG8gYXNzZW1ibHkg
ZmlsZXMgYW5kIGZvciBtYWNyb3Mucywgd2hpY2ggaG9sZHMgdGhlIFBWDQpjYWxsIG1hY3Jvcy4g
SSB3aWxsIHJlY2hlY2sgaXQgaXMgZG9uZSB0aGlzIHdheS4NCg0KUmVnYXJkcywNCk5hZGF2

Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28C1C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1752145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="WS4CzusP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1752145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeJSAtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:49:41 -0400
Received: from mail-cys01nam02on0084.outbound.protection.outlook.com ([104.47.37.84]:56211
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727294AbeJSAtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cC3DtPQ0eaesF+5Oa7LEcIEaheUjEuI6JyjB7q1kY6Y=;
 b=WS4CzusPZaWk4atvkdWXUU6dSx+rLd51ZL21bOgp82apdoIda2s4hdSDy2CrmQpNOydLZaTx1UuJmQaFNXNqzeTzDnEg28pI7r9Sp6fPTU2ix+HVluFm1TdNdeuNKltxh6s3XcNlnf0XETH25FSrjp/vIp+xzfDRpOlHz7S45ko=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5013.namprd05.prod.outlook.com (20.177.230.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.13; Thu, 18 Oct 2018 16:47:08 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1250.024; Thu, 18 Oct 2018
 16:47:08 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Ingo Molnar <mingo@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Thread-Topic: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Thread-Index: AQHUZn1pCzXLEno8kUGEBsbCNoIC6KUkNS4AgAAefQCAAAsFAIAA2LuA
Date:   Thu, 18 Oct 2018 16:47:07 +0000
Message-ID: <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
 <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
 <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
In-Reply-To: <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5013;20:JrVFqNlMtP27CmFiJ4aR2A0WxZo8CjUhNltR3SBF21NGCt3zX1HCT6KBtnbIph+gicqytz3yCAR4rc3zX3D1nkcy77YMeTNLR0mNyTrsO33Z6rdh3xWBJFvJOn8mMswmXzwQMjJ8m+BvpFU7LExSD0Cl75B11j5tIOysYaJky7E=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1833145d-f5c4-49a5-d216-08d6351957b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5013;
x-ms-traffictypediagnostic: BYAPR05MB5013:
x-microsoft-antispam-prvs: <BYAPR05MB501344317FBD1F9CF5C288B2D0F80@BYAPR05MB5013.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5013;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5013;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(396003)(136003)(376002)(189003)(199004)(51444003)(217873002)(7416002)(36756003)(6506007)(76176011)(33656002)(102836004)(86362001)(6486002)(99286004)(26005)(53546011)(82746002)(5660300001)(81166006)(7736002)(81156014)(6512007)(3846002)(6916009)(8936002)(305945005)(25786009)(186003)(316002)(53936002)(106356001)(2900100001)(6116002)(4326008)(71190400001)(2616005)(93886005)(83716004)(478600001)(5250100002)(97736004)(8676002)(105586002)(71200400001)(6246003)(68736007)(476003)(446003)(6436002)(11346002)(2906002)(486006)(14444005)(66066001)(54906003)(256004)(14454004)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5013;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tRdWDhg+rYLWl24+LBaget+Iy4mvOYQEFPDqjfuq07ZTOKbYi3aWy2TsljxoRPECWLaTD5mzl2gu79P/c4A/43IDo+2VhFvPZH9qf6NtvB6Nf0qNTo9XduALeavGNxKzfymkf49irIJe91UGF1tG7iceV8aY3cZqWelzIMfMWNHDcMX2SCsBRC215dSmpceeBkmQZreASHpp75kvYLdYzzk9LFydTY1Vfc2en3ZCoDNDph9Ymjl9lcdEDbabQAgfxE7ZLQntXh008SbZvGht4ZwQ9WcnVi+/06UhoZtncGbrMdA04G0qrX0vcRiZkZ2uiFCxF1n3l91HIkL5xomyMi1AdwxsQFCIUAfK5m+1PI4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE1A3E71B228E9498E17B51CBDC88EA8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1833145d-f5c4-49a5-d216-08d6351957b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 16:47:07.8120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgODo1MSBQTSwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNhcGl0YWwubmV0PiB3cm90ZToN
Cg0KPiBPbiBXZWQsIE9jdCAxNywgMjAxOCBhdCA4OjEyIFBNIE5hZGF2IEFtaXQgPG5hbWl0QHZt
d2FyZS5jb20+IHdyb3RlOg0KPj4gYXQgNjoyMiBQTSwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGFt
YWNhcGl0YWwubmV0PiB3cm90ZToNCj4+IA0KPj4+PiBPbiBPY3QgMTcsIDIwMTgsIGF0IDU6NTQg
UE0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4+PiANCj4+Pj4gSXQg
aXMgc29tZXRpbWVzIGJlbmVmaWNpYWwgdG8gcHJldmVudCBwcmVlbXB0aW9uIGZvciB2ZXJ5IGZl
dw0KPj4+PiBpbnN0cnVjdGlvbnMsIG9yIHByZXZlbnQgcHJlZW1wdGlvbiBmb3Igc29tZSBpbnN0
cnVjdGlvbnMgdGhhdCBwcmVjZWRlDQo+Pj4+IGEgYnJhbmNoICh0aGlzIGxhdHRlciBjYXNlIHdp
bGwgYmUgaW50cm9kdWNlZCBpbiB0aGUgbmV4dCBwYXRjaGVzKS4NCj4+Pj4gDQo+Pj4+IFRvIHBy
b3ZpZGUgc3VjaCBmdW5jdGlvbmFsaXR5IG9uIHg4Ni02NCwgd2UgdXNlIGFuIGVtcHR5IFJFWC1w
cmVmaXgNCj4+Pj4gKG9wY29kZSAweDQwKSBhcyBhbiBpbmRpY2F0aW9uIHRoYXQgcHJlZW1wdGlv
biBpcyBkaXNhYmxlZCBmb3IgdGhlDQo+Pj4+IGZvbGxvd2luZyBpbnN0cnVjdGlvbi4NCj4+PiAN
Cj4+PiBOaWZ0eSENCj4+PiANCj4+PiBUaGF0IGJlaW5nIHNhaWQsIEkgdGhpbmsgeW91IGhhdmUg
YSBmZXcgYnVncy4gRmlyc3QsIHlvdSBjYW7igJl0IGp1c3QgaWdub3JlDQo+Pj4gYSByZXNjaGVk
dWxpbmcgaW50ZXJydXB0LCBhcyB5b3UgaW50cm9kdWNlIHVuYm91bmRlZCBsYXRlbmN5IHdoZW4g
dGhpcw0KPj4+IGhhcHBlbnMg4oCUIHlvdeKAmXJlIGVmZmVjdGl2ZWx5IGVtdWxhdGluZyBwcmVl
bXB0X2VuYWJsZV9ub19yZXNjaGVkKCksIHdoaWNoDQo+Pj4gaXMgbm90IGEgZHJvcC1pbiByZXBs
YWNlbWVudCBmb3IgcHJlZW1wdF9lbmFibGUoKS4gVG8gZml4IHRoaXMsIHlvdSBtYXkNCj4+PiBu
ZWVkIHRvIGp1bXAgdG8gYSBzbG93LXBhdGggdHJhbXBvbGluZSB0aGF0IGNhbGxzIHNjaGVkdWxl
KCkgYXQgdGhlIGVuZCBvcg0KPj4+IGNvbnNpZGVyIHJld2luZGluZyBvbmUgaW5zdHJ1Y3Rpb24g
aW5zdGVhZC4gT3IgdXNlIFRGLCB3aGljaCBpcyBvbmx5IGENCj4+PiBsaXR0bGUgYml0IHRlcnJp
ZnlpbmfigKYNCj4+IA0KPj4gWWVzLCBJIGRpZG7igJl0IHBheSBlbm91Z2ggYXR0ZW50aW9uIGhl
cmUuIEZvciBteSB1c2UtY2FzZSwgSSB0aGluayB0aGF0IHRoZQ0KPj4gZWFzaWVzdCBzb2x1dGlv
biB3b3VsZCBiZSB0byBtYWtlIHN5bmNocm9uaXplX3NjaGVkKCkgaWdub3JlIHByZWVtcHRpb25z
DQo+PiB0aGF0IGhhcHBlbiB3aGlsZSB0aGUgcHJlZml4IGlzIGRldGVjdGVkLiBJdCB3b3VsZCBz
bGlnaHRseSBjaGFuZ2UgdGhlDQo+PiBtZWFuaW5nIG9mIHRoZSBwcmVmaXguDQoNClNvIHRoaW5r
aW5nIGFib3V0IGl0IGZ1cnRoZXIsIHJld2luZGluZyB0aGUgaW5zdHJ1Y3Rpb24gc2VlbXMgdGhl
IGVhc2llc3QNCmFuZCBtb3N0IHJvYnVzdCBzb2x1dGlvbi4gSeKAmWxsIGRvIGl0Lg0KDQo+Pj4g
WW91IGFsc28gYXJlbuKAmXQgYWNjb3VudGluZyBmb3IgdGhlIGNhc2Ugd2hlcmUgeW91IGdldCBh
biBleGNlcHRpb24gdGhhdA0KPj4+IGlzLCBpbiB0dXJuLCBwcmVlbXB0ZWQuDQo+PiANCj4+IEht
bS4uIENhbiB5b3UgZ2l2ZSBtZSBhbiBleGFtcGxlIGZvciBzdWNoIGFuIGV4Y2VwdGlvbiBpbiBt
eSB1c2UtY2FzZT8gSQ0KPj4gY2Fubm90IHRoaW5rIG9mIGFuIGV4Y2VwdGlvbiB0aGF0IG1pZ2h0
IGJlIHByZWVtcHRlZCAoYXNzdW1pbmcgI0JQLCAjTUMNCj4+IGNhbm5vdCBiZSBwcmVlbXB0ZWQp
Lg0KPiANCj4gTG9vayBmb3IgY29uZF9sb2NhbF9pcnFfZW5hYmxlKCkuDQoNCkkgbG9va2VkIGF0
IGl0LiBZZXQsIEkgc3RpbGwgZG9u4oCZdCBzZWUgaG93IGV4Y2VwdGlvbnMgbWlnaHQgaGFwcGVu
IGluIG15DQp1c2UtY2FzZSwgYnV0IGhhdmluZyBzYWlkIHRoYXQgLSB0aGlzIGNhbiBiZSBmaXhl
ZCB0b28uDQoNClRvIGJlIGZyYW5rLCBJIHBhaWQgcmVsYXRpdmVseSBsaXR0bGUgYXR0ZW50aW9u
IHRvIHRoaXMgc3ViamVjdC4gQW55DQpmZWVkYmFjayBhYm91dCB0aGUgb3RoZXIgcGFydHMgYW5k
IGVzcGVjaWFsbHkgb24gdGhlIGhpZ2gtbGV2ZWwgYXBwcm9hY2g/IElzDQptb2RpZnlpbmcgdGhl
IHJldHBvbGluZXMgaW4gdGhlIHByb3Bvc2VkIG1hbm5lciAoYXNzZW1ibHkgbWFjcm9zKQ0KYWNj
ZXB0YWJsZT8NCg0KVGhhbmtzLA0KTmFkYXY=

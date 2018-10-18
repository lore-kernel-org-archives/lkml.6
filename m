Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B48C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA0A2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="f/DaENQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA0A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbeJSB1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:27:40 -0400
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:19140
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbeJSB1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8nhusbk5vqUaq5PpM4LLh8Uu2bGq5xv3cEwvtEK3i0=;
 b=f/DaENQbPZ7ANOrwpytWkBsYmvSijC3y2TZwJtElntKLAeE6rD6tSwGvcZWDMKdkuHQULMd6t6sUdPjxHrZPr6dGc6sTFGn+NB76vu1BQmJCctUnl0BQtSId41bOL5dWIcYHxuO1q39i5dXJT0Jebh2pxzB/ofSnMrLe+M4zExU=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4630.namprd05.prod.outlook.com (52.135.233.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Thu, 18 Oct 2018 17:25:37 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1250.024; Thu, 18 Oct 2018
 17:25:37 +0000
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
Thread-Index: AQHUZn1pCzXLEno8kUGEBsbCNoIC6KUkNS4AgAAefQCAAAsFAIAA2LuAgAADyICAAAb5AA==
Date:   Thu, 18 Oct 2018 17:25:37 +0000
Message-ID: <2054C1A9-37C1-4A5A-A716-EDAC90564D2A@vmware.com>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
 <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
 <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
 <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com>
 <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net>
In-Reply-To: <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4630;20:97yHvg0WRBCTOD885woLRCXU/eD7pHOa1X0Kf+jz262e37lW8fqAlmwZbxZBDYP5+rCmpvKdmAJdcuj5g3Ih+FU5OqHt/ZxAeTH0UPLMl5Io61yaKKBRiWRknGcA6aoleMCFY0nEhZlkC8MGSIpO2ee2S0upIIDpQaR1RJoE/0w=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1d4a17ab-e09f-4b7f-2277-08d6351eb82d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4630;
x-ms-traffictypediagnostic: BYAPR05MB4630:
x-microsoft-antispam-prvs: <BYAPR05MB4630DD97851D16D3E4F6B4F1D0F80@BYAPR05MB4630.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4630;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4630;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(51444003)(199004)(189003)(256004)(76176011)(36756003)(102836004)(229853002)(7736002)(26005)(68736007)(305945005)(81156014)(81166006)(8936002)(6436002)(33656002)(6346003)(6506007)(6486002)(54906003)(99286004)(8676002)(6246003)(3846002)(316002)(53546011)(25786009)(186003)(66066001)(6116002)(2906002)(14454004)(4326008)(7416002)(446003)(11346002)(2616005)(105586002)(476003)(93886005)(486006)(82746002)(478600001)(5660300001)(71200400001)(5250100002)(2900100001)(83716004)(86362001)(97736004)(14444005)(6916009)(71190400001)(106356001)(53936002)(6512007)(217873002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4630;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-message-info: 4q3/9ux/iJx+UrQjX5ASzfH0rOt+FUr3m0vmd3p6Cpjmo1lolY09mjflotRdNsRqPnNMIbMW5BMD+pXBgtLIsh+TqrtNHJKblAv1SASTltLRbfi3x+Qs3S8KXa3YbckSRqO02gmgyE/OY5JD+8ykicUOlRgMb68LmcuYnk9KGfNlPVCo3eV1B12Humpk9ijVABus4XteD/1A3j0SphXed7McBNOZEb5ufvncAUKDgGYkHnCpPbj38QEyTex9mbXHlJYIgLeabQdLqo5V+hWgR2OeAQnc0OEKExpS/g8rzmsw2JURGNcaHfeeIgId8Jsc1q0fBFhTgORoWJB5M1cQ5SyZ8Bab87OYmaCBSPvN6yk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F810E98174DF546AE0546EADE833766@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4a17ab-e09f-4b7f-2277-08d6351eb82d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 17:25:37.2969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTA6MDAgQU0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BhbWFjYXBpdGFsLm5ldD4gd3JvdGU6
DQoNCj4gDQo+IA0KPj4gT24gT2N0IDE4LCAyMDE4LCBhdCA5OjQ3IEFNLCBOYWRhdiBBbWl0IDxu
YW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4+IA0KPj4gYXQgODo1MSBQTSwgQW5keSBMdXRvbWly
c2tpIDxsdXRvQGFtYWNhcGl0YWwubmV0PiB3cm90ZToNCj4+IA0KPj4+PiBPbiBXZWQsIE9jdCAx
NywgMjAxOCBhdCA4OjEyIFBNIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0K
Pj4+PiBhdCA2OjIyIFBNLCBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1hY2FwaXRhbC5uZXQ+IHdy
b3RlOg0KPj4+PiANCj4+Pj4+PiBPbiBPY3QgMTcsIDIwMTgsIGF0IDU6NTQgUE0sIE5hZGF2IEFt
aXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IEl0IGlzIHNvbWV0
aW1lcyBiZW5lZmljaWFsIHRvIHByZXZlbnQgcHJlZW1wdGlvbiBmb3IgdmVyeSBmZXcNCj4+Pj4+
PiBpbnN0cnVjdGlvbnMsIG9yIHByZXZlbnQgcHJlZW1wdGlvbiBmb3Igc29tZSBpbnN0cnVjdGlv
bnMgdGhhdCBwcmVjZWRlDQo+Pj4+Pj4gYSBicmFuY2ggKHRoaXMgbGF0dGVyIGNhc2Ugd2lsbCBi
ZSBpbnRyb2R1Y2VkIGluIHRoZSBuZXh0IHBhdGNoZXMpLg0KPj4+Pj4+IA0KPj4+Pj4+IFRvIHBy
b3ZpZGUgc3VjaCBmdW5jdGlvbmFsaXR5IG9uIHg4Ni02NCwgd2UgdXNlIGFuIGVtcHR5IFJFWC1w
cmVmaXgNCj4+Pj4+PiAob3Bjb2RlIDB4NDApIGFzIGFuIGluZGljYXRpb24gdGhhdCBwcmVlbXB0
aW9uIGlzIGRpc2FibGVkIGZvciB0aGUNCj4+Pj4+PiBmb2xsb3dpbmcgaW5zdHJ1Y3Rpb24uDQo+
Pj4+PiANCj4+Pj4+IE5pZnR5IQ0KPj4+Pj4gDQo+Pj4+PiBUaGF0IGJlaW5nIHNhaWQsIEkgdGhp
bmsgeW91IGhhdmUgYSBmZXcgYnVncy4gRmlyc3QsIHlvdSBjYW7igJl0IGp1c3QgaWdub3JlDQo+
Pj4+PiBhIHJlc2NoZWR1bGluZyBpbnRlcnJ1cHQsIGFzIHlvdSBpbnRyb2R1Y2UgdW5ib3VuZGVk
IGxhdGVuY3kgd2hlbiB0aGlzDQo+Pj4+PiBoYXBwZW5zIOKAlCB5b3XigJlyZSBlZmZlY3RpdmVs
eSBlbXVsYXRpbmcgcHJlZW1wdF9lbmFibGVfbm9fcmVzY2hlZCgpLCB3aGljaA0KPj4+Pj4gaXMg
bm90IGEgZHJvcC1pbiByZXBsYWNlbWVudCBmb3IgcHJlZW1wdF9lbmFibGUoKS4gVG8gZml4IHRo
aXMsIHlvdSBtYXkNCj4+Pj4+IG5lZWQgdG8ganVtcCB0byBhIHNsb3ctcGF0aCB0cmFtcG9saW5l
IHRoYXQgY2FsbHMgc2NoZWR1bGUoKSBhdCB0aGUgZW5kIG9yDQo+Pj4+PiBjb25zaWRlciByZXdp
bmRpbmcgb25lIGluc3RydWN0aW9uIGluc3RlYWQuIE9yIHVzZSBURiwgd2hpY2ggaXMgb25seSBh
DQo+Pj4+PiBsaXR0bGUgYml0IHRlcnJpZnlpbmfigKYNCj4+Pj4gDQo+Pj4+IFllcywgSSBkaWRu
4oCZdCBwYXkgZW5vdWdoIGF0dGVudGlvbiBoZXJlLiBGb3IgbXkgdXNlLWNhc2UsIEkgdGhpbmsg
dGhhdCB0aGUNCj4+Pj4gZWFzaWVzdCBzb2x1dGlvbiB3b3VsZCBiZSB0byBtYWtlIHN5bmNocm9u
aXplX3NjaGVkKCkgaWdub3JlIHByZWVtcHRpb25zDQo+Pj4+IHRoYXQgaGFwcGVuIHdoaWxlIHRo
ZSBwcmVmaXggaXMgZGV0ZWN0ZWQuIEl0IHdvdWxkIHNsaWdodGx5IGNoYW5nZSB0aGUNCj4+Pj4g
bWVhbmluZyBvZiB0aGUgcHJlZml4Lg0KPj4gDQo+PiBTbyB0aGlua2luZyBhYm91dCBpdCBmdXJ0
aGVyLCByZXdpbmRpbmcgdGhlIGluc3RydWN0aW9uIHNlZW1zIHRoZSBlYXNpZXN0DQo+PiBhbmQg
bW9zdCByb2J1c3Qgc29sdXRpb24uIEnigJlsbCBkbyBpdC4NCj4+IA0KPj4+Pj4gWW91IGFsc28g
YXJlbuKAmXQgYWNjb3VudGluZyBmb3IgdGhlIGNhc2Ugd2hlcmUgeW91IGdldCBhbiBleGNlcHRp
b24gdGhhdA0KPj4+Pj4gaXMsIGluIHR1cm4sIHByZWVtcHRlZC4NCj4+Pj4gDQo+Pj4+IEhtbS4u
IENhbiB5b3UgZ2l2ZSBtZSBhbiBleGFtcGxlIGZvciBzdWNoIGFuIGV4Y2VwdGlvbiBpbiBteSB1
c2UtY2FzZT8gSQ0KPj4+PiBjYW5ub3QgdGhpbmsgb2YgYW4gZXhjZXB0aW9uIHRoYXQgbWlnaHQg
YmUgcHJlZW1wdGVkIChhc3N1bWluZyAjQlAsICNNQw0KPj4+PiBjYW5ub3QgYmUgcHJlZW1wdGVk
KS4NCj4+PiANCj4+PiBMb29rIGZvciBjb25kX2xvY2FsX2lycV9lbmFibGUoKS4NCj4+IA0KPj4g
SSBsb29rZWQgYXQgaXQuIFlldCwgSSBzdGlsbCBkb27igJl0IHNlZSBob3cgZXhjZXB0aW9ucyBt
aWdodCBoYXBwZW4gaW4gbXkNCj4+IHVzZS1jYXNlLCBidXQgaGF2aW5nIHNhaWQgdGhhdCAtIHRo
aXMgY2FuIGJlIGZpeGVkIHRvby4NCj4gDQo+IEnigJltIG5vdCB0b3RhbGx5IGNlcnRhaW4gdGhl
cmXigJlzIGEgY2FzZSB0aGF0IG1hdHRlcnMuICBCdXQgaXTigJlzIHdvcnRoIGNoZWNraW5nIA0K
PiANCj4+IFRvIGJlIGZyYW5rLCBJIHBhaWQgcmVsYXRpdmVseSBsaXR0bGUgYXR0ZW50aW9uIHRv
IHRoaXMgc3ViamVjdC4gQW55DQo+PiBmZWVkYmFjayBhYm91dCB0aGUgb3RoZXIgcGFydHMgYW5k
IGVzcGVjaWFsbHkgb24gdGhlIGhpZ2gtbGV2ZWwgYXBwcm9hY2g/IElzDQo+PiBtb2RpZnlpbmcg
dGhlIHJldHBvbGluZXMgaW4gdGhlIHByb3Bvc2VkIG1hbm5lciAoYXNzZW1ibHkgbWFjcm9zKQ0K
Pj4gYWNjZXB0YWJsZT8NCj4gDQo+IEl04oCZcyBjZXJ0YWlubHkgYSBuZWF0IGlkZWEsIGFuZCBp
dCBjb3VsZCBiZSBhIHJlYWwgc3BlZWR1cC4NCg0KR3JlYXQuIFNvIEnigJlsbCB0cnkgdG8gc2hh
cGUgdGhpbmdzIHVwLCBhbmQgSSBzdGlsbCB3YWl0IGZvciBvdGhlciBjb21tZW50cw0KKGZyb20g
b3RoZXJzKS4NCg0KSeKAmWxsIGp1c3QgbWVudGlvbiB0d28gbW9yZSBwYXRjaGVzIEkgbmVlZCB0
byBjbGVhbnVwIChJIGtub3cgSSBzdGlsbCBvd2UgeW91IHNvbWUNCndvcmssIHNvIG9idmlvdXNs
eSBpdCB3aWxsIGJlIGRvbmUgbGF0ZXIpOg0KDQoxLiBTZWNjb21wIHRyYW1wb2xpbmVzLiBPbiBt
eSBVYnVudHUsIHdoZW4gSSBydW4gUmVkaXMsIHN5c3RlbWQgaW5zdGFsbHMgMTcNCkJQRiBmaWx0
ZXJzIG9uIHRoZSBSZWRpcyBzZXJ2ZXIgcHJvY2VzcyB0aGF0IGFyZSBpbnZva2VkIG9uIGVhY2gN
CnN5c3RlbS1jYWxsLiBJbnZva2luZyBlYWNoIG9uZSByZXF1aXJlcyBhbiBpbmRpcmVjdCBicmFu
Y2guIFRoZSBwYXRjaCBrZWVwcw0KYSBwZXItcHJvY2VzcyBrZXJuZWwgY29kZS1wYWdlIHRoYXQg
aG9sZHMgdHJhbXBvbGluZXMgZm9yIHRoZXNlIGZ1bmN0aW9ucy4NCg0KMi4gQmluYXJ5LXNlYXJj
aCBmb3Igc3lzdGVtLWNhbGxzLiBVc2UgdGhlIHBlci1wcm9jZXNzIGtlcm5lbCBjb2RlLXBhZ2Ug
YWxzbw0KdG8gaG9sZCBtdWx0aXBsZSB0cmFtcG9saW5lcyBmb3IgdGhlIDE2IGNvbW1vbiBzeXN0
ZW0gY2FsbHMgb2YgYSBjZXJ0YWluDQpwcm9jZXNzLiBUaGUgcGF0Y2ggdXNlcyBhbiBpbmRpcmVj
dGlvbiB0YWJsZSBhbmQgYSBiaW5hcnktc2VhcmNoIHRvIGZpbmQgdGhlDQpwcm9wZXIgdHJhbXBv
bGluZS4NCg0KVGhhbmtzIGFnYWluLA0KTmFkYXY=

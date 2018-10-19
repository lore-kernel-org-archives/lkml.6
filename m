Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366A2ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3862083A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="FGuGxvCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3862083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeJSMvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 08:51:51 -0400
Received: from mail-co1nam03on0042.outbound.protection.outlook.com ([104.47.40.42]:53120
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726424AbeJSMvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 08:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2eyYel7J/XxYofkVd8aH1lwFHSaurWUG3YmCf2WDOc=;
 b=FGuGxvCxohYJhfW56JhzeqakbmmaBjH5sVJ9wk0RMoraGN30qYyxHKplO7HzDG4xA4Dyn0ew8Vr1Fga6bUEfTKBZi379s767H2FO1CFMXkhvkDxN8d8M/3p7ZDYc1P3DoyCAk06opovaPy9IquFeFYYgxaW3M0DtX3V/pLhuVFc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5622.namprd05.prod.outlook.com (20.177.186.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Fri, 19 Oct 2018 04:44:33 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1250.028; Fri, 19 Oct 2018
 04:44:33 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Thread-Topic: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Thread-Index: AQHUZn1pCzXLEno8kUGEBsbCNoIC6KUkNS4AgAAefQCAAAsFAIAA2LuAgAADyICAAIhGgIAAOD6AgAAEJ4A=
Date:   Fri, 19 Oct 2018 04:44:33 +0000
Message-ID: <37CB98C2-AF9B-475B-8B2D-7B414DC491F3@vmware.com>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
 <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
 <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
 <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com>
 <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net>
 <6F1FD9DA-5E86-42A2-8EAF-05F5D70FE2EF@vmware.com>
 <CALCETrWjeqMs7Z6auStk9VGT9vAn+U5REGE+=TBv1Yh4kmOF3w@mail.gmail.com>
In-Reply-To: <CALCETrWjeqMs7Z6auStk9VGT9vAn+U5REGE+=TBv1Yh4kmOF3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5622;20:4GLqy5gHgYyHkHjvJaqvUEaDVB7/vRhH3ZZMg3UtD5848VTqLFdssi1ZqM7q+ok6YHwLRKueo3PDPPYOwcF6OaGIAMnkXLE62/+TZzqp53MpRnVR8PLLuau7mUutZa0LIXRE29PZHNQAt9M2tB42dtBQwheVWpZ9KtBc6hqZsF0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2204b672-d6a2-4259-4b57-08d6357d90ac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5622;
x-ms-traffictypediagnostic: BYAPR05MB5622:
x-microsoft-antispam-prvs: <BYAPR05MB56222AA717433D19F7CF9549D0F90@BYAPR05MB5622.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5622;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5622;
x-forefront-prvs: 0830866D19
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(189003)(199004)(51444003)(2900100001)(36756003)(106356001)(256004)(71200400001)(25786009)(83716004)(14454004)(8936002)(3846002)(81166006)(8676002)(99286004)(93886005)(478600001)(86362001)(4326008)(71190400001)(5660300001)(81156014)(6116002)(105586002)(2906002)(316002)(26005)(186003)(486006)(110136005)(102836004)(11346002)(446003)(33656002)(54906003)(305945005)(53936002)(82746002)(217873002)(2616005)(66066001)(6436002)(6512007)(39060400002)(5250100002)(14444005)(68736007)(7416002)(6506007)(6486002)(6246003)(76176011)(7736002)(229853002)(53546011)(97736004)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5622;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: w2PpTF2ih+4OAnTrLrmhxMGAcJpMbQDn/xX/nj5qu5f8EMZ42GbUvr0vZ0E0W9EnloCYB/Fqnrwn/8barw/v+9gYhLhUUJJO8FKGPO3UMr2rFl6uR07EcUJqgUf3DeIXk0OQ3ZJ8mphx0trxyL9U1E/99IzxemBdH1X1rEszRIVlKIXWF53MamzqPu5qm4WFB1ZEt7GzpU0oHc3BptP0abTZdmbHvabZnZsRnFi4pIioAaVa6etYlZcqrQeHutyhgdR6xy/rlHTDVoZT0nDhjxeNYELWOfhn4e5gCXi09qLws8k4LGVrEowFyAufV6duWfvfl3awoHQLrNRyvhgjyZjXej+ZUvXzKpPslWQ7Aos=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7FFA932D221044FBE62F7C83474E694@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2204b672-d6a2-4259-4b57-08d6357d90ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 04:44:33.2087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgOToyOSBQTSwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQo+
PiBPbiBPY3QgMTgsIDIwMTgsIGF0IDY6MDggUE0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5j
b20+IHdyb3RlOg0KPj4gDQo+PiBhdCAxMDowMCBBTSwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGFt
YWNhcGl0YWwubmV0PiB3cm90ZToNCj4+IA0KPj4+PiBPbiBPY3QgMTgsIDIwMTgsIGF0IDk6NDcg
QU0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4+PiANCj4+Pj4gYXQg
ODo1MSBQTSwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNhcGl0YWwubmV0PiB3cm90ZToNCj4+
Pj4gDQo+Pj4+Pj4gT24gV2VkLCBPY3QgMTcsIDIwMTggYXQgODoxMiBQTSBOYWRhdiBBbWl0IDxu
YW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4+Pj4+PiBhdCA2OjIyIFBNLCBBbmR5IEx1dG9taXJz
a2kgPGx1dG9AYW1hY2FwaXRhbC5uZXQ+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+Pj4gT24gT2N0
IDE3LCAyMDE4LCBhdCA1OjU0IFBNLCBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90
ZToNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gSXQgaXMgc29tZXRpbWVzIGJlbmVmaWNpYWwgdG8gcHJl
dmVudCBwcmVlbXB0aW9uIGZvciB2ZXJ5IGZldw0KPj4+Pj4+Pj4gaW5zdHJ1Y3Rpb25zLCBvciBw
cmV2ZW50IHByZWVtcHRpb24gZm9yIHNvbWUgaW5zdHJ1Y3Rpb25zIHRoYXQgcHJlY2VkZQ0KPj4+
Pj4+Pj4gYSBicmFuY2ggKHRoaXMgbGF0dGVyIGNhc2Ugd2lsbCBiZSBpbnRyb2R1Y2VkIGluIHRo
ZSBuZXh0IHBhdGNoZXMpLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBUbyBwcm92aWRlIHN1Y2ggZnVu
Y3Rpb25hbGl0eSBvbiB4ODYtNjQsIHdlIHVzZSBhbiBlbXB0eSBSRVgtcHJlZml4DQo+Pj4+Pj4+
PiAob3Bjb2RlIDB4NDApIGFzIGFuIGluZGljYXRpb24gdGhhdCBwcmVlbXB0aW9uIGlzIGRpc2Fi
bGVkIGZvciB0aGUNCj4+Pj4+Pj4+IGZvbGxvd2luZyBpbnN0cnVjdGlvbi4NCj4+Pj4+Pj4gDQo+
Pj4+Pj4+IE5pZnR5IQ0KPj4+Pj4+PiANCj4+Pj4+Pj4gVGhhdCBiZWluZyBzYWlkLCBJIHRoaW5r
IHlvdSBoYXZlIGEgZmV3IGJ1Z3MuIEZpcnN0LCB5b3UgY2Fu4oCZdCBqdXN0IGlnbm9yZQ0KPj4+
Pj4+PiBhIHJlc2NoZWR1bGluZyBpbnRlcnJ1cHQsIGFzIHlvdSBpbnRyb2R1Y2UgdW5ib3VuZGVk
IGxhdGVuY3kgd2hlbiB0aGlzDQo+Pj4+Pj4+IGhhcHBlbnMg4oCUIHlvdeKAmXJlIGVmZmVjdGl2
ZWx5IGVtdWxhdGluZyBwcmVlbXB0X2VuYWJsZV9ub19yZXNjaGVkKCksIHdoaWNoDQo+Pj4+Pj4+
IGlzIG5vdCBhIGRyb3AtaW4gcmVwbGFjZW1lbnQgZm9yIHByZWVtcHRfZW5hYmxlKCkuIFRvIGZp
eCB0aGlzLCB5b3UgbWF5DQo+Pj4+Pj4+IG5lZWQgdG8ganVtcCB0byBhIHNsb3ctcGF0aCB0cmFt
cG9saW5lIHRoYXQgY2FsbHMgc2NoZWR1bGUoKSBhdCB0aGUgZW5kIG9yDQo+Pj4+Pj4+IGNvbnNp
ZGVyIHJld2luZGluZyBvbmUgaW5zdHJ1Y3Rpb24gaW5zdGVhZC4gT3IgdXNlIFRGLCB3aGljaCBp
cyBvbmx5IGENCj4+Pj4+Pj4gbGl0dGxlIGJpdCB0ZXJyaWZ5aW5n4oCmDQo+Pj4+Pj4gDQo+Pj4+
Pj4gWWVzLCBJIGRpZG7igJl0IHBheSBlbm91Z2ggYXR0ZW50aW9uIGhlcmUuIEZvciBteSB1c2Ut
Y2FzZSwgSSB0aGluayB0aGF0IHRoZQ0KPj4+Pj4+IGVhc2llc3Qgc29sdXRpb24gd291bGQgYmUg
dG8gbWFrZSBzeW5jaHJvbml6ZV9zY2hlZCgpIGlnbm9yZSBwcmVlbXB0aW9ucw0KPj4+Pj4+IHRo
YXQgaGFwcGVuIHdoaWxlIHRoZSBwcmVmaXggaXMgZGV0ZWN0ZWQuIEl0IHdvdWxkIHNsaWdodGx5
IGNoYW5nZSB0aGUNCj4+Pj4+PiBtZWFuaW5nIG9mIHRoZSBwcmVmaXguDQo+Pj4+IA0KPj4+PiBT
byB0aGlua2luZyBhYm91dCBpdCBmdXJ0aGVyLCByZXdpbmRpbmcgdGhlIGluc3RydWN0aW9uIHNl
ZW1zIHRoZSBlYXNpZXN0DQo+Pj4+IGFuZCBtb3N0IHJvYnVzdCBzb2x1dGlvbi4gSeKAmWxsIGRv
IGl0Lg0KPj4+PiANCj4+Pj4+Pj4gWW91IGFsc28gYXJlbuKAmXQgYWNjb3VudGluZyBmb3IgdGhl
IGNhc2Ugd2hlcmUgeW91IGdldCBhbiBleGNlcHRpb24gdGhhdA0KPj4+Pj4+PiBpcywgaW4gdHVy
biwgcHJlZW1wdGVkLg0KPj4+Pj4+IA0KPj4+Pj4+IEhtbS4uIENhbiB5b3UgZ2l2ZSBtZSBhbiBl
eGFtcGxlIGZvciBzdWNoIGFuIGV4Y2VwdGlvbiBpbiBteSB1c2UtY2FzZT8gSQ0KPj4+Pj4+IGNh
bm5vdCB0aGluayBvZiBhbiBleGNlcHRpb24gdGhhdCBtaWdodCBiZSBwcmVlbXB0ZWQgKGFzc3Vt
aW5nICNCUCwgI01DDQo+Pj4+Pj4gY2Fubm90IGJlIHByZWVtcHRlZCkuDQo+Pj4+PiANCj4+Pj4+
IExvb2sgZm9yIGNvbmRfbG9jYWxfaXJxX2VuYWJsZSgpLg0KPj4+PiANCj4+Pj4gSSBsb29rZWQg
YXQgaXQuIFlldCwgSSBzdGlsbCBkb27igJl0IHNlZSBob3cgZXhjZXB0aW9ucyBtaWdodCBoYXBw
ZW4gaW4gbXkNCj4+Pj4gdXNlLWNhc2UsIGJ1dCBoYXZpbmcgc2FpZCB0aGF0IC0gdGhpcyBjYW4g
YmUgZml4ZWQgdG9vLg0KPj4+IA0KPj4+IEnigJltIG5vdCB0b3RhbGx5IGNlcnRhaW4gdGhlcmXi
gJlzIGEgY2FzZSB0aGF0IG1hdHRlcnMuICBCdXQgaXTigJlzIHdvcnRoIGNoZWNraW5nDQo+PiAN
Cj4+IEkgYW0gc3RpbGwgY2hlY2tpbmcuIEJ1dCwgSSB3YW50ZWQgdG8gYXNrIHlvdSB3aGV0aGVy
IHRoZSBleGlzdGluZyBjb2RlIGlzDQo+PiBjb3JyZWN0LCBzaW5jZSBpdCBzZWVtcyB0byBtZSB0
aGF0IG90aGVycyBkbyB0aGUgc2FtZSBtaXN0YWtlIEkgZGlkLCB1bmxlc3MNCj4+IEkgZG9u4oCZ
dCB1bmRlcnN0YW5kIHRoZSBjb2RlLg0KPj4gDQo+PiBDb25zaWRlciBmb3IgZXhhbXBsZSBkb19p
bnQzKCksIGFuZCBzZWUgbXkgaW5saW5lZCBjb21tZW50czoNCj4+IA0KPj4gZG90cmFwbGlua2Fn
ZSB2b2lkIG5vdHJhY2UgZG9faW50MyhzdHJ1Y3QgcHRfcmVncyAqcmVncywgbG9uZyBlcnJvcl9j
b2RlKQ0KPj4gew0KPj4gICAuLi4NCj4+ICAgaXN0X2VudGVyKHJlZ3MpOyAgICAgICAgLy8gPT4g
cHJlZW1wdF9kaXNhYmxlKCkNCj4+ICAgY29uZF9sb2NhbF9pcnFfZW5hYmxlKHJlZ3MpOyAgICAv
LyA9PiBhc3N1bWUgaXQgZW5hYmxlcyBJUlFzDQo+PiANCj4+ICAgLi4uDQo+PiAgIC8vIHJlc2No
ZWQgaXJxIGNhbiBiZSBkZWxpdmVyZWQgaGVyZS4gSXQgd2lsbCBub3QgY2F1c2VkIHJlc2NoZWR1
bGluZw0KPj4gICAvLyBzaW5jZSBwcmVlbXB0aW9uIGlzIGRpc2FibGVkDQo+PiANCj4+ICAgY29u
ZF9sb2NhbF9pcnFfZGlzYWJsZShyZWdzKTsgICAgLy8gPT4gYXNzdW1lIGl0IGRpc2FibGVzIElS
UXMNCj4+ICAgaXN0X2V4aXQocmVncyk7ICAgICAgICAgICAgLy8gPT4gcHJlZW1wdF9lbmFibGVf
bm9fcmVzY2hlZCgpDQo+PiB9DQo+PiANCj4+IEF0IHRoaXMgcG9pbnQgcmVzY2hlZCB3aWxsIG5v
dCBoYXBwZW4gZm9yIHVuYm91bmRlZCBsZW5ndGggb2YgdGltZSAodW5sZXNzDQo+PiB0aGVyZSBp
cyBhbm90aGVyIHBvaW50IHdoZW4gZXhpdGluZyB0aGUgdHJhcCBoYW5kbGVyIHRoYXQgY2hlY2tz
IGlmDQo+PiBwcmVlbXB0aW9uIHNob3VsZCB0YWtlIHBsYWNlKS4NCj4gDQo+IEkgdGhpbmsgaXQn
cyBvbmx5IGEgYnVnIGluIHRoZSBjYXNlcyB3aGVyZSBzb21lb25lIHVzZXMgZXh0YWJsZSB0byBm
aXgNCj4gdXAgYW4gaW50MyAod2hpY2ggd291bGQgYmUgbnV0cykgb3IgdGhhdCB3ZSBvb3BzLiAg
QnV0IEkgc2hvdWxkIHN0aWxsDQo+IGZpeCBpdC4gIEluIHRoZSBub3JtYWwgY2FzZSB3aGVyZSBp
bnQzIHdhcyBpbiB1c2VyIGNvZGUsIHdlJ2xsIG1pc3MNCj4gdGhlIHJlc2NoZWR1bGUgaW4gZG9f
dHJhcCgpLCBidXQgd2UnbGwgcmVzY2hlZHVsZSBpbg0KPiBwcmVwYXJlX2V4aXRfdG9fdXNlcm1v
ZGUoKSAtPiBleGl0X3RvX3VzZXJtb2RlX2xvb3AoKS4NCg0KVGhhbmtzIGZvciB5b3VyIHF1aWNr
IHJlc3BvbnNlLCBhbmQgc29ycnkgZm9yIGJvdGhlcmluZyBpbnN0ZWFkIG9mIGRlYWxpbmcNCndp
dGggaXQuIE5vdGUgdGhhdCBkb19kZWJ1ZygpIGRvZXMgc29tZXRoaW5nIHNpbWlsYXIgdG8gZG9f
aW50MygpLg0KDQpBbmQgdGhlbiB0aGVyZSBpcyBvcHRpbWl6ZWRfY2FsbGJhY2soKSB0aGF0IGFs
c28gdXNlcw0KcHJlZW1wdF9lbmFibGVfbm9fcmVzY2hlZCgpLiBJIHRoaW5rIHRoZSBvcmlnaW5h
bCB1c2Ugd2FzIGNvcnJlY3QsIGJ1dCB0aGVuDQphMTliMmUzZDc4MzkgKCJrcHJvYmVzL3g4Njog
UmVtb3ZlIElSUSBkaXNhYmxpbmcgZnJvbSBmdHJhY2UtYmFzZWQvb3B0aW1pemVkDQprcHJvYmVz
4oCdKSByZW1vdmVkIHRoZSBJUlEgZGlzYWJsaW5nLCB3aGlsZSBsZWF2aW5nDQpwcmVlbXB0X2Vu
YWJsZV9ub19yZXNjaGVkKCkgLiBObz8NCg0K

Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625B7C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCAA2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 01:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="l0ceey2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCAA2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeJSJMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 05:12:12 -0400
Received: from mail-dm3nam03on0079.outbound.protection.outlook.com ([104.47.41.79]:61432
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726245AbeJSJMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 05:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwRe9b/kyv3XLIhcMaYH/AlL8ZrdGvodImPZT56EUGg=;
 b=l0ceey2OQgM7Yk+94c/KoeCdOq8wtWl7tvuyA8xBQ4L1LlLe9frUV4xYbD6R6DZD02a37N9P/Br3AIAE4Qm649EY3lfHpRGXzoJaZWdZvDwU9u8Got5SZNcbd7TpQ9UGZCaPXjGHw/l48GJO0/OgTwNoWphPyNWTE8jJ8muA+OM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5094.namprd05.prod.outlook.com (20.177.231.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.18; Fri, 19 Oct 2018 01:08:23 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1250.028; Fri, 19 Oct 2018
 01:08:23 +0000
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
Thread-Index: AQHUZn1pCzXLEno8kUGEBsbCNoIC6KUkNS4AgAAefQCAAAsFAIAA2LuAgAADyICAAIhGgA==
Date:   Fri, 19 Oct 2018 01:08:23 +0000
Message-ID: <6F1FD9DA-5E86-42A2-8EAF-05F5D70FE2EF@vmware.com>
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
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5094;20:nnl1IALlNzMx/nQXQQBg4khF0j6wXt8/AsS+CcrUzV9YsOVben6TBXo+2E1HXvAFabq+orp6p85lPhOE9wv99yTR0OuistiHGEvq3jPjjd7TTFOZMS42AEATr0aIVnfK2oRJ+AoJgd9/uG1H70MGw7rUYWaPq2n9j9Dfq6AxfZI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d5952137-f45e-424d-2e26-08d6355f5def
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5094;
x-ms-traffictypediagnostic: BYAPR05MB5094:
x-microsoft-antispam-prvs: <BYAPR05MB5094B162EA4641103DEC3A5CD0F90@BYAPR05MB5094.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5094;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5094;
x-forefront-prvs: 0830866D19
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(51444003)(199004)(189003)(3846002)(54906003)(105586002)(93886005)(6512007)(316002)(229853002)(26005)(66066001)(2900100001)(446003)(25786009)(7736002)(99286004)(2616005)(106356001)(14444005)(256004)(4326008)(11346002)(36756003)(486006)(6486002)(6436002)(476003)(186003)(305945005)(102836004)(53936002)(14454004)(8676002)(81156014)(6246003)(76176011)(7416002)(86362001)(6506007)(71200400001)(217873002)(83716004)(71190400001)(5660300001)(33656002)(2906002)(53546011)(478600001)(6916009)(82746002)(8936002)(81166006)(68736007)(5250100002)(97736004)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5094;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: u8gV/XRIRO7+XWkmz5hG3zzB/UFChRcXVnnMPqvJDPHDYUJBKii6A+L9LIskoNj5/I1n40aEa3Gg42gaDK8ha3dPB9xu6fGX5BzOQunv3UOVwSJYpXN3kLUNzGKc7IlOKgIobkkZ4Q/lKQhz3E73mB2rTjFdIrSscQcjTpNvBOPUaDLTOYBhOE8ydl2xUia3A6Vb1oF3vn69mnT7n8JVtpkV9cB9bf+9tF5MRUsZSTT78o+mbYzjeiWYGYuDgl2xr+ZKQnfXOd8x/HvwfnjpJUhpcyEf7f+YmZ5j1teqGta6MX315ZI3QCacLR2WJdqcix13bx0oyahWCQOxePaGTh988Kwf+sBKtbp+nd9xJnA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <45ECA944F99B0E4E9436171DBBC32B69@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5952137-f45e-424d-2e26-08d6355f5def
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2018 01:08:23.2023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5094
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
DQpJIGFtIHN0aWxsIGNoZWNraW5nLiBCdXQsIEkgd2FudGVkIHRvIGFzayB5b3Ugd2hldGhlciB0
aGUgZXhpc3RpbmcgY29kZSBpcw0KY29ycmVjdCwgc2luY2UgaXQgc2VlbXMgdG8gbWUgdGhhdCBv
dGhlcnMgZG8gdGhlIHNhbWUgbWlzdGFrZSBJIGRpZCwgdW5sZXNzDQpJIGRvbuKAmXQgdW5kZXJz
dGFuZCB0aGUgY29kZS4NCg0KQ29uc2lkZXIgZm9yIGV4YW1wbGUgZG9faW50MygpLCBhbmQgc2Vl
IG15IGlubGluZWQgY29tbWVudHM6DQoNCmRvdHJhcGxpbmthZ2Ugdm9pZCBub3RyYWNlIGRvX2lu
dDMoc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIGxvbmcgZXJyb3JfY29kZSkNCnsNCgkuLi4NCglpc3Rf
ZW50ZXIocmVncyk7IAkJLy8gPT4gcHJlZW1wdF9kaXNhYmxlKCkNCgljb25kX2xvY2FsX2lycV9l
bmFibGUocmVncyk7CS8vID0+IGFzc3VtZSBpdCBlbmFibGVzIElSUXMNCg0KCS4uLg0KCS8vIHJl
c2NoZWQgaXJxIGNhbiBiZSBkZWxpdmVyZWQgaGVyZS4gSXQgd2lsbCBub3QgY2F1c2VkIHJlc2No
ZWR1bGluZw0KCS8vIHNpbmNlIHByZWVtcHRpb24gaXMgZGlzYWJsZWQNCg0KCWNvbmRfbG9jYWxf
aXJxX2Rpc2FibGUocmVncyk7CS8vID0+IGFzc3VtZSBpdCBkaXNhYmxlcyBJUlFzDQoJaXN0X2V4
aXQocmVncyk7CQkJLy8gPT4gcHJlZW1wdF9lbmFibGVfbm9fcmVzY2hlZCgpDQp9DQoNCkF0IHRo
aXMgcG9pbnQgcmVzY2hlZCB3aWxsIG5vdCBoYXBwZW4gZm9yIHVuYm91bmRlZCBsZW5ndGggb2Yg
dGltZSAodW5sZXNzDQp0aGVyZSBpcyBhbm90aGVyIHBvaW50IHdoZW4gZXhpdGluZyB0aGUgdHJh
cCBoYW5kbGVyIHRoYXQgY2hlY2tzIGlmDQpwcmVlbXB0aW9uIHNob3VsZCB0YWtlIHBsYWNlKS4N
Cg0KQW5vdGhlciBleGFtcGxlIGlzIF9fQlBGX1BST0dfUlVOX0FSUkFZKCksIHdoaWNoIGFsc28g
dXNlcw0KcHJlZW1wdF9lbmFibGVfbm9fcmVzY2hlZCgpLg0KDQpBbSBJIG1pc3Npbmcgc29tZXRo
aW5nPw0KDQpUaGFua3MsDQpOYWRhdg==

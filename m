Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E68ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4C720869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="UTmZpMWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4C720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJSBoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:44:16 -0400
Received: from mail-eopbgr720070.outbound.protection.outlook.com ([40.107.72.70]:51648
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727362AbeJSBoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIt7byZi8dhw0Y/YzMsXUu/eLp+L6sgvXWbClz0qWGs=;
 b=UTmZpMWFCUGQOQB4ugSKXlqJHfsN+iV6NP9FTfipyW+YivDcuvwWJ205QUbFng23TUjQR99MP/vQzGAycoh/sze7pmOjCUvL+n2ay0t/oKK8ltvkVnOwiT/dq6wxZb4FaAIT9apHbePZ3xjcq5Fs510MHI/DuJV6NzppsW594t0=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5157.namprd05.prod.outlook.com (20.177.231.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.13; Thu, 18 Oct 2018 17:42:13 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1250.024; Thu, 18 Oct 2018
 17:42:12 +0000
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
Thread-Index: AQHUZn1pCzXLEno8kUGEBsbCNoIC6KUkNS4AgAAefQCAAAsFAIAA2LuAgAADyICAAAb5AIAAAQWAgAADn4A=
Date:   Thu, 18 Oct 2018 17:42:12 +0000
Message-ID: <1D3E9B8A-9D90-49D9-87D0-185908B425E1@vmware.com>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
 <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
 <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
 <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com>
 <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net>
 <2054C1A9-37C1-4A5A-A716-EDAC90564D2A@vmware.com>
 <CALCETrUQwHysVOJ2G8AQF25TRVaqUi7k93K8nks4Yp+fFehVBA@mail.gmail.com>
In-Reply-To: <CALCETrUQwHysVOJ2G8AQF25TRVaqUi7k93K8nks4Yp+fFehVBA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5157;20:XVNBRJwbuZxAHr+r/6RsdyWB2R6Xvrp+85k1YlC+y89nh3WztexMPmZ60qkJAPNEgNgGIakoFeIIdnXDCNh0JJXWVF5HPkPHdQVL10LUEctPfIW0ZCFDd2ifkZAgfuUDYcU6dVXyQV8U7F/QPqe5bH7gzY+w80vYOGaozbv0/C8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 454930da-3e6f-45b9-f4dc-08d635210989
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5157;
x-ms-traffictypediagnostic: BYAPR05MB5157:
x-microsoft-antispam-prvs: <BYAPR05MB5157D3D4645103CC65189061D0F80@BYAPR05MB5157.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5157;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5157;
x-forefront-prvs: 08296C9B35
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(39860400002)(396003)(346002)(51444003)(189003)(199004)(316002)(6246003)(478600001)(305945005)(93886005)(7416002)(71190400001)(71200400001)(7736002)(83716004)(217873002)(6916009)(5660300001)(446003)(486006)(2900100001)(97736004)(11346002)(2616005)(476003)(68736007)(33656002)(86362001)(5250100002)(186003)(102836004)(66066001)(26005)(105586002)(25786009)(14444005)(256004)(4326008)(106356001)(2906002)(36756003)(229853002)(81166006)(81156014)(8936002)(14454004)(53936002)(6116002)(3846002)(54906003)(6512007)(76176011)(82746002)(6486002)(6506007)(53546011)(6436002)(8676002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5157;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fgXlefinPX83Wy18G0hrdGqnvgyMUQEFwALeICQ9AyynEyZhXvijBcOozNHPtvL50EkYHzTrm0dG1Q6FJoG9OzNQigjG3k2G5TSFnAI6q9psR7fW4LQPkciYUy2dyEUJ4a3X5Ufts/gGXGAT1p3GsIrtFhBWkXw4lwCp6SALDAGYRx/CphQJVvHxhrBtqZm0zE1OiKUCOIFymIo3aoGmHOaLqZLmWpZMcVjZQ8KwIc3Ve4GfG7xn+qffLZ+hiIA66n/bnjmWD4wXClMZpCDMrNxnq9xgr9uVSExRUyT27xxqPwJVa2L9sR/Knar+mYF5vHOph/7km6Vj+oxCDqHuKG3cJQtLASsw0JXZnqFxO48=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0F85A3DFEA59D419AC4E111D226DD04@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454930da-3e6f-45b9-f4dc-08d635210989
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2018 17:42:12.7531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTA6MjkgQU0sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BhbWFjYXBpdGFsLm5ldD4gd3JvdGU6
DQoNCj4gT24gVGh1LCBPY3QgMTgsIDIwMTggYXQgMTA6MjUgQU0gTmFkYXYgQW1pdCA8bmFtaXRA
dm13YXJlLmNvbT4gd3JvdGU6DQo+PiBhdCAxMDowMCBBTSwgQW5keSBMdXRvbWlyc2tpIDxsdXRv
QGFtYWNhcGl0YWwubmV0PiB3cm90ZToNCj4+IA0KPj4+PiBPbiBPY3QgMTgsIDIwMTgsIGF0IDk6
NDcgQU0sIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPj4+PiANCj4+Pj4g
YXQgODo1MSBQTSwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNhcGl0YWwubmV0PiB3cm90ZToN
Cj4+Pj4gDQo+Pj4+Pj4gT24gV2VkLCBPY3QgMTcsIDIwMTggYXQgODoxMiBQTSBOYWRhdiBBbWl0
IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4+Pj4+PiBhdCA2OjIyIFBNLCBBbmR5IEx1dG9t
aXJza2kgPGx1dG9AYW1hY2FwaXRhbC5uZXQ+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+Pj4gT24g
T2N0IDE3LCAyMDE4LCBhdCA1OjU0IFBNLCBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3
cm90ZToNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gSXQgaXMgc29tZXRpbWVzIGJlbmVmaWNpYWwgdG8g
cHJldmVudCBwcmVlbXB0aW9uIGZvciB2ZXJ5IGZldw0KPj4+Pj4+Pj4gaW5zdHJ1Y3Rpb25zLCBv
ciBwcmV2ZW50IHByZWVtcHRpb24gZm9yIHNvbWUgaW5zdHJ1Y3Rpb25zIHRoYXQgcHJlY2VkZQ0K
Pj4+Pj4+Pj4gYSBicmFuY2ggKHRoaXMgbGF0dGVyIGNhc2Ugd2lsbCBiZSBpbnRyb2R1Y2VkIGlu
IHRoZSBuZXh0IHBhdGNoZXMpLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBUbyBwcm92aWRlIHN1Y2gg
ZnVuY3Rpb25hbGl0eSBvbiB4ODYtNjQsIHdlIHVzZSBhbiBlbXB0eSBSRVgtcHJlZml4DQo+Pj4+
Pj4+PiAob3Bjb2RlIDB4NDApIGFzIGFuIGluZGljYXRpb24gdGhhdCBwcmVlbXB0aW9uIGlzIGRp
c2FibGVkIGZvciB0aGUNCj4+Pj4+Pj4+IGZvbGxvd2luZyBpbnN0cnVjdGlvbi4NCj4+Pj4+Pj4g
DQo+Pj4+Pj4+IE5pZnR5IQ0KPj4+Pj4+PiANCj4+Pj4+Pj4gVGhhdCBiZWluZyBzYWlkLCBJIHRo
aW5rIHlvdSBoYXZlIGEgZmV3IGJ1Z3MuIEZpcnN0LCB5b3UgY2Fu4oCZdCBqdXN0IGlnbm9yZQ0K
Pj4+Pj4+PiBhIHJlc2NoZWR1bGluZyBpbnRlcnJ1cHQsIGFzIHlvdSBpbnRyb2R1Y2UgdW5ib3Vu
ZGVkIGxhdGVuY3kgd2hlbiB0aGlzDQo+Pj4+Pj4+IGhhcHBlbnMg4oCUIHlvdeKAmXJlIGVmZmVj
dGl2ZWx5IGVtdWxhdGluZyBwcmVlbXB0X2VuYWJsZV9ub19yZXNjaGVkKCksIHdoaWNoDQo+Pj4+
Pj4+IGlzIG5vdCBhIGRyb3AtaW4gcmVwbGFjZW1lbnQgZm9yIHByZWVtcHRfZW5hYmxlKCkuIFRv
IGZpeCB0aGlzLCB5b3UgbWF5DQo+Pj4+Pj4+IG5lZWQgdG8ganVtcCB0byBhIHNsb3ctcGF0aCB0
cmFtcG9saW5lIHRoYXQgY2FsbHMgc2NoZWR1bGUoKSBhdCB0aGUgZW5kIG9yDQo+Pj4+Pj4+IGNv
bnNpZGVyIHJld2luZGluZyBvbmUgaW5zdHJ1Y3Rpb24gaW5zdGVhZC4gT3IgdXNlIFRGLCB3aGlj
aCBpcyBvbmx5IGENCj4+Pj4+Pj4gbGl0dGxlIGJpdCB0ZXJyaWZ5aW5n4oCmDQo+Pj4+Pj4gDQo+
Pj4+Pj4gWWVzLCBJIGRpZG7igJl0IHBheSBlbm91Z2ggYXR0ZW50aW9uIGhlcmUuIEZvciBteSB1
c2UtY2FzZSwgSSB0aGluayB0aGF0IHRoZQ0KPj4+Pj4+IGVhc2llc3Qgc29sdXRpb24gd291bGQg
YmUgdG8gbWFrZSBzeW5jaHJvbml6ZV9zY2hlZCgpIGlnbm9yZSBwcmVlbXB0aW9ucw0KPj4+Pj4+
IHRoYXQgaGFwcGVuIHdoaWxlIHRoZSBwcmVmaXggaXMgZGV0ZWN0ZWQuIEl0IHdvdWxkIHNsaWdo
dGx5IGNoYW5nZSB0aGUNCj4+Pj4+PiBtZWFuaW5nIG9mIHRoZSBwcmVmaXguDQo+Pj4+IA0KPj4+
PiBTbyB0aGlua2luZyBhYm91dCBpdCBmdXJ0aGVyLCByZXdpbmRpbmcgdGhlIGluc3RydWN0aW9u
IHNlZW1zIHRoZSBlYXNpZXN0DQo+Pj4+IGFuZCBtb3N0IHJvYnVzdCBzb2x1dGlvbi4gSeKAmWxs
IGRvIGl0Lg0KPj4+PiANCj4+Pj4+Pj4gWW91IGFsc28gYXJlbuKAmXQgYWNjb3VudGluZyBmb3Ig
dGhlIGNhc2Ugd2hlcmUgeW91IGdldCBhbiBleGNlcHRpb24gdGhhdA0KPj4+Pj4+PiBpcywgaW4g
dHVybiwgcHJlZW1wdGVkLg0KPj4+Pj4+IA0KPj4+Pj4+IEhtbS4uIENhbiB5b3UgZ2l2ZSBtZSBh
biBleGFtcGxlIGZvciBzdWNoIGFuIGV4Y2VwdGlvbiBpbiBteSB1c2UtY2FzZT8gSQ0KPj4+Pj4+
IGNhbm5vdCB0aGluayBvZiBhbiBleGNlcHRpb24gdGhhdCBtaWdodCBiZSBwcmVlbXB0ZWQgKGFz
c3VtaW5nICNCUCwgI01DDQo+Pj4+Pj4gY2Fubm90IGJlIHByZWVtcHRlZCkuDQo+Pj4+PiANCj4+
Pj4+IExvb2sgZm9yIGNvbmRfbG9jYWxfaXJxX2VuYWJsZSgpLg0KPj4+PiANCj4+Pj4gSSBsb29r
ZWQgYXQgaXQuIFlldCwgSSBzdGlsbCBkb27igJl0IHNlZSBob3cgZXhjZXB0aW9ucyBtaWdodCBo
YXBwZW4gaW4gbXkNCj4+Pj4gdXNlLWNhc2UsIGJ1dCBoYXZpbmcgc2FpZCB0aGF0IC0gdGhpcyBj
YW4gYmUgZml4ZWQgdG9vLg0KPj4+IA0KPj4+IEnigJltIG5vdCB0b3RhbGx5IGNlcnRhaW4gdGhl
cmXigJlzIGEgY2FzZSB0aGF0IG1hdHRlcnMuICBCdXQgaXTigJlzIHdvcnRoIGNoZWNraW5nDQo+
Pj4gDQo+Pj4+IFRvIGJlIGZyYW5rLCBJIHBhaWQgcmVsYXRpdmVseSBsaXR0bGUgYXR0ZW50aW9u
IHRvIHRoaXMgc3ViamVjdC4gQW55DQo+Pj4+IGZlZWRiYWNrIGFib3V0IHRoZSBvdGhlciBwYXJ0
cyBhbmQgZXNwZWNpYWxseSBvbiB0aGUgaGlnaC1sZXZlbCBhcHByb2FjaD8gSXMNCj4+Pj4gbW9k
aWZ5aW5nIHRoZSByZXRwb2xpbmVzIGluIHRoZSBwcm9wb3NlZCBtYW5uZXIgKGFzc2VtYmx5IG1h
Y3JvcykNCj4+Pj4gYWNjZXB0YWJsZT8NCj4+PiANCj4+PiBJdOKAmXMgY2VydGFpbmx5IGEgbmVh
dCBpZGVhLCBhbmQgaXQgY291bGQgYmUgYSByZWFsIHNwZWVkdXAuDQo+PiANCj4+IEdyZWF0LiBT
byBJ4oCZbGwgdHJ5IHRvIHNoYXBlIHRoaW5ncyB1cCwgYW5kIEkgc3RpbGwgd2FpdCBmb3Igb3Ro
ZXIgY29tbWVudHMNCj4+IChmcm9tIG90aGVycykuDQo+PiANCj4+IEnigJlsbCBqdXN0IG1lbnRp
b24gdHdvIG1vcmUgcGF0Y2hlcyBJIG5lZWQgdG8gY2xlYW51cCAoSSBrbm93IEkgc3RpbGwgb3dl
IHlvdSBzb21lDQo+PiB3b3JrLCBzbyBvYnZpb3VzbHkgaXQgd2lsbCBiZSBkb25lIGxhdGVyKToN
Cj4+IA0KPj4gMS4gU2VjY29tcCB0cmFtcG9saW5lcy4gT24gbXkgVWJ1bnR1LCB3aGVuIEkgcnVu
IFJlZGlzLCBzeXN0ZW1kIGluc3RhbGxzIDE3DQo+PiBCUEYgZmlsdGVycyBvbiB0aGUgUmVkaXMg
c2VydmVyIHByb2Nlc3MgdGhhdCBhcmUgaW52b2tlZCBvbiBlYWNoDQo+PiBzeXN0ZW0tY2FsbC4g
SW52b2tpbmcgZWFjaCBvbmUgcmVxdWlyZXMgYW4gaW5kaXJlY3QgYnJhbmNoLiBUaGUgcGF0Y2gg
a2VlcHMNCj4+IGEgcGVyLXByb2Nlc3Mga2VybmVsIGNvZGUtcGFnZSB0aGF0IGhvbGRzIHRyYW1w
b2xpbmVzIGZvciB0aGVzZSBmdW5jdGlvbnMuDQo+IA0KPiBJIHdvbmRlciBob3cgbWFueSBsZXZl
bHMgb2YgYnJhbmNoZXMgYXJlIG5lZWRlZCBiZWZvcmUgdGhlIGJyYW5jaGVzDQo+IGludm9sdmVk
IGV4Y2VlZCB0aGUgcmV0cG9saW5lIGNvc3QuDQoNCkluIHRoaXMgY2FzZSB0aGVyZSBpcyBubyBo
aWVyYXJjaHksIGJ1dCBhIGxpc3Qgb2YgdHJhbXBvbGluZXMgdGhhdCBhcmUNCmNhbGxlZCBvbmUg
YWZ0ZXIgdGhlIG90aGVyLCBhcyB0aGUgc2VjY29tcCBmaWx0ZXIgb3JkZXIgaXMgcHJlZGVmaW5l
ZC4gSXQNCmRvZXMgbm90IHdvcmsgaWYgZGlmZmVyZW50IHRocmVhZHMgb2YgdGhlIHNhbWUgcHJv
Y2VzcyBoYXZlIGRpZmZlcmVudA0KZmlsdGVycy4NCg0KPj4gMi4gQmluYXJ5LXNlYXJjaCBmb3Ig
c3lzdGVtLWNhbGxzLiBVc2UgdGhlIHBlci1wcm9jZXNzIGtlcm5lbCBjb2RlLXBhZ2UgYWxzbw0K
Pj4gdG8gaG9sZCBtdWx0aXBsZSB0cmFtcG9saW5lcyBmb3IgdGhlIDE2IGNvbW1vbiBzeXN0ZW0g
Y2FsbHMgb2YgYSBjZXJ0YWluDQo+PiBwcm9jZXNzLiBUaGUgcGF0Y2ggdXNlcyBhbiBpbmRpcmVj
dGlvbiB0YWJsZSBhbmQgYSBiaW5hcnktc2VhcmNoIHRvIGZpbmQgdGhlDQo+PiBwcm9wZXIgdHJh
bXBvbGluZS4NCj4gDQo+IFNhbWUgY29tbWVudCBhcHBsaWVzIGhlcmUuDQoNCkJyYW5jaCBtaXNw
cmVkaWN0aW9uIHdhc3RlcyB+NyBjeWNsZXMgYW5kIGEgcmV0cG9saW5lIHRha2VzIGF0IGxlYXN0
IDMwLiBTbw0KYXNzdW1pbmcgdGhlIGJyYW5jaCBwcmVkaWN0b3IgaXMgbm90IGNvbXBsZXRlbHkg
c3R1cGlkIDMtNCBsZXZlbHMgc2hvdWxkIG5vdA0KYmUgdG9vIG11Y2guDQoNCg==

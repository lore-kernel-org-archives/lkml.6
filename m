Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52A3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C1C2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="UFeBT9so"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C1C2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbeKGDhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:37:51 -0500
Received: from mail-eopbgr810050.outbound.protection.outlook.com ([40.107.81.50]:9198
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730717AbeKGDhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCHqZ5rn8fRQMAmh3bQYwtJKO2jc/0PZT92cB+KKprY=;
 b=UFeBT9souU4mTfdRt2DTkPAX173uFtAfiamR9SJlIFmC/XnjFGRQ1XbWY8nVsV8igZGYpdFkeFRqkJoB8tyfAomMRD3nXX/PqMuYdF2wd/tQQRarp5/sD/N1xxpl/Kl6OHPeyA4DdagfhFndSJ+fgf33kKU3A/6hsrqqixdmqQc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4533.namprd05.prod.outlook.com (52.135.203.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.16; Tue, 6 Nov 2018 18:11:19 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 18:11:19 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 6/7] x86/alternatives: use temporary mm for text poking
Thread-Topic: [PATCH v3 6/7] x86/alternatives: use temporary mm for text
 poking
Thread-Index: AQHUcwQ5CMopNGTk70+f2dIwnm2sU6VBMXWAgABMjQCAAO8RgIAAUU6AgABTbYA=
Date:   Tue, 6 Nov 2018 18:11:18 +0000
Message-ID: <341D9EA6-8B5E-4EC4-9140-14B5A7FD5690@vmware.com>
References: <20181102232946.98461-1-namit@vmware.com>
 <20181102232946.98461-7-namit@vmware.com>
 <20181105133041.GC22467@hirez.programming.kicks-ass.net>
 <EFF64D16-26DE-437E-99B5-A870921B7D5F@vmware.com>
 <20181106082019.GF22431@hirez.programming.kicks-ass.net>
 <20181106131119.GA9828@hirez.programming.kicks-ass.net>
In-Reply-To: <20181106131119.GA9828@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4533;20:VqKBVdmcwyEHGR6kBTdgBFU+R6XqR96SfTRJelof0OVbOlUA1vZHPsaUfyFl2YZiA0EjfdFMSjU7nxb64ZRjcrCgwMpelWA5I+vCrXETQRqt/yu2AsOKHZ17dQHqLdmpzoBgZ6m4LRrR4D9cs6mJgQvxBT2xW0aMApESu2A5fBw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8397b4b0-333b-491b-c46d-08d644134020
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4533;
x-ms-traffictypediagnostic: BYAPR05MB4533:
x-microsoft-antispam-prvs: <BYAPR05MB45336D50CC84BB8848CBD549D0CB0@BYAPR05MB4533.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(61668805478150)(9452136761055)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4533;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4533;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(366004)(396003)(376002)(189003)(199004)(476003)(6116002)(97736004)(2900100001)(11346002)(2616005)(486006)(3846002)(4326008)(81156014)(81166006)(66066001)(2906002)(7416002)(14444005)(446003)(256004)(82746002)(36756003)(6436002)(7736002)(478600001)(6506007)(8676002)(93886005)(305945005)(99286004)(25786009)(53546011)(54906003)(53936002)(76176011)(229853002)(106356001)(102836004)(105586002)(6512007)(14454004)(186003)(6916009)(316002)(5660300001)(6246003)(68736007)(6486002)(26005)(8936002)(33656002)(86362001)(71200400001)(83716004)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4533;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: InoITXtWDlza0NGRW609VQfHtyhNvjqIJLfDpWw6usp/9l9K/8+4dkLfbctvkAwheVrMHe/ESC028lkLuAMKIlZ/jurgSS8H8oQLH5ZvWg39eCUMzP1xoGLsY6aPz2dQSsFnTt89Og2fbeYMNZZXdCRIIl2JXJ35FV1jKmcd7QfHFlkMsE/8FhFwqbjPK2i301OwxdSyWbqDtRUNka1cTjhWVA11qmWRuwNA7ykWvtbAfqgE33ojMdQD0mp+KFQ9ZAs0gjpOJtPgDykMv3/h+lQ55+D823PGA609b++jlVX3LMO9VvZSMncWA2cKpLUlt+66Ieji0qwe6fNxhQUPeVerxvOa6M/5a3OcA2Fos3E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D72B334AA8103C49A8D00B0E172F2FA1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8397b4b0-333b-491b-c46d-08d644134020
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 18:11:18.8268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4533
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGV0ZXIgWmlqbHN0cmENClNlbnQ6IE5vdmVtYmVyIDYsIDIwMTggYXQgMToxMToxOSBQ
TSBHTVQNCj4gVG86IE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+DQo+IENjOiBJbmdvIE1v
bG5hciA8bWluZ29AcmVkaGF0LmNvbT4sIExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+LCBYODYgTUwgPHg4NkBrZXJuZWwub3JnPiwgSC4gUGV0ZXIgQW52aW4gPGhwYUB6eXRvci5j
b20+LCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4sIEJvcmlzbGF2IFBldGtv
diA8YnBAYWxpZW44LmRlPiwgRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNv
bT4sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwub3JnPiwgS2VlcyBDb29rIDxrZWVzY29v
a0BjaHJvbWl1bS5vcmc+LCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPiwgTWFz
YW1pIEhpcmFtYXRzdSA8bWhpcmFtYXRAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MyA2LzddIHg4Ni9hbHRlcm5hdGl2ZXM6IHVzZSB0ZW1wb3JhcnkgbW0gZm9yIHRleHQgcG9r
aW5nDQo+IA0KPiANCj4gT24gVHVlLCBOb3YgMDYsIDIwMTggYXQgMDk6MjA6MTlBTSArMDEwMCwg
UGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+IA0KPj4gQnkgb3VyIGN1cnJlbnQgd2F5IG9mIHRoaW5r
aW5nLCBrbWFwX2F0b21pYyBzaW1wbHkgaXMgbm90IGNvcnJlY3QuDQo+IA0KPiBTb21ldGhpbmcg
bGlrZSB0aGUgYmVsb3c7IHdoaWNoIHdlaXJkbHkgYnVpbGRzIGFuIHg4Nl8zMiBrZXJuZWwuDQo+
IEFsdGhvdWdoIEkgaW1hZ2luZSBhIHZlcnkgc2FkIG9uZS4NCj4gDQo+IC0tLQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L0tjb25maWcgYi9hcmNoL3g4Ni9LY29uZmlnDQo+IGluZGV4IGJh
N2UzNDY0ZWU5Mi4uZTI3M2YzODc5ZDA0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9LY29uZmln
DQo+ICsrKyBiL2FyY2gveDg2L0tjb25maWcNCj4gQEAgLTE0NDksNiArMTQ0OSwxNiBAQCBjb25m
aWcgUEFHRV9PRkZTRVQNCj4gY29uZmlnIEhJR0hNRU0NCj4gCWRlZl9ib29sIHkNCj4gCWRlcGVu
ZHMgb24gWDg2XzMyICYmIChISUdITUVNNjRHIHx8IEhJR0hNRU00RykNCj4gKwlkZXBlbmRzIG9u
ICFTTVAgfHwgQlJPS0VODQo+ICsJaGVscA0KPiArCSAgQnkgY3VycmVudCB0aGlua2luZyBrbWFw
X2F0b21pYygpIGlzIGJyb2tlbiwgc2luY2UgaXQgcmVsaWVzIG9uIHBlcg0KPiArCSAgQ1BVIFBU
RXMgaW4gdGhlIGdsb2JhbCAoa2VybmVsKSBhZGRyZXNzIHNwYWNlIGFuZCByZWxpZXMgb24gQ1BV
IGxvY2FsDQo+ICsJICBUTEIgaW52YWxpZGF0ZXMgdG8gY29tcGxldGVseSBpbnZhbGlkYXRlIHRo
ZXNlIFBURXMuIEhvd2V2ZXIgdGhlcmUgaXMNCj4gKwkgIG5vdGhpbmcgdGhhdCBndWFyYW50ZWVz
IG90aGVyIENQVXMgd2lsbCBub3Qgc3BlY3VsYXRpdmVseSB0b3VjaCB1cG9uDQo+ICsJICAnb3Vy
JyBmaXhtYXAgUFRFcyBhbmQgbG9hZCB0aGVuIGludG8gdGhlaXIgVExCcywgYWZ0ZXIgd2hpY2gg
b3VyDQo+ICsJICBsb2NhbCBUTEIgaW52YWxpZGF0ZSB3aWxsIG5vdCBpbnZhbGlkYXRlIHRoZW0u
DQo+ICsNCj4gKwkgIFRoZXJlIGFyZSBBTUQgY2hpcHMgdGhhdCB3aWxsICNNQyBvbiBpbmNvbnNp
c3RlbnQgVExCIHN0YXRlcy4NCj4gDQo+IGNvbmZpZyBYODZfUEFFDQo+IAlib29sICJQQUUgKFBo
eXNpY2FsIEFkZHJlc3MgRXh0ZW5zaW9uKSBTdXBwb3J04oCdDQoNClBsZWFzZSBoZWxwIG1lIHVu
ZGVyc3RhbmQgdGhlIHNjZW5hcmlvIHlvdSBhcmUgd29ycmllZCBhYm91dC4gSSBzZWUgc2V2ZXJh
bA0KKHBvdGVudGlhbGx5KSBjb25jZXJuaW5nIHNpdHVhdGlvbnMgZHVlIHRvIGxvbmcgbGl2ZWQg
bWFwcGluZ3M6DQoNCjEuIEluY29uc2lzdGVudCBjYWNoYWJpbGl0eSBpbiB0aGUgUEFUIChiZXR3
ZWVuIHR3byBkaWZmZXJlbnQgbWFwcGluZ3Mgb2YNCnRoZSBzYW1lIHBoeXNpY2FsIG1lbW9yeSks
IGNhdXNpbmcgbWVtb3J5IG9yZGVyaW5nIGlzc3Vlcy4NCg0KMi4gSW5jb25zaXN0ZW50IGFjY2Vz
cy1jb250cm9sIChiZXR3ZWVuIHR3byBkaWZmZXJlbnQgbWFwcGluZ3Mgb2YgdGhlIHNhbWUNCnBo
eXNpY2FsIG1lbW9yeSksIGFsbG93aW5nIHRvIGNpcmN1bXZlbnQgc2VjdXJpdHkgaGFyZGVuaW5n
IG1lY2hhbmlzbXMuDQoNCjMuIEludmFsaWQgY2FjaGFiaWxpdHkgaW4gdGhlIFBBVCBmb3IgTU1J
TywgY2F1c2luZyAjTUMNCg0KNC4gRmF1bHR5IG1lbW9yeSBiZWluZyBtYXBwZWQsIGNhdXNpbmcg
I01DDQoNCjUuIFNvbWUgcG90ZW50aWFsIGRhdGEgbGVha2FnZSBkdWUgdG8gbG9uZyBsaXZlZCBt
YXBwaW5ncw0KDQpUaGUgI01DIHlvdSBtZW50aW9uLCBJIHRoaW5rLCByZWdhcmRzIHNvbWV0aGlu
ZyB0aGF0IHJlc2VtYmxlcyAoMykgLQ0Kc3BlY3VsYXRpdmUgcGFnZS13YWxrcyB1c2luZyBjYWNo
YWJsZSBtZW1vcnkgY2F1c2VkICNNQyB3aGVuIHRoaXMgbWVtb3J5IHdhcw0Kc2V0IG9uIE1NSU8g
cmVnaW9uLiBUaGlzIG1lbW9yeSwgSUlVQywgd2FzIG1pc3Rha2VubHkgcHJlc3VtZWQgdG8gYmUg
dXNlZCBieQ0KcGFnZS10YWJsZXMsIHNvIEkgZG9u4oCZdCBzZWUgaG93IGl0IGlzIHJlbGV2YW50
IGZvciBrbWFwX2F0b21pYygpLg0KDQpBcyBmb3IgdGhlIG90aGVyIHNpdHVhdGlvbnMsIGV4Y2x1
ZGluZyAoMiksIHdoaWNoIHRoaXMgc2VyaWVzIGlzIGludGVuZGVkIHRvDQpkZWFsIHdpdGgsIEkg
ZG9u4oCZdCBzZWUgYSBodWdlIHByb2JsZW0gd2hpY2ggY2Fubm90IGJlIHJlc29sdmVkIGluIGRp
ZmZlcmVudA0KbWVhbnMuDQoNCg==

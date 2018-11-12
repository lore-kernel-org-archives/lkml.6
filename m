Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C9BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F29C20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="aVWJdtDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F29C20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbeKLKAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:00:04 -0500
Received: from mail-eopbgr760045.outbound.protection.outlook.com ([40.107.76.45]:45600
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731042AbeKLKAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 05:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1s87dDRPAoXbW/rouMKE9xBWcZYAQVSnrC78Tdrik4=;
 b=aVWJdtDi6nuVHFbOydG8RONx8BoM3FIrwk5AAIHnMz10UNS+ZYiZkT1MZIAnOTb6xP6OTY4HA2z10hi+kaPN6MuyxUbCFvZbAerDZpUECfzcgbsdlUuBBNHXfgZaNv/qBmJC4GnSBv3Afsa6Bn1GJzAFZtKWde1DGWCX8zzra9c=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5846.namprd05.prod.outlook.com (20.178.49.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.14; Mon, 12 Nov 2018 00:09:32 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1339.018; Mon, 12 Nov 2018
 00:09:32 +0000
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
Subject: Re: [PATCH v4 06/10] x86/alternative: use temporary mm for text
 poking
Thread-Topic: [PATCH v4 06/10] x86/alternative: use temporary mm for text
 poking
Thread-Index: AQHUeYjbLsK1w/h4IEOngRVarOSwtaVKq0EAgABiwQCAADIXAIAABMsA
Date:   Mon, 12 Nov 2018 00:09:32 +0000
Message-ID: <70EACCF7-D854-4051-9F71-4E966FD6C37B@vmware.com>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-7-namit@vmware.com> <20181111145936.GA3021@worktop>
 <43C8C690-F079-4513-82CD-46A62DBA5A3B@vmware.com>
 <20181111235220.GB3056@worktop>
In-Reply-To: <20181111235220.GB3056@worktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5846;20:U/yDI7qJjhmLo/vrsL0cilOHz+255QinXKPU8tloQNuNfpp6uhxpd7zvjfC9ZPOhumkX4KsLQxK+QtC0gv5TiSVjIWvKsqGbGe+R7CMioOQVSgf/oTLmEgq7szytQU6Sj8wOJ90PD0fw2xhojId53d6bNpMRPPeRE2KIaXEqa8Y=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fb6806a9-3d3a-4d61-a10d-08d648331f3b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5846;
x-ms-traffictypediagnostic: BYAPR05MB5846:
x-microsoft-antispam-prvs: <BYAPR05MB5846B904E16AC13B6196F7B1D0C10@BYAPR05MB5846.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5846;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5846;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(376002)(396003)(39860400002)(189003)(199004)(68736007)(83716004)(71200400001)(97736004)(71190400001)(6486002)(446003)(2616005)(256004)(229853002)(478600001)(14444005)(486006)(36756003)(14454004)(25786009)(316002)(54906003)(6916009)(2906002)(99286004)(86362001)(105586002)(106356001)(7416002)(81166006)(102836004)(81156014)(6246003)(2900100001)(3846002)(6116002)(66066001)(8676002)(7736002)(93886005)(186003)(82746002)(6436002)(53936002)(76176011)(33656002)(6512007)(11346002)(476003)(5660300001)(8936002)(6506007)(53546011)(305945005)(26005)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5846;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oIL1aQYjUAro23bYuOYBHzHetJ4uWTw5knFBupL0bQqKPo8JHBimcVaEVupbkZ4plkmFzrA8hRGvfLf+/i/pS2zQWRvfbjbRhkPWbO/m1re9Q1Yohu0SR/BjY69EOva0hTikvKQVAiZJURv4Ur51WIT5W9WWS45Wj9X7JeITWEsW5WJ6HjcXijdL3z5vRAzujTyE1cWJ82WbQ1BxiYPW1+VZkurTYmqENuH7SH5wYwgqpmHysmzoNmcdZaNyNfuHPmvAc++qlAMmCnZwS4rGvR8CFWLrD/C3NziJm7XEMLECkCc6GkKVdDmKiA9vyB1f+Fa3VkEoz2m62M7OUckWnjDtChZn2qaPRm7ej2EFSRo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA6C3C887285B7429A3F5758532199CA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6806a9-3d3a-4d61-a10d-08d648331f3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 00:09:32.2318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5846
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGV0ZXIgWmlqbHN0cmENClNlbnQ6IE5vdmVtYmVyIDExLCAyMDE4IGF0IDExOjUyOjIw
IFBNIEdNVA0KPiBUbzogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4NCj4gQ2M6IEluZ28g
TW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPiwgTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZz4sIFg4NiBNTCA8eDg2QGtlcm5lbC5vcmc+LCBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9y
LmNvbT4sIFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPiwgQm9yaXNsYXYgUGV0
a292IDxicEBhbGllbjguZGU+LCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwu
Y29tPiwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+LCBLZWVzIENvb2sgPGtlZXNj
b29rQGNocm9taXVtLm9yZz4sIERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+LCBN
YXNhbWkgSGlyYW1hdHN1IDxtaGlyYW1hdEBrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY0IDA2LzEwXSB4ODYvYWx0ZXJuYXRpdmU6IHVzZSB0ZW1wb3JhcnkgbW0gZm9yIHRleHQg
cG9raW5nDQo+IA0KPiANCj4gT24gU3VuLCBOb3YgMTEsIDIwMTggYXQgMDg6NTM6MDdQTSArMDAw
MCwgTmFkYXYgQW1pdCB3cm90ZToNCj4gDQo+Pj4+ICsJLyoNCj4+Pj4gKwkgKiBUaGUgbG9jayBp
cyBub3QgcmVhbGx5IG5lZWRlZCwgYnV0IHRoaXMgYWxsb3dzIHRvIGF2b2lkIG9wZW4tY29kaW5n
Lg0KPj4+PiArCSAqLw0KPj4+PiArCXB0ZXAgPSBnZXRfbG9ja2VkX3B0ZShwb2tpbmdfbW0sIHBv
a2luZ19hZGRyLCAmcHRsKTsNCj4+Pj4gKw0KPj4+PiArCS8qDQo+Pj4+ICsJICogSWYgd2UgZmFp
bGVkIHRvIGFsbG9jYXRlIGEgUFRFLCBmYWlsLiBUaGlzIHNob3VsZCAqbmV2ZXIqIGhhcHBlbiwN
Cj4+Pj4gKwkgKiBzaW5jZSB3ZSBwcmVhbGxvY2F0ZSB0aGUgUFRFLg0KPj4+PiArCSAqLw0KPj4+
PiArCWlmIChXQVJOX09OX09OQ0UoIXB0ZXApKQ0KPj4+PiArCQlnb3RvIG91dDsNCj4+PiANCj4+
PiBTaW5jZSB3ZSBoYXJkIHJlbHkgb24gaW5pdCBnZXR0aW5nIHRoYXQgcmlnaHQ7IGNhbid0IHdl
IHNpbXBseSBnZXQgcmlkDQo+Pj4gb2YgdGhpcz8NCj4+IA0KPj4gVGhpcyBpcyBhIHJlcGVhdGVk
IGNvbXBsYWludCBvZiB5b3Vycywgd2hpY2ggSSBkbyBub3QgZmVlbCBjb21mb3J0YWJsZSB3aXRo
Lg0KPj4gT25lIGRheSBzb21lb25lIHdpbGwgcnVuIHNvbWUgc3RhdGljIGFuYWx5c2lzIHRvb2wg
YW5kIHN0YXJ0IGZpbmRpbmcgdGhhdA0KPj4gYWxsIHRoZXNlIGNoZWNrcyBhcmUgbWlzc2luZy4N
Cj4+IA0KPj4gVGhlIHF1ZXN0aW9uIGlzIHdoeSBkbyB5b3UgY2FyZSBhYm91dCB0aGVtLg0KPiAN
Cj4gTW9zdGx5IGJlY2F1c2UgdGhleSBzaG91bGQgbm90IGJlIGhhcHBlbmluZywgZXZlci4gQW5k
IGlmIHRoZXkgaGFwcGVuLA0KPiB0aGVyZSByZWFsbHkgaXNuJ3QgYW55dGhpbmcgc2Vuc2libGUg
d2UgY2FuIGRvIGFib3V0IGl0Lg0KPiANCj4+IElmIGl0IGlzIGJlY2F1c2UgdGhleSBhZmZlY3Qg
dGhlDQo+PiBnZW5lcmF0ZWQgY29kZSBhbmQgbWFrZSBpdCBsZXNzIGVmZmljaWVudCwgSSBjYW4g
ZnVsbHkgdW5kZXJzdGFuZCBhbmQgcGVyaGFwcw0KPj4gd2Ugc2hvdWxkIGhhdmUgc29tZXRoaW5n
IGxpa2UgUEFSQU5PSURfV0FSTl9PTl9PTkNFKCkgd2hpY2ggY29tcGlsZXMgaW50byBub3RoaW5n
DQo+PiB1bmxlc3MgYSBjZXJ0YWluIGRlYnVnIG9wdGlvbiBpcyBzZXQuDQo+PiANCj4+IElmIGl0
IGlzIGFib3V0IHRoZSB3YXkgdGhlIHNvdXJjZSBjb2RlIGxvb2tzIC0gSSBndWVzcyBpdCBkb2Vz
buKAmXQgc29yZSBteQ0KPj4gZXllcyBhcyBoYXJkIGFzIHNvbWUgb3RoZXIgc3R1ZmYsIGFuZCBJ
IGNhbm5vdCBkbyBtdWNoIGFib3V0IGl0IChvdGhlciB0aGFuDQo+PiByZW1vdmluZyBpdCBhcyB5
b3UgYXNrZWQpLg0KPiANCj4gQW5kIHllcyBvbiB0aGUgYWJvdmUgdHdvIHBvaW50cy4gSXQgYWRk
cyBib3RoIHJ1bnRpbWUgb3ZlcmhlYWQgKGFsYmVpdA0KPiB0cml2aWFsbHkgc21hbGwpIGFuZCBj
b2RlIGNvbXBsZXhpdHkuDQoNCkkgdW5kZXJzdGFuZC4gU28gdGhlIHF1ZXN0aW9uIGlzIC0gd2hh
dCB3b3VsZCB5b3UgcHJlZmVyOiBzb21ldGhpbmcgbGlrZQ0KUEFSQU5PSURfV0FSTl9PTl9PTkNF
KCkgb3Igc2hvdWxkIEkganVzdCByZW1vdmUgdGhlIGFzc2VydGlvbj8NCg0KPj4+PiArb3V0Og0K
Pj4+PiArCWlmIChtZW1jbXAoYWRkciwgb3Bjb2RlLCBsZW4pKQ0KPj4+PiArCQlyID0gLUVGQVVM
VDsNCj4+PiANCj4+PiBIb3cgY291bGQgdGhpcyBldmVyIGZhaWw/IEFuZCBob3cgY2FuIHdlIHJl
bGlhYmx5IHJlY292ZXIgZnJvbSB0aGF0Pw0KPj4gDQo+PiBUaGlzIGNvZGUgaGFzIGJlZW4gdGhl
cmUgYmVmb3JlICh3aXRoIHNsaWdodGx5IHVnbGllciBjb2RlKS4gQmVmb3JlIHRoaXMNCj4+IHBh
dGNoLCBhIEJVR19PTigpIHdhcyB1c2VkIGhlcmUuIEhvd2V2ZXIsIEkgbm90aWNlZCB0aGF0IGtn
ZGIgYWN0dWFsbHkNCj4+IGNoZWNrcyB0aGF0IHRleHRfcG9rZSgpIHN1Y2NlZWRlZCBhZnRlciBj
YWxsaW5nIGl0IGFuZCBncmFjZWZ1bGx5IGZhaWwuDQo+PiBIb3dldmVyLCB0aGlzIHdhcyB1c2Vs
ZXNzLCBzaW5jZSB0ZXh0X3Bva2UoKSB3b3VsZCBwYW5pYyBiZWZvcmUga2dkYiBnZXRzDQo+PiB0
aGUgY2hhbmNlIHRvIGRvIGFueXRoaW5nIChzZWUgcGF0Y2ggNykuDQo+IA0KPiBZZXMsIEkga25v
dyBpdCB3YXMgdGhlcmUgYmVmb3JlLCBhbmQgSSBkaWQgc2VlIGtnZGIgZG8gaXQgdG9vLiBCdXQg
YXNpZGUNCj4gZnJvbSB0aGF0IG91dC1sYWJlbCBjYXNlLCB3aGljaCB3ZSBhbHNvIHNob3VsZCBu
ZXZlciBoaXQsIGhvdyBjYW4gd2UNCj4gcmVhbGlzdGljYWxseSBldmVyIGZhaWwgdGhhdCBtZW1j
bXAoKT8NCj4gDQo+IElmIHdlIGZhaWwgaGVyZSwgc29tZXRoaW5nIGlzIF9zZXJpb3VzbHlfIGJ1
Z2dlcmVkLg0KDQpJIGFncmVlLiBCdXQgYXMgaXQgbWF5IGJlIHVzZWZ1bCBhdCBsZWFzdCB0byB3
YXJuIGluIHN1Y2ggYSBjYXNlLCBhcw0KZGVidWdnaW5nIG9mIFNNQy9DTUMgaXMgaGFyZC4gRm9y
IGV4YW1wbGUsIGlmIHRoZXJlIGlzIHNvbWUgc29ydCBvZiBhIHJhY2UNCmJldHdlZW4gbW9kdWxl
ICh1bilsb2FkaW5nIGFuZCBzdGF0aWMta2V5cyAtIHN1Y2ggYSBjaGVjayBtaWdodCBiZQ0KYmVu
ZWZpY2lhbCB0byBpbmRpY2F0ZSBzby4gSGF2aW5nIHNhaWQgdGhhdCwgY2hhbmdpbmcgaXQgaW50
byBWTV9CVUdfT04oKSBvcg0Kc29tZXRoaW5nIHNpbWlsYXIgbWF5IG1ha2UgbW9yZSBzZW5zZS4N
Cg0KUGVyc29uYWxseSwgSSBkb27igJl0IGNhcmUgbXVjaCAtIEnigJltIGp1c3Qgd29ycmllZCB0
aGF0IEkgbWFkZSBzb21lIGludHJ1c2l2ZQ0KY2hhbmdlcyAqYW5kKiB5b3Ugd2FudCBtZSB0byBy
ZW1vdmUgdGhlIGFzc2VydGlvbiB0aGF0IGNoZWNrcyB0aGF0IEkgZGlkbuKAmXQNCnNjcmV3IHVw
Lg0KDQo=

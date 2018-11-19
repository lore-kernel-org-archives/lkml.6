Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0706DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC723208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="lVLh7ofz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC723208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406084AbeKTDme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:42:34 -0500
Received: from mail-eopbgr760048.outbound.protection.outlook.com ([40.107.76.48]:33867
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404730AbeKTDmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5cmhR8C4I+lxrq+ZVcybx1GhbvHuekegIIoIK3IlPA=;
 b=lVLh7ofzBTBpKOA43lDhpwLYirRLpwwvDD3d7NzX75NYqN1LgOwkZMaw+A/uk9DLCSOLdgPGAumCTXTycB2FhvWzFMEl/9FP0GTiGE3NYp2xnUUpezRQuofTzffBkvOmgN/zf/EEinVWb9hZa9b9Ij82uK9ADFdH/TMo/7jsBHI=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5560.namprd05.prod.outlook.com (20.177.186.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Mon, 19 Nov 2018 17:18:07 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a1b8:a948:4c8c:747d%4]) with mapi id 15.20.1361.013; Mon, 19 Nov 2018
 17:18:07 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Makefile: Fix distcc compilation with x86 macros
Thread-Topic: [PATCH v2 1/2] Makefile: Fix distcc compilation with x86 macros
Thread-Index: AQHUfJfvmtKbIIZ6B0mJO/gQ5HjNB6VSB5OAgADeVwCAAg0FgIACa4uA
Date:   Mon, 19 Nov 2018 17:18:06 +0000
Message-ID: <1F17E69E-06E8-4A5A-A434-1DCD6C6F0259@vmware.com>
References: <20181114204309.18645-1-namit@vmware.com>
 <20181114204309.18645-2-namit@vmware.com>
 <CAK7LNAREF_Pcejq1LJ=3K7h0M4o4oSRLfbeJc73O+8HV420Ziw@mail.gmail.com>
 <1C316B94-8F27-439C-B049-9947DC329780@vmware.com>
 <CAK7LNATFVHnPXh-uEA+T9QNw3OnSvkLLKMuJ_tF1v8bEveStSg@mail.gmail.com>
In-Reply-To: <CAK7LNATFVHnPXh-uEA+T9QNw3OnSvkLLKMuJ_tF1v8bEveStSg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5560;20:clyfUE5lh6Z8FCkFsTkN5MunCkl641qQu78uQYZxODqgh5I8DezjBycb2DDiJdMQRPf5ajLqpk6TBNsU31YCOVUUWn+FWl6zZ2JJPpo/iVnMzDIVuzynv8jVdTZW3C9glLzNd6wk98VScef35nhESpzF1gDbds9gUcare2hhy6w=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c16de502-b76a-4163-490d-08d64e42f8f2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5560;
x-ms-traffictypediagnostic: BYAPR05MB5560:
x-microsoft-antispam-prvs: <BYAPR05MB55609CCA2C91201058C0C1A3D0D80@BYAPR05MB5560.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231415)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5560;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5560;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(6486002)(446003)(11346002)(6436002)(2616005)(486006)(6512007)(476003)(14454004)(71190400001)(71200400001)(83716004)(82746002)(229853002)(66066001)(2906002)(25786009)(105586002)(106356001)(5660300001)(2900100001)(478600001)(4326008)(7736002)(575784001)(86362001)(305945005)(102836004)(93886005)(36756003)(53936002)(6246003)(68736007)(6916009)(33656002)(54906003)(99286004)(256004)(8676002)(6116002)(6506007)(26005)(186003)(53546011)(3846002)(81166006)(8936002)(81156014)(316002)(76176011)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5560;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HUvVah2WT1timq54xQQsaAsjdF60C+7sK7rg16mTRZb01vbc/wtMOG25BhJkIK1Y9Vb6XkaeDckJKtj3cFN+Stf3X5bhMCYQRbGedbTaKC8emrvR//bFJ8R8sULXf997c5KzXTyqHISPSeyjlx4oAHe+z7gbAKg86EpetLP7tL4JX2QX8BXVWoAVdPcSdIqGjAEv+/x5nq4t0ihet2ITK8EaTWgZo/IDVVTvIkR9Yc1mnyrTMsUIQEtWfN2nThXyM5DCo9QFxoYT9xfOdUkFQCxY9hG6JB59etOzL66QEhLfQHBQoId1RFbCvnH0c7Sfynn1NFQ7AJ0duCrpqKXVXljSWlHp9v93JSukz3N6J7k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C6E82CD31B0FD4EADBEAE4658B8D0FE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16de502-b76a-4163-490d-08d64e42f8f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 17:18:06.9398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5560
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgODoyMCBQTSwgTWFzYWhpcm8gWWFtYWRhIDx5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNv
bT4gd3JvdGU6DQoNCj4gT24gU2F0LCBOb3YgMTcsIDIwMTggYXQgNjowMiBBTSBOYWRhdiBBbWl0
IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4+IEZyb206IE1hc2FoaXJvIFlhbWFkYQ0KPj4g
U2VudDogTm92ZW1iZXIgMTYsIDIwMTggYXQgNzo0NTo0NSBBTSBHTVQNCj4+PiBUbzogTmFkYXYg
QW1pdCA8bmFtaXRAdm13YXJlLmNvbT4NCj4+PiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhh
dC5jb20+LCBNaWNoYWwgTWFyZWsgPG1pY2hhbC5sa21sQG1hcmtvdmkubmV0PiwgVGhvbWFzIEds
ZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+LCBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5k
ZT4sIEguIFBldGVyIEFudmluIDxocGFAenl0b3IuY29tPiwgWDg2IE1MIDx4ODZAa2VybmVsLm9y
Zz4sIExpbnV4IEtidWlsZCBtYWlsaW5nIGxpc3QgPGxpbnV4LWtidWlsZEB2Z2VyLmtlcm5lbC5v
cmc+LCBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8yXSBNYWtlZmlsZTogRml4IGRpc3Rj
YyBjb21waWxhdGlvbiB3aXRoIHg4NiBtYWNyb3MNCj4+PiANCj4+PiANCj4+PiBPbiBUaHUsIE5v
diAxNSwgMjAxOCBhdCAxOjAxIFBNIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3Rl
Og0KPj4+PiBJbnRyb2R1Y2luZyB0aGUgdXNlIG9mIGFzbSBtYWNyb3MgaW4gYy1jb2RlIGJyb2tl
IGRpc3RjYywgc2luY2UgaXQgb25seQ0KPj4+PiBzZW5kcyB0aGUgcHJlcHJvY2Vzc2VkIHNvdXJj
ZSBmaWxlLiBUaGUgc29sdXRpb24gaXMgdG8gYnJlYWsgdGhlDQo+Pj4+IGNvbXBpbGF0aW9uIGlu
dG8gdHdvIHNlcGFyYXRlIHBoYXNlcyBvZiBjb21waWxhdGlvbiBhbmQgYXNzZW1ibHksIGFuZA0K
Pj4+PiBiZXR3ZWVuIHRoZSB0d28gY29uY2F0ZW5hdGUgdGhlIGFzc2VtYmx5IG1hY3JvcyBhbmQg
dGhlIGNvbXBpbGVkICh5ZXQNCj4+Pj4gbm90IGFzc2VtYmxlZCkgc291cmNlIGZpbGUuIFNpbmNl
IHRoaXMgaXMgbGVzcyBlZmZpY2llbnQsIHRoaXMNCj4+Pj4gY29tcGlsYXRpb24gbW9kZSBpcyBv
bmx5IHVzZWQgd2hlbiBkaXN0Y2Mgb3IgaWNlY2MgYXJlIHVzZWQuDQo+Pj4+IA0KPj4+PiBOb3Rl
IHRoYXQgdGhlIGFzc2VtYmx5IHN0YWdlIHNob3VsZCBhbHNvIGJlIGRpc3RyaWJ1dGVkLCBpZiBk
aXN0Y2MgaXMNCj4+Pj4gY29uZmlndXJlZCB1c2luZyAiQ0ZMQUdTPS1ERU5BQkxFX1JFTU9URV9B
U1NFTUJMRSIuDQo+Pj4+IA0KPj4+PiBSZXBvcnRlZC1ieTogTG9nYW4gR3VudGhvcnBlIDxsb2dh
bmdAZGVsdGF0ZWUuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBOYWRhdiBBbWl0IDxuYW1pdEB2
bXdhcmUuY29tPg0KPj4+IA0KPj4+IA0KPj4+IFdvdywgdGhpcyBpcyBzbyB1Z2x5Lg0KPj4gDQo+
PiBJbmRlZWQsIGl0IGlzIG5vdCBwcmV0dHkgZnJvbSB0aGUgTWFrZWZpbGUgc3lzdGVtIHBvaW50
IG9mIHZpZXcuDQo+PiANCj4+IEJ1dCBpdCBkb2VzIGhhdmUgbWVyaXRzIHdoZW4gaXQgY29tZXMg
dG8gdGhlIGFjdHVhbCB1c2UgKGJ5IGRldmVsb3BlcnMpLiBJZg0KPj4geW91IGxvb2sgb24geDg2
LCB0aGVyZSBhcmUgYSBsb3Qgb2YgZHVwbGljYXRlZCBpbXBsZW1lbnRhdGlvbiBmb3IgQyBhbmQg
QXNtDQo+PiBhbmQgY3JhenkgQyBtYWNyb3MsIGZvciBleGFtcGxlIGZvciBQViBmdW5jdGlvbiBj
YWxsIG9yIHRoZSBhbHRlcm5hdGl2ZQ0KPj4gbWVjaGFuaXNtLiBUaGUgY29kZSBpcyBhbHNvIGxl
c3MgcmVhZGFibGUgaW4gaXRzIGN1cnJlbnQgZm9ybS4NCj4+IA0KPj4+IEkgcmVhbGl6ZWQgaG93
IG11Y2ggSSBoYXRlZCB0aGlzIGJ5IG5vdy4NCj4+PiANCj4+PiBNeSBxdWVzdGlvbiBpcywgaG93
IGxvbmcgZG8gd2UgbmVlZCB0byBjYXJyeSB0aGlzPw0KPj4gDQo+PiBJZiBpdCBpcyBwdXJlbHkg
YWJvdXQgcGVyZm9ybWFuY2UsIEkgYW0gbm90IHN1cmUgaXQgd291bGQgbWFrZSBzZW5zZSB0bw0K
Pj4gcHV0IGl0IGluLCBhcyBpdCB3aWxsIGluZGVlZCBiZSAoZXZlbnR1YWxseSkgc29sdmVkIGJ5
IHRoZSBjb21waWxlciwgYW5kDQo+PiB0aGUgcGVuYWx0eSBpcyBub3QgdG9vIGdyZWF0Lg0KPiAN
Cj4gDQo+IEl0IGlzIHVuZm9ydHVuYXRlIHRvIG1lc3MgdXAgdGhlIGNvZGUNCj4gYnkgaGF2aW5n
IHR3byBkaWZmZXJlbnQgd2F5cyB0byBhY2hpZXZlIHRoZSBzYW1lIGdvYWwuDQoNCkluZGVlZCwg
YnV0IEkgZmFpbCB0byBzZWUgaG93IHRoaXMgc3RhdGVtZW50IGZpdHMgd2l0aCB0aGUgbmV4dCBz
ZW50ZW5jZS4NCg0KPiBXaGVuIEdDQyB3aXRoIGFzbSBpbmxpbmUgc3VwcG9ydCBpcyBzaGlwcGVk
LA0KPiB3b3VsZCB5b3UgcmV2ZXJ0IDc3YjBiZjU1ID8NCg0KVGhpcyBwYXRjaCBhbmQgdGhlIGZv
bGxvd2luZyBvbmVzIHdlcmUgbm90IHdyaXR0ZW4gdG8gYmUgcmV2ZXJ0ZWQsIGkuZS4sDQpyZXZl
cnRpbmcgdGhlbSBsYXRlciBtYXkgbm90IGJlIGVhc3kgc2luY2UgdGhleSByZW1vdmUgcmVkdW5k
YW50IEMgaW5saW5lDQphc3NlbWJseSBjaHVua3MuDQoNClNpbmNlIGdjYyB3aWxsIHNvbHZlIHRo
ZSBpbmxpbmUgYXNzZW1ibHkgaXNzdWVzLCB0aGUgdmFsdWUgb2YgdGhlc2UgcGF0Y2hlcw0KaXMg
aW4gdW5pZnlpbmcgdGhlIGFzc2VtYmx5IHRoYXQgaXMgdXNlZCBpbiAuYyBhbmQgLlMgZmlsZXMu
IER1ZSB0byB0aGUgbGFjaw0Kb2YgbTQtbGlrZSBwcmVwcm9jZXNzb3IgaW4gdGhlIExpbnV4IG1h
a2Utc3lzdGVtLCB0aGUgc29sdXRpb24gaXMgYSBiaXQNCuKAnGhhY2t54oCdIChpbiBvdGhlciB3
b3JkcywgSSBkb27igJl0IHNlZSBhIHJlYXNvbmFibGUgYWx0ZXJuYXRpdmUgc29sdXRpb24pLg0K
DQpTbyB0aGVyZSBpcyBhIGRvd25zaWRlIGluIHRoZSBmb3JtIG9mIHBlcmZvcm1hbmNlIGRlZ3Jh
ZGF0aW9uIG9mIGRpc3RjYywgYW5kDQpoYWNreSAobm90IHRvbyBoYWNreT8pIE1ha2VmaWxlIGNo
YW5nZXMuIE9uIHRoZSB1cHNpZGUsIGV4Y2VwdCBhZGRyZXNzaW5nDQp0aGUgZ2NjIHN0YXRlbWVu
dCBjb3N0IGNvbXB1dGF0aW9uIChpbmxpbmUpIGlzc3VlLCB0aGUgcGF0Y2ggcmVtb3Zlcw0KcmVk
dW5kYW50IGNvZGUsIGFuZCBpbXByb3ZlcyBhc3NlbWJseSBjb2RlIHJlYWRhYmlsaXR5LiBJbiBh
ZGRpdGlvbiwgaXQNCnByb3ZpZGVzIHRoZSBvcHRpb24gdG8gbWFrZSBhc3NlbWJseSBtYW5pcHVs
YXRpb25zIGFmdGVyIGNvbXBpbGF0aW9uLCB3aGljaA0KSFBBIGFuZCBvdGhlcnMgKG1lKSBsb29r
IGludG8uDQoNChBBbnlob3csIGlmIGFmdGVyIGFsbCwgdGhlIGRvd25zaWRlIGlzIGNvbnNpZGVy
ZWQgZ3JlYXRlciB0aGFuIHRoZSB1cHNpZGUsDQppdCBpcyBiZXN0IHRvIHJlbW92ZSB0aGUgcGF0
Y2hlcyBzb29uZXIgdGhhbiBsYXRlciwgYXMgYSByZXZlcnQgbGF0ZXIgd2lsbA0KYmUgbW9yZSBw
YWluZnVsLg0KDQpSZWdhcmRzLA0KTmFkYXY=

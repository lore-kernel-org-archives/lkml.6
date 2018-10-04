Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A613C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422262064E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ikqiENZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422262064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJDRQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:16:10 -0400
Received: from mail-eopbgr680083.outbound.protection.outlook.com ([40.107.68.83]:26400
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727109AbeJDRQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnolxkDOjh220jE2D4msNSmebg1Dzf/sqMksDrflXuM=;
 b=ikqiENZShh5TaGSVimygiWg2iw/FzG/l2pD2x0AKEyeaTWg5oPXmyNaGErUmUzpweiy58LxcOnO+i9dVbSweUSrvxIIE51j9RExxXB5ScqnmXcmOWna7YKpu/jN5D6pmS75uP68vPGlcAf+oO8SV98wibVuqMhE2NxULTJsjplM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4341.namprd05.prod.outlook.com (52.135.202.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Thu, 4 Oct 2018 10:23:29 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%3]) with mapi id 15.20.1207.018; Thu, 4 Oct 2018
 10:23:29 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     "hpa@zytor.com" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Thread-Topic: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Thread-Index: AQHUW2CZEG0GJCpfDkK4fEgcOSwgMqUOuSmAgAAJ9ICAAAHlAIAABIuAgAAEaQCAAAT8gIAABDiAgAAKqIA=
Date:   Thu, 4 Oct 2018 10:23:29 +0000
Message-ID: <29591D3B-D49B-4D7A-B280-85A2C3F63F9C@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com> <20181004075755.GA3353@gmail.com>
 <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
 <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
 <20181004091222.GB21864@gmail.com>
 <D42AB116-BFA4-4CF0-BF45-41C579A9B4C7@vmware.com>
 <20181004094519.GA97692@gmail.com>
In-Reply-To: <20181004094519.GA97692@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4341;20:Ye+6LjcMMVpS3h/Cck0KIhn2L/gsqRFRO6WZ1Uggm4Jc2hseMidB/VmIhuWSqTjxvqlHeantOmRyfDPDfNNYuaFDTLyfSsMy9HVM+zaS/AdGBnLRQHc+Mk7iDc7h3ppl4AV3+R6V7ry9gRoT//FAxS0m/OTxwdPZGeF8+umulrs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a5a9d07e-d716-45ad-43e0-08d629e36de0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4341;
x-ms-traffictypediagnostic: BYAPR05MB4341:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB434184292E039211CCAD710FD0EA0@BYAPR05MB4341.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991048);SRVR:BYAPR05MB4341;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4341;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(199004)(189003)(8676002)(2906002)(33656002)(6506007)(71200400001)(71190400001)(229853002)(6916009)(54906003)(93886005)(316002)(6436002)(97736004)(66066001)(83716004)(6486002)(82746002)(105586002)(6512007)(81166006)(478600001)(53936002)(25786009)(102836004)(2616005)(476003)(186003)(26005)(68736007)(4326008)(99286004)(7416002)(14454004)(11346002)(81156014)(76176011)(7736002)(486006)(86362001)(5660300001)(305945005)(6346003)(446003)(5250100002)(2900100001)(8936002)(6116002)(256004)(3846002)(6246003)(36756003)(14444005)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4341;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-message-info: pZsCcSVtKSC3dkXrk1gR8Y3B1WjDHM/VEPfzsmYFftduOSAZjFd5x3wVzXKWLAalVYtpxiu6+YsbYtgWDYX6ng1J7Y2ogV3f4Nj2KFk1ygM235JsZoRJGW3LnvW7OfpvNtIoaXMHPgi1s2Ug1990jYIpDZGqB6E7theYxecpQgguVAdLrpjZyvG16O1WAY2yCl16UU3TwkKQplAlQVacdR3RWF5C3rs3CIzRGNZIDiRDsT65g6i5N6kixEj+rhz6YZyCo2KKumDJF6FKAnyEpGi7pD2vAGgq029Ds6q0M3nmCn6MUXLxoI1KF8N6VTEol6hH769Fxf0ln9OMA2RDBUvXlbaGr6S9wwZww41MpNQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC32A69EDDE72D4A83F2DA52A70AC0B9@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a9d07e-d716-45ad-43e0-08d629e36de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 10:23:29.5357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4341
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMjo0NSBBTSwgSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQo+IA0K
PiAqIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPiANCj4+PiBBbm90aGVy
LCBzZXBhcmF0ZSBxdWVzdGlvbiBJIHdhbnRlZCB0byBhc2s6IGhvdyBkbyB3ZSBlbnN1cmUgdGhh
dCB0aGUga2VybmVsIHN0YXlzIGZpeGVkPw0KPj4+IEkuZS4gaXMgdGhlcmUgc29tZSB0b29saW5n
IHdlIGNhbiB1c2UgdG8gYWN0dWFsbHkgbWVhc3VyZSB3aGV0aGVyIHRoZXJlJ3MgYmFkIGlubGlu
aW5nIGRlY2lzaW9ucyANCj4+PiBkb25lLCB0byBkZXRlY3QgYWxsIHRoZXNlIGJhZCBwYXR0ZXJu
cyB0aGF0IGNhdXNlIGJhZCBHQ0MgY29kZSBnZW5lcmF0aW9uPw0KPj4gDQo+PiBHb29kIHF1ZXN0
aW9uLiBGaXJzdCwgSeKAmWxsIGluZGljYXRlIHRoYXQgdGhpcyBwYXRjaC1zZXQgZG9lcyBub3Qg
aGFuZGxlIGFsbA0KPj4gdGhlIGlzc3Vlcy4gVGhlcmUgaXMgc3RpbGwgdGhlIGlzc3VlIG9mIGNv
bmRpdGlvbmFsIHVzZSBvZg0KPj4gX19idWlsdGluX2NvbnN0YW50X3AoKS4NCj4+IA0KPj4gT25l
IGluZGljYXRpb24gZm9yIGJhZCBpbmxpbmluZyBkZWNpc2lvbnMgaXMgdGhlIGlubGluZWQgZnVu
Y3Rpb25zIGhhdmUNCj4+IG11bHRpcGxlIChub24taW5saW5lZCkgaW5zdGFuY2VzIGluIHRoZSBi
aW5hcnkgYW5kIGFyZSBzaG9ydC4gSSBkb27igJl0DQo+PiBoYXZlIGFuIGF1dG9tYXRpYyBzb2x1
dGlvbiwgYnV0IHlvdSBjYW4gdHJ5LCBmb3IgZXhhbXBsZSB0byBydW46DQo+PiANCj4+IG5tIC0t
cHJpbnQtc2l6ZSAuL3ZtbGludXggfCBncmVwICcgdCAnIHwgY3V0IC1kJyAnIC1mMi0gfCBzb3J0
IHwgdW5pcSAtYyB8IFwNCj4+IAlncmVwIC12ICdeICAgICAgMScgfCBzb3J0IC1uIC1yIHwgaGVh
ZCAtbiA1DQo+PiANCj4+IFRoZXJlIGFyZSBob3dldmVyIG1hbnkgZmFsc2UgcG9zaXRpdmVzLiBB
ZnRlciB0aGVzZSBwYXRjaGVzLCBmb3IgZXhhbXBsZSwgSQ0KPj4gZ2V0Og0KPj4gDQo+PiAgICAg
MTEgMDAwMDAwMDAwMDAwMDEyZiB0IGpoYXNoDQo+PiAgICAgIDcgMDAwMDAwMDAwMDAwMDAxNyB0
IGRzdF9vdXRwdXQNCj4+ICAgICAgNiAwMDAwMDAwMDAwMDAwMDExIHQga3phbGxvYw0KPj4gICAg
ICA1IDAwMDAwMDAwMDAwMDAwMmYgdCBhY3BpX29zX2FsbG9jYXRlX3plcm9lZA0KPj4gICAgICA1
IDAwMDAwMDAwMDAwMDAwMjkgdCBhY3BpX29zX2FsbG9jYXRlDQo+PiANCj4+IA0KPj4gamhhc2go
KSBzaG91bGQgbm90IGhhdmUgYmVlbiBpbmxpbmVkIGluIG15IG1pbmQsIGFuZCBzaG91bGQgaGF2
ZSBhDQo+PiBub24taW5saW5lZCBpbXBsZW1lbnRhdGlvbi4gZHN0X291dHB1dCgpIGlzIHVzZWQg
YXMgYSBmdW5jdGlvbiBwb2ludGVyLg0KPj4ga3phbGxvYygpIGFuZCB0aGUgbmV4dCB0d28gc3Vm
ZmVyIGZyb20gdGhlIF9fYnVpbHRpbl9jb25zdGFudF9wKCkgcHJvYmxlbSBJDQo+PiBkZXNjcmli
ZWQgaW4gdGhlIHBhc3QuDQo+IA0KPiBPaywgdGhhdCdzIHVzZWZ1bCBpbmZvLg0KPiANCj4gVGhl
IGhpc3RvZ3JhbSBzdWdnZXN0cyB0aGF0IHdpdGggYWxsIHlvdXIgcGF0Y2hlcyBhcHBsaWVkIHRo
ZSBrZXJuZWwgaXMgbm93IGluIGEgcHJldHR5IGdvb2QgDQo+IHN0YXRlIGluIHRlcm1zIG9mIGlu
bGluaW5nIGRlY2lzaW9ucywgcmlnaHQ/DQoNCkl0IHdhcyBqdXN0IGFuIGV4YW1wbGUgdGhhdCBJ
IHJhbiBvbiB0aGUga2VybmVsIEkgYnVpbHQgcmlnaHQgbm93ICh3aXRoIGENCmN1c3RvbSBjb25m
aWcpLiBQbGVhc2UgZG9u4oCZdCByZWdhcmQgdGhlc2UgcmVzdWx0cyBhcyBhbnl0aGluZyBpbmRp
Y2F0aXZlLg0KDQo+IEFyZSB5b3UgdXNpbmcgZGVmY29uZmlnIG9yIGEgcmVhc29uYWJsZSBkaXN0
cm8tY29uZmlnIGZvciB5b3VyIHRlc3RzPw0KDQpJIHRoaW5rIGl0IGlzIGJlc3QgdG8gdGFrZSB0
aGUga2VybmVsIGFuZCBydW4gbG9jYWx5ZXNjb25maWcgZm9yIHRlc3RpbmcuDQoNClRha2luZyBV
YnVudHUgMTguMDQgYW5kIGRvaW5nIHRoZSBzYW1lIGdpdmVzIHRoZSBmb2xsb3dpbmcgcmVzdWx0
czoNCg0KICAgICAxMiAwMDAwMDAwMDAwMDAwMTJmIHQgamhhc2gNCiAgICAgIDcgMDAwMDAwMDAw
MDAwMDAxNyB0IGRzdF9vdXRwdXQNCiAgICAgIDcgMDAwMDAwMDAwMDAwMDAxNCB0IGluaXRfb25j
ZQ0KICAgICAgNSAwMDAwMDAwMDAwMDAwMGQ4IHQgamhhc2gyDQogICAgICA1IDAwMDAwMDAwMDAw
MDAwNGUgdCBwdXRfcGFnZQ0KICAgICAgNSAwMDAwMDAwMDAwMDAwMDJmIHQgYWNwaV9vc19hbGxv
Y2F0ZV96ZXJvZWQNCiAgICAgIDUgMDAwMDAwMDAwMDAwMDAyOSB0IGFjcGlfb3NfYWxsb2NhdGUN
CiAgICAgIDUgMDAwMDAwMDAwMDAwMDAyOCB0IHVtYXNrX3Nob3cNCiAgICAgIDUgMDAwMDAwMDAw
MDAwMDAxMSB0IGt6YWxsb2MNCiAgICAgIDQgMDAwMDAwMDAwMDAwMDA1MyB0IHRyYWNlX3hoY2lf
ZGJnX3F1aXJrcw0KDQpOb3QgYXdmdWwsIGJ1dCBub3QgZ3JlYXQuDQoNCkl0IGlzIGEgYml0IGhh
cmQgdG8gZml4IHRoZSBfX2J1aWx0aW5fY29uc3RhbnRfcCgpIHByb2JsZW0gd2l0aG91dCBoYXZp
bmcNCnNvbWUgbmVnYXRpdmUgc2lkZS1lZmZlY3RzLg0KDQpSZW1pbmRlcjogX19idWlsdGluX2Nv
bnN0YW50X3AoKSBpcyBldmFsdWF0ZWQgYWZ0ZXIgdGhlIGlubGluaW5nIGRlY2lzaW9uDQphcmUg
ZG9uZS4gWW91IGNhbiB1c2UgX19idWlsdGluX2Nob29zZV9leHByKCkgaW5zdGVhZCBvZiBhbiDi
gJxpZuKAnXMgYW5kDQppbnN0ZWFkIG9mIHRlcm5hcnkgb3BlcmF0b3JzIHdoZW4gZXZhbHVhdGlu
ZyBfX2J1aWx0aW5fY29uc3RhbnRfcCgpIHRvIHNvbHZlDQp0aGUgcHJvYmxlbS4gSG93ZXZlciwg
dGhpcyBjYXVzZXMgdGhlIGNvbXBpbGVyIG5vdCB0byBrbm93IHNvbWV0aW1lcyB0aGF0IGENCnZh
bHVlIGlzIGNvbnN0YW50IGJlY2F1c2UgX19idWlsdGluX2Nob29zZV9leHByICgpIGV2YWx1YXRp
b24gaGFwcGVucyB0b28NCmVhcmx5LiBUaGlzIF9fYnVpbHRpbl9jaG9vc2VfZXhwcigpIHByb2Js
ZW0gaXMgdGhlIHJlYXNvbiBmb3IgcHV0X3BhZ2UoKSBhbmQNCmt6YWxsb2MoKSBhcmUgbm90IGJl
aW5nIGlubGluZWQuIENsYW5nLCBhZ2FpbiwgZG9lcyBub3Qgc3VmZmVyIGZyb20gdGhpcw0KcHJv
YmxlbS4NCg0KQW55aG93LCBpdCBtYXkgYmUgYSBnb29kIHByYWN0aWNlIHRvIHRyeSB0byBnZXQg
cmlkIG9mIHRoZSByZXN0LiBGb3INCmV4YW1wbGUsIGRzdF9kaXNjYXJkKCkgaGFzIGZvdXIgaW5z
dGFuY2VzIGJlY2F1c2UgaXQgaXMgYWx3YXlzIGdpdmVuIGFzIGENCmZ1bmN0aW9uIHBvaW50ZXIu
IFNvIGl0IHNob3VsZCBub3QgaGF2ZSBiZWVuIGlubGluZWQuDQoNClJlZ2FyZHMsDQpOYWRhdg==

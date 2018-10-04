Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0CBC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FA821473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="W86mjHfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FA821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeJDQWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:22:43 -0400
Received: from mail-eopbgr710075.outbound.protection.outlook.com ([40.107.71.75]:50466
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbeJDQWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unCNC79bt7HQ1LDrcn5OwFlnLF+aOgHU2JVG22gGbxA=;
 b=W86mjHfQ01wSWpjY8qmhR3jcfIS4MvQbkhQsb5UjRRjHTrQ4Yk8j1nCeP+RayEHcMKWhTUYWODvt2B4giimV+w9TasKU+sCvqVqDFu2c5u7/gsijBU9Vt8BXkq0b6T7PPhdZ7nfoUXZIuYh+sF0TvPjGN3NhNibOiTcRs73cfuI=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4440.namprd05.prod.outlook.com (52.135.203.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Thu, 4 Oct 2018 09:30:16 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%3]) with mapi id 15.20.1207.018; Thu, 4 Oct 2018
 09:30:16 +0000
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
Thread-Index: AQHUW2CZEG0GJCpfDkK4fEgcOSwgMqUOuSmAgAAJ9ICAAAHlAIAABIuAgAAEaQCAAAT8gA==
Date:   Thu, 4 Oct 2018 09:30:15 +0000
Message-ID: <D42AB116-BFA4-4CF0-BF45-41C579A9B4C7@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com> <20181004075755.GA3353@gmail.com>
 <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
 <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
 <20181004091222.GB21864@gmail.com>
In-Reply-To: <20181004091222.GB21864@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4440;20:iSpJ3oTbAKVX+W3LCLEY90oWQ2h1UAg4YGUukSJFMPC30/an82gcPP+aubdFVDM+qO12WgEpMPz6yyadxAdTF3VwHr8Wy+wd8GSmB4V/kkqkMo4MS4yK9vDYREvQm32NDahTRGE9vKkZB5wiqL8tqW9RQnyEVldyG9vK315ZOS0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3621cb98-343e-45b4-d391-08d629dbfe5f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4440;
x-ms-traffictypediagnostic: BYAPR05MB4440:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB44406059554F377AF210B581D0EA0@BYAPR05MB4440.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BYAPR05MB4440;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4440;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(136003)(396003)(189003)(54534003)(199004)(82746002)(6916009)(478600001)(5250100002)(6246003)(53936002)(2906002)(6506007)(3846002)(6116002)(316002)(68736007)(66066001)(5660300001)(305945005)(256004)(14444005)(486006)(97736004)(6512007)(71190400001)(71200400001)(86362001)(83716004)(76176011)(36756003)(25786009)(99286004)(4326008)(81156014)(2900100001)(11346002)(81166006)(26005)(106356001)(8676002)(186003)(6486002)(7736002)(8936002)(2616005)(6436002)(229853002)(7416002)(105586002)(476003)(14454004)(54906003)(102836004)(93886005)(33656002)(446003)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4440;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5Ngqlt7ia/+YxzSs0iQbWf8+Gu2OfWW9JYjkILiiQlf9T+E5f+2bJ8fx3c1Ki/a/qN6UUUEWXyi5LB2LqT+/2MpI+PuQdQhqySPk98NkfAU9vx3k2wswj6b7zvltm4Gm83c/fQZr8YV9t75W25bPbKLnCOvwSwORNUYQrVcJAGm+t6avkQVPZKT00aIjiLHIQPeNY/lsosgm0BN55vfCi7rg2i5HYed/aL6QIiK03jBmWGenHoupoEzn3hmmvX1DC3WCtJhbwN3P35BguWUJuVHgX4zvivuF7XALLiNP2i2HrRn0kobMIQb0mr4I+/P9nmOVcFe9AvdH2hrSBDSdShMYa7EWkWmjU3o0RXJuXSM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <39086A10C69EE947B89FC1D73F0D2248@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3621cb98-343e-45b4-d391-08d629dbfe5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 09:30:15.9585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4440
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMjoxMiBBTSwgSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQo+IA0K
PiAqIE5hZGF2IEFtaXQgPG5hbWl0QHZtd2FyZS5jb20+IHdyb3RlOg0KPiANCj4+IEkgY2FuIHJ1
biBzb21lIHRlc3RzLiAoQGhwYTogSSB0aG91Z2h0IHlvdSBhc2tlZCBhYm91dCB0aGUgLXBpcGUg
b3ZlcmhlYWQ7DQo+PiBwZXJoYXBzIEkgbWlzdW5kZXJzdG9vZCkuDQo+IA0KPiBXZWxsLCB0ZXN0
cyBhcmUgdW5saWtlbHkgdG8gc2hvdyB0aGUgb3ZlcmhlYWQgb2YgZXh0cmEgbGluZXMgb2YgdGhp
cw0KPiBtYWduaXR1ZGUsIHVubGVzcyBkb25lIHZlcnkgY2FyZWZ1bGx5LCB5ZXQgdGhlIGFkZGVk
IGJsb2F0IGV4aXN0cyBhbmQgaXMgbm90IGV2ZW4NCj4gbWVudGlvbmVkIGJ5IHRoZSBjaGFuZ2Vs
b2csIGl0IGp1c3Qgc2F5czoNCj4gDQo+ICBTdWJqZWN0OiBbUEFUQ0ggdjkgMDIvMTBdIE1ha2Vm
aWxlOiBQcmVwYXJlIGZvciB1c2luZyBtYWNyb3MgZm9yIGlubGluZSBhc20NCj4gDQo+ICBVc2lu
ZyBtYWNyb3MgZm9yIGlubGluZSBhc3NlbWJseSBpbXByb3ZlcyBib3RoIHJlYWRhYmlsaXR5IGFu
ZA0KPiAgY29tcGlsYXRpb24gZGVjaXNpb25zIHRoYXQgYXJlIGRpc3RvcnRlZCBieSBiaWcgYXNz
ZW1ibHkgYmxvY2tzIHRoYXQgdXNlDQo+ICBhbHRlcm5hdGl2ZSBzZWN0aW9ucy4gQ29tcGlsZSBt
YWNyb3MuUyBhbmQgdXNlIGl0IHRvIGFzc2VtYmxlIGFsbCBDDQo+ICBmaWxlcy4gQ3VycmVudGx5
LCBvbmx5IHg4NiB3aWxsIHVzZSBpdC4NCj4gDQo+PiBJIGd1ZXNzIHlvdSByZWdhcmQgdG8gdGhl
IHByZXByb2Nlc3Npbmcgb2YgdGhlIGFzc2VtYmxlci4gTm90ZSB0aGF0IHRoZSBDIA0KPj4gcHJl
cHJvY2Vzc2luZyBvZiBtYWNyb3MuUyBvYnZpb3VzbHkgaGFwcGVucyBvbmx5IG9uY2UuIFRoYXTi
gJlzIHRoZSByZWFzb24NCj4+IEkgYXNzdW1lZCBpdOKAmXMgbm90IHRoYXQgZXhwZW5zaXZlLg0K
PiANCj4gVHJ1ZSAtIHNvIGZpcnN0IHdlIGJ1aWxkIG1hY3Jvcy5zLCBhbmQgdGhhdCBnZXRzIGlu
Y2x1ZGVkIGluIGV2ZXJ5IEMgZmlsZSBidWlsZCwgcmlnaHQ/DQpSaWdodC4NCg0KPiANCj4gbWFj
cm9zLnMgaXMgc21hbGxlcjogMjc1IGxpbmVzIG9ubHkgaW4gdGhlIGRpc3RybyB0ZXN0IGJ1aWxk
IEkgdHJpZWQsIHdoaWNoIGxvb2tzDQo+IGEgbG90IGJldHRlciB0aGFuIG15IGZpcnN0IDQsMjAw
IGxpbmVzIGd1ZXNzdGltYXRlLg0KPiANCj4+IEFueWhvdywgSSByZW1lbWJlciB0aGF0IHdlIGRp
c2N1c3NlZCBhdCBzb21lIHBvaW50IGRvaW5nIHNvbWV0aGluZyBsaWtlDQo+PiDigJhhc20o4oCc
LmluY2x1ZGUgWFhYLnPigJ0p4oCZIGFuZCBzb21lYm9keSBzYWlkIGl0IGlzIG5vdCBnb29kLCBi
dXQgSSBkb27igJl0DQo+PiByZW1lbWJlciB3aHkgYW5kIGRvbuKAmXQgc2VlIGFueSByZWFzb24g
aXQgaXMgc28uIFVubGVzcyBJIGFtIG1pc3NpbmcNCj4+IHNvbWV0aGluZywgSSB0aGluayBpdCBp
cyBwb3NzaWJsZSB0byB0YWtlIGVhY2ggaW5kaXZpZHVhbCBoZWFkZXIgYW5kDQo+PiBwcmVwcm9j
ZXNzIHRoZSBhc3NlbWJseSBwYXJ0IG9mIGludG8gYSBzZXBhcmF0ZSAucyBmaWxlLiBUaGVuIHdl
IGNhbiBwdXQgaW4NCj4+IHRoZSBDIHBhcnQgb2YgdGhlIGhlYWRlciDigJhhc20oIi5pbmNsdWRl
IFhYWC5z4oCdKeKAmS4NCj4+IA0KPj4gV2hhdCBkbyB5b3UgdGhpbms/DQo+IA0KPiBIbSwgdGhp
cyBsb29rcyBxdWl0ZSBjb21wbGV4IC0gbWFjcm9zLnMgaXMgYmV0dGVyIEkgdGhpbmsuIEFsc28s
IDI3NSBzdHJhaWdodCBhc3NlbWJseSBsaW5lcyBpcyANCj4gYSBsb3QgYmV0dGVyIHRoYW4gNCwy
MDAuDQoNCknigJltIHJlYWxseSBub3QgaW50byBpdCwgYW5kIGhwYSByZW1pbmRlZCBtZSB3aHkg
aXQgd291bGRu4oCZdCB3b3JrLiBGb3Igc29tZQ0KcmVhc29uIEkgdGhvdWdodCB0aGUgb3JkZXIg
b2YgbWFjcm9zIGRvZXNu4oCZdCBtYXR0ZXIgaW4gYXNtIChJIHByb2JhYmx5DQpzaG91bGQgZ28g
dG8gc2xlZXApLg0KDQo+IEFub3RoZXIsIHNlcGFyYXRlIHF1ZXN0aW9uIEkgd2FudGVkIHRvIGFz
azogaG93IGRvIHdlIGVuc3VyZSB0aGF0IHRoZSBrZXJuZWwgc3RheXMgZml4ZWQ/DQo+IEkuZS4g
aXMgdGhlcmUgc29tZSB0b29saW5nIHdlIGNhbiB1c2UgdG8gYWN0dWFsbHkgbWVhc3VyZSB3aGV0
aGVyIHRoZXJlJ3MgYmFkIGlubGluaW5nIGRlY2lzaW9ucyANCj4gZG9uZSwgdG8gZGV0ZWN0IGFs
bCB0aGVzZSBiYWQgcGF0dGVybnMgdGhhdCBjYXVzZSBiYWQgR0NDIGNvZGUgZ2VuZXJhdGlvbj8N
Cg0KR29vZCBxdWVzdGlvbi4gRmlyc3QsIEnigJlsbCBpbmRpY2F0ZSB0aGF0IHRoaXMgcGF0Y2gt
c2V0IGRvZXMgbm90IGhhbmRsZSBhbGwNCnRoZSBpc3N1ZXMuIFRoZXJlIGlzIHN0aWxsIHRoZSBp
c3N1ZSBvZiBjb25kaXRpb25hbCB1c2Ugb2YNCl9fYnVpbHRpbl9jb25zdGFudF9wKCkuDQoNCk9u
ZSBpbmRpY2F0aW9uIGZvciBiYWQgaW5saW5pbmcgZGVjaXNpb25zIGlzIHRoZSBpbmxpbmVkIGZ1
bmN0aW9ucyBoYXZlDQptdWx0aXBsZSAobm9uLWlubGluZWQpIGluc3RhbmNlcyBpbiB0aGUgYmlu
YXJ5IGFuZCBhcmUgc2hvcnQuIEkgZG9u4oCZdA0KaGF2ZSBhbiBhdXRvbWF0aWMgc29sdXRpb24s
IGJ1dCB5b3UgY2FuIHRyeSwgZm9yIGV4YW1wbGUgdG8gcnVuOg0KDQpubSAtLXByaW50LXNpemUg
Li92bWxpbnV4IHwgZ3JlcCAnIHQgJyB8IGN1dCAtZCcgJyAtZjItIHwgc29ydCB8IHVuaXEgLWMg
fCBcDQoJZ3JlcCAtdiAnXiAgICAgIDEnIHwgc29ydCAtbiAtciB8IGhlYWQgLW4gNQ0KDQpUaGVy
ZSBhcmUgaG93ZXZlciBtYW55IGZhbHNlIHBvc2l0aXZlcy4gQWZ0ZXIgdGhlc2UgcGF0Y2hlcywg
Zm9yIGV4YW1wbGUsIEkNCmdldDoNCg0KICAgICAxMSAwMDAwMDAwMDAwMDAwMTJmIHQgamhhc2gN
CiAgICAgIDcgMDAwMDAwMDAwMDAwMDAxNyB0IGRzdF9vdXRwdXQNCiAgICAgIDYgMDAwMDAwMDAw
MDAwMDAxMSB0IGt6YWxsb2MNCiAgICAgIDUgMDAwMDAwMDAwMDAwMDAyZiB0IGFjcGlfb3NfYWxs
b2NhdGVfemVyb2VkDQogICAgICA1IDAwMDAwMDAwMDAwMDAwMjkgdCBhY3BpX29zX2FsbG9jYXRl
DQoNCg0Kamhhc2goKSBzaG91bGQgbm90IGhhdmUgYmVlbiBpbmxpbmVkIGluIG15IG1pbmQsIGFu
ZCBzaG91bGQgaGF2ZSBhDQpub24taW5saW5lZCBpbXBsZW1lbnRhdGlvbi4gZHN0X291dHB1dCgp
IGlzIHVzZWQgYXMgYSBmdW5jdGlvbiBwb2ludGVyLg0Ka3phbGxvYygpIGFuZCB0aGUgbmV4dCB0
d28gc3VmZmVyIGZyb20gdGhlIF9fYnVpbHRpbl9jb25zdGFudF9wKCkgcHJvYmxlbSBJDQpkZXNj
cmliZWQgaW4gdGhlIHBhc3QuDQoNClJlZ2FyZHMsDQpOYWRhdg==

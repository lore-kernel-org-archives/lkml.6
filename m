Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3787C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BF821473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="FrQyzzX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BF821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeJDPs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:48:56 -0400
Received: from mail-bn3nam01on0067.outbound.protection.outlook.com ([104.47.33.67]:47277
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727310AbeJDPs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n80v1s2EBxdsw906Ahs5QFDp15bMlTIBJQknaIbPTdo=;
 b=FrQyzzX299mXn/+1uKwANF0UTOPNa7HC64NvsQbERKVrTIPO1Le7aZaPoppMhVF41vXnWfdvpuDmP/7lm/+UQkoy5Xxf2XiPQ0gJMi8IwmK7AI5JwHT17qy2IHjB/tfeP0FDwqu06bM2dviJ7fhXV2wr9t1ceofxIj6QTLrSu9o=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4022.namprd05.prod.outlook.com (52.135.199.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.15; Thu, 4 Oct 2018 08:56:37 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%3]) with mapi id 15.20.1207.018; Thu, 4 Oct 2018
 08:56:37 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "hpa@zytor.com" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
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
Thread-Index: AQHUW2CZEG0GJCpfDkK4fEgcOSwgMqUOuSmAgAAJ9ICAAAHlAIAABIuA
Date:   Thu, 4 Oct 2018 08:56:37 +0000
Message-ID: <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com> <20181004075755.GA3353@gmail.com>
 <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
In-Reply-To: <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4022;20:q0QTn6P2eAMFE2Jtjn8o4XTMsggo3MWwqxJgOOPFfD4COR13VRZt3gfHunmn7sks8u79XmZpO+kmAfw/9f9ZEYdD7pTmZgxcSgBNiQ3q31t1aoyCQMcph1PZvzZnppcmbK9cfe+xpdH8cPPiTa6VYLOBRgXPoI2TkALm01wyQaU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5f503bd2-22c9-4752-2486-08d629d74b2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4022;
x-ms-traffictypediagnostic: BYAPR05MB4022:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB40225E0B63C9987E0ED3ADDED0EA0@BYAPR05MB4022.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:BYAPR05MB4022;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4022;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(76176011)(486006)(5660300001)(229853002)(7416002)(6486002)(5250100002)(6436002)(68736007)(186003)(82746002)(2900100001)(26005)(81166006)(97736004)(8676002)(105586002)(106356001)(2501003)(6506007)(99286004)(66066001)(53936002)(33656002)(83716004)(71190400001)(102836004)(6512007)(86362001)(256004)(3846002)(93886005)(14444005)(6246003)(71200400001)(81156014)(476003)(561924002)(6116002)(478600001)(2906002)(25786009)(36756003)(446003)(8936002)(7736002)(110136005)(305945005)(316002)(14454004)(54906003)(11346002)(4326008)(2616005)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4022;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3Kz6tw7CjYI4XC7zOyV6j2RkMSAINwPzj9LwV7kDBcfKvqfXYaueV/Atmmf8EoAzgQg9Ri1h0ox0piJOiFlHodpQBL2AD+fvy4RzftAHjEBfqpBHw5pM1zaZ+hkD/eTXaMCNOXNzUVgQ058gibQU2WyawP4s3Kr+cnQASw5GdAmpdKdMpV3K4CIJK58rmDiLN8xqy4fQOjqjgybK8oyjEmhIyc63ilCZSiPLpHI5oVSDC31TFjSu4YttBrHr3SCyljDKg9wbZl0jnQ379NMBApuhTH40OFi/sbN3V470ACZswdjEmcfAuYp8CKsiUVXnhp0oRSOr+VsGYTYQ1BwjWqnw/Zr8KTlkomnNCdGiCuA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9FF3DA70ED6E94E9159EE487E46AE02@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f503bd2-22c9-4752-2486-08d629d74b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 08:56:37.3767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTo0MCBBTSwgaHBhQHp5dG9yLmNvbSB3cm90ZToNCg0KPiBPbiBPY3RvYmVyIDQsIDIwMTgg
MTozMzozMyBBTSBQRFQsIEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPiB3cm90ZToNCj4+
ICogSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4gDQo+Pj4gSSdtIGFs
c28gc29tZXdoYXQgYW5ub3llZCBhdCB0aGUgZmFjdCB0aGF0IHRoaXMgc2VyaWVzIGNhcnJpZXMg
YQ0KPj4gYm9hdGxvYWQNCj4+PiBvZiByZXZpZXdlZC1ieSdzIGFuZCBhY2tlZC1ieSdzLCB5ZXQg
bm9uZSBvZiB0aG9zZSByZXZpZXdlcnMgZm91bmQgaXQNCj4+PiBpbXBvcnRhbnQgdG8gcG9pbnQg
b3V0IHRoZSBsYXJnZSBjaGFzbSB0aGF0IGlzIGdhcGluZyBiZXR3ZWVuDQo+PiBkZXNjcmlwdGlv
bg0KPj4+IGFuZCByZWFsaXR5Lg0KPj4gDQo+PiBBbm90aGVyIHByb2JsZW0gSSBqdXN0IHJlYWxp
emVkIGlzIHRoYXQgd2Ugbm93IGluY2x1ZGUNCj4+IGFyY2gveDg2L2tlcm5lbC9tYWNyb3MuUyBp
biBldmVyeSANCj4+IHRyYW5zbGF0aW9uIHBhc3Mgd2hlbiBidWlsZGluZyB0aGUga2VybmVsLCBy
aWdodD8NCj4+IA0KPj4gQnV0IGFyY2gveDg2L2tlcm5lbC9tYWNyb3MuUyBleHBhbmRzIHRvIGEg
cHJldHR5IGxhcmdlIGhpZWFyY2h5IG9mDQo+PiBoZWFkZXIgZmlsZXM6DQo+PiANCj4+ICQgbWFr
ZSBhcmNoL3g4Ni9rZXJuZWwvbWFjcm9zLnMNCj4+IA0KPj4gJCBjYXQgJChncmVwIGluY2x1ZGUg
YXJjaC94ODYva2VybmVsL21hY3Jvcy5zIHwgY3V0IC1kXCIgLWYyIHwgc29ydCB8DQo+PiB1bmlx
KSB8IHdjIC1sDQo+PiA0MTI4DQo+PiANCj4+IFRoYXQncyA0LDEwMCBleHRyYSBsaW5lcyBvZiBj
b2RlIHRvIGJlIHByZXByb2Nlc3NlZCBmb3IgZXZlcnkNCj4+IHRyYW5zbGF0aW9uIHVuaXQsIG9m
DQo+PiB3aGljaCB0aGVyZSBhcmUgdGVucyBvZiB0aG91c2FuZHMuIE1vcmUgaWYgb3RoZXIgcGll
Y2VzIG9mIGNvZGUgZ2V0DQo+PiBtYWNyb2ZpZWQgaW4NCj4+IHRoaXMgZmFzaW9uIGluIHRoZSBm
dXR1cmUuDQo+PiANCj4+IElmIHdlIGFzc3VtZSB0aGF0IGEgdHlwaWNhbCBkaXN0cmlidXRpb24g
a2VybmVsIGJ1aWxkIGhhcyB+MjAsMDAwDQo+PiB0cmFuc2xhdGlvbiB1bml0cw0KPj4gdGhlbiB0
aGlzIGNoYW5nZSBhZGRzIDgyLDU2MCwwMDAgbW9yZSBsaW5lcyB0byBiZSBwcmVwcm9jZXNzZWQs
IGp1c3QgdG8NCj4+IHdvcmsgYXJvdW5kDQo+PiBhIHN0dXBpZCBHQ0MgYnVnPw0KPj4gDQo+PiBJ
J20gdG90YWxseSB1bmhhcHB5IGFib3V0IHRoYXQuIENhbiB3ZSBkbyB0aGlzIHdpdGhvdXQgYWRk
aW5nIG1hY3Jvcy5TPw0KPj4gDQo+PiBJdCdzIGFsc28gYSBwcmV0dHkgc3R1cGlkbHkgY2VudHJh
bCBmaWxlIGFueXdheSB0aGF0IG1vdmVzIHNvdXJjZSBjb2RlDQo+PiBhd2F5DQo+PiBmcm9tIHdo
ZXJlIGl0J3MgdXNlZC4NCj4+IA0KPj4gVGhhbmtzLA0KPj4gDQo+PiAJSW5nbw0KPiANCj4gSXQn
cyBub3QganVzdCBmb3Igd29ya2luZyBhcm91bmQgYSBzdHVwaWQgR0NDIGJ1ZywgYnV0IGl0IGFs
c28gaGFzIGEgaHVnZQ0KPiBwb3RlbnRpYWwgZm9yIGNsZWFuaW5nIHVwIHRoZSBpbmxpbmUgYXNt
IGluIGdlbmVyYWwuDQo+IA0KPiBJIHdvdWxkIGxpa2UgdG8ga25vdyBpZiB0aGVyZSBpcyBhbiBh
Y3R1YWwgbnVtYmVyIGZvciB0aGUgYnVpbGQgb3ZlcmhlYWQNCj4gKGFuIGFjdHVhbCBiZW5jaG1h
cmspOyBJIGhhdmUgYXNrZWQgZm9yIHRoYXQgb25jZSBhbHJlYWR5Lg0KDQpJIGNhbiBydW4gc29t
ZSB0ZXN0cy4gKEBocGE6IEkgdGhvdWdodCB5b3UgYXNrZWQgYWJvdXQgdGhlIC1waXBlIG92ZXJo
ZWFkOw0KcGVyaGFwcyBJIG1pc3VuZGVyc3Rvb2QpLg0KDQpJIGd1ZXNzIHlvdSByZWdhcmQgdG8g
dGhlIHByZXByb2Nlc3Npbmcgb2YgdGhlIGFzc2VtYmxlci4gTm90ZSB0aGF0IHRoZSBDIA0KcHJl
cHJvY2Vzc2luZyBvZiBtYWNyb3MuUyBvYnZpb3VzbHkgaGFwcGVucyBvbmx5IG9uY2UuIFRoYXTi
gJlzIHRoZSByZWFzb24NCkkgYXNzdW1lZCBpdOKAmXMgbm90IHRoYXQgZXhwZW5zaXZlLg0KDQpB
bnlob3csIEkgcmVtZW1iZXIgdGhhdCB3ZSBkaXNjdXNzZWQgYXQgc29tZSBwb2ludCBkb2luZyBz
b21ldGhpbmcgbGlrZQ0K4oCYYXNtKOKAnC5pbmNsdWRlIFhYWC5z4oCdKeKAmSBhbmQgc29tZWJv
ZHkgc2FpZCBpdCBpcyBub3QgZ29vZCwgYnV0IEkgZG9u4oCZdA0KcmVtZW1iZXIgd2h5IGFuZCBk
b27igJl0IHNlZSBhbnkgcmVhc29uIGl0IGlzIHNvLiBVbmxlc3MgSSBhbSBtaXNzaW5nDQpzb21l
dGhpbmcsIEkgdGhpbmsgaXQgaXMgcG9zc2libGUgdG8gdGFrZSBlYWNoIGluZGl2aWR1YWwgaGVh
ZGVyIGFuZA0KcHJlcHJvY2VzcyB0aGUgYXNzZW1ibHkgcGFydCBvZiBpbnRvIGEgc2VwYXJhdGUg
LnMgZmlsZS4gVGhlbiB3ZSBjYW4gcHV0IGluDQp0aGUgQyBwYXJ0IG9mIHRoZSBoZWFkZXIg4oCY
YXNtKCIuaW5jbHVkZSBYWFguc+KAnSnigJkuDQoNCldoYXQgZG8geW91IHRoaW5rPw0KDQo=

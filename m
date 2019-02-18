Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DC6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587E2214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="KfNRPmbk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733296AbfBRQWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:22:20 -0500
Received: from mail-eopbgr780042.outbound.protection.outlook.com ([40.107.78.42]:63859
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732723AbfBRQWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq/wxnn4FJjqnN5xW6I47IBIy6imvN4B5wqK2o84VeE=;
 b=KfNRPmbkBgB74HEqaPC5oaXF+MgMX/QkrOpOimasu0m4eSBjVOO7RMylM8d5+mkzm9nummQ1yqOX912ldN+Wd+vN8zh5xRq3MLdyUTTW0eHvkv3ESqoWCNE8xsNwwfDraZLlG64mljpKoJAl4Hc/NXfGMd3FWXIv3twne+MeNGY=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB6117.namprd05.prod.outlook.com (20.178.54.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.11; Mon, 18 Feb 2019 16:22:11 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::99ab:18fb:f393:df31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::99ab:18fb:f393:df31%3]) with mapi id 15.20.1643.012; Mon, 18 Feb 2019
 16:22:11 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Edward Cree <ecree@solarflare.com>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH v2 0/4] dynamic indirect call promotion
Thread-Topic: [RFC PATCH v2 0/4] dynamic indirect call promotion
Thread-Index: AQHUuosVcp8cKuvJm0mTu3sGpNa266XQ6oCAgBBGIYCABKZ7AA==
Date:   Mon, 18 Feb 2019 16:22:11 +0000
Message-ID: <77B1C9B7-2A61-4A55-96D0-6E21629956DB@vmware.com>
References: <1c8bfbb9-c76f-85d7-f6e2-aba33d5950b0@solarflare.com>
 <CDCF8F6E-1792-45B5-8850-88E3307D1FBD@vmware.com>
 <b099e061-32fc-4111-7836-b7cdcee88455@solarflare.com>
In-Reply-To: <b099e061-32fc-4111-7836-b7cdcee88455@solarflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff93bacf-ce6e-4f8f-9be4-08d695bd3c74
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB6117;
x-ms-traffictypediagnostic: BYAPR05MB6117:
x-microsoft-exchange-diagnostics: 1;BYAPR05MB6117;20:DCpJfWj/kIUKBQe8qqa9oCiBUMqoWxi78Iq8RVg0cIE6R2Zeh9psPXvG6SNZRInytdiuliwH76qyl3KcbEdqWwjGjaM9Coven0HwMfXPJZv9m+Dd4QS8P+R2q1HqyxzB6zTHqvsV+ow4z2LWMn8eVbwZLFxa2cnDr0ajuvHYWB8=
x-microsoft-antispam-prvs: <BYAPR05MB61173C9FE24E4CFEFC26ECDBD0630@BYAPR05MB6117.namprd05.prod.outlook.com>
x-forefront-prvs: 09525C61DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(366004)(346002)(396003)(199004)(189003)(51444003)(6116002)(54906003)(2616005)(486006)(6436002)(316002)(53936002)(476003)(256004)(14444005)(11346002)(33656002)(305945005)(6512007)(82746002)(6486002)(3846002)(186003)(229853002)(446003)(217873002)(2906002)(105586002)(26005)(97736004)(106356001)(36756003)(478600001)(6916009)(66066001)(4326008)(81156014)(14454004)(53546011)(6506007)(83716004)(25786009)(71200400001)(71190400001)(5660300002)(86362001)(6246003)(8676002)(76176011)(8936002)(102836004)(99286004)(81166006)(7736002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6117;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bM/B1O52IBkRsLeVQKQ3bdsWmAaoLZnCFgJUQiutPquCBgL/3enJU336KOEfLfncmLjVZLu4qzEPGgM/9t9vxRQWETBXeRTcejxmgy9VqpmInRqPsf7ICbKTMQGT0E1cxP/Jok8ng2lKZBkVbc2EyIicrJ9dywaRi7dibU8ySIF+iLQIPwdqLw2NUmH/WKCbxdfBLeKW2B8D11ff87De0evWcXUTNw6TK9bVlquatmffDHrioxKZjM5sEHv98qiD4xwwcQgYzyN4Oie1GOvll1Prf8uDHTHYz0MqR0OeUlDqTtHdBMl6mdSRpCkqNZTnMjq2AZSu1/Euws8jcSUnz4VYEvHFeKBJ4dDHaYHc3RkteNfyngjX768rGfb7Elv40IMN3uAasbGPshLJmP22yvzOy5/R7THg4wma56B0Crc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F35F45421908CF45BBF9CB6A49D54F8F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff93bacf-ce6e-4f8f-9be4-08d695bd3c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2019 16:22:11.4245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGZWIgMTUsIDIwMTksIGF0IDk6MjEgQU0sIEVkd2FyZCBDcmVlIDxlY3JlZUBzb2xhcmZs
YXJlLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiAwNS8wMi8xOSAwODo1MCwgTmFkYXYgQW1pdCB3cm90
ZToNCj4+PiBJbiBjYXNlcyB3aGVyZSBSQ1UgY2Fubm90IGJlIHVzZWQgKGUuZy4gYmVjYXVzZSBz
b21lIGNhbGxlZXMgbmVlZCB0byBSQ1UNCj4+PiBzeW5jaHJvbmlzZSksIGl0IG1pZ2h0IGJlIHBv
c3NpYmxlIHRvIGFkZCBhIHZhcmlhbnQgdGhhdCB1c2VzDQo+Pj4gc3luY2hyb25pemVfcmN1X3Rh
c2tzKCkgd2hlbiB1cGRhdGluZywgYnV0IHRoaXMgc2VyaWVzIGRvZXMgbm90IGF0dGVtcHQgdGhp
cy4NCj4+IEkgd29uZGVyIHdoeS4NCj4gTWFpbmx5IGJlY2F1c2UgSSBoYXZlIHlldCB0byBjb252
aW5jZSBteXNlbGYgdGhhdCBpdCdzIHRoZSBSaWdodCBUaGluZy4NCj4gTm90ZSBhbHNvIHRoZSBm
b2xsb3dpbmcgKGZyb20ga2VybmVsL3JjdS91cGRhdGUuYyk6DQo+IA0KPiAvKiAqIFRoaXMgaXMg
YSB2ZXJ5IHNwZWNpYWxpemVkIHByaW1pdGl2ZSwgaW50ZW5kZWQgb25seSBmb3IgYSBmZXcgdXNl
cyBpbg0KPiAqIHRyYWNpbmcgYW5kIG90aGVyIHNpdHVhdGlvbnMgcmVxdWlyaW5nIG1hbmlwdWxh
dGlvbiBvZiBmdW5jdGlvbg0KPiAqIHByZWFtYmxlcyBhbmQgcHJvZmlsaW5nIGhvb2tzLiBUaGUg
c3luY2hyb25pemVfcmN1X3Rhc2tzKCkgZnVuY3Rpb24NCj4gKiBpcyBub3QgKHlldCkgaW50ZW5k
ZWQgZm9yIGhlYXZ5IHVzZSBmcm9tIG11bHRpcGxlIENQVXMuICAqLw0KPiANCj4+IFRoaXMgc2Vl
bXMgbGlrZSBhbiBlYXN5IHNvbHV0aW9uLCBhbmQgYWNjb3JkaW5nIHRvIEpvc2gsIFN0ZXZlbg0K
Pj4gUm9zdGVkdCBhbmQgdGhlIGRvY3VtZW50YXRpb24gYXBwZWFycyB0byBiZSB2YWxpZC4NCj4g
V2lsbCBpdCBodXJ0IHBlcmZvcm1hbmNlLCB0aG91Z2gsIGlmIHdlIGVuZCB1cCAoc2F5KSBoYXZp
bmcgcmN1LXRhc2tzLQ0KPiAgYmFzZWQgc3luY2hyb25pc2F0aW9uIGZvciB1cGRhdGVzIG9uIGV2
ZXJ5IGluZGlyZWN0IGNhbGwgaW4gdGhlIGtlcm5lbD8NCj4gKEFzIHdvdWxkIHJlc3VsdCBmcm9t
IGEgcGx1Z2luLWJhc2VkIG9wdC1vdXQgYXBwcm9hY2guKQ0KDQpUaGF04oCZcyB3aGF0IGJhdGNo
aW5nIGlzIGZvci4uDQoNCj4gDQo+PiBBcyBJIHN0YXRlZCBiZWZvcmUsIEkgdGhpbmsgdGhhdCB0
aGUgYmVzdCBzb2x1dGlvbiBpcyB0byB1c2UgYSBHQ0MgcGx1Z2luLA0KPj4gWy4uLl0gU3VjaCBh
IHNvbHV0aW9uIHdpbGwgbm90IGVuYWJsZSB0aGUgY2FsbGluZyBjb2RlIHRvIGJlDQo+PiB3cml0
dGVuIGluIEMgYW5kIHdvdWxkIHJlcXVpcmUgYSBwbHVnaW4gZm9yIGVhY2ggYXJjaGl0ZWN0dXJl
Lg0KPiBJJ20gYWZyYWlkIEkgZG9uJ3Qgc2VlIHdoeS4gIElmIHdlIHVzZSB0aGUgc3RhdGljX2Nh
bGxzIGluZnJhc3RydWN0dXJlLA0KPiAgYnV0IHRoZW4gZG8gYSBzb3VyY2UtbGV2ZWwgdHJhbnNm
b3JtYXRpb24gaW4gdGhlIGNvbXBpbGVyIHBsdWdpbiB0byB0dXJuDQo+ICBpbmRpcmVjdCBjYWxs
cyBpbnRvIGR5bmFtaWNfY2FsbHMsIGl0IHNob3VsZCBiZSBwb3NzaWJsZSB0byBjcmVhdGUgYW4N
Cj4gIG9wdC1vdXQgc3lzdGVtIHdpdGhvdXQgYW55IGFyY2gtc3BlY2lmaWMgY29kZSBpbiB0aGUg
cGx1Z2luICh0aGUgYXJjaC0NCj4gIHNwZWNpZmljIHN0dWZmIGJlaW5nIGFsbCBpbiB0aGUgc3Rh
dGljX2NhbGxzIGNvZGUpLg0KPiBBbnkgcmVhc29uIHRoYXQgY2FuJ3QgYmUgZG9uZT8gIChOb3Rl
OiBJIGRvbid0IGtub3cgbXVjaCBhYm91dCBHQ0MNCj4gIGludGVybmFscywgbWF5YmUgdGhlcmUn
cyBzb21ldGhpbmcgb2J2aW91cyB0aGF0IHN0b3BzIGEgcGx1Z2luIGRvaW5nDQo+ICB0aGluZ3Mg
bGlrZSB0aGF0LikNCg0KSG1t4oCmIEkgdGhpbmsgeW91IGFyZSByaWdodC4gSXQgbWF5IGJlIHBv
c3NpYmxlIGJ5IGhvb2tpbmcgaW50bw0KUExVR0lOX1NUQVJUX1BBUlNFX0ZVTkNUSU9OIG9yIFBM
VUdJTl9GSU5JU0hfUEFSU0VfRlVOQ1RJT04gZXZlbnQuIEJ1dCwgSQ0KdGhpbmsgc291cmNlIGNv
ZGUgbWFuaXB1bGF0aW9uIGlzIGxpa2VseSB0byBiZSBtb3JlIGVycm9yIHByb25lIGFuZCDigJxk
aXJ0eeKAnS4NCkkgdGhpbmsgdGhhdCBhc3NlbWJseSBpcyB0aGUgcmlnaHQgbGV2ZWwgdG8gZGVh
bCB3aXRoIGluZGlyZWN0IGNhbGxzIGFueWhvdywNCnNwZWNpZmljYWxseSBpZiB0aGUgc2FtZSBt
ZWNoYW5pc20gaXMgdXNlZCBmb3IgY2FsbGVlLXNhdmVkIGZ1bmN0aW9ucy4NCg0KPj4gRmVlbCBm
cmVlIHRvIHRyeSBteSBjb2RlIGFuZCBnaXZlIG1lIGZlZWRiYWNrLiBJIGRpZCBub3QgZ2V0IGEg
ZmVlZGJhY2sgb24gbXkNCj4+IGxhc3QgdmVyc2lvbi4gSXMgdGhlcmUgYSBmdW5kYW1lbnRhbCBw
cm9ibGVtIHdpdGggbXkgcGx1Z2luPyBEaWQgeW91IHRyeSBpdCANCj4+IGFuZCBnb3QgYmFkIHJl
c3VsdHMsIG9yIHBlcmhhcHMgaXQgZGlkIG5vdCBidWlsZD8NCj4gSSBkaWRuJ3QgdGVzdCB5b3Vy
IHBhdGNoZXMgeWV0LCBiZWNhdXNlIEkgd2FzIGJ1c3kgdHJ5aW5nIHRvIGdldCBtaW5lDQo+ICB3
b3JraW5nIGFuZCByZWFkeSB0byBwb3N0IChhbmQgYWxzbyB3aXRoIHVucmVsYXRlZCB3b3JrKS4g
IEJ1dCBub3cgdGhhdA0KPiAgdGhhdCdzIGRvbmUsIG5leHQgdGltZSBJIGhhdmUgY3ljbGVzIHNw
YXJlIGZvciBpbmRpcmVjdCBjYWxsIHN0dWZmIEkNCj4gIGd1ZXNzIHRlc3RpbmcgKGFuZCByZXZp
ZXdpbmcpIHlvdXIgYXBwcm9hY2ggd2lsbCBiZSBuZXh0IG9uIG15IGxpc3QuDQo+IA0KPj4gV2h5
IGRvIHlvdSBwcmVmZXIgYW4gYXBwcm9hY2gNCj4+IHdoaWNoIHJlcXVpcmVzIGFubm90YXRpb24g
b2YgdGhlIGNhbGxlcnMsIGluc3RlYWQgb2Ygc29tZXRoaW5nIHRoYXQgaXMgbXVjaA0KPj4gbW9y
ZSB0cmFuc3BhcmVudD8NCj4gSSdtIGNvbmNlcm5lZCBhYm91dCB0aGUgb3ZlcmhlYWQgKGluIGJv
dGggdGltZSBhbmQgbWVtb3J5KSBvZiBydW5uaW5nDQo+ICBsZWFybmluZyBvbiBldmVyeSBpbmRp
cmVjdCBjYWxsIHNpdGUgKGluY2x1ZGluZyBvbmVzIHRoYXQgYXJlbid0IGluIGENCj4gIGhvdC1w
YXRoLCBhbmQgb25lcyB3aGljaCBoYXZlIHN1Y2ggYSB3aWRlIHZhcmlldHkgb2YgY2FsbGVlcyB0
aGF0DQo+ICBwcm9tb3Rpb24gcmVhbGx5IGRvZXNuJ3QgaGVscCkgdGhyb3VnaG91dCB0aGUgd2hv
bGUga2VybmVsLiAgQWxzbywgYW4NCj4gIGFubm90YXRpbmcgcHJvZ3JhbW1lciBrbm93cyB0aGUg
bG9ja2luZy9yY3UgY29udGV4dCBhbmQgY2FuIHRodXMgdGVsbA0KPiAgd2hldGhlciBhIGdpdmVu
IGR5bmFtaWNfY2FsbCBzaG91bGQgdXNlIHN5bmNocm9uaXNlX3JjdV90YXNrcygpLA0KPiAgc3lu
Y2hyb25pc2VfcmN1KCksIG9yIHBlcmhhcHMgc29tZXRoaW5nIGVsc2UgKGlmIGUuZy4gdGhlIGNh
bGwgYWx3YXlzDQo+ICBoYXBwZW5zIHVuZGVyIGEgbXV0ZXgsIHRoZW4gdGhlIHVwZGF0ZXIgd29y
ayBjb3VsZCB0YWtlIHRoYXQgbXV0ZXgpLg0KPiANCj4gVGhlIHJlYWwgYW5zd2VyLCB0aG91Z2gs
IGlzIHRoYXQgSSBkb24ndCBzbyBtdWNoIHByZWZlciB0aGlzIGFwcHJvYWNoLA0KPiAgYXMgdGhp
bmsgdGhhdCBib3RoIHNob3VsZCBiZSB0cmllZCAicHVibGljbHkiIGFuZCBldmFsdWF0ZWQgYnkg
bW9yZQ0KPiAgZGV2ZWxvcGVycyB0aGFuIGp1c3QgdXMgdGhyZWUuICBUaGVyZSdzIGEgcmVhc29u
IHRoaXMgc2VyaWVzIGlzDQo+ICBtYXJrZWQgUkZDIDstKQ0KDQpSZWFkaW5nIG15IGVtYWlsIGZy
b20gfjIgd2Vla3MgYWdvIC0gSSByZWFsaXplIEkgZG9u4oCZdCByZWFsbHkgdW5kZXJzdGFuZCBt
eQ0Kb3duIHF1ZXN0aW9uLiBDbGVhcmx5LCBhbm5vdGF0aW9uIGlzIGJldHRlciAoaWYgcG9zc2li
bGUpLiBNeSBwb2ludCB3YXMNCm1haW5seSB0aGF0IGl0IGlzIGEgdGVkaW91cyBqb2IgdG8gYW5u
b3RhdGUgYWxsIHRoZSBsb2NhdGlvbnMsIGFuZCB0aGVyZSBhcmUNCnF1aXRlIGEgZmV3Lg0KDQo=

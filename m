Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 84AF9C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264CB208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="aOXSIEjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264CB208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeFNF4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:56:40 -0400
Received: from mail-sn1nam01on0053.outbound.protection.outlook.com ([104.47.32.53]:26240
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752707AbeFNF4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pwx59dGq+8HXEeogBsfpph18QJHVTlzXATm6OIjno9w=;
 b=aOXSIEjtZyXSbzImSrAWVXksHn/NwbgWfxv1Js0ue4vQbAv2GEfLWsMYQtOzDZ5jLmz8qcqeTkQwzaYXcJYb8nCUhGvFDmAha+KAz1143y89UxBemHKEFJYgzlxVk4dolizHCeRRJeUxOgF+Sv7mbGgMUt5GfN0lERXlA00DGB4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4262.namprd05.prod.outlook.com (20.176.252.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Thu, 14 Jun 2018 05:56:36 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7%3]) with mapi id 15.20.0884.010; Thu, 14 Jun 2018
 05:56:36 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] vmw_balloon: fix inflation of 64-bit GFNs
Thread-Topic: [PATCH v2 1/7] vmw_balloon: fix inflation of 64-bit GFNs
Thread-Index: AQHUA1rKRrCKY1+zA0yfk4OBeCrKzqRfOPoAgAAE24CAAAK3AIAAAaQA
Date:   Thu, 14 Jun 2018 05:56:35 +0000
Message-ID: <0CFD7072-48DD-4A56-BFCA-83152664C315@vmware.com>
References: <20180613135412.81660-1-namit@vmware.com>
 <20180613135412.81660-2-namit@vmware.com> <20180614052336.GA29739@kroah.com>
 <485C5DF2-52FB-487C-AF65-096D74E9416B@vmware.com>
 <20180614055042.GA31687@kroah.com>
In-Reply-To: <20180614055042.GA31687@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4262;7:3fdDHqEnWkWTTVLJEEkbHSko6iCK10u2Ow2tErcwIA5/3qLsh0RGHJLlcd9/CRbK2gB+MTC8Pc3w2A7OJRDOBbUlcbHu2Pakb2RVXfmyG/MVxmxDwO2jrHp8xffHCEbUoN/FEvvbeAtpSrzfJ/ZOZ8/9NCG66iNCcR1Pcm0Ovc1h0X+XO0xWGAise6vlG1UvlJ8fp0doWzINYsPQK4cokNVkJc+lpX4TVWZldRj2UhtbYo7Ugw/jEwxLGqxvaPDv;20:W4sPljq6j1nvi9FY9GVJnMGClerh7PPisHIVNpQXA+/z+PpuTGSgyCsPImOFJRZNdXg6egVZNmwU3XzvhnxmvHbVB0vUytRLmonxGJFuvg3oeRCijI0VkKWJwSI8eOlc7upZBhaC3Nem3lM0wdc3QGCvSQNqdic7XPy191xJJfI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d4e2071d-f629-41fb-3da1-08d5d1bb96bc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4262;
x-ms-traffictypediagnostic: BYAPR05MB4262:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB4262C080BEE914DBA5C932E4D07D0@BYAPR05MB4262.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4262;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4262;
x-forefront-prvs: 0703B549E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(376002)(366004)(39860400002)(346002)(199004)(189003)(14454004)(316002)(54906003)(97736004)(25786009)(6246003)(33656002)(4326008)(53936002)(102836004)(36756003)(68736007)(478600001)(6506007)(81166006)(8676002)(186003)(106356001)(81156014)(8936002)(105586002)(229853002)(6486002)(86362001)(26005)(76176011)(11346002)(3846002)(486006)(99286004)(5250100002)(93886005)(2616005)(66066001)(82746002)(446003)(476003)(6436002)(3280700002)(7736002)(305945005)(59450400001)(6512007)(2906002)(6116002)(5660300001)(83716003)(2900100001)(575784001)(6916009)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4262;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NTijWhiT/pZV6Dh0RpvYgI4tKA+rKdCnHKts5lCvoabTGPx6b7lIcI8mtlxyxNLKob3nbhj48SagEkEwccPeZ2j/Q2pUcUP9Y+459GELBiY203If2rc9jnU1YVK1OVA8ZWTyyWnlpmc5+WHLxKn+p5yFPb28EEkdBxqD6I1NdhlQV3iUUNUTuizL6124Qhjn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <726BB1D49E60F4458DBE4B7FA93E04EB@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e2071d-f629-41fb-3da1-08d5d1bb96bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2018 05:56:35.6618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTA6NTAgUE0sIEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+IHdyb3RlOg0KDQo+IE9uIFRodSwgSnVuIDE0LCAyMDE4IGF0IDA1OjQxOjAxQU0gKzAwMDAs
IE5hZGF2IEFtaXQgd3JvdGU6DQo+PiBhdCAxMDoyMyBQTSwgR3JlZyBLcm9haC1IYXJ0bWFuIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+PiANCj4+PiBPbiBXZWQsIEp1biAx
MywgMjAxOCBhdCAwNjo1NDowNkFNIC0wNzAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+PiBXaGVu
IGJhbGxvb24gYmF0Y2hpbmcgaXMgbm90IHN1cHBvcnRlZCBieSB0aGUgaHlwZXJ2aXNvciwgdGhl
IGd1ZXN0DQo+Pj4+IGZyYW1lIG51bWJlciAoR0ZOKSBtdXN0IGZpdCBpbiAzMi1iaXQuIEhvd2V2
ZXIsIGR1ZSB0byBhIGJ1ZywgdGhpcyBjaGVjaw0KPj4+PiB3YXMgbWlzdGFrZW5seSBpZ25vcmVk
LiBJbiBwcmFjdGljZSwgd2hlbiB0b3RhbCBSQU0gaXMgZ3JlYXRlciB0aGFuDQo+Pj4+IDE2VEIs
IHRoZSBiYWxsb29uIGRvZXMgbm90IHdvcmsgY3VycmVudGx5LCBtYWtpbmcgdGhpcyBidWcgdW5s
aWtlbHkgdG8NCj4+Pj4gaGFwcGVuLg0KPj4+PiANCj4+Pj4gRml4ZXM6IGVmMGY4ZjExMjk4NCAo
IlZNd2FyZSBiYWxsb29uOiBwYXJ0aWFsbHkgaW5saW5lIHZtYmFsbG9vbl9yZXNlcnZlX3BhZ2Uu
IikNCj4+Pj4gDQo+Pj4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+Pj4gDQo+Pj4gQWdh
aW4sIG5vIGJsYW5rIGxpbmUgYmV0d2VlbiB0aGVzZSB0aGluZ3MuDQo+Pj4gDQo+Pj4gQWxzbywg
cGxlYXNlIGJyZWFrIHRoaXMgdXAgaW50byB0d28gZGlmZmVyZW50IHBhdGNoIHNlcmllcy4gIE9u
ZSBmb3INCj4+PiA0LjE4LWZpbmFsIGFuZCBvbmUgZm9yIDQuMTktcmMxLiAgWW91IHNob3VsZCBh
bHdheXMgc3BsaXQgdXAgYnVnZml4ZXMNCj4+PiBmcm9tIG5ldyBmZWF0dXJlcy9jbGVhbnVwcyBh
cyB0aGF0IGlzIHdoYXQgSSBoYXZlIHRvIGRvIHdoZW4gc2VuZGluZw0KPj4+IHRoZW0gdG8gTGlu
dXMuDQo+PiANCj4+IEkgaGF2ZSBvbmx5IHNlbnQgd2hhdCBJIHRob3VnaHQgaXMgYXBwcm9wcmlh
dGUgZm9yIDQuMTggKGNsZWFudXAvZmVhdHVyZXMgDQo+PiB3aWxsIGJlIHNlbnQgc2VwYXJhdGVs
eSk6DQo+PiANCj4+ICogNSBidWcgZml4ZXMgKDEtNS83KQ0KPj4gKiAxIHVwZGF0ZSB0aGUgbWFp
bnRhaW5lciBsaXN0ICg3LzcpDQo+PiAqIDEgdXBkYXRlIHRvIHRoZSBjb21tZW50IHRvIHByZXZl
bnQgY2hlY2twYXRjaCBmcm9tIGNvbXBsYWluaW5nICg2LzcpDQo+PiANCj4+IElmIHlvdSB0aGlu
ayBhbnkgcGF0Y2ggaXMgdW5zdWl0YWJsZSB0byA0LjE4IC0gcGxlYXNlIHNheSB3aGljaC4NCj4g
DQo+IEhvdyBkbyBJIGtub3cgd2hpY2ggcGF0Y2ggZ29lcyB0byB3aGljaCBicmFuY2g/ICBQbGVh
c2UgbWFrZSBpdCBzbw0KPiBvYnZpb3VzIEkgY2FuIG5vdCBnZXQgaXQgd3JvbmcuICBSZW1lbWJl
ciwgSSBnZXQgMTAwMCBlbWFpbHMgYSBkYXksIHlvdQ0KPiBkb24ndCB3YW50IG1lIHRvIGhhdmUg
dG8gbWFrZSBhIGp1ZGdlbWVudCBjYWxsIGFib3V0IGFueXRoaW5nLCBhcyBJIHdpbGwNCj4gbWVz
cyBpdCB1cCAgOikNCg0KSSBhcHByZWNpYXRlIHlvdXIgdGltZSwgYW5kIHVuZGVyc3RhbmQgeW91
IGV2ZW4gbmVlZCB0byByZWFkIHN0dWRlbnRz4oCZDQpkaXNzZXJ0YXRpb25zLiA7LSkNCg0KSSB3
aWxsIHdyaXRlIGl0IGNsZWFybHkgaW4gdGhlIGNvdmVyLWxldHRlciBpbiB0aGUgbmV4dCB2ZXJz
aW9uLCBhbmQgbW92ZQ0KdGhlIGxpY2Vuc2UgY2hhbmdlcyB0byA0LjE5Lg0KDQpUaGFua3MsDQpO
YWRhdg==

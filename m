Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78647C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2229D2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="JH2IYrkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfAUMni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:43:38 -0500
Received: from mail-eopbgr40051.outbound.protection.outlook.com ([40.107.4.51]:3211
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728163AbfAUMnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5U2A6vOFZHg68L+dT8c1fayZNiIMoVwhDy4h0pZeI4o=;
 b=JH2IYrkflPgQTuhs/XPwLx0GKEpD1sOC36Cjo/r74KzeWSqZa/mnz94q4Q16s0qSfPrVHEVtcw6bsCFBW27v73Hpc3QkpL2AXyujl1dfmA+rkYkfM7ZQwUNtH9pjB6otMLmOKjvGYPFcadDiqVcqBuMzLVDr8zXERM38mih7LB0=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB4119.eurprd03.prod.outlook.com (20.177.38.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Mon, 21 Jan 2019 12:43:32 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::844b:fab6:64d8:2f37]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::844b:fab6:64d8:2f37%3]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 12:43:32 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     Julien Grall <julien.grall@arm.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "jgross@suse.com" <jgross@suse.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [Xen-devel] [PATCH v2] drm/xen-front: Make shmem backed display
 buffer coherent
Thread-Topic: [Xen-devel] [PATCH v2] drm/xen-front: Make shmem backed display
 buffer coherent
Thread-Index: AQHUrNs7IxVSN/1nuUaI+Ik1wHznAaWxcBsAgAAB0ICAAAHygIABvZOAgAGYZ4CAACKFAIAEx8GA
Date:   Mon, 21 Jan 2019 12:43:32 +0000
Message-ID: <b5ee0d1c-7888-28c4-c5ae-7984c5e54c8e@epam.com>
References: <20190115140420.4652-1-andr2000@gmail.com>
 <20190116063002.jq3aas6ofhaogmyk@sirius.home.kraxel.org>
 <20190116063631.GA10881@infradead.org>
 <042fe794-dec6-6d9d-5b68-6f142790f5c7@epam.com>
 <20190117091815.GA7090@infradead.org>
 <1cfc5cb4-e481-5d71-29df-958db76fb681@epam.com>
 <2ed681b9-c8d4-ea27-6b8b-e399ed034bda@arm.com>
In-Reply-To: <2ed681b9-c8d4-ea27-6b8b-e399ed034bda@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB4119;6:OCL8Slj1mi3syQjNimeBqQD115UJe0Kr+dkdZFWXOSVKooCSk7B32vOT+w0iQQhd3nZ8hxvv4yoJavueOSxjbJe0PqfIiYYw8hy1tfW57tBRiXVkDlrynESAXpzjEVx3oSt83j0k7smStD9FOGK95DQr3v/3oSrQuxHdg1a/adScsTZTci+z8edJuNS3EyoPIjdRT1OQ4G0C16fO2krkPeFm4C6lYTicn9Vl6Zs2XdPWWdoQpqDjEKyJpzp2H4Vu0YlAC6bTYf25MZyaT/xKbm6myMRJYUaIKzG36h5pJ/B1ucd5qevj189gXfSZ1qT0hNljr3hDOWLAhNpfa2nCGUskHttzYdJ8gx4U8MWxGHLMVhOA3vRBctsQTeNGKgBeIETaQUyTDtf4PhDrk9zmZQgacfS3SOj3WDyWLH1PSdrr8U1OLHiPxExgS5nPiKdHinx0juVbfeeWE00/fsptrQ==;5:7rBC7ytraqCqC8HwZ0Tn8FRVBk3rjn37EmTAt8pa5sBFuNySWh5bFJbRIAq/bVTfVBjQokXqTV/jUsS3+3es8B6OHMb10KXAD2BOQPEPA+dEt0CejUeIqYEQ/d9YqjehBuvEYrQusLl5HHURBKvV092S+fn9hzlWUksWaMWeLLIdVHDm5+P3pQjdX3YxTNAry8qgh0TvTDFVt7s5q7RZsQ==;7:W0OPJH/pT8n7+y7IuyIGZfBXEaxwDe8cpTZJbCXbUyX1hV0IvbXTOgszSa1M2bCL6JYuRKyR+bGsa914kf2RDcZ+6/I4z98aHKy+2jONhwS06dtuER7DK1Dzxi5h4ORZEYbKKsm6xDQBdUX2NDn7jg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3844bb27-c560-4b58-55e0-08d67f9e0d62
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB4119;
x-ms-traffictypediagnostic: AM6PR03MB4119:
x-microsoft-antispam-prvs: <AM6PR03MB411983BA2643E7AF39EE141BE79F0@AM6PR03MB4119.eurprd03.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(478600001)(2906002)(39060400002)(4326008)(93886005)(71200400001)(71190400001)(14454004)(14444005)(256004)(25786009)(99286004)(316002)(966005)(110136005)(54906003)(31686004)(72206003)(66066001)(7416002)(36756003)(106356001)(105586002)(80792005)(97736004)(3846002)(6116002)(6506007)(53546011)(55236004)(68736007)(6306002)(446003)(102836004)(486006)(6512007)(76176011)(229853002)(6436002)(8936002)(8676002)(81166006)(81156014)(305945005)(86362001)(7736002)(2616005)(11346002)(31696002)(6486002)(186003)(26005)(476003)(6246003)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB4119;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /pHkqUnjaRYn1mO596h0B/sgTT0m1vdSM1MdVDNRrNhRcaQhCyWBX9WGWn5pubMcbeG3nrsu8/kJySaVy9qAMXCtjRU63rvKa/zRSqMDy68k6XLyvAWho/Sfv0T/DW/t8Jq/NcwNabAvfemvMsBk4UovBHFvyo/kwS2fInQsX82q4lvB+GtAdaNRlV2aAKdvOVrKc89R8kCxJ8GudBGT/cNBOncydxshLjbacgWay1pTblw9ajlJs4QnTIVXXXHftjKVUkuowDO10J0xkVc3GWoJ/1NM6PYXtE+K8vX2YhM7WZ6vJ+qQXBF9BftmSekwUhnXoFxbRaxzWBQ3zSoeye6YO9fKz6yOhvqoLtTh72+EKvr6ot086z0jj4z9mdiYSoCjj0izs1RT9dzOoV2RVGOx0J+91MOO4vjML6P0dUs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F0ACAD231AAC045A9F1BF4B26CAE844@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3844bb27-c560-4b58-55e0-08d67f9e0d62
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 12:43:32.4851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xOC8xOSAxOjQzIFBNLCBKdWxpZW4gR3JhbGwgd3JvdGU6DQo+ICgrIFN0ZWZhbm8pDQo+
DQo+IEhpLA0KPg0KPiBTb3JyeSBmb3IganVtcGluZyBsYXRlIGluIHRoZSBjb252ZXJzYXRpb24u
DQo+DQo+IE9uIDE4LzAxLzIwMTkgMDk6NDAsIE9sZWtzYW5kciBBbmRydXNoY2hlbmtvIHdyb3Rl
Og0KPj4gT24gMS8xNy8xOSAxMToxOCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+Pj4g
T24gV2VkLCBKYW4gMTYsIDIwMTkgYXQgMDY6NDM6MjlBTSArMDAwMCwgT2xla3NhbmRyIEFuZHJ1
c2hjaGVua28gDQo+Pj4gd3JvdGU6DQo+Pj4+PiBUaGlzIHdob2xlIGlzc3VlIGtlZXBzIGdldHRp
bmcgbW9yZSBhbmQgbW9yZSBjb25mdXNpbmcuDQo+Pj4+IFdlbGwsIEkgZG9uJ3QgcmVhbGx5IGRv
IERNQSBoZXJlLCBidXQgaW5zdGVhZCB0aGUgYnVmZmVycyBpbg0KPj4+PiBxdWVzdGlvbiBhcmUg
c2hhcmVkIHdpdGggb3RoZXIgWGVuIGRvbWFpbiwgc28gZWZmZWN0aXZlbHkgaXQNCj4+Pj4gY291
bGQgYmUgdGhvdWdodCBvZiBzb21lIHNvcnQgb2YgRE1BIGhlcmUsIHdoZXJlIHRoZSAiZGV2aWNl
IiBpcw0KPj4+PiB0aGF0IHJlbW90ZSBkb21haW4uIElmIHRoZSBidWZmZXJzIGFyZSBub3QgZmx1
c2hlZCB0aGVuIHRoZQ0KPj4+PiByZW1vdGUgcGFydCBzZWVzIHNvbWUgaW5jb25zaXN0ZW5jeSB3
aGljaCBpbiBteSBjYXNlIHJlc3VsdHMNCj4+Pj4gaW4gYXJ0aWZhY3RzIG9uIHNjcmVlbiB3aGls
ZSBkaXNwbGF5aW5nIHRoZSBidWZmZXJzLg0KPj4+PiBXaGVuIGJ1ZmZlcnMgYXJlIGFsbG9jYXRl
ZCB2aWEgRE1BIEFQSSB0aGVuIHRoZXJlIGFyZSBubyBhcnRpZmFjdHM7DQo+Pj4+IGlmIGJ1ZmZl
cnMgYXJlIGFsbG9jYXRlZCB3aXRoIHNobWVtICsgRE1BIG1hcHBpbmcgdGhlbiB0aGVyZSBhcmUg
bm8NCj4+Pj4gYXJ0aWZhY3RzIGFzIHdlbGwuDQo+Pj4+IFRoZSBvbmx5IG9mZmVuZGluZyB1c2Ut
Y2FzZSBpcyB3aGVuIEkgdXNlIHNobWVtIGJhY2tlZCBidWZmZXJzLA0KPj4+PiBidXQgZG8gbm90
IGZsdXNoIHRoZW0NCj4+PiBUaGUgcmlnaHQgYW5zd2VyIHdvdWxkIGJlIHRvIGltcGxlbWVudCBj
YWNoZSBtYWludGFpbmFuY2UgaG9va3MgZm9yDQo+Pj4gdGhpcyBjYXNlIGluIHRoZSBYZW4gYXJj
aCBjb2RlLsKgIFRoZXNlIHdvdWxkIGJhc2ljYWxseSBsb29rIHRoZSBzYW1lDQo+Pj4gYXMgdGhl
IGxvdy1sZXZlbCBjYWNoZSBtYWludGFpbmFuY2UgdXNlZCBieSB0aGUgRE1BIG9wcywgYnV0IHdp
dGhvdXQNCj4+PiBnb2luZyB0aHJvdWdoIHRoZSBETUEgbWFwcGluZyBsYXllciwgaW4gZmFjdCB0
aGV5IHNob3VsZCBwcm9iYWJseQ0KPj4+IHJldXNlIHRoZSBzYW1lIGxvdy1sZXZlbCBhc3NlbWJs
eSByb3V0aW5lcy4NCj4+Pg0KPj4+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyB0aGUgZmlyc3QgdXNh
Z2Ugb2Ygc3VjaCBYZW4gYnVmZmVyIHNoYXJpbmcsIHNvDQo+Pj4gd2hhdCBkbyB0aGUgb3RoZXIg
dXNlcnMgZG8/DQo+PiBJJ2xsIGhhdmUgdG8gZ2V0IGV2ZW4gZGVlcGVyIGludG8gaXQuIEluaXRp
YWxseSBJDQo+PiBsb29rZWQgYXQgdGhlIGNvZGUsIGJ1dCBkaWRuJ3QgZmluZCBhbnl0aGluZyB1
c2VmdWwuDQo+PiBPciBtYXliZSBJIGhhdmUganVzdCBvdmVybG9va2VkIG9idmlvdXMgdGhpbmdz
IHRoZXJlDQo+IEZyb20gWGVuIG9uIEFybSBBQkk6DQo+DQo+ICJBbGwgbWVtb3J5IHdoaWNoIGlz
IHNoYXJlZCB3aXRoIG90aGVyIGVudGl0aWVzIGluIHRoZSBzeXN0ZW0NCj4gKGluY2x1ZGluZyB0
aGUgaHlwZXJ2aXNvciBhbmQgb3RoZXIgZ3Vlc3RzKSBtdXN0IHJlc2lkZSBpbiBtZW1vcnkNCj4g
d2hpY2ggaXMgbWFwcGVkIGFzIE5vcm1hbCBJbm5lciBXcml0ZS1CYWNrIE91dGVyIFdyaXRlLUJh
Y2sgDQo+IElubmVyLVNoYXJlYWJsZS4NCj4gVGhpcyBhcHBsaWVzIHRvOg0KPiDCoCAtIGh5cGVy
Y2FsbCBhcmd1bWVudHMgcGFzc2VkIHZpYSBhIHBvaW50ZXIgdG8gZ3Vlc3QgbWVtb3J5Lg0KPiDC
oCAtIG1lbW9yeSBzaGFyZWQgdmlhIHRoZSBncmFudCB0YWJsZSBtZWNoYW5pc20gKGluY2x1ZGlu
ZyBQViBJL08NCj4gwqDCoMKgIHJpbmdzIGV0YykuDQo+IMKgIC0gbWVtb3J5IHNoYXJlZCB3aXRo
IHRoZSBoeXBlcnZpc29yIChzdHJ1Y3Qgc2hhcmVkX2luZm8sIHN0cnVjdA0KPiDCoMKgwqAgdmNw
dV9pbmZvLCB0aGUgZ3JhbnQgdGFibGUsIGV0YykuDQo+ICINCj4NCj4gU28geW91IHNob3VsZCBu
b3QgbmVlZCBhbnkgY2FjaGUgbWFpbnRlbmFuY2UgaGVyZS4gQ2FuIHlvdSBwcm92aWRlIA0KPiBt
b3JlIGRldGFpbHMgb24gdGhlIG1lbW9yeSBhdHRyaWJ1dGUgeW91IHVzZSBmb3IgbWVtb3J5IHNo
YXJlZCBpbiBib3RoIA0KPiB0aGUgYmFja2VuZCBhbmQgZnJvbnRlbmQ/DQo+DQpJdCB0YWtlcyBx
dWl0ZSBzb21lIHRpbWUgdG8gY29sbGVjdCB0aGlzIChiZWNhdXNlIG1hbnkgY29tcG9uZW50cyBh
cmUgDQppbnZvbHZlZCBpbiB0aGUNCnVzZS1jYXNlKSwgYnV0IGZvciBub3cgdGhlIHBhZ2VzIGlu
IHRoZSBndWVzdCBkb21haW4gYXJlOg0KIVBURV9SRE9OTFkgKyBQVEVfUFhOICsgUFRFX1NIQVJF
RCArIFBURV9BRiArIFBURV9VWE4gKyANClBURV9BVFRSSU5EWChNVF9OT1JNQUwpDQoNCj4gQ2hl
ZXJzLA0KPg0KPj4NCj4+IFRoYW5rIHlvdSwNCj4+IE9sZWtzYW5kcg0KPj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IFhlbi1kZXZlbCBtYWlsaW5n
IGxpc3QNCj4+IFhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZw0KPj4gaHR0cHM6Ly9saXN0
cy54ZW5wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3hlbi1kZXZlbA0KPj4NCj4NCg==

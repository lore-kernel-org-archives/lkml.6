Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8B4C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9812084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="QQmxsZJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfAVK2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:28:07 -0500
Received: from mail-eopbgr70088.outbound.protection.outlook.com ([40.107.7.88]:23758
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbfAVK2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as2m5kLb+SYbcmQ4u7hDrrbtpyYk78VvDH2ioFpIH1E=;
 b=QQmxsZJ0YAdQt95LeXcPaoz1oi4dJ8B5kUnp5yvvmA26p5sB9hUd9dWfLRTTet5bD01tHGtceoN0ZA/E2n9WkMxt3nA21lpr19gZjciDim2No7yuf0Fctp+puRJR9zEqAaxt0CNNrHZXVSA5ACBt26eAz+1YdY6qjbnI534T57Y=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB4440.eurprd03.prod.outlook.com (20.177.33.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.31; Tue, 22 Jan 2019 10:28:02 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::844b:fab6:64d8:2f37]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::844b:fab6:64d8:2f37%3]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 10:28:02 +0000
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
        Stefano Stabellini <sstabellini@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [Xen-devel] [PATCH v2] drm/xen-front: Make shmem backed display
 buffer coherent
Thread-Topic: [Xen-devel] [PATCH v2] drm/xen-front: Make shmem backed display
 buffer coherent
Thread-Index: AQHUrNs7IxVSN/1nuUaI+Ik1wHznAaWxcBsAgAAB0ICAAAHygIABvZOAgAGYZ4CAACKFAIAEx8GAgABKW4CAASIegA==
Date:   Tue, 22 Jan 2019 10:28:02 +0000
Message-ID: <79ac0743-68bc-c2b7-d843-cf152c40d583@epam.com>
References: <20190115140420.4652-1-andr2000@gmail.com>
 <20190116063002.jq3aas6ofhaogmyk@sirius.home.kraxel.org>
 <20190116063631.GA10881@infradead.org>
 <042fe794-dec6-6d9d-5b68-6f142790f5c7@epam.com>
 <20190117091815.GA7090@infradead.org>
 <1cfc5cb4-e481-5d71-29df-958db76fb681@epam.com>
 <2ed681b9-c8d4-ea27-6b8b-e399ed034bda@arm.com>
 <b5ee0d1c-7888-28c4-c5ae-7984c5e54c8e@epam.com>
 <9e0130ee-0418-f68c-94cf-31a5566d929a@arm.com>
In-Reply-To: <9e0130ee-0418-f68c-94cf-31a5566d929a@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB4440;6:Tfgf/lRajarnmZxEV/PxOIcRtE+MwHOidL8qXxEQpPCuEWh9uG/lnbYaUzJzStV/v6n7a0HL/C4myJkWSdTwWoCRDV63wBjvhZ4dn327TrNjgC+PnUmSP+l3VN1DOwRQwe1UAj6rWzmaSgcg37HPWvG2aUNpkIpjC62cgds4hhzYYSBVzNBkjg3PMMVvyQcjAz8VEth+mQ2aCy5r+nBU9cL8B78LCAu/q78GEbdNutJL1ICluIFFwtUm832JQSGGfbakmoXwSvGk5PV10zPwX4P71QIlu0uCOfpMQJ5un5X35zFy9TpWa4RXZcKnH90j4gvzD69Si91TX67iuZLLCpe/hxrxenEl7X0UKzDFutUgdh0fuoVxniUu1beQWwKQbSXQX4qEL9zmH2vSNsMOIL4AuVpL+eDwOv8Imi+jZ1ixqQW6Yu0BBQb/Fqz2KmkoMqLQQiLjz1GS4omHsKP/bA==;5:Ix/pQzA7QQo9T0jo1f9rWM0w8DvrvdSQdAcbv16FPBDr1tnJFJBEvsb/Zc0rnjB6iFZCHhQaOHi4zLBJsZo1TpBmOU2x0++DhsyvE+U0PllAX+Q6kwr1FkNkiQKGBIvHgwHVjE4WWJCEuM/hHRKnrACyvE8+4ShAkAsvXPAquNnmjXp726/9v8/vhgDqhrB1noGjM7H4amGM304HP1TuNg==;7:eVZkUxhRYPAJsQcDO4jgHMJ9y8Rqzs9Ys3eXLnDTnbQuvHUB7QqPKWGbf0AuNVDMF/trj0JurrzuxPCgKEq2H/k61/4PTS/TwqXh352iNTL5BHYzJsNKZJHbmXDwxrTJkOso4eoZV8JZo9LTBWve9A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3949a95a-1f4c-4c24-1ad2-08d6805449ba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB4440;
x-ms-traffictypediagnostic: AM6PR03MB4440:
x-microsoft-antispam-prvs: <AM6PR03MB44401F898220698BAE85D325E7980@AM6PR03MB4440.eurprd03.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(72206003)(2906002)(6512007)(71200400001)(71190400001)(102836004)(39060400002)(26005)(106356001)(2616005)(36756003)(11346002)(99286004)(66066001)(55236004)(478600001)(76176011)(7416002)(14454004)(3846002)(97736004)(6116002)(68736007)(53546011)(6506007)(53936002)(6246003)(4326008)(81166006)(476003)(8936002)(8676002)(486006)(81156014)(80792005)(7736002)(305945005)(14444005)(105586002)(54906003)(25786009)(110136005)(6486002)(446003)(316002)(86362001)(186003)(229853002)(6436002)(256004)(93886005)(31686004)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB4440;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oQalyKkU4oaBbMjKATWFDhyWVknKqUikC1w2wR+gm3+bCx/ktEvDQIEI7UBdoMmQH5IjVUO/tZrftd/HkmAhAr0DCp8Qp5W72XkrBQdRy0silBXu4/1LDxFdoh0ieTi8ElSFm986d7mKyujYXTc5MRjutfOsuZd/YEwMMARIQJEio+N8Nm6UoAeEkvfNnf7Fy9vMrEx6ADkZXDiu1MnnkIYJrawXWJAhSO0OQIP5PW13rCOjjeAxaggNbJQXih8auaiiqJFMFfYpRrp4wB3P7H54GFCSL0Z2J/eBuxDwaRptcjXGgTsvN7+aBRv6y8s/bP2kOUvxo19D/mVel+zXefANZgp9F+7S54KY3G7dDgz0+p3tCSuvYvE41uvg8XmB1y1PwhRHl6JA35UYyYFGMGGuq1XaH0NYwOlQHHQuTVw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5E74B85C635F44D9CDF573618A367FD@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3949a95a-1f4c-4c24-1ad2-08d6805449ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 10:28:02.0854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4440
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sIEp1bGllbiENCg0KT24gMS8yMS8xOSA3OjA5IFBNLCBKdWxpZW4gR3JhbGwgd3JvdGU6
DQo+IEhlbGxvLA0KPg0KPiBPbiAyMS8wMS8yMDE5IDEyOjQzLCBPbGVrc2FuZHIgQW5kcnVzaGNo
ZW5rbyB3cm90ZToNCj4+IE9uIDEvMTgvMTkgMTo0MyBQTSwgSnVsaWVuIEdyYWxsIHdyb3RlOg0K
Pj4+IE9uIDE4LzAxLzIwMTkgMDk6NDAsIE9sZWtzYW5kciBBbmRydXNoY2hlbmtvIHdyb3RlOg0K
Pj4+PiBPbiAxLzE3LzE5IDExOjE4IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+Pj4+
IE9uIFdlZCwgSmFuIDE2LCAyMDE5IGF0IDA2OjQzOjI5QU0gKzAwMDAsIE9sZWtzYW5kciBBbmRy
dXNoY2hlbmtvDQo+Pj4+PiB3cm90ZToNCj4+Pj4+Pj4gVGhpcyB3aG9sZSBpc3N1ZSBrZWVwcyBn
ZXR0aW5nIG1vcmUgYW5kIG1vcmUgY29uZnVzaW5nLg0KPj4+Pj4+IFdlbGwsIEkgZG9uJ3QgcmVh
bGx5IGRvIERNQSBoZXJlLCBidXQgaW5zdGVhZCB0aGUgYnVmZmVycyBpbg0KPj4+Pj4+IHF1ZXN0
aW9uIGFyZSBzaGFyZWQgd2l0aCBvdGhlciBYZW4gZG9tYWluLCBzbyBlZmZlY3RpdmVseSBpdA0K
Pj4+Pj4+IGNvdWxkIGJlIHRob3VnaHQgb2Ygc29tZSBzb3J0IG9mIERNQSBoZXJlLCB3aGVyZSB0
aGUgImRldmljZSIgaXMNCj4+Pj4+PiB0aGF0IHJlbW90ZSBkb21haW4uIElmIHRoZSBidWZmZXJz
IGFyZSBub3QgZmx1c2hlZCB0aGVuIHRoZQ0KPj4+Pj4+IHJlbW90ZSBwYXJ0IHNlZXMgc29tZSBp
bmNvbnNpc3RlbmN5IHdoaWNoIGluIG15IGNhc2UgcmVzdWx0cw0KPj4+Pj4+IGluIGFydGlmYWN0
cyBvbiBzY3JlZW4gd2hpbGUgZGlzcGxheWluZyB0aGUgYnVmZmVycy4NCj4+Pj4+PiBXaGVuIGJ1
ZmZlcnMgYXJlIGFsbG9jYXRlZCB2aWEgRE1BIEFQSSB0aGVuIHRoZXJlIGFyZSBubyBhcnRpZmFj
dHM7DQo+Pj4+Pj4gaWYgYnVmZmVycyBhcmUgYWxsb2NhdGVkIHdpdGggc2htZW0gKyBETUEgbWFw
cGluZyB0aGVuIHRoZXJlIGFyZSBubw0KPj4+Pj4+IGFydGlmYWN0cyBhcyB3ZWxsLg0KPj4+Pj4+
IFRoZSBvbmx5IG9mZmVuZGluZyB1c2UtY2FzZSBpcyB3aGVuIEkgdXNlIHNobWVtIGJhY2tlZCBi
dWZmZXJzLA0KPj4+Pj4+IGJ1dCBkbyBub3QgZmx1c2ggdGhlbQ0KPj4+Pj4gVGhlIHJpZ2h0IGFu
c3dlciB3b3VsZCBiZSB0byBpbXBsZW1lbnQgY2FjaGUgbWFpbnRhaW5hbmNlIGhvb2tzIGZvcg0K
Pj4+Pj4gdGhpcyBjYXNlIGluIHRoZSBYZW4gYXJjaCBjb2RlLsKgIFRoZXNlIHdvdWxkIGJhc2lj
YWxseSBsb29rIHRoZSBzYW1lDQo+Pj4+PiBhcyB0aGUgbG93LWxldmVsIGNhY2hlIG1haW50YWlu
YW5jZSB1c2VkIGJ5IHRoZSBETUEgb3BzLCBidXQgd2l0aG91dA0KPj4+Pj4gZ29pbmcgdGhyb3Vn
aCB0aGUgRE1BIG1hcHBpbmcgbGF5ZXIsIGluIGZhY3QgdGhleSBzaG91bGQgcHJvYmFibHkNCj4+
Pj4+IHJldXNlIHRoZSBzYW1lIGxvdy1sZXZlbCBhc3NlbWJseSByb3V0aW5lcy4NCj4+Pj4+DQo+
Pj4+PiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgdGhlIGZpcnN0IHVzYWdlIG9mIHN1Y2ggWGVuIGJ1
ZmZlciBzaGFyaW5nLCBzbw0KPj4+Pj4gd2hhdCBkbyB0aGUgb3RoZXIgdXNlcnMgZG8/DQo+Pj4+
IEknbGwgaGF2ZSB0byBnZXQgZXZlbiBkZWVwZXIgaW50byBpdC4gSW5pdGlhbGx5IEkNCj4+Pj4g
bG9va2VkIGF0IHRoZSBjb2RlLCBidXQgZGlkbid0IGZpbmQgYW55dGhpbmcgdXNlZnVsLg0KPj4+
PiBPciBtYXliZSBJIGhhdmUganVzdCBvdmVybG9va2VkIG9idmlvdXMgdGhpbmdzIHRoZXJlDQo+
Pj4gwqBGcm9tIFhlbiBvbiBBcm0gQUJJOg0KPj4+DQo+Pj4gIkFsbCBtZW1vcnkgd2hpY2ggaXMg
c2hhcmVkIHdpdGggb3RoZXIgZW50aXRpZXMgaW4gdGhlIHN5c3RlbQ0KPj4+IChpbmNsdWRpbmcg
dGhlIGh5cGVydmlzb3IgYW5kIG90aGVyIGd1ZXN0cykgbXVzdCByZXNpZGUgaW4gbWVtb3J5DQo+
Pj4gd2hpY2ggaXMgbWFwcGVkIGFzIE5vcm1hbCBJbm5lciBXcml0ZS1CYWNrIE91dGVyIFdyaXRl
LUJhY2sNCj4+PiBJbm5lci1TaGFyZWFibGUuDQo+Pj4gVGhpcyBhcHBsaWVzIHRvOg0KPj4+IMKg
wqAgLSBoeXBlcmNhbGwgYXJndW1lbnRzIHBhc3NlZCB2aWEgYSBwb2ludGVyIHRvIGd1ZXN0IG1l
bW9yeS4NCj4+PiDCoMKgIC0gbWVtb3J5IHNoYXJlZCB2aWEgdGhlIGdyYW50IHRhYmxlIG1lY2hh
bmlzbSAoaW5jbHVkaW5nIFBWIEkvTw0KPj4+IMKgwqDCoMKgIHJpbmdzIGV0YykuDQo+Pj4gwqDC
oCAtIG1lbW9yeSBzaGFyZWQgd2l0aCB0aGUgaHlwZXJ2aXNvciAoc3RydWN0IHNoYXJlZF9pbmZv
LCBzdHJ1Y3QNCj4+PiDCoMKgwqDCoCB2Y3B1X2luZm8sIHRoZSBncmFudCB0YWJsZSwgZXRjKS4N
Cj4+PiAiDQo+Pj4NCj4+PiBTbyB5b3Ugc2hvdWxkIG5vdCBuZWVkIGFueSBjYWNoZSBtYWludGVu
YW5jZSBoZXJlLiBDYW4geW91IHByb3ZpZGUNCj4+PiBtb3JlIGRldGFpbHMgb24gdGhlIG1lbW9y
eSBhdHRyaWJ1dGUgeW91IHVzZSBmb3IgbWVtb3J5IHNoYXJlZCBpbiBib3RoDQo+Pj4gdGhlIGJh
Y2tlbmQgYW5kIGZyb250ZW5kPw0KPj4+DQo+PiBJdCB0YWtlcyBxdWl0ZSBzb21lIHRpbWUgdG8g
Y29sbGVjdCB0aGlzIChiZWNhdXNlIG1hbnkgY29tcG9uZW50cyBhcmUNCj4+IGludm9sdmVkIGlu
IHRoZQ0KPj4gdXNlLWNhc2UpLCBidXQgZm9yIG5vdyB0aGUgcGFnZXMgaW4gdGhlIGd1ZXN0IGRv
bWFpbiBhcmU6DQo+PiAhUFRFX1JET05MWSArIFBURV9QWE4gKyBQVEVfU0hBUkVEICsgUFRFX0FG
ICsgUFRFX1VYTiArDQo+PiBQVEVfQVRUUklORFgoTVRfTk9STUFMKQ0KPg0KPiBTbyB0aGF0J3Mg
dGhlIGF0dHJpYnV0ZSBmb3IgdGhlIHBhZ2UgbWFwcGVkIGluIHRoZSBmcm9udGVuZCwgcmlnaHQ/
IA0KPiBIb3cgYWJvdXQgdGhlIGJhY2tlbmQgc2lkZT8NClBsZWFzZSBzZWUgYmVsb3cNCj4NCj4g
QWxzbywgY291bGQgdGhhdCBwYWdlIGJlIGhhbmRlZCB0byB0aGUgZ3JhcGhpYyBjYXJkIGNvcnJl
Y3RseT8NClllcywgaWYgd2UgdXNlIHplcm8tY29weWluZy4gQnV0IHBsZWFzZSBzZWUgYmVsb3cN
Cj4gSWYgc28sIGlzIHlvdXIgZ3JhcGhpYyBjYXJkIGNvaGVyZW50Pw0KWWVzLCBpdCBpcw0KPg0K
PiBJZiBvbmUgb2YgeW91ciBjb21wb25lbnRzIGlzIG1hcHBpbmcgd2l0aCBub24tY2FjaGVhYmxl
IGF0dHJpYnV0ZXMgDQo+IHRoZW4geW91IGFyZSBhbHJlYWR5IG5vdCBmb2xsb3dpbmcgdGhlIFhl
biBBcm0gQUJJLiBJbiB0aGF0IGNhc2UsIHdlIA0KPiB3b3VsZCBuZWVkIHRvIGRpc2N1c3MgaG93
IHRvIGV4dGVuZCB0aGUgQUJJLg0KPg0KPiBDaGVlcnMsDQo+DQpXZWxsLCBJIGRpZG4ndCBnZXQg
dGhlIGF0dHJpYnV0ZXMgb2YgcGFnZXMgYXQgdGhlIGJhY2tlbmQgc2lkZSwgYnV0IElNTyANCnRo
b3NlDQpkbyBub3QgbWF0dGVyIGluIG15IHVzZS1jYXNlIChmb3Igc2ltcGxpY2l0eSBJIGFtIG5v
dCB1c2luZyB6ZXJvLWNvcHlpbmcgYXQNCmJhY2tlbmQgc2lkZSk6DQoNCjEuIEZyb250ZW5kIGRl
dmljZSBhbGxvY2F0ZXMgZGlzcGxheSBidWZmZXIgcGFnZXMgd2hpY2ggY29tZSBmcm9tIHNobWVt
DQphbmQgaGF2ZSB0aGVzZSBhdHRyaWJ1dGVzOg0KIVBURV9SRE9OTFkgKyBQVEVfUFhOICsgUFRF
X1NIQVJFRCArIFBURV9BRiArIFBURV9VWE4gKyANClBURV9BVFRSSU5EWChNVF9OT1JNQUwpDQoN
CjIuIEZyb250ZW5kIGdyYW50cyByZWZlcmVuY2VzIHRvIHRoZXNlIHBhZ2VzIGFuZCBzaGFyZXMg
dGhvc2Ugd2l0aCB0aGUgDQpiYWNrZW5kDQoNCjMuIEJhY2tlbmQgaXMgYSB1c2VyLXNwYWNlIGFw
cGxpY2F0aW9uIChXZXN0b24gY2xpZW50KSwgc28gaXQgdXNlcyANCmdudGRldiBrZXJuZWwNCmRy
aXZlciB0byBtbWFwIHRoZSBwYWdlcy4gVGhlIHBhZ2VzLCB3aGljaCBhcmUgdXNlZCBieSBnbnRk
ZXYsIGFyZSB0aG9zZSANCmNvbWluZw0KZnJvbSB0aGUgWGVuIGJhbGxvb24gZHJpdmVyIGFuZCBJ
IGJlbGlldmUgdGhleSBhcmUgYWxsIG5vcm1hbCBtZW1vcnkgYW5kDQpzaG91bGRuJ3QgYmUgbm9u
LWNhY2hlZC4NCg0KNC4gT25jZSB0aGUgZnJvbnRlbmQgc3RhcnRzIGRpc3BsYXlpbmcgaXQgZmxp
cHMgdGhlIGJ1ZmZlcnMgYW5kIGJhY2tlbmQgDQpkb2VzICptZW1jcHkqDQpmcm9tIHRoZSBmcm9u
dGVuZC1iYWNrZW5kIHNoYXJlZCBidWZmZXIgaW50byBXZXN0b24ncyBidWZmZXIuIFRoaXMgbWVh
bnMNCm5vIEhXIGF0IHRoZSBiYWNrZW5kIHNpZGUgdG91Y2hlcyB0aGUgc2hhcmVkIGJ1ZmZlci4N
Cg0KNS4gSSBjYW4gc2VlIGRpc3RvcnRlZCBwaWN0dXJlLg0KDQpQcmV2aW91c2x5IEkgdXNlZCBz
ZXR1cCB3aXRoIHplcm8tY29weWluZywgc28gdGhlbiB0aGUgcGljdHVyZSBiZWNvbWVzIA0KbW9y
ZSBjb21wbGljYXRlZA0KaW4gdGVybXMgb2YgYnVmZmVycyBhbmQgaG93IHRob3NlIHVzZWQgYnkg
dGhlIGJhY2tlZCwgYnV0IGFueXdheXMgaXQgDQpzZWVtcyB0aGF0IHRoZQ0KdmVyeSBiYXNpYyBz
Y2VuYXJpbyB3aXRoIG1lbW9yeSBjb3B5aW5nIGRvZXNuJ3Qgd29yayBmb3IgbWUuDQoNClVzaW5n
IERNQSBBUEkgb24gZnJvbnRlbmQncyBzaWRlIGRvZXMgaGVscCAtIG5vIGFydGlmYWN0cyBhcmUg
c2Vlbi4NClRoaXMgaXMgd2h5IEknbSB0aGlua2luZyB0aGF0IHRoaXMgaXMgcmVsYXRlZCB0byBm
cm9udGVuZC9rZXJuZWwgc2lkZSANCnJhdGhlciB0aGVuIHRvDQp0aGUgYmFja2VuZCBzaWRlLiBU
aGlzIGlzIHdoeSBJJ20gdGhpbmtpbmcgdGhpcyBpcyByZWxhdGVkIHRvIGNhY2hlcyBhbmQgDQp0
cnlpbmcgdG8gZmlndXJlDQpvdXQgd2hhdCBjYW4gYmUgZG9uZSBoZXJlIGluc3RlYWQgb2YgdXNp
bmcgRE1BIEFQSS4NCg0KVGhhbmsgeW91LA0KT2xrZXNhbmRy

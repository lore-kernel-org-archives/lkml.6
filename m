Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5ABC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE662087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="DrItFWe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfA3JJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:09:30 -0500
Received: from mail-eopbgr50061.outbound.protection.outlook.com ([40.107.5.61]:49282
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727433AbfA3JJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLvqxsWhpHnn9GMDl5d3nC5PHAqTJvkJRFP2pPk8hV4=;
 b=DrItFWe7WJWj+OV2rSqWh2ZPpMSioZUxTWVnpksq89cDyvSzWqX6CAfObqLtqS4pISxGNTHMks44gQ/S7FfIn2U3hAKrbPKZk9GdKYDqeiQRSBrm3juhNU4x6wHedgFn4vQyF8jkCvj+X/vPMmriOH6nKrJTHAZkzOUQxrFkbKk=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB3557.eurprd03.prod.outlook.com (52.134.114.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Wed, 30 Jan 2019 09:09:22 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7%2]) with mapi id 15.20.1558.023; Wed, 30 Jan 2019
 09:09:22 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     Julien Grall <julien.grall@arm.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [Xen-devel][PATCH] drm/xen-front: Fix mmap attributes for display
 buffers
Thread-Topic: [Xen-devel][PATCH] drm/xen-front: Fix mmap attributes for
 display buffers
Thread-Index: AQHUt+PwOT/atadd5E6cEP5jJm29BKXGnAiAgADrJwA=
Date:   Wed, 30 Jan 2019 09:09:21 +0000
Message-ID: <c6e05462-2580-10a6-db8c-c6d5f5617105@epam.com>
References: <20190129150422.19867-1-andr2000@gmail.com>
 <bf8cf8d9-7092-d956-44d2-e55233f495d2@arm.com>
In-Reply-To: <bf8cf8d9-7092-d956-44d2-e55233f495d2@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB3557;6:h8OIvN47EVxegC1lHPGUjVKa4wrAqasuXrouRJ7H5j+rce29vSBoYPrbVoL20Hqz5vEdyKIY32dcdiJfTE8C+LNS/BXi1OYQ5U/h+dsdV6x94jIyfECF+1SvCSRzOlJDSFSWih6qd3qkoAAeL2C+JOdXkzEU2sjVcJd6fZkkSO7+z42KypleDuUCVDaoxBwlYjmlb4/TVLIrx91o38PkOTGnZi8140bEndGMARWcZU6ChpJUEIRg31ixNkkGRnHHTpkAB/ohPdLGvFFiJSJgBesyIfHRP6Jbeb7ShQpeavuYovCJ088XLM/AmGIYTdxRGRne3ndr65IFNOicvR75FNxno8UlgJ/L11JKyP/8XM/lQ4ovnQVPGsHGJ0ism4wdiClht9GA1V6zzOhNLC7tp/Z0d64H+fbvjZQhH4R4HJWhStozKUJIk2qMbwP8YP6VmbPDQdyCHQ8ib/820a+yjw==;5:gUkmyzfytccZ5nO4/PXxJdBYHxvfIKRN0sZDljJOjiaAXbrXcQfiFEcGgcvbom4ADXvw2CBW8lqU32fgCtm+mT9ot6LBciLL2g94V8dNH7m6NyKcNQdyM+ihGVn3L7sLxTtwgO2yaS/RzuCUtNCp3jv9ibpHuNwj52iTFRoIPDoqSR6qXbD6k0iI/WsszouGqjMx8eAmeHrHJH+2tzyqhQ==;7:5KPRPV9w8OiyKFXjQQ8Q7mlsutJ/mipRZchGYJhpi8A0w5L5BHv8Tsjpdv8hqmnPtP1WQKIVLLVOE9dsdFJC+jRa+b3WutpgbhZlC1kdIJTzaB/ejmzupyRqfmBQ8Lh+VQHsiRIDQAUojLVbgLF3tQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dc5aa0e1-3897-4d50-f95b-08d686929fae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB3557;
x-ms-traffictypediagnostic: AM6PR03MB3557:
x-microsoft-antispam-prvs: <AM6PR03MB355736A1747C3167FA284574E7900@AM6PR03MB3557.eurprd03.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(366004)(136003)(346002)(189003)(199004)(71190400001)(71200400001)(6486002)(316002)(486006)(68736007)(2616005)(97736004)(186003)(26005)(476003)(80792005)(39060400002)(66066001)(72206003)(2906002)(105586002)(8936002)(106356001)(6506007)(102836004)(81156014)(7416002)(8676002)(478600001)(53546011)(81166006)(55236004)(6512007)(6246003)(99286004)(6436002)(7736002)(110136005)(31686004)(305945005)(86362001)(3846002)(31696002)(6116002)(256004)(14454004)(14444005)(76176011)(2201001)(25786009)(229853002)(11346002)(446003)(36756003)(2501003)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB3557;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H3TmEMMVwixXsz9gbOY0G5qL4etCvsjHXcTe9qfxAhmPcyEYhv9JTl6JX7GIrpZFawmm/gJUCnzWJ590F4U1N7SfpQfMu2S3cgrEljR7+2R1MRUmA3jvaJtDHPhpG5Z/q3rwGbFkQp5JNU8iPrbvBCwki1wUfxhPmARlr4uVKJhX7djs7lBnkU5KM4+63mIVZH5pR9inuO57Xik7DfJJ/csTFJ1d7bS7LsGBehCY0qHlX3qcxbmr0ZiQkiXzfNStsTbYu0Y1OWBdKn5LEz+Ov/e6ArrpGekTitHX/tI8e9KS45xI0yB51BxgET1NCfzh9vuZpH5el4q2uEmdWCi9AUvkLUfo+MrrHIgwaE99+342UadwDuLKumNbzsm3CE7jCT2fDplfw3R/8YCohVOGWeyx5X/Ak1GIPMMJkQ81njo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD6619B6DB127841AEFAE4AF25D32001@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5aa0e1-3897-4d50-f95b-08d686929fae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 09:09:22.0645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yOS8xOSA5OjA3IFBNLCBKdWxpZW4gR3JhbGwgd3JvdGU6DQo+IEhpIE9sZWtzYW5kciwN
Cj4NCj4gT24gMS8yOS8xOSAzOjA0IFBNLCBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyB3cm90ZToN
Cj4+IEZyb206IE9sZWtzYW5kciBBbmRydXNoY2hlbmtvIDxvbGVrc2FuZHJfYW5kcnVzaGNoZW5r
b0BlcGFtLmNvbT4NCj4+DQo+PiBXaGVuIEdFTSBiYWNraW5nIHN0b3JhZ2UgaXMgYWxsb2NhdGVk
IHRob3NlIGFyZSBub3JtYWwgcGFnZXMsDQo+PiBzbyB0aGVyZSBpcyBubyBwb2ludCB1c2luZyBw
Z3Byb3Rfd3JpdGVjb21iaW5lIHdoaWxlIG1tYXBpbmcuDQo+PiBUaGlzIGZpeGVzIG1pc21hdGNo
IG9mIGJ1ZmZlciBwYWdlcycgbWVtb3J5IGF0dHJpYnV0ZXMgYmV0d2Vlbg0KPj4gdGhlIGZyb250
ZW5kIGFuZCBiYWNrZW5kIHdoaWNoIG1heSBjYXVzZSBzY3JlZW4gYXJ0aWZhY3RzLg0KPj4NCj4+
IEZpeGVzOiBjNTc1YjdlZWI4OWYgKCJkcm0veGVuLWZyb250OiBBZGQgc3VwcG9ydCBmb3IgWGVu
IFBWIGRpc3BsYXkgDQo+PiBmcm9udGVuZCIpDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogT2xla3Nh
bmRyIEFuZHJ1c2hjaGVua28gDQo+PiA8b2xla3NhbmRyX2FuZHJ1c2hjaGVua29AZXBhbS5jb20+
DQo+PiBTdWdnZXN0ZWQtYnk6IEp1bGllbiBHcmFsbCA8anVsaWVuLmdyYWxsQGFybS5jb20+DQo+
PiAtLS0NCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS94ZW4veGVuX2RybV9mcm9udF9nZW0uYyB8IDUg
KystLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS94ZW4veGVuX2RybV9mcm9u
dF9nZW0uYyANCj4+IGIvZHJpdmVycy9ncHUvZHJtL3hlbi94ZW5fZHJtX2Zyb250X2dlbS5jDQo+
PiBpbmRleCBkMzAzYTJlMTdmNWUuLjlkNWMwM2Q3NjY4ZCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS94ZW4veGVuX2RybV9mcm9udF9nZW0uYw0KPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3hlbi94ZW5fZHJtX2Zyb250X2dlbS5jDQo+PiBAQCAtMjM1LDggKzIzNSw3IEBAIHN0YXRp
YyBpbnQgZ2VtX21tYXBfb2JqKHN0cnVjdCB4ZW5fZ2VtX29iamVjdCANCj4+ICp4ZW5fb2JqLA0K
Pj4gwqDCoMKgwqDCoCB2bWEtPnZtX2ZsYWdzICY9IH5WTV9QRk5NQVA7DQo+PiDCoMKgwqDCoMKg
IHZtYS0+dm1fZmxhZ3MgfD0gVk1fTUlYRURNQVA7DQo+PiDCoMKgwqDCoMKgIHZtYS0+dm1fcGdv
ZmYgPSAwOw0KPj4gLcKgwqDCoCB2bWEtPnZtX3BhZ2VfcHJvdCA9DQo+PiAtIHBncHJvdF93cml0
ZWNvbWJpbmUodm1fZ2V0X3BhZ2VfcHJvdCh2bWEtPnZtX2ZsYWdzKSk7DQo+PiArwqDCoMKgIHZt
YS0+dm1fcGFnZV9wcm90ID0gdm1fZ2V0X3BhZ2VfcHJvdCh2bWEtPnZtX2ZsYWdzKTsNCj4NCj4g
VGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuIEl0IHdvdWxkIGJlIHdvcnRoIGV4cGFuZGluZyB0
aGUgY29tbWVudCBhIA0KPiBiaXQgYmVmb3JlIHRvIGV4cGxhaW4gdGhhdCB3ZSBvdmVyd3JpdGUg
dm1fcGFnZV9wcm90IHRvIHVzZSBjYWNoZWFibGUgDQo+IGF0dHJpYnV0ZSBhcyByZXF1aXJlZCBi
eSB0aGUgWGVuIEFCSS4NCj4NCk9rLCB0aGVuIEknbGwgcHV0Og0KDQorwqDCoMKgwqDCoMKgIC8q
DQorwqDCoMKgwqDCoMKgwqAgKiBBY2NvcmRpbmcgdG8gWGVuIG9uIEFSTSBBQkkgKHhlbi9pbmNs
dWRlL3B1YmxpYy9hcmNoLWFybS5oKToNCivCoMKgwqDCoMKgwqDCoCAqIGFsbCBtZW1vcnkgd2hp
Y2ggaXMgc2hhcmVkIHdpdGggb3RoZXIgZW50aXRpZXMgaW4gdGhlIHN5c3RlbQ0KK8KgwqDCoMKg
wqDCoMKgICogKGluY2x1ZGluZyB0aGUgaHlwZXJ2aXNvciBhbmQgb3RoZXIgZ3Vlc3RzKSBtdXN0
IHJlc2lkZSBpbiBtZW1vcnkNCivCoMKgwqDCoMKgwqDCoCAqIHdoaWNoIGlzIG1hcHBlZCBhcyBO
b3JtYWwgSW5uZXIgV3JpdGUtQmFjayBPdXRlciBXcml0ZS1CYWNrDQorwqDCoMKgwqDCoMKgwqAg
KiBJbm5lci1TaGFyZWFibGUuDQorwqDCoMKgwqDCoMKgwqAgKi8NCiDCoMKgwqDCoMKgwqDCoCB2
bWEtPnZtX3BhZ2VfcHJvdCA9IHZtX2dldF9wYWdlX3Byb3Qodm1hLT52bV9mbGFncyk7DQpQbGVh
c2UgbGV0IG1lIGtub3cgaWYgdGhpcyBpcyBub3Qgd2hhdCB5b3Ugd2FudA0KPiBXaXRoIHRoZSBj
b21tZW50IHVwZGF0ZWQ6DQo+DQo+IEFja2VkLWJ5OiBKdWxpZW4gR3JhbGwgPGp1bGllbi5ncmFs
bEBhcm0uY29tPg0KPg0KPiBDaGVlcnMsDQo+DQpUaGFuayB5b3UsDQpPbGVrc2FuZHI=

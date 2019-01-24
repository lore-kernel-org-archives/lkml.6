Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CECC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54BB217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 11:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i5Br2AVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfAXLhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 06:37:39 -0500
Received: from mail-eopbgr710051.outbound.protection.outlook.com ([40.107.71.51]:29632
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfAXLhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 06:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWo/JpDfLERoTEvy07CLEshKybOBtvoS1BSz04ddzDI=;
 b=i5Br2AVXNfQ1tQ7Yjg/IxJnQ0N/4n1DsKN+0+F7TBHwQGaQ1yQvixw0hqlYffUJPS5fe+NbHTdOrZEqhx+y+IntR0AYgAvOXkmdy2MjOer5gVB1ruoyxGbmdyo4vHGuK4hvyzokwO+wqqH6USXqyWIoB1kJ/EYvd0H+ggY8SwOo=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1226.namprd12.prod.outlook.com (10.168.237.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Thu, 24 Jan 2019 11:37:33 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e%10]) with mapi id 15.20.1558.016; Thu, 24 Jan
 2019 11:37:33 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Thread-Topic: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Thread-Index: AQHUsXD3UXk0MPD/dUyEFCISRS4xuqW50zEAgAAHO4CAAActAIAABFSAgAACPQCAAAIPAIAAF8kAgAABIQCAAAF0AIAABGAAgAABGQCAAAFFAIAAChyAgADjSQCAAM5NgIAAAvSAgACp8ICAAB+TAIAAf28AgAACVwCAARHuAIAAA2gAgAAA64CAAASOgIAAA/WAgAAXlACAAAC8AIAAAx8A
Date:   Thu, 24 Jan 2019 11:37:32 +0000
Message-ID: <40ad3ae7-9970-0cb9-d35c-05e128f83820@amd.com>
References: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org>
 <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
 <20190124091316.GA22796@infradead.org>
 <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
 <CAKv+Gu_3LurSN-6w1WijPfpJpc+Pgu0YTnwTfMrXMF3-AKAnJA@mail.gmail.com>
 <953e5e5f-5d47-d6df-40df-c8c94db5447f@amd.com>
 <CAKv+Gu9umPEmB+wh54NOTYcQ14oxf7rwVAXgCqo7V2A+VwkqPA@mail.gmail.com>
 <57590a48-4629-e2a1-8673-ce9eb2ec210b@amd.com>
 <CAKv+Gu_2f0FaJ+Th7H48u4GrPX=MM9xw0fFjdwhfRrr1nhgEkA@mail.gmail.com>
In-Reply-To: <CAKv+Gu_2f0FaJ+Th7H48u4GrPX=MM9xw0fFjdwhfRrr1nhgEkA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6PR0102CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::37) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1226;20:f+wIn9Ei8lOGm1Oxo4Pa3vI7YEwb6qg85ndIICENvENW3JTmutyN/HjH7fblm53jT4riFL+5EQJw+v6KAlmDBz9u88Pm6Hiw/I3LJQTP+tMvbXp4dS6a5oGQFxevIrs16AHzP4ssaRb1TTkCb6VyiyXzfKTFW204v8L8xjI4vYdhQ+gWPNnbMTu8BVq58wUER07O03wOU56UyvKllh9xJ7NQmd46G+yXc1HDLqLHaVde0SMxrLsa7GDBsshEDCto
x-ms-office365-filtering-correlation-id: 29a80888-f77e-4623-55a2-08d681f0544b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1226;
x-ms-traffictypediagnostic: DM5PR12MB1226:
x-microsoft-antispam-prvs: <DM5PR12MB12262CAD31D6E92555997D67839A0@DM5PR12MB1226.namprd12.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(189003)(199004)(6116002)(93886005)(76176011)(71200400001)(52116002)(65956001)(46003)(65806001)(71190400001)(6916009)(476003)(58126008)(316002)(2616005)(65826007)(386003)(6506007)(186003)(102836004)(54906003)(446003)(11346002)(97736004)(14454004)(68736007)(105586002)(7416002)(106356001)(486006)(31686004)(99286004)(81166006)(25786009)(6436002)(86362001)(81156014)(8676002)(229853002)(6246003)(6486002)(72206003)(64126003)(2906002)(31696002)(14444005)(256004)(8936002)(478600001)(53936002)(7736002)(305945005)(4326008)(39060400002)(36756003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1226;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3K5FuE9rdkB/GQIImsDNnVQpMZNb0Kjm/dwcfzEol0BeHrq8yU5sM5p0E4YS9vAlQ1O1ed1XUXk+uYu0Voambh3NnR9Tmf1bUBZ2h0xheb9NUPthfJuOMMeG08iMvx3XA+htWCeszRQjFVdHId2sydfCrICLktL1FvBWAMpNLH86dmCRV0ukp+W4MU7TgNTARQ4+Hfy6Ul0rUh+wgZHgtGQbw1nD/LoqonrluEvF9amFgfUHmH0OBZUdG/lfMufBu/uZovVZT+KNCtEriwo8cr2m1QZQNpAOgRpTK8e70G+bAc45qe58X+Mx1tX7AHDA6mwfsGlQEkJM/qHWwKuHfheT1avo1dFx8sVdAzlHXs3/8vT1pieEByD82ug9PhudwMkbWH0kjxsdKablP/KcX7OXj0v5IheI8xzgJYkeDM4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59400AED9633BA419EDBE63373A4A150@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a80888-f77e-4623-55a2-08d681f0544b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 11:37:28.7058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjQuMDEuMTkgdW0gMTI6MjYgc2NocmllYiBBcmQgQmllc2hldXZlbDoNCj4gT24gVGh1LCAy
NCBKYW4gMjAxOSBhdCAxMjoyMywgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT4gd3JvdGU6DQo+PiBBbSAyNC4wMS4xOSB1bSAxMDo1OSBzY2hyaWViIEFyZCBC
aWVzaGV1dmVsOg0KPj4+IFtTTklQXQ0KPj4+IFRoaXMgaXMgKmV4YWN0bHkqIG15IHBvaW50IHRo
ZSB3aG9sZSB0aW1lLg0KPj4+DQo+Pj4gVGhlIGN1cnJlbnQgY29kZSBoYXMNCj4+Pg0KPj4+IHN0
YXRpYyBpbmxpbmUgYm9vbCBkcm1fYXJjaF9jYW5fd2NfbWVtb3J5KHZvaWQpDQo+Pj4gew0KPj4+
ICNpZiBkZWZpbmVkKENPTkZJR19QUEMpICYmICFkZWZpbmVkKENPTkZJR19OT1RfQ09IRVJFTlRf
Q0FDSEUpDQo+Pj4gICAgICByZXR1cm4gZmFsc2U7DQo+Pj4NCj4+PiB3aGljaCBtZWFucyB0aGUg
b3B0aW1pemF0aW9uIGlzIGRpc2FibGVkICp1bmxlc3MgdGhlIHN5c3RlbSBpcw0KPj4+IG5vbi1j
YWNoZSBjb2hlcmVudCoNCj4+Pg0KPj4+IFNvIGlmIHlvdSBoYXZlIHJlcG9ydHMgdGhhdCB0aGUg
b3B0aW1pemF0aW9uIHdvcmtzIG9uIHNvbWUgUG93ZXJQQywgaXQNCj4+PiBtdXN0IGJlIG5vbi1j
YWNoZSBjb2hlcmVudCBQb3dlclBDLCBiZWNhdXNlIHRoYXQgaXMgdGhlIG9ubHkgcGxhY2UNCj4+
PiB3aGVyZSBpdCBpcyBlbmFibGVkIGluIHRoZSBmaXJzdCBwbGFjZS4NCj4+Pg0KPj4+PiBUaGUg
b25seSBwcm9ibGVtYXRpYyBoZXJlIGFjdHVhbGx5IHNlZW1zIHRvIGJlIEFSTSwgc28geW91IHNo
b3VsZA0KPj4+PiBwcm9iYWJseSBqdXN0IGFkZCBhbiAiI2lmZGVmIC4uX0FSTSByZXR1cm4gZmFs
c2U7Ii4NCj4+Pj4NCj4+PiBBUk0vYXJtNjQgZG9lcyBub3QgaGF2ZSBhIEtjb25maWcgc3ltYm9s
IGxpa2UNCj4+PiBDT05GSUdfTk9UX0NPSEVSRU5UX0NBQ0hFLCBzbyB3ZSBjYW4gb25seSBkaXNh
YmxlIGl0IGV2ZXJ5d2hlcmUuIElmDQo+Pj4gdGhlcmUgYXJlIG5vbi1jb2hlcmVudCBBUk0gc3lz
dGVtcyB0aGF0IGFyZSBjdXJyZW50bHkgd29ya2luZyBpbiB0aGUNCj4+PiBzYW1lIHdheSBhcyB0
aG9zZSBub24tY29oZXJlbnQgUG93ZXJQQyBzeXN0ZW1zLCB3ZSB3aWxsIGJyZWFrIHRoZW0gYnkN
Cj4+PiBkb2luZyB0aGlzLg0KPj4gU3VtbWluZyB0aGUgdGhpbmdzIEkndmUgcmVhZCBzbyBmYXIg
Zm9yIEFSTSB1cCBJIGFjdHVhbGx5IHRoaW5rIGl0DQo+PiBkZXBlbmRzIG9uIGEgcnVudGltZSBj
b25maWd1cmF0aW9uIGFuZCBub3Qgb24gY29tcGlsZSB0aW1lIG9uZS4NCj4+DQo+PiBTbyB0aGUg
d2hvbGUgaWRlYSBvZiBwcm92aWRpbmcgdGhlIGRldmljZSB0byB0aGUgZHJtXypfY2FuX3djX21l
bW9yeSgpDQo+PiBmdW5jdGlvbiBpc24ndCBzbyBmYXIgZmV0Y2hlZC4NCj4+DQo+IFRoYW5rIHlv
dS4NCj4NCj4+IEJ1dCBmb3Igbm93IEkgZG8gcHJlZmVyIHdvcmtpbmcgYW5kIHNsaWdodGx5IHNs
b3dlciBzeXN0ZW0gb3ZlciBicm9rZW4NCj4+IG9uZSwgc28gSSB0aGluayB3ZSBzaG91bGQganVz
dCBkaXNhYmxlIHRoaXMgb24gQVJNIGZvciBub3cuDQo+Pg0KPiBBZ2FpbiwgdGhpcyBpcyBub3Qg
YWJvdXQgbm9uLWNhY2hlIGNvaGVyZW50IGJlaW5nIHNsb3dlciB3aXRob3V0IHRoZQ0KPiBvcHRp
bWl6YXRpb24sIGl0IGlzIGFib3V0IG5vbi1jYWNoZSBjb2hlcmVudCBsaWtlbHkgbm90IHdvcmtp
bmcgKmF0DQo+IGFsbCogdW5sZXNzIHRoZSBvcHRpbWl6YXRpb24gaXMgZW5hYmxlZC4NCg0KQXMg
TWljaGVsIHRyaWVkIHRvIGV4cGxhaW4gdGhpcyBDQU4nVCBoYXBwZW4uIFRoZSBvcHRpbWl6YXRp
b24gaXMgYSANCnB1cmVseSBvcHRpb25hbCByZXF1ZXN0IGZyb20gdXNlcnNwYWNlLg0KDQo+IE90
aGVyd2lzZSwgdGhlIGRyaXZlciB3aWxsIHZtYXAoKSBETUEgcGFnZXMgd2l0aCBjYWNoZWFibGUg
YXR0cmlidXRlcywNCj4gd2hpbGUgdGhlIG5vbi1jYWNoZSBjb2hlcmVudCBkZXZpY2UgdXNlcyB1
bmNhY2hlZCBhdHRyaWJ1dGVzLCBicmVha2luZw0KPiBjb2hlcmVuY3kuDQoNCkFnYWluIHRoaXMg
aXMgbWFuZGF0ZWQgYnkgdGhlIHVzZXJzcGFjZSBBUElzIGFueXdheS4gRS5nLiB3ZSBjYW4ndCAN
CnZtYXAoKSBwYWdlcyBpbiBhbnkgb3RoZXIgd2F5IG9yIG91ciB1c2Vyc3BhY2UgQVBJcyB3b3Vs
ZCBicmVhay4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg==

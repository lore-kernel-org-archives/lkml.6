Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA39BC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6FD20855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uJBStDlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfAXJpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:45:16 -0500
Received: from mail-eopbgr800050.outbound.protection.outlook.com ([40.107.80.50]:62316
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbfAXJpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/pDJhRUGys9jUMusQi6I+O68rG3wkkWFHyUrdqnFko=;
 b=uJBStDltMkdnXL7uIGk02yXm1C9VxA29DhXCTiykwDa0Q5cOc0siIKqt5tVALrJ5PwRM2Az4EjZevWEAG/p+ROu0Z2eZTPPKce1sl8C/8HLJWij+qGnFhb21Dgao7VGzBX6zDLBa1WnmiILHKGOVgywCbo0Q5i+RXWieZFM7bx0=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1771.namprd12.prod.outlook.com (10.175.91.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.30; Thu, 24 Jan 2019 09:45:12 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e%10]) with mapi id 15.20.1558.016; Thu, 24 Jan
 2019 09:45:12 +0000
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
Thread-Index: AQHUsXD3UXk0MPD/dUyEFCISRS4xuqW50zEAgAAHO4CAAActAIAABFSAgAACPQCAAAIPAIAAF8kAgAABIQCAAAF0AIAABGAAgAABGQCAAAFFAIAAChyAgADjSQCAAM5NgIAAAvSAgACp8ICAAB+TAIAAf28AgAACVwCAARHuAIAAA2gAgAAA64CAAASOgA==
Date:   Thu, 24 Jan 2019 09:45:12 +0000
Message-ID: <953e5e5f-5d47-d6df-40df-c8c94db5447f@amd.com>
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
In-Reply-To: <CAKv+Gu_3LurSN-6w1WijPfpJpc+Pgu0YTnwTfMrXMF3-AKAnJA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6P191CA0064.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::41) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1771;20:ZG62PIr/YAZ2OWgRdWcBHyQ9aRo3/84WQKgBeCFgYK1R/VK/t11844sh8G4gMM09/IXiyz3cklL32SIe2j6bZcti/weSfzIPinYJnlNeG/N7JzM481dSXHweE0/PqcriJ0Gk9yHDaXza7q/ArdKDA4PR1lm4ehw5g5f7N0s79WjCKrP1ZK9R+QhLm8Mt+PgLCTW3r/Tb41G96GI/HQOm/nbZWg3isgiqRXUsdSxI2VY9tzrWw8OsLPq9fLtvH7W/
x-ms-office365-filtering-correlation-id: 86194bc8-b296-4240-6f36-08d681e0a2a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1771;
x-ms-traffictypediagnostic: DM5PR12MB1771:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-microsoft-antispam-prvs: <DM5PR12MB1771B066F606C45D5725107A839A0@DM5PR12MB1771.namprd12.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(6506007)(76176011)(386003)(102836004)(52116002)(6116002)(316002)(6486002)(31696002)(6436002)(105586002)(14444005)(65956001)(256004)(65806001)(65826007)(71200400001)(186003)(31686004)(7416002)(71190400001)(446003)(11346002)(36756003)(106356001)(476003)(46003)(2616005)(2906002)(478600001)(68736007)(72206003)(99286004)(6512007)(486006)(93886005)(6916009)(25786009)(229853002)(97736004)(39060400002)(305945005)(81156014)(81166006)(54906003)(86362001)(8676002)(7736002)(53936002)(4326008)(58126008)(8936002)(64126003)(14454004)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1771;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 22q6HlGiVBLZw36aIidVkGTPCxowaOwbfjnq6T1PACcE6qqaY2T1WjhQh6h3I3ooxSMyS7j+tLQ4xM6KRENHqcdF5WJ0e4M2ASOkyH7Lf+fHhUUzxmiUj/ssL/ab61CaG2RGgB31NAfq9OmJDIkGNBzpDaWuLOUJTZswityM9Cst3IzcnkV/gU1u7sFyepNwz4AuVTyIN1dh3s3icIs9zLeU+oCMDGstWMPh/FjlMZDa2pwrmw0NiIoREIm4ulY2FOaa+QPJILMlpZXVuybz6RC774LuVPtQn+oOIvWYeGSnOspoGsXz8zAcMthQ59jzW9XngMgZSkcwn0LXYnCdlEeXdL53nRtFwmSiWxlQiAegMj+MRW8rw1d/5A/5Ygd6l/PDVnF45ktweCMpv8JbW3+wQjkDcesp7dEmYdT/s10=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FACB70F4502C74F892D9E8CBB9DBD2D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86194bc8-b296-4240-6f36-08d681e0a2a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 09:45:07.8527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjQuMDEuMTkgdW0gMTA6Mjggc2NocmllYiBBcmQgQmllc2hldXZlbDoNCj4gT24gVGh1LCAy
NCBKYW4gMjAxOSBhdCAxMDoyNSwgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT4gd3JvdGU6DQo+PiBBbSAyNC4wMS4xOSB1bSAxMDoxMyBzY2hyaWViIENocmlz
dG9waCBIZWxsd2lnOg0KPj4+IE9uIFdlZCwgSmFuIDIzLCAyMDE5IGF0IDA1OjUyOjUwUE0gKzAx
MDAsIEFyZCBCaWVzaGV1dmVsIHdyb3RlOg0KPj4+PiBCdXQgbXkgY29uY2VybiBpcyB0aGF0IGl0
IHNlZW1zIGxpa2VseSB0aGF0IG5vbi1jYWNoZSBjb2hlcmVudA0KPj4+PiBpbXBsZW1lbnRhdGlv
bnMgYXJlIHJlbHlpbmcgb24gdGhpcyBoYWNrIGFzIHdlbGwuIFRoZXJlIG11c3QgYmUgYQ0KPj4+
PiByZWFzb24gdGhhdCB0aGlzIGhhY2sgaXMgb25seSBkaXNhYmxlZCBmb3IgUG93ZXJQQyBwbGF0
Zm9ybXMgaWYgdGhleQ0KPj4+PiBhcmUgY2FjaGUgY29oZXJlbnQsIGZvciBpbnN0YW5jZSwgYW5k
IEkgc3VzcGVjdCB0aGF0IHRoYXQgcmVhc29uIGlzDQo+Pj4+IHRoYXQgdGhlIGhhY2sgaXMgdGhl
IG9ubHkgdGhpbmcgZW5zdXJpbmcgdGhhdCB0aGUgQ1BVIG1hcHBpbmcNCj4+Pj4gYXR0cmlidXRl
cyBtYXRjaCB0aGUgZGV2aWNlIG9uZXMgdXNlZCBmb3IgdGhlc2UgYnVmZmVycyAodGhlIHZtYXAo
KWVkDQo+Pj4+IG9uZXMpLCB3aGVyZWFzIHRoZSByaW5ncyBhbmQgb3RoZXIgY29uc2lzdGVudCBk
YXRhIHN0cnVjdHVyZXMgYXJlDQo+Pj4+IHVzaW5nIHRoZSBETUEgQVBJIGFzIGludGVuZGVkLCBh
bmQgdGh1cyBnZXR0aW5nIHVuY2FjaGVkIGF0dHJpYnV0ZXMgaW4NCj4+Pj4gdGhlIGNvcnJlY3Qg
d2F5Lg0KPj4+IERhdmUsIHdobyBhZGRlZCB0aGF0IGNvbW1pdCBpcyBvbiBDYyB0b2dldGhlciB3
aXRoIGp1c3QgYWJvdXQgZXZlcnlvbmUNCj4+PiBpbnZvbHZlZCBpbiB0aGUgcmV2aWV3IGNoYWlu
LiAgQmFzZWQgb24gdGhlIHByZXZpb3VzIGV4cGxhbmF0aW9uDQo+Pj4gdGhhdCBpZGVhIHdoYXQg
d2UgbWlnaHQgd2FudCBhbiB1bmNhY2hlZCBtYXBwaW5nIGZvciBzb21lIG5vbi1jb2hlcmVudA0K
Pj4+IGFyY2hpdGVjdHVyZXMgZm9yIHRoaXMgdG8gd29yayBhdCBhbGwgbWFrZXMgc2Vuc2UsIGJ1
dCB0aGVuIGFnYWluDQo+Pj4gdGhlIHdheSB0byBjcmVhdGUgdGhvc2UgbWFwcGluZ3MgaXMgZW50
aXJlbHkgYXJjaGl0ZWN0dXJlIHNwZWNpZmljLA0KPj4+IGFuZCBhbHNvIG5lZWQgYSBjYWNoZSBm
bHVzaGluZyBiZWZvcmUgY3JlYXRpbmcgdGhlIG1hcHBpbmcgdG8gd29yaw0KPj4+IHByb3Blcmx5
LiAgU28gbXkgd29ya2luZyB0aGVvcnkgaXMgdGhhdCB0aGlzIGNvZGUgbmV2ZXIgcHJvcGVybHkN
Cj4+PiB3b3JrZWQgb24gYXJjaGl0ZWN0dXJlcyB3aXRob3V0IERNQSBjb2hlcmVudCBmb3IgUENJ
ZSBhdCBhbGwsIGJ1dA0KPj4+IEknZCBsb3ZlIHRvIGJlIGNvcnJlY3RlZCBieSBjb25jcmV0ZSBl
eGFtcGxlcyBpbmNsdWRpbmcgYW4gZXhwbGFuYXRpb24NCj4+PiBvZiBob3cgaXQgYWN0dWFsbHkg
ZW5kcyB1cCB3b3JraW5nLg0KPj4gQ2FjaGUgY29oZXJlbmN5IGlzIG1hbmRhdG9yeSBmb3IgbW9k
ZXJuIEdQVSBvcGVyYXRpb24uDQo+Pg0KPj4gT3RoZXJ3aXNlIHlvdSBjYW4ndCBpbXBsZW1lbnQg
YSBidW5jaCBvZiB0aGUgcmVxdWlyZW1lbnRzIG9mIHRoZQ0KPj4gdXNlcnNwYWNlIEFQSXMuDQo+
Pg0KPj4gSW4gb3RoZXIgd29yZHMgdGhlIGFwcGxpY2F0aW9ucyBkb2Vzbid0IGluZm9ybSB0aGUg
ZHJpdmVyIHRoYXQgdGhlIEdQVQ0KPj4gb3IgdGhlIENQVSBpcyBhY2Nlc3NpbmcgZGF0YSwgaXQg
anVzdCBkb2VzIGl0IGFuZCBhc3N1bWVzIHRoYXQgaXQgd29ya3MuDQo+Pg0KPiBXb25kZXJmdWwh
DQo+DQo+IEluIHRoYXQgY2FzZSwgZG8geW91IGhhdmUgYW55IG9iamVjdGlvbnMgdG8gdGhlIHBh
dGNoIHByb3Bvc2VkIGJ5DQo+IENocmlzdG9waCBhYm92ZT8NCg0KWWVhaCwgdGhlIHBhdGNoIG9m
IENocmlzdG9waCBhY3R1YWxseSBnb2VzIHdheSB0byBmYXIgY2F1c2Ugd2UgaGF2ZSANCnJlcG9y
dHMgdGhhdCB0aGlzIHdvcmtzIG9uIGEgYnVuY2ggb2Ygb3RoZXIgYXJjaGl0ZWN0dXJlcy4NCg0K
RS5nLiBYODYgNjRiaXQsIFBvd2VyUEMgKHVuZGVyIHNvbWUgY29uZGl0aW9ucykgYW5kIHNvbWUg
TUlQUy4NCg0KVGhlIG9ubHkgcHJvYmxlbWF0aWMgaGVyZSBhY3R1YWxseSBzZWVtcyB0byBiZSBB
Uk0sIHNvIHlvdSBzaG91bGQgDQpwcm9iYWJseSBqdXN0IGFkZCBhbiAiI2lmZGVmIC4uX0FSTSBy
ZXR1cm4gZmFsc2U7Ii4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg==

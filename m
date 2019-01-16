Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6A7C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1717620866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5PuWk8RX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388448AbfAPHgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 02:36:03 -0500
Received: from mail-eopbgr820071.outbound.protection.outlook.com ([40.107.82.71]:38457
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727667AbfAPHgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 02:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuOxI1mfPcE718ss50c6wYtffm3KloGil4Sop5UUca4=;
 b=5PuWk8RXM+n3iYNo7K6lFqMSBINJA5GQvuF3okEIe2SZmuvhvCBRypJ93wnpAsG1GTVijt8I1edOiIKKZ+kkRSOKCPa3kUydb/lMXfEGtFusrd50MdcxnjTWr5FhrmZ4LBYGTE1jJ4Luv8bt5QyaDsaAzcqpoqxCA/KllOBhrU4=
Received: from CY4PR12MB1717.namprd12.prod.outlook.com (10.175.62.139) by
 CY4PR12MB1751.namprd12.prod.outlook.com (10.175.62.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Wed, 16 Jan 2019 07:35:58 +0000
Received: from CY4PR12MB1717.namprd12.prod.outlook.com
 ([fe80::7dec:669a:ec18:7f0f]) by CY4PR12MB1717.namprd12.prod.outlook.com
 ([fe80::7dec:669a:ec18:7f0f%7]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 07:35:58 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>
CC:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?QmVybmhhcmQgUm9zZW5rcsOkbnplcg==?= 
        <Bernhard.Rosenkranzer@linaro.org>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Thread-Topic: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Thread-Index: AQHUqLYqeBA87jEBLUOvwyi3in13KaWoPfAAgAZfVICAAAyHgIAAYvAAgAAasQCAAAG3AIAAAgEAgAAEIgCAAQsEgIAA2mIAgAB2HYA=
Date:   Wed, 16 Jan 2019 07:35:58 +0000
Message-ID: <9dc27cbf-e109-0c32-fc92-6fce1b224cda@amd.com>
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
 <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
 <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
 <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com>
 <CAKv+Gu_JyO2KNtdN1-_TcoL_kqs0yswdwBrpAXA6-jyWuDrj+g@mail.gmail.com>
 <9f956898-7973-98ee-6bf1-e1d445e9d365@amd.com>
 <20190114191350.GA29600@fuggles.cambridge.arm.com>
 <a6d9d0ad-d1c0-9e60-17c6-a42f7bde258c@amd.com>
 <20190114193548.GB29600@fuggles.cambridge.arm.com>
 <87a7k2yx66.fsf@concordia.ellerman.id.au>
 <ed2dd9042d1afede4843d7fd3728a4d701a19fdd.camel@kernel.crashing.org>
In-Reply-To: <ed2dd9042d1afede4843d7fd3728a4d701a19fdd.camel@kernel.crashing.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6PR0502CA0071.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::48) To CY4PR12MB1717.namprd12.prod.outlook.com
 (2603:10b6:903:121::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1751;20:frZSrrkJOxoKWoHmJrtm3Ty33j0bCo6wgswe5gw4q93pDthP5gQJpE6m86Ty8I+IzdprITYW43qeEOpKsjSnhSqgmkVjWPRugqXBxehIiaXf0JeCDaCNqptwGP84FJTLzltZkDUG2BMgl84t/rNctlS5h62KVgeoSpvYAw1cKBVC+GJdOa4wb0WJq9wX+PYcb3S2RAJ5xuipYhI5nfoKuy8QxfRwzS6NwwwjbRiVDwm68KT9g7UHpaR6CcxDy4/R
x-ms-office365-filtering-correlation-id: 24c14c0d-d4d9-431a-0ec2-08d67b85418f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1751;
x-ms-traffictypediagnostic: CY4PR12MB1751:
x-microsoft-antispam-prvs: <CY4PR12MB1751ABBCC6C5D74863F4842083820@CY4PR12MB1751.namprd12.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(189003)(199004)(71190400001)(71200400001)(11346002)(97736004)(25786009)(229853002)(4326008)(53936002)(6246003)(7416002)(6512007)(446003)(6116002)(86362001)(6486002)(31696002)(486006)(476003)(46003)(64126003)(68736007)(2906002)(6436002)(2616005)(7736002)(31686004)(305945005)(105586002)(106356001)(8676002)(81156014)(8936002)(316002)(99286004)(186003)(478600001)(52116002)(36756003)(102836004)(386003)(72206003)(110136005)(54906003)(65826007)(65806001)(14444005)(256004)(65956001)(5660300001)(58126008)(81166006)(93886005)(14454004)(76176011)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1751;H:CY4PR12MB1717.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sPiZ0r48goOCDcE+Ocz9Ik/Qw2jt9QKb5KbJtK/w6wYPWRZd5H1hwpkzA+mhO6EEibnoiazt0rTTgFAjjfowY7XlmTaGZRhXkPM5nBmABS2W2QzSp/bTlk1KMsM2Xc7baPcrYZOj+7HCY7ZWOIQw0zh1LdYz4guGGPwgRwX99aFDzk5Up0sDI75d0aZZhwazJovCD3GzAJL/ZauUbAWhmf7udjD0KtieDJwe0LltUNDOEff9WjtyLOOmpaYwcn5udx/2go51FuH3Zxpzm3LK8NEvFDK+4tmV9I+L4w7XYm191eA5v+7tRu1+DVCf1/T9LY82pjuvLTH5okfE6xTaR3NputKVpum9NkfVIcLN6q7+jILDRG22i9lGjGqtVje7Io0GVCVJpzuoUjmJh/6YptJrVVWktCU7hRBmes5QcR8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A8E14009A14C34A840EDD336B706F9B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c14c0d-d4d9-431a-0ec2-08d67b85418f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 07:35:55.6747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1751
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTYuMDEuMTkgdW0gMDE6MzMgc2NocmllYiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0Og0KPiBP
biBUdWUsIDIwMTktMDEtMTUgYXQgMjI6MzEgKzExMDAsIE1pY2hhZWwgRWxsZXJtYW4gd3JvdGU6
DQo+Pj4+IEFzIGZhciBhcyBJIGtub3cgUG93ZXIgZG9lc24ndCByZWFsbHkgc3VwcG9ydHMgdW4t
Y2FjaGVkIG1lbW9yeSBhdCBhbGwsDQo+Pj4+IGV4Y2VwdCBmb3IgYSB2ZXJ5IHZlcnkgb2xkIGFu
ZCBvZGQgY29uZmlndXJhdGlvbiB3aXRoIEFHUC4NCj4+PiBIb3BlZnVsbHkgTWljaGFlbC9CZW4g
Y2FuIGVsYWJvcmF0ZSBoZXJlLCBidXQgSSB3YXMgdW5kZXIgdGhlIChwb3NzaWJseQ0KPj4+IG1p
c3Rha2VuKSBpbXByZXNzaW9uIHRoYXQgbWlzbWF0Y2hlZCBhdHRyaWJ1dGVzIGNvdWxkIGNhdXNl
IGEgbWFjaGluZS1jaGVjaw0KPj4+IG9uIFBvd2VyLg0KPj4gVGhhdCdzIHdoYXQgSSd2ZSBhbHdh
eXMgYmVlbiB0b2xkLCBidXQgSSBjYW4ndCBhY3R1YWxseSBmaW5kIHdoZXJlIGl0J3MNCj4+IGRv
Y3VtZW50ZWQsIEknbGwga2VlcCBzZWFyY2hpbmcuDQo+Pg0KPj4gQnV0IHlvdSdyZSByaWdodCB0
aGF0IG1peGluZyBjYWNoZWQgLyB1bmNhY2hlZCBpcyBub3QgcmVhbGx5IHN1cHBvcnRlZCwNCj4+
IGFuZCBwcm9iYWJseSByZXN1bHRzIGluIGEgbWFjaGluZSBjaGVjayBvciB3b3JzZS4NCj4gICAu
LiBvciB3b3JzZSA6KSBJdCBjb3VsZCBjaGVja3N0b3AuDQoNCk5vdCBzdXJlIGlmIHRoYXQgd291
bGQgYmUgc28gYmFkLCBpdCB3b3VsZCBhdCBsZWFzdCBnaXZlIHVzIGEgY2xlYXIgDQppbmRpY2F0
b3IgdGhhdCBzb21ldGhpbmcgaXMgd3JvbmcgaW5zdGVhZCBvZiBzaWxlbnRseSBjb3JydXB0aW5n
IGRhdGEuDQoNCj4gSXQncyBhbHNvIG15IHVuZGVyc3RhbmRpbmcgdGhhdCBvbiBBUk0gdjcgYW5k
IGFib3ZlLCBpdCdzIHRlY2huaWNhbGx5DQo+IGZvcmJpZGRlbiB0byBtYXAgdGhlIHNhbWUgcGh5
c2ljYWwgcGFnZSB3aXRoIGJvdGggY2FjaGVkIGFuZCBub24tY2FjaGVkDQo+IG1hcHBpbmdzLCBz
aW5jZSB0aGUgY2FjaGVkIG9uZSBjb3VsZCBwcmVmZXRjaCAob3Igc3BlY3VsYXRpdmVseSBsb2Fk
KSwNCj4gdGh1cyBjcmVhdGluZyBjb2xsaXNpb25zIGFuZCBpbmNvbnNpc3RlbmNpZXMuIEFtIEkg
d3JvbmcgaGVyZSA/DQoNCk5vLCBidXQgeW91IGFuc3dlciB0aGUgd3JvbmcgcXVlc3Rpb24uDQoN
ClNlZSB3ZSBkb24ndCB3YW50IHRvIGhhdmUgZGlmZmVyZW50IG1hcHBpbmdzIG9mIGNhY2hlZCBh
bmQgbm9uLWNhY2hlZCBvbiANCnRoZSBDUFUsIGJ1dCByYXRoZXIgd2FudCB0byBrbm93IGlmIGEg
c25vb3BlZCBETUEgZnJvbSB0aGUgUENJZSBjb3VudHMgDQphcyBjYWNoZWQgYWNjZXNzIGFzIHdl
bGwuDQoNCkFzIGZhciBhcyBJIGtub3cgb24geDg2IGl0IGRvZXNuJ3QsIHNvIHdoZW4geW91IGhh
dmUgYW4gdW4tY2FjaGVkIHBhZ2UgDQp5b3UgY2FuIHN0aWxsIGFjY2VzcyBpdCB3aXRoIGEgc25v
b3BpbmcgRE1BIHJlYWQvd3JpdGUgb3BlcmF0aW9uIGFuZCANCmRvbid0IGNhdXNlIHRyb3VibGUu
DQoNCj4gVGhlIG9sZCBoYWNrIG9mIHVzaW5nIG5vbi1jYWNoZWQgbWFwcGluZyB0byBhdm9pZCBz
bm9vcCBjb3N0IGluIEFHUCBhbmQNCj4gb3RoZXJzIGlzIGp1c3QgdGhhdCAuLi4gYW4gdWdseSBh
bmQgaG9ycmlibGUgaGFja3MgdGhhdCBzaG91bGQgaGF2ZQ0KPiBuZXZlciBldmVudHVhdGVkLCB3
aGVuIHRoZSBzZWFyY2ggZm9yIHBlcmZvcm1hbmNlIHB1c2hlcyBIVyBwZW9wbGUgaW50bw0KPiB1
dHRlciBpbnNhbml0eSA6KQ0KDQpXZWxsIEkgYWdyZWUgdGhhdCB1bi1jYWNoZWQgc3lzdGVtIG1l
bW9yeSBtYWtlcyB0aGluZ3MgbXVjaCBtb3JlIA0KY29tcGxpY2F0ZWQgZm9yIGEgcXVlc3Rpb25h
YmxlIGdhaW4uDQoNCkJ1dCBmYWN0IGlzIHdlIG5vdyBoYXZlIHRvIGRlYWwgd2l0aCB0aGUgbWVz
cywgc28gbm8gcG9pbnQgaW4gDQpjb21wbGFpbmluZyBhYm91dCBpdCB0byBtdWNoIDopDQoNCkNo
ZWVycywNCkNocmlzdGlhbi4NCg0KPg0KPiBDaGVlcnMsDQo+IEJlbi4NCj4NCj4NCj4NCg0K

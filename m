Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155B2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AE520651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GzUv+X01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfANTVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:21:12 -0500
Received: from mail-eopbgr740075.outbound.protection.outlook.com ([40.107.74.75]:45591
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbfANTVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50t7m6tlXiQ8OasY1KpdEa6t4TyMuFrjMCV3hR2pUjk=;
 b=GzUv+X01bjzhV1qgOt5e4zuNde3Ax7Y+6KOazDbKyvGFn4eqUykG2spZGjkwR40hPkYDVhN/EjorkFbrF7lJEnA6/+vn3Xz0ZfiYFQ1w+86BYxGH1zDKSHFhWcP9dOw1AatZZ8dFVQabPIeoRa+laRoo5ZsKDzBLbOe/clqgfgQ=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1828.namprd12.prod.outlook.com (10.175.102.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.19; Mon, 14 Jan 2019 19:21:08 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::1c01:3bbc:5ef1:4090]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::1c01:3bbc:5ef1:4090%11]) with mapi id 15.20.1516.019; Mon, 14 Jan
 2019 19:21:08 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Will Deacon <will.deacon@arm.com>
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
Thread-Index: AQHUqLYqeBA87jEBLUOvwyi3in13KaWoPfAAgAZfVICAAAyHgIAAYvAAgAAasQCAAAG3AIAAAgEA
Date:   Mon, 14 Jan 2019 19:21:08 +0000
Message-ID: <a6d9d0ad-d1c0-9e60-17c6-a42f7bde258c@amd.com>
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
 <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
 <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
 <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com>
 <CAKv+Gu_JyO2KNtdN1-_TcoL_kqs0yswdwBrpAXA6-jyWuDrj+g@mail.gmail.com>
 <9f956898-7973-98ee-6bf1-e1d445e9d365@amd.com>
 <20190114191350.GA29600@fuggles.cambridge.arm.com>
In-Reply-To: <20190114191350.GA29600@fuggles.cambridge.arm.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM5PR04CA0031.eurprd04.prod.outlook.com
 (2603:10a6:206:1::44) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1828;20:n+EGYNSi/hzTgA+NK7om5IliMCKjJ5ncpOMXEk+UxqR7jrQv45KTZT5yDyK/H8sQMA9lOaxGdOBnfnOwmlox9GkSg+jxF6V7BBIlZX7vW0aP6XqpGE/0ixiYp2aMRKWqJxAbqTSnni4gF/NnzBPkLvTa7GhrH7AFaIW6xon/ea0mkXMsCaXydPi8/SsXl3/WWkHMyTVdxHxWCN3Q7uzEd4zq+B0PnHb16XRcOn22T+B9XA7kcGY7lW4h+T6S9UcQ
x-ms-office365-filtering-correlation-id: f02f0da5-87a6-4d7f-a633-08d67a556f88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1828;
x-ms-traffictypediagnostic: BN6PR12MB1828:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-microsoft-antispam-prvs: <BN6PR12MB18289421122348CCFB2FAC0D83800@BN6PR12MB1828.namprd12.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(43544003)(199004)(189003)(551934003)(99286004)(72206003)(256004)(478600001)(31696002)(86362001)(71200400001)(71190400001)(2616005)(386003)(229853002)(6436002)(102836004)(6506007)(65806001)(6486002)(186003)(476003)(97736004)(46003)(486006)(93886005)(11346002)(76176011)(52116002)(65956001)(446003)(64126003)(25786009)(6512007)(53936002)(6246003)(14454004)(8676002)(4326008)(54906003)(6916009)(105586002)(81156014)(81166006)(58126008)(106356001)(305945005)(31686004)(68736007)(5660300001)(316002)(8936002)(7736002)(6116002)(65826007)(2906002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1828;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S96glF9ERGVvJiXts7N06eFPPtEChEsbGTpXvNI5JSmMkLWAgUGEP713U+KcStJTtlEo20tcdQPHjNn+tPOZye9XogDJYNpr8z2rlrUsZ1XcLm8KPYB815tNnh59OzOIoU8m06QCMzRVCajqzAej9btVmRbcxezkYy7zjRg+Ss3uE8e65WiywhfQsQdExgJjoN5nmdVA3K8IuDcaJvUDkZClBLUzvDyUtGRK8VhL0MHWsxwsO0h3Qpy50f8iFo3x0av3GiHzz+h5uYkcrMJ1U0rnZ9UDc13qjD7TEcUIQKEb+NtujRY5ILZsHILaVwA6T3ar5ZfhiTk1ciI9APU+WSoX4d9r3tCvBHbEp+LLAEz7RCspXhEA4DAsPhyrbfU74qxboLz9wsf4fwG4o7APetvIZqf7H9u7lbLi79jI7UE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E528CC0473A908438E9FB0E453C856E2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f02f0da5-87a6-4d7f-a633-08d67a556f88
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 19:21:08.4461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1828
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTQuMDEuMTkgdW0gMjA6MTMgc2NocmllYiBXaWxsIERlYWNvbjoNCj4gT24gTW9uLCBKYW4g
MTQsIDIwMTkgYXQgMDc6MDc6NTRQTSArMDAwMCwgS29lbmlnLCBDaHJpc3RpYW4gd3JvdGU6DQo+
PiBBbSAxNC4wMS4xOSB1bSAxODozMiBzY2hyaWViIEFyZCBCaWVzaGV1dmVsOg0KPj4gICAgICAg
ICAgICAgIC0gVGhlIHJlYXNvbiByZW1hcHBpbmcgdGhlIENQVSBzaWRlIGFzIGNhY2hlYWJsZSBk
b2VzIHdvcmsgKHdoaWNoIEkNCj4+ICAgICAgICAgICAgICBkaWQgdGVzdCkgaXMgYmVjYXVzZSB0
aGUgR1BVJ3MgdW5jYWNoZWFibGUgYWNjZXNzZXMgKHdoaWNoIEkgYXNzdW1lDQo+PiAgICAgICAg
ICAgICAgYXJlIG1hZGUgdXNpbmcgdGhlIE5vU25vb3AgUENJZSB0cmFuc2FjdGlvbiBhdHRyaWJ1
dGUpIGFyZSBhY3R1YWxseQ0KPj4gICAgICAgICAgICAgIGVtaXR0ZWQgYXMgY2FjaGVhYmxlIGlu
IHNvbWUgY2FzZXMuDQo+PiAgICAgICAgICAgICAgICAgLiBPbiBteSBBTUQgU2VhdHRsZSwgd2l0
aCBvciB3aXRob3V0IFNNTVUgKHdoaWNoIGlzIHN0YWdlIDIgb25seSksIEkNCj4+ICAgICAgICAg
ICAgICBtdXN0IHVzZSBjYWNoZWFibGUgYWNjZXNzZXMgZnJvbSB0aGUgQ1BVIHNpZGUgb3IgdGhp
bmdzIGFyZSBicm9rZW4uDQo+PiAgICAgICAgICAgICAgVGhpcyBtaWdodCBiZSBhIGgvdyBmbGF3
LCB0aG91Z2guDQo+PiAgICAgICAgICAgICAgICAgLiBPbiBzeXN0ZW1zIHdpdGggc3RhZ2UgMSsy
IFNNTVVzLCB0aGUgZHJpdmVyIHVzZXMgc3RhZ2UgMQ0KPj4gICAgICAgICAgICAgIHRyYW5zbGF0
aW9ucyB3aGljaCBhbHdheXMgb3ZlcnJpZGUgdGhlIG1lbW9yeSBhdHRyaWJ1dGVzIHRvIGNhY2hl
YWJsZQ0KPj4gICAgICAgICAgICAgIGZvciBETUEgY29oZXJlbnQgZGV2aWNlcy4gVGhpcyBpcyB3
aGF0IGlzIGFmZmVjdGluZyB0aGUgQ2F2aXVtDQo+PiAgICAgICAgICAgICAgVGh1bmRlclgyIChh
bHRob3VnaCBpdCBhcHBlYXJzIHRoZSBhdHRyaWJ1dGVzIGVtaXR0ZWQgYnkgdGhlIFJDIG1heSBi
ZQ0KPj4gICAgICAgICAgICAgIGluY29ycmVjdCBhcyB3ZWxsLikNCj4+DQo+PiAgICAgICAgICAg
ICAgVGhlIGxhdHRlciBpc3N1ZSBpcyBhIHNob3J0Y29taW5nIGluIHRoZSBTTU1VIGRyaXZlciB0
aGF0IHdlIGhhdmUgdG8NCj4+ICAgICAgICAgICAgICBmaXgsIGkuZS4sIGl0IHNob3VsZCB0YWtl
IGNhcmUgbm90IHRvIG1vZGlmeSB0aGUgaW5jb21pbmcgYXR0cmlidXRlcw0KPj4gICAgICAgICAg
ICAgIG9mIERNQSBjb2hlcmVudCBQQ0llIGRldmljZXMgZm9yIE5vU25vb3AgdG8gYmUgYWJsZSB0
byB3b3JrLg0KPj4NCj4+ICAgICAgICAgICAgICBTbyBpbiBzdW1tYXJ5LCB0aGUgbWlzbWF0Y2gg
YXBwZWFycyB0byBiZSBiZXR3ZWVuIHRoZSBDUFUgYWNjZXNzaW5nDQo+PiAgICAgICAgICAgICAg
dGhlIHZtYXAgcmVnaW9uIHdpdGggbm9uLWNhY2hlYWJsZSBhdHRyaWJ1dGVzIGFuZCB0aGUgR1BV
IGFjY2Vzc2luZw0KPj4gICAgICAgICAgICAgIHRoZSBzYW1lIG1lbW9yeSB3aXRoIGNhY2hlYWJs
ZSBhdHRyaWJ1dGVzLCByZXN1bHRpbmcgaW4gYSBsb3NzIG9mDQo+PiAgICAgICAgICAgICAgY29o
ZXJlbmN5IGFuZCBsb3RzIG9mIHZpc2libGUgY29ycnVwdGlvbi4NCj4+DQo+PiAgICAgICAgICBB
Y3R1YWxseSBpdCBpcyB0aGUgb3RoZXIgd2F5IGFyb3VuZC4gVGhlIENQVSB0aGlua3Mgc29tZSBk
YXRhIGlzIGluIHRoZQ0KPj4gICAgICAgICAgY2FjaGUgYW5kIHRoZSBHUFUgb25seSB1cGRhdGVz
IHRoZSBzeXN0ZW0gbWVtb3J5IHZlcnNpb24gYmVjYXVzZSB0aGUNCj4+ICAgICAgICAgIHNub29w
IGZsYWcgaXMgbm90IHNldC4NCj4+DQo+Pg0KPj4gICAgICBUaGF0IGRvZXNuJ3Qgc2VlbSB0byBi
ZSB3aGF0IGlzIGhhcHBlbmluZy4gQXMgZmFyIGFzIHdlIGNhbiB0ZWxsIGZyb20NCj4+ICAgICAg
b3VyIGV4cGVyaW1lbnRzLCBhbGwgaW5ib3VuZCB0cmFuc2FjdGlvbnMgYXJlIGFsd2F5cyBjYWNo
ZWFibGUsIGFuZCBzbw0KPj4gICAgICB0aGUgb25seSB3YXkgdG8gbWFrZSB0aGluZ3Mgd29yayBp
cyB0byBlbnN1cmUgdGhhdCB0aGUgQ1BVIHVzZXMgdGhlDQo+PiAgICAgIHNhbWUgYXR0cmlidXRl
cy4NCj4+DQo+Pg0KPj4gT2sgdGhhdCBkb2Vzbid0IG1ha2UgYW55IHNlbnNlLiBJZiBpbmJvdW5k
IHRyYW5zYWN0aW9ucyBhcmUgY2FjaGVhYmxlIG9yIG5vdCBpcw0KPj4gaXJyZWxldmFudCB3aGVu
IHRoZSBDUFUgYWx3YXlzIHVzZXMgdW5jYWNoZWQgYWNjZXNzZXMuDQo+Pg0KPj4gU2VlIG9uIHRo
ZSBQQ0llIHNpZGUgeW91IGhhdmUgdGhlIHNub29wIGJpdCBpbiB0aGUgcmVhZC93cml0ZSB0cmFu
c2FjdGlvbnMNCj4+IHdoaWNoIHRlbGxzIHRoZSByb290IGh1YiBpZiB0aGUgZGV2aWNlIHdhbnRz
IHRvIHNub29wIGNhY2hlcyBvciBub3QuDQo+Pg0KPj4gV2hlbiB0aGUgQ1BVIGFjY2Vzc2VzIHNv
bWUgbWVtb3J5IGFzIGNhY2hlZCB0aGVuIGRldmljZXMgbmVlZCB0byBzbm9vcCB0aGUNCj4+IGNh
Y2hlIGZvciBjb2hlcmVudCBhY2Nlc3Nlcy4NCj4+DQo+PiBXaGVuIHRoZSBDUFUgYWNjZXNzZXMg
c29tZSBtZW1vcnkgYXMgdW5jYWNoZWQgdGhlbiBkZXZpY2VzIGNhbiBkaXNhYmxlIHNub29waW5n
DQo+PiB0byBpbXByb3ZlIHBlcmZvcm1hbmNlLCBidXQgd2hlbiB0aGV5IGRvbid0IGRvIHRoaXMg
aXQgaXMgbWFuZGF0ZWQgYnkgdGhlIHNwZWMNCj4+IHRoYXQgdGhpcyBzdGlsbCB3b3Jrcy4NCj4g
V2hpY2ggc3BlYz8NCg0KVGhlIFBDSWUgc3BlYy4gVGhlIHNub29wIGJpdCAob3IgcmF0aGVyIHRo
ZSBOb1Nub29wKSBpbiB0aGUgdHJhbnNhY3Rpb24gDQppcyBwZXJmZWN0bHkgb3B0aW9uYWwgSUlS
Qy4NCg0KPiBUaGUgQXJtIGFyY2hpdGVjdHVyZSAoYW5kIG90aGVycyBpbmNsdWRpbmcgUG93ZXIg
YWZhaXUpIGRvZXNuJ3QNCj4gZ3VhcmFudGVlIGNvaGVyZW5jeSB3aGVuIG1lbW9yeSBpcyBhY2Nl
c3NlZCB1c2luZyBtaXNtYXRjaGVkIGNhY2hlYWJpbGl0eQ0KPiBhdHRyaWJ1dGVzLg0KDQpXZWxs
IHdoYXQgZXhhY3RseSBnb2VzIHdyb25nIG9uIEFSTT8NCg0KQXMgZmFyIGFzIEkga25vdyBQb3dl
ciBkb2Vzbid0IHJlYWxseSBzdXBwb3J0cyB1bi1jYWNoZWQgbWVtb3J5IGF0IGFsbCwgDQpleGNl
cHQgZm9yIGEgdmVyeSB2ZXJ5IG9sZCBhbmQgb2RkIGNvbmZpZ3VyYXRpb24gd2l0aCBBR1AuDQoN
CkkgbWVhbiBpbiB0aGVvcnkgSSBhZ3JlZSB0aGF0IGRldmljZXMgc2hvdWxkIHVzZSBtYXRjaGlu
ZyBjYWNoZWFiaWxpdHkgDQphdHRyaWJ1dGVzLCBidXQgaW4gcHJhY3RpY2UgSSBrbm93IG9mIHF1
aXRlIGEgYnVuY2ggb2YgZGV2aWNlcy9lbmdpbmVzIA0Kd2hpY2ggZmFpbHMgdG8gZG8gdGhpcyBj
b3JyZWN0bHkuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gV2lsbA0KDQo=

Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B822C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75442063F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ENxOGaT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfANLlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:41:10 -0500
Received: from mail-eopbgr680075.outbound.protection.outlook.com ([40.107.68.75]:52096
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726552AbfANLlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx5cOsnjMqUFZJUy02tVepPueAxyzb6EXMdLKp2hFU0=;
 b=ENxOGaT4QGdTFCUviruD9g+XTix9HhcIja0epe6xdTamqww6ff3Oo3resNkfENh2KN68KoQE110K2Ym7fAB1bYVj8W5DC0T6Gaj3YKIUSMTptSsEiJsJHlRBzeKjlwYjO+VH97Z6RAjSH7XYw+uvcUA4J06TaQAz2wf+NDaNMcU=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1857.namprd12.prod.outlook.com (10.175.96.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Mon, 14 Jan 2019 11:38:09 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::1c01:3bbc:5ef1:4090]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::1c01:3bbc:5ef1:4090%11]) with mapi id 15.20.1516.019; Mon, 14 Jan
 2019 11:38:09 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Carsten Haitzler <Carsten.Haitzler@arm.com>,
        David Airlie <airlied@linux.ie>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?QmVybmhhcmQgUm9zZW5rcsOkbnplcg==?= 
        <Bernhard.Rosenkranzer@linaro.org>
Subject: Re: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Thread-Topic: [RFC PATCH] drm/ttm: force cached mappings for system RAM on ARM
Thread-Index: AQHUqLYqeBA87jEBLUOvwyi3in13KaWoPfAAgAZfVICAAAyHgA==
Date:   Mon, 14 Jan 2019 11:38:09 +0000
Message-ID: <55facfb9-92af-86b8-40e9-d63b887b5592@amd.com>
References: <20190110072841.3283-1-ard.biesheuvel@linaro.org>
 <5d8135de-80fe-9c0e-2206-ecb809f64cdb@daenzer.net>
 <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
In-Reply-To: <CAKv+Gu_X-DH6GZ0k8RYuL18rxTwBpb5=Qp9VCZfn_kh+9b3Zkg@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6P191CA0092.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::33) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1857;20:fQ7v0Kh+a+mT/qLoonYIvLbNSIUN5ukAvWOpDJRbNMYHmBstrcciHy2pvhOaOLXx4BdHTsSW8jqg6ePbiA2+uoz2gFxz4eqd0i+p6mNXaEr1gEK6QI0IQIHJzOSfV5Jy/MwGzMJnPd4RdY/AicTfqWzrgenDvxnwzhVcoEe7+ou0WDy2jxLxySQoFrdJW7ut4KL/zHPy4mShtAc/e911sgyc6u6p9kUeaOhEYpR1kT+GQx87kLsx7weao0BxYdJF
x-ms-office365-filtering-correlation-id: fdacbead-24bb-44f1-f59a-08d67a14c1dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1857;
x-ms-traffictypediagnostic: BN6PR12MB1857:
x-microsoft-antispam-prvs: <BN6PR12MB185717C077B9CA6C672302EF83800@BN6PR12MB1857.namprd12.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(39860400002)(376002)(136003)(199004)(189003)(43544003)(53546011)(386003)(478600001)(476003)(2616005)(446003)(46003)(11346002)(6116002)(486006)(52116002)(186003)(6506007)(102836004)(68736007)(76176011)(65806001)(81166006)(81156014)(256004)(229853002)(65956001)(6486002)(305945005)(8936002)(8676002)(7736002)(6436002)(551934003)(14444005)(36756003)(31686004)(99286004)(105586002)(106356001)(31696002)(86362001)(316002)(58126008)(97736004)(64126003)(110136005)(54906003)(72206003)(14454004)(66574012)(71190400001)(71200400001)(65826007)(5660300001)(6512007)(2906002)(4326008)(53936002)(6246003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1857;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oky0vH4DypzJfNh6SZVcvTpPd1L55fCmZT+zAsz913S0OIxEOQPMlz4ItnZMOuHX5ErgqvbmlOIgYVRWuaEOcPmg0TEWyvgsjQ4iLBaWJf2gQUq7pQTLddRRsNkq9omQ1+Hh2pOWwB0pZw8iBPbojfyoFTpwLQTGv9UhtTXjucd5ByH5wZWSa4z8f650qgsr5EVshTftoi9v2LM4gsotDeuqQzKnxuc8jjpAj1ApvYIVBDADudCvrNiEFDnus2wljVL/QT6aJMOBm/U5O9m92KbkxHlDEWNG9JLkzgqTOPv0Wm3dzg3NAuYJDPwnhXq7U+1VKzC3ERObFArEWcgaQeJC0t2Lva22jOmTjHWeHtKKXHGeV1SYcRmNtnFtMHBS2qef6cE3YhEOVVnstZvRXQoPEHkOV3uGCffROvZKACo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <29C3E6E1755C8146B404BF7ACA6F61DE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdacbead-24bb-44f1-f59a-08d67a14c1dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 11:38:09.3755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1857
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTQuMDEuMTkgdW0gMTE6NTMgc2NocmllYiBBcmQgQmllc2hldXZlbDoNCj4gT24gVGh1LCAx
MCBKYW4gMjAxOSBhdCAxMDozNCwgTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4g
d3JvdGU6DQo+PiBPbiAyMDE5LTAxLTEwIDg6MjggYS5tLiwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6
DQo+Pj4gQVJNIHN5c3RlbXMgZG8gbm90IHBlcm1pdCB0aGUgdXNlIG9mIGFueXRoaW5nIG90aGVy
IHRoYW4gY2FjaGVkDQo+Pj4gbWFwcGluZ3MgZm9yIHN5c3RlbSBtZW1vcnksIHNpbmNlIHRoYXQg
bWVtb3J5IG1heSBiZSBtYXBwZWQgaW4gdGhlDQo+Pj4gbGluZWFyIHJlZ2lvbiBhcyB3ZWxsLCBh
bmQgdGhlIGFyY2hpdGVjdHVyZSBkb2VzIG5vdCBwZXJtaXQgYWxpYXNlcw0KPj4+IHdpdGggbWlz
bWF0Y2hlZCBhdHRyaWJ1dGVzLg0KPj4+DQo+Pj4gU28gc2hvcnQtY2lyY3VpdCB0aGUgZXZhbHVh
dGlvbiBpbiB0dG1faW9fcHJvdCgpIGlmIHRoZSBmbGFncyBpbmNsdWRlDQo+Pj4gVFRNX1BMX1NZ
U1RFTSB3aGVuIHJ1bm5pbmcgb24gQVJNIG9yIGFybTY0LCBhbmQganVzdCByZXR1cm4gY2FjaGVk
DQo+Pj4gYXR0cmlidXRlcyBpbW1lZGlhdGVseS4NCj4+Pg0KPj4+IFRoaXMgZml4ZXMgdGhlIHJh
ZGVvbiBhbmQgYW1kZ3B1IFtUQkNdIGRyaXZlcnMgd2hlbiBydW5uaW5nIG9uIGFybTY0Lg0KPj4+
IFdpdGhvdXQgdGhpcyBjaGFuZ2UsIGFtZGdwdSBkb2VzIG5vdCBzdGFydCBhdCBhbGwsIGFuZCBy
YWRlb24gb25seQ0KPj4+IHByb2R1Y2VzIGNvcnJ1cHQgZGlzcGxheSBvdXRwdXQuDQo+Pj4NCj4+
PiBDYzogQ2hyaXN0aWFuIEtvZW5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPj4+IENj
OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPg0KPj4+IENjOiBKdW53ZWkgWmhhbmcgPEpl
cnJ5LlpoYW5nQGFtZC5jb20+DQo+Pj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5p
ZT4NCj4+PiBSZXBvcnRlZC1ieTogQ2Fyc3RlbiBIYWl0emxlciA8Q2Fyc3Rlbi5IYWl0emxlckBh
cm0uY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IEFyZCBCaWVzaGV1dmVsIDxhcmQuYmllc2hldXZl
bEBsaW5hcm8ub3JnPg0KPj4+IC0tLQ0KPj4+ICAgZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9f
dXRpbC5jIHwgNSArKysrKw0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0K
Pj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYyBi
L2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYw0KPj4+IGluZGV4IDA0NmE2ZGRhNjkw
YS4uMGMxZWVmNWY3YWUzIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRt
X2JvX3V0aWwuYw0KPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYw0K
Pj4+IEBAIC01MzAsNiArNTMwLDExIEBAIHBncHJvdF90IHR0bV9pb19wcm90KHVpbnQzMl90IGNh
Y2hpbmdfZmxhZ3MsIHBncHJvdF90IHRtcCkNCj4+PiAgICAgICAgaWYgKGNhY2hpbmdfZmxhZ3Mg
JiBUVE1fUExfRkxBR19DQUNIRUQpDQo+Pj4gICAgICAgICAgICAgICAgcmV0dXJuIHRtcDsNCj4+
Pg0KPj4+ICsjaWYgZGVmaW5lZChfX2FybV9fKSB8fCBkZWZpbmVkKF9fYWFyY2g2NF9fKQ0KPj4+
ICsgICAgIC8qIEFSTSBvbmx5IHBlcm1pdHMgY2FjaGVkIG1hcHBpbmdzIG9mIHN5c3RlbSBtZW1v
cnkgKi8NCj4+PiArICAgICBpZiAoY2FjaGluZ19mbGFncyAmIFRUTV9QTF9TWVNURU0pDQo+Pj4g
KyAgICAgICAgICAgICByZXR1cm4gdG1wOw0KPj4+ICsjZW5kaWYNCj4+PiAgICNpZiBkZWZpbmVk
KF9faTM4Nl9fKSB8fCBkZWZpbmVkKF9feDg2XzY0X18pDQo+Pj4gICAgICAgIGlmIChjYWNoaW5n
X2ZsYWdzICYgVFRNX1BMX0ZMQUdfV0MpDQo+Pj4gICAgICAgICAgICAgICAgdG1wID0gcGdwcm90
X3dyaXRlY29tYmluZSh0bXApOw0KPj4+DQo+PiBBcGFydCBmcm9tIENocmlzdGlhbidzIGNvbmNl
cm5zLCBJIHRoaW5rIHRoaXMgaXMgdGhlIHdyb25nIHBsYWNlIGZvcg0KPj4gdGhpcywgYmVjYXVz
ZSBvdGhlciBUVE0gLyBkcml2ZXIgY29kZSB3aWxsIHN0aWxsIGNvbnNpZGVyIHRoZSBtZW1vcnkN
Cj4+IHVuY2FjaGVhYmxlLiBFLmcuIHRoZSBhbWRncHUgZHJpdmVyIHdpbGwgcHJvZ3JhbSB0aGUg
R1BVIHRvIHRyZWF0IHRoZQ0KPj4gbWVtb3J5IGFzIHVuY2FjaGVhYmxlLCBzbyBpdCB3b24ndCBw
YXJ0aWNpcGF0ZSBpbiBjYWNoZSBjb2hlcmVuY3kNCj4+IHByb3RvY29sIGZvciBpdCwgd2hpY2gg
aXMgdW5saWtlbHkgdG8gd29yayBhcyBleHBlY3RlZCBpbiBnZW5lcmFsIGlmIHRoZQ0KPj4gQ1BV
IHRyZWF0cyB0aGUgbWVtb3J5IGFzIGNhY2hlYWJsZS4NCj4+DQo+IFdpbGwgYW5kIEkgaGF2ZSBz
cGVudCBzb21lIHRpbWUgZGlnZ2luZyBpbnRvIHRoaXMsIHNvIGFsbG93IG1lIHRvDQo+IHNoYXJl
IHNvbWUgcHJlbGltaW5hcnkgZmluZGluZ3Mgd2hpbGUgd2UgY2Fycnkgb24gYW5kIHRyeSB0byBm
aXggdGhpcw0KPiBwcm9wZXJseS4NCj4NCj4gLSBUaGUgcGF0Y2ggYWJvdmUgaXMgZmxhd2VkLCBp
LmUuLCBpdCBkb2Vzbid0IGRvIHdoYXQgaXQgaW50ZW5kcyB0bw0KPiBzaW5jZSBpdCB1c2VzIFRU
TV9QTF9TWVNURU0gaW5zdGVhZCBvZiBUVE1fUExfRkxBR19TWVNURU0uIEFwb2xvZ2llcw0KPiBm
b3IgdGhhdC4NCj4gLSBUaGUgZXhpc3RlbmNlIG9mIGEgbGluZWFyIHJlZ2lvbiBtYXBwaW5nIHdp
dGggbWlzbWF0Y2hlZCBhdHRyaWJ1dGVzDQo+IGlzIGxpa2VseSBub3QgdGhlIGN1bHByaXQgaGVy
ZS4gKFdlIGRvIHNvbWV0aGluZyBzaW1pbGFyIHdpdGgNCj4gbm9uLWNhY2hlIGNvaGVyZW50IERN
QSBpbiBvdGhlciBwbGFjZXMpLg0KDQpUaGlzIGlzIHN0aWxsIHJhdGhlciBwcm9ibGVtYXRpYy4N
Cg0KVGhlIGlzc3VlIGlzIHRoYXQgd2Ugb2Z0ZW4gZG9uJ3QgY3JlYXRlIGEgdm1hcCBmb3IgYSBw
YWdlLCBidXQgcmF0aGVyIA0KYWNjZXNzIHRoZSBwYWdlIGRpcmVjdGx5IHVzaW5nIHRoZSBsaW5l
YXIgbWFwcGluZy4NCg0KU28gd2Ugd291bGQgdXNlIHRoZSB3cm9uZyBhY2Nlc3MgdHlwZSBoZXJl
Lg0KDQo+IC0gVGhlIHJlYXNvbiByZW1hcHBpbmcgdGhlIENQVSBzaWRlIGFzIGNhY2hlYWJsZSBk
b2VzIHdvcmsgKHdoaWNoIEkNCj4gZGlkIHRlc3QpIGlzIGJlY2F1c2UgdGhlIEdQVSdzIHVuY2Fj
aGVhYmxlIGFjY2Vzc2VzICh3aGljaCBJIGFzc3VtZQ0KPiBhcmUgbWFkZSB1c2luZyB0aGUgTm9T
bm9vcCBQQ0llIHRyYW5zYWN0aW9uIGF0dHJpYnV0ZSkgYXJlIGFjdHVhbGx5DQo+IGVtaXR0ZWQg
YXMgY2FjaGVhYmxlIGluIHNvbWUgY2FzZXMuDQo+ICAgIC4gT24gbXkgQU1EIFNlYXR0bGUsIHdp
dGggb3Igd2l0aG91dCBTTU1VICh3aGljaCBpcyBzdGFnZSAyIG9ubHkpLCBJDQo+IG11c3QgdXNl
IGNhY2hlYWJsZSBhY2Nlc3NlcyBmcm9tIHRoZSBDUFUgc2lkZSBvciB0aGluZ3MgYXJlIGJyb2tl
bi4NCj4gVGhpcyBtaWdodCBiZSBhIGgvdyBmbGF3LCB0aG91Z2guDQo+ICAgIC4gT24gc3lzdGVt
cyB3aXRoIHN0YWdlIDErMiBTTU1VcywgdGhlIGRyaXZlciB1c2VzIHN0YWdlIDENCj4gdHJhbnNs
YXRpb25zIHdoaWNoIGFsd2F5cyBvdmVycmlkZSB0aGUgbWVtb3J5IGF0dHJpYnV0ZXMgdG8gY2Fj
aGVhYmxlDQo+IGZvciBETUEgY29oZXJlbnQgZGV2aWNlcy4gVGhpcyBpcyB3aGF0IGlzIGFmZmVj
dGluZyB0aGUgQ2F2aXVtDQo+IFRodW5kZXJYMiAoYWx0aG91Z2ggaXQgYXBwZWFycyB0aGUgYXR0
cmlidXRlcyBlbWl0dGVkIGJ5IHRoZSBSQyBtYXkgYmUNCj4gaW5jb3JyZWN0IGFzIHdlbGwuKQ0K
Pg0KPiBUaGUgbGF0dGVyIGlzc3VlIGlzIGEgc2hvcnRjb21pbmcgaW4gdGhlIFNNTVUgZHJpdmVy
IHRoYXQgd2UgaGF2ZSB0bw0KPiBmaXgsIGkuZS4sIGl0IHNob3VsZCB0YWtlIGNhcmUgbm90IHRv
IG1vZGlmeSB0aGUgaW5jb21pbmcgYXR0cmlidXRlcw0KPiBvZiBETUEgY29oZXJlbnQgUENJZSBk
ZXZpY2VzIGZvciBOb1Nub29wIHRvIGJlIGFibGUgdG8gd29yay4NCj4NCj4gU28gaW4gc3VtbWFy
eSwgdGhlIG1pc21hdGNoIGFwcGVhcnMgdG8gYmUgYmV0d2VlbiB0aGUgQ1BVIGFjY2Vzc2luZw0K
PiB0aGUgdm1hcCByZWdpb24gd2l0aCBub24tY2FjaGVhYmxlIGF0dHJpYnV0ZXMgYW5kIHRoZSBH
UFUgYWNjZXNzaW5nDQo+IHRoZSBzYW1lIG1lbW9yeSB3aXRoIGNhY2hlYWJsZSBhdHRyaWJ1dGVz
LCByZXN1bHRpbmcgaW4gYSBsb3NzIG9mDQo+IGNvaGVyZW5jeSBhbmQgbG90cyBvZiB2aXNpYmxl
IGNvcnJ1cHRpb24uDQoNCkFjdHVhbGx5IGl0IGlzIHRoZSBvdGhlciB3YXkgYXJvdW5kLiBUaGUg
Q1BVIHRoaW5rcyBzb21lIGRhdGEgaXMgaW4gdGhlIA0KY2FjaGUgYW5kIHRoZSBHUFUgb25seSB1
cGRhdGVzIHRoZSBzeXN0ZW0gbWVtb3J5IHZlcnNpb24gYmVjYXVzZSB0aGUgDQpzbm9vcCBmbGFn
IGlzIG5vdCBzZXQuDQoNCj4gVG8gYmUgYWJsZSB0byBkZWJ1ZyB0aGlzIGZ1cnRoZXIsIGNvdWxk
IHlvdSBlbGFib3JhdGUgYSBiaXQgb24NCj4gLSBIb3cgZG9lcyB0aGUgaGFyZHdhcmUgZW1pdCB0
aG9zZSB1bmNhY2hlZC93YyBpbmJvdW5kIGFjY2Vzc2VzPyBEbw0KPiB0aGV5IHJlbHkgb24gTm9T
bm9vcD8NCg0KVGhlIEdQVSBoYXMgYSBzZXBhcmF0ZSBwYWdlIHdhbGtlciBpbiB0aGUgTUMgYW5k
IHRoZSBwYWdlIHRhYmxlcyB0aGVyZSANCmhhdmUgYSBiaXRzIHNheWluZyBpZiB0aGUgYWNjZXNz
IHNob3VsZCBnbyB0byB0aGUgUENJZSBidXMgYW5kIGlmIHllcyBpZiANCnRoZSBzbm9vcCBiaXQg
c2hvdWxkIGJlIHNldC4NCg0KPiAtIENocmlzdGlhbiBwb2ludGVkIG91dCB0aGF0IHNvbWUgYWNj
ZXNzZXMgbXVzdCBiZSB1bmNhY2hlZCBldmVuIHdoZW4NCj4gbm90IHVzaW5nIFdDLiBXaGF0IGtp
bmQgb2YgYWNjZXNzZXMgYXJlIHRob3NlPyBBbmQgZG8gdGhleSBhY2Nlc3MNCj4gc3lzdGVtIFJB
TT8NCg0KT24gc29tZSBoYXJkd2FyZSBnZW5lcmF0aW9ucyB3ZSBoYXZlIGEgYnVnZ3kgZW5naW5l
IHdoaWNoIGZhaWxzIHRvIA0KZm9yd2FyZCB0aGUgc25vb3AgYml0IGFuZCBiZWNhdXNlIG9mIHRo
aXMgdGhlIHN5c3RlbSBtZW1vcnkgcGFnZSB1c2VkIGJ5IA0KdGhpcyBlbmdpbmUgbXVzdCBiZSB1
bmNhY2hlZC4gQnV0IHRoaXMgb25seSBhcHBsaWVzIGlmIHlvdSB1c2UgUk9DbSBpbiBhIA0Kc3Bl
Y2lmaWMgY29uZmlndXJhdGlvbi4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg==

Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91827C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532402184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HM8cQ3iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfAXJ0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:26:20 -0500
Received: from mail-eopbgr800087.outbound.protection.outlook.com ([40.107.80.87]:33223
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbfAXJ0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/UDPKzli20McYRNipqvsucEBKx+BsCxVSEDm6NSZxo=;
 b=HM8cQ3iq+mDSMBKnwEDXTCo+Q41MQQt37wqNPOUziFPRosb4492RE2RiMWT+XwDgY7+X8c0J3Bu1QSOCtxz6TjayZl1z65gE2liII09HQRe3YFxZqyFZDP6swQP68qdjkfiyHDKtE3RAeetJv2GcwiKnVDsIMym31Dm283Nd4q4=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB2453.namprd12.prod.outlook.com (52.132.141.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 24 Jan 2019 09:25:35 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::35a3:c1b4:5ad0:ec6e%10]) with mapi id 15.20.1558.016; Thu, 24 Jan
 2019 09:25:35 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Alex Deucher <alexdeucher@gmail.com>,
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
Thread-Index: AQHUsXD3UXk0MPD/dUyEFCISRS4xuqW50zEAgAAHO4CAAActAIAABFSAgAACPQCAAAIPAIAAF8kAgAABIQCAAAF0AIAABGAAgAABGQCAAAFFAIAAChyAgADjSQCAAM5NgIAAAvSAgACp8ICAAB+TAIAAf28AgAACVwCAARHuAIAAA2gA
Date:   Thu, 24 Jan 2019 09:25:35 +0000
Message-ID: <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
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
In-Reply-To: <20190124091316.GA22796@infradead.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM6PR02CA0026.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::39) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB2453;20:zyMb8abFgMnzaXjaQP9Kc2TKuvKJxqijB/XwV6X3dewWVNpSFWBwvn0SoxY40KDpn+MX+rGMHfdfIuujkpI5gyXParC3HgFnfWfhnyRLEwGahlmKSNhvwUc5LcXzzgk7zScwLILOggQR0jhBhKOCsRmIR1lXVctHMJbuoWIa38xzDT5jySluKpjKs9D03HdiGahas0ci8ql/mq1iPlhHHBnmwgkoNDmbti+Ry7HrOou3scO3gXJqlAylBQCw6P+a
x-ms-office365-filtering-correlation-id: 21aa0c3f-4bf1-46cb-7608-08d681dde540
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2453;
x-ms-traffictypediagnostic: DM5PR12MB2453:
x-microsoft-antispam-prvs: <DM5PR12MB24535115A21FB525EB5C522C839A0@DM5PR12MB2453.namprd12.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(366004)(189003)(199004)(186003)(386003)(6506007)(81166006)(8936002)(102836004)(81156014)(2906002)(52116002)(93886005)(76176011)(4326008)(6246003)(256004)(14444005)(39060400002)(25786009)(486006)(106356001)(31686004)(105586002)(53936002)(6512007)(6436002)(86362001)(6486002)(7736002)(476003)(64126003)(8676002)(2616005)(446003)(31696002)(11346002)(46003)(110136005)(54906003)(58126008)(99286004)(305945005)(316002)(478600001)(229853002)(72206003)(6116002)(65806001)(65956001)(14454004)(97736004)(71200400001)(71190400001)(7416002)(65826007)(36756003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2453;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J8HiUFXKZIjdPxPqOOqVvRa11E/WdmTGqycNKDmoUjNG4RNMeGHcNIzgxDDTsxKPpOyzBPZzrJD6XmW8at9yfdyOqlTMMp33lsBr/3VSIRCI726NaLlV54wu77PGPCquDF64fAK+AW96AAAMKKaqd+TzD+s847CGHMUHbyThlImRhxlmroSHJnUEEFIH7USpszKvYUhoUWNW4gwn/EOv7P8J/Jg2smFTDGDFkSbR9/8UOEYp6kQT26VlbpI2ohoBvYLBuZbQMYMw+bSpQUe8b+eCTyk9QOa8K3GKaF7UI3SbjNGANFvNmbsOVBRKMOO/yMY+uYW5CKQnlDGpGEstGf7MtusfyFDUZv+xqVNMrdtVnYwzTK31fRMIHq95NHM3cOAGN1EptBju2BzCvBh76QhJ/fbOMYh8gG0sp3pe4hY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF3B4EBF3CBDD3479AB379D417D317C6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21aa0c3f-4bf1-46cb-7608-08d681dde540
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 09:25:32.7644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMjQuMDEuMTkgdW0gMTA6MTMgc2NocmllYiBDaHJpc3RvcGggSGVsbHdpZzoNCj4gT24gV2Vk
LCBKYW4gMjMsIDIwMTkgYXQgMDU6NTI6NTBQTSArMDEwMCwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6
DQo+PiBCdXQgbXkgY29uY2VybiBpcyB0aGF0IGl0IHNlZW1zIGxpa2VseSB0aGF0IG5vbi1jYWNo
ZSBjb2hlcmVudA0KPj4gaW1wbGVtZW50YXRpb25zIGFyZSByZWx5aW5nIG9uIHRoaXMgaGFjayBh
cyB3ZWxsLiBUaGVyZSBtdXN0IGJlIGENCj4+IHJlYXNvbiB0aGF0IHRoaXMgaGFjayBpcyBvbmx5
IGRpc2FibGVkIGZvciBQb3dlclBDIHBsYXRmb3JtcyBpZiB0aGV5DQo+PiBhcmUgY2FjaGUgY29o
ZXJlbnQsIGZvciBpbnN0YW5jZSwgYW5kIEkgc3VzcGVjdCB0aGF0IHRoYXQgcmVhc29uIGlzDQo+
PiB0aGF0IHRoZSBoYWNrIGlzIHRoZSBvbmx5IHRoaW5nIGVuc3VyaW5nIHRoYXQgdGhlIENQVSBt
YXBwaW5nDQo+PiBhdHRyaWJ1dGVzIG1hdGNoIHRoZSBkZXZpY2Ugb25lcyB1c2VkIGZvciB0aGVz
ZSBidWZmZXJzICh0aGUgdm1hcCgpZWQNCj4+IG9uZXMpLCB3aGVyZWFzIHRoZSByaW5ncyBhbmQg
b3RoZXIgY29uc2lzdGVudCBkYXRhIHN0cnVjdHVyZXMgYXJlDQo+PiB1c2luZyB0aGUgRE1BIEFQ
SSBhcyBpbnRlbmRlZCwgYW5kIHRodXMgZ2V0dGluZyB1bmNhY2hlZCBhdHRyaWJ1dGVzIGluDQo+
PiB0aGUgY29ycmVjdCB3YXkuDQo+IERhdmUsIHdobyBhZGRlZCB0aGF0IGNvbW1pdCBpcyBvbiBD
YyB0b2dldGhlciB3aXRoIGp1c3QgYWJvdXQgZXZlcnlvbmUNCj4gaW52b2x2ZWQgaW4gdGhlIHJl
dmlldyBjaGFpbi4gIEJhc2VkIG9uIHRoZSBwcmV2aW91cyBleHBsYW5hdGlvbg0KPiB0aGF0IGlk
ZWEgd2hhdCB3ZSBtaWdodCB3YW50IGFuIHVuY2FjaGVkIG1hcHBpbmcgZm9yIHNvbWUgbm9uLWNv
aGVyZW50DQo+IGFyY2hpdGVjdHVyZXMgZm9yIHRoaXMgdG8gd29yayBhdCBhbGwgbWFrZXMgc2Vu
c2UsIGJ1dCB0aGVuIGFnYWluDQo+IHRoZSB3YXkgdG8gY3JlYXRlIHRob3NlIG1hcHBpbmdzIGlz
IGVudGlyZWx5IGFyY2hpdGVjdHVyZSBzcGVjaWZpYywNCj4gYW5kIGFsc28gbmVlZCBhIGNhY2hl
IGZsdXNoaW5nIGJlZm9yZSBjcmVhdGluZyB0aGUgbWFwcGluZyB0byB3b3JrDQo+IHByb3Blcmx5
LiAgU28gbXkgd29ya2luZyB0aGVvcnkgaXMgdGhhdCB0aGlzIGNvZGUgbmV2ZXIgcHJvcGVybHkN
Cj4gd29ya2VkIG9uIGFyY2hpdGVjdHVyZXMgd2l0aG91dCBETUEgY29oZXJlbnQgZm9yIFBDSWUg
YXQgYWxsLCBidXQNCj4gSSdkIGxvdmUgdG8gYmUgY29ycmVjdGVkIGJ5IGNvbmNyZXRlIGV4YW1w
bGVzIGluY2x1ZGluZyBhbiBleHBsYW5hdGlvbg0KPiBvZiBob3cgaXQgYWN0dWFsbHkgZW5kcyB1
cCB3b3JraW5nLg0KDQpDYWNoZSBjb2hlcmVuY3kgaXMgbWFuZGF0b3J5IGZvciBtb2Rlcm4gR1BV
IG9wZXJhdGlvbi4NCg0KT3RoZXJ3aXNlIHlvdSBjYW4ndCBpbXBsZW1lbnQgYSBidW5jaCBvZiB0
aGUgcmVxdWlyZW1lbnRzIG9mIHRoZSANCnVzZXJzcGFjZSBBUElzLg0KDQpJbiBvdGhlciB3b3Jk
cyB0aGUgYXBwbGljYXRpb25zIGRvZXNuJ3QgaW5mb3JtIHRoZSBkcml2ZXIgdGhhdCB0aGUgR1BV
IA0Kb3IgdGhlIENQVSBpcyBhY2Nlc3NpbmcgZGF0YSwgaXQganVzdCBkb2VzIGl0IGFuZCBhc3N1
bWVzIHRoYXQgaXQgd29ya3MuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQo=

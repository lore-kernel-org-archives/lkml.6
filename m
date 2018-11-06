Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D92BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E6B20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qoVa5oY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E6B20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbeKFSfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:35:16 -0500
Received: from mail-eopbgr730057.outbound.protection.outlook.com ([40.107.73.57]:24016
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729241AbeKFSfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mearDQv0Sc/Skw+j/NL8JFV4+xgSz0DEUNfHaghn+o=;
 b=qoVa5oY9eGx0rSiGnGfHbAmEhUysNwZ09jpa/PDeD52VxxzlMuRAJkUukLAoZJkVpSGFklLTPH9wX7cpiEDhHGWiwxAgwWGpPAfRhfuIpHPZn57kfgTY0YHvw/AdjdUS6106CP3P8ZYDRVYMcq4CUFN63Mojnv6EkXUFkCaSRKs=
Received: from BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11) by
 BN6PR12MB1745.namprd12.prod.outlook.com (10.175.101.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.23; Tue, 6 Nov 2018 09:10:55 +0000
Received: from BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5472:26e2:affa:2b41]) by BN6PR12MB1714.namprd12.prod.outlook.com
 ([fe80::5472:26e2:affa:2b41%7]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 09:10:55 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Eric Anholt <eric@anholt.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/syncobj: Fix oops on
 drm_syncobj_find_fence(file_priv, 0, ...).
Thread-Topic: [PATCH] drm/syncobj: Fix oops on
 drm_syncobj_find_fence(file_priv, 0, ...).
Thread-Index: AQHUdVt08xMf7hmI5E66bo6Ala5lL6VCA1cAgABzKAA=
Date:   Tue, 6 Nov 2018 09:10:55 +0000
Message-ID: <f3bff02c-9a71-77c8-d386-fdbedd4ce2f7@amd.com>
References: <20181105230110.4812-1-eric@anholt.net>
 <BY1PR12MB050299A6BA4B1967250724AAB4CB0@BY1PR12MB0502.namprd12.prod.outlook.com>
In-Reply-To: <BY1PR12MB050299A6BA4B1967250724AAB4CB0@BY1PR12MB0502.namprd12.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
x-clientproxiedby: AM6P191CA0105.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::46) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1745;20:bctzYJTtBdeKDe8z7SZ3SQwyzwhZmz4RFcEtJm71IWyeBUAPr1UaclyY4F9goDFKn2XrhL0NAHuT8GINtsAjXUUzRPv5dWIA90rXbVEWHOKSvX55qahhGJqiPlepAE8Maq1Am4Rb4SJkyToqlyk2IQ5ZdSg1fmCf4pwzA+3Ko+byJqZ0YI5oCufwN0t43AGPxzuU4F/+M0zqZn6mDTh6A6c7lVWDIS37JSkMqgVVkGlG4qqCeZRW1DJbB/I+qHS+
x-ms-office365-filtering-correlation-id: 1120b6b7-9ffd-4360-6b09-08d643c7c1cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1745;
x-ms-traffictypediagnostic: BN6PR12MB1745:
x-microsoft-antispam-prvs: <BN6PR12MB1745162351755C384141FC9C83CB0@BN6PR12MB1745.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(217544274631240)(9452136761055)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1745;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1745;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39860400002)(189003)(199004)(13464003)(7736002)(105586002)(305945005)(97736004)(11346002)(446003)(99286004)(4326008)(486006)(86362001)(31696002)(2616005)(106356001)(476003)(6436002)(6512007)(110136005)(64126003)(31686004)(2501003)(2906002)(316002)(53936002)(6246003)(58126008)(6116002)(14454004)(2900100001)(68736007)(256004)(14444005)(72206003)(81156014)(81166006)(8676002)(478600001)(186003)(6486002)(229853002)(71200400001)(71190400001)(25786009)(102836004)(5660300001)(66574009)(52116002)(76176011)(8936002)(65826007)(36756003)(65806001)(6506007)(53546011)(386003)(65956001)(46003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1745;H:BN6PR12MB1714.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: qbTjuXyPTeVNDKBuc7uc2USNbsm9fucBppmthEho4D1eHtlkiKNqi6zsM/REtlB4+sHMKiFHUdxz68rhrVbFzcz97TVlbKvHsGIw/CYwpck1NaOygSCq3j22I5oWwiGl64DoI5PGAqxR8E5aJiqKRlbla+ScGVVYus1AYG68YEGPBHGrd6jAw6K3+RZffbee1KzouRB1hyodR1PwM/obLH7RPHcFyw7vPVy/vORjUd5AiZfBx28iHXkEk6YrnnWNuGoX/H/EnIi9e4fnvKynWHbUtLK7MpwyRJwdBrdGhjIZj92Gh7eSNh4Lc9tKY7+UqazmGLYeQxIldZY+Vfp8QY/9cb31z5Ud8vMC+J8t6Pg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1067BE29B8C709489C7C4C1394301107@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1120b6b7-9ffd-4360-6b09-08d643c7c1cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 09:10:55.5846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1745
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCg0K
U2hvdWxkIEkgcHVzaCBpdCB0byBkcm0tbWlzYy1uZXh0Pw0KDQpDaHJpc3RpYW4uDQoNCkFtIDA2
LjExLjE4IHVtIDAzOjE4IHNjaHJpZWIgWmhvdSwgRGF2aWQoQ2h1bk1pbmcpOg0KPiBSZXZpZXdl
ZC1ieTogQ2h1bm1pbmcgWmhvdSA8ZGF2aWQxLnpob3VAYW1kLmNvbT4NCj4NCj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBFcmljIEFuaG9sdCA8ZXJpY0BhbmhvbHQubmV0
Pg0KPj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMDYsIDIwMTggNzowMSBBTQ0KPj4gVG86IGRy
aS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBFcmljIEFuaG9sdCA8ZXJpY0BhbmhvbHQubmV0PjsgWmhvdSwNCj4+IERhdmlk
KENodW5NaW5nKSA8RGF2aWQxLlpob3VAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuDQo+PiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPj4gU3ViamVjdDogW1BBVENIXSBkcm0vc3luY29i
ajogRml4IG9vcHMgb24NCj4+IGRybV9zeW5jb2JqX2ZpbmRfZmVuY2UoZmlsZV9wcml2LCAwLCAu
Li4pLg0KPj4NCj4+IFRoaXMgYnJva2UgcmVuZGVyaW5nIG9uIFYzRCwgd2hlcmUgd2UgYWxtb3N0
IGFsd2F5cyBoYXZlIGEgMCBpbi1zeW5jb2JqLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMg
QW5ob2x0IDxlcmljQGFuaG9sdC5uZXQ+DQo+PiBGaXhlczogNDgxOTdiYzU2NGM3ICgiZHJtOiBh
ZGQgc3luY29iaiB0aW1lbGluZSBzdXBwb3J0IHY5IikNCj4+IENjOiBDaHVubWluZyBaaG91IDxk
YXZpZDEuemhvdUBhbWQuY29tPg0KPj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2dwdS9kcm0vZHJtX3N5bmNvYmou
YyB8IDMgKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9zeW5jb2JqLmMN
Cj4+IGIvZHJpdmVycy9ncHUvZHJtL2RybV9zeW5jb2JqLmMgaW5kZXggNGRjYTVmN2U4YzRiLi5k
YTgxNzVkOWM2ZmYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX3N5bmNvYmou
Yw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9zeW5jb2JqLmMNCj4+IEBAIC00NDMsNyAr
NDQzLDggQEAgaW50IGRybV9zeW5jb2JqX2ZpbmRfZmVuY2Uoc3RydWN0IGRybV9maWxlDQo+PiAq
ZmlsZV9wcml2YXRlLA0KPj4gICAJaW50IHJldDsNCj4+DQo+PiAgIAlyZXQgPSBkcm1fc3luY29i
al9zZWFyY2hfZmVuY2Uoc3luY29iaiwgcG9pbnQsIGZsYWdzLCBmZW5jZSk7DQo+PiAtCWRybV9z
eW5jb2JqX3B1dChzeW5jb2JqKTsNCj4+ICsJaWYgKHN5bmNvYmopDQo+PiArCQlkcm1fc3luY29i
al9wdXQoc3luY29iaik7DQo+PiAgIAlyZXR1cm4gcmV0Ow0KPj4gICB9DQo+PiAgIEVYUE9SVF9T
WU1CT0woZHJtX3N5bmNvYmpfZmluZF9mZW5jZSk7DQo+PiAtLQ0KPj4gMi4xOS4xDQoNCg==

Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F20C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CDB20989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="R3u+3LQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfA2Oqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:46:55 -0500
Received: from mail-eopbgr10058.outbound.protection.outlook.com ([40.107.1.58]:29728
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbfA2Oqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzGiLVFV49KIKAG930KQHybbjLvfEiyHa33GFpqnZw0=;
 b=R3u+3LQCARSQIyzWqZMiavN1GpqufKgFgXFdahBkgMmG8Cu9tLXmKivfMM5JRqnGxygr15v3qfv5QJbW2kyAKqbAAWGGV8aVOtLMF9GjqVLD+D+9eCEoJaSFunb4jbj5/6yH65czeuiSZ62ZHTywSZ04k+g1GYwIWEmO7XUXxQs=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB4357.eurprd03.prod.outlook.com (20.177.33.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.20; Tue, 29 Jan 2019 14:46:45 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::3cc9:3b23:a872:99d7%2]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 14:46:45 +0000
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
Thread-Index: AQHUrNs7IxVSN/1nuUaI+Ik1wHznAaWxcBsAgAAB0ICAAAHygIABvZOAgAGYZ4CAACKFAIAEx8GAgABKW4CAASIegIAAFYGAgANT5QCAAAfggIAH11SA
Date:   Tue, 29 Jan 2019 14:46:44 +0000
Message-ID: <538813d9-2432-a697-6982-699da3a7c73c@epam.com>
References: <20190115140420.4652-1-andr2000@gmail.com>
 <20190116063002.jq3aas6ofhaogmyk@sirius.home.kraxel.org>
 <20190116063631.GA10881@infradead.org>
 <042fe794-dec6-6d9d-5b68-6f142790f5c7@epam.com>
 <20190117091815.GA7090@infradead.org>
 <1cfc5cb4-e481-5d71-29df-958db76fb681@epam.com>
 <2ed681b9-c8d4-ea27-6b8b-e399ed034bda@arm.com>
 <b5ee0d1c-7888-28c4-c5ae-7984c5e54c8e@epam.com>
 <9e0130ee-0418-f68c-94cf-31a5566d929a@arm.com>
 <79ac0743-68bc-c2b7-d843-cf152c40d583@epam.com>
 <34a31bc8-96c6-2801-689c-3c4498b68ee8@arm.com>
 <b0cfe533-5b0b-e20f-eeab-2ce743914c98@epam.com>
 <e5193e96-a80e-23fd-c833-447d6a2a1574@arm.com>
In-Reply-To: <e5193e96-a80e-23fd-c833-447d6a2a1574@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB4357;6:b4VS6jgBCO2kGZgivGXY7oQ+mEduSQFuda/LLR+T85LSYAtwCfMm2Z9i6em8SD0W/p97E1G/nGJmpYrvNVzCMKqSum2Giy5XNqyRvMsoeHSymNHvJ9SmU2doY3pVmDb+sfaC7QnrcwpAyVUfcawycKtWQjCy1Mu008ClwUe0rrkz5W0vk25h6DJE2oOowrxCjBDyCFHwFFbBTnXBP2D2bY1M4EW2Rw8wb4+OOCmDhzMn7uUjH8wEgsa7XKmPPVh26sq6kkypsdTMSMA7YEYWXmzSsXT3HA5+Pv/6QAJN92gSr1JFVOlMZUS3uGE6mFOb2u5Xwl1807mdHJReSEbL1c3/TeNiudz8Gg+Xc8INbw/44Cuu+R0jHdG2D8v0jt7FgLKfU8ZXMLHwobpaUpZ5SS6z4KD6JVvCFvYP52NBYbElKskMJXAjtr70FrUkdkFj6J5Q6NHc7r7BypxL1KBUpQ==;5:5Rw1cmCf3lEwSoH6BtwCaacJsFzmChVu8IFqLctGj3GF5Mr/4FKfu/vbhAAafXS8ulbxpptEc8ypbQCKZugcadnqzXb0XeFxWLwFFBeV+of2fTyOgtEHJ/f/SJfBzAcVCDzv0dgfnQriacrvQkBqat5G+LVpJOiXeKiSN2DiFqk5D40nLrjpmbMtk/Q4N3qQixqR4mFvbdQcxcCJHyUtvw==;7:vxcbopJ33ZXI0IwJEaLZCicTecXaNisLDKgM5zw/LtIEb2FM4++2gDqhki9/DtgrGu/i/4aBvMycsTJD8tAxJv9DAZ0PEC9ZQRF5npn+xau2JQyzack0i9cRQHlcj6Rd+Ad1+YB/PMJlm7thIUnLwQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fce52962-9148-4de2-20d2-08d685f89700
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB4357;
x-ms-traffictypediagnostic: AM6PR03MB4357:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-microsoft-antispam-prvs: <AM6PR03MB4357A6F6007BDA9562ED09B2E7970@AM6PR03MB4357.eurprd03.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(52314003)(36756003)(72206003)(6436002)(105586002)(14454004)(97736004)(6512007)(6116002)(3846002)(478600001)(316002)(66066001)(4326008)(7416002)(68736007)(86362001)(110136005)(53936002)(6246003)(31696002)(54906003)(2906002)(229853002)(80792005)(39060400002)(25786009)(6486002)(93886005)(81156014)(81166006)(8676002)(99286004)(76176011)(8936002)(7736002)(26005)(55236004)(53546011)(6506007)(106356001)(186003)(102836004)(446003)(2616005)(476003)(31686004)(486006)(14444005)(11346002)(256004)(71200400001)(345774005)(305945005)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB4357;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Kbu0Y41ruJ4XxAq3A0yoB8cz987q6Sb4HBlT5hHCdxjWXGlJ9AiNrAOaQgr2jVUq22dJyt5+24WUAAeNMqfPBlAQdNjazZ8kWVp5CuZfrm4hHeW80rQjkVN2znoj9T3LQb7RFULUO4EFOK4wXVNY3ThsSI8P5PgKZvZ+QHxrXwCVHZJX9LzKYCKm14BlzevPM5UJaKDW9jJ5B8QKG3g0FNCdymWCX5pxE1+CScCg6zKIJqa0rZrPdTVeEm3mH9/ix8BhbCfvo66BtuTz651R/g/WMGuGGlIoDxnpsz8yJ3wuVcAYWrsIC45ipmxTeYlSpZbrKc5a7sk0laK6D5VM98sYS3mpV5DrLlfaum4IJ1jqlqNT0urtKW5j42HJl5WigqTI6OpMuN88Fa33foG/Q5AQ1QzN1ufKnI0/Ca9BPbE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E36A7668B302C4D81FDEF64D7E00AA1@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce52962-9148-4de2-20d2-08d685f89700
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 14:46:45.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4357
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yNC8xOSA1OjAyIFBNLCBKdWxpZW4gR3JhbGwgd3JvdGU6DQo+DQo+DQo+IE9uIDI0LzAx
LzIwMTkgMTQ6MzQsIE9sZWtzYW5kciBBbmRydXNoY2hlbmtvIHdyb3RlOg0KPj4gSGVsbG8sIEp1
bGllbiENCj4NCj4gSGksDQo+DQo+PiBPbiAxLzIyLzE5IDE6NDQgUE0sIEp1bGllbiBHcmFsbCB3
cm90ZToNCj4+Pg0KPj4+DQo+Pj4gT24gMS8yMi8xOSAxMDoyOCBBTSwgT2xla3NhbmRyIEFuZHJ1
c2hjaGVua28gd3JvdGU6DQo+Pj4+IEhlbGxvLCBKdWxpZW4hDQo+Pj4NCj4+PiBIaSwNCj4+Pg0K
Pj4+PiBPbiAxLzIxLzE5IDc6MDkgUE0sIEp1bGllbiBHcmFsbCB3cm90ZToNCj4+Pj4gV2VsbCwg
SSBkaWRuJ3QgZ2V0IHRoZSBhdHRyaWJ1dGVzIG9mIHBhZ2VzIGF0IHRoZSBiYWNrZW5kIHNpZGUs
IGJ1dCANCj4+Pj4gSU1PDQo+Pj4+IHRob3NlDQo+Pj4+IGRvIG5vdCBtYXR0ZXIgaW4gbXkgdXNl
LWNhc2UgKGZvciBzaW1wbGljaXR5IEkgYW0gbm90IHVzaW5nDQo+Pj4+IHplcm8tY29weWluZyBh
dA0KPj4+PiBiYWNrZW5kIHNpZGUpOg0KPj4+DQo+Pj4gVGhleSBhcmUgYWN0dWFsbHkgaW1wb3J0
YW50IG5vIG1hdHRlciB3aGF0IGlzIHlvdXIgdXNlIGNhc2UuIElmIHlvdQ0KPj4+IGFjY2VzcyB0
aGUgc2FtZSBwaHlzaWNhbCBwYWdlIHdpdGggZGlmZmVyZW50IGF0dHJpYnV0ZXMsIHRoZW4geW91
IGFyZQ0KPj4+IGFza2luZyBmb3IgdHJvdWJsZS4NCj4+IFNvLCB3ZSBoYXZlOg0KPj4NCj4+IERv
bVU6IGZyb250ZW5kIHNpZGUNCj4+ID09PT09PT09PT09PT09PT09PT09DQo+PiAhUFRFX1JET05M
WSArIFBURV9QWE4gKyBQVEVfU0hBUkVEICsgUFRFX0FGICsgUFRFX1VYTiArDQo+PiBQVEVfQVRU
UklORFgoTVRfTk9STUFMKQ0KPg0KPiBJIHN0aWxsIGRvbid0IHVuZGVyc3RhbmQgaG93IHlvdSBj
YW1lIHVwIHdpdGggTVRfTk9STUFMIHdoZW4geW91IHNlZW0gDQo+IHRvIGNvbmZpcm0uLi4NCj4N
Cj4+DQo+PiBEb21EOiBiYWNrZW5kIHNpZGUNCj4+ID09PT09PT09PT09PT09PT09PT09DQo+PiBQ
VEVfVVNFUiArICFQVEVfUkRPTkxZICsgUFRFX1BYTiArIFBURV9ORyArIFBURV9DT05UICsgUFRF
X1RBQkxFX0JJVCArDQo+PiBQVEVfVVhOICsgUFRFX0FUVFJJTkRYKE1UX05PUk1BTCkNCj4+DQo+
PiDCoCBGcm9tIHRoZSBhYm92ZSBpdCBzZWVtcyB0aGF0IEkgZG9uJ3QgdmlvbGF0ZSBjYWNoZWQv
bm9uLWNhY2hlZA0KPj4gYWdyZWVtZW50IGhlcmUNCj4+Pg0KPj4+IFRoaXMgaXMgd2h5IFhlbiBp
bXBvc2VzIGFsbCB0aGUgcGFnZXMgc2hhcmVkIHRvIGhhdmUgdGhlaXIgbWVtb3J5DQo+Pj4gYXR0
cmlidXRlcyBmb2xsb3dpbmcgc29tZSBydWxlcy4gQWN0dWFsbHksIHNwZWFraW5nIHdpdGggTWFy
ayBSLiwgd2UNCj4+PiBtYXkgd2FudCB0byB0aWdodCBhIGJpdCBtb3JlIHRoZSBhdHRyaWJ1dGVz
Lg0KPj4+DQo+Pj4+DQo+Pj4+IDEuIEZyb250ZW5kIGRldmljZSBhbGxvY2F0ZXMgZGlzcGxheSBi
dWZmZXIgcGFnZXMgd2hpY2ggY29tZSBmcm9tIA0KPj4+PiBzaG1lbQ0KPj4+PiBhbmQgaGF2ZSB0
aGVzZSBhdHRyaWJ1dGVzOg0KPj4+PiAhUFRFX1JET05MWSArIFBURV9QWE4gKyBQVEVfU0hBUkVE
ICsgUFRFX0FGICsgUFRFX1VYTiArDQo+Pj4+IFBURV9BVFRSSU5EWChNVF9OT1JNQUwpDQo+Pj4N
Cj4+PiBNeSBrbm93bGVkZ2Ugb2YgWGVuIERSTSBpcyBpbmV4aXN0ZW50LiBIb3dldmVyLCBsb29r
aW5nIGF0IHRoZSBjb2RlIGluDQo+Pj4gNS4wLXJjMiwgSSBkb24ndCBzZWVtIHRvIGZpbmQgdGhl
IHNhbWUgYXR0cmlidXRlcy4gRm9yIGluc3RhbmNlDQo+Pj4geGVuX2RybV9mcm9udF9nZW1fcHJp
bWVfdm1hcCBhbmQgZ2VtX21tYXBfb2JqIGFyZSB1c2luZw0KPj4+IHBncHJvdF93cml0ZWNvbWJp
bmUuIFNvIGl0IGxvb2tzIGxpa2UsIHRoZSBtYXBwaW5nIHdpbGwgYmUNCj4+PiBub24tY2FjaGVh
YmxlIG9uIEFybTY0Lg0KPj4+DQo+Pj4gQ2FuIHlvdSBleHBsYWluIGhvdyB5b3UgY2FtZSB1cCB0
byB0aGVzZSBhdHRyaWJ1dGVzPw0KPj4gcGdwcm90X3dyaXRlY29tYmluZSBpcyBQVEVfQVRUUklO
RFgoTVRfTk9STUFMX05DKSwgc28gaXQgc2VlbXMgdG8gYmUNCj4+IGFwcGxpY2FibGUgaGVyZT8g
WzFdDQo+DQo+IC4uLiB0aGF0IE1UX05PUk1BTF9OQyBpcyB1c2VkIGZvciB0aGUgZnJvbnRlbmQg
cGFnZXMuDQo+DQo+IE1UX05PUk1BTF9OQyBpcyBkaWZmZXJlbnQgZnJvbSBNVF9OT1JNQUwuIFRo
ZSB1c2Ugb2YgdGhlIGZvcm1lciB3aWxsIA0KPiByZXN1bHQgdG8gbm9uLWNhY2hlYWJsZSBtZW1v
cnkgd2hpbGUgdGhlIGxhdHRlciB3aWxsIHJlc3VsdCB0byANCj4gY2FjaGVhYmxlIG1lbW9yeS4N
Cj4NCj4gVG8gbWUsIHRoaXMgbG9va3MgbGlrZSB0aGUgZXhhY3QgcmVhc29uIHdoeSB5b3Ugc2Vl
IGFydGlmYWN0IG9uIHRoZSANCj4gZGlzcGxheSBidWZmZXIuIEFzIHRoZSBhdXRob3Igb2YgdGhp
cyBjb2RlLCBjYW4geW91IGV4cGxhaW4gd2h5IHlvdSANCj4gZGVjaWRlZCB0byB1c2UgcGdwcm90
X3dyaXRlY29tYmluZSBoZXJlIGluc3RlYWQgb2YgcmVseWluZyBvbiB0aGUgDQo+IGRlZmF1bHQg
Vk1BIHByb3Q/DQo+DQo+IFsuLi5dDQpTb3JyeSBmb3IgbGF0ZSByZXBseSwgaXQgdG9vayBtZSBx
dWl0ZSBzb21lIHRpbWUgdG8gcmUtY2hlY2sgYWxsIHRoZSANCnVzZS1jYXNlcw0KdGhhdCB3ZSBo
YXZlIHdpdGggUFYgRFJNLg0KRmlyc3Qgb2YgYWxsIEkgZm91bmQgYSBidWcgaW4gbXkgZGVidWcg
Y29kZSB3aGljaCByZXBvcnRlZCBwYWdlIA0KYXR0cmlidXRlcyBhbmQNCm5vdyBJIGNhbiBjb25m
aXJtIHRoYXQgYWxsIHRoZSB1c2UtY2FzZXMgc3VlIE1UX05PUk1BTCwgYm90aCBiYWNrZW5kIGFu
ZCANCmZyb250ZW5kLg0KWW91IGFyZSByaWdodDogdGhlcmUgaXMgbm8gcmVhc29uIHRvIGhhdmUg
cGdwcm90X3dyaXRlY29tYmluZSBhbmQgaW5kZWVkIA0KSSBoYXZlDQp0byByZWx5IG9uIGFsbW9z
dCBkZWZhdWx0IFZNQSBwcm90LiBJIGNhbWUgdXAgd2l0aCB0aGUgZm9sbG93aW5nICh1c2VkIA0K
Ynkgb21hcCBkcm0sDQpmb3IgZXhhbXBsZSk6DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0veGVuL3hlbl9kcm1fZnJvbnRfZ2VtLmMgDQpiL2RyaXZlcnMvZ3B1L2RybS94ZW4veGVuX2Ry
bV9mcm9udF9nZW0uYw0KaW5kZXggYWUyOGFkNGI0MjU0Li44Njc4MDBhMmVkNDIgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2dwdS9kcm0veGVuL3hlbl9kcm1fZnJvbnRfZ2VtLmMNCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS94ZW4veGVuX2RybV9mcm9udF9nZW0uYw0KQEAgLTIzOCw4ICsyMzgsNyBAQCBz
dGF0aWMgaW50IGdlbV9tbWFwX29iaihzdHJ1Y3QgeGVuX2dlbV9vYmplY3QgKnhlbl9vYmosDQog
wqDCoMKgwqDCoMKgwqAgdm1hLT52bV9mbGFncyAmPSB+Vk1fUEZOTUFQOw0KIMKgwqDCoMKgwqDC
oMKgIHZtYS0+dm1fZmxhZ3MgfD0gVk1fTUlYRURNQVA7DQogwqDCoMKgwqDCoMKgwqAgdm1hLT52
bV9wZ29mZiA9IDA7DQotwqDCoMKgwqDCoMKgIHZtYS0+dm1fcGFnZV9wcm90ID0NCi0gcGdwcm90
X3dyaXRlY29tYmluZSh2bV9nZXRfcGFnZV9wcm90KHZtYS0+dm1fZmxhZ3MpKTsNCivCoMKgwqDC
oMKgwqAgdm1hLT52bV9wYWdlX3Byb3QgPSB2bV9nZXRfcGFnZV9wcm90KHZtYS0+dm1fZmxhZ3Mp
Ow0KDQogwqDCoMKgwqDCoMKgwqAgew0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
bnQgY250ID0geGVuX29iai0+bnVtX3BhZ2VzID4gNSA/IDUgOiB4ZW5fb2JqLT5udW1fcGFnZXM7
DQpAQCAtMjk1LDcgKzI5NCw3IEBAIHZvaWQgKnhlbl9kcm1fZnJvbnRfZ2VtX3ByaW1lX3ZtYXAo
c3RydWN0IA0KZHJtX2dlbV9vYmplY3QgKmdlbV9vYmopDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiBOVUxMOw0KDQogwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHZtYXAoeGVu
X29iai0+cGFnZXMsIHhlbl9vYmotPm51bV9wYWdlcywNCi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgVk1fTUFQLCBwZ3Byb3Rfd3JpdGVjb21iaW5lKFBBR0VfS0VSTkVMKSk7
DQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZNX01BUCwgUEFHRV9LRVJO
RUwpOw0KIMKgfQ0KDQpXaXRoIHRoZSBhYm92ZSBhbGwgdGhlIGFydGlmYWN0cyBhcmUgZ29uZSBu
b3cgYXMgcGFnZSBhdHRyaWJ1dGVzIGFyZSB0aGUgDQpzYW1lIGFjcm9zcw0KYWxsIGRvbWFpbnMu
IFNvLCBJIGNvbnNpZGVyIHRoaXMgYXMgYSBmaXggYW5kIHdpbGwgc2VuZCBpdCBhcyB2MyBvciBi
ZXR0ZXINCmRyb3AgdGhpcyBwYXRjaCBhbmQgaGF2ZSBhIG5ldyBvbmUuDQoNClRIQU5LIFlPVSBm
b3IgaGVscGluZyBmaWd1cmluZyB0aGlzIG91dCENCj4NCj4+PiBXZSBhY3R1YWxseSBuZXZlciBy
ZXF1aXJlZCB0byB1c2UgY2FjaGUgZmx1c2ggaW4gb3RoZXIgUFYgcHJvdG9jb2wsIHNvDQo+Pj4g
SSBzdGlsbCBkb24ndCB1bmRlcnN0YW5kIHdoeSB0aGUgUFYgRFJNIHNob3VsZCBiZSBkaWZmZXJl
bnQgaGVyZS4NCj4+IFdlbGwsIHlvdSBhcmUgcmlnaHQuIEJ1dCBhdCB0aGUgc2FtZSB0aW1lIG5v
dCBmbHVzaGluZyB0aGUgYnVmZmVyIG1ha2VzDQo+PiB0cm91YmxlcywNCj4+IHNvIHRoaXMgaXMg
d2h5IEkgYW0gdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgd2hhdCBpcyB3cm9uZyBoZXJlLg0KPg0KPiBU
aGUgY2FjaGUgZmx1c2ggaXMgbGlrZWx5IGhpZGluZyB0aGUgcmVhbCBwcm9ibGVtIHJhdGhlciB0
aGFuIHNvbHZpbmcgaXQuDQo+DQpJdCBkb2VzIGhpZGUgdGhlIHJlYWwgaXNzdWUuIEFuZCBJIGhh
dmUgY29uZmlybWVkIHRoaXMNCj4+Pg0KPj4+IFRvIG1lLCBpdCBsb29rcyBsaWtlIHRoYXQgeW91
IGFyZSBlaXRoZXIgbWlzc2luZyBzb21lIGJhcnJpZXJzDQo+PiBCYXJyaWVycyBmb3IgdGhlIGJ1
ZmZlcj8gTm90IHN1cmUgd2hhdCB5b3UgbWVhbiBoZXJlLg0KPg0KPiBJZiB5b3Ugc2hhcmUgaW5m
b3JtYXRpb24gYmV0d2VlbiB0d28gZW50aXRpZXMsIHlvdSBtYXkgbmVlZCBzb21lIA0KPiBvcmRl
cmluZyBzbyB0aGUgaW5mb3JtYXRpb24gYXJlIHNlZW4gY29uc2lzdGVudGx5IGJ5IHRoZSBjb25z
dW1lciANCj4gc2lkZS4gVGhpcyBjYW4gYmUgYWNoaWV2ZWQgYnkgdXNpbmcgYmFycmllcnMuDQo+
DQo+PiBFdmVuIG1vcmUsIHdlIGhhdmUNCj4+IGEgdXNlIGNhc2UNCj4+IHdoZW4gdGhlIGJ1ZmZl
ciBpcyBub3QgdG91Y2hlZCBieSBDUFUgaW4gRG9tRCBhbmQgaXMgc29sZWx5IG93bmVkIGJ5IA0K
Pj4gdGhlIEhXLg0KPg0KPiBNZW1vcnkgb3JkZXJpbmcgaXNzdWVzIGFyZSBzdWJ0bGUuIFRoZSBm
YWN0IHRoYXQgb25lIG9mIHlvdXIgdXNlLWNhc2UgDQo+IHdvcmtzIGRvZXMgbm90IGltcGx5IHRo
YXQgYmFycmllcnMgYXJlIG5vdCBuZWNlc3NhcnkuIEkgYW0gbm90IHNheWluZyANCj4gdGhlcmUg
YXJlIGEgbWlzc2luZyBiYXJyaWVycywgSSBhbSBvbmx5IHBvaW50ZWQgb3V0IHBvdGVudGlhbCBy
ZWFzb25zLg0KPg0KPiBBbnl3YXksIEkgZG9uJ3QgdGhpbmsgeW91ciBwcm9ibGVtIGlzIGEgbWlz
c2luZyBiYXJyaWVycyBoZXJlLiBJdCBpcyANCj4gbW9yZSBsaWtlbHkgYmVjYXVzZSBvZiBtaXNt
YXRjaCBtZW1vcnkgYXR0cmlidXRlcyAoc2VlIGFib3ZlKS4NCj4NClllcywgcGxlYXNlIHNlZSBh
Ym92ZQ0KPiBDaGVlcnMsDQo+DQpUaGFuayB5b3UgYWxsIGZvciBoZWxwaW5nIHdpdGggdGhlIGNv
cnJlY3QgZml4LA0KT2xla3NhbmRy

Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD72FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2CB20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="aVCpJu/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388074AbfAPGnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:43:35 -0500
Received: from mail-eopbgr00065.outbound.protection.outlook.com ([40.107.0.65]:48416
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730889AbfAPGnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vH+QYR36YaGAqrPkN65fLjI34SzcisKNiFEru110h70=;
 b=aVCpJu/cIkCJW6TsLO7Xz0kw6uL0q9I85ZHhglVCBJnnwdowpzaIyYcY9/EfvZPNRGVjeF0COn0xrN1FJPFoGZZn2JBIJKWZuJdE4lgVamTsRhMC7087mpr1Tn1UPaDoS7HpcA9TKkjB7qa94ZbMtVDrPHyyKbuLer8o+z701rs=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB4439.eurprd03.prod.outlook.com (20.177.33.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Wed, 16 Jan 2019 06:43:29 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::844b:fab6:64d8:2f37]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::844b:fab6:64d8:2f37%3]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 06:43:29 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Gerd Hoffmann <kraxel@redhat.com>
CC:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "noralf@tronnes.org" <noralf@tronnes.org>
Subject: Re: [PATCH v2] drm/xen-front: Make shmem backed display buffer
 coherent
Thread-Topic: [PATCH v2] drm/xen-front: Make shmem backed display buffer
 coherent
Thread-Index: AQHUrNs7IxVSN/1nuUaI+Ik1wHznAaWxcBsAgAAB0ICAAAHygA==
Date:   Wed, 16 Jan 2019 06:43:29 +0000
Message-ID: <042fe794-dec6-6d9d-5b68-6f142790f5c7@epam.com>
References: <20190115140420.4652-1-andr2000@gmail.com>
 <20190116063002.jq3aas6ofhaogmyk@sirius.home.kraxel.org>
 <20190116063631.GA10881@infradead.org>
In-Reply-To: <20190116063631.GA10881@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB4439;6:16DLyduWbLCWVC9aBKy3btjIltDIh8sC9A2e8oII0gECp/dWkqwCPoO3tCTj9tgaDTJEC3sohZidOxZIVkDVxH2mJdEmjxGW/G0XGRa27jgfsVpzG7aDKYTetjDSHWmQPQiNfJfMPnZc0c4YqOYMJS8rmbt22g/w5/1fRA69N0Fb05fKLLzjyS1HQfmGq0Fcet4S/+FIXtyDCIExCieRvsHsavowvMGL+CQTouxBGpvvd5ASr73kj/xhIR3EhTZvJj06ggIZDnRrYQg9yHg+hE9gFVofcmVaFfFtJPawTDdVjuhqaKQyBeqMuMCKI1jDioWb01kKNwjvefEeDo3iowpITgLGaUv3kwitOOb1pfX0CWqD121WR+dHkUth+lK7kcFl4AWr0FvABvmvs+XFs5oF/mwokm6t9FiuEV7uYXACr4mi4sJaCa79po6wl2IGaw/RuchzxJLMEqWhB+8hSQ==;5:N+yFxMLQk48JP6aEjALUOcgYCLgochPjHqyAjro074kZ0X8C9pfo6lJKbBgfOwHKE0hNf5yvJpp2ViQ6jlGqsJnRx6X3o7XrBf/4tDgPZ65J6zusLXA0VIegdDmXfdUj/hmWaPW9qOH1uzy30iEcJUugMB02HuVAhJG2uGyv6yAjDQYc3ZFScBQEBmUCTfuQl4tio7gllXfJ7hAvBRBQXw==;7:cBjX4hkGNK7G2ZVGftheLMXkCfz8rcCzx4mrFp0UMNXDBrF7eO1KIAZsjj76srhvxUJ0tnwWr8ZszDNK08efVFCMz1G9yaKG2FlsRxVrNak3YyWzWGg9nHUIpGcIkfqpzUPG0X4PgM2xseFvwsJZqg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 56ca07aa-4098-47d1-e656-08d67b7ded0b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB4439;
x-ms-traffictypediagnostic: AM6PR03MB4439:
x-microsoft-antispam-prvs: <AM6PR03MB443932CC74E3207DCE5DF981E7820@AM6PR03MB4439.eurprd03.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(136003)(376002)(189003)(199004)(7416002)(110136005)(54906003)(11346002)(81166006)(102836004)(81156014)(26005)(8676002)(7736002)(105586002)(31686004)(14454004)(305945005)(99286004)(8936002)(76176011)(476003)(6506007)(186003)(256004)(5660300001)(72206003)(316002)(446003)(2616005)(106356001)(478600001)(486006)(68736007)(55236004)(53546011)(25786009)(2906002)(6512007)(97736004)(80792005)(6246003)(3846002)(86362001)(31696002)(4326008)(53936002)(36756003)(66066001)(6436002)(39060400002)(71190400001)(71200400001)(6116002)(6486002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB4439;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LsyZN64g9O6PgDYWTYbX1IdVsgyK5ApK8fGcRM4XXHO42lc02w+CzoQkAAefbl02eEkc32q6VsgYY2heVbh09cRVKmekzbUSmCzFQsnqAP4I+KIrwy4APDDPwAH12niLhYpaqIGnbK1Kz1h9FkyPQMfkWoZcVYQKksaRbb5qGt0jUhHV/ukFVB79wgdN35c+nsH/cQ/RutV+hIa1m2gec6NBKyFC1TrYsSaUPzFdfn3st10u8A6vVs9GQrC8dR/N4bkEvyOOkjGqq5r2wVtlZuCjzi9z+OQqQBgoIvNOaj1MfIzwMO7YWMJn5H9G7xFu0ffItm17CmQaSnASDACNBtmi2fO1nPe0l1PQu0+ILOS96mFqxHyxJJUK+GHVo7+nvDVP2QEQx553Tv5GF6lvnZ9oeVRdDZeR4lNvIhR5Bg4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A23AA4B1281BD945A6E3BB322C07423C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ca07aa-4098-47d1-e656-08d67b7ded0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 06:43:29.6941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4439
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xNi8xOSA4OjM2IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gV2VkLCBK
YW4gMTYsIDIwMTkgYXQgMDc6MzA6MDJBTSArMDEwMCwgR2VyZCBIb2ZmbWFubiB3cm90ZToNCj4+
ICAgIEhpLA0KPj4NCj4+PiArCWlmICghZG1hX21hcF9zZyhkZXYtPmRldiwgeGVuX29iai0+c2d0
LT5zZ2wsIHhlbl9vYmotPnNndC0+bmVudHMsDQo+Pj4gKwkJCURNQV9CSURJUkVDVElPTkFMKSkg
ew0KPj4+ICsJCXJldCA9IC1FRkFVTFQ7DQo+Pj4gKwkJZ290byBmYWlsX2ZyZWVfc2d0Ow0KPj4+
ICsJfQ0KPj4gSG1tLCBzbyBpdCBzZWVtcyB0aGUgYXJtIGd1eXMgY291bGQgbm90IGNvbWUgdXAg
d2l0aCBhIHN1Z2dlc3Rpb24gaG93IHRvDQo+PiBzb2x2ZSB0aGF0IG9uZSBpbiBhIGJldHRlciB3
YXkuICBPaywgbGV0cyBnbyB3aXRoIHRoaXMgdGhlbi4NCj4+DQo+PiBCdXQgZGlkbid0IHdlIGFn
cmVlIHRoYXQgdGhpcyBkZXNlcnZlcyBhIGNvbW1lbnQgZXhtcGxhaW5pbmcgdGhlIHB1cnBvc2UN
Cj4+IG9mIHRoZSBkbWFfbWFwX3NnKCkgY2FsbCBpcyB0byBmbHVzaCBjYWNoZXMgYW5kIHRoYXQg
dGhlcmUgaXMgbm8gYWN0dWFsDQo+PiBETUEgaGFwcGVuaW5nIGhlcmU/DQo+IFVzaW5nIGEgZG1h
IG1hcHBpbmcgY2FsbCB0byBmbHVzaCBjYWNoZXMgaXMgY29tcGxldGUgbm8tZ28uICBCdXQgdGhl
DQo+IHJlYWwgcXVlc3Rpb24gaXMgd2h5IHlvdSdkIGV2ZW4gd2FudCB0byBmbHVzaCBjYXNoZXMg
aWYgeW91IGRvIG5vdA0KPiB3YW50IGEgZG1hIG1hcHBpbmc/DQo+DQo+IFRoaXMgd2hvbGUgaXNz
dWUga2VlcHMgZ2V0dGluZyBtb3JlIGFuZCBtb3JlIGNvbmZ1c2luZy4NCldlbGwsIEkgZG9uJ3Qg
cmVhbGx5IGRvIERNQSBoZXJlLCBidXQgaW5zdGVhZCB0aGUgYnVmZmVycyBpbg0KcXVlc3Rpb24g
YXJlIHNoYXJlZCB3aXRoIG90aGVyIFhlbiBkb21haW4sIHNvIGVmZmVjdGl2ZWx5IGl0DQpjb3Vs
ZCBiZSB0aG91Z2h0IG9mIHNvbWUgc29ydCBvZiBETUEgaGVyZSwgd2hlcmUgdGhlICJkZXZpY2Ui
IGlzDQp0aGF0IHJlbW90ZSBkb21haW4uIElmIHRoZSBidWZmZXJzIGFyZSBub3QgZmx1c2hlZCB0
aGVuIHRoZQ0KcmVtb3RlIHBhcnQgc2VlcyBzb21lIGluY29uc2lzdGVuY3kgd2hpY2ggaW4gbXkg
Y2FzZSByZXN1bHRzDQppbiBhcnRpZmFjdHMgb24gc2NyZWVuIHdoaWxlIGRpc3BsYXlpbmcgdGhl
IGJ1ZmZlcnMuDQpXaGVuIGJ1ZmZlcnMgYXJlIGFsbG9jYXRlZCB2aWEgRE1BIEFQSSB0aGVuIHRo
ZXJlIGFyZSBubyBhcnRpZmFjdHM7DQppZiBidWZmZXJzIGFyZSBhbGxvY2F0ZWQgd2l0aCBzaG1l
bSArIERNQSBtYXBwaW5nIHRoZW4gdGhlcmUgYXJlIG5vDQphcnRpZmFjdHMgYXMgd2VsbC4NClRo
ZSBvbmx5IG9mZmVuZGluZyB1c2UtY2FzZSBpcyB3aGVuIEkgdXNlIHNobWVtIGJhY2tlZCBidWZm
ZXJzLA0KYnV0IGRvIG5vdCBmbHVzaCB0aGVt

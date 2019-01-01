Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD929C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 07:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05E42075D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 07:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="J7KYaAJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfAAHzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 02:55:04 -0500
Received: from mail-eopbgr140131.outbound.protection.outlook.com ([40.107.14.131]:5966
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727883AbfAAHzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 02:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHnlHB9FM1aELLv8hIVpTkafcuXx4OWwYbeLxrif3v4=;
 b=J7KYaAJbKvG8zRLiZXAuUg0qEI5cK+sIrAdVuXybxV2C9wqSMTLS4x7S6OV2pRhR2DWQS0nTJoejzf0Cebqyp+KB0V8wMpNdweNaQ76fk39SGTgFplYgUGrIhjwUiW8vn6lw3mXSo9HY4IA3YM271lYMi90pWBIfPSLtvKX6Ejg=
Received: from DB7PR08MB3771.eurprd08.prod.outlook.com (20.178.47.26) by
 DB7PR08MB3225.eurprd08.prod.outlook.com (52.134.111.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Tue, 1 Jan 2019 07:54:59 +0000
Received: from DB7PR08MB3771.eurprd08.prod.outlook.com
 ([fe80::83:10e6:94a0:6bb8]) by DB7PR08MB3771.eurprd08.prod.outlook.com
 ([fe80::83:10e6:94a0:6bb8%4]) with mapi id 15.20.1471.019; Tue, 1 Jan 2019
 07:54:59 +0000
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     Murali Krishna Policharla <murali.policharla@broadcom.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "amritha.nambiar@intel.com" <amritha.nambiar@intel.com>,
        "ecree@solarflare.com" <ecree@solarflare.com>,
        "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: core: Fix to store new mtu setting in netdevice.
Thread-Topic: [PATCH] net: core: Fix to store new mtu setting in netdevice.
Thread-Index: AQHUoZ1NkkZpWDs1uUKuI9iWquyn7qWaC1AA
Date:   Tue, 1 Jan 2019 07:54:59 +0000
Message-ID: <b2127534-4e9c-1fef-27f1-72329595c3a3@virtuozzo.com>
References: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
In-Reply-To: <1546324934-17555-1-git-send-email-murali.policharla@broadcom.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0003.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::13) To DB7PR08MB3771.eurprd08.prod.outlook.com
 (2603:10a6:10:7c::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [128.69.177.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR08MB3225;20:aNMYlBmYbCyJ/PXRVT4Haxz8g/iNLzfgFsQDvnWw8VldEKKITUQ4yiCysSX5RKRx2jzguOdcsQhoXLkFh9KPBmjabhh4SAH/3WVhk12e8MpbI2GXjbtMAJfdWNp6DZpmNq83piHOQz24Gv/w1nVPvbXoEfOPaY+joj/WIFh6oY0=
x-ms-office365-filtering-correlation-id: 67726e7f-f233-4c20-4771-08d66fbe6d50
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3225;
x-ms-traffictypediagnostic: DB7PR08MB3225:
x-microsoft-antispam-prvs: <DB7PR08MB32258317711767BA2C42ADE4CDB30@DB7PR08MB3225.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR08MB3225;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3225;
x-forefront-prvs: 0904004ECB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(396003)(346002)(39840400004)(199004)(189003)(6246003)(14444005)(14454004)(256004)(53936002)(2616005)(5660300001)(6116002)(11346002)(68736007)(446003)(2201001)(71190400001)(66066001)(3846002)(2906002)(36756003)(6512007)(31696002)(7736002)(6486002)(305945005)(6436002)(71200400001)(86362001)(4326008)(105586002)(486006)(81156014)(478600001)(8676002)(316002)(54906003)(476003)(25786009)(99286004)(229853002)(186003)(52116002)(2501003)(76176011)(6506007)(53546011)(55236004)(386003)(102836004)(26005)(81166006)(97736004)(106356001)(8936002)(110136005)(31686004);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3225;H:DB7PR08MB3771.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ctQb+GbDgcZ6mFUhZO4j6u3pu8J0khRzIFDVXGn1juUq9uKpThMl8nYmBFBuqZeK818H4Kk49NIIaSklRUScWEy3OcCco4O+3zqOVXWboOnvODcp0UH42AVOzQIM7uOKzhL4LqGbcq19kxp/hG2BjL204OptF/Byl1c8iPffLWh0+WfZtqIVHKJuLRFhgxBvYN5UqbXBOn5PoLwPQD2f0nARVPfZcwfx37G2diV/HNYqv6J2fF7elMV2brAYVIxQ/QKQ45Z3qpkPvRIiJ1bpm/iRRIdzMEf5MAtvYXAL7KGZ35Ki7/+yDPtbjl5PbpHe
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EC56CC402EE174F9149FB2523BD51FD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67726e7f-f233-4c20-4771-08d66fbe6d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2019 07:54:59.1663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEuMDEuMjAxOSAwOTo0MiwgTXVyYWxpIEtyaXNobmEgUG9saWNoYXJsYSB3cm90ZToNCj4g
U3RvcmUgbmV3bHkgY29uZmlndXJlZCBtdHUgc2V0dGluZ3MgaW4gdGhlIG5ldGRldmljZSBhZnRl
ciBtdHUNCj4gY29uZmlndXJhdGlvbiBpcyBzdWNjZXNzZnVsIHRvIHRoZSBkc2Egc3dpdGNoLg0K
PiANCj4gRml4ZXM6IDIzMTVkYzkxYTUgKCJuZXQ6IG1ha2UgZGV2X3NldF9tdHUoKSBob25vciBu
b3RpZmljYXRpb24gcmV0dXJuIGNvZGUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNdXJhbGkgS3Jpc2hu
YSBQb2xpY2hhcmxhIDxtdXJhbGkucG9saWNoYXJsYUBicm9hZGNvbS5jb20+DQo+IFJldmlld2Vk
LWJ5OiBGbG9yaWFuIEZhaW5lbGxpIDxmbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbT4NCj4g
LS0tDQo+ICBuZXQvY29yZS9kZXYuYyB8IDkgKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9j
b3JlL2Rldi5jIGIvbmV0L2NvcmUvZGV2LmMNCj4gaW5kZXggNzIyZDUwZC4uNTg2MTdhYSAxMDA2
NDQNCj4gLS0tIGEvbmV0L2NvcmUvZGV2LmMNCj4gKysrIGIvbmV0L2NvcmUvZGV2LmMNCj4gQEAg
LTc1ODYsMTIgKzc1ODYsMTUgQEAgaW50IGRldl9jaGFuZ2VfZmxhZ3Moc3RydWN0IG5ldF9kZXZp
Y2UgKmRldiwgdW5zaWduZWQgaW50IGZsYWdzKQ0KPiAgaW50IF9fZGV2X3NldF9tdHUoc3RydWN0
IG5ldF9kZXZpY2UgKmRldiwgaW50IG5ld19tdHUpDQo+ICB7DQo+ICAJY29uc3Qgc3RydWN0IG5l
dF9kZXZpY2Vfb3BzICpvcHMgPSBkZXYtPm5ldGRldl9vcHM7DQo+ICsJaW50IHJldCA9IDA7DQo+
ICANCj4gIAlpZiAob3BzLT5uZG9fY2hhbmdlX210dSkNCj4gLQkJcmV0dXJuIG9wcy0+bmRvX2No
YW5nZV9tdHUoZGV2LCBuZXdfbXR1KTsNCg0KSXMgdGhlcmUgYSAubmRvX2NoYW5nZV9tdHUgY2Fs
bGJhY2ssIHdoaWNoIGRvZXMgbm90IGFzc2lnbiBhIG5ldyBtdHUgaXRzZWxmPw0KDQo+ICsJCXJl
dCA9IG9wcy0+bmRvX2NoYW5nZV9tdHUoZGV2LCBuZXdfbXR1KTsNCj4gIA0KPiAtCWRldi0+bXR1
ID0gbmV3X210dTsNCj4gLQlyZXR1cm4gMDsNCj4gKwlpZiAocmV0ID49IDApDQo+ICsJCWRldi0+
bXR1ID0gbmV3X210dTsNCj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICB9DQo+ICBFWFBPUlRfU1lN
Qk9MKF9fZGV2X3NldF9tdHUpOw0KPiAgDQo+IA0KDQo=

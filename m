Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642D1C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8F6208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="rnNWbeTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8F6208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeLHIlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 03:41:40 -0500
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:63489
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbeLHIlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 03:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6yDqKW4ldtBtBKJuDRK6Al63E6W8EZOUpo+zJPDZfc=;
 b=rnNWbeTQgZ7mvGlIuYhkjcEW69/TmnWALB7MnXmLTr9I9rPCm4uuzapY8HnWntYQsluq5qr9LQ8iunXKeSjuw3iMSg1xsYpndLqyguE0I9pofDrIvNfTqoeM5YTFjszIWR1mEQ78gV49OgJq9iP4fFJTiebIRJ4eW9GQuyu4NYw=
Received: from AM0PR0502MB4068.eurprd05.prod.outlook.com (52.133.41.24) by
 AM0PR0502MB3665.eurprd05.prod.outlook.com (52.133.46.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Sat, 8 Dec 2018 08:41:33 +0000
Received: from AM0PR0502MB4068.eurprd05.prod.outlook.com
 ([fe80::ee:e7ec:61b7:ed00]) by AM0PR0502MB4068.eurprd05.prod.outlook.com
 ([fe80::ee:e7ec:61b7:ed00%3]) with mapi id 15.20.1404.023; Sat, 8 Dec 2018
 08:41:33 +0000
From:   Eran Ben Elisha <eranbe@mellanox.com>
To:     Tarick Bedeir <tarick@google.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net/mlx4_core: Correctly set PFC param if global pause is
 turned off.
Thread-Topic: [PATCH] net/mlx4_core: Correctly set PFC param if global pause
 is turned off.
Thread-Index: AQHUjgcwcja5olH/3kCE6MVuyTxWEKV0h4+A
Date:   Sat, 8 Dec 2018 08:41:33 +0000
Message-ID: <cf9b9fb2-89a0-e9f3-9dbf-80d68c1ae361@mellanox.com>
References: <20181207083026.173789-1-tarick@google.com>
In-Reply-To: <20181207083026.173789-1-tarick@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR06CA0035.eurprd06.prod.outlook.com
 (2603:10a6:206:2::48) To AM0PR0502MB4068.eurprd05.prod.outlook.com
 (2603:10a6:208:12::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=eranbe@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.124.72.79]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0502MB3665;6:hVyug0H0/n3ZmUhhlHmjA6pc/63X1sfFzX9JWc6zVGxeUF/D0+BuXkLMsQ0bPnl9SIg/xintTH2R3lRVq2df7MlIU7hJlrtI45xsahXRTZkEH4Ppho8QU6KpPuOdFKSI9rxZWDOvzrv4JSbZY+9sQqBw+1HwNOu0nxHUtbYDU/Auz3oAWHt9EVZArLaiB4vW0UqF6TY2GU6fZFW3qRrnrhAxY7c7nTOwVXJLRc1BsrGbyvLoska00slYAzpApWKr1Bd1SGhwCxK08UVfaKquFy6/tuDEM/CAtGJ94qOL/MbBf1aIaxmsPbHkH1SM4rqTrrIXotOhVGdtfymZqFB7YXvnqYHdJ7P64J4GZRKF1erOFUDkM+m3SnQcmuaHTBPjPwmRFaggukKiOe4+qFesq5H6+o9am2XOT2FQydWB9M2SzpredPHrrIcjvmOilrUjwwGq4cHSMReVpggYYbOwkw==;5:a7Ionq3DrLieZLAgvMf1ZDS+6w40lAA7jboTUXvl9EC9KiJdMdGG310JnZEuOSSj6vtk/t034TaufoUvirVyVO/OUrJqfCS1D3GDxo25Oa6YtX6CpniGWNGX1YNv0/PjpkjCtn9Qskc/qZ3WS/QBM033IFC6uJNCnmRhZ2+arpE=;7:wYHhpVa/VHceZ7XDjZxhM0yrtj95x8WV+p6wBGm3ZJftUCeeDkwDazqDK1I8RxLBjXpWfbVw4XpdaD7XE9m6Kreke1S2QIbPVmo5B+Ch0rAb7st9yMmj1Wg/iQD9S7x2NuCXnhfaBsC5gfq4nfX9eg==
x-ms-office365-filtering-correlation-id: dfb53515-19bc-4327-a6a9-08d65ce8f4d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0502MB3665;
x-ms-traffictypediagnostic: AM0PR0502MB3665:
x-microsoft-antispam-prvs: <AM0PR0502MB3665E8109091F286A8D6A3CFBAAB0@AM0PR0502MB3665.eurprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR0502MB3665;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0502MB3665;
x-forefront-prvs: 0880FB6EC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(39860400002)(136003)(346002)(199004)(189003)(51914003)(256004)(25786009)(97736004)(52116002)(31686004)(76176011)(66066001)(86362001)(4326008)(6246003)(31696002)(6116002)(53936002)(68736007)(105586002)(229853002)(316002)(3846002)(106356001)(14454004)(71200400001)(71190400001)(476003)(53546011)(6506007)(386003)(6486002)(54906003)(6512007)(6436002)(2616005)(186003)(8676002)(81166006)(81156014)(8936002)(110136005)(446003)(478600001)(7736002)(305945005)(486006)(26005)(102836004)(99286004)(11346002)(5660300001)(36756003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0502MB3665;H:AM0PR0502MB4068.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0IA8EM/POfuR1kCE0VlhZSZ5N80egU7QMATtKQbEEy+3eajIqZgo7iTjmHJl8p4Or1MY2idJwVSBebJqE7YkUeBqhD/po6g4VvHDbVwPz3Cv11NEdwSa5+UTrdhsUhSgBAwIOigesAIJdjjk63p5bP8rfdrxngMa61GK5h++AeRk5rCjbA0lzXmYQDATH7Yru5u8GIKC98SyCfRahl8kWKouY5jcGoQJ6dk+RwaLrrEoTuTIus1Ppj3wIYv98jk4u6mfwUSotSCW24t/09cCleK7Vo1yg1FJ602ZbJR1oylzj+85uoOOg41eakdKBE4+IlGOExc3c+ajiu+kKoZHPQrs8NjL/gFFn5Dcs2vAGtM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1678218A18D794A86795FFABFECB95D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb53515-19bc-4327-a6a9-08d65ce8f4d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2018 08:41:33.2726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3665
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEyLzcvMjAxOCAxMDozMCBBTSwgVGFyaWNrIEJlZGVpciB3cm90ZToNCj4gcnhfcHBw
IGFuZCB0eF9wcHAgY2FuIGJlIHNldCBiZXR3ZWVuIDAgYW5kIDI1NSwgc28gZG9uJ3QgY2xhbXAg
dG8gMS4NCj4gDQo+IEZpeGVzOiA2ZTg4MTRjZWI3ZTggKCJuZXQvbWx4NF9lbjogRml4IG1peGVk
IFBGQyBhbmQgR2xvYmFsIHBhdXNlIHVzZXIgY29udHJvbCByZXF1ZXN0cyIpDQo+IFNpZ25lZC1v
ZmYtYnk6IFRhcmljayBCZWRlaXIgPHRhcmlja0Bnb29nbGUuY29tPg0KPiAtLS0NCj4gICBkcml2
ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg0L2VuX2V0aHRvb2wuYyB8IDQgKystLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NC9lbl9ldGh0b29s
LmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg0L2VuX2V0aHRvb2wuYw0KPiBp
bmRleCBmMTFiNDUwMDFjYWQuLmQyOTBmMDc4N2RmYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NC9lbl9ldGh0b29sLmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NC9lbl9ldGh0b29sLmMNCj4gQEAgLTEwODQsOCArMTA4
NCw4IEBAIHN0YXRpYyBpbnQgbWx4NF9lbl9zZXRfcGF1c2VwYXJhbShzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZGV2LA0KPiAgIA0KPiAgIAl0eF9wYXVzZSA9ICEhKHBhdXNlLT50eF9wYXVzZSk7DQo+ICAg
CXJ4X3BhdXNlID0gISEocGF1c2UtPnJ4X3BhdXNlKTsNCj4gLQlyeF9wcHAgPSBwcml2LT5wcm9m
LT5yeF9wcHAgJiYgISh0eF9wYXVzZSB8fCByeF9wYXVzZSk7DQo+IC0JdHhfcHBwID0gcHJpdi0+
cHJvZi0+dHhfcHBwICYmICEodHhfcGF1c2UgfHwgcnhfcGF1c2UpOw0KPiArCXJ4X3BwcCA9ICh0
eF9wYXVzZSB8fCByeF9wYXVzZSkgPyAwIDogcHJpdi0+cHJvZi0+cnhfcHBwOw0KPiArCXR4X3Bw
cCA9ICh0eF9wYXVzZSB8fCByeF9wYXVzZSkgPyAwIDogcHJpdi0+cHJvZi0+dHhfcHBwOw0KPiAg
IA0KPiAgIAllcnIgPSBtbHg0X1NFVF9QT1JUX2dlbmVyYWwobWRldi0+ZGV2LCBwcml2LT5wb3J0
LA0KPiAgIAkJCQkgICAgcHJpdi0+cnhfc2tiX3NpemUgKyBFVEhfRkNTX0xFTiwNCj4gDQoNCnRo
YW5rcyBmb3IgdGhlIFRhcmljay4NCg0KUmV2aWV3ZWQtYnk6IEVyYW4gQmVuIEVsaXNoYSA8ZXJh
bmJlQG1lbGxhbm94LmNvbT4NCg==

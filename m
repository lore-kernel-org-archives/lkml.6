Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425FEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0897E20873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="nadUW7ZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBKKov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:44:51 -0500
Received: from mail-eopbgr150124.outbound.protection.outlook.com ([40.107.15.124]:18816
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726107AbfBKKou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZN9mUJu6JxwWo50tVr9AVgJPl+zdSDhpLHnz4pD23I0=;
 b=nadUW7ZU5NVPfr66MBKJ4RCMkQtX6C2/Bc6pkBWBcOHAKTTiM+iaCRjGqth472COZITiICqrw5UYBdVcPTIrKas+zHEF6Hi/OeYbK8/aEgL13jbySjEX6T3RIKwchM4pVZk8lCmEdIgVy4snjGr6spn+Sy8teyIIAkqrpX7dROU=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB3837.eurprd02.prod.outlook.com (52.134.25.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Mon, 11 Feb 2019 10:44:46 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 10:44:46 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Federico Vaga <federico.vaga@cern.ch>,
        Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] i2c:ocores: stop transfer on timeout
Thread-Topic: [PATCH v4 1/5] i2c:ocores: stop transfer on timeout
Thread-Index: AQHUweRMAO13avx7Mka5zrr0HYoZC6XaadAA
Date:   Mon, 11 Feb 2019 10:44:46 +0000
Message-ID: <d406a2ea-9d37-3eca-d975-818a22ca2458@axentia.se>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
 <20190211083122.32485-2-federico.vaga@cern.ch>
In-Reply-To: <20190211083122.32485-2-federico.vaga@cern.ch>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0202CA0021.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::31) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB3837;6:83rGMGnMucPpLL85KJCq0mNnJO5LJ8+zrBt+gleGU6quYLfkzDj6mj7SwSJQ/120fNDtyfpDucd3NXlF0P6oe+flG8mtqyWYiCHIeC1sL8P8F8JYwszCv9b8OV0xX4ZjhhFEysyo/axFmoxe5KxaK9mbY21qjCUk5aPl7XgQGSVW9ruzl55UkUPOpMe2UdVKAnErpw8eHKlxRZJpLCPfmD/LMHbTSt3BDJxZ3uBuxBLDw3yAYcCCXv/FD5nSvbT2xT9x5LOI9afgg3mo0Q2vmjTAshBxN23kvCkSVPQXH5XchDu/v+B+4nHEBTM0eQJSVLlaSaqKYYvduXRMnFh0RCP1PC/dvyj7T2DY22mv941Mxqjol6qoZ3itbrobg6TD+a7yJw71RXkPLB9NkuF2ckE3o5IvhFQJDqA5yAaCjd1eIszEx9y1a0rH3Md3DQVPTiSL0hQ6JK4zo+2jDnB8gQ==;5:lmVfBPeHadSw7iE9z5EJHyeFO0gOIP58d5NbijVWBZs8M9C4Zgh+pujm3attW48Npd6L/pGjIjeoOevrlfpoWMkp4KwbB/jOCSAXWy1Gn+AAUVbCwvFhPdqCHkhVU59VzXXGOZmhLl9Y4fDt1Z5tTedw+/rfk1rQXbta+o8nd/PdyHs2+lKOeEQzWZSHlxPTF4GtrX9F6sIKFBCMX+A2nw==;7:rACJpdZ7fhHxlirsAJolpu94hLs9sT97LvUlmU/AlZRiS7ZYrA9/5bkFLE8XybwhRi5rttBeXCO+w6IXCVjIWZ8bGMUHvWdUEU3AaNzLPznoJbE3K8TuPrB2sfCjSp3ppO5+LkIb1XhkYR+PSvicHQ==
x-ms-office365-filtering-correlation-id: 885fc4ab-c480-41b5-f7e6-08d6900df081
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB3837;
x-ms-traffictypediagnostic: VI1PR02MB3837:
x-microsoft-antispam-prvs: <VI1PR02MB3837650CCD2ECBED5A10E0B0BC640@VI1PR02MB3837.eurprd02.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(136003)(366004)(376002)(346002)(189003)(199004)(6436002)(26005)(105586002)(102836004)(74482002)(386003)(31686004)(53546011)(25786009)(186003)(64126003)(6506007)(6486002)(316002)(54906003)(110136005)(58126008)(99286004)(65806001)(66066001)(65956001)(229853002)(6512007)(65826007)(2906002)(256004)(53936002)(6246003)(6116002)(3846002)(4326008)(36756003)(14444005)(76176011)(14454004)(52116002)(508600001)(81166006)(81156014)(8676002)(86362001)(2616005)(71190400001)(71200400001)(7736002)(31696002)(446003)(476003)(68736007)(11346002)(8936002)(486006)(305945005)(97736004)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3837;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CPjYfwFZCUz70X6GrBKgqQcX4qyGLNyMw+MzWFbeh0uxDrv75u1J5vstsZdRs/Ou8/YaNqMUGvfdilaWuX0S+ZKu/CKhDXfq3thQ+ug7heSaxUcRVoc+hQ5BPkgN0Y/xUAdVRCtDTisdmh9MqKUofCoonE8Vw926hm95niohu4/JlN7WAiXlJxk04a+9arv0azRc0TwOuVze0rSBFODs+zcHfvXvYgEXrZQo2JL4xb0ByKnNpz011KQb4XFmcgouMx+Wa2yvaARVpsNvT1xQVQTAmJtGkKQmzIJ+FZZZsPdd/cIM1MHFWPR0wnkYw3kUs93Xh1oP6MvnNuF1QQYB1LBNAQAkrryOU/rOAQ4/U3vnwQuoKD5kSAKhLh6drRoJVJzHXuy+jtQ5F5XVaGCooPzhXoc+j933BxEkKAalzGM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF80FFA2966C85448330F5B5F76546C1@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 885fc4ab-c480-41b5-f7e6-08d6900df081
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 10:44:45.7904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3837
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMi0xMSAwOTozMSwgRmVkZXJpY28gVmFnYSB3cm90ZToNCj4gRGV0ZWN0aW5nIGEg
dGltZW91dCBpcyBvaywgYnV0IHdlIGFsc28gbmVlZCB0byBhc3NlcnQgYSBTVE9QIGNvbW1hbmQg
b24NCj4gdGhlIGJ1cyBpbiBvcmRlciB0byBwcmV2ZW50IGl0IGZyb20gZ2VuZXJhdGluZyBpbnRl
cnJ1cHRzIHdoZW4gdGhlcmUgYXJlDQo+IG5vIG9uIGdvaW5nIHRyYW5zZmVycy4NCj4gDQo+IEV4
YW1wbGU6IHZlcnkgbG9uZyB0cmFuc21pc3Npb24uDQo+IA0KPiAxLiBvY29yZXNfeGZlcjogU1RB
UlQgYSB0cmFuc2Zlcg0KPiAyLiBvY29yZXNfaXNyIDogaGFuZGxlIGJ5dGUgYnkgYnl0ZSB0aGUg
dHJhbnNmZXINCj4gMy4gb2NvcmVzX3hmZXI6IGdvZXMgaW4gdGltZW91dCBbW2J1Z2ZpeCBoZXJl
XV0NCj4gNC4gb2NvcmVzX3hmZXI6IHJldHVybiB0byBJMkMgc3Vic3lzdGVtIGFuZCB0byB0aGUg
STJDIGRyaXZlcg0KPiA1LiBJMkMgZHJpdmVyIDogaXQgbWF5IGNsZWFuIHVwIHRoZSBpMmNfbXNn
IG1lbW9yeQ0KPiA2LiBvY29yZXNfaXNyIDogcmVjZWl2ZXMgYW5vdGhlciBpbnRlcnJ1cHQgKHBl
bmRpbmcgYnl0ZXMgdG8gYmUNCj4gICAgICAgICAgICAgICAgIHRyYW5zZmVycmVkKSBidXQgdGhl
IGkyY19tc2cgbWVtb3J5IGlzIGludmFsaWQgbm93DQo+IA0KPiBTbywgc2luY2UgdGhlIHRyYW5z
ZmVyIHdhcyB0b28gbG9uZywgd2UgaGF2ZSB0byBkZXRlY3QgdGhlIHRpbWVvdXQgYW5kDQo+IFNU
T1AgdGhlIHRyYW5zZmVyLg0KPiANCj4gQW5vdGhlciBwb2ludCBpcyB0aGF0IHdlIGhhdmUgYSBj
cml0aWNhbCByZWdpb24gaGVyZS4gV2hlbiBoYW5kbGluZyB0aGUNCj4gdGltZW91dCBjb25kaXRp
b24gd2UgbWF5IGhhdmUgYSBydW5uaW5nIElSUSBoYW5kbGVyLiBGb3IgdGhpcyByZWFzb24gSQ0K
PiBpbnRyb2R1Y2UgYSBzcGlubG9jay4NCj4gDQo+IEluIG9yZGVyIHRvIG1ha2UgZWFzaWVyIHRv
IHVuZGVyc3RhbiBsb2NraW5nIEkgaGF2ZToNCj4gLSBhZGRlZCBhIG5ldyBmdW5jdGlvbiB0byBo
YW5kbGUgdGltZW91dA0KPiAtIG1vZGlmaWVkIHRoZSBjdXJyZW50IG9jb3Jlc19wcm9jZXNzKCkg
ZnVuY3Rpb24gaW4gb3JkZXIgdG8gYmUgcHJvdGVjdGVkDQo+ICAgYnkgdGhlIG5ldyBzcGlubG9j
aw0KPiBMaWtlIHRoaXMgaXQgaXMgb2J2aW91cyBhdCBmaXJzdCBzaWdodCB0aGF0IHRoaXMgbG9j
a2luZyBzZXJpYWxpemVzDQo+IHRoZSBleGVjdXRpb24gb2Ygb2NvcmVzX3Byb2Nlc3MoKSBhbmQg
b2NvcmVzX3Byb2Nlc3NfdGltZW91dCgpDQo+IA0KDQoqc25pcCoNCg0KPiBAQCAtMTg0LDE0ICsx
OTcsMTQgQEAgc3RhdGljIHZvaWQgb2NvcmVzX3Byb2Nlc3Moc3RydWN0IG9jb3Jlc19pMmMgKmky
YykNCj4gIA0KPiAgCQkJCW9jX3NldHJlZyhpMmMsIE9DSTJDX0RBVEEsIGFkZHIpOw0KPiAgCQkJ
CW9jX3NldHJlZyhpMmMsIE9DSTJDX0NNRCwgIE9DSTJDX0NNRF9TVEFSVCk7DQoNCkRpZG4ndCBj
aGVja3BhdGNoIGNvbXBsYWluIGFib3V0IHRoZSBkb3VibGUgc3BhY2U/IEZpeGluZyBpdCBmaXRz
IGluDQpwYXRjaCA1Li4uDQoNCkNoZWVycywNClBldGVyDQo=

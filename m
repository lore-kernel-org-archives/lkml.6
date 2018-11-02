Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3576FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2EF20831
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 22:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="hvYWhNRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2EF20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeKCHQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 03:16:04 -0400
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:15809
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726083AbeKCHQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 03:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/i5/ctKG9lzOEnKILUuhjlAWcYTeRRtWn2BQ2XMiRA=;
 b=hvYWhNREtQ3gWjZm0SDofJEHZGBpQ16yYGfjrwuXJEYLmaqi/4Npd69oLb+GaOA4qVzD/28i3Vf8UegTf1XKN+NGHTkewDnRBDwQ/O9gt2cR0lW19dS1SxvpQcGD/aFlNhvEhEaW1wUtchvYksgxjgDNayCgTYoMTJ0LRU9fhio=
Received: from DB6PR0502MB2901.eurprd05.prod.outlook.com (10.172.249.140) by
 DB6PR0502MB3000.eurprd05.prod.outlook.com (10.172.247.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.25; Fri, 2 Nov 2018 22:07:02 +0000
Received: from DB6PR0502MB2901.eurprd05.prod.outlook.com
 ([fe80::3c1f:a6d8:45c6:5d5]) by DB6PR0502MB2901.eurprd05.prod.outlook.com
 ([fe80::3c1f:a6d8:45c6:5d5%5]) with mapi id 15.20.1294.027; Fri, 2 Nov 2018
 22:07:02 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moshe Shemesh <moshe@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Boris Pismenny <borisp@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Kamal Heib <kamalh@mellanox.com>
Subject: Re: [PATCH] net/mlx5e: fix high stack usage
Thread-Topic: [PATCH] net/mlx5e: fix high stack usage
Thread-Index: AQHUcsFk3o0flMyDYkGmMaSNi/5NYKU8+hsAgAAJXYCAAAeNAA==
Date:   Fri, 2 Nov 2018 22:07:02 +0000
Message-ID: <4ebfc3aeb5335a1f671602f9a906f948c39a30da.camel@mellanox.com>
References: <20181102153316.1492515-1-arnd@arndb.de>
         <9f214f12ec89020ceb14c1aec25b3a0d968507aa.camel@mellanox.com>
         <2727f37b-1742-5532-317e-3be8a984266b@gmail.com>
In-Reply-To: <2727f37b-1742-5532-317e-3be8a984266b@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [73.15.39.150]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0502MB3000;6:ArW3suedZmigMqVb5WRlpNcW0R5y4eQFo7lou3a2VsfQjYLgaCaXLKFYvPHc6ILWsSOArXpLBOCgYyCbUzmga5GSLwtt8dq6A7cxwpZTkNEgeiN7F0qdwEcq6NqjdBvvbiuUk2jyAcEiH5OA0+fWAZKZCJbYNtO4D6yc0ibFvZ7Lb88p2wm33uviIBNzNbcgmEyPzVC3uGKV2fT/EmPAuBHRU3Fvmkv2Y6IJ44DAhdWS7SvWBlgVNDV+jTDeAuwvzyQTQaBok4tJSLofEr7kYym9ADWgNdYRNujHsfeixAQVXQJHUqtuPw8ei8rC7owbaQ17adS2Sr0tRkqgnDzdC3Ec/zq90WDqaTnUzMS6MQ2CTHH/y2H0LSAuuP9i1GHxjT7Tk2H9eATj4yV8uGbgLucWmgyA2oDxArlY5f3QJuevDkx6ENls2KOUZ9Bkxa7mGnqOoLaKmlzZFrWD6LQ4RA==;5:RpzvKnhUCWP9ypnmE+3iK9XzAdfk5T/wLXNz2dA6BkU9jv5ewLnaXAonMAD5qhcK0ImQQ3RwvX13UeAEhm8Rbw0QnVSObvtz1xxIbhM7e7BmnzYke6Sp/auo6KRyMtBYtLmPOIgc3xG32ljBif0SVJ/ZL3Q/nb1ttPXYY9goqWo=;7:CTJCSM/azfgJJ8289PjW+9+D+4eHUgKLVhKiA6xNiLiTevv8UrOmeFk71AeButBJHTc3iV3qJOztmy+NEZGSx5cAPm6zjmYJkrvicl/lD/GCKVIm9rPpghiFaxaAXlLTk/R4rLuEHU6yH/69rZHU2w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fbffb383-efcd-48a8-1403-08d6410f8493
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0502MB3000;
x-ms-traffictypediagnostic: DB6PR0502MB3000:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-microsoft-antispam-prvs: <DB6PR0502MB30004739B90125BA6C4EFB70BECF0@DB6PR0502MB3000.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB6PR0502MB3000;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0502MB3000;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(376002)(136003)(199004)(189003)(110136005)(6486002)(54906003)(2201001)(6116002)(6436002)(446003)(316002)(26005)(105586002)(14454004)(86362001)(6512007)(2501003)(186003)(4326008)(71200400001)(2900100001)(5660300001)(478600001)(97736004)(107886003)(7736002)(6246003)(71190400001)(305945005)(8676002)(81166006)(81156014)(99286004)(39060400002)(53936002)(68736007)(25786009)(229853002)(2906002)(50226002)(66066001)(8936002)(106356001)(53546011)(486006)(6506007)(11346002)(76176011)(118296001)(14444005)(3846002)(256004)(2616005)(36756003)(102836004)(476003)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0502MB3000;H:DB6PR0502MB2901.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YYJc3XOvKaFacShEj7TZlVu6tFMEcSCduL/iZaK0KQQEoyUT9BQztdCpAfa3o4nC5VZi92CuBz+fssbJavGn0/gMRgERdmPK44hoOlSQ7TeNRSVSyJCQ6zIsVSla6crTc+CcZmdfC64H8QjAOhnViFRdCMNu9Z2JBFDc8HjX4lfGzmF+vqBIA79gyAlI5boBTL5J13g1WoTo0NkP4gJmuAB6j8kNKOB/YPxhHULaS+UZXh00nV8MLwbIvNAGxs7ppF3iLlfhrCfvKfp/OWJn3T0XoHz10YlsfYx1nFA7av7U/HQL8Uw88u3THR2eNCrDhAVBcaFG+xQ7Qep5+2oTly9dk6WtCfXJ8U8SUbNVIgE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE2A7BA9AE0993429F5915ED0B1D2D6F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbffb383-efcd-48a8-1403-08d6410f8493
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 22:07:02.1618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0502MB3000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTExLTAyIGF0IDE0OjM5IC0wNzAwLCBFcmljIER1bWF6ZXQgd3JvdGU6DQo+
IA0KPiBPbiAxMS8wMi8yMDE4IDAyOjA1IFBNLCBTYWVlZCBNYWhhbWVlZCB3cm90ZToNCj4gIA0K
PiA+IHRlbXAgd2lsbCBiZSBtZW0gY29waWVkIHRvIHByaXYtPnN0YXRzLnN3IGF0IHRoZSBlbmQs
DQo+ID4gbWVtY3B5KCZwcml2LT5zdGF0cy5zdywgJnMsIHNpemVvZihzKSk7IA0KPiA+IA0KPiA+
IG9uZSBvdGhlciB3YXkgdG8gc29sdmUgdGhpcyBhcyBzdWdnZXN0ZWQgYnkgQW5kcmV3LCBpcyB0
byBnZXQgcmlkDQo+ID4gb2YNCj4gPiB0aGUgdGVtcCB2YXIgYW5kIG1ha2UgaXQgcG9pbnQgZGly
ZWN0bHkgdG8gcHJpdi0+c3RhdHMuc3cgDQo+ID4gDQo+IA0KPiBXaGF0IGFib3V0IGNvbmN1cnJl
bmN5ID8NCj4gDQo+IFRoaXMgdGVtcCB2YXJpYWJsZSBpcyB0aGVyZSB0byBtYWtlIHN1cmUgY29u
Y3VycmVudCByZWFkZXJzIG9mIHN0YXRzDQo+IG1pZ2h0DQo+IG5vdCBzZWUgbWFuZ2xlIGRhdGEg
KGJlY2F1c2UgYW5vdGhlciAncmVhZGVyJyBqdXN0IGRpZCBhIG1lbXNldCgpIGFuZA0KPiBpcyBk
b2luZyB0aGUgZm9sZGluZykNCj4gDQo+IA0KPiBtbHg1ZV9nZXRfc3RhdHMoKSBjYW4gZGVmaW5p
dGVseSBiZSBydW4gYXQgdGhlIHNhbWUgdGltZSBieSBtdWx0aXBsZQ0KPiB0aHJlYWRzLg0KPiAN
Cg0KaG1tLCB5b3UgYXJlIHJpZ2h0LCBpIHdhcyB0aGlua2luZyB0aGF0IG1seDVlX2dldF9TdGF0
cyB3aWxsIHRyaWdnZXIgYQ0Kd29yayB0byB1cGRhdGUgc3RhdHMgYW5kIGdyYWIgdGhlIHN0YXRl
X2xvY2ssIGJ1dCBmb3Igc3cgc3RhdHMgdGhpcyBpcw0Kbm90IHRoZSBjYXNlIGl0IGlzIGRvbmUg
aW4gcGxhY2UuDQoNCkJUVyBtZW1jcHkgaXRzZWxmIGlzIG5vdCB0aHJlYWQgc2FmZS4NCg==

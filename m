Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2D9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8C520834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Mwxtrp9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8C520834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeK2VFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:05:14 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:3194 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeK2VFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:05:13 -0500
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="scan'208";a="20910078"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Nov 2018 03:00:25 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 29 Nov 2018 03:00:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWS2/PzdJuwrCYHzkYx8A+7YVvro5eJuRJ0ay16oQiU=;
 b=Mwxtrp9X98+9/6CHkphMurMv//5yW9o22uROxySrmGXoClUB/uOZ49+TnSiQBhran1oFs4dtVYN8+AMK8odog6M1uV+JtLi7IIja9QhMmIg3moz/GFEx7gA6ulfxfP4e3AMkmm9Lj66kyN7aBtNZHOJM4HTx/9IQjhlDilE7s74=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0680.namprd11.prod.outlook.com (10.163.111.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 29 Nov 2018 10:00:22 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1361.019; Thu, 29 Nov 2018
 10:00:22 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <brandon.streiff@ni.com>, <harini.katakam@xilinx.com>,
        <Nicolas.Ferre@microchip.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <harinikatakamlinux@gmail.com>
Subject: Re: [RFC PATCH] net: macb: Apply RXUBR workaround only to versions
 with errata
Thread-Topic: [RFC PATCH] net: macb: Apply RXUBR workaround only to versions
 with errata
Thread-Index: AQHUgxNAbu3Co8uTGEqCd0JItPQ7vKVltyuAgADXUoA=
Date:   Thu, 29 Nov 2018 10:00:22 +0000
Message-ID: <88ca959b-6fed-8afb-e433-6a21e17ec067@microchip.com>
References: <1542967157-8053-1-git-send-email-harini.katakam@xilinx.com>
 <5b550305-ff96-fdf6-883e-b6ae69ad3124@ni.com>
In-Reply-To: <5b550305-ff96-fdf6-883e-b6ae69ad3124@ni.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0226.eurprd07.prod.outlook.com
 (2603:10a6:802:58::29) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0680;6:ewJn0dde8b54wdOI/D4bJ9AElPQtwI9UYmr5CNu/3KZlU2dwALhNH8AzVZi8bSVGowEfTihYvCEDhAao0CdpC3Y8RFfGcXMBxF0Vin/nQEkbod40iE4tFWxPZ8hfijbfsIJeE2ar/Mq+TTaNbYbrcxI3jU/lC67u5yvOzz+QQru1LslFJXrjvGdulsbJtmmNT5Z5IV/Xp7ajY47qFiy1PK9EJxnSgPvUbukN8ds68/raigZzEbShEl9yPet2r4f4yA1oY9wKPSuQ+AdiHzIz5QqqGWs8OKc1Tc3KPJ+Wuw3yEIx23Teq2CIL2173WS37Z41KIZuDgBhGydcyJs6uRcF75PhwnNXuNKos9ChVornbslRovgQNsUfrBIdDKYfsnIOuzJM6aKGRHjjuhjWjx5v1beMc4JkO1dUJ8gZMOoNeLVifKVCcjZlLRcitAW6clUIboES48GuSCDRmtQi4Cs82idmOnKU4894F/fAYZ9g=;5:gfdR/raHJZQWCmcKU2Ck01994KVl7YNLnf7eeBKnqvNjHaUXtEZPzXUg5iiQJt0MtQFWFg3WwGFXB62Az/udl111HpXhM6G/q7/Ge90/3ha1YLBjN6SIH2Ow1cl8j+J2UgcUuu3VRwulVuC9oV8uE6R/cPgLPWTuKZlKFGzeOHs=;7:WLAtWtIg2y6kHc3OOtUjEJuJyxYcBl4/vqiY0prcM+zjJx4Dzq+7NEfu4nnMjMx1ngx9w48yKqdnpffz0Qi4wSucXsoyCVJrcuuDcFOwWflOzhdUGwlwsVhdmc1kfus4oGbsqSG+fteeBlI92iX2Tw==
x-ms-office365-filtering-correlation-id: 62bc00c8-f23d-4058-abdf-08d655e17a1a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0680;
x-ms-traffictypediagnostic: BY2PR11MB0680:
x-microsoft-antispam-prvs: <BY2PR11MB0680F14BE3EB03196C5DF58287D20@BY2PR11MB0680.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231453)(999002)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0680;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0680;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(396003)(366004)(189003)(199004)(966005)(3846002)(186003)(6116002)(6306002)(8676002)(81156014)(81166006)(229853002)(6512007)(7736002)(25786009)(256004)(76176011)(6506007)(53546011)(386003)(31696002)(71200400001)(8936002)(2906002)(71190400001)(86362001)(575784001)(36756003)(97736004)(52116002)(53936002)(99286004)(105586002)(102836004)(106356001)(11346002)(31686004)(2616005)(6436002)(26005)(486006)(478600001)(72206003)(39060400002)(66066001)(305945005)(14454004)(4326008)(446003)(476003)(6246003)(5660300001)(316002)(6486002)(68736007)(110136005)(54906003)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0680;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BECOmW7QIO3pHFBV0W0GnJgmIMlH+RRpcipUMmNDu7WriT3RLH60VPas5NVEcHBUm20M7oEnTm8ixTa5NNha9Y4CXTxBbCo0oA3ckzfCdwG2ic1UHEVi7g9D5QbjM1WCjyR2U3X72l1zOdf1WMksp7CTFJRfOcicuYvKCHkHktoJS4lxwkwG7NnXDBzjuSZuCQK1RUCGxc+wgCUwyzbTe8I6u7HBhARu9w1PZ5+RbRrvt3oaGKkIgz4BUlx9KCAOOkTNjNKuMgm2zSaJvJ4YpKgpriAW4DVOGYoirWfPHOT1Yq4CqOAfYcYJkR/0Z3Z1+kT9XpsnrHQJ9lIa0b9wTvfupyMIOP7ourUBk7zHHlk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D17F534876C74042ACEFFC664D5D1474@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bc00c8-f23d-4058-abdf-08d655e17a1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 10:00:22.6436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0680
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI4LjExLjIwMTggMjM6MDksIEJyYW5kb24gU3RyZWlmZiB3cm90ZToNCj4gT24gMTEv
MjMvMjAxOCAzOjU5IEFNLCBIYXJpbmkgS2F0YWthbSB3cm90ZToNCj4+ICsvKiBFcnJhdGEgbWFz
ayBiaXRzICovDQo+PiArI2RlZmluZSBNQUNCX0VSUkFUQV9SWExPQ0tVUAkJCTB4MDAwMDAwMDEN
Cj4+ICsNCj4+ICAvKiBMU08gc2V0dGluZ3MgKi8NCj4+ICAjZGVmaW5lIE1BQ0JfTFNPX1VGT19F
TkFCTEUJCQkweDAxDQo+PiAgI2RlZmluZSBNQUNCX0xTT19UU09fRU5BQkxFCQkJMHgwMg0KPj4g
QEAgLTEwODUsNiArMTA4OCw3IEBAIHN0cnVjdCBtYWNiX2NvbmZpZyB7DQo+PiAgCQkJICAgIHN0
cnVjdCBjbGsgKipyeF9jbGspOw0KPj4gIAlpbnQJKCppbml0KShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KTsNCj4+ICAJaW50CWp1bWJvX21heF9sZW47DQo+PiArCXUzMgllcnJhdGE7DQo+
PiAgfTsNCj4+ICANCj4+ICBzdHJ1Y3QgdHN1X2luY3Igew0KPj4gQEAgLTEyMTQsNiArMTIxOCw4
IEBAIHN0cnVjdCBtYWNiIHsNCj4+ICANCj4+ICAJaW50CXJ4X2JkX3JkX3ByZWZldGNoOw0KPj4g
IAlpbnQJdHhfYmRfcmRfcHJlZmV0Y2g7DQo+PiArDQo+PiArCXUzMiBlcnJhdGE7DQo+PiAgfTsN
Cj4gDQo+IEhpIEhhcmluaSwNCj4gDQo+IENvdWxkIHRoaXMgYmUgbWFkZSBpbnRvIHNpbXBsZXIg
YnkgaW5zdGVhZCBhZGRpbmcgYSBjYXBzIGJpdCwgbmFtZWQNCj4gKHBlcmhhcHMpIE1BQ0JfQ0FQ
U19CVUdHWV9SWFVCUiBvciBNQUNCX0NBUFNfTkVFRFNfUlhVQlJfUkVTRVRTIG9yDQo+IHNvbWV0
aGluZz8NCj4gDQo+IFRoYXQgd291bGQgc2F2ZSBuZWVkaW5nIHRvIGFkZCBhIG5ldyB1MzIgZmll
bGQgaW50byB0aGUgbWFjYl9jb25maWcgYW5kDQo+IG1hY2Igc3RydWN0cyAoYm90aCBvZiB3aGlj
aCBhbHJlYWR5IGhhdmUgdGhpcyBjYXBzIGZpZWxkKS4NCj4gDQoNCkkgYXZvaWQgZHVwbGljYXRp
bmcgdGhlc2UgZmllbGRzIGZyb20gc3RydWN0IG1hY2JfY29uZmlnIHRvIHN0cnVjdCBtYWNiIEkN
CndvdWxkIHN0YXJ0IHRvIG1vdmUgbWFjYl9jb25maWcgcGFydCBvZiBzdHJ1Y3QgbWFjYiBhcyBh
IGNvbnN0ICogbWVtYmVyDQooc2VlIFsxXSkuDQoNCg0KWzFdDQpodHRwczovL2dpdGh1Yi5jb20v
bGludXg0c2FtL2xpbnV4LWF0OTEvY29tbWl0LzhjNTg4MTM2MTg5MTQ4ZDc5YzQwNzhjNTVkYTIy
NDJhMmJhMmI4ZDMjZGlmZi05MjFjODM5ZGJhNDM5ZmQ1MDJhMjRhZWQwODQ1ZGM5ZA0K

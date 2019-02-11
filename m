Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7497CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0668121B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="IFdkaYVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfBKNfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:35:34 -0500
Received: from mail-eopbgr40105.outbound.protection.outlook.com ([40.107.4.105]:6335
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727601AbfBKNfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:35:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t73Y36bxIda6aa5OdWxHKrRcDRuPmhi/NtlpjAbm0Ew=;
 b=IFdkaYVbeFyarem1O/H5c/q9yqYaEb3G9WbKae3dgHEpvTJkiIh+IBtZ8xuPh9hhotgqb+3Zd3Qdcv9p+83eC5fdw//z+qIgULgH5/4TNxZ83uXCnllyn4atyfIaMe8zYKdlXTSx2TutbnpC6C/upZzTHjPsE2XaK4Wesf81oOc=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1SPR8PMB101.eurprd02.prod.outlook.com (10.163.248.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Mon, 11 Feb 2019 13:35:15 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590%5]) with mapi id 15.20.1601.023; Mon, 11 Feb 2019
 13:35:15 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "federico.vaga@cern.ch" <federico.vaga@cern.ch>
CC:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] i2c:ocores: add polling interface
Thread-Topic: [PATCH v4 3/5] i2c:ocores: add polling interface
Thread-Index: AQHUweRLTUHUnAuDmkmFf4LpKz4VZ6XaekoAgAAZgYCAAAWkAA==
Date:   Mon, 11 Feb 2019 13:35:15 +0000
Message-ID: <5bc1757a-3b74-5c77-7c39-00c2513683a1@axentia.se>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
 <20190211083122.32485-4-federico.vaga@cern.ch>
 <7ef62069-3ce1-2c31-b64e-3a5d045990e5@axentia.se>
 <1845501.4feNL5aF6H@pcbe13614>
In-Reply-To: <1845501.4feNL5aF6H@pcbe13614>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1P189CA0018.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::31)
 To VI1PR02MB4542.eurprd02.prod.outlook.com (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1SPR8PMB101;6:sz2fy3grsdLAMOfXASELKaVoREQ7gi6kw9aRjAPn5GWsSRwUSvBWwqKo8wrpaZKBQSEcwa4vMN5LvPkzKRoBCi7qk3ajUVYx70k+0a60m367+lRUlhZMb8gom+E/5EqltgVAO3m5OjyH6zn5sYQYw5GyPWCSAM0EAxevlaAKNVoJVc8IwDax4qrhQtGAZHLdNyN6wAy8FOV+VSSl5g986S+7P3eMaw7yIIST0/9jrd0gG9Q9cEkCbavMqqNskmprP76ZY0WX/mCUFF1Kd2QoWUOioVqlI83Ex3fTDLpUXok+l6BMmhd8nzfKJrnXP98NTRnT2GWMOqDqceCvFJWCXUbwfUC5Y/epMzpJZPVMQ6r8y0H8r8rW9N55hJNZNqrCzi8PcqNkTLA4fhCBXfDKGC3lMro13fVZXmktvFkMnUOLChgg1vZ/GStUUBFFw6xFDDhl/dHGzbOL0ythhMxJ6g==;5:frmm6TX1I9EZMyXMXZT1DKVYu4cddgmpW/4e8KrbrwyMo79qZ3dQv1gpPOgwKXimD3uGWE4U3H2lqTJMUel8d7wNfUZJ3cw02qffAKRNTkee6LWne2BMed6ci7ShX+V23spHgjafhRJxaAt2PC3MxpMtrkegjATlaP0DqwPlW6+tToxZlQAeOB7uIIPZOmB0z+iAYwen9evbvgMesfp4vA==;7:xJEya7cAyMWEzN21QWwbjRBeosobt3I1oJDIl7R7Rb351vCpbXSJ43OluF9Ruzs+LLx7zSgA2bxgUc4zdzOLa6/2gTe+ZJvQQZJhdMPve0eC+hj6fdcBMjtg7ROC5olwKHL/QxTSoqd7os522X5MMg==
x-ms-office365-filtering-correlation-id: 9d020a92-0da7-4d14-3e66-08d69025c14a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:VI1SPR8PMB101;
x-ms-traffictypediagnostic: VI1SPR8PMB101:
x-microsoft-antispam-prvs: <VI1SPR8PMB10150AD7CA782D8D76ACE69BC640@VI1SPR8PMB101.eurprd02.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(136003)(39830400003)(189003)(199004)(6486002)(105586002)(7736002)(305945005)(65826007)(6512007)(106356001)(5640700003)(6436002)(6916009)(2501003)(508600001)(14454004)(229853002)(2351001)(4326008)(53936002)(81156014)(74482002)(6246003)(81166006)(25786009)(8676002)(66066001)(65956001)(65806001)(256004)(14444005)(93886005)(102836004)(386003)(486006)(64126003)(2906002)(8936002)(186003)(31696002)(36756003)(31686004)(97736004)(476003)(6506007)(26005)(76176011)(316002)(54906003)(6116002)(58126008)(3846002)(68736007)(86362001)(52116002)(2616005)(11346002)(446003)(99286004)(71200400001)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1SPR8PMB101;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a+r0Q2lndLWRjbsZlYUYmRtG1rdsQCb7mWSFkJ+h2vI6c4V2M+6ijpJ6cRLSPYENwAQ8I+umMG6b0OYhw1J1HJXHxSsCNcHsdNQsK8lSZPNEyF5bSFqu+l7OmKAi74/k07VJODIS7WhvozACvvDiKWPtLN96ftJfliDJug92UCQFGbjE50JDuZLqWB7ZWszBYNOX5ht8sEcAx1Dji718oa61rCwN6DVvSz7pZf814a5hapRFAEJ4/HV2OPv0FdlailMK2aKpmPtlhdcuSCvWTZPBddquUCKpS/IikIgXw6VVm5+PwPa0KvdV8gmCub/TnCIAnKh7IQgqO9hRPe+rws7Zx7WpXpy6YATqOnYMTyDk1KK1T0Dq0+c0HtIlib/0zDBPUlp3SqSefKpIqtbHVoIqpInjSxQGKTr4VcyM6zs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5F2060185D8C941B87CEA1ABC202A40@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d020a92-0da7-4d14-3e66-08d69025c14a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 13:35:13.6402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR8PMB101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+IEBAIC0yOTQsNyArNDI3LDcgQEAgc3RhdGljIGludCBvY29yZXNfaW5pdChzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdA0KPj4+IG9jb3Jlc19pMmMgKmkyYykNCj4+DQo+Pj4gIA0KPj4+ICAN
Cj4+PiAgCS8qIEluaXQgdGhlIGRldmljZSAqLw0KPj4+ICAJb2Nfc2V0cmVnKGkyYywgT0NJMkNf
Q01ELCBPQ0kyQ19DTURfSUFDSyk7DQo+Pj4NCj4+PiAtCW9jX3NldHJlZyhpMmMsIE9DSTJDX0NP
TlRST0wsIGN0cmwgfCBPQ0kyQ19DVFJMX0lFTiB8IE9DSTJDX0NUUkxfRU4pOw0KPj4+ICsJb2Nf
c2V0cmVnKGkyYywgT0NJMkNfQ09OVFJPTCwgY3RybCB8IE9DSTJDX0NUUkxfRU4pOw0KPj4NCj4+
DQo+PiBZb3UgZml4IHRoaXMgdXAgaW4gcGF0Y2ggNSAoaW4gd2hhdCBpcyBwZXJoYXBzIGNhcmVs
ZXNzbHkgbWFya2V0ZWQgYXMNCj4+IGZpeGVzIGZvciBtaW5vciBjaGVja3BhdGNoIGlzc3Vlcyks
IGJ1dCBmb3IgdGhpcyBwYXRjaCB5b3UgYXJlIGFjdHVhbGx5DQo+PiBubyBsb25nZXIgbWFraW5n
IHN1cmUgdGhhdCB5b3UgY2xlYXIgdGhlIE9DSTJDX0NUUkxfSUVOIGJpdCBhcyB0aGUgY29kZQ0K
Pj4gdXNlZCB0byBiZWZvcmUgdGhpcyBwYXRjaC4gSSB0aGluayB5b3UgaW50ZW5kZWQgdG8gcHJl
c2VydmUgdGhhdA0KPj4gYmVoYXZpb3IsIG5vPw0KPiANCj4gSSB0aGluayB5b3UgZ290IGNvbmZ1
c2VkIGJ5IHRoZSB0d28gcGF0Y2hlcyBiZWNhdXNlIHRob3NlIGxpbmVzIGxvb2sgdmVyeSANCj4g
c2ltaWxhci4NCj4gDQo+IEluIFBBVENIIDUgd2hhdCB5b3Ugc2VlIGlzIHRoZSAic3R5bGUgZml4
IiB0byBjbGVhciBFTiBhbmQgSUVOIGJlZm9yZSBjbG9jayANCj4gY29uZmlndXJhdGlvbg0KPiAN
Cj4gaW4gUEFUQ0ggMyAodGhpcyBvbmUpIHdoYXQgeW91IHNlZSBpcyB3aGVuIGxhdGVyIChzYW1l
IGZ1bmN0aW9uLCBhZnRlciBjbG9jayANCj4gY29uZmlndXJhdGlvbikgdGhlIGRldmljZSBpcyBy
ZS1lbmFibGVkIChFTiksIGJ1dCB3aXRob3V0IGVuYWJsaW5nIHRoZSANCj4gaW50ZXJydXB0IGJl
Y2F1c2Ugb24gcG9sbGluZyBjb25maWd1cmF0aW9uIHdlIGRvIG5vdCB3YW50IHRvIHNlZSBpbnRl
cnJ1cHQgDQo+IGZsb3dpbmcuDQo+IA0KPiBTbywgdGhlIGJlaGF2aW9yIGlzIHByZXNlcnZlZCBm
b3Igd2hhdCBjb25jZXJuIGNsZWFyaW5nIHRoZSBJRU4gYml0IGJlZm9yZSANCj4gY2xvY2sgY29u
ZmlndXJhdGlvbi4NCj4gDQo+IGFtIEkgd3Jvbmc/DQoNCk5vLCBJIGRvbid0IHRoaW5rIEknbSBj
b25mdXNlZCBhbmQgSSB0aGluayB5b3UgYXJlIHdyb25nLiBDdXJyZW50IGNvZGUgZG9lcw0KdGhp
czoNCg0KCXU4IGN0cmwgPSBvY19nZXRyZWcoaTJjLCBPQ0kyQ19DT05UUk9MKTsNCg0KCS8qIG1h
a2Ugc3VyZSB0aGUgZGV2aWNlIGlzIGRpc2FibGVkICovDQoJb2Nfc2V0cmVnKGkyYywgT0NJMkNf
Q09OVFJPTCwgY3RybCAmIH4oT0NJMkNfQ1RSTF9JRU58T0NJMkNfQ1RSTF9FTikpOw0KCS4uLg0K
CW9jX3NldHJlZyhpMmMsIE9DSTJDX0NPTlRST0wsIGN0cmwgfCBPQ0kyQ19DVFJMX0lFTiB8IE9D
STJDX0NUUkxfRU4pKTsNCg0KSGVyZSwgdGhlIGZpbmFsIG9jX3NldHJlZyBhbHdheXMgc2V0cyBP
Q0kyQ19DVFJMX0lFTi4NCg0KDQpQYXRjaCAzIGNoYW5nZXMgaXQgdG86DQoNCgl1OCBjdHJsID0g
b2NfZ2V0cmVnKGkyYywgT0NJMkNfQ09OVFJPTCk7DQoNCgkvKiBtYWtlIHN1cmUgdGhlIGRldmlj
ZSBpcyBkaXNhYmxlZCAqLw0KCW9jX3NldHJlZyhpMmMsIE9DSTJDX0NPTlRST0wsIGN0cmwgJiB+
KE9DSTJDX0NUUkxfSUVOfE9DSTJDX0NUUkxfRU4pKTsNCgkuLi4NCglvY19zZXRyZWcoaTJjLCBP
Q0kyQ19DT05UUk9MLCBjdHJsIHwgT0NJMkNfQ1RSTF9FTikpOw0KDQpIZXJlLCB0aGUgZmluYWwg
b2Nfc2V0cmVnIHJlc3RvcmVzIE9DSTJDX0NUUkxfSUVOIHRvIHdoYXRldmVyIGl0IHdhcw0KYXQg
ZnVuY3Rpb24gZW50cnkuDQoNCg0KQW5kIHBhdGNoIDUgY2hhbmdlcyBpdCBhZ2FpbiB0bzoNCg0K
CXU4IGN0cmwgPSBvY19nZXRyZWcoaTJjLCBPQ0kyQ19DT05UUk9MKTsNCg0KCS8qIG1ha2Ugc3Vy
ZSB0aGUgZGV2aWNlIGlzIGRpc2FibGVkICovDQoJY3RybCAmPSB+KE9DSTJDX0NUUkxfSUVOIHwg
T0NJMkNfQ1RSTF9FTik7DQoJb2Nfc2V0cmVnKGkyYywgT0NJMkNfQ09OVFJPTCwgY3RybCk7DQoJ
Li4uDQoJb2Nfc2V0cmVnKGkyYywgT0NJMkNfQ09OVFJPTCwgY3RybCB8IE9DSTJDX0NUUkxfRU4p
KTsNCg0KSGVyZSwgdGhlIGZpbmFsIG9jX3NldHJlZyBrZWVwcyBPQ0kyQ19DVFJMX0lFTiBjbGVh
cmVkLiBJIHRoaW5rIHlvdSB3YW50ZWQNCnRoaXMgZGV0ZXJtaW5pc3RpYyBiZWhhdmlvciBmb3Ig
cGF0Y2ggMyBhcyB3ZWxsLg0KDQpDaGVlcnMsDQpQZXRlcg0K

Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE507C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853992084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="uUndKzpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853992084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbeLJWDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:03:15 -0500
Received: from mail-eopbgr40091.outbound.protection.outlook.com ([40.107.4.91]:20475
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727405AbeLJWDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIhZ/gmxiCBsK4w03Gr+V0m+oygNxiWSzsaRJMB8Xug=;
 b=uUndKzpBi+8DAbwEgGwj11K8shwy41jVzdNiWhAqoQT8B1xqTVccBuO5SNF8wIUj9TXzBUhCHpGZk7tPa6Dzm+oq0FWiNHgFNwHFUgi/Lf7PsGriTLdLThxFyrc5glcZMETLubLMSLIRRhSPGCVTGFKRFk5r1dYy8rUa+i1RWvU=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB4511.eurprd02.prod.outlook.com (20.178.12.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.20; Mon, 10 Dec 2018 22:03:09 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::b:49a6:411a:6a39%3]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 22:03:09 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT 01/10] i2c: add 'is_suspended' flag for i2c adapters
Thread-Topic: [RFC/RFT 01/10] i2c: add 'is_suspended' flag for i2c adapters
Thread-Index: AQHUkMv4GPStz0vv3EaV20zFHvdhyqV4hqkA
Date:   Mon, 10 Dec 2018 22:03:09 +0000
Message-ID: <a4fdd7f1-be79-48fd-0d13-410276962384@axentia.se>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181210210310.12677-2-wsa+renesas@sang-engineering.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR07CA0046.eurprd07.prod.outlook.com
 (2603:10a6:7:66::32) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB4511;6:oaYVhTpAzAExfN+DqJSuR1cyeNzfaPxWS2FnpW0CkUHkbO2hICiZhOLVQlBBxDJQGpGFMz635DfMQPJ2Qe1waZbh711YRXN5eK7Q1EZGV4cHchX6JGD6sgeqV5S1YaMAUBHKOV9Lk3G94G2NzqSoC7mmbicWK2i7nCBo2vNTdpwMJOcTjKjUC37F4afDj/uuBDmiy24i0OSk58f4tzIAJTX+1hNSucMo6DepHfBzeI0aCmeaG5FP8PrfRxDTxD6I1n45h47c4d7QQDPFN2YQAJFRnCOVm7JvHj8SqSUd96FN05l411Ql6N4XxPRzDl0R+cDiRxYUoxgcfEEmpJ6BWDw0DozCVndIMEv0L+Jmsgw7Abv8R0DCQqUsQ3YUELh9o+USRIqXRpbkCH9qTeH2sKTousmFVDWhf7vyxNM019Oj8TQBO6zCaa3Z0er0mWI/D/RhmSjPqfddaiePW0DaLA==;5:p4i8VMK6x4qP7AgJIG/LhuJlWO1Ns4dAy+LL89Epk4DQTJDbu3keSctHv7nne2IE6wKYjLJa7Lqw9Ib1PYZKxCbqHJRKIRZOupEGNKATjzWumJXLPps3yOZeACgohySTtX4PRMAaugLt30dwkOccz9gLJqknp7L3KId5TrQvG+w=;7:DskFJ55wY0OGRx3uey9dLfBpxMAyRWL4xjdXd090rI46K0bIl+2IxPf2VGlfamXkobjZwqNhjwGUQCpNjhIlrKuHjyOE7nlW5o+hSbAz5ZjrK/hR1LYARzcbYJNoODQQXe06xiWcftw+bAQNKzcD7g==
x-ms-office365-filtering-correlation-id: c0c2ecc5-d2aa-4350-04c1-08d65eeb4554
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4511;
x-ms-traffictypediagnostic: VI1PR02MB4511:
x-microsoft-antispam-prvs: <VI1PR02MB4511DB31A59D28B3DA36987FBCA50@VI1PR02MB4511.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231472)(944501520)(52105112)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB4511;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB4511;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(39830400003)(376002)(346002)(199004)(189003)(14444005)(6506007)(446003)(2616005)(229853002)(65806001)(53546011)(186003)(76176011)(68736007)(102836004)(65956001)(66066001)(486006)(11346002)(2501003)(52116002)(64126003)(99286004)(476003)(386003)(26005)(53936002)(6512007)(6116002)(3846002)(256004)(14454004)(4326008)(105586002)(31686004)(106356001)(7736002)(8936002)(4001150100001)(305945005)(36756003)(97736004)(5660300001)(6246003)(81166006)(74482002)(2906002)(81156014)(86362001)(25786009)(575784001)(8676002)(58126008)(316002)(54906003)(71190400001)(110136005)(71200400001)(6436002)(31696002)(508600001)(6486002)(65826007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4511;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xMAw1DpD8TQqasCPdZZOcdbtENaTKrNUTK+euGEKve7/kWB8JkUX+FKJMjQnla1RYTBDs84m9LQeUX+KuYnXV3oXRRyJE5ZPNUht0+fjxUhWACXzOnjotSY5L1uWNben06BiiL8BmCpn1ju+UM+9z6h+ggDLUr2upBDn3nMwNb3wEqo9kDml6lZroe5ngmSLaa6urxoUSe6QTMCMBBlwG6a1CvnVkStcsGGvb6D6Wyr7ImLS7oktYBgmWv291EEzErCmHAm/oMTNW1SSsjT5R4VOKA9LZ1eosZLhrrvT2/HVxKgYFyx6ZghAqk1k9KC0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B06DF676AEA734FB34D0ED6F8043D42@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c2ecc5-d2aa-4350-04c1-08d65eeb4554
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 22:03:09.6325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOC0xMi0xMCAyMjowMiwgV29sZnJhbSBTYW5nIHdyb3RlOg0KPiBTb21lIGRyaXZlcnMg
b3BlbiBjb2RlIGhhbmRsaW5nIG9mIHN1c3BlbmRlZCBhZGFwdGVycy4gSXQgc2hvdWxkIGJlDQo+
IGhhbmRsZWQgYnkgdGhlIGNvcmUsIHRob3VnaCwgdG8gZW5zdXJlIGdlbmVyaWMgaGFuZGxpbmcu
IFRoaXMgcGF0Y2ggYWRkcw0KPiB0aGUgZmxhZyBhbmQgYW4gYWNjZXNzb3IgZnVuY3Rpb24uDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBXb2xmcmFtIFNhbmcgPHdzYStyZW5lc2FzQHNhbmctZW5naW5l
ZXJpbmcuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaTJjL2kyYy1jb3JlLWJhc2UuYyB8IDEgKw0K
PiAgaW5jbHVkZS9saW51eC9pMmMuaCAgICAgICAgIHwgOSArKysrKysrKysNCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJj
L2kyYy1jb3JlLWJhc2UuYyBiL2RyaXZlcnMvaTJjL2kyYy1jb3JlLWJhc2UuYw0KPiBpbmRleCAy
ODQ2MGY2YTYwY2MuLjlmODllMjU4YzhmZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pMmMvaTJj
LWNvcmUtYmFzZS5jDQo+ICsrKyBiL2RyaXZlcnMvaTJjL2kyYy1jb3JlLWJhc2UuYw0KPiBAQCAt
MTIzMiw2ICsxMjMyLDcgQEAgc3RhdGljIGludCBpMmNfcmVnaXN0ZXJfYWRhcHRlcihzdHJ1Y3Qg
aTJjX2FkYXB0ZXIgKmFkYXApDQo+ICAJaWYgKCFhZGFwLT5sb2NrX29wcykNCj4gIAkJYWRhcC0+
bG9ja19vcHMgPSAmaTJjX2FkYXB0ZXJfbG9ja19vcHM7DQo+ICANCj4gKwlhZGFwLT5pc19zdXNw
ZW5kZWQgPSBmYWxzZTsNCj4gIAlydF9tdXRleF9pbml0KCZhZGFwLT5idXNfbG9jayk7DQo+ICAJ
cnRfbXV0ZXhfaW5pdCgmYWRhcC0+bXV4X2xvY2spOw0KPiAgCW11dGV4X2luaXQoJmFkYXAtPnVz
ZXJzcGFjZV9jbGllbnRzX2xvY2spOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pMmMu
aCBiL2luY2x1ZGUvbGludXgvaTJjLmgNCj4gaW5kZXggNjViNGVhZWQxZDk2Li45ODUyMDM4ZWUz
YTcgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvaTJjLmgNCj4gKysrIGIvaW5jbHVkZS9s
aW51eC9pMmMuaA0KPiBAQCAtNjgwLDYgKzY4MCw3IEBAIHN0cnVjdCBpMmNfYWRhcHRlciB7DQo+
ICAJaW50IHRpbWVvdXQ7CQkJLyogaW4gamlmZmllcyAqLw0KPiAgCWludCByZXRyaWVzOw0KPiAg
CXN0cnVjdCBkZXZpY2UgZGV2OwkJLyogdGhlIGFkYXB0ZXIgZGV2aWNlICovDQo+ICsJdW5zaWdu
ZWQgaW50IGlzX3N1c3BlbmRlZDoxOwkvKiBvd25lZCBieSB0aGUgSTJDIGNvcmUgKi8NCg0KV2hl
biBtb3JlIHN0dWZmIGlzIGFkZGVkIHRvIHRoaXMgYml0IGZpZWxkICh3aGljaCBhbHdheXMgaGFw
cGVucyBhdA0Kc29tZSBwb2ludCkgdXBkYXRlcyB0byBhbGwgbWVtYmVycyBvZiB0aGUgYml0IGZp
ZWxkIHdpbGwgaGF2ZSB0byB1c2UNCnRoZSBzYW1lIHJvb3QtYWRhcHRlci1sb2NraW5nLCBvciB3
ZSB3aWxsIHN1ZmZlciBmcm9tIFJNVy1yYWNlcy4gU28NCnRoaXMgZmVlbHMgbGlrZSBhbiBpbnZp
dGF0aW9uIGZvciBmdXR1cmUgZGlzYXN0ZXIuIE1heWJlIGEgY29tbWVudA0KYWJvdXQgdGhhdCB0
byByZW1pbmQgb3VyIGZ1dHVyZSBzZWx2ZXM/IE9yIHBlcmhhcHMgdGhlIGJpdCBmaWVsZA0Kc2hv
dWxkIGJlIGF2b2lkZWQgYWx0b2dldGhlcj8NCg0KQ2hlZXJzLA0KUGV0ZXINCg0KPiAgDQo+ICAJ
aW50IG5yOw0KPiAgCWNoYXIgbmFtZVs0OF07DQo+IEBAIC03NjIsNiArNzYzLDE0IEBAIGkyY191
bmxvY2tfYnVzKHN0cnVjdCBpMmNfYWRhcHRlciAqYWRhcHRlciwgdW5zaWduZWQgaW50IGZsYWdz
KQ0KPiAgCWFkYXB0ZXItPmxvY2tfb3BzLT51bmxvY2tfYnVzKGFkYXB0ZXIsIGZsYWdzKTsNCj4g
IH0NCj4gIA0KPiArc3RhdGljIGlubGluZSB2b2lkIGkyY19tYXJrX2FkYXB0ZXJfc3VzcGVuZGVk
KHN0cnVjdCBpMmNfYWRhcHRlciAqYWRhcCwNCj4gKwkJCQkJICAgICAgYm9vbCBzdXNwZW5kZWQp
DQo+ICt7DQo+ICsJaTJjX2xvY2tfYnVzKGFkYXAsIEkyQ19MT0NLX1JPT1RfQURBUFRFUik7DQo+
ICsJYWRhcC0+aXNfc3VzcGVuZGVkID0gc3VzcGVuZGVkOw0KPiArCWkyY191bmxvY2tfYnVzKGFk
YXAsIEkyQ19MT0NLX1JPT1RfQURBUFRFUik7DQo+ICt9DQo+ICsNCj4gIC8qZmxhZ3MgZm9yIHRo
ZSBjbGllbnQgc3RydWN0OiAqLw0KPiAgI2RlZmluZSBJMkNfQ0xJRU5UX1BFQwkJMHgwNAkvKiBV
c2UgUGFja2V0IEVycm9yIENoZWNraW5nICovDQo+ICAjZGVmaW5lIEkyQ19DTElFTlRfVEVOCQkw
eDEwCS8qIHdlIGhhdmUgYSB0ZW4gYml0IGNoaXAgYWRkcmVzcyAqLw0KPiANCg0K

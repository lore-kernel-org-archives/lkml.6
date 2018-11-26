Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D14EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E8D20862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T9ykqtcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E8D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbeKZWrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:47:17 -0500
Received: from mail-eopbgr130079.outbound.protection.outlook.com ([40.107.13.79]:34976
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbeKZWrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:47:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN5PCz6kfTHCNALxy5fhbT8UAE1o95fEeItIRBRc5xI=;
 b=T9ykqtcT+RteclHBTpBpxoglIEBI2k8NVJnRcxNrwdG2vr4X2G+yhMcoMNur/5ZsG4NYaoe/sIUX44yMWbFr7JUk7R1ihNOxzhtGp2TI/6+xTXKtR2ot9YoblkWZH1WFP7tVhlcZvHjMRhbqhYWRhLxrO+FwhQ11eJEpLeTgBpA=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5453.eurprd04.prod.outlook.com (20.178.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Mon, 26 Nov 2018 11:53:18 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547%5]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 11:53:18 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        Andy Duan <fugang.duan@nxp.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: imx6sx uart failing loopback tests with sdma firmware (ROM works)
Thread-Topic: imx6sx uart failing loopback tests with sdma firmware (ROM
 works)
Thread-Index: AQHUhX6fudZ5Qa2IqEK64USekwGKUw==
Date:   Mon, 26 Nov 2018 11:53:18 +0000
Message-ID: <6d8280df85c6e5b2ddba635780cd2912d9c5d425.camel@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5453;6:wCc8lyT4EJo/rYgpVgtxZljtlA+TCrrIM4wha5GGEbFYNotgZ7M2kl6kOUuyIuhjhAfB1lrUwdAkROrs9EIWBG7UQJ8+AYMyC4OnAOuaLmKb2P7gqPTgDfFouA+WCYMYez75oVrTdUDEhDVgj+JLMFVZXbOJQ1f3BubD/Jan2KjznVOfQJzalJbEs1E+O0ynbm2rv9pAPRKmsjjjZvEeStXCFc0/dd75YNu76LegjMijwlz30lmjtBJKOJ/LPlYNCeeqdIV4U3Q97O6QHSNkK7XkVPbRx4hYpd1s5fKbYaI4Op1We1w9mkymQdDLud5eTwGDU3Oy/zpBQnrw4+Pm8HCkapeJfcs2Cdfyjt6PwDzpEmPi28ozXJOGndHpBsbaqKEc3fm5/shabHbIIjOcSYCl11rszRZK3CL+ZiPyWCZWIYuDfobOYGuBjXRs1KtxNpvDfcZAZfMS42tg+EIAnw==;5:ZoWgj7hMkJMUesd0Gzh17LUFGv53q5YLWjx/npl0/uBUszQ2HMJ/7kK+wliWBuBWPVz4spKUYjzqvy6hk6YRiV9Wlb0W5S9zFRiVJNsxg7lnoKTFmC3u0Iigh3juZhDeGfcyBFZPGKDTte5XKM1rdgnMGJoaj+dG+aC/3z4/U0M=;7:c4npTu1VBLSXt4Q3BkrqtNhmKRLXFBo1NJ+9aHlH8v/ShG7sd5x5b2eRd2ZtVqxlno9V6A17WAG+1IX82uvB7mOqAFsTGSYI6RE0hW0jbqaYrUoLCaJXW4f404Jxd0ruCweqiCn5wnajNOFhP2ji1Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0f81e00f-3bfc-4fe4-f800-08d65395c1ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5453;
x-ms-traffictypediagnostic: VI1PR04MB5453:
x-microsoft-antispam-prvs: <VI1PR04MB5453B811FECF63DC6E940241EED70@VI1PR04MB5453.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231443)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5453;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5453;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(136003)(39860400002)(189003)(199004)(6506007)(305945005)(316002)(99286004)(110136005)(102836004)(54906003)(7736002)(6306002)(3846002)(6512007)(25786009)(53936002)(14444005)(256004)(2501003)(2616005)(44832011)(486006)(71200400001)(71190400001)(2906002)(6636002)(6116002)(6486002)(36756003)(6436002)(106356001)(105586002)(575784001)(5660300001)(86362001)(26005)(118296001)(186003)(66066001)(478600001)(14454004)(966005)(8936002)(8676002)(81156014)(81166006)(50226002)(68736007)(476003)(4326008)(97736004)(99106002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5453;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hXtcctm0NoR2YfeiCvcUfXO1lwZHJ8oH8msw7H703qMlV7a8hIEeIXtMaC1UT5R0vwxMgdtnwGfgJ0Intsf4pcsuZCdzVCYy8OfUrOE/miPGVLm1bf2IxWFUMr1gp+6HICmEwQvL1OJlGa6EAjAgcVJlvtVqxbeRBcsgDnYeTDHX45SjXvGQGKyPvcz/32uKWBpjEJ9weK21dA6R6ARcgwrLLTezqtGhRWNQXPQRemnYC2zHqjHKB9nDyWeZoa0sDh36kdj5/f7gj0ox913L334+U+gjocNbSInQJZ3KP+LHdws2QQMkxDFsO+tLMiqgFlrH7c0a/bSwkqIYUbBSPt1/dMvhTC4OjMrc1Vd7CsE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <008117BBEC490F4DABC9F492D0038EDA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f81e00f-3bfc-4fe4-f800-08d65395c1ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 11:53:18.3134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCk9uIGEgYnVpbGQgZmFybSBhdCBOWFAgd2UgZm91bmQgdGhhdCBsaW51eC1uZXh0
IG5vdyBmYWlscyBvbiBzaW1wbGUNCmxvb3BiYWNrIHRlc3RzIG9uIGlteDZzeC1zZGIgKGJ1dCBu
b3Qgb3RoZXIgU09DcyBBRkFJQ1QpLiBJIHRyYWNrZWQNCnRoaXMgZG93biB0byBjb21taXQgMzBm
ZGQ1MWJlMTYxDQooIkFSTTogaW14X3Y2X3Y3X2RlZmNvbmZpZzogYWRkIENPTkZJR19GV19MT0FE
RVJfVVNFUl9IRUxQRVIiKQ0KDQpBbGwgdGhhdCBkb2VzIGlzIGVuYWJsZSBsb2FkaW5nIFNETUEg
ZmlybXdhcmUgZnJvbSByb290ZnMsIGluIHRoZW9yeQ0KdGhpcyBjb25maWcgd2FzIGFsd2F5cyBz
dXBwb3J0ZWQgc28gaXQgd291bGQgbm90IGJlIGEgbmV3IGJ1Zy4NCg0KVGhpcyBkb2Vzbid0IGhh
cHBlbiB3aXRoIHRoZSBOWFAgdmVuZG9yIHRyZWUgYnV0IHRoZXJlIGlzIHF1aXRlIGEgbGFyZ2UN
CmRlbHRhIGluIHVhcnQgZG1hIGNvZGUuIEluIHBhcnRpY3VsYXIgdXBzdHJlYW0gZHJvcHBlZCBJ
RERNQUVOIGNsYWltaW5nDQp0aGF0IHRoaXMgd29ya3Mgd2l0aCBib3RoIFJPTSBhbmQgRlcgc2Ny
aXB0cywgc2VlIGNvbW1pdCA5MDVjMGRlY2FkMjgNCigic2VyaWFsOiBpbXg6IGRvbid0IHVzZSBp
ZGxlIGNvbmRpdGlvbiBkZXRlY3QgZm9yIERNQSB0cmFuc2ZlcnMiKQ0KDQpUaGlzIGRvZXNuJ3Qg
c2VlbSB0byB3b3JrIG9uIDZzeCB0aG91Z2ggYW5kIEkgZG9uJ3Qga25vdyB3aHkgOigNCg0KVGhl
IGlzc3VlIGNhbiBiZSB3b3JrZWQtYXJvdW5kIGJ5IGZvcmNpbmcgUlggc2NyaXB0IGZyb20gUk9N
Og0KDQpkaWZmIC0tZ2l0IGRyaXZlcnMvZG1hL2lteC1zZG1hLmMgZHJpdmVycy9kbWEvaW14LXNk
bWEuYw0KQEAgLTg5NCw5ICs4OTQsMTEgQEAgc3RhdGljIHZvaWQgc2RtYV9nZXRfcGMoc3RydWN0
IHNkbWFfY2hhbm5lbCAqc2RtYWMsDQogICAgICAgICAgICAgICAgYnJlYWs7DQogICAgICAgIGNh
c2UgSU1YX0RNQVRZUEVfVUFSVDoNCi0gICAgICAgICAgICAgICBwZXJfMl9lbWkgPSBzZG1hLT5z
Y3JpcHRfYWRkcnMtPnVhcnRfMl9tY3VfYWRkcjsNCisgICAgICAgICAgICAgICAvL3Blcl8yX2Vt
aSA9IHNkbWEtPnNjcmlwdF9hZGRycy0+dWFydF8yX21jdV9hZGRyOw0KKyAgICAgICAgICAgICAg
IHBlcl8yX2VtaSA9IDgxNzsNCiAgICAgICAgICAgICAgICBlbWlfMl9wZXIgPSBzZG1hLT5zY3Jp
cHRfYWRkcnMtPm1jdV8yX2FwcF9hZGRyOw0KICAgICAgICAgICAgICAgIGJyZWFrOw0KICAgICAg
ICBjYXNlIElNWF9ETUFUWVBFX1VBUlRfU1A6DQoNClRoZSBhYm92ZSBkb2Vzbid0IGxvb2sgbGlr
ZSBhIGdvb2QgZml4LiBJIHRyaWVkIHRvIHJldmVydCA5MDVjMGRlY2FkMjgNCmFuZCByZXNvbHZl
IGNvbmZsaWN0cyBhbmQgdGhhdCBhbHNvIHNlZW1zIHRvIHdvcmssIHB1c2hlZCBoZXJlOg0KaHR0
cHM6Ly9naXRodWIuY29tL2NkbGVvbmFyZC9saW51eC9jb21taXQvMGExNzU3ZjQ2N2U2ZGM5NjAz
N2VjMmUzZWE3Yzg4YzVhNGViMmNlYg0KDQpZb3UgY2FuIGZpbmQgdGVzdCBjb2RlIGhlcmUgKG5v
dCB2ZXJ5IGludGVyZXN0aW5nKToNCmh0dHBzOi8vc291cmNlLmNvZGVhdXJvcmEub3JnL2V4dGVy
bmFsL2lteC9pbXgtdGVzdC90cmVlL3Rlc3QvbXhjX3VhcnRfdGVzdC9teGNfdWFydF90ZXN0LmM/
aD1pbXhfNC4xNC42Ml8xLjAuMF9iZXRhDQoNCkFueSBpZGVhIG9uIGhvdyB0byBmaXggdGhpcz8N
Cg0KLS0NClJlZ2FyZHMsDQpMZW9uYXJkDQo=

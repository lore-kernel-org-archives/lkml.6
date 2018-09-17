Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B25ECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F9F214DD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bZtvPBU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F9F214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbeIQI2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:47 -0400
Received: from mail-by2nam03on0130.outbound.protection.outlook.com ([104.47.42.130]:60384
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728718AbeIQI2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXRYx/79iNfWBkGIUy5m4kBkIVvijxcxuVTzZVk8X4A=;
 b=bZtvPBU3mBV+7Krmnc2WvfRsEO00NU+Xzmk9AGg73FCPXkFBPIwcy6yNe/CZjfJf2Obojez8aiQWzJNHc6S6Bhmk836x0Oqg2baZGox0bDHqmIcW+KDEfRac/MaWpxULNkuaRdu4aZuIuXohuvON1V2cqUAp0QjLDF5UH4xX9N0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:03:27 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:27 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stafford Horne <shorne@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 01/87] crypto: skcipher - Fix
 -Wstringop-truncation warnings
Thread-Topic: [PATCH AUTOSEL 4.14 01/87] crypto: skcipher - Fix
 -Wstringop-truncation warnings
Thread-Index: AQHUTjLcXAClSEBDFUmcXqckL+3KDg==
Date:   Mon, 17 Sep 2018 03:02:24 +0000
Message-ID: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:ttfYuJbRJAXoLKodTac9tM3MwY88FF60dSHdpXlEe8PIeJq/+snTftjuvjq/jc3dwIH5jAT2aGMmf9tG8rFtE//qzwwM90CvPqQpxMb5edjygdUn+tBr4SLKMimH9kg4rwc9uWxKTRngpJPXmqmTnoZwDcx1JVXodsR6JCVvMUDaqpTB59rWJ3dDi8NYKTg+IXnybmZNs5HSxITq5sfU7YHlMocZ0By+ongSgf4Jh2uic2s5td3mpLq3EDRASL0Gh1GDv7RHMT1LoyR5W3IHEEUn0spqI51D/JGfpaowiX5vk11P8rTseDFbO+z7A4lwzmD9bLowJAr5hBTmAxhdIVIFzXsB4T4yuN/NTv1TLiVUnQWDl/qkNaMRenGBVflRu3H9+VdIRzVltEUQGO7+cCDk2JhyAAqUwUcjtxaRg3xSWCXFrCtjMj2L/ZK5HTUmw1ftExhiGC5kQ5KyauzrBg==;5:zp8nrwGbODocYjrGbLobXv/W/xg4gWdnI556pGnVmYW2rveoHRRhfJ37lkxPuB+RtFzyJYGBZmwmOqghnKoX8oSkFtYatYO/7PoZdDsMkf2u/55e8qXrjorodA5xgzyikHeDNxu5KxHuq9vwvtSN7PPetfpR+HIZhmevL53Tg5g=;7:0/eyzAB/RGqgwhRqY+CE//AqTkEjFbpQHFOuX1ScEwJCrVVUH0lzypI4oVRvr3PDCEclgiN/54svG3lkCDcHfM0qgoWt+mt6lH8MRC+uufE++0cqFPl1UGRVaBuDq4Vk/cq87kQmxiQhVAgOUCB5ENra5i6eunrU+RT2Bvt0g4Uu8CBnOLooVr/i6lzE4yxYS+mu2D4YLkjrzIB3rBxN8hl7cslHPZ94LOa9Lndcwle5iv9NFifHeYjKsPkt2xOp
x-ms-office365-filtering-correlation-id: af15f6f3-a527-439e-b1b3-08d61c4a23ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-microsoft-antispam-prvs: <CY4PR21MB0855A97DD7712874358C1886FB1E0@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211171220733660)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(6436002)(99286004)(7736002)(110136005)(54906003)(97736004)(5660300001)(66066001)(72206003)(86362001)(86612001)(81166006)(81156014)(2906002)(478600001)(305945005)(68736007)(105586002)(2616005)(106356001)(476003)(22452003)(6486002)(10090500001)(10290500003)(8676002)(39060400002)(36756003)(6346003)(6116002)(6506007)(3846002)(102836004)(107886003)(6666003)(6512007)(1076002)(25786009)(217873002)(4326008)(14454004)(26005)(256004)(14444005)(486006)(186003)(316002)(2900100001)(8936002)(53936002)(5250100002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: o0C4eL5UFnptpmnbhEb1+3wCWyGySSf7pY2TT2hXXTHil9Y7LAYuHyU9EIzln08ovL4eUhZVVWG9wt/j85DIo2ZUQf/QWoks2NKQW/AkWly1OP671Tkrjc313SdSxGoebU9AK+UpIUtPQ4lT0ENiiuc10WbMyff2GerV7kzgnXniFAP8Qrnh3xaYxokwgDm5j7Fum0yvGbR2sTVzNHzeucx1H0H8b1XpNZb3nMDMg4yX6jp0Wi9QXBtEmhJmQYQRz6JzSTwSC/sFQagyVCXwZgaZqvt7nFqiarZ3Q95nQoPucDe13OnHLKN6Q9RR821g4xYqyJmuIf4FmIK46Dv6J9sYaX+mNZl3Zvh2vJNYJZQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D140F3E67C2D984BA9AE771D9BEB1762@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af15f6f3-a527-439e-b1b3-08d61c4a23ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:24.8846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RhZmZvcmQgSG9ybmUgPHNob3JuZUBnbWFpbC5jb20+DQoNClsgVXBzdHJlYW0gY29t
bWl0IGNlZmQ3NjlmZDAxOTJjODRkNjM4ZjY2ZGEyMDI0NTllZDhhZDYzYmEgXQ0KDQpBcyBvZiBH
Q0MgOS4wLjAgdGhlIGJ1aWxkIGlzIHJlcG9ydGluZyB3YXJuaW5ncyBsaWtlOg0KDQogICAgY3J5
cHRvL2FibGtjaXBoZXIuYzogSW4gZnVuY3Rpb24g4oCYY3J5cHRvX2FibGtjaXBoZXJfcmVwb3J0
4oCZOg0KICAgIGNyeXB0by9hYmxrY2lwaGVyLmM6Mzc0OjI6IHdhcm5pbmc6IOKAmHN0cm5jcHni
gJkgc3BlY2lmaWVkIGJvdW5kIDY0IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV3N0cmluZ29w
LXRydW5jYXRpb25dDQogICAgICBzdHJuY3B5KHJibGtjaXBoZXIuZ2VuaXYsIGFsZy0+Y3JhX2Fi
bGtjaXBoZXIuZ2VuaXYgPzogIjxkZWZhdWx0PiIsDQogICAgICBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQogICAgICAg
c2l6ZW9mKHJibGtjaXBoZXIuZ2VuaXYpKTsNCiAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+DQoNClRoaXMgbWVhbnMgdGhlIHN0cm55Y3B5IG1pZ2h0IGNyZWF0ZSBhIG5vbiBudWxsIHRl
cm1pbmF0ZWQgc3RyaW5nLiAgRml4IHRoaXMgYnkNCmV4cGxpY2l0bHkgcGVyZm9ybWluZyAnXDAn
IHRlcm1pbmF0aW9uLg0KDQpDYzogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz4NCkNjOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KQ2M6IE1heCBG
aWxpcHBvdiA8amNtdmJrYmNAZ21haWwuY29tPg0KQ2M6IEVyaWMgQmlnZ2VycyA8ZWJpZ2dlcnMz
QGdtYWlsLmNvbT4NCkNjOiBOaWNrIERlc2F1bG5pZXJzIDxuaWNrLmRlc2F1bG5pZXJzQGdtYWls
LmNvbT4NClNpZ25lZC1vZmYtYnk6IFN0YWZmb3JkIEhvcm5lIDxzaG9ybmVAZ21haWwuY29tPg0K
U2lnbmVkLW9mZi1ieTogSGVyYmVydCBYdSA8aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1Pg0K
U2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQuY29t
Pg0KLS0tDQogY3J5cHRvL2FibGtjaXBoZXIuYyB8IDIgKysNCiBjcnlwdG8vYmxrY2lwaGVyLmMg
IHwgMSArDQogMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBh
L2NyeXB0by9hYmxrY2lwaGVyLmMgYi9jcnlwdG8vYWJsa2NpcGhlci5jDQppbmRleCA0ZWU3YzA0
MWJiODIuLjg4ODJlOTBlODY4ZSAxMDA2NDQNCi0tLSBhL2NyeXB0by9hYmxrY2lwaGVyLmMNCisr
KyBiL2NyeXB0by9hYmxrY2lwaGVyLmMNCkBAIC0zNjgsNiArMzY4LDcgQEAgc3RhdGljIGludCBj
cnlwdG9fYWJsa2NpcGhlcl9yZXBvcnQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IGNyeXB0
b19hbGcgKmFsZykNCiAJc3RybmNweShyYmxrY2lwaGVyLnR5cGUsICJhYmxrY2lwaGVyIiwgc2l6
ZW9mKHJibGtjaXBoZXIudHlwZSkpOw0KIAlzdHJuY3B5KHJibGtjaXBoZXIuZ2VuaXYsIGFsZy0+
Y3JhX2FibGtjaXBoZXIuZ2VuaXYgPzogIjxkZWZhdWx0PiIsDQogCQlzaXplb2YocmJsa2NpcGhl
ci5nZW5pdikpOw0KKwlyYmxrY2lwaGVyLmdlbml2W3NpemVvZihyYmxrY2lwaGVyLmdlbml2KSAt
IDFdID0gJ1wwJzsNCiANCiAJcmJsa2NpcGhlci5ibG9ja3NpemUgPSBhbGctPmNyYV9ibG9ja3Np
emU7DQogCXJibGtjaXBoZXIubWluX2tleXNpemUgPSBhbGctPmNyYV9hYmxrY2lwaGVyLm1pbl9r
ZXlzaXplOw0KQEAgLTQ0Miw2ICs0NDMsNyBAQCBzdGF0aWMgaW50IGNyeXB0b19naXZjaXBoZXJf
cmVwb3J0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBjcnlwdG9fYWxnICphbGcpDQogCXN0
cm5jcHkocmJsa2NpcGhlci50eXBlLCAiZ2l2Y2lwaGVyIiwgc2l6ZW9mKHJibGtjaXBoZXIudHlw
ZSkpOw0KIAlzdHJuY3B5KHJibGtjaXBoZXIuZ2VuaXYsIGFsZy0+Y3JhX2FibGtjaXBoZXIuZ2Vu
aXYgPzogIjxidWlsdC1pbj4iLA0KIAkJc2l6ZW9mKHJibGtjaXBoZXIuZ2VuaXYpKTsNCisJcmJs
a2NpcGhlci5nZW5pdltzaXplb2YocmJsa2NpcGhlci5nZW5pdikgLSAxXSA9ICdcMCc7DQogDQog
CXJibGtjaXBoZXIuYmxvY2tzaXplID0gYWxnLT5jcmFfYmxvY2tzaXplOw0KIAlyYmxrY2lwaGVy
Lm1pbl9rZXlzaXplID0gYWxnLT5jcmFfYWJsa2NpcGhlci5taW5fa2V5c2l6ZTsNCmRpZmYgLS1n
aXQgYS9jcnlwdG8vYmxrY2lwaGVyLmMgYi9jcnlwdG8vYmxrY2lwaGVyLmMNCmluZGV4IGQ4NGM2
OTIwYWRhOS4uODMwODIxZjIzNGQyIDEwMDY0NA0KLS0tIGEvY3J5cHRvL2Jsa2NpcGhlci5jDQor
KysgYi9jcnlwdG8vYmxrY2lwaGVyLmMNCkBAIC01MTEsNiArNTExLDcgQEAgc3RhdGljIGludCBj
cnlwdG9fYmxrY2lwaGVyX3JlcG9ydChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgY3J5cHRv
X2FsZyAqYWxnKQ0KIAlzdHJuY3B5KHJibGtjaXBoZXIudHlwZSwgImJsa2NpcGhlciIsIHNpemVv
ZihyYmxrY2lwaGVyLnR5cGUpKTsNCiAJc3RybmNweShyYmxrY2lwaGVyLmdlbml2LCBhbGctPmNy
YV9ibGtjaXBoZXIuZ2VuaXYgPzogIjxkZWZhdWx0PiIsDQogCQlzaXplb2YocmJsa2NpcGhlci5n
ZW5pdikpOw0KKwlyYmxrY2lwaGVyLmdlbml2W3NpemVvZihyYmxrY2lwaGVyLmdlbml2KSAtIDFd
ID0gJ1wwJzsNCiANCiAJcmJsa2NpcGhlci5ibG9ja3NpemUgPSBhbGctPmNyYV9ibG9ja3NpemU7
DQogCXJibGtjaXBoZXIubWluX2tleXNpemUgPSBhbGctPmNyYV9ibGtjaXBoZXIubWluX2tleXNp
emU7DQotLSANCjIuMTcuMQ0K

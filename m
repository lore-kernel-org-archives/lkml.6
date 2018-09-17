Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E7DECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600752147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="V2tNLz0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600752147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbeIQIdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:33:11 -0400
Received: from mail-bl2nam02on0116.outbound.protection.outlook.com ([104.47.38.116]:52292
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731475AbeIQIdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j5jl4cyBv74NGRdIQbs98HYeHI6vaQjbcHQm0Q0fXk=;
 b=V2tNLz0aT9KGzyJmmkmnkhB6RBkKBxi5s92xfv1Ac0Z7VJyfvuqOUNFEiGM/vtr6bt2YTJXqo+onE57x/6V3av+KCFDoDWmQZh3qykGLztqOM62ocW3ydCm+53HLfzW+3kNR3a5a4r9kdlqkmTGWtTjI+pyT9WN7CccEPudk/GM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.11; Mon, 17 Sep 2018 03:07:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:47 +0000
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
Subject: [PATCH AUTOSEL 3.18 01/29] crypto: skcipher - Fix
 -Wstringop-truncation warnings
Thread-Topic: [PATCH AUTOSEL 3.18 01/29] crypto: skcipher - Fix
 -Wstringop-truncation warnings
Thread-Index: AQHUTjNOGgBE05WUwkWDOUqA+1jtXw==
Date:   Mon, 17 Sep 2018 03:05:37 +0000
Message-ID: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:1VGZTEROmvQLAivnfqSGHUZeuTiLh0vq12bdB7lxAtR+3TvyBJ44bxjnddVAdhi35ZmJ71xm8a1DKext+G4cc9omvqmutcuKA6GEV2ImvOHK/849kM16d+2tyhGCiUQySecf3diHjeYUqeGdlBWZDVgweddd8nb+XFvPF2kHFD65bPfQ2DWTQzdl3LvZKLAnbdUDxmMgXYC4AXcN5CxvoOvfFUuUOvdOqQfB1UJOgUbtzL8juTH8tV/mMFLT5jrH4CQBwbj9Ser6Rkrcym47R4IkHjMvOpaMQgWCkIaTwEJIKaRJ2SdpUVwJGrGEhYrHFIAyLYqEnI9/pkFDfeinbgz0k3Qw/rafIVkb7TTS+TQo1zHAOih1phwdWAM/5kDHsPFXbUnbVUD7v15vCmhp40q1RmmyuY7lAe5IkeajZkUptbKf6fqtq+LKKSYj7nu6NMPdMQus/xvUHiyud2yG4Q==;5:OtOn0XkZip/e4brqlLvHmaaKZrO3l4gyKxwjiMifWtuMDFmbJJYlUmWhrtFu6hlOIyCATXGe9x/MRiyqxL0eonF9t0hzsM9UAqqd7OAhVMoqahz+WoHGlIRxEejYJPXx6+gzifNwnSuvtHUcD1x86qHPGTZlxyHbUl/tnNIpTa4=;7:33j2QL8i5qPoXS7zkl1MaHIzIaQJ4iQiDvT0XPDm2lVxCnTVOiyY2CYVJWPth6GHuFykrs/8jIhZfXFONCfm6cvrJgBQDiREXZpiEyJxFs9GoTqXg5BuSWN6I9C90wgpRVHTvXnF7rqywJSiytVNqP65hAcx8uxXgLL/u6UmBRClD6hCxbHcw9Mhs+yLQZTWeAGIpyUFvCe/Tz50fzuTt3m9vxtQvgGoKwu13bIGH47lrogsADB4/EzHJopg+gSQ
x-ms-office365-filtering-correlation-id: 64c335dc-ed4b-4629-eefa-08d61c4abf26
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839C2311A8E6BC61DCEDE35FB1E0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211171220733660)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(376002)(396003)(189003)(199004)(8936002)(6116002)(86612001)(3846002)(575784001)(53936002)(81166006)(25786009)(217873002)(39060400002)(5660300001)(68736007)(5250100002)(6666003)(107886003)(256004)(14444005)(305945005)(7736002)(2900100001)(1076002)(86362001)(2501003)(6506007)(4326008)(22452003)(10090500001)(6436002)(102836004)(6486002)(186003)(105586002)(6346003)(26005)(106356001)(54906003)(110136005)(316002)(478600001)(6512007)(2616005)(476003)(486006)(10290500003)(2906002)(81156014)(36756003)(66066001)(72206003)(8676002)(97736004)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: r5H+FbIeivSXgN9Bd8bypGp9OmkyIrPwHqv7JYeRUwXlg1+VPH3Rda57HX6PP4x0/kjFepPT+vFjQqVYYiqazPAlJkxzorPnz2l8fMzYitvnFGqZ5hvirWpcjyvzgh+tq8tLZ7fhh6jr6eOUNhWbOQHrne3e0guphMGTde8uMPBlnKc/nLhLz21Pm8JxPHm+FXX08s+gez1U34umkBn7Rye+PQLKBfQvisOpabLMNNkux9jBjmaU5KAIgiedDqzfL5Mc55WknjufhpDqvpBNKV7UZvk7D0JoVX0NlVnukknmfe9jVRbEbwJgH4i1y9E9W5Edp3kQKQwmMne3jaqMjwbggWDr2H5NGlh8DfQzRYg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <01CB7D2FD84B2F49AF5CDE80B8CF4E7B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c335dc-ed4b-4629-eefa-08d61c4abf26
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:37.1325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
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
L2NyeXB0by9hYmxrY2lwaGVyLmMgYi9jcnlwdG8vYWJsa2NpcGhlci5jDQppbmRleCA1MDYxZDdh
ZDMzZTQuLmNhZDY2YWY1YTFhZSAxMDA2NDQNCi0tLSBhL2NyeXB0by9hYmxrY2lwaGVyLmMNCisr
KyBiL2NyeXB0by9hYmxrY2lwaGVyLmMNCkBAIC0zODIsNiArMzgyLDcgQEAgc3RhdGljIGludCBj
cnlwdG9fYWJsa2NpcGhlcl9yZXBvcnQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IGNyeXB0
b19hbGcgKmFsZykNCiAJc3RybmNweShyYmxrY2lwaGVyLnR5cGUsICJhYmxrY2lwaGVyIiwgc2l6
ZW9mKHJibGtjaXBoZXIudHlwZSkpOw0KIAlzdHJuY3B5KHJibGtjaXBoZXIuZ2VuaXYsIGFsZy0+
Y3JhX2FibGtjaXBoZXIuZ2VuaXYgPzogIjxkZWZhdWx0PiIsDQogCQlzaXplb2YocmJsa2NpcGhl
ci5nZW5pdikpOw0KKwlyYmxrY2lwaGVyLmdlbml2W3NpemVvZihyYmxrY2lwaGVyLmdlbml2KSAt
IDFdID0gJ1wwJzsNCiANCiAJcmJsa2NpcGhlci5ibG9ja3NpemUgPSBhbGctPmNyYV9ibG9ja3Np
emU7DQogCXJibGtjaXBoZXIubWluX2tleXNpemUgPSBhbGctPmNyYV9hYmxrY2lwaGVyLm1pbl9r
ZXlzaXplOw0KQEAgLTQ2Myw2ICs0NjQsNyBAQCBzdGF0aWMgaW50IGNyeXB0b19naXZjaXBoZXJf
cmVwb3J0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBjcnlwdG9fYWxnICphbGcpDQogCXN0
cm5jcHkocmJsa2NpcGhlci50eXBlLCAiZ2l2Y2lwaGVyIiwgc2l6ZW9mKHJibGtjaXBoZXIudHlw
ZSkpOw0KIAlzdHJuY3B5KHJibGtjaXBoZXIuZ2VuaXYsIGFsZy0+Y3JhX2FibGtjaXBoZXIuZ2Vu
aXYgPzogIjxidWlsdC1pbj4iLA0KIAkJc2l6ZW9mKHJibGtjaXBoZXIuZ2VuaXYpKTsNCisJcmJs
a2NpcGhlci5nZW5pdltzaXplb2YocmJsa2NpcGhlci5nZW5pdikgLSAxXSA9ICdcMCc7DQogDQog
CXJibGtjaXBoZXIuYmxvY2tzaXplID0gYWxnLT5jcmFfYmxvY2tzaXplOw0KIAlyYmxrY2lwaGVy
Lm1pbl9rZXlzaXplID0gYWxnLT5jcmFfYWJsa2NpcGhlci5taW5fa2V5c2l6ZTsNCmRpZmYgLS1n
aXQgYS9jcnlwdG8vYmxrY2lwaGVyLmMgYi9jcnlwdG8vYmxrY2lwaGVyLmMNCmluZGV4IDVlYmZk
ZDBkNDU0My4uNWJhOTkxNmEzM2M4IDEwMDY0NA0KLS0tIGEvY3J5cHRvL2Jsa2NpcGhlci5jDQor
KysgYi9jcnlwdG8vYmxrY2lwaGVyLmMNCkBAIC01MTQsNiArNTE0LDcgQEAgc3RhdGljIGludCBj
cnlwdG9fYmxrY2lwaGVyX3JlcG9ydChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgY3J5cHRv
X2FsZyAqYWxnKQ0KIAlzdHJuY3B5KHJibGtjaXBoZXIudHlwZSwgImJsa2NpcGhlciIsIHNpemVv
ZihyYmxrY2lwaGVyLnR5cGUpKTsNCiAJc3RybmNweShyYmxrY2lwaGVyLmdlbml2LCBhbGctPmNy
YV9ibGtjaXBoZXIuZ2VuaXYgPzogIjxkZWZhdWx0PiIsDQogCQlzaXplb2YocmJsa2NpcGhlci5n
ZW5pdikpOw0KKwlyYmxrY2lwaGVyLmdlbml2W3NpemVvZihyYmxrY2lwaGVyLmdlbml2KSAtIDFd
ID0gJ1wwJzsNCiANCiAJcmJsa2NpcGhlci5ibG9ja3NpemUgPSBhbGctPmNyYV9ibG9ja3NpemU7
DQogCXJibGtjaXBoZXIubWluX2tleXNpemUgPSBhbGctPmNyYV9ibGtjaXBoZXIubWluX2tleXNp
emU7DQotLSANCjIuMTcuMQ0K

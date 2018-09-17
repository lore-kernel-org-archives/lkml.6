Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55894ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70F5208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LmPMd3n+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70F5208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbeIQI2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:06 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:22121
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728680AbeIQI2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oNrN8ha50zipdOMRiUh1jSFOtsfUqzTRHsTTPK4jz4=;
 b=LmPMd3n+xI1rLAYpz5AjFlVnD9tM0o5OhH+oNGYSOQMeLMB9OcmtUkMCo/piE3DcaFk56QgBjSBnjzaklmwSQZziv0XYAl19wV8jLHaZ2Ge5RRy/fvPDaP330lhK7Lndbr3lV6rCeUQ5+rFWQxHWlTfkY05UnHPGf+crLOhFMJA=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 112/136] spi: orion: fix CS GPIO handling again
Thread-Topic: [PATCH AUTOSEL 4.18 112/136] spi: orion: fix CS GPIO handling
 again
Thread-Index: AQHUTjK3rm/GKJMngkGlG6ho80/skg==
Date:   Mon, 17 Sep 2018 03:01:22 +0000
Message-ID: <20180917030006.245495-112-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:2p10aG7eeZOfl0TcTgSGIk+6EyM9+GGtNDXshHqMbwDHbN8BtOUw69b0nYlGuq7nAyLkqQeNk+2+y897r7/hLD2h4eSoa+ykpUf1VTS9y8WpiM4kblR6+kxUkD2hUiu8IZapfNSuocPxcgVnAw88c6ZhLzu+3qFlBFt6yXc8NudL6i8THbTvPTj+EPWnpUOV8AVz/nHBF91eeRyUyb0XueRu7EgoUZdvWlHKMGsF1EPPau/6eYDLEoJ1SWcLImFcICI/zE0Br5vMroyBZr4YdWdXMi4wN8rphV/LEEntwRTeBYFyYAXCH6Jbs29YO1ERS5TPIZeZ7CgGlSfabE/5sjQab3XaJa8/kWWqX+xIfAbbwg2Y/A8RByOnk+u5jFbH9e2DZFn/rTPcQVrtY83UcAkQWuol76DdZgwhBEHsy7wB/RzJ1eMq8nP2yeXjMnm4coOhcNp4tjfF2WOALMRziQ==;5:oJNzsyyJ1N+loXqCr0r783eFjPodXMtjUwf3jJmb1K7kQnY6vSmd80+OCpP89XMhUFrUE68Dv8pCqRVg4SU+Bs1U+qri8axxOf/KPnnHg9CNvN3SVdu7iw1uQb0Cukrp5KgCtR6j2B4HDytipZIY7daQUoiyc5aOUToOKnAuGPc=;7:ttAguy7Mi0adbPDg+LUO1I5HGcrALDvUKPbfQiQAIG9J2ngEFVHFml/Ons9DNMuorkT5dpqE6zfoPL5N3XjwVRbJoxSDDQ71OXnrC5QeEuVZEA39G4jHgb5ai6CoRC3faYpsql1A9U0bF5W9TdignUkQbFyMGBi8rDec6dt0Rt0yfLELCA+xB9e9Nd1QYskf+viy+/v3+vizHru+j63vRjtwPM2CUdTdDjhrdo8K5Dkoz9OQAA96cFzffaTSv3pc
x-ms-office365-filtering-correlation-id: 39bd1883-edfe-4e2e-b06f-08d61c4a0afe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB0168D506B5A6F0C76B783FF0FB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(5024004)(6512007)(2501003)(5250100002)(2900100001)(14444005)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: S0HwVZUnNNABoni9zooL5UtH3VIJWMW5G0geT/9LX/eKbVgy6g8iYzPoL3piPVc/TgAm53AINbLZDYBQ97k3Yq7H/Kwee1mlW+lOasRdABWPgQBAqlUOqs4vPb9HPX7a5p7FBsqHTjPDIvLDIKBMWJCQfoSfAMgthdjCGR953ht7hKOqzkoz0mxIfSN8pg9cDE2uqyg5MZgC732X3TgsMxVbsFp+IlTHp1JpjEbmJDc6WvcAwtgYexCpRHc7RkMd1XuG11uk1eQwsk2QlKoOU2NUE/HbAFnrQlX+YyvfVAN8jJM9PZXNT+OaUz7IBJ6y3GybtL4b6XddqB9V8irG0SLR+S9dUExc42cOPTdnB5w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C58133FA2D3E740A3DB0F12C187D3CF@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bd1883-edfe-4e2e-b06f-08d61c4a0afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:22.7291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFuIEt1bmRyw6F0IDxqYW4ua3VuZHJhdEBjZXNuZXQuY3o+DQoNClsgVXBzdHJlYW0g
Y29tbWl0IGZiOWFjZjVmMWYyMWYxZGUxOTM1MjNmZjc4MGJkYTM3NWI0YzJlMjEgXQ0KDQpUaGUg
Y29kZSBkaWQgbm90IGRlLWFzc2VydCBhbnkgQ1MgR1BJT3MgYmVmb3JlIHByb2Jpbmcgc2xhdmVz
LiBUaGlzDQptZWFucyB0aGF0IHNldmVyYWwgQ1Mgc2lnbmFscyBjb3VsZCBiZSBhY3RpdmUgYXQg
b25jZSwgZ2FyYmxpbmcgdGhlDQpjb21tdW5pY2F0aW9uLiBXaGV0aGVyIHRoaXMgd2FzIGFjdHVh
bGx5IGEgcHJvYmxlbSBkZXBlbmRlZCBvbiB0aGUgdHlwZQ0Kb2YgdGhlIFNQSSBkZXZpY2UgYXR0
YWNoZWQgKHNvIG15ICJzcGlkZXYiIGZvciB1c2Vyc3BhY2UgYWNjZXNzIHdvcmtlZA0KY29ycmVj
dGx5IGJlY2F1c2UgaXRzIHByb2JlIHdhcyBlZmZlY3RpdmVseSBhIG5vLW9wKSwgYW5kIG9uIHRo
ZSBzdGF0ZQ0Kb2YgdGhlIEdQSU8gcGlucyBhdCBTb0MncyBib290Lg0KDQpUaGUgY29kZSB3YXMg
YWxyZWFkeSBpdGVyYXRpbmcgdGhyb3VnaCBhbGwgRFQgY2hpbGRyZW4gb2YgdGhlIFNQSQ0KY29u
dHJvbGxlciwgc28gdGhpcyBjaGFuZ2UgcmUtdXNlcyB0aGF0IGxvb3AgZm9yIENTIEdQSU8gc2V0
dXAgYXMgd2VsbC4NClRoaXMgbWVhbnMgdGhhdCB0aGlzIG1pZ2h0IGNoYW5nZSB0aGUgbnVtYmVy
IG9mIHRoZSBIVyBDUyBzaWduYWwgd2hpY2gNCmlzIHBpY2tlZCBmb3IgYWxsIEdQSU8gQ1MgZGV2
aWNlcy4gUHJldmlvdXNseSwgdGhlIGxvd2VzdCBvbmUgd2FzIHVzZWQsDQpidXQgd2Ugbm93IHVz
ZSB0aGUgZmlyc3Qgb25lIGZyb20gdGhlIERULg0KDQpXaXRoIHRoaXMgbW92ZSBvZiB0aGUgY29k
ZSwgd2UgY2FuIGFsc28gZmluYWxseSBpbml0aWFsaXplIGVhY2ggR1BJTyBDUw0KbGFuZSBiZWZv
cmUgcmVnaXN0ZXJpbmcgdGhlIFNQSSBjb250cm9sbGVyICh3aGljaCBpbiB0dXJuIHByb2JlcyBm
b3INCnNsYXZlcykuDQoNCkkgdHJpZWQgdG8gZml4IHRoaXMgaW4gNTQ0MjQ4NjIzYjk1IGFscmVh
ZHksIGJ1dCB0aGF0IG9ubHkgZGlkIGl0IGhhbGYNCndheSBieSByZWdpc3RlcmluZyB0aGUgR1BJ
T3MgcHJvcGVybHkuIFRoYXQgcGF0Y2ggZmFpbGVkIHRvIHNldCB0aGVpcg0KbG9naWMgc2lnbmFs
cyBlYXJseSBlbm91Z2gsIHRob3VnaC4NCg0KU2lnbmVkLW9mZi1ieTogSmFuIEt1bmRyw6F0IDxq
YW4ua3VuZHJhdEBjZXNuZXQuY3o+DQpTaWduZWQtb2ZmLWJ5OiBNYXJrIEJyb3duIDxicm9vbmll
QGtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8YWxleGFuZGVyLmxldmlu
QG1pY3Jvc29mdC5jb20+DQotLS0NCiBkcml2ZXJzL3NwaS9zcGktb3Jpb24uYyB8IDc3ICsrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQw
IGluc2VydGlvbnMoKyksIDM3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
cGkvc3BpLW9yaW9uLmMgYi9kcml2ZXJzL3NwaS9zcGktb3Jpb24uYw0KaW5kZXggZDAxYTZhZGM3
MjZlLi40N2VmNmIxYTJlNzYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NwaS9zcGktb3Jpb24uYw0K
KysrIGIvZHJpdmVycy9zcGkvc3BpLW9yaW9uLmMNCkBAIC0yMCw2ICsyMCw3IEBADQogI2luY2x1
ZGUgPGxpbnV4L29mLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCiAjaW5jbHVk
ZSA8bGludXgvb2ZfZGV2aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4L29mX2dwaW8uaD4NCiAjaW5j
bHVkZSA8bGludXgvY2xrLmg+DQogI2luY2x1ZGUgPGxpbnV4L3NpemVzLmg+DQogI2luY2x1ZGUg
PGxpbnV4L2dwaW8uaD4NCkBAIC02ODEsOSArNjgyLDkgQEAgc3RhdGljIGludCBvcmlvbl9zcGlf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJCWdvdG8gb3V0X3JlbF9heGlf
Y2xrOw0KIAl9DQogDQotCS8qIFNjYW4gYWxsIFNQSSBkZXZpY2VzIG9mIHRoaXMgY29udHJvbGxl
ciBmb3IgZGlyZWN0IG1hcHBlZCBkZXZpY2VzICovDQogCWZvcl9lYWNoX2F2YWlsYWJsZV9jaGls
ZF9vZl9ub2RlKHBkZXYtPmRldi5vZl9ub2RlLCBucCkgew0KIAkJdTMyIGNzOw0KKwkJaW50IGNz
X2dwaW87DQogDQogCQkvKiBHZXQgY2hpcC1zZWxlY3QgbnVtYmVyIGZyb20gdGhlICJyZWciIHBy
b3BlcnR5ICovDQogCQlzdGF0dXMgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgInJlZyIsICZj
cyk7DQpAQCAtNjk0LDYgKzY5NSw0NCBAQCBzdGF0aWMgaW50IG9yaW9uX3NwaV9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJCWNvbnRpbnVlOw0KIAkJfQ0KIA0KKwkJLyoN
CisJCSAqIEluaXRpYWxpemUgdGhlIENTIEdQSU86DQorCQkgKiAtIHByb3Blcmx5IHJlcXVlc3Qg
dGhlIGFjdHVhbCBHUElPIHNpZ25hbA0KKwkJICogLSBkZS1hc3NlcnQgdGhlIGxvZ2ljYWwgc2ln
bmFsIHNvIHRoYXQgYWxsIEdQSU8gQ1MgbGluZXMNCisJCSAqICAgYXJlIGluYWN0aXZlIHdoZW4g
cHJvYmluZyBmb3Igc2xhdmVzDQorCQkgKiAtIGZpbmQgYW4gdW51c2VkIHBoeXNpY2FsIENTIHdo
aWNoIHdpbGwgYmUgZHJpdmVuIGZvciBhbnkNCisJCSAqICAgc2xhdmUgd2hpY2ggdXNlcyBhIENT
IEdQSU8NCisJCSAqLw0KKwkJY3NfZ3BpbyA9IG9mX2dldF9uYW1lZF9ncGlvKHBkZXYtPmRldi5v
Zl9ub2RlLCAiY3MtZ3Bpb3MiLCBjcyk7DQorCQlpZiAoY3NfZ3BpbyA+IDApIHsNCisJCQljaGFy
ICpncGlvX25hbWU7DQorCQkJaW50IGNzX2ZsYWdzOw0KKw0KKwkJCWlmIChzcGktPnVudXNlZF9o
d19ncGlvID09IC0xKSB7DQorCQkJCWRldl9pbmZvKCZwZGV2LT5kZXYsDQorCQkJCQkiU2VsZWN0
ZWQgdW51c2VkIEhXIENTIyVkIGZvciBhbnkgR1BJTyBDU2VzXG4iLA0KKwkJCQkJY3MpOw0KKwkJ
CQlzcGktPnVudXNlZF9od19ncGlvID0gY3M7DQorCQkJfQ0KKw0KKwkJCWdwaW9fbmFtZSA9IGRl
dm1fa2FzcHJpbnRmKCZwZGV2LT5kZXYsIEdGUF9LRVJORUwsDQorCQkJCQkiJXMtQ1MlZCIsIGRl
dl9uYW1lKCZwZGV2LT5kZXYpLCBjcyk7DQorCQkJaWYgKCFncGlvX25hbWUpIHsNCisJCQkJc3Rh
dHVzID0gLUVOT01FTTsNCisJCQkJZ290byBvdXRfcmVsX2F4aV9jbGs7DQorCQkJfQ0KKw0KKwkJ
CWNzX2ZsYWdzID0gb2ZfcHJvcGVydHlfcmVhZF9ib29sKG5wLCAic3BpLWNzLWhpZ2giKSA/DQor
CQkJCUdQSU9GX09VVF9JTklUX0xPVyA6IEdQSU9GX09VVF9JTklUX0hJR0g7DQorCQkJc3RhdHVz
ID0gZGV2bV9ncGlvX3JlcXVlc3Rfb25lKCZwZGV2LT5kZXYsIGNzX2dwaW8sDQorCQkJCQljc19m
bGFncywgZ3Bpb19uYW1lKTsNCisJCQlpZiAoc3RhdHVzKSB7DQorCQkJCWRldl9lcnIoJnBkZXYt
PmRldiwNCisJCQkJCSJDYW4ndCByZXF1ZXN0IEdQSU8gZm9yIENTICVkXG4iLCBjcyk7DQorCQkJ
CWdvdG8gb3V0X3JlbF9heGlfY2xrOw0KKwkJCX0NCisJCX0NCisNCiAJCS8qDQogCQkgKiBDaGVj
ayBpZiBhbiBhZGRyZXNzIGlzIGNvbmZpZ3VyZWQgZm9yIHRoaXMgU1BJIGRldmljZS4gSWYNCiAJ
CSAqIG5vdCwgdGhlIE1CdXMgbWFwcGluZyB2aWEgdGhlICdyYW5nZXMnIHByb3BlcnR5IGluIHRo
ZSAnc29jJw0KQEAgLTc0MCw0NCArNzc5LDggQEAgc3RhdGljIGludCBvcmlvbl9zcGlfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJaWYgKHN0YXR1cyA8IDApDQogCQlnb3Rv
IG91dF9yZWxfcG07DQogDQotCWlmIChtYXN0ZXItPmNzX2dwaW9zKSB7DQotCQlpbnQgaTsNCi0J
CWZvciAoaSA9IDA7IGkgPCBtYXN0ZXItPm51bV9jaGlwc2VsZWN0OyArK2kpIHsNCi0JCQljaGFy
ICpncGlvX25hbWU7DQotDQotCQkJaWYgKCFncGlvX2lzX3ZhbGlkKG1hc3Rlci0+Y3NfZ3Bpb3Nb
aV0pKSB7DQotCQkJCWNvbnRpbnVlOw0KLQkJCX0NCi0NCi0JCQlncGlvX25hbWUgPSBkZXZtX2th
c3ByaW50ZigmcGRldi0+ZGV2LCBHRlBfS0VSTkVMLA0KLQkJCQkJIiVzLUNTJWQiLCBkZXZfbmFt
ZSgmcGRldi0+ZGV2KSwgaSk7DQotCQkJaWYgKCFncGlvX25hbWUpIHsNCi0JCQkJc3RhdHVzID0g
LUVOT01FTTsNCi0JCQkJZ290byBvdXRfcmVsX21hc3RlcjsNCi0JCQl9DQotDQotCQkJc3RhdHVz
ID0gZGV2bV9ncGlvX3JlcXVlc3QoJnBkZXYtPmRldiwNCi0JCQkJCW1hc3Rlci0+Y3NfZ3Bpb3Nb
aV0sIGdwaW9fbmFtZSk7DQotCQkJaWYgKHN0YXR1cykgew0KLQkJCQlkZXZfZXJyKCZwZGV2LT5k
ZXYsDQotCQkJCQkiQ2FuJ3QgcmVxdWVzdCBHUElPIGZvciBDUyAlZFxuIiwNCi0JCQkJCW1hc3Rl
ci0+Y3NfZ3Bpb3NbaV0pOw0KLQkJCQlnb3RvIG91dF9yZWxfbWFzdGVyOw0KLQkJCX0NCi0JCQlp
ZiAoc3BpLT51bnVzZWRfaHdfZ3BpbyA9PSAtMSkgew0KLQkJCQlkZXZfaW5mbygmcGRldi0+ZGV2
LA0KLQkJCQkJIlNlbGVjdGVkIHVudXNlZCBIVyBDUyMlZCBmb3IgYW55IEdQSU8gQ1Nlc1xuIiwN
Ci0JCQkJCWkpOw0KLQkJCQlzcGktPnVudXNlZF9od19ncGlvID0gaTsNCi0JCQl9DQotCQl9DQot
CX0NCi0NCi0NCiAJcmV0dXJuIHN0YXR1czsNCiANCi1vdXRfcmVsX21hc3RlcjoNCi0Jc3BpX3Vu
cmVnaXN0ZXJfbWFzdGVyKG1hc3Rlcik7DQogb3V0X3JlbF9wbToNCiAJcG1fcnVudGltZV9kaXNh
YmxlKCZwZGV2LT5kZXYpOw0KIG91dF9yZWxfYXhpX2NsazoNCi0tIA0KMi4xNy4xDQo=

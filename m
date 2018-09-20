Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A45C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391C621521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LlrjkaDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 391C621521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbeITI24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:28:56 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:41534
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387719AbeITI2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6KGXGskIo+Eu6Ya7uIAa5J/UiXnaZQ1HgjTKJR8HZY=;
 b=LlrjkaDI3P1RTdjhjvyQZjt0Yn7Q7BsFYgfyGgE/qL86VVI/M/9+54WWIx6zHxbhNT8Ly9gscpWzgoAZ8+XffJJSzMHmzWxTKOfCWtgOz5w+fL/IEEI2Zh2R6fkVJ84Rn6AQ5Mv9G/JTL0BAzkSGXcpq4Fkqw6yLlVAfADu0uDo=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 19/56] drm/amdgpu: fix preamble handling
Thread-Topic: [PATCH AUTOSEL 4.18 19/56] drm/amdgpu: fix preamble handling
Thread-Index: AQHUUIxMtPujEHlAGEqjTJVzjeASLg==
Date:   Thu, 20 Sep 2018 02:47:40 +0000
Message-ID: <20180920024716.58490-19-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:9GFcl3iOJbdI+WvYvDfuSEvnpmrA4rUxY8ckF0xb4+fGDZwU9E+zfJMcmDCvRrs4G2UfsWztUZKQOzvDSO3uZKDECDtas+pbB6mAi9gSNnupwg1ATpBBdYwQai4+d9AXVK32r34UGSK40+RY/dIuIgWpe9vjXwEqhBN+eFeN1gcz9UQC9z+3+01cMe74LCeAU6A/wGewbHlZLEMK00Eb6lfjeZiw+t+N4V2mPFj4CiQUA0Tzh1PS8YfgKPj6YLbt5Gpb8yMPP0aFG4eXhlMf0asVSJezG9IcIwsLmBWPwMyQAluMx5vBqLW3FTo4oq6cxCQHzm7mzh0ak2dkr5AwaXX6JRBzY5bYcZh8HrJR0hfaZYKPMlugCugeBXE9k3bcrOzaSM6TiwYruKjM/Gv4t9GqaL3GuoyAd98gaa+iCoHLPGEvnajFot6ElVikfYetH5B1JeovznYuGqsoAWFc5g==;5:yvDE6FaTeGh0HqySx5OmWFBbIVt9slxXbXZHmzmtGe8eZ8WWTFwXNcUFct7GTC0RQAioWZLFzcCLAbOQPdneYozAjv9Fq3k2K5v2ygbzgMctDlp026bGBr0HBqhk60y8jcBa2o0O9tgEU8SRXwFIxtmaVkmpFKjBOq0G34AmZ0c=;7:KdCxiIQCs9QfUY70pKD1/GZLmlCF5n2U4L3rmulvTY3q1HCUeVkH5z29pv2XSTvinR7vfFONfJ4VAhPAjpshwci40Kk7TVm5K6jbUTccBE1LuoEeaJXaFuPzoctBhbozgMWh6krq0AYxJLlpJZ+q5ygKVQCOjq/Tzze4b70TYlWntfBkghT6zU+v5SL7MziAuIWcEskcvUafE3c/G9rVtlOTY5iRuYMTd+TFoUM0JhpyAYx4ZVv01g4bAADKlmPz
x-ms-office365-filtering-correlation-id: 04b31a0c-fc19-4fa5-68c5-08d61ea3703c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB08229FC02545029DF8A5D702FB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(575784001)(2906002)(107886003)(2616005)(486006)(256004)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ACtAU+mOg/HpwdFsOcFGqb6dPtBFfuNaHUnIjz3WoCzvNUymE/hLywiQXVNP+cbMzOQkKnzRmsqQt8VexNvy1vDcYAKv4Z4x1NtAMoax/Rtp8opVXRYf9D2LyGhBjZuBG8u7CbTopSa62Ph8iiccei1FJ7Ui77ZzWXyGKsH2VdZC/8ZsiNl4/1mYSTtwW2LEugfNQAIfs1jFS7H9Q7AcU1317F/j3C2xDzcMPwnXK4tAFb/ClA7cxMkiPGP+Z4pFqg4vaRmVYs6xQlRkNoZXrqMF6q64T2U1EPZCMiUF1H1JcPD7mHLs4gcyrePeouaU0cVvXETZGk3okmL6V30GYlUznHULdSNm1tAhWnE6Poc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <728CB4A89AD8B24483F90F98E564AC9E@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b31a0c-fc19-4fa5-68c5-08d61ea3703c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:40.6170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KDQpbIFVw
c3RyZWFtIGNvbW1pdCBkOThmZjI0ZThlOWJlMzMyOWVlYTdjODRkNWUyNDRkMGMxY2QwYWIzIF0N
Cg0KQXQgdGhpcyBwb2ludCB0aGUgY29tbWFuZCBzdWJtaXNzaW9uIGNhbiBzdGlsbCBiZSBpbnRl
cnJ1cHRlZC4NCg0KU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPg0KQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxhbGV4YW5kZXIubGV2aW5AbWlj
cm9zb2Z0LmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5j
IHwgMTYgKysrKysrKysrLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfY3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jDQpp
bmRleCA1YTE5NmVjNDliZTguLjcyMDBlZWE0ZjkxOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfY3MuYw0KQEAgLTk3NSwxMyArOTc1LDkgQEAgc3RhdGljIGludCBhbWRncHVf
Y3NfaWJfZmlsbChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCiAJCWlmIChyKQ0KIAkJCXJl
dHVybiByOw0KIA0KLQkJaWYgKGNodW5rX2liLT5mbGFncyAmIEFNREdQVV9JQl9GTEFHX1BSRUFN
QkxFKSB7DQotCQkJcGFyc2VyLT5qb2ItPnByZWFtYmxlX3N0YXR1cyB8PSBBTURHUFVfUFJFQU1C
TEVfSUJfUFJFU0VOVDsNCi0JCQlpZiAoIXBhcnNlci0+Y3R4LT5wcmVhbWJsZV9wcmVzZW50ZWQp
IHsNCi0JCQkJcGFyc2VyLT5qb2ItPnByZWFtYmxlX3N0YXR1cyB8PSBBTURHUFVfUFJFQU1CTEVf
SUJfUFJFU0VOVF9GSVJTVDsNCi0JCQkJcGFyc2VyLT5jdHgtPnByZWFtYmxlX3ByZXNlbnRlZCA9
IHRydWU7DQotCQkJfQ0KLQkJfQ0KKwkJaWYgKGNodW5rX2liLT5mbGFncyAmIEFNREdQVV9JQl9G
TEFHX1BSRUFNQkxFKQ0KKwkJCXBhcnNlci0+am9iLT5wcmVhbWJsZV9zdGF0dXMgfD0NCisJCQkJ
QU1ER1BVX1BSRUFNQkxFX0lCX1BSRVNFTlQ7DQogDQogCQlpZiAocGFyc2VyLT5qb2ItPnJpbmcg
JiYgcGFyc2VyLT5qb2ItPnJpbmcgIT0gcmluZykNCiAJCQlyZXR1cm4gLUVJTlZBTDsNCkBAIC0x
MjA2LDYgKzEyMDIsMTIgQEAgc3RhdGljIGludCBhbWRncHVfY3Nfc3VibWl0KHN0cnVjdCBhbWRn
cHVfY3NfcGFyc2VyICpwLA0KIA0KIAlhbWRncHVfY3NfcG9zdF9kZXBlbmRlbmNpZXMocCk7DQog
DQorCWlmICgoam9iLT5wcmVhbWJsZV9zdGF0dXMgJiBBTURHUFVfUFJFQU1CTEVfSUJfUFJFU0VO
VCkgJiYNCisJICAgICFwLT5jdHgtPnByZWFtYmxlX3ByZXNlbnRlZCkgew0KKwkJam9iLT5wcmVh
bWJsZV9zdGF0dXMgfD0gQU1ER1BVX1BSRUFNQkxFX0lCX1BSRVNFTlRfRklSU1Q7DQorCQlwLT5j
dHgtPnByZWFtYmxlX3ByZXNlbnRlZCA9IHRydWU7DQorCX0NCisNCiAJY3MtPm91dC5oYW5kbGUg
PSBzZXE7DQogCWpvYi0+dWZfc2VxdWVuY2UgPSBzZXE7DQogDQotLSANCjIuMTcuMQ0K

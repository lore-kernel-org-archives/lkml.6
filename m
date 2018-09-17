Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7503ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755E2214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AHHVweA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755E2214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbeIQIbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:31:50 -0400
Received: from mail-sn1nam02on0129.outbound.protection.outlook.com ([104.47.36.129]:32192
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728988AbeIQIbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21nq15nu0j7qhwXfbmM4Rr5oQXH+mWen/WKpiSKfcd0=;
 b=AHHVweA0KTeLuRw/yfqiXjQH9/xihsKNHAPc2UW3rwQyfPEeL6W9BB8J6SwICdqIFcBUB7UP/2IPmIsO7GdUukzWshkFIgxNf4pETxYObPUOTmNVxKJGVnh99VC8TpjEksaHpRcpe6PGv99Nju3ub/O5pd3gupnI8q7ydIFYaBM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0166.namprd21.prod.outlook.com (10.173.192.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:06:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:06:29 +0000
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
Subject: [PATCH AUTOSEL 4.4 01/43] crypto: skcipher - Fix
 -Wstringop-truncation warnings
Thread-Topic: [PATCH AUTOSEL 4.4 01/43] crypto: skcipher - Fix
 -Wstringop-truncation warnings
Thread-Index: AQHUTjMyaHUNnpt+q0C5WqDZx/kQDg==
Date:   Mon, 17 Sep 2018 03:04:49 +0000
Message-ID: <20180917030445.484-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0166;6:DBaQeYNU1+Z7RBBdYgrncm2i43ZwNMpKUro743zg7kzQviMXABd71Osqp7vgnbM6KQKLGf2jyDzuu+3GsSH+KbypIW1/vxOsHfyIo1tZfqTbeWaR7k2t3IZc8TEv6GENFz/0Xy74/dI0O5mv5gMsKl74WuPlX0SrpF24bSpWGfrr/+TzYp7FCO2zbCef6ZnoCSydf+yki/WPOsN0DYGNWda5hU/BueADQyL6GOFefaVXGMAZR1K8Nnjzc4QR4bo+GE0WAOYgx4PUXFvakR0YOAdU3mrdXhDFy596gjcR+mBCT3m0xtY8iE0hqK/HheVtuPwIUBbhhJv28xBXpmFk/gbi2QHPAyPCQC6WBLPVrv/vuGuv22NIXD56iGQefz004inX2lGMkKfieBDpkQR130ytLrHTAXMBgpWL8ZQ+9jV0aVVF5qLOir5vlYFPFalAg6Mhi8mwDsRegnw3MIPkVg==;5:1kpq8BdalzgGVb2zVDoaY2gp2siLaL3TPe+ag9sizwFSPHgNTMHaELi7kzzpxwQon7drlaageAu770gX1u01PugvNZC5vmsPu1Nlg9V2qFUm7viewApXT+834WZtHRNLQtB7WLw0Agw89GF/eNpcNxVIwR2nnOp5Tk1yGCLXNDk=;7:xHdO0opN5mbKLWisTqMX+dBLsl4aYQ7jMxg5ts+ClS4sQ8Vh3NfdCaIdl1x/PbGq2mX7eZUyT3AOXKfbB9/MUY/KhrWY5WbTm7eGXF+f4cOM9PnlxfbsCHvEYrfMNkGCGPQKRYu7Z3e0XDD1JYJV9xvcd+Ttz7mDxXJp5DF52DPK0NsL0nQFff+R37PxW0l6wXGaVAtxiGhlg8tQDRkaU+GuBRDLN0WOFVUJhh1bqBVBi4YX7t6nQnHDvPLbVxsD
x-ms-office365-filtering-correlation-id: 60d58b40-d0b9-4b43-038d-08d61c4a9045
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0166;
x-ms-traffictypediagnostic: CY4PR21MB0166:
x-microsoft-antispam-prvs: <CY4PR21MB01661770D9A65C5B239B7F22FB1E0@CY4PR21MB0166.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(211171220733660)(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0166;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(39860400002)(396003)(189003)(199004)(305945005)(256004)(14444005)(217873002)(486006)(186003)(86612001)(66066001)(7736002)(6486002)(102836004)(6512007)(2900100001)(25786009)(14454004)(6666003)(2616005)(476003)(39060400002)(1076002)(97736004)(86362001)(6436002)(5660300001)(6346003)(316002)(2501003)(6116002)(6506007)(105586002)(8676002)(478600001)(3846002)(106356001)(53936002)(68736007)(72206003)(22452003)(5250100002)(81156014)(8936002)(36756003)(10090500001)(107886003)(4326008)(110136005)(99286004)(81166006)(2906002)(26005)(54906003)(10290500003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0166;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: LagnDOvW+Oir+LN3xlfYQpYCrwzMeaOgfM+yvLSQ1OgHy2lI7dN4OSZKTvz+PF6Td+NXuCpLI+TleGLM5A0sKsLBE3t/VZyv+9tH5knURtPTAEHlYbt1cG/GJowux9+fM65ckCKScGbs26/yXjSuI7Xx8xzOaEqi8tFTR2s3STSLxFYrckiEZBfCl+t/Tl+2Y4qcvO9n9mNoaN41U/WP80K8hYyIUkRqiAMO9hFxxrHL6wf/DAwQ1WwgjXVPT+VcGhOVqFCojEVEimxSl5jr0XBNNmhH/c8WVNLkx8bF2zyWbigSwG60n7xVseH31c30ZHjS7vk0IozJ16qqLXyn6AOCLwDa+fiGpgqt2NZJB5U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <75137DCA227E5D48AD24E6470DF796CC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d58b40-d0b9-4b43-038d-08d61c4a9045
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:49.3674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0166
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
L2NyeXB0by9hYmxrY2lwaGVyLmMgYi9jcnlwdG8vYWJsa2NpcGhlci5jDQppbmRleCAxNDllN2E3
ZjA0ZmUuLmI1MjRmNzAyZTY1OCAxMDA2NDQNCi0tLSBhL2NyeXB0by9hYmxrY2lwaGVyLmMNCisr
KyBiL2NyeXB0by9hYmxrY2lwaGVyLmMNCkBAIC0zODQsNiArMzg0LDcgQEAgc3RhdGljIGludCBj
cnlwdG9fYWJsa2NpcGhlcl9yZXBvcnQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IGNyeXB0
b19hbGcgKmFsZykNCiAJc3RybmNweShyYmxrY2lwaGVyLnR5cGUsICJhYmxrY2lwaGVyIiwgc2l6
ZW9mKHJibGtjaXBoZXIudHlwZSkpOw0KIAlzdHJuY3B5KHJibGtjaXBoZXIuZ2VuaXYsIGFsZy0+
Y3JhX2FibGtjaXBoZXIuZ2VuaXYgPzogIjxkZWZhdWx0PiIsDQogCQlzaXplb2YocmJsa2NpcGhl
ci5nZW5pdikpOw0KKwlyYmxrY2lwaGVyLmdlbml2W3NpemVvZihyYmxrY2lwaGVyLmdlbml2KSAt
IDFdID0gJ1wwJzsNCiANCiAJcmJsa2NpcGhlci5ibG9ja3NpemUgPSBhbGctPmNyYV9ibG9ja3Np
emU7DQogCXJibGtjaXBoZXIubWluX2tleXNpemUgPSBhbGctPmNyYV9hYmxrY2lwaGVyLm1pbl9r
ZXlzaXplOw0KQEAgLTQ2NSw2ICs0NjYsNyBAQCBzdGF0aWMgaW50IGNyeXB0b19naXZjaXBoZXJf
cmVwb3J0KHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBjcnlwdG9fYWxnICphbGcpDQogCXN0
cm5jcHkocmJsa2NpcGhlci50eXBlLCAiZ2l2Y2lwaGVyIiwgc2l6ZW9mKHJibGtjaXBoZXIudHlw
ZSkpOw0KIAlzdHJuY3B5KHJibGtjaXBoZXIuZ2VuaXYsIGFsZy0+Y3JhX2FibGtjaXBoZXIuZ2Vu
aXYgPzogIjxidWlsdC1pbj4iLA0KIAkJc2l6ZW9mKHJibGtjaXBoZXIuZ2VuaXYpKTsNCisJcmJs
a2NpcGhlci5nZW5pdltzaXplb2YocmJsa2NpcGhlci5nZW5pdikgLSAxXSA9ICdcMCc7DQogDQog
CXJibGtjaXBoZXIuYmxvY2tzaXplID0gYWxnLT5jcmFfYmxvY2tzaXplOw0KIAlyYmxrY2lwaGVy
Lm1pbl9rZXlzaXplID0gYWxnLT5jcmFfYWJsa2NpcGhlci5taW5fa2V5c2l6ZTsNCmRpZmYgLS1n
aXQgYS9jcnlwdG8vYmxrY2lwaGVyLmMgYi9jcnlwdG8vYmxrY2lwaGVyLmMNCmluZGV4IDJkMDhl
NTliMzIxMi4uZDUyNGY4MzhlYjEwIDEwMDY0NA0KLS0tIGEvY3J5cHRvL2Jsa2NpcGhlci5jDQor
KysgYi9jcnlwdG8vYmxrY2lwaGVyLmMNCkBAIC01MTUsNiArNTE1LDcgQEAgc3RhdGljIGludCBj
cnlwdG9fYmxrY2lwaGVyX3JlcG9ydChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgY3J5cHRv
X2FsZyAqYWxnKQ0KIAlzdHJuY3B5KHJibGtjaXBoZXIudHlwZSwgImJsa2NpcGhlciIsIHNpemVv
ZihyYmxrY2lwaGVyLnR5cGUpKTsNCiAJc3RybmNweShyYmxrY2lwaGVyLmdlbml2LCBhbGctPmNy
YV9ibGtjaXBoZXIuZ2VuaXYgPzogIjxkZWZhdWx0PiIsDQogCQlzaXplb2YocmJsa2NpcGhlci5n
ZW5pdikpOw0KKwlyYmxrY2lwaGVyLmdlbml2W3NpemVvZihyYmxrY2lwaGVyLmdlbml2KSAtIDFd
ID0gJ1wwJzsNCiANCiAJcmJsa2NpcGhlci5ibG9ja3NpemUgPSBhbGctPmNyYV9ibG9ja3NpemU7
DQogCXJibGtjaXBoZXIubWluX2tleXNpemUgPSBhbGctPmNyYV9ibGtjaXBoZXIubWluX2tleXNp
emU7DQotLSANCjIuMTcuMQ0K

Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD5DECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE5A214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ca68VfrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE5A214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbeIXUud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:50:33 -0400
Received: from mail-eopbgr720120.outbound.protection.outlook.com ([40.107.72.120]:39245
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727497AbeIXUud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wxghn7LvLBkv/44YNcT+jyDij9ed+nAOiwMX5XW0eFA=;
 b=ca68VfrJ4FPqjJCYrkYyHr89fn1UueiYm5v17tPRD8djKDbk5u51qE9ftyUxXo1fxjqF3TlC2waNCASAmfhDO6mJ+KsSzT003RPLaudeieCNONdeaKqOPmMUgMWc8q0T6BA8bvrGh3iXDRsDrJo69EFK1OL4DTJHPR7VqtOZFO8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0134.namprd21.prod.outlook.com (10.173.189.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.9; Mon, 24 Sep 2018 14:48:00 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 01/76] mac80211: Run TXQ teardown code before
 de-registering interfaces
Thread-Topic: [PATCH AUTOSEL 4.18 01/76] mac80211: Run TXQ teardown code
 before de-registering interfaces
Thread-Index: AQHUVBWXDLaayAt0wECZGBRNI97eKw==
Date:   Mon, 24 Sep 2018 14:48:00 +0000
Message-ID: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0134;6:8smddD5tJ43+uekJ2s3qoDfAc+/Di4py75eUO1fLkLgWnHr62VVUTcR2V2TXEKc9myyhX8y46lqtFQRPNyrc0EEH1b1ltqrPOs473B/udS0+icnDBQPDHTVvEAEoJXfg6V1XJ3D2NzDxMuZVqXfq/splIGo/rlgNbcR5S46bZRh8J8Hr2XZcAqxYFXA0dA3exsOq2mdDa/nQg9SifmiASCkTWQ9ThXQ9NNRjWtSw145k4RSJNTAGwWj/TySuMXLRkZdxzd1zWmoTVJLXE9S/dL0rrAcryUcceKLBB9tyFS1pzJRk53RG0f2mZzsRho3EvigEtF6M938r8+EWyIGfmGyYn+SdWfsUs2ViKFXS5NWCgskGxNdOYv6dWpb2LSU9Mtl2zq8wxocekqj2PQM+U6upky8x7SKx7wknbWKRcbZ/3IS+c5c9WWc3tO8/2LfpwiV6XyYdtWFl5hGA5AoaEw==;5:ghp+Zt6tNt4s08uy6bemhzsv73uXErcZBz/jluwALILcqOT0EXhw5E7gzfFBohDH/3YuFFyvwQbVVE4unH1O+QcyxVbhh1OF3U60/XEq+h+dyaWBWfBY3PegL3roo5FfwxyWnLPGOvx5I1ODI9vcIdrvPvPC4mEW/lzwUQh16X4=;7:xjuu9Mtb/5V4ZrdJroHsi31kxMSeDRckA4Su2CIk5qYwgUX5d4bLfWMIAuNiB04Z62yzttX+QB/aoFg6saADEfQFf3WbnMVrRXErrZ/tity7Gcy2NUnn4HAShJH2TE2NGydsvYwWMD0sXWyh92oAZUkQ4M7l19OWK+k96CrAQ4i0Grgon7dKc9hx/uJhyAUj3bX3h6eVOyaBBxf3IlnHyxQNWxkcLByuW+bGghy9YRnbfylBh7tnPxxoBWekgkCC
x-ms-office365-filtering-correlation-id: 31d5738e-9a23-4da0-f13c-08d6222cb99a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0134;
x-ms-traffictypediagnostic: CY4PR21MB0134:
x-microsoft-antispam-prvs: <CY4PR21MB0134AC0AFC6533741C5868FAFB170@CY4PR21MB0134.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149066)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0134;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0134;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(2900100001)(86612001)(3846002)(106356001)(97736004)(105586002)(478600001)(10290500003)(36756003)(71200400001)(71190400001)(575784001)(6116002)(8936002)(186003)(5250100002)(217873002)(2501003)(8676002)(2616005)(102836004)(26005)(81166006)(81156014)(476003)(14444005)(256004)(305945005)(54906003)(486006)(68736007)(86362001)(6486002)(5660300001)(99286004)(4326008)(2906002)(7736002)(110136005)(6346003)(6506007)(6512007)(53936002)(6436002)(25786009)(107886003)(1076002)(14454004)(10090500001)(316002)(72206003)(22452003)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0134;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: OEqdPcVdPKd7dk6Nqk579USTwmvQCbLCyzcGjOXB6vr19ikZDJanxhFyy9TrVD1XoaY1MkDe1GG3YY6ZnjDfwxYB5GXU1GzolCwmMgFVe2a1u2eXIPprdoHU7rSetHG1zYFplhCkDi2C8LDHFEpjbm9tAkJwAAf7REOO7PKt2NlgCtM5wI4zCEhJ2IxMCRd5alERfYttpd3BlBbWsjhSKDuSeBZEvgWHDwgNW7IyOlpSEzd6Ouktevo9ORtrIZNJnQUHyAWoXqPaT/Pd/H3Fggc2V6EUsDO/vYWe+h7Su6pNVaV/0xnq0iu6B0xDdMe/adZu1N+mtgSMOtvhUU3IYAAljIzTfHPK0w3Xb2ob9Xc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C599A818EDE850499E74DB7D17C02412@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d5738e-9a23-4da0-f13c-08d6222cb99a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:00.6317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHRva2UuZGs+DQoNClsgVXBzdHJl
YW0gY29tbWl0IDc3Y2ZhZjUyZWNhNWNhYzMwZWQwMjk1MDdlMGNhYjA2NWY4ODg5OTUgXQ0KDQpU
aGUgVFhRIHRlYXJkb3duIGNvZGUgY2FuIHJlZmVyZW5jZSB0aGUgdmlmIGRhdGEgc3RydWN0dXJl
cyB0aGF0IGFyZQ0Kc3RvcmVkIGluIHRoZSBuZXRkZXYgcHJpdmF0ZSBtZW1vcnkgYXJlYSBpZiB0
aGVyZSBhcmUgc3RpbGwgcGFja2V0cyBvbg0KdGhlIHF1ZXVlIHdoZW4gaXQgaXMgYmVpbmcgZnJl
ZWQuIFNpbmNlIHRoZSBUWFEgdGVhcmRvd24gY29kZSBpcyBydW4NCmFmdGVyIHRoZSBuZXRkZXZz
IGFyZSBmcmVlZCwgdGhpcyBjYW4gbGVhZCB0byBhIHVzZS1hZnRlci1mcmVlLiBGaXggdGhpcw0K
YnkgbW92aW5nIHRoZSBUWFEgdGVhcmRvd24gY29kZSB0byBlYXJsaWVyIGluIGllZWU4MDIxMV91
bnJlZ2lzdGVyX2h3KCkuDQoNClJlcG9ydGVkLWJ5OiBCZW4gR3JlZWFyIDxncmVlYXJiQGNhbmRl
bGF0ZWNoLmNvbT4NClRlc3RlZC1ieTogQmVuIEdyZWVhciA8Z3JlZWFyYkBjYW5kZWxhdGVjaC5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBUb2tlIEjDuGlsYW5kLUrDuHJnZW5zZW4gPHRva2VAdG9rZS5k
az4NClNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzLmJlcmdAaW50ZWwuY29t
Pg0KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPGFsZXhhbmRlci5sZXZpbkBtaWNyb3NvZnQu
Y29tPg0KLS0tDQogbmV0L21hYzgwMjExL21haW4uYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL25ldC9tYWM4MDIx
MS9tYWluLmMgYi9uZXQvbWFjODAyMTEvbWFpbi5jDQppbmRleCBmYjczNDUxZWQ4NWUuLjAzNThm
MjBiNjc1ZiAxMDA2NDQNCi0tLSBhL25ldC9tYWM4MDIxMS9tYWluLmMNCisrKyBiL25ldC9tYWM4
MDIxMS9tYWluLmMNCkBAIC0xMTgyLDYgKzExODIsNyBAQCB2b2lkIGllZWU4MDIxMV91bnJlZ2lz
dGVyX2h3KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQ0KICNpZiBJU19FTkFCTEVEKENPTkZJR19J
UFY2KQ0KIAl1bnJlZ2lzdGVyX2luZXQ2YWRkcl9ub3RpZmllcigmbG9jYWwtPmlmYTZfbm90aWZp
ZXIpOw0KICNlbmRpZg0KKwlpZWVlODAyMTFfdHhxX3RlYXJkb3duX2Zsb3dzKGxvY2FsKTsNCiAN
CiAJcnRubF9sb2NrKCk7DQogDQpAQCAtMTIxMCw3ICsxMjExLDYgQEAgdm9pZCBpZWVlODAyMTFf
dW5yZWdpc3Rlcl9odyhzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodykNCiAJc2tiX3F1ZXVlX3B1cmdl
KCZsb2NhbC0+c2tiX3F1ZXVlKTsNCiAJc2tiX3F1ZXVlX3B1cmdlKCZsb2NhbC0+c2tiX3F1ZXVl
X3VucmVsaWFibGUpOw0KIAlza2JfcXVldWVfcHVyZ2UoJmxvY2FsLT5za2JfcXVldWVfdGRsc19j
aHN3KTsNCi0JaWVlZTgwMjExX3R4cV90ZWFyZG93bl9mbG93cyhsb2NhbCk7DQogDQogCWRlc3Ry
b3lfd29ya3F1ZXVlKGxvY2FsLT53b3JrcXVldWUpOw0KIAl3aXBoeV91bnJlZ2lzdGVyKGxvY2Fs
LT5ody53aXBoeSk7DQotLSANCjIuMTcuMQ0K

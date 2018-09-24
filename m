Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B552C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45334214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EU9nClY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45334214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387993AbeIXUwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:52:21 -0400
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:31232
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387658AbeIXUwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYYroEuduaPp6fYTWsS/Sowrk7+tRJvhL19rsRuGQeE=;
 b=EU9nClY/bMQ1HymweC3/Z3dUUiLMhaNsCW/ye26nH3Foa+h1C76pRfxm9D10wmNtkNdEUcch2OqqkO3dT5V9dtNgWeAPeYqwhCwjJiDMmSZHzRns7BpLW/nJB6WKLVmIaCxHE/pM7NFJiea2obfMDdelGYw0nUPurBfPAmnWwNM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 01/36] mac80211: Run TXQ teardown code before
 de-registering interfaces
Thread-Topic: [PATCH AUTOSEL 4.14 01/36] mac80211: Run TXQ teardown code
 before de-registering interfaces
Thread-Index: AQHUVBW3pzkSfzJpnU6rDAbWvbwDSQ==
Date:   Mon, 24 Sep 2018 14:48:54 +0000
Message-ID: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:ClJaE9+WaCG1vtReKqbmDBiW9RYrTcW82e1uyA4jV5I/XsvP4KliunpsNzuVNgPRXDEVW3knLTbzFFwP2N4byhRZ9PLLoKvUEbrGDMmouypNTW9Sqn1tN2sOpui9In3QQcbiuVyWS+aA4WjYjwjc7PByD7raCL2DsqYmhx4IKELBCvz+boa7VnndMI37VwDkg+c2v8Bkr5h8G4BNpeX5fvXMFiKfVelB9wxl0FkEVV0D7KwySGKQcBJOISD57/rsNcRH7ZuFJovhx/G17fCKqqYmy5AufsLVxkcJHo6f9/l2EmhYkL2J2M8OiYgfJEd9p3At9mddyrjFJzIhU1rm364Ya6hKqhDWCj4o/WJ7hj2o5W1WHL6dR5fMU3mAyBcjEhgBR4GlPEaRH3zp1Fmx8CuJICD+/i033eKfdBCRTfMRt4tkxmdNSwATOb89bGpxziASM99w8TiiQMvwsKGTKw==;5:gjvV4zI6nYp4joRjZ4eFj279vNDAiEoRNBKKJYkKZlH3/QC3b2eKD7S8L1rX11bccCWKGQJrJL1t4NceButKsxdw0aHxHzmbpH/f+pvD6jqT97RsXKvmpyC2xB+R8XXXCnk65HZhWMe7ZbCBhFq5YCy16VuybN0x36Jzy3F2V8w=;7:GRyY6nrirTtxaSR+F74KzN0aSld6fXhYCr1LSVDUO89Lh/6HOjXPiY3e36CFTAwWmLZfg5iwJBZZO86pZl56AJcc1ffxloGb8KCelaI5pJPr524/b9hKtfrCl8GWJs5loQNhCK88kNIuOHeY1iBQWJWPBH+oIwS35mPgH9i30X/+DKdRoe9AVoDwFOxBtmpYRSQRe12oH1UVNBfXEcDDU2Hs+X8mPekuSBRAOVU8hdB8Ia/84P3ZXc0dSXEuqjrI
x-ms-office365-filtering-correlation-id: b85176a8-3118-4e72-013c-08d6222cf45e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB047019F3205EDE8E4DA72AF5FB170@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(26005)(97736004)(53936002)(14444005)(25786009)(1076002)(99286004)(102836004)(186003)(6666003)(4326008)(3846002)(110136005)(107886003)(86362001)(5660300001)(6116002)(72206003)(575784001)(54906003)(478600001)(8676002)(217873002)(86612001)(256004)(14454004)(10290500003)(316002)(6486002)(6436002)(106356001)(486006)(105586002)(6506007)(476003)(10090500001)(2616005)(2501003)(5250100002)(71190400001)(68736007)(66066001)(81156014)(71200400001)(22452003)(7736002)(305945005)(2900100001)(8936002)(6512007)(81166006)(36756003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SIepUZ9w6BOJ7q1R9NJmyOAwTw21s5apKZvwCi8a1DjuLE9Z88I2JgJj59mkxqnncYwmS5FYzxONJ5eV469rhQwFEuTx5NtXnrOFck6ttWQpIs85rviHYolTQSKAmqNOZKv5wo7KESo8xaq9Nr4xgwP/GnZZRAAFUbfU9Egf7+OO/YNxrCV1Cb3CUoac254UegK3r8J1eNhC5kxIu/A6rrgYyuWyIR6kjAueMlKE2jfacEW9EmlCgduKaYbLuW7I7IQfKnDb5HaCKXRTS4+wNt+8M2TTh5yzfYgvO60KwqCmvnohxWMWlOxlziDYlUdP01yYxrQh7Nq6vr2fSSV3+Zzqm705SUIJkZOvDJhB9VE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5B7A62E1E07774BBE15AB09CF0DF2E8@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85176a8-3118-4e72-013c-08d6222cf45e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:54.5311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
MS9tYWluLmMgYi9uZXQvbWFjODAyMTEvbWFpbi5jDQppbmRleCA4YWExZjViNmEwNTEuLmNiNWIy
MmI2MTM4OCAxMDA2NDQNCi0tLSBhL25ldC9tYWM4MDIxMS9tYWluLmMNCisrKyBiL25ldC9tYWM4
MDIxMS9tYWluLmMNCkBAIC0xMTcxLDYgKzExNzEsNyBAQCB2b2lkIGllZWU4MDIxMV91bnJlZ2lz
dGVyX2h3KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQ0KICNpZiBJU19FTkFCTEVEKENPTkZJR19J
UFY2KQ0KIAl1bnJlZ2lzdGVyX2luZXQ2YWRkcl9ub3RpZmllcigmbG9jYWwtPmlmYTZfbm90aWZp
ZXIpOw0KICNlbmRpZg0KKwlpZWVlODAyMTFfdHhxX3RlYXJkb3duX2Zsb3dzKGxvY2FsKTsNCiAN
CiAJcnRubF9sb2NrKCk7DQogDQpAQCAtMTE5OSw3ICsxMjAwLDYgQEAgdm9pZCBpZWVlODAyMTFf
dW5yZWdpc3Rlcl9odyhzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodykNCiAJc2tiX3F1ZXVlX3B1cmdl
KCZsb2NhbC0+c2tiX3F1ZXVlKTsNCiAJc2tiX3F1ZXVlX3B1cmdlKCZsb2NhbC0+c2tiX3F1ZXVl
X3VucmVsaWFibGUpOw0KIAlza2JfcXVldWVfcHVyZ2UoJmxvY2FsLT5za2JfcXVldWVfdGRsc19j
aHN3KTsNCi0JaWVlZTgwMjExX3R4cV90ZWFyZG93bl9mbG93cyhsb2NhbCk7DQogDQogCWRlc3Ry
b3lfd29ya3F1ZXVlKGxvY2FsLT53b3JrcXVldWUpOw0KIAl3aXBoeV91bnJlZ2lzdGVyKGxvY2Fs
LT5ody53aXBoeSk7DQotLSANCjIuMTcuMQ0K

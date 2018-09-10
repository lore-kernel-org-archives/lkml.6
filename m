Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C285C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F9A204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BsgTR2KS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F9A204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbeIJNce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:32:34 -0400
Received: from mail-pu1apc01on0102.outbound.protection.outlook.com ([104.47.126.102]:27893
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728216AbeIJNcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLMmICVsnRWy0G3tNQBGUQII/uQ72FHZtTukDIgeWOE=;
 b=BsgTR2KShZeV8FNfAix1N7w6v/ZIN0U6WCnWfeoGmfv6wVssapIsd+QJgzACXYYo0BbgxJ6Ax0SI4DRG3JE2Ie//bKFAytrnbLOQ4/9KVaFnIr/8k6SKtTzM7rHRNQEHIrJrt7qerW1P83uNAVnjqVjVlug1rB7ytlygZjgce4Y=
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM (52.133.156.18) by
 HK0P153MB0178.APCP153.PROD.OUTLOOK.COM (52.133.212.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Mon, 10 Sep 2018 08:39:28 +0000
Received: from HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890]) by HK0P153MB0129.APCP153.PROD.OUTLOOK.COM
 ([fe80::194c:c2f9:171:1890%5]) with mapi id 15.20.1143.010; Mon, 10 Sep 2018
 08:39:28 +0000
From:   Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Jork Loeser <Jork.Loeser@microsoft.com>
Subject: [PATCH 10/13] x86/hyper-v: Add HvFlushGuestAddressList hypercall
 support
Thread-Topic: [PATCH 10/13] x86/hyper-v: Add HvFlushGuestAddressList hypercall
 support
Thread-Index: AQHUSOHJLOBE0OrXvE+2gnpjgG3+tQ==
Date:   Mon, 10 Sep 2018 08:39:27 +0000
Message-ID: <20180910083806.65177-11-Tianyu.Lan@microsoft.com>
References: <20180910083806.65177-1-Tianyu.Lan@microsoft.com>
In-Reply-To: <20180910083806.65177-1-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK0P153MB0178;6:JuYZknGGMMNVEr3KWjY9eHWkkBg34NHeq7r8njDzhVuHT6prjQrqxMui+dpisYDGV3QeQhNZic7GXlLYOviT0t2xukO25ScKqTVjGB6TSZFyd0JgZO88+2XnTFCRXIS6DvAYhw4L8by/tYSSSU7fK5BWW0f+JT5Jgt2czDP95/OIvSXvYn7jou1Bcpi4x29bAkFC8rNyF7dkflFqCS2aML4TEG6mW/hPuFtoONc3J0v/tJa7MuRx5HDeWiW/kWwia7NjjCWHEZQqzxWT56JmvAF882L0Irnh/w+lzYcqjoUlRlJ1L7kcfWeA7IldHb/owYuiQUIeNHwVRNu82n71qdjJQSghgUInCJIbLeRalJRDxTYciw4jKAazK3oCpEhNB5E9Hh7ITdydCtfytjtKt2zpbBz84YZp3cYHLkLdcYuxFOEuL7X/UGbg9C6J84oV5Skx2YGvMBS2kZlYTpddZw==;5:E/+T6ExIms6mfnn1thVbsrirT1G+L+zOjxHV4Qiks2c961Fo87Pyc/a0cnJ3682r8LjJDwipMQMGIN3JbhkfTZRf8iSObNUp4EFj3AfvN+vEUzzzIG+rDQsgTFlv39qjJIHH4hpLiRNLxhqKqH7+H0WV1qyl+Z8MeSBxpZicmfo=;7:5in7q0gn4uAkc3I79tczgFE2ju4kbLaHr3dguXG4cIpN7apDlc1L7h1OVHzdcEwhQ3u2drCplO++PFtUSyOA4ELdVaZLuEOReiiEIc3q/4XxCq1CM8yw89+G7S1OV2v9igtTfO68MMdhVINa90+cd2zknaKUMqRds/anLzXkTy4HUAz0wssXwdmKOA+M9ct5276QrLngvsPWgSZv7eBoRUExbfUxG5E+rGdbr8lYsiRJOKrqxuhpB1vnJYA7Xhe9
x-ms-office365-filtering-correlation-id: f7bc9218-430f-4f2f-02ea-08d616f8ebd1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HK0P153MB0178;
x-ms-traffictypediagnostic: HK0P153MB0178:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0178269271B131753C7E007D92050@HK0P153MB0178.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:HK0P153MB0178;BCL:0;PCL:0;RULEID:;SRVR:HK0P153MB0178;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6029001)(376002)(39850400004)(136003)(366004)(346002)(396003)(189003)(199004)(7736002)(14454004)(478600001)(105586002)(36756003)(97736004)(305945005)(4326008)(10090500001)(486006)(53936002)(99286004)(5660300001)(10290500003)(6116002)(6436002)(72206003)(446003)(76176011)(11346002)(1671002)(2906002)(7416002)(2616005)(6486002)(59246006)(476003)(66066001)(107886003)(109986005)(68736007)(8676002)(14444005)(54906003)(81156014)(81166006)(5250100002)(256004)(1076002)(6506007)(316002)(22452003)(26005)(25786009)(8936002)(6512007)(102836004)(86612001)(106356001)(3846002)(2900100001)(575784001)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0178;H:HK0P153MB0129.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZuEBMXd6n9MAuRBBptJ7cGo/MdaCzR8ew6Z3kFjOVEpmN/Zo6k5mD7o2vLyTR3TnxGO9Yk5VbwO7UBStKp4zpRlqB9kEaIAMLnzgUCIOht0CPuaVmkwhaiIrP1TdWuEXZwK5tvv/YcOdNjH9KeyM6EudMXfQqY4JkwXICzqAdqFGJwE/CYAqBRUPpnNtoMQRfd+0ryfs4odXg5VbNUwSF1tvxEw5G/yxa/5u1JcjXlsTuPJT4Q3iSVDEh/vKsG3cmD2iMBbSCAAOiEFUfTgYM7R/tgudx3Ytu++RpHu7vpo15cht/hqJzWAKEVg/2tEcnB/ExHBAcyDGK173WyaPR23CES9rD8Az3KMeONQ03qU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BE87073FA40564AB54A77054040B71E@APCP153.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bc9218-430f-4f2f-02ea-08d616f8ebd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 08:39:27.9495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0178
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SHlwZXItViBwcm92aWRlcyBIdkZsdXNoR3Vlc3RBZGRyZXNzTGlzdCgpIGh5cGVyY2FsbCB0byBm
bHVzaCBFUFQgdGxiDQp3aXRoIHNwZWNpZmllZCByYW5nZXMuIFRoaXMgcGF0Y2ggaXMgdG8gYWRk
IHRoZSBoeXBlcmNhbGwgc3VwcG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogTGFuIFRpYW55dSA8VGlh
bnl1LkxhbkBtaWNyb3NvZnQuY29tPg0KLS0tDQogYXJjaC94ODYvaHlwZXJ2L25lc3RlZC5jICAg
ICAgICAgICB8IDExMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogYXJj
aC94ODYvaW5jbHVkZS9hc20vaHlwZXJ2LXRsZnMuaCB8ICAxNyArKysrKysNCiBhcmNoL3g4Ni9p
bmNsdWRlL2FzbS9tc2h5cGVydi5oICAgIHwgICA4ICsrKw0KIDMgZmlsZXMgY2hhbmdlZCwgMTM1
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2h5cGVydi9uZXN0ZWQuYyBi
L2FyY2gveDg2L2h5cGVydi9uZXN0ZWQuYw0KaW5kZXggYjhlNjBjYzUwNDYxLi5iYjcxNmVkOTQz
MjAgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9oeXBlcnYvbmVzdGVkLmMNCisrKyBiL2FyY2gveDg2
L2h5cGVydi9uZXN0ZWQuYw0KQEAgLTcsMTUgKzcsMzIgQEANCiAgKg0KICAqIEF1dGhvciA6IExh
biBUaWFueXUgPFRpYW55dS5MYW5AbWljcm9zb2Z0LmNvbT4NCiAgKi8NCisjZGVmaW5lIHByX2Zt
dChmbXQpICAiSHlwZXItVjogIiBmbXQNCiANCiANCiAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4N
CiAjaW5jbHVkZSA8YXNtL2h5cGVydi10bGZzLmg+DQogI2luY2x1ZGUgPGFzbS9tc2h5cGVydi5o
Pg0KICNpbmNsdWRlIDxhc20vdGxiZmx1c2guaD4NCisjaW5jbHVkZSA8YXNtL2t2bV9ob3N0Lmg+
DQogDQogI2luY2x1ZGUgPGFzbS90cmFjZS9oeXBlcnYuaD4NCiANCisvKg0KKyAqICBNQVhfRkxV
U0hfUEFHRVMgPSAiYWRkaXRpb25hbF9wYWdlcyIgKyAxLiBJdCdzIGxpbWl0ZWQNCisgKiAgYnkg
dGhlIGJpdHdpZHRoIG9mICJhZGRpdGlvbmFsX3BhZ2VzIiBpbiB1bmlvbiBodl9ncGFfcGFnZV9y
YW5nZS4NCisgKi8NCisjZGVmaW5lIE1BWF9GTFVTSF9QQUdFUyAoMjA0OCkNCisNCisvKg0KKyAq
IEFsbCBpbnB1dCBmbHVzaCBwYXJhbWV0ZXJzIGFyZSBpbiBzaW5nbGUgcGFnZS4gVGhlIG1heCBm
bHVzaCBjb3VudA0KKyAqIGlzIGVxdWFsIHdpdGggaG93IG1hbnkgZW50cmllcyBvZiB1bmlvbiBo
dl9ncGFfcGFnZV9yYW5nZSBjYW4gYmUNCisgKiBwb3B1bGF0ZWQgaW4gdGhlIGlucHV0IHBhcmFt
ZXRlciBwYWdlLiBNQVhfRkxVU0hfUkVQX0NPVU5UDQorICogPSAoNDA5NiAtIDE2KSAvIDguICji
gJxQYWdlIFNpemXigJ0gLSAiQWRkcmVzcyBTcGFjZSIgLSAiRmxhZ3MiKSAvDQorICogIkdQQSBS
YW5nZSIuDQorICovDQorI2RlZmluZSBNQVhfRkxVU0hfUkVQX0NPVU5UICg1MTApDQorDQogaW50
IGh5cGVydl9mbHVzaF9ndWVzdF9tYXBwaW5nKHU2NCBhcykNCiB7DQogCXN0cnVjdCBodl9ndWVz
dF9tYXBwaW5nX2ZsdXNoICoqZmx1c2hfcGNwdTsNCkBAIC01NCwzICs3MSw5NiBAQCBpbnQgaHlw
ZXJ2X2ZsdXNoX2d1ZXN0X21hcHBpbmcodTY0IGFzKQ0KIAlyZXR1cm4gcmV0Ow0KIH0NCiBFWFBP
UlRfU1lNQk9MX0dQTChoeXBlcnZfZmx1c2hfZ3Vlc3RfbWFwcGluZyk7DQorDQorc3RhdGljIGlu
bGluZSBpbnQgZmlsbF9mbHVzaF9saXN0KHVuaW9uIGh2X2dwYV9wYWdlX3JhbmdlIGdwYV9saXN0
W10sDQorCQlpbnQgb2Zmc2V0LCB1NjQgc3RhcnRfZ2ZuLCB1NjQgZW5kX2dmbikNCit7DQorCWlu
dCBncGFfbiA9IG9mZnNldDsNCisJdTY0IGN1ciA9IHN0YXJ0X2dmbjsNCisJdTY0IHBhZ2VzID0g
ZW5kX2dmbiAtIHN0YXJ0X2dmbiArIDE7DQorCXU2NCBhZGRpdGlvbmFsX3BhZ2VzOw0KKw0KKwlp
ZiAoZW5kX2dmbiA8IHN0YXJ0X2dmbikNCisJCXJldHVybiAtRUlOVkFMOw0KKw0KKwlkbyB7DQor
CQlpZiAoZ3BhX24gPT0gTUFYX0ZMVVNIX1JFUF9DT1VOVCkgew0KKwkJCXByX3dhcm4oIlJlcXVl
c3QgZXhjZWVkcyBIdkZsdXNoR3Vlc3RMaXN0IG1heCBmbHVzaCBjb3VudC5cbiIpOw0KKwkJCXJl
dHVybiAtRU5PU1BDOw0KKwkJfQ0KKw0KKwkJaWYgKHBhZ2VzID4gTUFYX0ZMVVNIX1BBR0VTKSB7
DQorCQkJYWRkaXRpb25hbF9wYWdlcyA9IE1BWF9GTFVTSF9QQUdFUyAtIDE7DQorCQkJcGFnZXMg
LT0gTUFYX0ZMVVNIX1BBR0VTOw0KKwkJfSBlbHNlIHsNCisJCQlhZGRpdGlvbmFsX3BhZ2VzID0g
cGFnZXMgLSAxOw0KKwkJCXBhZ2VzID0gMDsNCisJCX0NCisNCisJCWdwYV9saXN0W2dwYV9uXS5w
YWdlLmFkZGl0aW9uYWxfcGFnZXMgPSBhZGRpdGlvbmFsX3BhZ2VzOw0KKwkJZ3BhX2xpc3RbZ3Bh
X25dLnBhZ2UubGFyZ2VwYWdlID0gZmFsc2U7DQorCQlncGFfbGlzdFtncGFfbl0ucGFnZS5iYXNl
cGZuID0gY3VyOw0KKw0KKwkJY3VyICs9IGFkZGl0aW9uYWxfcGFnZXMgKyAxOw0KKwkJZ3BhX24r
KzsNCisJfSB3aGlsZSAocGFnZXMgPiAwKTsNCisNCisJcmV0dXJuIGdwYV9uOw0KK30NCisNCitp
bnQgaHlwZXJ2X2ZsdXNoX2d1ZXN0X21hcHBpbmdfcmFuZ2UodTY0IGFzLCBzdHJ1Y3Qga3ZtX3Rs
Yl9yYW5nZSAqcmFuZ2UpDQorew0KKwlzdHJ1Y3Qga3ZtX21tdV9wYWdlICpzcDsNCisJc3RydWN0
IGh2X2d1ZXN0X21hcHBpbmdfZmx1c2hfbGlzdCAqKmZsdXNoX3BjcHU7DQorCXN0cnVjdCBodl9n
dWVzdF9tYXBwaW5nX2ZsdXNoX2xpc3QgKmZsdXNoOw0KKwl1NjQgc3RhdHVzID0gMDsNCisJdW5z
aWduZWQgbG9uZyBmbGFnczsNCisJaW50IHJldCA9IC1FTk9UU1VQUDsNCisJaW50IGdwYV9uID0g
MDsNCisNCisJaWYgKCFodl9oeXBlcmNhbGxfcGcpDQorCQlnb3RvIGZhdWx0Ow0KKw0KKwlsb2Nh
bF9pcnFfc2F2ZShmbGFncyk7DQorDQorCWZsdXNoX3BjcHUgPSAoc3RydWN0IGh2X2d1ZXN0X21h
cHBpbmdfZmx1c2hfbGlzdCAqKikNCisJCXRoaXNfY3B1X3B0cihoeXBlcnZfcGNwdV9pbnB1dF9h
cmcpOw0KKw0KKwlmbHVzaCA9ICpmbHVzaF9wY3B1Ow0KKwlpZiAodW5saWtlbHkoIWZsdXNoKSkg
ew0KKwkJbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOw0KKwkJZ290byBmYXVsdDsNCisJfQ0KKw0K
KwlmbHVzaC0+YWRkcmVzc19zcGFjZSA9IGFzOw0KKwlmbHVzaC0+ZmxhZ3MgPSAwOw0KKw0KKwlp
ZiAoIXJhbmdlLT5mbHVzaF9saXN0KSB7DQorCQlncGFfbiA9IGZpbGxfZmx1c2hfbGlzdChmbHVz
aC0+Z3BhX2xpc3QsIGdwYV9uLA0KKwkJCQlyYW5nZS0+c3RhcnRfZ2ZuLCByYW5nZS0+ZW5kX2dm
bik7DQorCX0gZWxzZSB7DQorCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KHNwLCByYW5nZS0+Zmx1c2hf
bGlzdCwNCisJCQkJZmx1c2hfbGluaykgew0KKwkJCXU2NCBlbmRfZ2ZuID0gc3AtPmdmbiArDQor
CQkJCUtWTV9QQUdFU19QRVJfSFBBR0Uoc3AtPnJvbGUubGV2ZWwpIC0gMTsNCisJCQlncGFfbiA9
IGZpbGxfZmx1c2hfbGlzdChmbHVzaC0+Z3BhX2xpc3QsIGdwYV9uLA0KKwkJCQkJc3AtPmdmbiwg
ZW5kX2dmbik7DQorCQl9DQorCX0NCisNCisJaWYgKGdwYV9uIDwgMCkgew0KKwkJbG9jYWxfaXJx
X3Jlc3RvcmUoZmxhZ3MpOw0KKwkJZ290byBmYXVsdDsNCisJfQ0KKw0KKwlzdGF0dXMgPSBodl9k
b19yZXBfaHlwZXJjYWxsKEhWQ0FMTF9GTFVTSF9HVUVTVF9QSFlTSUNBTF9BRERSRVNTX0xJU1Qs
DQorCQkJCSAgICAgZ3BhX24sIDAsIGZsdXNoLCBOVUxMKTsNCisNCisJbG9jYWxfaXJxX3Jlc3Rv
cmUoZmxhZ3MpOw0KKw0KKwlpZiAoIShzdGF0dXMgJiBIVl9IWVBFUkNBTExfUkVTVUxUX01BU0sp
KQ0KKwkJcmV0ID0gMDsNCitmYXVsdDoNCisJcmV0dXJuIHJldDsNCit9DQorRVhQT1JUX1NZTUJP
TF9HUEwoaHlwZXJ2X2ZsdXNoX2d1ZXN0X21hcHBpbmdfcmFuZ2UpOw0KZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2h5cGVydi10bGZzLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9o
eXBlcnYtdGxmcy5oDQppbmRleCBlOTc3YjZiM2E1MzguLjUxMmYyMmI0OTk5OSAxMDA2NDQNCi0t
LSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2h5cGVydi10bGZzLmgNCisrKyBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2h5cGVydi10bGZzLmgNCkBAIC0zNTMsNiArMzUzLDcgQEAgc3RydWN0IGh2X3Rz
Y19lbXVsYXRpb25fc3RhdHVzIHsNCiAjZGVmaW5lIEhWQ0FMTF9QT1NUX01FU1NBR0UJCQkweDAw
NWMNCiAjZGVmaW5lIEhWQ0FMTF9TSUdOQUxfRVZFTlQJCQkweDAwNWQNCiAjZGVmaW5lIEhWQ0FM
TF9GTFVTSF9HVUVTVF9QSFlTSUNBTF9BRERSRVNTX1NQQUNFIDB4MDBhZg0KKyNkZWZpbmUgSFZD
QUxMX0ZMVVNIX0dVRVNUX1BIWVNJQ0FMX0FERFJFU1NfTElTVCAweDAwYjANCiANCiAjZGVmaW5l
IEhWX1g2NF9NU1JfVlBfQVNTSVNUX1BBR0VfRU5BQkxFCTB4MDAwMDAwMDENCiAjZGVmaW5lIEhW
X1g2NF9NU1JfVlBfQVNTSVNUX1BBR0VfQUREUkVTU19TSElGVAkxMg0KQEAgLTc1MCw2ICs3NTEs
MjIgQEAgc3RydWN0IGh2X2d1ZXN0X21hcHBpbmdfZmx1c2ggew0KIAl1NjQgZmxhZ3M7DQogfTsN
CiANCisvKiBIdkZsdXNoR3Vlc3RQaHlzaWNhbEFkZHJlc3NMaXN0IGh5cGVyY2FsbCAqLw0KK3Vu
aW9uIGh2X2dwYV9wYWdlX3JhbmdlIHsNCisJdTY0IGFkZHJlc3Nfc3BhY2U7DQorCXN0cnVjdCB7
DQorCQl1NjQgYWRkaXRpb25hbF9wYWdlczoxMTsNCisJCXU2NCBsYXJnZXBhZ2U6MTsNCisJCXU2
NCBiYXNlcGZuOjUyOw0KKwl9IHBhZ2U7DQorfTsNCisNCitzdHJ1Y3QgaHZfZ3Vlc3RfbWFwcGlu
Z19mbHVzaF9saXN0IHsNCisJdTY0IGFkZHJlc3Nfc3BhY2U7DQorCXU2NCBmbGFnczsNCisJdW5p
b24gaHZfZ3BhX3BhZ2VfcmFuZ2UgZ3BhX2xpc3RbXTsNCit9Ow0KKw0KIC8qIEh2Rmx1c2hWaXJ0
dWFsQWRkcmVzc1NwYWNlLCBIdkZsdXNoVmlydHVhbEFkZHJlc3NMaXN0IGh5cGVyY2FsbHMgKi8N
CiBzdHJ1Y3QgaHZfdGxiX2ZsdXNoIHsNCiAJdTY0IGFkZHJlc3Nfc3BhY2U7DQpkaWZmIC0tZ2l0
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNoeXBlcnYuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNt
L21zaHlwZXJ2LmgNCmluZGV4IGYzNzcwNDQ5N2Q4Zi4uZGE2ODU3NDQwNGJmIDEwMDY0NA0KLS0t
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNoeXBlcnYuaA0KKysrIGIvYXJjaC94ODYvaW5jbHVk
ZS9hc20vbXNoeXBlcnYuaA0KQEAgLTIyLDYgKzIyLDggQEAgc3RydWN0IG1zX2h5cGVydl9pbmZv
IHsNCiANCiBleHRlcm4gc3RydWN0IG1zX2h5cGVydl9pbmZvIG1zX2h5cGVydjsNCiANCitzdHJ1
Y3Qga3ZtX3RsYl9yYW5nZTsNCisNCiAvKg0KICAqIEdlbmVyYXRlIHRoZSBndWVzdCBJRC4NCiAg
Ki8NCkBAIC0zNDgsNiArMzUwLDcgQEAgdm9pZCBzZXRfaHZfdHNjY2hhbmdlX2NiKHZvaWQgKCpj
Yikodm9pZCkpOw0KIHZvaWQgY2xlYXJfaHZfdHNjY2hhbmdlX2NiKHZvaWQpOw0KIHZvaWQgaHlw
ZXJ2X3N0b3BfdHNjX2VtdWxhdGlvbih2b2lkKTsNCiBpbnQgaHlwZXJ2X2ZsdXNoX2d1ZXN0X21h
cHBpbmcodTY0IGFzKTsNCitpbnQgaHlwZXJ2X2ZsdXNoX2d1ZXN0X21hcHBpbmdfcmFuZ2UodTY0
IGFzLCBzdHJ1Y3Qga3ZtX3RsYl9yYW5nZSAqcmFuZ2UpOw0KIA0KICNpZmRlZiBDT05GSUdfWDg2
XzY0DQogdm9pZCBodl9hcGljX2luaXQodm9pZCk7DQpAQCAtMzY4LDYgKzM3MSwxMSBAQCBzdGF0
aWMgaW5saW5lIHN0cnVjdCBodl92cF9hc3Npc3RfcGFnZSAqaHZfZ2V0X3ZwX2Fzc2lzdF9wYWdl
KHVuc2lnbmVkIGludCBjcHUpDQogCXJldHVybiBOVUxMOw0KIH0NCiBzdGF0aWMgaW5saW5lIGlu
dCBoeXBlcnZfZmx1c2hfZ3Vlc3RfbWFwcGluZyh1NjQgYXMpIHsgcmV0dXJuIC0xOyB9DQorc3Rh
dGljIGlubGluZSBpbnQgaHlwZXJ2X2ZsdXNoX2d1ZXN0X21hcHBpbmdfcmFuZ2UodTY0IGFzLA0K
KwkJc3RydWN0IGt2bV90bGJfcmFuZ2UgKnJhbmdlKQ0KK3sNCisJcmV0dXJuIC0xOw0KK30NCiAj
ZW5kaWYgLyogQ09ORklHX0hZUEVSViAqLw0KIA0KICNpZmRlZiBDT05GSUdfSFlQRVJWX1RTQ1BB
R0UNCi0tIA0KMi4xNC40DQo=
